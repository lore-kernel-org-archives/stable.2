Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719009;
	b=BJG8LxnK6jq3kbph5UITG3aUmDpqNigdepEir10lkjtIxtSsQZ9YDo5bElRNXvvY7yy3
	 0H9x2XmBGYc/0MHSItzi1H+TKnrWn/gnASINfeiZ6PAsObLJTaMJS2GpMSM68bQ4heJjX
	 tOaLA41AwH8XmiDssAYAzqgWPpO4oxSS5IRjXUF9wrLGeuik192Z0ZOiDxtOSFv17kWkX
	 YoQ8uimaa4/W6cs+9yNk4c3qyRRTihLGazrEB1bcybcfnjD8YKFERuPd3FVrp0Zm67vsC
	 wYj2ZDq61bNK3QD4hB4d4XwPYxOHRsFvPfvdkHVQ/AslnjhtNkHE1rv3zVWzp5v1G+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6i2t7fby1Aig91VlZtuENkoa1IMzYa+miHdRRqDdZTo=;
	b=5oN3AGlHLnkvfcczB+lnCroULI/bm6VgDzhC0KIqJJoNpGWAnzfNbHeeGM8MQoWNBLK5
	 5SJsX4pYaw7/AjUWcrZQ+y41XZL26YAkqnGogvafrT9H90zxYnPnxjbGsz4nJ63Iylx1y
	 pbPmivKKTCk3unFncYAe4+vQPdkVvzD00YPCInLfFfZ75urQ2HQD2oUAan3B4yI3GtfNd
	 aVC++XWjMIAi+t2Z4EueXit5t84g27Q6sIdlLx2CSWEht9CLRpLvM3LJpqTVaqcmUBzfu
	 OE3vPEBpdaZJUKY1xTeKChGJ8xcVkZ1xIGofvJwuQaL7YO8xeY2THBRvyW4AXlNlshg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1os2boY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DD606A7BA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1os2boY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DDC1F00919;
	Tue,  3 Nov 2026 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719009;
	bh=6i2t7fby1Aig91VlZtuENkoa1IMzYa+miHdRRqDdZTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1os2boYoHQ7odLo02g/IuqpA4y9Ko9mKkoJSSHuZcSTUf1Arw9OTmhrH/JIZqqc6
	 9naBWtRaXrzlIk7+VWhZkxaZRapE8FIF2SCwjFVuXtmjvGrSm1lWTuQpFg6+feH4e/
	 gk5EClpFsROm1F7egIEe/a1PZnlMb/9mV5A/IBVhBZJnuuP77/8vS9zvnVUSFpvJas
	 DHx0gxeKSeQGsFy0FeMkO96+Zwh8+h54lRZkYr/wlD+9isxyNOtr0EMbkAqXE6hi9r
	 Jlpgi9HavRmjTQZeOAnjfRSE1pWxuX3E7KfSX9p6HBSIiBwZAqm8bjYinLtFowvGUG
	 5A/pL/gO/qwPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: preserve unreadable named streams on open
Date: Tue,  3 Nov 2026 10:16:47 -0500
Message-ID: <20261103151628.279530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110315-jumbo-caliber-efb8@gregkh>
References: <2026110315-jumbo-caliber-efb8@gregkh>
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

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit 80c816c047f7cae3c99cc75740c1f5d2c4d97b45 ]

A write-only client can open an existing named stream with FILE_OPEN_IF
without permission to read the underlying file. The case-insensitive
lookup finds the xattr name, but querying its value length then fails
with -EACCES. smb2_set_stream_name_xattr() treats every negative result
as a missing stream and replaces the existing xattr with an empty value.

A failed xattr list is not proof that the stream is absent either:
for example, -ENOMEM can lead to the same empty replacement. Preserve
listing errors and create a stream only for -ENOENT or -ENODATA. The
latter can occur if the xattr is removed between listing its name and
querying its value. Return other lookup errors without changing the
stream.

A write-only FILE_OPEN now reports access denied instead of name not
found. FILE_OVERWRITE_IF and FILE_SUPERSEDE on an unreadable stream
also fail instead of appearing to replace it. Stream writes and EOF
changes already need to read the old value, so such handles cannot
update the stream after opening either.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 2 ++
 fs/ksmbd/vfs.c     | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..ada453e402d47 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2512,6 +2512,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 				     xattr_stream_size);
 	if (rc >= 0)
 		return 0;
+	if (rc != -ENOENT && rc != -ENODATA)
+		return rc;
 
 	if (fp->cdoption == FILE_OPEN_LE) {
 		ksmbd_debug(SMB, "XATTR stream name lookup failed: %d\n", rc);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index aff2d0f22c8fb..a063d7a006ecb 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1713,7 +1713,11 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 	ssize_t value_len = -ENOENT, xattr_list_len;
 
 	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
-	if (xattr_list_len <= 0)
+	if (xattr_list_len < 0) {
+		value_len = xattr_list_len;
+		goto out;
+	}
+	if (!xattr_list_len)
 		goto out;
 
 	for (name = xattr_list; name - xattr_list < xattr_list_len;
-- 
2.53.0

