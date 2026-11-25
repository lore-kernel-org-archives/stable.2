Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617529;
	b=dq1j+IJHy9Pcy/R4gX9GfX8O7/WmfzES7+aAqjtjjlVRymho/duRemBpvv9n23WhGwbJ
	 7+8fsgOFy4vA1KTFW9H6ZBruZjlXLePE+Y9HbEu6FSUDRNGrJcODbu9usVnAwUPdQLUY4
	 GLRUCYKd+8q4UpF5kfmOebZEyvomoY5CjVfJ8abdExjQvaMPN87DioLmsNQP+eQEFPPmC
	 ewzF/QiZ2rytzzRsZri2452loLlirWxZO8V6hpG0ylrt0EfQmT8Y2LLTRZpitNCeJq8w6
	 zegPemPQp6xIVO+mh82roCJKX+R/PjEWkwlaDmHUlufb6ds1WuT+u33mKD1CWl5iY7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KCNbPva4mF5XpGmktWSlUa7O0FkwlEdc1yHh6KRJCrU=;
	b=gHZIibp3smOpdCadA4fb6lVYu1ZddF6eO30/mqer8IJzAUNMAuPznOGBV8T1DTzK+KEF
	 REzc5VdQfXRZYyU193JIVXyQGipCpj32grP2HDQ4G6ZTvqu//2Z8qLot7WpjVx7J2oiH8
	 RzNprK3zDYZsXMagRMX6PXhRagy2nVCoW1IiCK8NVjYHijYkZx+75Y4+PwJ4RdvfyF1Xd
	 hwEMcSKPSGm6527ZBuFIVMKh6grltjr5pfqjTu3QSpd2JEMc3YN7fPc5p5J2qeOTNZ6J3
	 FI6wf326dyk7YEdk03DLvJu1AOoaZj6wHo8wop6GBS32MMyvnH8OQZAkghIGyxOqMCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=e2b.dev;
	spf=pass smtp.mailfrom=e2b.dev;
	dkim=pass header.d=e2b.dev header.i=@e2b.dev header.a=rsa-sha256 header.s=google header.b=X9nev+gb;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B207606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B207606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=e2b.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e2b.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e2b.dev header.i=@e2b.dev header.a=rsa-sha256 header.s=google header.b=X9nev+gb
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so47241905e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=e2b.dev; s=google; t=1795617528; x=1796222328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCNbPva4mF5XpGmktWSlUa7O0FkwlEdc1yHh6KRJCrU=;
        b=X9nev+gb29dK/PZhEUG0om2mx2tvAWC8Drd9Ue/pqjwJmae7sCJYZfqPIJx54is2kD
         m60KFv5wCeweYOM+cOUhZN8DC7OWm6yqx/sF1/Yq+KcUGNmVwC76TAxeeyzYFZG2tUm/
         BhoBl6rop+Rcsv8ogi0XJ569w8OFy77gCm/PFyzCcc9UbnkwrZ5whLvgAQRIIDr16Hz+
         KR+3bo6ZnG0fJUB8xCIa/7xox/jN3dyrL6q3exf8Uy5140xe277hUxIpdh+jc2k349IQ
         EzWfbVK/yfWYvDBqVAPbWJjpNZAZrA3W0L9oasgX1+FVuD8pZYE6wRndFE1BSbDqT4P7
         94UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617528; x=1796222328;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KCNbPva4mF5XpGmktWSlUa7O0FkwlEdc1yHh6KRJCrU=;
        b=IQG6FH5/R0YdgAMaM5wMpi/xpContggHyLfjaGj0ExqFtw9xUaOobyZximyY9E60wv
         0pimwg/piRjK/1MjMM9PnLdh81gg05UUhvthARj3yj8nQFXvj3slRX3bSj8i7Cvi/XVt
         kDlRu81qoITsXmli0VWdRn2HEjRcz+CWBNP8rbCpifmWni4k4rpJLH1OQNOLqC+/u2Gu
         COewnQwtRlD3gRCuaiu9AytQ+XnLUVugzC2+YL0FSJh3uSsf0Ipnl1IGKhelNLBC4LW6
         G81kbBqPh0RQi1bjMopgkz3XkwaZtzAoa4BxALWNBIVnfoj8G5jQvSq8amydFNNoJkRh
         dstA==
X-Forwarded-Encrypted: i=1; AL+hErGT0SL/OFznDRCjESQZe9d64xV7INYG8FwHsQ4KHkA4SvdqOv3bGg0GJWdnMePM4Y6soNxq1uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/X6i1cDacA7C0Ja/WohlW8jljA8lG1tCFhrDnbScZOhug7NH1r
	LFAmy8kO0vktq2PLRmPVPwqbqwyAM3MODjfsch+hBSmziHXJF/Xf3BFgABNiK4qWpW4=
