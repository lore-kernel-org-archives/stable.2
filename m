Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEB34A791
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262381; cv=none; b=n67sB3a7M7AnEKvHKtrliKsTywVeylYWLVw85VufPUkZ4CBC22j0zFgC87I/oaneXtkFwWl14yD8qW12gLTGtuVDnOtDlShTBVTOX+x/TroTEXUH5mbXWuw6pU7PBppF0fPBsK8aw6JND85Bv2CmstR2u4zdEBkZ8jggayXtKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262381; c=relaxed/simple;
	bh=5BRAI2mjiiwdWYknuhUNvmuD+TSUC4TBhnYkEEFLqBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCdI8UbhWVOSVuh2LTojXhh7NFgV/Ve5S7NPCCwcvLxK7mKblaF/LYIVV5wq4S6Eepj/sy+j5oAzC9FPD2LCFqWghX8LP8L2SLDxQK6+YjKinXG8m8ESE5d1RSXsSVMOQ8oN1CgmRM3V6RwBrLIisz9XthDWNJMU0M/0QFLEwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij9ahLo6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij9ahLo6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so3303625e9.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 21:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262377; x=1791867177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qa1bAuBiY4hv5m/kE0JClTqqzG/RYABtp9TEFFjsc0o=;
        b=Ij9ahLo6x2BJ1ROPrE259VV2xlk+mJ9oIt4hm2duC5AVSc2LlHQ0ZSHHdb7KEFbFSn
         xR2h9UnSOCzemk16HeqHvZRnSAxzhtLyjcDthtjarBulGz+heSFHHDHrBUZ5HB5Nff5X
         a9M3r5iWmG2GYhUmRQv+/YYe9zAXp5tXteGNU8cvDOj2NFh1ytQDFMMxRgBeLL/y4Ai3
         KV5bKvbv8X1wupYfD6eA+FyrST+Xf4FLbG0nCCIep1DBZB2Qb7ibjKc8Vs3ehZ+9jfwH
         QIvOESk3zqqxRPwJX1p+5ldtois8yy37AGPwELLdRDQmLhmNFTYFWDFr1B+dqgTQWvGy
         qHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262377; x=1791867177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qa1bAuBiY4hv5m/kE0JClTqqzG/RYABtp9TEFFjsc0o=;
        b=EUH9BNV8BfZShEsYejvHC6tFuk5oX9Xd0fedsbJ8HwoQBiL4w8kO2mcqN355GkrsEs
         fOMK5p1s00PqcU5zt9oYzEvWyBEyPKzlOJ9MMxGCZJiYXq6FUntc+XdHHDXUiS0Kl/Dp
         WXzZbpAFn0hlSMFWEBosnPONm9ps36FuSVQot3OGcUxwiFJCrXR7Ac1aCFCqvmVMkeaG
         ASaN6Sf6EVk/LmqDND+Upwg5OpuQZWJwTCamQPrjloIW1YQbe8FdNrpnlBJVdKJ8m1U+
         SEzTwPO2burRY541ZeEIbShjlY4PZdhSeS9mKtFfVp8TcviN6yst+tHZhA3WqI58M+G9
         iiGw==
X-Forwarded-Encrypted: i=1; AKwUvByPkw18hglSIWudENSbc16ouCaHE7yqvUAIYLvt5o7aRV/rztRyWhCCm1tHWWsedL899iM1FZs=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ5jlhKLLp33GUsG0J+B1knpB3i1G8hpNl6mdBvLNJzgZzIZno
	TsKaDTnYva4OYAnhmCoLfVsBZnVtEdEKPCR6krs9devDDdS/d90ENmm2
X-Gm-Gg: AYBFou1dIxh+RiMOUniVbv5V/E5n+zp9JLVYnjNZnvTdS3wmPNMlPXnDVU6LIZn6fJu
	z1dovWR3SK8VFYvKg9lZyptD9ptjYhythcITs7Ne9JxioLr/ZP4ccgqHTVgwj5/copmlsnWgsae
	SLKaiDKZIpb43zQUL6lTxA20XKBIIcqegDbfPnBd1/o5mP5svwlUBSnLYKgLq2una9ZqUk6mkFM
	vF9CunUOzjFd5ynUAA8W3sNSxGxv9LOepjv9ElZLC5tY1EqGT77vIt3jtbtGDRQsrK2xdnzjtLF
	6U0c+BIQn2pLYYh2MUeA9wVTMk6ohMB+ScQX0UNUI5G6vpKdsgqdLGIwLX63f3+z/4lH+RQB436
	b2wueQWy9Tnhw6TqNLv5W8JqiwkFH7AC2AJk38mEtGGyhsz2+NuSPbXDG07GYY2/evJzkUp63EJ
	Nas674KwbNxWNub5kNco56K9XnqSNeQ15nWdcoc1rKnn5M9+gOH9bJCupczLj1FxclYX5zcOo8E
	2dlMDif/fIOcLAc1h7qAmmOkom5FdDW9p9JVpKZDSWyQvjS8zT4FsRaey9WMyhm00fOkwS2O5QE
	XdT1u/ZqHcD75Xt8oN3oaCh6Fhxwc7AZ758=
X-Received: by 2002:a05:600d:82c1:b0:4a0:1a7f:2abf with SMTP id 5b1f17b1804b1-4a17b536decmr4681335e9.7.1791262377155;
        Mon, 05 Oct 2026 21:52:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-040-097.95.117.pool.telefonica.de. [95.117.40.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c53299sm72322225e9.11.2026.10.05.21.52.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 21:52:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ntfs: fix two kmap_local bugs on 32-bit kernels
Date: Tue,  6 Oct 2026 06:51:34 +0200
Message-Id: <20261006045136.5911-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two kmap_local bugs in the mount path of fs/ntfs. Both only show on
32-bit kernels with HIGHMEM, where kmap_local_folio() hands out fixmap
slots from a per task stack of 16 entries. multi_v7_defconfig enables
both NTFS_FS and HIGHMEM, so the stock 32-bit ARM configuration is
affected.

Patch 1: check_mft_mirror() unmaps pointers that were advanced past the
end of the page. On 32-bit ARM this clears the wrong fixmap entry and
the mount dies with a BUG a few calls later. syzkaller found it on a
multi_v7_defconfig kernel. A fresh mkntfs volume reproduces it on the
first mount.

Patch 2: ntfs_check_logfile() maps the same page once per loop
iteration and unmaps it once, so a mount leaves three entries on the
stack of the mounting task. After one mount the CPU it ran on can no
longer be taken offline. A process that mounts ntfs volumes five times
hits the BUG_ON() in kmap_local_idx_push(). x86-32 also warns when
mount(2) returns.

The two fixes are independent of each other. Patch 2 was tested on top
of patch 1. Both were tested on 32-bit ARM and x86-32 in QEMU. Details
are below the --- line of each patch.

Changes in v2:
- v1 carried an older copy of patch 2 as a second 2/2 by mistake. The
  patches are unchanged.

v1:
  https://lore.kernel.org/r/20261006043810.5393-1-kmehltretter@gmail.com/

Karl Mehltretter (2):
  ntfs: fix kunmap_local() of advanced pointers in check_mft_mirror()
  ntfs: fix kmap_local leak in ntfs_check_logfile()

 fs/ntfs/logfile.c | 11 ++++++-----
 fs/ntfs/super.c   | 20 +++++++++++---------
 2 files changed, 17 insertions(+), 14 deletions(-)


base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.53.0

