Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1177404E
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691654; cv=none; b=dEOEmuNhvgb3hxnlSnmMCxtrEML8sOJ1Clq+aFgxvJwZr7weOst4CXltZmB4fCBwARRkVbZ8z9juF8KHScvskLvXV913Qb4aidfwJj2tpIfRLATWPq6zGQ4MrlleT13jZVNLBpo6JML6Axa7ZOaC5YMiaauM3kJnUTrOs34JO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691654; c=relaxed/simple;
	bh=dW38mPZGM0aa6eb8Y8JTvlZxk1ycs1N9OR1dooHCpkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0OcPbL4EW4Q9lS23LKS4m2YJYBnX7LVatHmm3qvnwEbvHYzvQw04Pz0iGrz4fARunWT8t8Ll9/l9KRnqQk1Qx8T8MztHbbCDeB9MS3dJy5Qdp1b6RNX+Avq6Syzm2oeHlAfHU+9lsmNp8eDmt2WJmORMiKmIM7vpdQI+SuKK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1e33K1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1e33K1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D451F00893;
	Fri,  5 Jun 2026 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691653;
	bh=ZwPOXLWzBlKiUeWwGRvwR9mOyaYxpy4svJBvgJT4af4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i1e33K1Iju4o4+NlXC29MUAQ4+Rexxox9+j8OQNTkRGX745kQ4dITF5c9lcldqy4L
	 5pXDmXXT6Cwlp405GsoF2kXVRPXx/avjtXd+wpowhwoQESbdqvTOXW6EQOGkk4ev3e
	 YDUsnE2JP46OlmeaTz1w2Af1YBgbHbjBxyXn4afrtrwLOwr9Ml2/T5pPamHZN2ZReA
	 /iCZWq20NuhXaVlxPd88GT6ofMxD01hthA69TqqU4Do4HJfh5g6EGDQBtyrluM07u4
	 qAnegzwXQOq79u3ZN1mA2R3bn/NgDRkZHFC23tssBM/lwYt0ny9e5cjrnbMGPM3eNd
	 JfKz3tQ8B9SgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: ucsi: Check if power role change actually happened before handling
Date: Fri,  5 Jun 2026 16:34:10 -0400
Message-ID: <20260605203410.2224712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060418-snap-vividness-fa03@gregkh>
References: <2026060418-snap-vividness-fa03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

[ Upstream commit b80e7d34c7ea6a564525119d6138fbb577a23dba ]

The CrOS EC may send a connector status change event with the power
direction changed flag set even if the power direction hasn't actually
changed after initiating a SET_PDR command internally [1]. In practice
this happens on every system suspend due to other changes performed by
the EC [2][3][4], causing suspend to fail.

Fix this by checking if the power role change actually happened before
handling it.

[1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794

Cc: stable <stable@kernel.org>
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 05a2909e84fd59..34b6965ee30b59 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -669,7 +669,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	struct ucsi *ucsi = con->ucsi;
 	struct ucsi_connector_status pre_ack_status;
 	struct ucsi_connector_status post_ack_status;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	enum usb_role u_role = USB_ROLE_NONE;
 	u16 inferred_changes;
 	u16 changed_flags;
@@ -706,6 +706,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	 * short transitional changes.
 	 */
 
+	prev_role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
+
 	/* 1. First UCSI_GET_CONNECTOR_STATUS */
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 	ret = ucsi_send_command(ucsi, command, &pre_ack_status,
@@ -783,7 +785,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		ucsi_port_psy_changed(con);
 	}
 
-	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) &&
+	    role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 
 		/* Complete pending power role swap */
-- 
2.53.0

