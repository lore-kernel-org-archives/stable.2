Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026814E80B5;
	Tue, 13 Oct 2026 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892178; cv=none; b=Qw7ghtPAKcpggK0Od/EimxbSwp000CBpg4R0j6Pl46RqIrR2Q4JWZ6pZetxtEC8kW1GecOYZBwpKHyB5PX+9QUZNmF/ct6j3u2wWxNzpQvQ41Vj0ckaLbW9B54OmoBashzxl4WZ7/y4ja0bcLePoeBYc8wZwcUW055gZSj9Ym5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892178; c=relaxed/simple;
	bh=Cte5O82E4/8bFHVFurW8q0kZBNGKBHzylnYtAdWodvo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+HG5T42L6NFzQQl8KkEXT+dgi126R5/l/+ncwml3NY68abiGnOCdT7MTEPzQpjF2ax220OOqMSi3n9DfmiFqS43yD423iCP36YdrMMysOBCNkeFYn3q+VyiAkYparuAgpmfqykVze2KBGNLby3+IPCajHaNIo6cfdp+z9zAiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=IEHgFf4s; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="IEHgFf4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791892177; x=1823428177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d1/3CR8iNFzg6a+c2iFJKHRtJ9jB+pXXqdrPAFY9eqQ=;
  b=IEHgFf4sXEs0mwu3nmMjcO9xXMlEiL7jZ1K5OEZPR6qN63nahf9Ot8Sf
   /vyLcok3FyyUM0MV1NF/ggnZzEQ3idMpNKiziHMxf80TVJJV/1sed+wPj
   z4HqtPfrSusb+YazQDyUQqL9Ns+ahY0lMoTXzIa+bt3EiTgFUbGILdWy1
   lEMWrapUYoIKhVi2Nl2qgokhPB7DQhlI4/GfB49/Nj7DqtJY8Z2C0xOw9
   RbcXb5Q7TDG7zNai7etBivbMpvhT0XN/AlZjS38ryx0xKQEbxnE6ZFfiK
   ET610FJcw7jwm3UeDQnhJM3iuPxBZKjWcyIGB4Nk7+moWEN69G8z6FSAU
   A==;
X-CSE-ConnectionGUID: +hVgvGnySviiWalscu6ICg==
X-CSE-MsgGUID: A66rsOw7TTWNZ0M0YLN++w==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; 
   d="scan'208";a="30918700"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:49:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:24991]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.91:2525] with esmtp (Farcaster)
 id d5f6198b-e63f-4fd2-a0c5-44c5a33f4cee; Tue, 13 Oct 2026 11:49:34 +0000 (UTC)
X-Farcaster-Flow-ID: d5f6198b-e63f-4fd2-a0c5-44c5a33f4cee
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 11:49:33 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Tue, 13 Oct 2026
 11:49:31 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <linux-erofs@lists.ozlabs.org>
CC: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Hongbo Li <hongbohbli@tencent.com>, Chunhai Guo
	<guochunhai@vivo.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH] erofs: use on-disk blkszbits for lz4 max pcluster bound
Date: Tue, 13 Oct 2026 11:48:52 +0000
Message-ID: <20261013114852.174175-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

z_erofs_load_lz4_config() rejects a valid LZ4 image when the kernel's
page size differs from the image's block size. It bounds the on-disk
max_pclusterblks with erofs_blknr(sb, Z_EROFS_PCLUSTER_MAX_SIZE), which
expands to Z_EROFS_PCLUSTER_MAX_SIZE >> sb->s_blocksize_bits.

At the point this runs, sb->s_blocksize_bits still holds PAGE_SHIFT:
erofs_fc_fill_super() seeds s_blocksize_bits to PAGE_SHIFT before
reading the superblock, and only corrects it down to the on-disk
blkszbits after erofs_read_superblock() returns. The LZ4 config is
parsed inside erofs_read_superblock(), before that correction, so the
bound is computed with the wrong shift.

On a 64K-page kernel mounting a 4K-block image (e.g. one built with
mkfs.erofs -C 262144 on a 4K-page host), the bound evaluates to
1 MiB >> 16 = 16 blocks instead of the correct 1 MiB >> 12 = 256
blocks. The image's legitimate max_pclusterblks of 64 then fails the
check, mount returns -EINVAL, and booting from such an image as the
root filesystem panics:

  erofs (device dm-0): too large lz4 pclusterblks 64
  Kernel panic - not syncing: VFS: Unable to mount root fs

sbi->blkszbits already holds the on-disk block size at this point, so
compute the bound from it directly. This makes the check independent of
the host page size and of superblock-parse ordering.

commit 3acea5fc3354 ("erofs: avoid hardcoded blocksize for subpage block
support") already handled the same ordering hazard for the superblock
checksum path by using sbi->blkszbits in erofs_superblock_csum_verify();
the lz4 config path was missed.

Fixes: 3acea5fc3354 ("erofs: avoid hardcoded blocksize for subpage block support")
Cc: stable@vger.kernel.org
Assisted-by: Kirocrew:gpt-5.6-sol
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---

Tested on arm64 (Graviton) with CONFIG_ARM64_64K_PAGES=y (64K pages),
mounting an LZ4 EROFS image built on a 4K-page host with 4K blocks and a
large pcluster (mkfs.erofs -zlz4 -C 262144 -b 4096, max_pclusterblks=64):

  - Before: mount fails, dmesg "erofs: too large lz4 pclusterblks 64".
  - After:  mounts cleanly; file contents verified byte-for-byte.

A 4K-page kernel mounts the same image before and after (no regression).

 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 3c54e95964c9..00055d103da9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -27,7 +27,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
 		if (!sbi->lz4.max_pclusterblks) {
 			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
 		} else if (sbi->lz4.max_pclusterblks >
-			   erofs_blknr(sb, Z_EROFS_PCLUSTER_MAX_SIZE)) {
+			   Z_EROFS_PCLUSTER_MAX_SIZE >> sbi->blkszbits) {
 			erofs_err(sb, "too large lz4 pclusterblks %u",
 				  sbi->lz4.max_pclusterblks);
 			return -EINVAL;
-- 
2.50.1

