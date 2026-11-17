Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794875668;
	b=EizQ2D8ptotppCcCBRk/ng26I4wNH2Uu2XNN6uMD3P9wkjLLvK75X/pwdTTX2kzLLeTy
	 A2enVzF+cfK0w+7Gmtycf8nvgA/tJ8hxxvn30M1RVIQp2kgRl6QWF6AMZFYHpJDPiiQFt
	 j/1zWGXfT48zqppYuGF35LRjg7UupNGfrxdx8uKiApd1gndErYVzpk392ryexJD5xhgGg
	 RXjjcLUcD8JXracVh/YREY1We3GBRyepVmvNX60KC3BSRIO/Js1zgxCZR4q7cXNU9ycXH
	 eNZQj6zQ24ju0SmQ8P0LyzuvzdubAdC6qFRm0C8DMhAZI6wNrkRHc9cHeSKQWzXDosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794875668;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zOWSa27u3Ave0V9vTT3pFsTcgdu8IRVtcAyDkVZ91z8=;
	b=FynlSz8s52kP+S69hcRyeskTn821eKDCV67xjz5kZU9qH+7b4lSz//sSVKpmTQ8iNCt1
	 sFG0uyMEs26KlOTwGxHLTWqAOgd0U7aVpTEWT6OLwkO4oFRHNB0c8YTzWvXp7s7oc7ZZ5
	 h8TaQXL7ui8lT/cEPqN7kSiKJYkkwwzmdmRVjWhfBS0Rof4g2YjI3XBKSw2+p+mfWiE+A
	 d2wVEpGXlXhnlX0TndogduzSIAgVBTPjqCx5NB1Vq/peWqy5u/TYpbK0N586gng1Jw8yE
	 3rDo8SDbZn2wL0UevzK9BiUXaOhhUaRjsDO17O5gUxoMp57xOKOUTzKPEo7Z5Wqbuzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=justthetip.ca;
	spf=pass smtp.mailfrom=justthetip.ca;
	dkim=pass header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=Ot4oqxy3;
	arc=none smtp.remote-ip=95.215.58.51
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9D606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F9D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=Ot4oqxy3
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yvvOOXaMMgB1nSlfT2xaMn+eYtcmhlEfU9FHzAzuR3E=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794875665; v=1; x=1795480465;
 b=Ot4oqxy3U3AK6oPbJVVqi5gnOh/xIuw6x23rbLp5RjGURpfcmIEw0c7hlJVYaUquOv1+61fe
 prX8S1gnX+IKlM06brMGbFcVhRnOx/JELdEBxTFsRw/LeJM53AnxBM8ddwQJSxBUQuwNYNgWSHp
 FsJ8o6eWiljsMFBNrz50c2vAY+nE7cxmuCy4y6XXga+Zfh2Mh5KzFYLLl2xbMZeGXSfgsjlEvoG
 27jKQ4KWrBUjRfK9rvAx9A0ersSCrrtBMeEqFgeyhkZzCFVkd35hcOnfv+hwIhBmLSCFAwGOIGA
 JW70B1Rv8SIzu0uy1io2hNbq5Wl4HXont6tpwVaGIImNg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eece0ddd6e15d8e7;
	Tue, 17 Nov 2026 00:34:25 +0000
X-Mizu-Trace-ID: eece0ddd6e15d8e7
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ilan Peer <ilan.peer@intel.com>,
	Martin Moosbauer <martinmoosbauer@vivaldi.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: cfg80211: keep the user's setting when another hint times out
Date: Mon, 16 Nov 2026 17:34:16 -0700
Message-ID: <20261117003416.22375-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Connecting to an AP that advertises a country regulatory.db doesn't
have, like the "EU" some Vodafone routers send, makes cfg80211 ask
CRDA. Nothing answers, and the timeout restores the world domain and
forgets the country the user set.

Forgetting it made sense when only user requests had a timeout. Do it
only when the request that went unanswered came from the user.

Fixes: eeca9fce1d71 ("cfg80211: Schedule timeout for all CRDA calls")
Reported-by: Martin Moosbauer <martinmoosbauer@vivaldi.net>
Link: https://lore.kernel.org/linux-wireless/8db36875c56cd9703dee42c7a00b81c9@vivaldi.net/
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
Connecting to an AP whose beacons carry Country "EU", with a user
country set:

  kernel                       card          without          with
  7.4-rc1, wireless/main       MT7612, USB   world, US lost   back <1 s
  7.3.4 (Fedora)               MT7927, PCIe  world, CA lost   back <1 s
  6.18.63 (Arch)               MT7612, USB   world, US lost   back <1 s
  6.18.52 (Arch)               MT7925, USB   world, US lost   back <1 s
  6.12 6.6 6.1 5.15 5.10 Arch  MT7612, USB   world, US lost   back <1 s

On stock, a 5 GHz AP running at the time is shut down a minute later.
With the change it stays up, and a transfer running across the reset
keeps its rate. A CA element still applies, and the user's own
unanswered request still resets everything. With no regulatory.db at
all, CRDA is asked as often as before.

This replaces [1], which tied the two lookups together. Below 7.4 the
timeout takes the RTNL instead, and that version is what ran on 7.3
and older above.

[1] https://lore.kernel.org/all/20261116060723.37130-1-lucid_duck@justthetip.ca/

 net/wireless/reg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5cd3880ee384..1dde03ce16a5 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -526,10 +526,14 @@ static DECLARE_DELAYED_WORK(crda_timeout, crda_timeout_work);
 
 static void crda_timeout_work(struct work_struct *work)
 {
+	struct regulatory_request *lr;
+
 	pr_debug("Timeout while waiting for CRDA to reply, restoring regulatory settings\n");
 	mutex_lock(&cfg80211_mutex);
 	reg_crda_timeouts++;
-	restore_regulatory_settings(true, false);
+	lr = get_last_request();
+	restore_regulatory_settings(lr->initiator == NL80211_REGDOM_SET_BY_USER,
+				    false);
 	mutex_unlock(&cfg80211_mutex);
 }
 

base-commit: 763b13f622e2758726e8e3ecaef819db8fa0430a
-- 
2.56.1

