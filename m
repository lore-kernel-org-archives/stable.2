Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249823CA4A0;
	Tue, 29 Sep 2026 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654252; cv=none; b=cJwG+1xV5gvUWErL8YWvlowMuX/h6/bT8BV7LJE3BmE9b9dAHGECdTFhCAy2DtYqlAKQw+yRrJXuDhCmFbqwDKOBzU+1tHXYcNc3cvMaVk/mZ5/WufpmngCmOHY9qIy+Z11dZg+W7noHYK/sQfo/cfppikJjCOYJtEbflllzhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654252; c=relaxed/simple;
	bh=yfByeOMZtpbUNuuFkWDTJ8P5sGTXNwZSFa75tHTOAFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ll11GrAZJKtjt77/rR0N8GSA0fABdqMtNtXy2b87s+6vKLQ/7f4fGOJtPeiFO7USsa+4/JojKSkhKFwGsS0FpV4KjOhhBIWfqTxjayEcgn3XTfaDTGzVrRajhsplmeF4N2Eo27yWjfhxUoowJ+rv5PUzLQOmv0w6CuhAIpBQitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lVVOLZMT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lVVOLZMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qW
	9qfPoo8fYX/EwwTC0Q4IvfBmGgQcmIU1Bg5KLbhlQ=; b=lVVOLZMTsb1q1fBxaQ
	JUaTcdoLPGtZbKnuz/tRdhdW9s3PG3rMbZq4TXXJ8Cx4cYqM0ci7FHZAmRyv5GNj
	F03WnAg/h2skN3OnneMtx6oREcsS7jpqgF2eHmp6KrPXV59UCwllsehAqrS9AfIQ
	O6kJmOrYhrqed3cCHCo5XyIcs=
Received: from SH-NB-0474.wuqi-tech.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3X7URN7tqaY62BQ--.10925S2;
	Tue, 29 Sep 2026 11:57:12 +0800 (CST)
From: Huang Xiangping <huangxiangping88@163.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Huang Xiangping <huangxiangping88@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: process pending events before connect/disconnect requests
Date: Tue, 29 Sep 2026 11:56:49 +0800
Message-ID: <20260929035649.33538-1-huangxiangping88@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7URN7tqaY62BQ--.10925S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4fCFyxKry5tr1kAF43ZFb_yoW5Ar43pF
	y0gFZ3Kwn8Gr13Gwn3AF10gF95Zw4kJa15ZryqgFyYyas0gr18tr4kKF15Ar13Gr93Aa4U
	Zr40qanrGFyDua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEO6psUUUUU=
X-CM-SenderInfo: xkxd0wx0ld0wpslqwmqy6rljoofrz/xtbC+BhdB2q7NxinewAA3Y

cfg80211 reports connect results and disconnects through wdev->event_list,
processed asynchronously by cfg80211_event_work(). The state that
cfg80211_connect() and cfg80211_disconnect() reason about can therefore
lag behind what the driver has already reported.

cfg80211_disconnect() relies on that asynchronous processing on purpose:
when the interface is connected it leaves wdev->u.client.ssid_len alone,
expecting __cfg80211_disconnected() to clear it later:

	if (!wdev->connected)
		wdev->u.client.ssid_len = 0;

If userspace reconnects before that deferred clear has run,
cfg80211_connect() installs the new SSID and the queued EVENT_DISCONNECTED
then wipes it again, together with wdev->connected, wdev->connect_keys and
wdev->conn_owner_nlportid.

The connection result of the new connection is subsequently processed with
ssid_len == 0, so the BSS lookup in __cfg80211_connect_result() cannot
match any BSS and WARN_ON(bss_not_found) triggers, dropping the connection
result and leaving userspace waiting for a connection that is never
reported. The same happens in cfg80211_roamed(). The zero ssid_len
additionally defeats the -EALREADY and connection-owner checks of the
following request, as both are skipped when ssid_len is zero.

Fix this by draining the pending events before the connect and disconnect
handlers inspect the interface state. Both run under the wiphy mutex,
which cfg80211_process_rdev_events() requires, so no new lock ordering is
introduced; this mirrors what cfg80211_change_iface() already does.

Fixes: 51e13359cd5e ("cfg80211: fix connect/disconnect edge cases")
Cc: stable@vger.kernel.org
Signed-off-by: Huang Xiangping <huangxiangping88@163.com>
---
 net/wireless/sme.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 2a719b5c487e..e887c30567ec 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1445,6 +1445,13 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
+	/*
+	 * Pending events may still change the state we're about to reason
+	 * about (e.g. a deferred disconnect clearing ssid_len), so process
+	 * them before looking at it.
+	 */
+	cfg80211_process_rdev_events(rdev);
+
 	/*
 	 * If we have an ssid_len, we're trying to connect or are
 	 * already connected, so reject a new SSID unless it's the
@@ -1551,6 +1558,13 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 
 	lockdep_assert_wiphy(wdev->wiphy);
 
+	/*
+	 * Pending events may still change the state we're about to reason
+	 * about (e.g. a deferred disconnect clearing ssid_len), so process
+	 * them before looking at it.
+	 */
+	cfg80211_process_rdev_events(rdev);
+
 	kfree_sensitive(wdev->connect_keys);
 	wdev->connect_keys = NULL;
 
-- 
2.53.0

