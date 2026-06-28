Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12FBE63
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663741; cv=none; b=YBuBY6bgKcoEEYKRrni65OZp0VheGNB8Ip3pQCA0lbMgCEwq0IpC5fHpb1w+fbkYeoHciceQrV1pv8tkvOCnbvOcaULZdEtRqPsiYcI+3/RP38Ki6h+CnYJpQjn3ko3IpdnEp7t4ejN7/bqZ5QGPvS0lKe+1Ig1NM4qtFQIcnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663741; c=relaxed/simple;
	bh=SyO52oEdfQxgiRa+CHW5k7K2oKaIRSygP3XK/Gxcw2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXiz0gvjv/wiyQjEpm4BAe816bTBcEKhY27JhJAH6R4dKYNEOTbm9bGri3ceBdjCCtxevRhGucLW5QZg11sgkLKyr/B5MT9zwch3tezSrsqVOHJq2qW/+tmHPBg9CuTCP2BQ2zbrB4J0Y/+zK1VkoreEe0B61bUQ+7tNhnGJV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BUAnSBVH; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BUAnSBVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663616;
	bh=YwOpjHlkjEKGh3HVY41PKAPNuBw7M9OFBiqUuoBEI9s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BUAnSBVHD1TduDHMD5BwQDkNtmUrq4kc9JocRboGMnGOdXiHo5KwRxK7ZyiLkWcyF
	 8vaPnv/VLIMDcOezHAMwmaGk1iYcHwwry2D0wp1yrX2ULZ1XCs9bmJgAoHuJ/1/DkD
	 thf6bc6dXsxg766imDI37KgegoXn8wYu1kBv7k1A=
X-QQ-mid: esmtpgz10t1782663591t2d475ce5
X-QQ-Originating-IP: 8g9jK+n5HdNhPKDlb8Wcpcr5yHFhW8v8IBR+W+u/7CQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:19:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17640922023262748992
EX-QQ-RecipientCnt: 12
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.1.y 1/9] eventpoll: don't decrement ep refcount while still holding the ep mutex
Date: Mon, 29 Jun 2026 00:19:27 +0800
Message-Id: <20260628161933.532572-2-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MjQ00mYXMHtuRQZDozm0ze1ybe2xRBSrNqt4vU8X+tlScuYUEOW3e1kJ
	IawMlPrOTKI/hYa7MmhT2vYPgBRMLPAp05dLbEh1EZRcKIiBGMfaNKgV3wYM7hfuLu8m9DR
	TAd/wTapOcmHf25fFUrKygxzjZDXafG7w87ZFMF9Udgu4zOsjrAynBYiOwH5fY5DRBCQFZ0
	crtAblTOUFHoM4gk7R1OWHM/tCGaoSIQ94iT6h4DKjB3tQIllRotp+2rN0fs4XM9ENsOYyd
	dH3fl1XbpMu1sSDqaRZn7kivAYQ+sPiJr7NKe1z7HsbYsAtd0AQwfdzBJm0F7hQ4VwvoC7q
	+PqlVhrQoqRZDq76xCOZ6P/E61fcUkQHLIu9gYRYWV+bbtHg9dWLKevIUGkrzVIgZo9E3+b
	lTIxCbZ1glZjr9ZB0s4buSudvUFLzo/Ml7dbTz+Y68kezeqAEuuGC2c3G5XR9W/gKFFgvT9
	OCbsVjhTTmOkh9n1mfVEuj9vHZwRjcZY3iJlu6lDOw3vSsa09Z4YLO3ZrNWr6kECl/szz8L
	ymBar9+8f4l01oPTES6rfueuycbgTeSvBQKZrKFCAn8Wzf0VfcZJYD9kS+RrxovfRkaMBxs
	RACv3dbdRY5h24HlS0h67QVKyMDiSXbrL0C1TXNBVPN9zEcRCezp5qGY0rup/jjJTVYE2CD
	Wk6e55dPuK0g1sYcD24Df3U1ZPBK/MExlrhbzXAEJ6SNU9Ja71baY8l/nBSF8BZKpsrXeBt
	K7VCCfzWqXx1Sz3f0zCei/f9Ss4jNzuPtXFc7zzP3UUL35uEULeO3QSpk6mi+0LZ8P8hL0e
	mo36ppPMU/vJvOueE4yNVwCWiwk9u0OJNc44fg2SBCTyu/Y8LU0+h9wXSshoIq5/7rjtt7c
	Bwrs/qkqMxx4ThxBTlcXr2XgvsYcbToFnvPI3TjPtcHyFbR561jXkNOQ5Cfn9vhhifA6slh
	kSOGwIJSgLKebCQMpOyng+73lDdOm5SxWvNWHFnpYhgZ/5B1EtpJpBrv0UKKPHIRPoYCkb7
	ifLE6F5/oPI+8zRg6kB7QHNuZPbqq1jok7mvAIuL7a+swZOs/8zrcsPYSd1vjpM7Lbpa7+9
	2hbMp0GPOZ8KFcKyCembmY=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2 upstream.

