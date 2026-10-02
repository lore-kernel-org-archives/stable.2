Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D134BB815;
	Fri,  2 Oct 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949234; cv=none; b=VLU4djuZe6LBuw+nvbvP49Uz84SP0RzT2Y6JiB8dwD7lzr9INPUMFA3xxPbDy8N7OV63J9KWuuzXzFfA5+6DVF0Kgq9rX2A/phG0vX7cyPgxNx7vcS8HTaGb2StZZ1XR2M+Chrx1FP0r1K+0GWFmRC0z0eJkqSn8peJg1Ap2Yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949234; c=relaxed/simple;
	bh=+FvIqvJ5eUkvX7+ZBqHA0vXyLd0RLiLhFoX+5fW74UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRbdt98pz3AQ8vclIo57OLn9g4EdEynvpwrF+lt8PAf5OsHcbryTbk2lZz0HWJH5EMXqK8t4MFz1C2VhPW8QNsb3Bjyu9ohdjuljMYmASOewX0tex+yVagmgEoFJjVXXW3pgvFw5WrSEFChkLBpDlGHtK3L55UDp4IcIVy+mWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6E0sWiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6E0sWiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4251F000FF;
	Fri,  2 Oct 2026 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949233;
	bh=ped27erg+ZoqpxdgtlkvsBMPfMUfdwEp5q/fNTxaAFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I6E0sWiZ1Sr1wR9uhJd6TbiHTaljL3RnCMunVMH4R0zf0V4uuXIi7/kt0ywtt2zFY
	 h7XMrpdZFZTNcCdBEaLOSWIeE8ZdzNsAtRmLqS44INzlf8Yp55rw8bYMmnU/C0wH6t
	 Kt+q1E4SdZZEmMuUkbTj9bYyamHCUYyvCYOFumGX6ooTkbWcEgfqMo4m1F8bKZVgOy
	 w8BGenPHFOO6Hw9B1DRdSXc64MtzdnJB1Pxw1Y3s47SL/idLqFqeEFsMz92B/y1Zn/
	 0KoPMSk3eDPIZwZa4EOmJc+Ffbch11oYaErVaAOBn9Y8Mm1udewRIUT/uCEma9NukN
	 Ry1vkdp4SWuNA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:38 +0200
Subject: [PATCH 07/21] nullfs: don't update the access time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-7-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+FvIqvJ5eUkvX7+ZBqHA0vXyLd0RLiLhFoX+5fW74UU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x6ZWV5+K61rlt9qj485TbXRtjdiTL4+ac2XsmZtX
 5R9YoVfRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQWGzEyrC2vefu3RqF1joJw
 pq31nCKWB3/rtyeFHKtt2tV67o6kJSPDnFcGv+6Y1+lyVoc+n/LxzSTTz43uYY8YiifGz/33vSa
 YHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no point in updating access times of the nullfs instance. Raise
S_IMMUTABLE.

Fixes: 9d4e752a24f7 ("namespace: allow creating empty mount namespaces")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nullfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index e06352c7b2cc..40aa228bd81a 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -32,8 +32,8 @@ static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	make_empty_dir_inode(inode);
 	simple_inode_init_ts(inode);
 	inode->i_ino	= 1;
-	/* ... and immutable. */
-	inode->i_flags |= S_IMMUTABLE;
+	/* ... and immutable, reading it leaves no trace either. */
+	inode->i_flags |= S_IMMUTABLE | S_NOATIME;
 
 	s->s_root = d_make_root(inode);
 	if (!s->s_root)

-- 
2.53.0

