Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361804;
	b=oAgunTiC4X1V0ZqZxKuYU7vBMrCQLAq2KnenwcZ3nZx39+SwjtiuBbqqh/LFiYPMOdi2
	 TRNliqz7TPL5YD+gJjDYwHgFftxBLY8DmHAq34Akfrm/dLJ9VoP4D1arSo0yiBAbGV2X7
	 kD0JSJLSXc357xlPHEu02nnR7+Rl5ilz6wDJiVaj5Tk3Msv5uYo0i5WCEWSQBeAJgBnxV
	 I+VGqLx85T55wYucewAfhTtOY4WnIzcP5zn3wiKY7qFaaY/bD0nWqkY1iOAM7FLXcAfcA
	 VhSLa551TvO57JRzL3ZlbCyurlhKFBFB0hYilg6dwEAjmXrS2xjdy6JYJiGIdTVRHVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=;
	b=NWocPhagOj8+yJMWnGaikixibxDqHBs+hI3fhp0fLDMRMAGKAy1/9cfTPK0u5p+yUFiC
	 j/vGOI1ZnV2Fi69Sm3VmCKpMO9jx0g32MRcQF0Vcv8x+FRPH4/jKlZmvpdW+fa9Yfwfuw
	 WnOO+QbQhLkkFmRg28TfCZwj4+s4ZqVJ8bEmMC04BjTfYcgSicHJw6ItdNYqubQkdQm2p
	 lZ8eHKOrR7EbLrO9QW/pVq1QxoovZ3MaNijC6eAEf51y4Wh6uAn5EmU/n5CUR607JvjLT
	 PiiP5XhG179Y8OGUzavcZBgR1MjR6/T3cnGV1OqX2orKKc6A5cKgBd9Tx1JbOjjBBbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=OGgpn4ff;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DF606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D6DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=OGgpn4ff
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b2d14968c9so22368687b3.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795361803; x=1795966603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=;
        b=OGgpn4ffKsw9DLMles/9pb5XkRT7KxzN583oIW4UHzqZDzoiG35zqdu4knwGMjzVtH
         levZfbOpDVJ4VYX7XV9iQkfjLQVaMcouCPjEb8soRphfDsOCNSZ5S8UQY2/rOwbQej+m
         dT+U1HYYUxl73PFiyEjt1ZYQ3/zkptvK9kzL7QkBfBpaywHqc73oYwpJ+XIsKBJ1cPNn
         wqyPY0zrkkVQotE3NVhv5bD2vIeTeRN8Y0TtQUB7o+/TElQfK+EKaSPkZYF5q4MxvCSy
         dju0tUrpeT6JdHtzdKea82LrQFyJ7hV/uIHQnGU1wbQK5dBvTSF/nQs3eVJkuJ8MU55Q
         jPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361803; x=1795966603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=;
        b=nhT1SqKlyFve4zy1sgpqpSfAESc3FpNLGaFSU8DQRBteMU4oFk9jSJi/L1ujAOoG+f
         YbqdA6wa2yzRwSAqvSJbZjYAy47vBZq2DYytaGseGHKiCoQOO3OEo5VBX2K0C1TDvkSa
         dIqwqUv30Z2wGHJ5awzn9rtVVjGU2646aT8AQrXt3XCE8Memevnlk810MVjp3GcQ58fy
         ywooH5NsfFtANEKOrNNW/Bxw5WFN5mJKT8DdQ//crEzcYJYtcxyEsbMSqojMH7N6Gqaq
         rvBvkVsMX56FH/VyATa3oDMLCmgoykCO5ZA4HN1KToEdedvb4S2tpV9oBPifvlfkjX8R
         LQGw==
X-Forwarded-Encrypted: i=1; AL+hErG2rUDVgIHKeXz81WSA5Ec1HXHVbx+GBBMNllX4Wf95bVnvUGEnoerq0YJPnBRfmH00n1DAd1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eQ2doYYcp8IQcey9EZXRO9Vv8fSaDAF/FSv3LcPAb0+R/6zOr
	BTW7RudYq7EvcJ7L+1MDZGgekNwZ5SUD5PCE1AEs8v72W2D1uv5RlyLygjyNs/WnPA==
X-Gm-Gg: AZFdTZf8LyLiyrobG8f5/GxzIppgPuK/36U0RovPN/YYXxxfN6WoPhWuTQr/c6PzNL6
	SR1YWcESxZEarFniAUFOH2p7BOmKy2Ik5GvHK7V4rYXlIqY8ikdKACENZ01wg2Voym3w63dD6OO
	kuQuEATU1eVJGg1bhhQ+khu8R/ZLboyJsEDMC40zqbEpkBC+0ez8JXXoRPuYg2xZNLGuWljhyca
	goRPHcsJT8EoZ/8yWwhaN//F5/yUYffrKQLR0IRMDwgTLjO5XN9TU0JDdvJepeAwzttKEzqNTjj
	5z2tArzG/KlAp5lQWjnGxysIt2OJzuUDbGVNWI51c5iTvCfhRUr+qyP7aYKS7wXkPtQpylOF6Rq
	TG3sqOp49nGEkXQolTt1rfN7PYKC6Q5VDmjeIbUusqre8akLQzBzsCQDmtLejg2qeDMQgwnN9rm
	GNq7EiHwqJXZl56NVAkwhYjd7rWATMaR9bAy3Cj2mOalqcByqgmkGY/X4eECPWTJafR128BB4Ds
	CBhMj1IOAmXjIivgn8PIrDiGhArZeWK/9Nun9OtLsgcHU+yX7y6FZFKZwLEjpHQ9p/myb8yMU5O
	nhA7wCvkxWVSwKYEDeW0B5kPAQx9iZN/ygfyVxRjCnnz6dOY0vKe
