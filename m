Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021424;
	b=JAA9kxSpbx/V2ppQsFbOjhVyra2CRlkrSa32eNC+3i9ZbP1TWy9WIVttIS8sX1pXb45Y
	 x0t5ZHCvRIgOWw15KHr9wfhTq9O2avudE/lMInfClt9gN+AUuW9826bZ2ZDwHwTsI5Jce
	 vs9EbEskKcW1zRzmNeOaGaxWncVr/ggzJt99dgNjdxCUpCJZWxi/F9nvnYdzEJlLNfo5b
	 SCNJeyrsDZ0o5Ma/jxNznOP+vvUcTrteri4tSjJyuPrxE1k8R5wAi/pV3F4tW8azcoR6/
	 dID2z12R7wRFwDl9y2wfAcBrHZ7QVgHfy7TW8UvMYc8eOPGTAPB+7eekM4LMr2qI8Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UaVcyNlEXvHCvSegf7DdOWk+AJHnO+R6lg7onpWBTLM=;
	b=M/n0CfxbMYryrHK1AOYKvG2BzJk35Z3xQDxwzX+Nflc55O/1trM89/9ll4mTHE2aM4QB
	 xWHbg4nL7cqeSaLP1XlNjxHyHrj3qPnzVxKYDWcJeckhzzDeqJOlHKnuNeb4e0S18UNUM
	 X3tW45PQ71dF1oYkj+sL9T7lmGW3Pz5sfbHQupo4ECh5PHyQ5HjMfsH6OnON+iTrRXfwl
	 YY6f6HKvvHVD3JfuXLz0iilGxjLr3j8C82t2+bqZid0XZs12FuQ3OK++ooeXxRgz2C+0A
	 pYHhnrj3mqmnctgs22ZfgNGmMevdc+9ndvNLooVR7IUTwr19g5OZVBIQA+Mg+elOE7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mOwwJznX;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22F60A3836
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B22F60A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mOwwJznX
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1215955a34.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795021422; x=1795626222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UaVcyNlEXvHCvSegf7DdOWk+AJHnO+R6lg7onpWBTLM=;
        b=mOwwJznXdq/mL9a1/tRYiu+9aHrPlamFRSWHPx0O36q9m1DP0sFU3+p9VaXqjV9+Jc
         MHRPPQyaH6plbzz+MRt03IENGzTCFWtIU2eB6RDCK/vXwdZ3FIYebVbtzwU68gaL+/YL
         svImR0bmonJzBwIrCZkIeL2mFLfBOb0UYMwLIM3rpOA9Rx0s1aEgxxJziWKfhhCyP6h5
         geqrqUdZrc7VGULz5CGgt6SNcvKLjmcItUpgyqAgUBH5zB+tze7iTqdDztLygklSMQsv
         CDA8M9ne2KsRlZRTbIJYPmcmkdYmXliMxsuKVjRfHlL7z45p5d8Bv8061oC7JWLDorFM
         JKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021422; x=1795626222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaVcyNlEXvHCvSegf7DdOWk+AJHnO+R6lg7onpWBTLM=;
        b=0NFj4ZnJ9E/8ZpffBmkc5X15+azY0EhKhJuylPU/RD6tSwUuuHVlCSZVOgvGAYROJm
         sZ8DtPTayVwpZTD5sQs6Iqn7oE9nnTRfGdrv1rIy4iIXyqKny+p+8b0JgCxmMu+/PHxz
         6ec2DmdEudI9rjTa3FnSrun93EOM6CMaGufl7IOjcim+ZeFPNwfgJgoUoeL4zGSQVene
         ksyLD6dI6F8+4XOZquZIeDK53gfx4duMvFwPkeVsJmqmJAerB8y/s7wg3ZdPeWirDY48
         cjNdFuDTW/Z7aiLSFLWxAlW/oMk8vu9jJTH29cgiDCMaqYBx2jNtrhBmM3nA8dfY9BZr
         XcOw==
X-Forwarded-Encrypted: i=1; AL+hErFZh5zqWnyrBA40R9THJHDcD3CXVF/+ZG5o3lcV58J6lfGxM+lRRGQ9QBFm5tD41dK/IwY0/HE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yvansrbig8Kd0giSd4UqCGbuRo0XCUh3K0NlvncZbVTDQF3xZ
	sLC3E3OSq6ud2CJ5Bhe8VKEyEHt6KphSOsGRvc8g/alXq0ZszeIRX7ZK
