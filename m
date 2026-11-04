Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817829;
	b=pZqCmpKPQ65Hi0iwgysiVpwKk0zgh6Zelk9CrmjsHwFQxe+ZHdfdUaBh63w6/iEUnGnQ
	 AL/qMHF7p9s0ZE3aVX4ze/vrlI1a03WHilKhcCPP6K4a7ubZ/TcxhNct87GAe1mixh85n
	 8gBuuUXqDibIGnWG55blVcP8f6IaTk4cvem5h/JAgLP98ujTzVYZYwBIHPzcuSpBR6CmQ
	 9YvoZoeqouP2Rb9RKy4YSTcvvR6sffejHGLDck3uEE5AtyOk1PK8dcTrgz1Z891MfLmOU
	 VVEmvzGXee9ev8vCRKy1NBf8Pqu/YqgXTtk0PjSW6VvHes8R5mdJBclYHG0hULAxv2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r6CyrH/vB2wym6Oc9IBfE0XhagA0RizN2V762XVicSM=;
	b=QtPNR0dY/6gGb72xiBDjc3dvh+xmxLg1FdRtsKrdrRXndyG/I+JnZqbispLdDJJZhacN
	 2/aKiyQ9F0gpi7+H3eKMirBTMhXTCI9TSsxxexoGinSgOkDVWmt1V/HwrfjKz4pyi25EH
	 /os0pr0XEXhy4FQHbu7HIK8YhlITSpJNChYTP42nx5zSQzgaVfyQyNos3FRi76q8GDiv0
	 Bfn0rtXL77yd5tPBD2N6dEko5g4kDqOhHdb9d3fRHeq+1brEL7wDKF7BGPhTNWHLelxiS
	 JqbhJL0SQL+6UkSgJGfQKPkI20xB4GRgtIo7akHJWo0LXzrpRi34X9mA6HjDX1bGwGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fLEDDX6U;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748A606D81A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6748A606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fLEDDX6U
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4f488ba6e90so424635b6e.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817828; x=1794422628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r6CyrH/vB2wym6Oc9IBfE0XhagA0RizN2V762XVicSM=;
        b=fLEDDX6UT+AL1mj6MNbqi9jsj9v/W8QWk9zkCXZxFotaPbtbD12WyaVVSxDIQfQxTO
         zRjaiDkxSnHIZJiIGFfbgnfPXtoSOx6F2z42epu7yIFVbd5pFICUfIiCnCMmk3Z5FE4Z
         +BKkddBdHH1cH6ED02gKMXRuBHZHUAZ4X421W4hi5cFYZiQSy3zkpCaWjtpeKoSInGbm
         OWXGQ6xrjIF2GPu2icRHnDFVG6te+d7WmAVjep2zlUjj4uIlml3s4k4cMw0EY/PEUXTl
         rOwwSAPm5Okf8+3kG/cGGTGrsLfxHCUiNXZdUNPxuVGVQl5jSBT2kb3nZcfbQLUc0fwa
         OvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817828; x=1794422628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r6CyrH/vB2wym6Oc9IBfE0XhagA0RizN2V762XVicSM=;
        b=b9D/UduavhQZgky1qeO/zl0Klf1nQvlJRzzP6w6R59OQQ6PULVwtK4kJW36rQYo/jV
         7mznWHf7WhUaAK+XbQHJDIQ4CYznW9rAEoImRsfdl5aVwOM7P5xJwtTuv/csTSoLoOz/
         gl5iqBec5od+wAph8sK3ODjkI8GONu1iSA9ZkMmTyaGGh8iR6V8tvXsh1QNBKwj9FCfG
         kXnF9dQ7rF2nXPOoE2Z0USSbpWnqWELTOlT61DGbSmaGTeAMNdnVuaC8rz7NyuRG48Hl
         YEgoQuNiiHGlGDRNob/HlT4c5cyVmr40wjbKiMFtOHqBmawl4qyy06mNAWh2Va2IOaB2
         Ikyw==
