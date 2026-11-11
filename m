Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404388;
	b=p/WoBg7ekms/n28MqYF8DEQA6Mli9x2zeFMuJ7jqL4DE8LpH+5hOeD7CfYLVPwc1GSUu
	 Wc1q5VRfOHyOkxR402l0LlsjIZnrW+jIJksbqOc3fZvLHFRrld/MC8JfIoDTfzf82DhE8
	 8zBElRVyaTguNupBxcdROpVk7APu9Y8EjC+GLFim94unZYD9bN1HWkczJSwMjPCuxXtGo
	 eh6gjEcEGPY2sJqlLFXrcXP2e95XOzMhc21Pe344Kl+lmy3PMejx0ocpSsPTYK1KoYnEX
	 nJEVasGWD5mpit55zwCakKowdDh8pmwtVWR7K3wHYA65Qqvby+LM0t62W02E8pcWlmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cfak1+NTRpEorLLR3UJO9xQhpvZlJqdMCf72TYWl/fw=;
	b=ve1QJw4MqZYBWoAUVUCopyq48Owj75hnWrjMCLI3E+emZPMkaCPwUaa5yWMCbt7FC4US
	 sE1fu1iiLkVlVHN10yPbU+WgqRdF5rAo3DA0pBa7VEN141xFFSazQkX4O37oJb/3siVUI
	 Lf4KmuwBKCEHDZOfG6BByawr5heOGfPPdSXfljk2jargx2vOegGvJzonvEcmr+6x75ln8
	 RD1NGV/078+2+k9VE5cf1qbtCLkG+J2bnyPZ7afvI9wctelUaLbxtkkJGV7qol8VGvSga
	 4medkhltyeqHoM4EWxyBiiTDQi4JCIAjKsBeDjo35VPtjrJxkh8WsHxfu3rx2Ztme8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N32F3a29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F072606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N32F3a29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960431F00A06;
	Wed, 11 Nov 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404388;
	bh=Cfak1+NTRpEorLLR3UJO9xQhpvZlJqdMCf72TYWl/fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N32F3a29BcB97EiftsLHgK8VauwogH6krK4iNCM5IaiDpQ507iuwU0UBlegGVVh8M
	 pkztR5bOkBYYttxvsIsQs1PkyBpWxL6tNXn+porTB8IFgZydQsB2SFKCAYpMXWqbjU
	 L6PUVIwd6jHKfbQr3WG9nAnIXhkTUEYmhfpFk8wp7iJlNkxaFxEKz86AKwwqOjzodT
	 Hj7f7MQY6GpqdECInS0LJ83sxyDDGWAgMtR65R7Ecv1PapKCfVWXA09hXSgz6XhTIW
	 v1JsxWD7AZH0R7S+yub/Ls87eaAAyNNp+sriRM/POKUn2C4up6W1rKhrdNS5S3kYPG
	 Of2w0rxg38njw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sean Greenslade <sean@seangreenslade.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ext4: avoid updating the superblock on a r/o mount if not needed
Date: Wed, 11 Nov 2026 08:39:44 -0500
Message-ID: <20261111133858.1650548-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111133858.1650548-1-sashal@kernel.org>
References: <20261107054548-failed-6.1-e1a881ea4674@kernel.org>
 <20261111133858.1650548-1-sashal@kernel.org>
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
index 7f2c5df730219..acaaa0218f22d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6005,19 +6005,27 @@ static int ext4_load_journal(struct super_block *sb,
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

