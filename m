Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462256;
	b=15CDjsehXCVcr7eW/zOWpt3TLpgKRiVQh84XsiIVC87+6S9icIi8rbO1hA8gxc0/n08y
	 wuydv9PcTpDsV44ZGGFV9OBicR+uV7zZvS7IMrMnoVRho01f0z41uz3xSTNDgwvmLu3tv
	 VjMigBwXexFq3jjmCyPf94YcnVhzpLypoqw1t/Dv5d2pej0tHw+5h4OTQosXv5S8vkCzZ
	 RMeARVTGzdeVl+L9rMM4GZ0fOo4Uzn/q/pvn3PqZGiwj41xfCUfV7RP1ljATGRI4R9y5y
	 KgBQIVMNWfhEdQ2yJb8dxz266zTZIz/eBk9+CcDNfnHZkDeZ9bz5EQytVCLaKn3p7Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n2kAhYTQ/7ZzvJTGIJk4rRpCmFc8ESu40ca/0a1CeuY=;
	b=IjRfummdZNx2YOUlqS9H2I46HfgDAIMK1g6ls8PkRpneTpgOHP6IDoMYKiWcXWBJqnbq
	 Xj0lLjmQLauwFdMIdlfhTV31OuQBA6SLaHAKeoYbN/W20Mz8KULkETHp5XzhRGkXNo8ec
	 cQUs9CgeB0+8eI5jLnqai5KQxdBwDOTjZn4joFaNDNzu7XQ+VSxb6n9TZX78UTBhRtUM6
	 /Zof/srFkZPzE9q7qg1UbcdrPzgufbxfX6XsdOilkCUgHJUsF8fSdV7hEWi1FHxKJ3s4D
	 qQ7DKg2fj++FZN9HFH6cygFvTe/gWjZf3N4QACA9T+Ap7P47kPGSyp7SaKYGbYbSGhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an0fxXn1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18333606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an0fxXn1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7844D1F00A05;
	Thu, 12 Nov 2026 05:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462255;
	bh=n2kAhYTQ/7ZzvJTGIJk4rRpCmFc8ESu40ca/0a1CeuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=an0fxXn1dzG0oTa3iUZF0xh+iFqj+X/sQx4Q/87R/0PpAQtebgDTVjM+SkVMsrOLQ
	 xTs6iPclozazuT5yqFl2m/Y7mxI5yyZIyDv1MdepFav1F9dhe7tEpE/wtCccDk144a
	 3yXhTy/Ni7dtNIYm9XQIeRRyLjJLGD+/7yWuO2sw/CWCGgtaeTLpiHsDlhzLfoimZx
	 rUq2bCjW9VIVyh3+/pAD0P1T681roy0SWJU9xCf4256h44Hy5m3o0gCgOWHiTEW1Uu
	 dMZHQsNDlGCZnSJgBWI5WXKcPLyrA5+99VUM/ZP9C8r8XqQ1MF4eNHnT/VDPEZeg1B
	 d2KzdhBAB5hpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: enforce the read-only share flag when creating a stream
Date: Thu, 12 Nov 2026 00:44:14 -0500
Message-ID: <20261112054351.2253011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202050-failed-5.15-09139429fab3@kernel.org>
References: <20261109202050-failed-5.15-09139429fab3@kernel.org>
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
[ sashal: omitted the AFP_AfpInfo synthesis guard because that synthesis branch is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 74a0c3b68633f..da69dd9488f2e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2538,6 +2538,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
+	if (!test_tree_conn_flag(fp->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE))
+		return -EACCES;
+
 	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
-- 
2.53.0

