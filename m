Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452458;
	b=a+WGeljuIX+jKejffB5UHBF+vzlh55FVR+ww3dsTm0wtiRa3wl9p+dEl3qQImE6OWcpp
	 RIZ5+4KIgH6BxkvDK6ag0AX9R0e2i9CsK3kDc4dDmtua6dNsdQbgRsTseu1iSwkL0ZGhW
	 YkJCLyyZABIkq++/ZHvazU+NWQuFe07n8S8hBsXQ68kBb6ayPrXZFK4B6ZOBEcGPv3u0O
	 UuDglFbCfefvIjp/rFZUTYiv781WQMv0AQp2L4fdTwGDiyFR5AAVDkyendLXmQXD7BVBr
	 nziC3j0OdSLUAsUnn/I0L+32iUdQ9igVebHTQ0XaQmzC0IbTndNhVQKLXShYQCgLLSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452458;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xU/+Od+4o2KWxwWkqODlOvT7GxkwfcI6UST+m5r0BhI=;
	b=kY14bts1vBfTnvMOkMnVL7EiEAzoNflVV6Qrb3apRjm4nh/UX9hnP3qGmsA2PzecK/DI
	 9mbqUGjHC4Q1gWVHPmywadlbd5TEDsRkHCdXBROruZu8/AyJlNSkQP0iq/yv4/m7nt9lR
	 3cnWa3lFrg8QECn4nukPf0xs70jTzJyvQ755DNH/ipZLSNZwR8S10NWIvqyCjxaFeJTJF
	 P2tztPppBOB1bqVXS8nvZfKIh+sejVaIqRFw1NxPx4xCgBn/qGafZJFFuSbsmt10swfyu
	 ZjwBy13W0PhYj9yYdFHn0cRFAV4JFW3EqsW4WAuXIpgrYyJWmVXZdvJUTunZvkg9YSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WrJ/PtC1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBC606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrJ/PtC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C36A1F00A06;
	Thu, 12 Nov 2026 03:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452457;
	bh=xU/+Od+4o2KWxwWkqODlOvT7GxkwfcI6UST+m5r0BhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrJ/PtC1iqGgKqCm4Au7qOstZYNWXvRT1IaRSNk0ZNZyygypjGXJ+pBDztuqRJ9gL
	 GoxDWZwJ+a/86RcRu4saDWv2hJVFPWg1MGw3+56puL2VfBlTGXzKh1F93K5ZbOzqrW
	 aHfLObNgUcdR6O/m6CaaCMmPFOA+tNWvdQe31lDFJW10RE4L3+tewX5CWnvYzRPmWm
	 +3XmxHivcHefpUHyDOU4v8jABgOT0Y9H9xGeC2NQavD9iNCdjZPmvxn+NO8K4uKkoe
	 XUHxAXMHTHik5QWg2tbDLF0y7Lm+YwdZnihWcFATA1Vx/GQ8X8Wbqk9P4x3VA7e59B
	 Ke+m2lcCvd31g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: enforce the read-only share flag when creating a stream
Date: Wed, 11 Nov 2026 22:00:55 -0500
Message-ID: <20261112030030.1366587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200637-failed-6.12-09139429fab3@kernel.org>
References: <20261109200637-failed-6.12-09139429fab3@kernel.org>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 09139429fab3a5114c18d7c15fb161511d4d66c9 ]

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
[ sashal: omitted the writable-tree check in the AFP_AfpInfo stream synthesis branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f7e3d7986c4ca..fdbe4c5664fd2 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2574,6 +2574,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
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