X-Gm-Gg: AYBFou3recbBzQAbIFo+mGFPXJqtMenpJwiESMIiKKtF7p3HWggHLX1SfwC5wRLPK54
	eZ3atvNi7ezMFEMGhnV8oSEJKsxU3OJZCvOqmrYmnGWwjF55h3JgN/86sjNbmC51h987r1Hcyhl
	eoRwZAbPSBqqdjkr0m5hlLAp+MDPNg2bPMl8y6N7BKwyL+SGmGk5JLE97D6bz3iku7LxCNBPk27
	Mly/eWN15yxzgq/G+QcME8LbLqUiTaTAMN8ZAXJ+VII5zHT0im/s0ga7dvGPQvHS42qy6SfpvLM
	VwmS/gPwOhDL2vmt21UY+rMGFY91kkHF0i3kObJpJBqm0OKTjq/EN5TnvYx/TnL21PvZeF1ahnj
	FgdFKZQ+WwmN9TtzA63Gbr/A9xDR6qcaT/hFNdWCauCR6uzFi51IADjXIaQxFv84RRDF29zZ+jB
	7fshJdXSvuf3lOxGktxOJwWtdoyupOM2/SgPNUAby7TNt7QqYp/8dvCN9SlkPwE3HB7TtcMo/7V
	89hUyHK8SaeJgECsJ7KtgvnbqNiMi3hV/5pBTXjrC4toFVVZVbVXC3s/BGKrR3p6mjaW8rnphej
	Ud9mTKq15qPuBlbfgTuk5WA=
X-Received: by 2002:a05:6830:2696:b0:862:aca4:1158 with SMTP id 46e09a7af769-862f0861aafmr2972784a34.22.1795021419554;
        Wed, 18 Nov 2026 09:03:39 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:15::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d474esm2486617a34.4.2026.11.18.09.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:03:39 -0800 (PST)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: mason@kernel.org,
	osandov@osandov.com,
	josef@toxicpanda.com,
	fdmanana@suse.com,
	boris@bur.io,
	quwenruo.btrfs@gmx.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH v2] btrfs: fix bytes_may_use underflow after a failed tree block allocation
Date: Wed, 18 Nov 2026 09:03:32 -0800
Message-ID: <20261118170332.992625-1-vlad.wing@gmail.com>
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

When btrfs_alloc_tree_block() fails after btrfs_reserve_extent() has
succeeded, its error path gives the block back to the block reserve,
although the block has already left bytes_may_use. Each such failure
leaves bytes_may_use a block short, and it underflows and warns in
space-info.h when the global block reserve is released at unmount, or
earlier.

  btrfs_alloc_tree_block()
  |- btrfs_use_block_rsv()
  |- btrfs_reserve_extent()
  |  \- btrfs_add_reserved_bytes()  <- bytes_may_use -= blocksize
  |- btrfs_init_new_buffer()
  |  \- alloc_extent_buffer()       <- fails with -ENOMEM
  |- btrfs_free_reserved_extent()   <- bytes_reserved -= blocksize
  \- btrfs_unuse_block_rsv()        <- block rsv += blocksize again

Since commit 19d7f65f032f ("btrfs: convert the buffer_radix to an
xarray") in 6.16, alloc_extent_buffer() can fail this way under memory
cgroup pressure, because fs_info->buffer_tree is memcg-accounted.

Return without giving the block back once btrfs_reserve_extent() has
succeeded.

Fixes: 67b7859e9bfa ("btrfs: handle ENOMEM in btrfs_alloc_tree_block")
Cc: stable@vger.kernel.org # 6.16+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
v2:
- Shorter changelog, built around a call trace (Qu Wenruo).
- Dropped the code comment (Boris Burkov).

The code is v1's apart from the removed comment, so v1's testing stands:
its reproducer leaves bytes_may_use below the global reserve without the
fix and not with it, and fstests btrfs/002, btrfs/220, generic/475 and
generic/476 pass.

v1, with the reproducer:
https://lore.kernel.org/all/20261113170926.1468850-1-vlad.wing@gmail.com/
 fs/btrfs/extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9b0a5c6b96f3c..8d4c66bf850bc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5433,6 +5433,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	free_extent_buffer(buf);
 out_free_reserved:
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, false);
+	return ERR_PTR(ret);
 out_unuse:
 	btrfs_unuse_block_rsv(fs_info, block_rsv, blocksize);
 	return ERR_PTR(ret);
