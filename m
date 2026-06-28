Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226BF507
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663746; cv=none; b=kTsqzxdKdig5CmVIGdgvxbEinWNAeKF7Fc8AM+29C58l+hitXYC30q5m9odgL6WX2L4sVqsOPSWheRkoaVPvCg/1+UJDoRMkszn4V3kFiL8tJH7VRFFYCoDftFe/S5SwV64OAF02hWXV83b5peqAdm+ZX20lNIwVPq9L6pM1Z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663746; c=relaxed/simple;
	bh=FO9GkVUDtCxFV8IW/cGpoOetTtF6fpr5GW491/2Pyrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFWBrBElJTwQSIn35R2aoDQfj9edxlCcLrLyJeh8j01+W1yv1syrIRGPx7n5JKjq8SxM/oVEWTYmwx5XxlVzz0LKxyH2TtAWooEXEwyT1F6bPM4BNfESR69lxGMv5yHrE7dg0nMIShAYX2B4CGs36tXhycBUnSuvedK6+4LM9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Kp7m2F67; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Kp7m2F67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663632;
	bh=2EM8jZdr4Kunx1tgcP3JKKGJZnSpkQnqhmgSRSmuD18=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Kp7m2F678qcZhE1Hj6M2s9ylgvv6mEPXXiFxxFq6Zj+Lb0IzqC18pfFNK4+aX0obL
	 i4jX2+z9nadia4G04xtEcsxz/O9t98Mm1ivD+oLDJIorS5RdzO4Mk/bjnTuzLKWtC5
	 btjR9F0/gFZT7xd5y3cUIveHOtTzOaF0/avukzBc=
X-QQ-mid: esmtpgz10t1782663627t35de7896
X-QQ-Originating-IP: +FJQ5gVEDdunh8y0+r5XQ+DEfUppoJy+bQRkeeyvlcQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13513584146525467139
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.1.y 5/9] eventpoll: kill __ep_remove()
Date: Mon, 29 Jun 2026 00:19:35 +0800
Message-Id: <20260628161933.532572-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <akEtsUNOcuws0xPC@eldamar.lan>
References: <akEtsUNOcuws0xPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MO2SytlNpkNqIgV019Rw7R9rDUTBBKJNnsp+sLXRGALfPmj3RZvqVUe6
	O0cqKy1EhOQHSOvT6GZqoHZwUj0y+JWtNOBUD6g+NCYNOelAHzSMGrlJH5RFU1LX4UJN3eg
	t07Dt4RIzBuyKMvHDtj18KCAK10h/uYcq+JR6gKsmoiOU93bVgpsMg0N1tYz42c6xjnG+jX
	DECDpKGY0SjCZwDNwe65TIwIqHb7xbBnRQYZ6F07KSkABfEiit6S0XV/Jo7fMBwB9uNlgKf
	BNJnGunvdQIQ+luFPCYAepBkg6Gtp5LahxpJvVTWOxVaUUrOrm5BcEx/6obrIPypSW1ZP+7
	CzBizvsJwVvykScOr63szc3wj9xModDhScdNGmccx26UeetxjXQkOqlFzbbPNPc6uRpU88L
	wrjzmIgV9DV0QMyjKLu/HIQ7tiQTcBdgk4DMRgLZpr2FeZY82MSdPw3u0GhgUwPzZ2D+LNf
	pKPVNa7+/DgwVU8pwXMjeGB2mN/AZ/tyEeKHlChJiXcrjugV/9Bf6C1+J9uMVYvSSO5xj1Q
	ehimEcXP0lfP2F9jPk8rhKqNJQV57j/SMUnd1j7DP2GhzX9wQPRnkb8tNCDJ63gFVZY8YFL
	nNh3jcU2f5DU8Hc+bIUIuZE+KrbDUuITS12V7gLyArvxdjha7q7lgCn/Vk0kZkRUjNMfrzA
	Ir/TocP7iqZUx5OCLb+o3STrLi9uE7OYnMQHkeDGczNRDivZPj7/S6ccyS6RnFT/HiRMM+r
	ZtYrx/icWUdiZRO/z40Gclvj/FIfAlrOocQX5yol1HkTls3RSdEp7NeWf/IAgjwqwhJBX3b
	us1uldlyl2zJiv7WDNwUeMHMcMKpMBWC0Axn54peNyC6sDqraKdKU4P+g88IG1xldp5jzIC
	r+Z+jS4Lsz0lkdj3TQqLqrY4MqJEqW96cRNPyfDw/h+SgufC5NQX6c4IsVHQcRdHASE67Oz
	yJWgitHGNyyyzIWTxOc/tT7JUOJkjJm28xSBl/TCVC4vQwU009k++s5EpTQSSm1OwChX4me
	rHHkdHLqS+yfKD52qk6ab5kvh58IzT46NAqufDuunAGLnJCovh0/AIyLZTXWuyuWp/qdK5J
	/5UHxUdow1a1vYKtI0VraUXevxfDICX3EL79dFpVveI1auBCyHpPDeZmvCuGDGTHg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e9e5cd40d7c403e19f21d0f7b8b8ba3a76b58330 ]

