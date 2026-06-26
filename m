Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF4211A14
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447328; cv=none; b=fxyS+AbR1GfCpTMRr1E9X/N8o5rEx0JO9I0MyF0T8F98los4QeEwOzQOd7rkC0Knt+50TcZwKp8uBl075wElS86timZm+EaMdRrZfOLWD6i2q90Q5cFKhL7gomi6oSiVcDW2rzleZm4LM2dTm005bm+hoPjFxg7Y1c42tUOKlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447328; c=relaxed/simple;
	bh=G6RmNTqYROpjt9DlcxGQNALg1UdVD4frTSeaFp6axyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8VBZ7hs8WHCM7da/vx7emi6QDPGG8w53GXSQwXZHhGTxyg49tqsGd4Fjsr0FgR7t6k0VUsT6LfB2kTxjKv3SOCXV/73HjMDXxrlJj0vrHJBqfZ0EyFdA6pAGLBFdtonEIPy24Npfmy6XZ8sKBQPMVwkGcebtpEUiIm1LrahHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aXVnmaJp; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aXVnmaJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447283;
	bh=74Ta1GaJ908LAxiP2HjWHTSJKACbI0XFPiM4M/1j+IU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aXVnmaJpYdDzrtgpa+Meb/qn+yopuIL8LSyqQeehmExh8xxT2ekDu17SNoqUAZ95Z
	 JFw1eP4PDN/Zv5ZG1BizxiLiipFtuW+S0fpj+VxXTiBa/2n4cvJWyVGrjBj3+iAoXu
	 k7KjSHoEe2+EtrOGL2urdY8SEj6IrzM7MlO1J6wQ=
X-QQ-mid: zesmtpgz1t1782447276t27ed3663
X-QQ-Originating-IP: u/y1TTTPbmRO/CDtTS7gcXP6aFY6x3T/wYLMFTs9Ekg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6531825540282112445
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.6.y 4/8] eventpoll: kill __ep_remove()
Date: Fri, 26 Jun 2026 12:13:59 +0800
Message-Id: <20260626041403.85968-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OYpbVsTx4C81Ea2BKYHQOdiOi50/eEJiIo+toBzWNKSuwokFxeelDKo/
	obFK0MWvkHTPMWUgz0KhIWA8ijG1MPsCs26vd7bNeMs+8iKWcDAJzEzJ3Uqdn/2qO4INxsP
	ZOs+BkgAudhYdnaPto9o0Bih7LlLYFir0ugVhhNh3bpNV5hGRWUliq0jufR318xIjSIphPp
	IkMhWkVFFnfYz7RjQ/0Mwbud9hsfIBtXCYhkWSfs/bRdTMsdi2VYhXjhvx0GYerHE5xEKIg
	Wong+WoZUAw4QxmTxJopERI1p1hgkLOo05yXc6wXRFVuqBVkW6/bjWFjfiZpN7/6rKW35TC
	dK0gigt7PF9PYOwxdO47IigspIwlQ9pRKQsRBrlGECcADEgEsQyvQ6/zx174z8nDomMB0Jj
	DMeeS3OiUt/m3ngJkkZRIml6Zwj16R7SoROQtGUww2Sj0VOIE8EEo9jJhcQkxddfewoGj8d
	cVdDN3Jkq77T2x7otac7/wb8+wy3tAIDsDm56Kly8Y8enYilhLGZ+bIgyUZuD+aizEb8oGG
	+rPD71oFxv/sIjdD2os4ZoBO3l39H2+mU2iipVy9PvNjjF687m4mqQujCDO16CpLW2wxlw9
	MPqNRlDDhm5XJfFXEbT4vRRKAzL+a8S1NUoFFOjd/+NANZX5MHkh38WkOf+B0BAE2jJmubX
	RjaSMjIK+i1cfihiHHUaAuD4bZDEed/bhjRiNPEZRk2u6VJUDtHqi3FJXKn+pe8Oh3kAa2X
	c6Wh3XGZl595Zm2z+5RhGQb/vu0v6h9Bevuv3Zc199tE/Hqq4wzDgRCvwzekhMK+UzhZcrd
	/kM1RiwBOo7A6h1u0duXE2oOXZvCTxc6Ro9cfTTWzpnoi6+77CRpQsRQ8aNxO9KOLf5xlGl
	JHH1XTePM9VWkZLUuV9eGoPeW4HfBz1VCEP1Hf82B4eFLr3GCJpTj5fANI2ytjIPJFpMRqg
	TkCrdfx6LetOer3mE7Mbrp18p53OgDXAztEHTGFTqmRbhbcOzsg2K3FBEUthdFCeG3rvj7B
	TjBOisR6Nyg41NXsWM+achtjYcARv+iWVu6eUgdBKn2Ew2Ugiy9Z6wtkxMjKSTVqqJF0oVQ
	gYhW/SChg3p
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
---
 fs/eventpoll.c | 67 ++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ae9cb82764482..766716c2fd92a 100644
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

