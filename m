Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C7374169
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727663; cv=none; b=RFz6QGMoD7AkSNpd2/gaKmbp8mu3oWkL67Zfuaqcq1LU+ACXBc6W6f7kasLtPlYjyOJ7euJ5vTBy+RfysEgw4xzHmcmpuIcXYBPQ9cmHiqLfVqiZ+hPRrKERZ9dmw7/Q14jJj7FAMxqUfg7FjybgR0MJywx+Ul8fhZkz04JvFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727663; c=relaxed/simple;
	bh=Jsn2r1uveXbUFYaD7Tectcn3uRJrKN6MuVwv/rRQ9e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3JLw4kWb2ENpkF1jDPsYKBqveITAOCbwOUuwY9Dm2p+KXfzi+JlasAI9sFwp6ZBJUtnMPv7pXtwIw0v+B+eHE1jyMTjwzuF24e4+UWxbCwz8HJgg+KgtdNb2B+VRpII8spTJT8t+wSzD4LQJ0dY5jTqT9qwzgUeUEv+5OPNwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4HDi/EV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4HDi/EV"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1920116a12.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727661; x=1786332461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYoOGjZWCQI6jE6FLVWCCG9hsc76kxEv4IGNCI27rDA=;
        b=W4HDi/EViFVwgJqt+YeTU6JoZ3MyI9Zg5Real9ezzDYLdwKBoetvzgCnNxZSTPGwXd
         trsQKNNU0z3WpCHuZ6oPAc6raUvHEHlvPBGW+vyH51lF6wBYFsip7a8gYa93nMHREie/
         5RMRBKU19v1kEK+kLuvSRPae4eOKl5m3y7LX9E1VVq2fElnfH+AoGibH5XpjwkQ2OtmF
         QiqyAA8DhzJKb06VDIZPQxswpsmBISQOiTjJVt9QtSbwcXKqR/nGSwVNOwxU/kzrBrVO
         tginxrlKYnJziOPPcEdzNv1HF7Dh19fOaTQTR+AnmAWvNhijR4Q2XkC0yQx6NPV3VMN5
         NxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727661; x=1786332461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYoOGjZWCQI6jE6FLVWCCG9hsc76kxEv4IGNCI27rDA=;
        b=s/PhpbD5DXi/lbq1E/ajvZxJFeLCfCpe997DrLyqbOGYnBP3d3WcP1bptCcE4Q04qM
         f4w1F4Jras8+ZRcMuUXcEgO45AMnkCNcmTWHWv7vXXeQv5D+vuYqnifs2YUt2px5rLp5
         aXrmvEcXpFnPa4dNO+C+qM97ftpxkohXMgJsO7eRMcnAnOE2XFzfBR9xkKVUUXcZkeEn
         SFJHWqHUubA/jUrHtsxZwUpE0j3sUgVCZUmPKHcz66f+jln/KVhvvl6GlmbRnVf0utVC
         e063CTuwwcdOAgAVfNuTEfQisufprv3f9YjgkWi2SjpMLHV2DJ9rjCux6u6qmHtBawIr
         MEpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxolVdJdO4/HiCPX+s502cwIHjF330nlSsobSXAtSxb4PIMP5JZSCClzm54ZlY4R96SanQ0s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMX4IN0YQ1Yia+sgbLezTlJ0gVgqK/0ltlCrZOitiaK2f92bvR
	70/4f+anfzgPxN8wdH1HbuuzVTLK9eKUT6f4U9xzZk/pgnmAUpbbjMqHvc71A1B160M=
X-Gm-Gg: AR+sD13JQ/aMYib/1dBgtev2HZbqHBreytIqvUo+Uo5LpaclWHw0CfWeiFzq7YsMZoQ
	VoRnPf00QH3uCNakJOwAQGfAicrQDN/IFKos98h9yOLLr69Z2wYc5nnOYUY1eiLZIDR/Rdj4r8h
	j+fu8mlGLTdpPlnGa4KolWMcq5FrSR0jl+qBggGg6OQ3QvHOM+HoKxyUfW/zszQ6HVcUzk1al5Q
	36hTSf8WIZM6s4FBx4Y9KgshKQtiSbwDZMa8pMLvkWBQ0b9Z67GNFAn87yHXB3atvAKEV441/iB
	fBMIAaO8eKzInaokgFVKQMJJhsUhLsEMBLyiT4YaOhphROpN0CNv4mWwW1iNYi4bqsWDL1H7VZj
	xTAEnfOXcyvu1rkh6It5WY3uaJD2ngaNtiytKCqpCzkOPeB3rpRKvjkdPHUyTPjX2BM8jcu2mgR
	fX3YUbX35NXipw880o8U9mPM7Z9ECNN3FM8mzdleTumA/BH04M114f/gzZ/krlywpNIzkOBBpoW
	F8MH31ebp4IQg==
X-Received: by 2002:a05:6a20:7348:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c92a58e834mr8230483637.26.1785727661332;
        Sun, 02 Aug 2026 20:27:41 -0700 (PDT)
