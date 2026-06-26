Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D2175A66
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447337; cv=none; b=iNh3yO9mi+K8rRRmBuFnJJvvokOPueOHlMaEXTFiNZUzezBQr4SQzrjLN6wmOtuNQCjr7FhYJcrrmHYds+wQU1K4rKnNy5wWWxJrrl6wd3MvWmF0RChtVoR3I9Ga91ZF/fJ2U7adNI1hSQOfPadJrPg1eodqm1y+sqFxZTrE9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447337; c=relaxed/simple;
	bh=czYtGKziBL5he6HdUnY3wES6NNszDcXO1RBQZxBzBbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6sZdXpkO8sCnVxCfyqc02KxokA3vU7TYGTsa5SyJbuvNi4+dPbTgIB7iO7HUzF7HI23BWPdQPTPn+gEy549nn/zQglx2Nc4s2P3ZduuZF0XgGxQ5+eFmxF2og4seh42GeVi/MPqTv2HaQp0j1Uj9XQUf0PQ8Pd1lMXxj39rEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MGzsuMiU; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MGzsuMiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447300;
	bh=kzPfazfa2yk8mgC1sIFGH/9PeNR+bRXBSPDvsgGyFiQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MGzsuMiU5oxPgDDVBqXIBbLaG2gATGMep8UqDSGbEaNQ0NmMvHhA19oZcu7xW1dQv
	 8gonPOESOXNmikGpNlo9S+TNGKE6bo2ZvnpvzIoAZdO4JDZ3HneTgEv7Y7varRbBNa
	 YXuAT8qwdPpgHW92qsFpDqOmNPfGkdhfm3ZrttsM=
X-QQ-mid: zesmtpgz1t1782447293t49cd4e27
X-QQ-Originating-IP: GXA7/zI5BcReD+r00LZYTrHPkvlLxycWRZdrWYbE/1M=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7040099100832653713
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 8/8] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Fri, 26 Jun 2026 12:14:03 +0800
Message-Id: <20260626041403.85968-9-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NcYDFsAPVUmhOjZLfOjyFBcMSd4u0Md1DFq+5l3Bvu7VcrXPeddGHCPw
	Z7vQKk4unONzAzAGvPy3W03jhHCfVCwJTKI8nqNqHGpBf8aaM96laL5J8NjMHSwkXuZd92t
	mLIxTJW/VWnQGvNbwt6ZmKk5sAlLrLbOksU/HOrzUB5fEApIV3HRIPbLPeEdtYUH71Q/FX+
	lJ4HSMEtdh9GqR8PCYDFTOi6fKeWXBuTbGtN6qMrZGfpONYwMH230TV0HAmd05toTtKPRna
	GF+aZwCnX3b7uzZH3jwyNsUttHhJSl93XHwB47qCychuPALj0u+3PrWawQybRDEKLPHrG3B
	y6rI3Ng7u9ckOjnRibK/iXf0vf8IZGs8hxBd25PBNCKeWgm3jt/uhrh7d/KV2IJNJB3ct3F
	7cThGWc1OMfxmUYieI/6ID+XfsY6zWl6MOhMSrXafIQNbXoH7gMTSL1QwLkuSd7Cs7Xnz6m
	GrH/EOwwv35dX2FAnmAJMc+Wh4JNM9u82Bz32Hb1zQteUx0z65fem2f+d+pQeHqsYOXhgPp
	Q3MI74MnQZLQOSa0hHLXLuXB513sZk0AlbZFj/UYbL132OzYDxgrdfhWK7TvYBgn3vyHxD1
	V+3Unro/qMS2bE9231wQidSB4SG+Fb78I+9rQzKQv6eXGL5aKN7/YSUTTZYu9fnhgCVaaKY
	TF0IiNz4nt+XA0UCf29R1nCFlG03n4MJTX9r+am0zYgN/nD3CJQcaMpvbJ4B2KZ/OucuOEd
	/GQADXta/rxVmrvfA6+4F27qYNx7clvnnEEMOhKS1J1cxs8gIiNMwDJoNc57UNX7mZryh68
	iFM0EO4qt2s89BIORwd8B7Z938lThbvMk15p1724bsu0Yvbsp+dJXOUTbE3IkSSkfEl6MGP
	ioJRSwGKFrDb56b5qmfbF9Ov9ehriGwiB5Xz2SaCjTjmGHtWyKR6LRhBs/lxi7fC32hGrXi
	NOvMO6V1KZwYm7OeZpbP7SgtS0w2mRmDTIWwZf1xICQE9Anefoswyw85zCGKt2frXSJgwk0
	PqYyizPNgKx987NLqC+ivuV04NO/fUjHaT3mkBuwpCl07k7/mpOyZ9tpatIm8PhaBwhF/Ku
	0yoAMme3gr52uKG0HJmj5a/W/WKq8g8Gf7lWOI+FU8YIV8oVRJWR4hQf+5GkCRuNQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a6dc643c69311677c574a0f17a3f4d66a5f3744b ]

