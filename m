Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273653;
	b=fQ4e25MrRw3pLYVNNQXRAlgRaRfjzCDkgfFH8LG8RBICgDf7mK8Hpz5g4DonbNMvGBf5
	 OApqpQfihfGON97BNASjcN3SW/1KTSdDUEyt+6VqCPH8zF0XvDar1fxs5ROTLp8yia9Cf
	 WG4B7qYd8GATyQUIk4dFseqnHQaKLxuC7ztAvQgVyr3eUYimLciNkCpY8MU7CQehuyAJ3
	 HALrpLAYr0j0xy6hZeesQeILNnJjWZqVEZc7CZtiiIiQ5ESI+mg03T+W6aKzg5wtGGHWW
	 zSbXD5Bo1TVB7sGhzupFOX4KM/irX1kCHohAaKaw1LfdtR6A5qLbutfwsi3pD9qQGxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sNOoE0fk5LjFYDPPsuQraTyUpEhRqm2q3T93AxF8JY4=;
	b=QFCHPnJSl2yeyXd4iUnW9nKR+xDmxMQa1/R1j5F+OGp89EmWa+vabVWz0GnSzMrviCwp
	 b11Z8UlaYa/VXZOQDa25B4y5GeFRWliIEleAuZnq4iTAM23rl5f33O8YCv46zWe+7oESQ
	 ujmiluta6MqeId/eOIQWNEkgyL2dHZuBtVnuGdvNokNqJ8BA7PdNX7lfz1wSlYv8rruS2
	 HYLHq2wP3e+j07mFa4xBnmTz12zcKmNDSSnw4DHZZ+VWnjIqvnWpOiPquFFLPTaOUPXCw
	 4Dt1vMkoRZyaJhEz1s1bKynX9QMyJ9pvruDn0wtMQXpONIkpnrbemIjOLuRFqHoqN2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W61HnYSy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48E606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W61HnYSy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18541F0089F;
	Tue, 10 Nov 2026 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273652;
	bh=sNOoE0fk5LjFYDPPsuQraTyUpEhRqm2q3T93AxF8JY4=;
	h=From:To:Cc:Subject:Date;
	b=W61HnYSyJeAHwSkIovGRPSP/T7RSt6klvHdj0bhBJrZypGMOgy/+ZjC6LsGM604YI
	 OOWkAJDGJV8J7KaYojh4BrjyhDwVloZ7+5q0CJGdtMo5dpkD3j/za/QleFedXZ4m8x
	 wr+ntgnv/qtFnoCsOafYYlz7+QSQlAQ1u2hIwinKMUS1wOY1sfCOlLjeM2KIH4Eftt
	 EqMWLoRWSu49coNEtYmXl+7rad179/On8wQe69jvORhdcwP7NPv3CgyVgxF0lKVion
	 HGMnHLC22CtuJmy+yGgrm9fxLePURZ7MpjzjAi3ykx+J/MdsrbOPIr1JTappD4vqVt
	 19+CC+P+lVUOg==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: enforce the read-only share flag when creating a stream" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:50 -0500
Message-ID: <20261109202050-failed-5.15-09139429fab3@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 09139429fab3a5114c18d7c15fb161511d4d66c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202050-failed-5.15-09139429fab3@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