Received: from localhost.localdomain ([113.23.46.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18d9c6sm33203673eec.30.2026.08.02.20.27.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 20:27:40 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: squashfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] squashfs: bound the fragment offset stored in an inode
Date: Mon,  3 Aug 2026 11:27:35 +0800
Message-ID: <20260803032735.81785-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the REG and LREG inode readers take the fragment offset verbatim
off disk:

	frag = le32_to_cpu(sqsh_ino->fragment);
	if (frag != SQUASHFS_INVALID_FRAG) {
		/*
		 * the file cannot have a fragment (tailend) and have a
		 * file size a multiple of the block size
		 */
		if ((inode->i_size & (msblk->block_size - 1)) == 0) { ... }
		frag_offset = le32_to_cpu(sqsh_ino->offset);
		...
	}
	...
	squashfs_i(inode)->fragment_offset = frag_offset;

The check added by commit 9ee94bfbe930 ("Squashfs: add additional inode
sanity checking") is about i_size, not about offset, and nothing else
looks at offset at all.  It reaches squashfs_copy_data() unchanged, for
instance from squashfs_readahead_fragment():

	bytes = squashfs_copy_data(addr, buffer, offset +
			squashfs_i(inode)->fragment_offset, avail);

where the parameter is a signed int:

	while (offset < entry->length) {
		void *buff = entry->data[offset / PAGE_SIZE]
				+ (offset % PAGE_SIZE);

An on-disk offset of 0x80000000 arrives as -2147483648, the loop guard
passes, and entry->data[-524288] is loaded from about 4 MiB below the
cache entry's page pointer array.

The tailend of the file has to lie inside the uncompressed fragment
block, and that block is at most msblk->block_size bytes, so check that
when the inode is read -- the offset is on-disk metadata and belongs
validated where it is parsed, not where it eventually faults.

Mounting a crafted image requires CAP_SYS_ADMIN in the initial user
namespace -- SquashFS is not FS_USERNS_MOUNT, so an unprivileged user in
a user namespace cannot mount one either.  The realistic threat model is
untrusted images: automounted removable media and udisks2, .snap and
AppImage style container images, mount -o loop from a setuid helper, and
any service that mounts a squashfs it did not build.  Note the trigger
is unprivileged and a read-only mount is enough: a single read() of the
crafted file by any user who can open it.

  # mksquashfs -noI -noD -noF -noX -b 4096 with one 1-byte file, then
  # rewrite that inode's fragment offset to 0x80000000
  mount -t squashfs -o ro /dev/loop0 /mnt
  cat /mnt/file

  BUG: KASAN: wild-memory-access in squashfs_copy_data+0xb8/0x158
  Read of size 8 at addr 007f0000c7b1a0a0 by task cat/132
   __asan_load8+0x84/0xd0
   squashfs_copy_data+0xb8/0x158
   squashfs_readahead+0x9b8/0xe60
   read_pages+0x134/0x550
   page_cache_ra_unbounded+0x264/0x540
   filemap_get_pages+0x1d0/0xaa0
   filemap_splice_read+0x248/0x548
   do_sendfile+0x540/0x618
   __arm64_sys_sendfile64+0x1f8/0x220
   el0t_64_sync+0x198/0x1a0
  Unable to handle kernel paging request at virtual address 007f0000c7b1a0a0
  ...
  Kernel panic - not syncing: Oops: Fatal exception

The KASAN report is immediately followed by a fatal page fault at the
same address, so this is not a sanitizer-only artefact: the same load
oopses on a kernel built without KASAN.  (The trace goes through
sendfile(2) because busybox cat uses it; the plain read(2) path reaches
the same squashfs_copy_data() through squashfs_readpage_fragment().)

mksquashfs packs tailends inside a single fragment block, so every image
it produces satisfies the new check.

Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 fs/squashfs/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 82b687414e65..4872b28f1b77 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -156,6 +156,16 @@ int squashfs_read_inode(struct inode *inode, long long
 				goto failed_read;
 			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
+			/*
+			 * the tailend has to lie within the uncompressed
+			 * fragment block, which is at most block_size bytes
+			 */
+			if (frag_offset +
+			    (inode->i_size & (msblk->block_size - 1)) >
+					msblk->block_size) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
 				err = frag_size;
@@ -212,6 +222,16 @@ int squashfs_read_inode(struct inode *inode, long long
 				goto failed_read;
 			}
 			frag_offset = le32_to_cpu(sqsh_ino->offset);
+			/*
+			 * the tailend has to lie within the uncompressed
+			 * fragment block, which is at most block_size bytes
+			 */
+			if (frag_offset +
+			    (inode->i_size & (msblk->block_size - 1)) >
+					msblk->block_size) {
+				err = -EINVAL;
+				goto failed_read;
+			}
 			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
 			if (frag_size < 0) {
 				err = frag_size;
--
2.51.0
