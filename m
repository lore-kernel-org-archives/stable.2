Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046149;
	b=rbYBNQJNJoe92SY+BIq65jzaU1UcdHL1qk14kLKVGpsYSC7Dx7vv5dChddbWUCBIr8JC
	 j5kNC8qPUM7KWIt8VZminyyle/kENXDMpRJQMPBgavKbKMnztSIuqiWjDBBJfsFiF9QGV
	 U27dDtThI9NylqvQzPM6e6YG9wJxqcWQmNdro2ecuTm9rfpMr/nGTeJON1NsUKcvhIGQw
	 3urFrVAPx5nEmPkSvx0YWyeC5tbb+VZnC1ADSp2VUhzR3wnFnjO7/fU/RoHNiCiDizV7Z
	 2w/lqcLyhBpDepK5vVh6dXVsYrPe9KKphYgkFU16XR927F6P8ZyBV70moR/Uv3w8T7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046149;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IjrgQXMV5ymW23iPKI1My/Fb4eE9b4apiraO9OzxYBc=;
	b=YQ/ohINW5r63gG/3zKTwa/0Ct3MehDT7Fby0avDa45uS9e8GfXKgMjSnQD01FN39nUAl
	 w/gSzGpy1+M5ajf1nMmKjXM0yJJLS2LgW/v1Hi6Xsmo0ujjGb3myBi0TfvYQM1FJhKgUu
	 TZlGjnKyUsy8o3cceY1R3aSEmmJJ77KlqeWhGkQk/hXwMxK1E3wR5DMvbC+vSt38wBKXN
	 HvQk5U7fb5j2toKc8buvmLAa+7JZL/OVzhk3Ge5F3Qmp8RjWQ6zNv4ZMKspGKCH+5oJ0T
	 hpDud5heaur/rMUySiFMn/iyuW6Sz7gq9Uk+kjGDZF8MqNnU7vp+ya5fnd6XAY4j4lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gszFB/m9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gszFB/m9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C8E1F0089F;
	Sat,  7 Nov 2026 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046149;
	bh=IjrgQXMV5ymW23iPKI1My/Fb4eE9b4apiraO9OzxYBc=;
	h=From:To:Cc:Subject:Date;
	b=gszFB/m9Dc/5JEjYh68KE3NjWH2HDbM0rkK3pGqU0cJFZ/CqaCzVYDbpn+ixVDeXW
	 i3GAOL67mK4cbocZ2UC0ufndQcdLhhlLZ0fphbFFaYR0k7hp1gEeio04UkLws+d9ud
	 nFrYv0SIUIWH3C5+UNMf4T9AueRaG+Wf7TTgA9/wcMUOGjx8zOICAo6dcZCTPF1jsf
	 xf1dTdwmvU1TT1NlhMmOIMFYrlKSxStAmXmOjaIeeOYOSdmF9qj1SvxWGgo0UIzTh9
	 MEicwVs3/LTS5nLqF1ZNX9Y1JBUVbMbEDmlvI7U/siKTqyWgc5AltYEHwGu/kSUmEy
	 KUWd2Hd1p2PcA==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	akpm@linux-foundation.org,
	hch@lst.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xor: add missing vzeroupper to AVX code" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:07 -0500
Message-ID: <20261107050907-failed-6.18-7b8fc26c40d6@kernel.org>
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
git cherry-pick -x 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050907-failed-6.18-7b8fc26c40d6@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7b8fc26c40d6cf4c6751a045c9e42bbb7e78d81b Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 31 Aug 2026 14:22:48 -0700
Subject: [PATCH] xor: add missing vzeroupper to AVX code

Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
before returning from it.  This is needed to avoid degrading the
performance of any later SSE code that may happen to be executed.

Link: https://lore.kernel.org/20260831212248.213805-1-ebiggers@kernel.org
Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
---
 lib/raid/xor/x86/xor-avx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/raid/xor/x86/xor-avx.c b/lib/raid/xor/x86/xor-avx.c
index f7777d7aa269b..95b21e7225e8d 100644
--- a/lib/raid/xor/x86/xor-avx.c
+++ b/lib/raid/xor/x86/xor-avx.c
@@ -147,6 +147,7 @@ static void xor_gen_avx(void *dest, void **srcs, unsigned int src_cnt,
 {
 	kernel_fpu_begin();
 	xor_gen_avx_inner(dest, srcs, src_cnt, bytes);
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 }
 
-- 
2.53.0




