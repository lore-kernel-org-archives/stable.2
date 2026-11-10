Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272799;
	b=xCKX8PqOyHIEGgY6exMBCI2FkRtnz91M7W0sSH6Hp3nKOlY6RZhSsx7jgjxOK0D8MV7M
	 8TAyv6Mnd2BMYUKoloPp+DuYtBF23LX7kaMagdWkjyWZJIfpHCRijjeUhig9O/zUh384s
	 3y9gKVd47e2/kOFBjMdilrMaTK3sek15A/oK9181bopqgHZ50KSEEIhEYhK/aFGAJaI0d
	 Qw5KJGQ0c7TBlcNCtaRUiNLqHS5M3y+R9UPQaWqcCVnp0t+PTGdbcAWS+BRiJYCagdT/1
	 GLdY+7uPAA+Le+kgtoypvpRdMakp8WDodMNJPufhwQMs6U6khSH+8L/lqG0RgjR4w0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vO9ObLS5iRJDz6WjRJA/zrsc2kDtL61uZkNe61HgMKI=;
	b=Z+wdLR0BU6nT7cP1prkNO+ikMZSuqfSVp2DJJOViws3Qyo80wy31H8rUB2a6zufGc3k1
	 knfjyS9bXBw8pS5HjNUqeukX7OjvzK5Gw88nx93csfAfczkDCCMjiP9L6mppejGaGPAsc
	 NMmxbuDsE5Gxc9CqxFxv/soyXKSOjPMQQnMxCXyZfVQaP3gI69rz1cvB9IeiYfakl14Oo
	 iI6a0F0HLemezpJPYC7PkLK9cZQ+xEpx5QoeZWt8/yxy2yb2WotAATZ72vBNzStGbvC7h
	 beR2W+1+8bN5oohIe0kmCLBm/2XcG3sVUtq/sNCSHzZvU829jjZKyrW4PMnEyd3NYyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLM+mKFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11128606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLM+mKFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7921F0089F;
	Tue, 10 Nov 2026 01:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272798;
	bh=vO9ObLS5iRJDz6WjRJA/zrsc2kDtL61uZkNe61HgMKI=;
	h=From:To:Cc:Subject:Date;
	b=RLM+mKFAVsnetbTUReRfB/lrlBA4iD4pJlfbSn5xHUiuHX4csBAckt/5sfNUkPisX
	 Lbx5o9XBtVo00kG8pQd07I6pff5uEfM/fRhQ38gzG33KIbTud9N3NwAAR3aQl7TC7o
	 n82GqqtCiWyQ58R3SrayF1R1N8S3mJ+oFyOQ5FgiLN6wF1gbCha+Fc6mSZjVL238JQ
	 hMu2CyhDQQ1/uVBVMNQhat9GgXmckOlgiqazuqeziwjdzbRdVV5+TyxUkCMbVWswmu
	 ZfRGTroUv4oPT1F+pdvW1wUCeCq0yjixplHGfFvSedmkCL5cEqeVdL7AgKrd3b2DKm
	 ucI3rAE2Q6bnQ==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: enforce the read-only share flag when creating a stream" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:37 -0500
Message-ID: <20261109200637-failed-6.12-09139429fab3@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 09139429fab3a5114c18d7c15fb161511d4d66c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200637-failed-6.12-09139429fab3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 09139429fab3a5114c18d7c15fb161511d4d66c9 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Wed, 28 Oct 2026 20:25:32 -0500
Subject: [PATCH] ksmbd: enforce the read-only share flag when creating a
 stream

When a share is read-only, smb2_open() rejects opens that would create
or truncate a file. Creating a named stream on an existing file with
streams_xattr sets neither O_CREAT nor O_TRUNC, so it passes this check,
and smb2_set_stream_name_xattr() then creates the stream. On a Time
Machine share, opening a missing AFP_AfpInfo stream also writes one. A
user who can write a file at the filesystem level can therefore add
streams to it through a read-only share.

Do not create a stream or synthesize AFP_AfpInfo when the share is not
writable. Existing streams still open normally, and a missing stream
opened with FILE_OPEN still returns STATUS_OBJECT_NAME_NOT_FOUND.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Fixes: eaff8e924f60 ("ksmbd: synthesize empty AFP_AfpInfo xattr on first probe")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/smb2pdu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c626cb3bece1e..528bb4ac97e16 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3566,7 +3566,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	if (fp->cdoption == FILE_OPEN_LE) {
 		if (!strcmp(stream_name, "AFP_AfpInfo") &&
 		    test_share_config_flag(fp->tcon->share_conf,
-					   KSMBD_SHARE_FLAG_TIME_MACHINE)) {
+					   KSMBD_SHARE_FLAG_TIME_MACHINE) &&
+		    test_tree_conn_flag(fp->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 			/*
 			 * Synthesize an empty AFP_AfpInfo xattr on first access.
 			 * type=0/creator=0 tells macOS to use the file extension
@@ -3593,6 +3594,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
+	if (!test_tree_conn_flag(fp->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE))
+		return -EACCES;
+
 	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
-- 
2.53.0