X-Received: by 2002:a05:690c:9b0c:b0:873:5c6b:a305 with SMTP id 00721157ae682-8b5204dab2emr36320217b3.51.1795361803007;
        Sun, 22 Nov 2026 07:36:43 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028d160sm36223427b3.10.2026.11.22.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:36:42 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Taerang Kim <kth5965@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to reject inline_data inode which has blocks
Date: Sun, 22 Nov 2026 10:36:36 -0500
Message-ID: <20261122153636.2731348-1-hengyul@cs.unc.edu>
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
Content-Transfer-Encoding: 8bit

Commit c240c87bcd44 ("f2fs: fix to do sanity check on blocks for
inline_data inode") made f2fs_sanity_check_inline_data() return false,
i.e. "sane", as soon as an inline_data inode has blocks or node ids.

However, the function returns true for a corrupted inode, and that
commit meant to detect exactly this state. The early return also skips
the older checks that reject inline_data on a directory and on a
compressed, encrypted or verity file. As of now, such an inode on a
corrupted image is loaded, and setting this one bit in i_inline of an
inode is enough for the following:

- unlink() of a small compressed file that owns one data block hits
  BUG_ON() in clear_inode(). With panic_on_oops=1 the machine panics.
  Otherwise the task is killed, and the file system can no longer be
  unmounted (EBUSY).
- unlink() of a larger compressed file succeeds, but the orphan inode
  cannot be evicted, and the next mount fails with EIO until fsck.f2fs
  repairs the image.
- A directory lists only 70 of its 300 entries, yet rmdir removes it
  once those 70 are deleted, and fsck.f2fs then finds the other 230
  inodes unreachable.

The issue can be reproduced with:

    mkfs.f2fs -q -f -O extra_attr,compression /dev/vda
    mount -t f2fs -o compress_algorithm=lz4 /dev/vda /mnt
    touch /mnt/f; chattr +c /mnt/f; echo hello > /mnt/f; sync
    ino=$(ls -i /mnt/f | awk '{print $1}'); umount /mnt
    blk=$(dump.f2fs -d 1 -i $ino /dev/vda |
          sed -n 's/.*nat_entry.block_addr *\[0x\(.*\)\]/\1/p')
    # i_inline 0x21 -> 0x23 (F2FS_INLINE_DATA)
    printf '\043' | dd of=/dev/vda bs=1 seek=$((0x$blk * 4096 + 3)) \
        conv=notrunc
    mount -t f2fs /dev/vda /mnt; rm /mnt/f

Before that commit, the result is:

    rm: can't stat '/mnt/f': Structure needs cleaning

After it, the result is:

    kernel BUG at fs/inode.c:776!

With this patch, the result is the same as before that commit.

This patch will make the check return true for an inline_data inode
which has blocks, as the message of that commit describes.

Fixes: c240c87bcd44 ("f2fs: fix to do sanity check on blocks for inline_data inode")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

I noticed afterwards that Taerang Kim pointed out the same early return
in this thread:
https://lore.kernel.org/linux-f2fs-devel/20260317152838.26664-1-kth5965@gmail.com/

Tested on f2fs dev (b61a029304bb) with KASAN and lockdep: the reproducer
above, the same file with F2FS_DATA_EXIST also set, a 5000-byte
compressed file, and a directory with the flag and 300 entries now fail
with -EUCLEAN at iget, without BUG, lost entries or a failed mount. On
healthy images made by v6.8, v6.18, dev with and without this patch,
and sload.f2fs (default; flexible inline xattr + compression;
noinline_data; noinline_xattr; sizes around MAX_INLINE_DATA, conversion
by append, truncate, mmap, O_DIRECT, fallocate and atomic write,
symlinks, xattr node blocks, compressed files, roll-forward recovery
after F2FS_IOC_SHUTDOWN), every file reads back unchanged and fsck.f2fs
reports no error. The f2fs/*
and the generic shutdown/log/metadata quick tests of fstests that can
run here give the same results with and without the patch.

 fs/f2fs/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 032c1cf8c615..2c50a72580af 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -54,7 +54,7 @@ bool f2fs_sanity_check_inline_data(struct inode *inode, struct f2fs_cached_block
 		return false;
 
 	if (inode_has_blocks(inode, ientry))
-		return false;
+		return true;
 
 	if (!support_inline_data(inode))
 		return true;

base-commit: b61a029304bb5531312ebc133b2a895d14dc3fee
-- 
2.53.0

