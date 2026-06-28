Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA861FCE
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663767; cv=none; b=ubCDLMrh21X0QpNCDyneM627Er+Lk/v2myKRX+T+sTIECxmGiOFtSBExEzQPWgkzI6CxQMebhRI6ghPsHJ8KB2ol/+yDKrXPTCS1aevCTmk0MC2XMAKMww6+F4rzXZbU8Xiu/h5nIGOQ19QW2SR53xvC0txcmON+gPvP5tdWMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663767; c=relaxed/simple;
	bh=edtZ+WAI/NsTiGWG46ieez9020h0TvTlJ2koRX9DcS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lj7k1G/20TjlIPB18r08avlrBOnwxH52X9T3num0iED37jh+18kcZ4HG2LXxaA3WVN2bJgw+8J+lwlqrshZEmACy9oLO1fARbIST6ySftthpVj+yx52LD1LQoQV51IS8OtZU+LY9qFuImkHnQSZPa4fj8SMA5bGwqaJDzP7/72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Tm1T4ELR; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Tm1T4ELR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663680;
	bh=nIBeR13CxaeLArJJ3bC57aH1LqV/qoCEiu9xm6KKhGs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Tm1T4ELRG7UkCGn8MBve31FBSzp5lhARhnSpfFUJFg96v95Q2+3dF/Lmw3dfoPB4o
	 36nzAY+cGWYNRYZW5Zxn3itSni9K2BBjRWy5KY456JEKzsO6aLei/Q4x5aUacjfZDL
	 RBjUIVK2o1ONFwFXLQ8qK4JbyoKpBBgKqHUaGnv4=
X-QQ-mid: esmtpgz10t1782663661taca2dc73
X-QQ-Originating-IP: BsWnFdt4kok6SqE1TGN3mYB5OO5CmlBZpf9fsr9jo44=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11196330115972661698
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
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH 6.1.y 9/9] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Mon, 29 Jun 2026 00:19:43 +0800
Message-Id: <20260628161933.532572-10-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NlFYEv8P6dwh5/1b4iDxfiXu82yn2DvhAsUL/ar6lP3qsHSh4WM07cCS
	HwRWFvHN3Xi90ZraukMwPaZOLMTP5ddN6clIH5/XwMzBfZCHscmwRL17Vceso7MK/wSDCQ3
	i5S9JhUa9ylb5PCjE7KfYr2lQg3W3KVzXW2WBuv8jdjkKr7C4YsuqsUZFT7l5x/yruNm6IE
	jOXokQsnR6NaFxdfDmqpNxCSk26Gz6s0GV6+viFQ5fem56OYmXY6TuRU0U5iZaN9lQwjb7V
	AR2C10ilAuX32Rkfy2RW1e9ZIPmlSR+RxJnckHMGfMg+m8f8XQG7VRMhQCM4SzoehgkrgmF
	GDrFV8mA53ORNMDsxgzLsGFkb5JIUxLrOafdOFOU937dNTj+/EYSUVeJQP41OVcnVT1svbD
	lRmq1vvmAltGTqhiLgWOc7VHGodCyumVUDZxE7aFYn206E5OQLkWdRnZ3+V7bIJgWWcjENv
	l+JN4n2eKYP5qa87AzfMt0hXzAOQTOsy/IRF2WzHYnxIQQXSuSe+Vv7pPRBwI6zFsMZ3Fdf
	7D5RnNn5PzGeeLZdKcvbmbs8/iDx5VLG9UWqv7mp1N13EVffIU5fSaHRaUJaDco58AWJY+W
	xGBRJR4jR5bGhlINEjyVvFCFV+bkHRgDS4uFfYjcwYXIqV191faj5dqAf6oVmr/4yvceokN
	nQTiAPXSRSrLq5JhikdoGtbkYP476pHMgcZoaUf0gMRySSovgiWdKCN3XyHez6DJfJ7HIOC
	wt35t5TUO2QObcBgNMc5Kn2Vd8MvXvyN8D0yUoco3kDl42HptS6Q9hHAfN2yLZcujV/YGiO
	VbRVCv6HR1WBxEUnaDeo4w4k9xMeEDdaMlbQVJZlBAcQxscVPyM5MdXJOK63JqvM2Un0r80
	Wv1Dsyc/mgw3sNq4TD07y1nzEVeWd8xW4I1OY9c5Sn1/FWnoIgUEzUMWJUZcgXUWxP+UOVH
	lsEO2kHMKLljm+gosERrE69gtwFrK06lYyTncnzSOlmPmhhNqsVzgnHbeM9tMwSjwRDoTpf
	+7bMxSeHB8o0vXVGaceAc4tgZXa7KQPyB6y4MS0C1+tHADEtyMEHGUWH1pZCB6fq0ImansA
	VVehhgOFxnqvWtyIOrdQ9Q46kLFY55d9FqhKT+Di+CtfverP/lEJlci45lwlbwOsw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
index 67ba8bf17b800..799fdf442e433 100644
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

