Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409452;
	b=mLRUy7HNVa6ZSWF6UmA+dUzJw8Mkqs7czE07fyJyE4YlphQ09qO6NN50P7rqO/AB3rnH
	 1MSnkIzJexQLpv1g9IYQskiKk6uZLJvD7C89m+IwGwKcqno/T+JbNVfRf+6Qrx9r9xnh9
	 TtWeWLSYgfxY44mJvFqEj6PBkpEMfjLmWHb5X8NFrecWghCTzmYUL+Hv4qH+5t7eHO7Vw
	 XR/B8gKZYOL98FLPKxPjnAZLFozbrL9NXsV9YNm3ohoGNof0hbwKd6NhGmJnWEIC3j4Rf
	 +7WivnyZUYC9DoTPJMIJDynLU6vs4/Hlv6FPnjzGDipDZ6iFrpEVjFGewRTWGaGCAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p4E2pH0lSmH4FLNSMno5m5zDMA9lipwOMSDm6hv5rFI=;
	b=xorktBscXK0dpf1GRzlyykXmXQXdUxzpnKGg/74m2i8bdjBGH9HR3DaXRqeQjGC7KfW6
	 eHg7cRMmobAvDBIBWwmMxEiWdfzuY8DucJgQq95AGaUn28xxGekRXeUbcX19hYDt0zXjW
	 8gw93GPv7rKZXuqzL48DQu5koCfVy5xAGLWrYVAeoOd/tqh8p5abNvqhr3zfyhfoN75AK
	 LneV5SoB0nkBi4YWcsCEZZfY/silgHxOmXCdPCyHehdRqYgR8+S88i2PfCCZrX/6gsBy3
	 otpfg6eOkdEeQHFx4PZVW0V2lp8uU7wdjrNaQsWoFGmKzmLildMX8ceFuxw54Dhpclg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSsyCSS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD1606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSsyCSS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E982C1F00A05;
	Wed, 11 Nov 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409451;
	bh=p4E2pH0lSmH4FLNSMno5m5zDMA9lipwOMSDm6hv5rFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lSsyCSS1RsLte4AtdQZF3fmLCzs30BSWdXucJjKzcoXcmQASrTVATlxnlRxzoPJcA
	 DeFtmtxBYIz/QiN5t4/o2EGbom+JcOBANyDaWv7jc2aMsATeRxINvJd5OInBkhaQGc
	 eFeDHDnhSoDOPopql51Tg9Q+422h865BVwc8iDWuy8r5XSQAAOsxgipd5iL3xrcVdE
	 43N+GhMwJziNuihvR/hpvbgUqdpm5D9KcAkFEioUHHjjDL5YHOHuf76vwi5GX0HxhS
	 hO0RJ6eP0WIrdAOJFIcab605eGXCqncmseBou8lzoJsHTzzl+PKD9Ke4CR2YnnNrf6
	 2v6yh3NAcXo0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()
Date: Wed, 11 Nov 2026 10:04:09 -0500
Message-ID: <20261111150349.2541166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050441-failed-7.3-e4582e5f3b43@kernel.org>
References: <20261107050441-failed-7.3-e4582e5f3b43@kernel.org>
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

[ Upstream commit e4582e5f3b439228d4e900edcf8225aa89be32b4 ]

f2fs_write_end_io() uses in_atomic() to decide whether a write bio which
exceeds max_atc_write_bio_size or max_atc_write_bio_entry_cnt should be
completed in sbi->wq rather than in the current context.

However, in_atomic() is not meant to be used outside core kernel code
(checkpatch.pl warns about it), as it only looks at preempt_count(): it
misses irqs-disabled and RCU read-side critical sections, and on kernels
without CONFIG_PREEMPT_COUNT it cannot see spinlock-held sections at all.
In those contexts, a large write bio will still be completed inline,
which defeats the purpose of the above knobs.

The block layer provides bio_in_atomic() for exactly this purpose, it
checks rcu_preempt_depth() and preemptible(), and conservatively returns
true if CONFIG_PREEMPT_COUNT is disabled, let's use it instead. The
difference is as below:

 Context                              | in_atomic()    | bio_in_atomic()
 -------------------------------------+----------------+----------------
 Hard IRQ / softirq                   | true           | true
 IRQs disabled, preempt count 0       | false (missed) | true
 RCU read lock (CONFIG_PREEMPTION)    | false (missed) | true
 Kernel w/o CONFIG_PREEMPT_COUNT      | IRQ ctx only   | always true

Note that on kernels without CONFIG_PREEMPT_COUNT, write bios exceeding
the thresholds will always be offloaded to sbi->wq, since there is no way
to tell whether the current context is atomic. The thresholds default to
UINT_MAX, so the default behavior is not changed.

Cc: stable@kernel.org
Fixes: 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Retained the bio-size check without the entry-count condition because the required fields are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cfd81bfc28a22..43e623a0bd30a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -399,7 +399,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
+	if (bio_in_atomic() &&
+	    bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
-- 
2.53.0