Remove the boolean conditional in __ep_remove() and restructure the code
so the check for racing with eventpoll_release_file() are only done in
the ep_remove_safe() path where they belong.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-3-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 67 ++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9e728b359ea3d..93251a4858ed7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -715,49 +715,18 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
-
-/*
- * Removes a "struct epitem" from the eventpoll RB tree and deallocates
- * all the associated resources. Must be called with "mtx" held.
- * If the dying flag is set, do the removal only if force is true.
- * This prevents ep_clear_and_put() from dropping all the ep references
- * while running concurrently with eventpoll_release_file().
- * Returns true if the eventpoll can be disposed.
- */
-static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
-{
-	struct file *file = epi->ffd.file;
-
-	lockdep_assert_irqs_enabled();
-
-	/*
-	 * Removes poll wait queue hooks.
-	 */
-	ep_unregister_pollwait(ep, epi);
-
-	/* Remove the current item from the list of epoll hooks */
-	spin_lock(&file->f_lock);
-	if (epi->dying && !force) {
-		spin_unlock(&file->f_lock);
-		return false;
-	}
-
-	__ep_remove_file(ep, epi, file);
-	return __ep_remove_epi(ep, epi);
-}
-
 /*
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
 	struct hlist_head *head = file->f_ep;
 
 	lockdep_assert_held(&ep->mtx);
+	lockdep_assert_held(&file->f_lock);
 
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
@@ -804,7 +773,25 @@ static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
  */
 static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 {
-	if (__ep_remove(ep, epi, false))
+	struct file *file = epi->ffd.file;
+
+	lockdep_assert_irqs_enabled();
+	lockdep_assert_held(&ep->mtx);
+
+	ep_unregister_pollwait(ep, epi);
+
+	/* sync with eventpoll_release_file() */
+	if (unlikely(READ_ONCE(epi->dying)))
+		return;
+
+	spin_lock(&file->f_lock);
+	if (epi->dying) {
+		spin_unlock(&file->f_lock);
+		return;
+	}
+	__ep_remove_file(ep, epi, file);
+
+	if (__ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1013,7 +1000,7 @@ void eventpoll_release_file(struct file *file)
 	spin_lock(&file->f_lock);
 	if (file->f_ep && file->f_ep->first) {
 		epi = hlist_entry(file->f_ep->first, struct epitem, fllink);
-		epi->dying = true;
+		WRITE_ONCE(epi->dying, true);
 		spin_unlock(&file->f_lock);
 
 		/*
@@ -1022,7 +1009,13 @@ void eventpoll_release_file(struct file *file)
 		 */
 		ep = epi->ep;
 		mutex_lock(&ep->mtx);
-		dispose = __ep_remove(ep, epi, true);
+
+		ep_unregister_pollwait(ep, epi);
+
+		spin_lock(&file->f_lock);
+		__ep_remove_file(ep, epi, file);
+		dispose = __ep_remove_epi(ep, epi);
+
 		mutex_unlock(&ep->mtx);
 
 		if (dispose && ep_refcount_dec_and_test(ep))
-- 
2.30.2