Jann Horn points out that epoll is decrementing the ep refcount and then
doing a

    mutex_unlock(&ep->mtx);

afterwards. That's very wrong, because it can lead to a use-after-free.

That pattern is actually fine for the very last reference, because the
code in question will delay the actual call to "ep_free(ep)" until after
it has unlocked the mutex.

But it's wrong for the much subtler "next to last" case when somebody
*else* may also be dropping their reference and free the ep while we're
still using the mutex.

Note that this is true even if that other user is also using the same ep
mutex: mutexes, unlike spinlocks, can not be used for object ownership,
even if they guarantee mutual exclusion.

A mutex "unlock" operation is not atomic, and as one user is still
accessing the mutex as part of unlocking it, another user can come in
and get the now released mutex and free the data structure while the
first user is still cleaning up.

See our mutex documentation in Documentation/locking/mutex-design.rst,
in particular the section [1] about semantics:

	"mutex_unlock() may access the mutex structure even after it has
	 internally released the lock already - so it's not safe for
	 another context to acquire the mutex and assume that the
	 mutex_unlock() context is not using the structure anymore"

So if we drop our ep ref before the mutex unlock, but we weren't the
last one, we may then unlock the mutex, another user comes in, drops
_their_ reference and releases the 'ep' as it now has no users - all
while the mutex_unlock() is still accessing it.

Fix this by simply moving the ep refcount dropping to outside the mutex:
the refcount itself is atomic, and doesn't need mutex protection (that's
the whole _point_ of refcounts: unlike mutexes, they are inherently
about object lifetimes).

Reported-by: Jann Horn <jannh@google.com>
Link: https://docs.kernel.org/locking/mutex-design.html#semantics [1]
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 521e9ff0b67c66a17d6f9593dfccafaa984aae4c)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f6038819fe79f..7ca1b5931480c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -777,7 +777,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	call_rcu(&epi->rcu, epi_rcu_free);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
-	return ep_refcount_dec_and_test(ep);
+	return true;
 }
 
 /*
@@ -785,14 +785,14 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
  */
 static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 {
-	WARN_ON_ONCE(__ep_remove(ep, epi, false));
+	if (__ep_remove(ep, epi, false))
+		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
 static void ep_clear_and_put(struct eventpoll *ep)
 {
 	struct rb_node *rbp, *next;
 	struct epitem *epi;
-	bool dispose;
 
 	/* We need to release all tasks waiting for these file */
 	if (waitqueue_active(&ep->poll_wait))
@@ -825,10 +825,8 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		cond_resched();
 	}
 
-	dispose = ep_refcount_dec_and_test(ep);
 	mutex_unlock(&ep->mtx);
-
-	if (dispose)
+	if (ep_refcount_dec_and_test(ep))
 		ep_free(ep);
 }
 
@@ -1008,7 +1006,7 @@ void eventpoll_release_file(struct file *file)
 		dispose = __ep_remove(ep, epi, true);
 		mutex_unlock(&ep->mtx);
 
-		if (dispose)
+		if (dispose && ep_refcount_dec_and_test(ep))
 			ep_free(ep);
 		goto again;
 	}
-- 
2.30.2

