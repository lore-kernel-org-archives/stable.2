Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404758;
	b=UhW+PSibQRvx0iV+kkX9GS+l3TIZMdz1gwpu6Mtoo4d2AjMBdN5h4+4FTn4N7NO0UQ81
	 w9lKOBfhzX9lVB8IOPvymlpFnlYO02eDPkkKi8wkBxyCM5MJ5jL5JNQD+IPDiQmAyrGzk
	 FjfzDsLKdFfD0c66xQosU80VZpYMO33FEWYRsM4smBLxbSc2Lg4buXiXyEKuqX6qSJm2k
	 JUXN5QeBuDZshG0Suo0MsINUVWCW4dEUSfT52k81QVXm2LayokdrImNQ3LGU6GYj/blpJ
	 6ixWKgJCXPq3b2Gnslv7sl/76p6LfloFkEL4VCtkRZoDHrvG3RDXUhFfHCcMeObKfhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DYIun7Og7Grxb0CUQI9i6cbed8WFV6IK7ow4l60LsJI=;
	b=wAQnA9ZP1+5gAuZY5L/souOMtDjuIKD6dW3LrD23OVIfBxouRS8Yog3bx/zCtnzxlwol
	 eHXFKA+twfQaywjoo1rOT5I3vXPnHZ7FUnSZ+YkirUbwat2DtAgrL+R0nMniDewBdJ0dA
	 kAo7bS0TeyZWY2S99Pr3jBQ0XpjHiVXn/KtxHd0CkONh4nCvqwpeaBHaK1Tbr9ytgqO6X
	 AsRct/FAtrAK5yjxZHS7Ts6SfN4BhKN0B5tGzPkl4UQmRX0kRvIWNh8YA1G5vSt1V9x+F
	 mjtc8vb1i9C+J6quVm4j+AeteyRt+QmHX+Sw9E7KEr3JY6fYir6oxLmGUYim5p1jE9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8t1aYW0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C6606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8t1aYW0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA951F00A05;
	Wed, 11 Nov 2026 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404758;
	bh=DYIun7Og7Grxb0CUQI9i6cbed8WFV6IK7ow4l60LsJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8t1aYW0iChdjDzmbFXAghBZDsqbq1bTbIiFRt7IhKdFG8TfeOTTXDnmipYMGHr7a
	 gRgnc5UCBWg0w8brSTkfG9jzDKxW4/5DAuFXrV69qWCvBUj/Z7SgXWk+N+VvkvYphV
	 alsg8/LDg1LGxZkpF6fKluqtxC0Uy673sBQST4byGpJSqmFYPArplyEV8w44p8B9B4
	 Je1rkOlMf1cMKaQWkrc/wFgvgRfnWXdbmx+FSvGBP6YPOewhMgoD2rYiH+B/0FcT8V
	 htPj8q5BJQ6+lUGcL4AhPHd6P5K6SMUHJRRIZgVE3p9d0PTuSVnJhbLgOEw30BzKQu
	 K1UJfAgub9Plw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ext4: commit super block if fs record error when journal record without error
Date: Wed, 11 Nov 2026 08:45:54 -0500
Message-ID: <20261111134523.2064738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060307-failed-5.15-e1a881ea4674@kernel.org>
References: <20261107060307-failed-5.15-e1a881ea4674@kernel.org>
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
index c89e460180b82..ae0509f6936e8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5400,6 +5400,7 @@ static int ext4_load_journal(struct super_block *sb,
 		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err) {
 		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
+
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
@@ -5408,6 +5409,14 @@ static int ext4_load_journal(struct super_block *sb,
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

