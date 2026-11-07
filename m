Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046278;
	b=lJejZN7bcDFcKF2HYyvPzxIKi2OqN/rmqTHFACEgkQVYqvhlzXW/eeorvnTdTxyCtiqe
	 89Lp6TwfUW76f9ZUUijYeqFBcZLC+nB59MkQmVpsUl/a8ZJMCXKSwIx7RPIrJz6OK5fbs
	 BwWqEYrYgVgmr/sYsaAX8E/PiXljLZKArao8X6ksb8iwgmBXPY/IYk8okG4xabSVHrr/l
	 UiCgAoPRniJocKHK0KOavUxVoWTHaqP8oYEj7IvDbwzLHxG95pUXNwd0qZXy5fg7/Z0yK
	 9JgziaNipIEqnk4UnKn/2dAhFUafeOfYOIFkuP39HOu5h0i7rTbIJAARSohblePArtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cAi9SxhBTF1EMraayRCOyimuUj1KCwkhbYss6mZ7LTc=;
	b=k69pyOgJQ/8mohZA3tBh2gMOoPZOInBEaJUzS2JIzXWL+8husuYKiMJNy9q/br0nrA+d
	 YTYT+CwmdlkDbzhOlNh45T/HvxEvz8D3HlnFw/EiyUwm83sGw6DJ8XkDXPAPASW1q6Gts
	 XNN0J9isUOGjd5p1krALmvzW/ynNEzrdR2xmEofYadTdliPyoAbZthTmAuaXyRpJa/shQ
	 euiyPwG5OS4vA0pqaddo3QJxMivdbv5T7/oWkAg/vS7ucTcI6MX44dI6CWd2waRz5Ap44
	 6EBIOy3+bBqmUwqVkBTSRT3/nUGLTd5uIPAyUOeynQ99Zqirw14wM+UFAdwdKalqspg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHjoyY4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C883606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHjoyY4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F159F1F0089F;
	Sat,  7 Nov 2026 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046278;
	bh=cAi9SxhBTF1EMraayRCOyimuUj1KCwkhbYss6mZ7LTc=;
	h=From:To:Cc:Subject:Date;
	b=IHjoyY4L4GXDbeLqoVxLlwaYU2mqzx5bX/1rcQdI/91hbjR4yRCBmYxXvZrx+S1TO
	 7HdFly1MXLhsYbAdmVAQKCmZp7Idbn1gw8kbeWOB4wbPMNDtmarNF8G3YYP4BMc1gV
	 jcLAgjDLPQVgwlPxUJoUSVdZ4dzttdz4ZdJc3OFdazgFVMz1gL4d5Zlc+oFMinao6o
	 mgo1sJQEvEORMtBKSv77obMk2Sc/5vCKLs3jx2+aVg9EMhBFbjBm3XJkff/PKGECEB
	 JI1Ey8gXggpeTUNbCQBcB9PGFeKC0kpYRmx8xYyk8+IjRep7r4yAMs9KEnLzfSpRsu
	 oaIArJY01DDMg==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:16 -0500
Message-ID: <20261107051116-failed-6.18-a605d5d71a6d@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a605d5d71a6d280c43c7ede9778dda63fb5c3f22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051116-failed-6.18-a605d5d71a6d@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a605d5d71a6d280c43c7ede9778dda63fb5c3f22 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 14:55:46 +0800
Subject: [PATCH] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()

f2fs_read_end_io() uses "in_task() && !irqs_disabled()" to decide
whether it is safe to sleep, the result is passed down as @in_task to:
- f2fs_put_dic() -> f2fs_free_dic() -> f2fs_release_decomp_mem()
  -> vm_unmap_ram(), which may sleep.
- f2fs_end_read_compressed_page() -> f2fs_cache_compressed_page()
  -> f2fs_grab_cache() -> f2fs_lock_cache(), which may sleep in
  wait_on_bit_lock().

However, the check still treats below task contexts as sleepable:
- with spinlock held via spin_lock(), i.e. preempt count != 0 while
  irqs are enabled.
- with BH disabled via local_bh_disable().
- inside an RCU read lock on kernels with CONFIG_PREEMPTION.
- with any spinlock held on kernels without CONFIG_PREEMPT_COUNT.

So the "sleeping function called from invalid context" issue fixed by
commit 08a7efc5b02a ("f2fs: vm_unmap_ram() may be called from an
invalid context") can still be triggered.

The block layer provides bio_in_atomic() for exactly this purpose, it
checks rcu_preempt_depth() and preemptible(), and conservatively returns
true if CONFIG_PREEMPT_COUNT is disabled, let's use it instead. The
difference is as below:

 old: intask = in_task() && !irqs_disabled()
 new: intask = !bio_in_atomic()

 Context                              | old intask     | new intask
 -------------------------------------+----------------+----------------
 Hard IRQ / softirq                   | false          | false
 IRQs disabled                        | false          | false
 spin_lock() held, IRQs enabled       | true (wrong)   | false
 BH disabled by local_bh_disable()    | true (wrong)   | false
 RCU read lock (CONFIG_PREEMPTION)    | true (wrong)   | false
 Spinlock held, w/o PREEMPT_COUNT     | true (wrong)   | false

Note that on kernels without CONFIG_PREEMPT_COUNT, bio_in_atomic()
always returns true, so dic freeing will always be offloaded to sbi->wq,
and compressed pages will not be cached in f2fs_read_end_io(); this is
the price of correctness, since there is no way to tell whether the
current context can sleep.

Cc: stable@kernel.org
Fixes: 08a7efc5b02a ("f2fs: vm_unmap_ram() may be called from an invalid context")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ae3bde0767f3c..a8d39add5cbe0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -271,7 +271,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !bio_in_atomic();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.53.0




