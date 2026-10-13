Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8C3B14B8;
	Tue, 13 Oct 2026 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886936; cv=none; b=Scqpmyu1xHyXnWZQvbIV+/XD9E27iHQLyrhxHQenNV2L4nUIeENy/BtOgBYjq/YKLaSoc2K771sI91Lxnp7eE/k582KDWFBUCyw0C4olKjpj5kw8Meb/jflxG0oPE+fgp/2tCUJ1A7V/qDKjVkBXWmOTVZxxwBVPiMkzV1MuCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886936; c=relaxed/simple;
	bh=4IheRV/g1BeVK9txqvpMvLVlxJ7VQ+0wAgcECHyQqr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7ucHM/q3JIdD/AMttUVtdFFadGjABEwqOZ46iLExV/AWtmDxzjM9iUwXsRNixVBhW2ZlcoRrkvLH5ijrHxghVvVY+ou8R/6XsqNJzbNQex41iOstFYTuoVfAa6E93vfmXEHdaBZhK2cGKQg2DTVL4+65eXziDOA2bPfMybg4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=blnMl6h8; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="blnMl6h8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791886881;
	bh=8RVUfeR7mIgD85Pbh654nwMJAFiX2/jUOjG5ftwkHTg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=blnMl6h8G1aDHdRjdrXWSuGz3a4RwcFGBznm5NZbaBWm099HH9AGRfRm9IfGv+EU3
	 FnTNmebORX9TKqCGMjIrhJ3MR8JkOewmWmPIGEVvB6h1SwqqFvIr/AFD3RyAJEE6Jf
	 MRfViGeMFeNAWbwA3u66n/FVeGkr3dbWjO/ectv4=
X-QQ-mid: zesmtpip4t1791886862tef5bdd87
X-QQ-Originating-IP: tSB673uuTDan7DaUsciucL3UtgYdJpw9S67DOpXjOyE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 18:21:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4667132018720575612
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v3 6.6.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Tue, 13 Oct 2026 18:20:39 +0800
Message-Id: <20261013102041.2113948-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N29Tq5wqrLTlqZtmzgVbS2+MylF323eqjbzYeBAlzwEqsxsprc1Xej7F
	qEmQA5BzUcQtVUaeDLirDGNK24FN1KREvzYJ5rV4Pce53lAgJbMwmH1TkyZpFE1wY1bXn6p
	sMDLjt8cS28LKlXfLteorG18IhTWYQWWQ3MKyCKDaGgNzB6zAfX1Hl01UPTX2gqSYiL++IB
	wmMWuAJTysWpkQHrin1a2LLPlMq7HeDKHkqGscPJF/dcLR4B3o+R6UfvxI3M59Rl3PsxiHH
	QPVbi0uWL80a8LM6BBRxlFK8Ojmv4r5bYMpLTK5tHacWzGyyPoSjAoGBoq4FidpY8NZ/UqA
	XFVEqdi8dwd3j1/6IOkroCe+WxALVX0uNIxfvlrKZhh11ruKjk8pRQBfByVUW+XHXQxFL/q
	8cY8d0fh/8dLjRhZ4c9348iNC6xN7eD2ou7qZmHOEDmODDMM1PsA/YWlyzuLFZFwVdcGSgo
	zFyYbiHbuxf3HIVtcMPwXAHXxCyPyNTIRAh09IPnL6O+MS/htcUVd5/zut3wR0h1WhUHTnl
	Zl7OjpJVA3O/ABvw7iOwu9ZgtyjeI6k4i8/t/JTSU926qC07Fgqx1ZqLOv4v3EKJ7aOUSjr
	TP67CjoANsm6XD8U6v1Q1A1WBq5L5HorT2HO5egiqtfAhbXJs5NzIzhcAJvhk01beUrTFgS
	LgJFzCpBa+3saTK+xHu/2+qkSxzdY1P+2sDUb3qtojcqVPp64TBmFfagzjZKuhbiVS/WqcT
	ItOsRqIuEpKIst5BEfoLbcPosdNMD8DZl8g+fsLYoAP5jIIOhGNoysrX43yMgkxyj1JHmsp
	dtqkI3yZV6gYN7Am8zChFxts8EdIoU6ZfAFWRXi3F9nLlqwHRPIKhIsLTf4Y92B101taF/D
	uLCYg4539aBdbKNygf/nHT8JQCfjmVVN5t1kiFvFyqKSqkE5EsNg9oXw5g6j7XQKsLGgMXN
	I7wSnaTiBvzsJyrRn18JXcMY8KiyNbYI1gzDe7999Ak9fjJAD+MfY4x1R29ySDWeJtBaJVD
	kQf0LyGBk2pteD6HBLpeZblqIevqLvtSvetSqntW4bqaPBHvxxhYsPXpK4if6yig1exqMs4
	YAVZEbaeeLouuK31AMq4QS8pVlNgOaHI8BMMOyiBIDK1RIURdw2D0OFTn/YCejrFT/v31ep
	gEfMtl0e6knSQ+sPUneaKm5UcT5xIIqm84/9
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This error path returns while both wiphy_lock() and wdev_lock() are still
held, so one malformed IE request can permanently block later operations
on this wiphy. Route the error through out to release both locks.

This bug is stable-specific: it was introduced by the stable backport
commit d01f1600e8b0 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()") of upstream
commit a2f5286ca4f3 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()").  Upstream is safe because that function
runs under guard(wiphy)(), added by
commit f42d22d3f7963 ("wifi: cfg80211: define and use wiphy guard"),
while this tree still uses explicit locking and the separate wdev
mutex that upstream removed in
commit 076fc8775dafe ("wifi: cfg80211: remove wdev mutex").  Backporting
those locking reworks is not appropriate as a minimal stable fix.

This is a fix for stable v6.6.158 backport commit, so no upstream commit.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: d01f1600e8b0 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v3:
update message as greg suggested.
changelog v2:
add reported by.
---
---
 net/wireless/wext-sme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index cfa903eb0e82f..0e7c314bdeef0 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -354,8 +354,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 			/* nothing */
 		}
 
-		if (!for_each_element_completed(elem, extra, ie_len))
-			return -EINVAL;
+		if (!for_each_element_completed(elem, extra, ie_len)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
 		if (!ie) {
-- 
2.39.5

