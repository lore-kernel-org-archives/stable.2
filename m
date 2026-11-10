Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272563;
	b=ovB4IU+b4scY1YgO6JzTCeGEUZQrVKAuif+ROZnGk5gzAhzIZxEbPnyQTZAY4HF46Ck8
	 q0Gf2j6FqDMKcDFRFcKhFDitFv4Tm6OwFt5f3aTGpudt4geB+AHdfjwpjxEautLSXhV/n
	 KKjSCAkExwOS+t7Gkjb8cyTX18qL7Si5c3iqkN1I0v/N/zPy2TEQaWg3e32eT9Dgypruy
	 qW0zg+cyabPgFON+7ggL5rveTISmaQ8oJ0f43Rlrg6xhllOkX6XNRbc4d0/G66QoTDjS3
	 TOMCrNSAfk269McBKhRbh8w7ofp3LwaNRD1lP3t6zNNBYsmHxXPcN/ilU57JDzUSHog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DZ/PEvTbrp7rnkMHGY/HPggYMj70TZklb7mp0gtsuck=;
	b=fBgWKF7CtJPHX6M/YjHbyzPOBLzQIt6IiwrGakKywDHASinHYB9Gdi+El0b+EtMrR3SO
	 xSfxw0kUJd8AkXFPmRL9U8sFp7/w/s0MiylAbe7Tl+8VJs4uAjXiuesaYgAimAG7nCJNC
	 WIHrNxXCSpgjJxtcTHhQZAfsh2LF7yrITcYivJDr8nhvluxkVYMtIsOXybqQYxYkT+x/v
	 N8bxOmQxWNYN1VoXVt+pjJ1/96DIbXA3o+b+qVK48WUs7/ORkFdZeiBbf79Bb2LIcRasg
	 g9En2/1bzRvg3bi9dM1u5i+I/0dpjFFAb5rup+9EvvCTbydGWtGiiEYYFUjw8B8Sw1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3cbEIxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F06606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3cbEIxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441951F0089F;
	Tue, 10 Nov 2026 01:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272562;
	bh=DZ/PEvTbrp7rnkMHGY/HPggYMj70TZklb7mp0gtsuck=;
	h=From:To:Cc:Subject:Date;
	b=Y3cbEIxNiPPs4efm+3bLqK24hLw9R3FBMaZfDi/BoQiMP+JIt38j/pm+kazDhmsiu
	 jeQmzA0rvaaRgSx82jsITj/xhdVan9gwjUnJYpl6wR9z6F91QaoOwt2mgiDeFaqO+k
	 AtrMMKODxXNk7sCoWjLFqOHF5foTIOLmOKGJQaTlTIhUDMgaDg4kTOWZB7tPvgYjJU
	 IgfX30tFuq09NmmZJGwz/XBzzeBXtk0Cfdl+MSauVigVirkrvgtXO2MQQXrRXdVE1L
	 s5E9wmeylgikHxovjDwrKDbp1VTrBfOj44DsauGhnkDWQ+NqEed6MAMbB+8BjEN/Df
	 T40MqcrO6loQQ==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: enforce the read-only share flag when creating a stream" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:41 -0500
Message-ID: <20261109200241-failed-6.18-09139429fab3@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 09139429fab3a5114c18d7c15fb161511d4d66c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200241-failed-6.18-09139429fab3@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




