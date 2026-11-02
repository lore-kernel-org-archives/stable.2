Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662290;
	b=n1wG/2UyHKEb77GimZtUyiEr0lpJX2jhmW0XjfKMT7lSrI1cqO3uq363iWdKySDj11P9
	 aH9M1f5U8QQ30iJyK7Cov0BELc3DqKepPGbAQ7BJfS5SzxVvdbExTcYQr7zx+XNR+0C8P
	 t96EImWQfpGst2xrXI8gFy6IY/YF31einJWz+ZmW3AI17lpgUKaej8RTHaTrYrYVaIJI7
	 pLY8+dhMUn34uCsyLE3WFi9Pnb92x4VBf+WqgUJDPEHDqtRdVsdDJU4EyR2D0Xwe3RvUC
	 usM7/waS3rkAR49ucmc/3l7XOWn/hDziUcVRkLEBCS9ECZa+CqSTMgifRUza3P+kQpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OoWUKvavyBp7l0yEFdfI809FcCGWR9loHYOW+zBH4zE=;
	b=ntSKe/Wxuo4wyEm3Slmn/ORn6DKeYXLOiJFdQt09LG4XAAi+ef9v6H3WRMMWfcW0p+2F
	 cn7xwITJd34Axm8hlOtJHSN/PYS4kHa94x9QFX2SwHpC+rwk8lUyvnQWEHOTikLssN8Hb
	 l8TaMu82l7vm2lKY5jwT0En3H2UDJw1gUEBmI8LPNXmRsW8M9PYH1CAZwZkPGI7TcpGKo
	 L9L+XqOm/W6aYC8h8jCwfsFiYvsqk6/nK2RWv/zlrKww+XjmJdhE79rWAfh5iH5Y58qaz
	 pB3gBf1zOQwDATACjuWwuql4kDpf+Iua1fG/8hRM6USIK/gnyDx+4jdDcgJ7bMllpUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=BO1sTTha;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAE606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DEAE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=BO1sTTha
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so3529075c88.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793662289; x=1794267089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoWUKvavyBp7l0yEFdfI809FcCGWR9loHYOW+zBH4zE=;
        b=BO1sTThaMeBd2/m5P4xWiK4pYDIdeppgAAerPQVmPpupgqKrZX4NUAat4ZVm0v1qin
         4/yPRXqhOWsaTFMpC9nEV8qvLtnMZzsf+Vobs1Ga+LCxrHeA2jfB6rTE1vzySrub4Ra/
         3oCZm1OLvrkqXHTlcKmCa6u6TtZvTPSNRjygutwRiXWFqIdjXvZA2nyp5fk5GJCmlrXM
         HFkvB+gD9NHRZvCeHswGMeFGiK40c+pe9iEkkLr9Rx3tqoju1I+owRT+fvXu0Bgx36O6
         iIJj/5DqTDW56+fPYHXCvIzc5NG2J6Q5H0HTntlaUyXZBsTTiPZhkNLKBZplvPjCrH96
         8Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662289; x=1794267089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoWUKvavyBp7l0yEFdfI809FcCGWR9loHYOW+zBH4zE=;
        b=K8MVa5vXZv52eRTfnihu/N5eH8f2roXvA3E0ZNpRNQAteSp2IOTBMf+UbViEHnzLeA
         cHF1LwWcMaVNaEHdDatX0g63ZK39u0ZKLhlmhd5mQV58ETWH8/WExrO9Uy/DUq79WVw3
         +JQjL5m+6//1W5Vt4AFV0QMrMz+gQ9Y04hd/upxSgd2T2bgwn6z3iyCvI7bb5EUtv3Ex
         FgjYhj0iWX7pegLbl8mn4IDpOT8FGoE/ZXcsXjtI8VKv0pC+4K292Fxkq0OyJvESobZ1
         MiFb9NN+ls1sT/ysdgR8uL90DZrnBIDGImPJKhNSN+87i6/yT/6krTYRzgySvT+vM2Hc
         mHwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBCRNwRowkLsToJ4mefkhKngRs1vNUGEWn6GPdf3z2F1vrFu2ztOtAmDAowcav5+OTUzeVJrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjZX2+02ntWluh5T2zz2HPynOI4QbXpZAk1tdITPckeCymNqMV
	JI3hUTXYnq5gabH4r+qoV++r90M+mIEZLVsKNTamjBmz+LZoW6IEB1zFx8FG0F9EEX0wlGWUoBl
	PBlHInqfL
