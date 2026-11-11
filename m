Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404387;
	b=JYmxq+AdAFs3SXps9dzGDvAJT3xfAMdu3Ng4ypnuR/AypidU8hGRc/unPJ2Jzy/YkTEH
	 VoARTMUlJ8GvkFdchBv6UrI5cjbqfvdSpoe61DXXXBQPLa5A5WEAuzZAFMRpY0oOWs+cV
	 9CTQXQOOmVSsM+TkIuph0PzAS8Tgh5YK0zHbqElunHreSCxQVxgHbufAsFSFrz7X2Tm/A
	 5EQ9955MgatWXWyJXVQJBqXQWj4N+FQQ6m6GW7QzgJnixuqtVHGLdGZ4w80KtJprPCqAS
	 xVTwdnQdvA8zQ5Qz9aCc7zFH2BrL/x8xsmmWJ4vcuCWXBlOEPAMbWwR0Z9bI06dUzfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404387;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/JeRfJS6Oxz51j4WfSRazZqu22tqtbAnR5i6CqB4/EU=;
	b=YEExJUw2VWpQM2ozEe3+qkgFOXQHUry/Zs4Xgl8gJc9FTyJu0KN/BkFboftxO19XMlcc
	 ICENbg3Cim/SvhEHo6f7u0sw1OmZQox7F085GDpIuuejEvAv2MiukwrAVdOx1LmJOyvEm
	 ydaZ0qLY1R2X+siaCQAMZS+IJnUjODZFixTv55kYow2JKlb+WucLmMKktf6GmhQwyIbLw
	 RsNWQcng+qI/pTaczz5MU6y3vUXEjqSeZ3w3Nz4Zb7qsKbicFcGoggxvtHMzP8+4/1Tfx
	 YT+1gt2pikMl7zrkndNBSkKMUgoKncnElPJt9bgrAKKkRtOGtKJDCkC3+Sz0dOhqyww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ye5q2alm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409E606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ye5q2alm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0571F00A05;
	Wed, 11 Nov 2026 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404387;
	bh=/JeRfJS6Oxz51j4WfSRazZqu22tqtbAnR5i6CqB4/EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ye5q2almZLfPP/Ac+QVv1dH6UnKRx+NSu/xiPeISG64podbWWDJ9XDH1Zfv/3hOVf
	 5fIgL8QwVZ1MoSPjrtdGHCJwVb4LpT/DQHUb6v67QE0aU8PYHWBzxL6uZaTYhqsno1
	 EuZjGNXInHpO7rddNfSofY7fxx6ZsKzRMPakdTzdQtrkbyOe9SeAOI5tlQAVkNNOjY
	 5OinG7xSsnHd+2L2NQbNBa7D7Qk1e4fQVMvTZ/zTxC1n8z+CRc7/v2stbEH2mq+CQS
	 RNv5YHQclor2BjAtQAxphxoDl69WKqlbZP76yLVpkTFomGYGKRaICytTzMQ8+qs5x9
	 Iu/EaJ0xpYhxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ext4: commit super block if fs record error when journal record without error
Date: Wed, 11 Nov 2026 08:39:43 -0500
Message-ID: <20261111133858.1650548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054548-failed-6.1-e1a881ea4674@kernel.org>
References: <20261107054548-failed-6.1-e1a881ea4674@kernel.org>
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

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit eee00237fa5ec8f704f7323b54e48cc34e2d9168 ]

Now, 'es->s_state' maybe covered by recover journal. And journal errno
maybe not recorded in journal sb as IO error. ext4_update_super() only
update error information when 'sbi->s_add_error_count' large than zero.
Then 'EXT4_ERROR_FS' flag maybe lost.
To solve above issue just recover 'es->s_state' error flag after journal
replay like error info.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230307061703.245965-2-yebin@huaweicloud.com
Stable-dep-of: e1a881ea4674 ("ext4: fix fast commit replay failing on a read-only mount")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fa6d9260030aa..7f2c5df730219 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6005,6 +6005,7 @@ static int ext4_load_journal(struct super_block *sb,
 		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err) {
 		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
+
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
@@ -6013,6 +6014,14 @@ static int ext4_load_journal(struct super_block *sb,
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
 		kfree(save);
+		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
+					   EXT4_ERROR_FS);
+		/* Write out restored error information to the superblock */
+		if (!bdev_read_only(sb->s_bdev)) {
+			int err2;
+			err2 = ext4_commit_super(sb);
+			err = err ? : err2;
+		}
 	}
 
 	if (err) {
-- 
2.53.0