ep_remove() (via ep_remove_file()) cleared file->f_ep under
file->f_lock but then kept using @file inside the critical section
(is_file_epoll(), hlist_del_rcu() through the head, spin_unlock).
A concurrent __fput() taking the eventpoll_release() fastpath in
that window observed the transient NULL, skipped
eventpoll_release_file() and ran to f_op->release / file_free().

For the epoll-watches-epoll case, f_op->release is
ep_eventpoll_release() -> ep_clear_and_put() -> ep_free(), which
kfree()s the watched struct eventpoll. Its embedded ->refs
hlist_head is exactly where epi->fllink.pprev points, so the
subsequent hlist_del_rcu()'s "*pprev = next" scribbles into freed
kmalloc-192 memory.

In addition, struct file is SLAB_TYPESAFE_BY_RCU, so the slot
backing @file could be recycled by alloc_empty_file() --
reinitializing f_lock and f_ep -- while ep_remove() is still
nominally inside that lock. The upshot is an attacker-controllable
kmem_cache_free() against the wrong slab cache.

Pin @file via epi_fget() at the top of ep_remove() and gate the
critical section on the pin succeeding. With the pin held @file
cannot reach refcount zero, which holds __fput() off and
transitively keeps the watched struct eventpoll alive across the
hlist_del_rcu() and the f_lock use, closing both UAFs.

If the pin fails @file has already reached refcount zero and its
__fput() is in flight. Because we bailed before clearing f_ep,
that path takes the eventpoll_release() slow path into
eventpoll_release_file() and blocks on ep->mtx until the waiter
side's ep_clear_and_put() drops it. The bailed epi's share of
ep->refcount stays intact, so the trailing ep_refcount_dec_and_test()
in ep_clear_and_put() cannot free the eventpoll out from under
eventpoll_release_file(); the orphaned epi is then cleaned up
there.

A successful pin also proves we are not racing
eventpoll_release_file() on this epi, so drop the now-redundant
re-check of epi->dying under f_lock. The cheap lockless
READ_ONCE(epi->dying) fast-path bailout stays.

Fixes: 58c9b016e128 ("epoll: use refcount to reduce ep_mutex contention")
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-6-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
(cherry picked from commit a6dc643c69311677c574a0f17a3f4d66a5f3744b)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index fc4668a403c9d..0e09bddea16a5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -801,22 +801,26 @@ static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
  */
 static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
-	struct file *file = epi->ffd.file;
+	struct file *file __free(fput) = NULL;
 
 	lockdep_assert_irqs_enabled();
 	lockdep_assert_held(&ep->mtx);
 
 	ep_unregister_pollwait(ep, epi);
 
-	/* sync with eventpoll_release_file() */
+	/* cheap sync with eventpoll_release_file() */
 	if (unlikely(READ_ONCE(epi->dying)))
 		return;
 
-	spin_lock(&file->f_lock);
-	if (epi->dying) {
-		spin_unlock(&file->f_lock);
+	/*
+	 * If we manage to grab a reference it means we're not in
+	 * eventpoll_release_file() and aren't going to be.
+	 */
+	file = epi_fget(epi);
+	if (!file)
 		return;
-	}
+
+	spin_lock(&file->f_lock);
 	ep_remove_file(ep, epi, file);
 
 	if (ep_remove_epi(ep, epi))
-- 
2.30.2