X-Gm-Message-State: APuU4Z+vKSjkYKuATzgAUADCTV9AGFB50ejW6wpRYHMbeDFlJ61bvUeQ
	1YEJScfsMyA7kHdYa1jt2xWmda8uvGaoT9deeoPovB8zgKPfSMfnLD7V4oGxQm6B4WNg7CiZM+k
	8tHGv4eM=
X-Gm-Gg: AYBFou3007r6VSevQw/ZjJarUJeVh8cjky+cKnFQ5VMYqN8tP7J72xHjCTrh89pFuyQ
	7D4ysThvbGt2ecKvR1/XXJrw2ecdhxb0VZiAHsbpkR4GM1nJMCeGgIZlcyY6LI5J3d52nt41zfi
	7fe4OQqAyeUEQKTfvxqSQ75tpYKaZcnyZZpoN2J9iyTOzVPzUCVzjjKcU7bCqimWMGqpSV/nxHy
	76zpnVzLSC43oPZy8XFXDXsyvnN4+3VE4VoF7E/pLTy5/65wvttvl4orVSCJOui8oOwO54kyRTM
	3ljG9PlXvawAZp+2P9wztNZnvhypRMUPWxRfFVHHdFSNarDnkhiEYJZnO1xZv5hmwi/R1pBITnb
	JJpDHq1ED4OgKLznMgN+48mIpzKMYmz8QaNetNKcwoFUAJ7O7tuWlWL79QqoaQa/tk7jlOKIMTK
	uQ2xGqYno37rw1/uSspilms1KKe1vJTFRHdnZflBiPEhxvTevUa7lz8hkIhHATlYSV1SBBaaKa4
	f0Yly8RQCabI6THLiIhBw6bttRkf634wPYbmVtLOMfo2P/+72psLpJ+TCGYJrqDzloHCR+CnXsu
	v+Qifdn/+1Bl236eK0SXqh2JTHIKDY+Vf+FDbsZsuIAnOnnaNAlQ71+zgHsMg4DW9iU2CHw0njn
	YqJhXc6l1+h3rjF/nrlc=
X-Received: by 2002:a05:6808:bd4:b0:53a:8c5:d7d7 with SMTP id 5614622812f47-5640de0faa6mr11506230b6e.58.1793817828264;
        Wed, 04 Nov 2026 10:43:48 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 4/8] io_uring/rsrc: charge buffer arrays and nodes to memcg
Date: Wed,  4 Nov 2026 11:43:37 -0700
Message-ID: <20261104184341.516297-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Commit 075d5837bafc317e796548f721b8fbf7add6821d upstream.

The io_mapped_ubuf of a registered buffer has one bio_vec per page,
unless the pages coalesce into huge pages. Huge pages only count against
RLIMIT_MEMLOCK once per ring, so a buffer that maps the same 2MB folio
over and over in a way that defeats coalescing gets a full bvec array
per registration while only the one folio counts as locked. 1GB of that
registered in 100 slots took several times a 64MB memory.max, with 2.6MB
charged.

Allocate the io_mapped_ubuf and the io_rsrc_node with
GFP_KERNEL_ACCOUNT. An object reused from the ring caches stays charged
to whoever allocated it first, same as the io_kiocb cache.

Fixes: de2939388be5 ("io_uring: improve registered buffer accounting for huge pages")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 predates the rsrc node rework, charge the imu kvmalloc() and
the node kzalloc() instead]
---
 io_uring/rsrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f0353e8707d5..f35ae7d6ecc7 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -203,7 +203,7 @@ struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx)
 	if (entry) {
 		ref_node = container_of(entry, struct io_rsrc_node, cache);
 	} else {
-		ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL);
+		ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL_ACCOUNT);
 		if (!ref_node)
 			return NULL;
 	}
@@ -923,7 +923,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 		}
 	}
 
-	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL);
+	imu = kvmalloc(struct_size(imu, bvec, nr_pages), GFP_KERNEL_ACCOUNT);
 	if (!imu)
 		goto done;
 
-- 
2.56.0

