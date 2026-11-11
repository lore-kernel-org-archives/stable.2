Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404759;
	b=P1cCDjsbxcQDSWL3klxMYBwiCtMZMlhVIQdGbMfPy8YLhxyyNKgCOi34FtOY7jrHhVXC
	 EnOeIp1sTHC6WCPUCX5HMB+qNqRd6lo1ZQ+jqD5cFpSlxmdFyfT3UsLDny2dYMbQYyQ/0
	 iqDu5VBftxM2jH7mLU5VmMIr5Zg81DY4eLqJ3JX93SCmVLfZg0xOm7cP1ds7jOhH+zGi+
	 NupTR+GsJZv+FdcfgcmJDwi12Prj2lF+zuVddp9ESqs0fiOty/205itzdNmpWpY725ZTC
	 KK5bnXR//PAdnV0iJqEW1kajduMI7SK1C038sdfVb2RaLoe2Lz7NESJgz9anaynE2Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404759;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FVHJFSXeCNH8RWqBj1q3+g5gXcH5k/6fe8A7n9KZ+vY=;
	b=Dg+4Y9oCFiR2tHr4oth+hsXFVag5HLgRiqflU1/6mYy5ybbqzPjC6x3fnSEVQ9XAgAUz
	 VNZxVhcwBC2aiPLz7hTik+nzqREvtLyN3gNOErJC12FYcnY3cYk3Fu5Ww5eyfiK6I8o7F
	 WgOrDhFAtrBhv/ixnSxyw0tc9L5OL4hIgMDzXFLyl3tUchzP7H4WlPbiJVwlsDypUDVbr
	 2ljlGEwV/FU8QsWkXpKtP4jERVnlFQVd8l27FrDACdfALInx55Q5JcGjCXOFh93UmCrPr
	 u+Lm9oqNAZWQfTu5dld9Z7cvUElydaMWZ4VjuN2iH6LRJu2zWB59HnAskQUw9s80bfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPpu49zy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A929606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPpu49zy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5251F00A07;
	Wed, 11 Nov 2026 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404759;
	bh=FVHJFSXeCNH8RWqBj1q3+g5gXcH5k/6fe8A7n9KZ+vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPpu49zy00Cs8CiZplyUxwtOlJ+yrPv7DP5MQR2SqosTh3tEsQznLeshQqH6olNET
	 BVh/+EjhCGnad4eijc/DDpTDJiJhzM58XnN3quXqx6wO+0j4HA8ldn1iahpQ5yLmTR
	 0mdilhx4oLv5qzb5PTna7y/ugwa1xxxUV8dcvLXBf6nNv6XbfQEbiOA4aUGLxGc+hX
	 9K8pY7zWIyFVHuJwXomTmpJ6QhcshMAAyyj0yu3MMdwGtyNiOz9BrDggyjqwuwilP3
	 OH0IsHux5mgvYZ0EZmfcmnDr+Q9j5t7k9l5yPSp0r+wPZGwuRxDYBwSArBEoHSjoD9
	 4myHvVzx6U8HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sean Greenslade <sean@seangreenslade.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ext4: avoid updating the superblock on a r/o mount if not needed
Date: Wed, 11 Nov 2026 08:45:55 -0500
Message-ID: <20261111134523.2064738-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111134523.2064738-1-sashal@kernel.org>
References: <20261107060307-failed-5.15-e1a881ea4674@kernel.org>
 <20261111134523.2064738-1-sashal@kernel.org>
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

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 2ef6c32a914b85217b44a0a2418e830e520b085e ]

This was noticed by a user who noticied that the mtime of a file
backing a loopback device was getting bumped when the loopback device
is mounted read/only.  Note: This doesn't show up when doing a
loopback mount of a file directly, via "mount -o ro /tmp/foo.img
/mnt", since the loop device is set read-only when mount automatically
creates loop device.  However, this is noticeable for a LUKS loop
device like this:

% cryptsetup luksOpen /tmp/foo.img test
% mount -o ro /dev/loop0 /mnt ; umount /mnt

or, if LUKS is not in use, if the user manually creates the loop
device like this:

% losetup /dev/loop0 /tmp/foo.img
% mount -o ro /dev/loop0 /mnt ; umount /mnt

The modified mtime causes rsync to do a rolling checksum scan of the
file on the local and remote side, incrementally increasing the time
to rsync the not-modified-but-touched image file.

Fixes: eee00237fa5e ("ext4: commit super block if fs record error when journal record without error")
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/ZIauBR7YiV3rVAHL@glitch
Reported-by: Sean Greenslade <sean@seangreenslade.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: e1a881ea4674 ("ext4: fix fast commit replay failing on a read-only mount")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ae0509f6936e8..0a4ca26ed11f9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5400,19 +5400,27 @@ static int ext4_load_journal(struct super_block *sb,
 		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err) {
 		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
+		__le16 orig_state;
+		bool changed = false;
 
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
 		err = jbd2_journal_load(journal);
-		if (save)
+		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
+				   save, EXT4_S_ERR_LEN)) {
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
+			changed = true;
+		}
 		kfree(save);
+		orig_state = es->s_state;
 		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
 					   EXT4_ERROR_FS);
+		if (orig_state != es->s_state)
+			changed = true;
 		/* Write out restored error information to the superblock */
-		if (!bdev_read_only(sb->s_bdev)) {
+		if (changed && !really_read_only) {
 			int err2;
 			err2 = ext4_commit_super(sb);
 			err = err ? : err2;
-- 
2.53.0

