Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273057;
	b=4kFUrSMxvSVoFaLheLCiNJQCsuH01IdpKvEhTc3/51wfBIySRDM+gLB9LULvWEd8nKps
	 gpJ/N34IGwoT8ViFKMAd3t2dL2D14OcwFjUWeOWsZdUGvy27WMWfxSXZxGbhAl81C+Cn4
	 3zC88vE1Yi3Sz6OS0DNxxm7losPet9JrKYPcunZ3EFx2tTvYeUsWzczKbeIK5gXYe+3W+
	 hC2HGIvIRNHesVXKNlVLtsLBPAt3YLYGyrugs6SL+B6+YtEpXMMJ8W9d7i8EoJZCEUJGx
	 shmL/PqNig9OtETbQstktMd2GbhRBCYRIPSHfod+T/adDK7DaFTkTLeQ3pClwCqT6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gFuAevO2FGB9jaISrtQhlEyBFm9CJYgQQ6dyN+IcgQ4=;
	b=peAhsUTUbP7P091u6MZttDl4VKQNMuJo5X4522bsZMLKPJ+x1xOvAmjk9hzyPsyZcQTx
	 RotyJZJUaQ9xPHw4fmyDg6CqNMROI31D94A7nm9vGwGJffmnra786pvLdNY1KrY1H826j
	 pUAS2A7whgBNNCf3UBjYV7hFM8bEKiK1ur+1mzMl+7gV2l9RE9SN1UFo5Orz8pt5HUKzd
	 ejhsxWrAcfx6wDpMypEniAAX9u9SgVL2009nTb195oxYVuFRFLqEGePHu4jkP+XxIr6Z6
	 BNgZOjPodyY0Vv9HV1zW4Gg0YGXrcyY5JgMXjEZeCkHQloMp6bh7O4Fc1uBEAEzwMsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoqL5+to;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoqL5+to
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4341F0089F;
	Tue, 10 Nov 2026 01:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273057;
	bh=gFuAevO2FGB9jaISrtQhlEyBFm9CJYgQQ6dyN+IcgQ4=;
	h=From:To:Cc:Subject:Date;
	b=ZoqL5+toPSdpYubNlO2olLHdnKUoqeCM8b8xygba8N48CdPHSasckgVbv3b3rNZJC
	 /WgmBmdHb+hsPTLULHFRs4T4wfN8ItL3foJQg7HHu4PbAvNC2+e0r2TQlZJwg88x0I
	 g+9BAfrg03OWWZYe/IExtNV4es/z8nyUcouDRzxoT3ahlB5TmTpOIsgfrdIFGBdbIM
	 daPBafT7lSGe3YtK1W9rbGYZEqDBnRPz6zLsS2I8OWPBxg2CgqlQP1y/90PmS6a36d
	 usJvCNkS53twdPhZRdtV344Sl42sqndyGc67fBBVrSPrAfSsKWD3PKINJn9119oy/Y
	 A3Xms0km4rIDQ==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: enforce the read-only share flag when creating a stream" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:55 -0500
Message-ID: <20261109201055-failed-6.6-09139429fab3@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 09139429fab3a5114c18d7c15fb161511d4d66c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201055-failed-6.6-09139429fab3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