X-Gm-Gg: AZFdTZdNiq8y6e+0NWmt3422e5iuoTPtmVXNXB7KaV0fBYweMXyQzPyVBvaY6fatVNe
	ZqVn/19Cwy446Qg3oJyqKPBlysTtpqrKTO5SMUlRPbYCDP0ugaParadnPzm3waOP2+EmMbhtIBM
	vGzsMj4xKvWwnmDTxU8ERrmRqeV4z0AH8P3sbd5lOeFyadRzzBSx3yr/+CfBowTadqW9J5GQoMc
	rcNNxA9xCIRUmRFau0ZCp5DY9H97R/ZJs+hu1cmSbOYKbGMzJLHEM1K634ps+6gPOiSlDIgv2iT
	E+xx152Ltmpy9dAyrvhMvNvgnHm8lLsF7LXhxk4T+uVLVD5O9DXr3rCByo4INWUG9snXVUf05iW
	1s29QO6shZmt5gK9tOTAtRzzRPJ0ovEv6atAdK5mu4QIuWLwR+ikBE0/AhAhIdmzxQRssGOD16n
	xz1F23TnffI+IdRJDPEj1Kgky/GhhOHBVM04qbPq+R4GqcBndNlQHA1NagUOaVUZNWy19GNFGIx
	MwpocMTPUL9sxhf0A3DwtSPU5v5XXdJRl1n950AweMTgvuaQMiUACwuKxgrqQMjGkL8AwpNbmE8
	tchfk8zEWuHVAtH08nLsuUG0PyDOmlV3O5Hv8M2VHFjiavM5y3U=
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb887c33f7mr352292285e9.4.1795617527720;
        Wed, 25 Nov 2026 06:38:47 -0800 (PST)
Received: from fedora.sphynx-tuna.ts.net ([2001:1ae9:6617:a200:4752:c78a:bea5:1bc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm491648735e9.8.2026.11.25.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:38:47 -0800 (PST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <petr.vanek@e2b.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>
Cc: =?UTF-8?q?Petr=20Van=C4=9Bk?= <petr.vanek@e2b.dev>,
	stable@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: recompute the inode checksum after restoring inline data
Date: Wed, 25 Nov 2026 15:38:39 +0100
Message-ID: <20261125143841.928615-1-petr.vanek@e2b.dev>
X-Mailer: git-send-email 2.56.1
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

ext4_restore_inline_data() recreates the system.data xattr with
ext4_create_inline_data(), which marks the inode dirty and so sets its
checksum, and only then copies the saved bytes into the raw inode with
ext4_write_inline_data().  Unless something dirties the inode again
before it is written out, the inode reaches the disk with a checksum
that does not match its contents.

Failed inline data conversions take this path, for example an mmap write
to a small inline file on a full filesystem:

  mkfs.ext4 -O inline_data /dev/vdb 64M
  mount /dev/vdb /mnt
  xfs_io -f -c "pwrite -S 0x61 0 42" /mnt/small
  xfs_io -f -c "falloc 0 64m" /mnt/fill                # ENOSPC, fs is full
  xfs_io -c "mmap -rw 0 42" -c "mwrite 0 1" /mnt/small # SIGBUS
  umount /mnt; mount /dev/vdb /mnt
  cat /mnt/small                                       # EBADMSG

The read after the remount fails with:

  [    1.203967] EXT4-fs error (device vdb): ext4_lookup:1635: inode #4097: comm cat: iget: checksum invalid

Mark the inode dirty again after ext4_write_inline_data(), so the
checksum written to disk covers the restored data.

The Fixes tag is based on code analysis: ext4_restore_inline_data() has
called ext4_create_inline_data() before ext4_write_inline_data() since
that commit.  The failure reproduces on v5.19 and later; older kernels
were not tested.

Fixes: 3c47d54170b6 ("ext4: let add_dir_entry handle inline data properly")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Vaněk <petr.vanek@e2b.dev>
---
This patch was developed with the help of an AI coding assistant
(Claude Opus via OpenCode).  It analysed the bug, wrote the fix and the
changelog, and built the QEMU test setup; I reviewed the change and the
test results.

Tested with the reproducer above in QEMU (x86_64, KASAN and lockdep
enabled) on 7.4-rc5 with and without the patch; e2fsck is clean after
the patched run.  Not tested: xfstests, other architectures.

 fs/ext4/inline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index acdc65ce47960..360c06441c8f1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1111,6 +1111,8 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 	}
 	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+	/* Update the inode checksum to cover the restored data. */
+	ext4_mark_inode_dirty(handle, inode);
 }
 
 struct buffer_head *ext4_inline_getblk(struct super_block *sb,
-- 
2.56.1

