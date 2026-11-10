Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346504;
	b=gVrHWE6T1PTywV5j+2yK/gl4/0Rplf+DakN9q0OVxVNHRxpxPewo41CMaKjt9MYjZ/dp
	 6xVCDUeaOEMV0MLKjjAGyp9Aox04T9QU4XCPRsCkaO0ZUUCQ3pOdk8yNwWKbH1jr1QTYP
	 vYjOwELtRHUcOetL9pCy3lpis2Uxd0bH+clW/5gc5uKljrlWqJPPYXNVScFtfgwMjsEz1
	 Bryu7bHJiTpmFCMjO9NsWYEUHWu1wZbqmxMVp3W1m1ZgrQXWPQPlA4+imywRzmNdPqean
	 wgJkycz/YVejzwKSDPHaiP/UAMpZLFyNJk16KV5IP1OfN1xpSmy8Fk5GXAiTCMK+9Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f5QSNcBVrOlv9x2Tml4+VpZ5VEIGpug7AeLnNtguKKA=;
	b=JBeLmLCYG9cO5N2sjkRa9zpNzQu29mn2NlIaBzEPFd5S0pJrq8b6XLNqHR3Eq5m5pVHF
	 l5RfFiZt4qfKJHjmVW/4bFDn6SAQJhU5h5hFeZFd+IK+73eCi+L0tnSd/Tut0QbRBybI1
	 dapQOb8jo03IeyuOX9Q0+e+Tt6Q8oIvkXYplh2C2tJiXx4wnxhAlM+mTEWWBuGaheB02L
	 fSpDijWSzkpHX4bkmcP9ltW50bbTb9Pwmr8cu9S+gUqFmQm/gq0tJWPP2fgWhKLIX491Y
	 nFarAdnQNA97pWlrs3o0XBDIpCF6db/Rj7N1cyoO1iuOOR3qsmADLQ0N3aMPh7Am0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUMFpcI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DB606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUMFpcI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2201F00900;
	Tue, 10 Nov 2026 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346504;
	bh=f5QSNcBVrOlv9x2Tml4+VpZ5VEIGpug7AeLnNtguKKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUMFpcI7Djajnfxn/jaWT++AAO7L6uKpM8cMsVAsV89a17ZQBIv2tS1McvsA//rk0
	 WnaQ4KRsUXKKXWWsktpn+Aapgaep9YBmk7nRUmG0DGd3wts/cEq2IkkYm/rV948jx7
	 xwC8QjoBUUUSwhsXJPOX+pPwszfc6wePrARC3GrLt2/bMghFS20Dah2kA/OiXM1vzp
	 PoFmMYMPNg52JFCXEPvhTtPC4k1v4Q1NdwrMSPix6mXlDuAFh9YU2RDE2ak1pDw3ZB
	 C6SquoF+VYpZu62EfC04E0b90+5fnnoeG/KC/Q2Ipof4AyixJl5/e2aRFvUTJ45Bux
	 TORUKlYzFACrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
Date: Tue, 10 Nov 2026 16:35:00 -0500
Message-ID: <20261110213230.3939455-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110213230.3939455-1-sashal@kernel.org>
References: <20261107053451-failed-6.6-a605d5d71a6d@kernel.org>
 <20261110213230.3939455-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit a605d5d71a6d280c43c7ede9778dda63fb5c3f22 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0c633c5deb75..f3992a728de69 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -288,7 +288,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !bio_in_atomic();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.53.0