X-Gm-Gg: AYBFou2YOll0hg8SOCLs+y+TMhTZtc1r48sEhlloHkXl5p4aRTxyy+7N4B29GnlTZEG
	HNXoU5DHNMnD1QvyT8y0M6b7671En7Tb68tJWRV8LAXs/VGSw0CgFlTa8YM2jP9JWQ6EDnMR+Xv
	T+eY+tFbvZmAKnfDC2VqQFTc+yJeiGVrBWX/StGrSAKbSbO1jLXwDW/1Pmm7mhbGRpFKcS4qOXZ
	gHw6GZ9MmB4kASiegY9KbnDvU17ufSE59tVIecxc1z+exFfde3HLKqmb8RKL6jeC4lABM6uc6xn
	ylxLEUiNfLgjk/V149KgvrUzNapB7Yl6CvcNNgf/oBeCfGO8H0qDs7u8v5DkII4GQT07Bpv+z5r
	jMGGS7bCT0L3ey55Dk22xEkHeh1F97Ld1E5WuC/O+F4bBINjlA6DIxueOPex9ioh7YEBJgedkpg
	0DqniM6xavv0m4alHS6yO9UPUMFPwIRUjHxEqNuykTh981p1yFvaAC/ZEJTwo4fPjjVvx7MpuY0
	y4FmOrLW+7VCS0mVS6q5N5g9yIyABnXOIbm3fc3Q/10bq8genEdhw8e0CiaGQ1gaV6C1If1vIlt
	mcTta/ibFHm7X86ZQ25R08NTa1h8Ssz1ociO
X-Received: by 2002:a05:701b:240f:b0:151:2e62:fe6e with SMTP id a92af1059eb24-1ac5e322fc2mr13871385c88.19.1793662288465;
        Mon, 02 Nov 2026 15:31:28 -0800 (PST)
Received: from localhost.localdomain ([206.206.222.26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1845817csm36527415c88.5.2026.11.02.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:31:28 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Chris Mason <mason@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <brightprogrammer@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: do not check support for an invalid sectorsize
Date: Mon,  2 Nov 2026 16:30:41 -0700
Message-ID: <20261102233041.310900-1-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
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

From: Siddharth Mishra <brightprogrammer@asu.edu>

[BUG]
Mounting an image whose super block has an invalid sectorsize (for
example 4097) on a kernel with CONFIG_BTRFS_ASSERT=y triggers a BUG:

  BTRFS error (device loop0): invalid sectorsize 4097
  assertion failed: is_power_of_2(blocksize) &&
  blocksize >= BTRFS_MIN_BLOCKSIZE && blocksize <= BTRFS_MAX_BLOCKSIZE,
  in fs/btrfs/fs.c:137
  kernel BUG at fs/btrfs/fs.c:137!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:btrfs_supported_blocksize.cold (fs/btrfs/fs.c:137)
  Call Trace:
   btrfs_validate_super (fs/btrfs/disk-io.c:2525)
   open_ctree (fs/btrfs/disk-io.c:3507)
   btrfs_get_tree.cold (fs/btrfs/super.c:2133)
   vfs_get_tree (fs/super.c:1943)
   fc_mount (fs/namespace.c:1282)
   path_mount (fs/namespace.c:4337)
   __x64_sys_mount (fs/namespace.c:4542)

[CAUSE]
btrfs_validate_super() rejects the sectorsize because it is not a power
of 2, but it does not stop there: it goes on to report all invalid
fields.  The next check passes the same sectorsize to
btrfs_supported_blocksize(), which requires a validated value and
asserts it since commit d728f2e5f8a0 ("btrfs: simplify support block
size check").

[FIX]
Only check whether a sectorsize is supported after it passed the
validity check.  An invalid sectorsize is still rejected with -EINVAL,
and the misleading second message "sectorsize 4097 not yet supported"
is no longer printed.

This bug was found by fuzzing. The cause was analysed and the fix was
written with the help of an AI tool. Tested on btrfs for-next
(d6f76ca0a70d) and on v7.4-rc1, with KASAN and CONFIG_BTRFS_ASSERT=y:
without the fix, mounting the image hits the BUG above; with the fix,
the mount fails with -EINVAL and only "invalid sectorsize 4097" is
printed.
A crafted image (22 KiB, xz) and a C reproducer are available on request.

Fixes: d728f2e5f8a0 ("btrfs: simplify support block size check")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Siddharth Mishra <brightprogrammer@asu.edu>
---
 fs/btrfs/disk-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8e8fb942d..b348591f8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2520,9 +2520,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		     sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE)) {
 		btrfs_err(fs_info, "invalid sectorsize %u", sectorsize);
 		ret = -EINVAL;
-	}
-
-	if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
+	} else if (unlikely(!btrfs_supported_blocksize(sectorsize))) {
 		btrfs_err(fs_info,
 			"sectorsize %u not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);

base-commit: d6f76ca0a70d0c814731394a625ff0dc1feb390e
-- 
2.54.0

