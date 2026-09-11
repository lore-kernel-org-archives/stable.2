Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858C2D1913
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133761; cv=none; b=lq1aH7oRjNF3ziVVcOW+2NRjkSZfL5Iu/VU0dRSCUMA8l25vxA2kFSjDujDZmhonv6BBcRqtld+jPsX4rjRCU1X1j83wa8R4e2iutc4XqM9lAseeGFXdH/vC23PqoPmdm6cYSrjSpaHr3uUlSxqc0Ip2l5G5UgMQnqVA6ZxX7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133761; c=relaxed/simple;
	bh=l/bCVGSspL02YXJ/yAB5JeMTyAVEFU1oMpY90Had7ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJwuPo8mzZarMLItHNskyrB9rjTsxQsYc0RHraV0o9Ffe8c3So7A7rhwiuli3dpXfhN6LrN+FxhMKE1Jq+oxIQXKhN4E4/pESJA/M8JyoGncKqOvC+yNP/Uab1to8tc9UDbXHzR4w2TrKeeq577YRIJVtx6IIYdnpl32iG4J8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=p74ZxXTI; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="p74ZxXTI"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1789133747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/bgLyaoJzXUKGE5hQTyHuqNL2qur/PgtwXtaYxDoOp4=;
	b=p74ZxXTIaPYFLJvHO4kSym/M9jRPr/3fIC4vOz32kmQP0ULCG6yXy5L9qi/ujfGGoY9jcZ
	oVdhL6NVkwQcsbhIQTCRt9UsPN5WgwFVeaTZH4xQHagNm9EcuVAvn5MydOw7xCUoXl9nRS
	GJRoeq9GFlEx308yjgLR8jgJvi5MGXc=
To: lvc-patches@linuxtesting.org
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.10/6.1] usb: typec: tcpm: bound altmode_desc[] per iteration in svdm_consume_modes()
Date: Fri, 11 Sep 2026 16:35:44 +0300
Message-ID: <20260911133546.111411-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 3389c149c68c3fea61910ad5d34f7bf3bff44e32 upstream.

svdm_consume_modes() checks pmdata->altmodes against the array size once
before the loop over the count, but forgot to check the bound at every
point in the loop.

In the well-behaved SVDM discovery flow this is harmless because each of
at most SVID_DISCOVERY_MAX SVIDs contributes at most MODE_DISCOVERY_MAX
modes, exactly filling altmode_desc[ALTMODE_DISCOVERY_MAX].  But the
CMDT_RSP_ACK handler in tcpm_pd_svdm() does not correlate an incoming
ACK with any request the port actually sent.  Once port->partner is set,
an unsolicited Discover Modes ACK is consumed unconditionally.  A broken
or malicious port partner can therefore drive altmodes to
ALTMODE_DISCOVERY_MAX - 1 via the normal flow, and then send one extra
Discover Modes ACK with seven VDOs.  Because the pre-loop check passes,
the loop could then writes up to five entries past altmode_desc[].  For
mode_data_prime the next field in struct tcpm_port is the
partner_altmode[] pointer array, which then receives partner-chosen
SVID/VDO bytes.

Move the bound check inside the loop so the array can never be indexed
past ALTMODE_DISCOVERY_MAX regardless of how many VDOs the partner
supplies or how the function was reached.

Assisted-by: gkh_clanker_t1000
Cc: Badhri Jagan Sridharan <badhri@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/2026051351-reshuffle-skillful-90af@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Denis Arefev: adapted for 5.10/6.1: tcpm has no SOP' support here,
svdm_consume_modes() takes no rx_sop_type argument and has a single
pre-loop bound check instead of the two in the SOP/SOP' switch;
drop that one check and add the per-iteration bound check]
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2026-63962
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-63962
---
 drivers/usb/typec/tcpm/tcpm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6969db16f07c..c3fac41eb387 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1541,17 +1541,16 @@ static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt)
 	struct typec_altmode_desc *paltmode;
 	int i;
 
-	if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
-		/* Already logged in svdm_consume_svids() */
-		return;
-	}
-
 	if (pmdata->svid_index < 0 || pmdata->svid_index >= pmdata->nsvids) {
 		tcpm_log(port, "Invalid SVID index %d", pmdata->svid_index);
 		return;
 	}
 
 	for (i = 1; i < cnt; i++) {
+		if (pmdata->altmodes >= ALTMODE_DISCOVERY_MAX) {
+			/* Already logged in svdm_consume_svids() */
+			return;
+		}
 		paltmode = &pmdata->altmode_desc[pmdata->altmodes];
 		memset(paltmode, 0, sizeof(*paltmode));
 
-- 
2.43.0

