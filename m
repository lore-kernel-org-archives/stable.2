Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455299;
	b=TBSTKf7LZtQSPtOLr5ZakmKoIaZY6CxsI2miHactk1ZCOzDI0C5b0j4x551tHc9EvL8m
	 Bz74zffNIApHP+fv4GYlcYufrXJvhS11RQWiTQlq/NQ3T7DU/yJn5FMKSpPsbbgUTMKIE
	 SQEDPx7Ld7RolPQ86SoNPQ6cP1i5yzD1F/ug1oOuXgLqnaQQOTy5PKpruvAWD5u3E6dks
	 k77YDPFpfvt3VnN1xdX/TLcM+eoGpTbRROEhKVMrQzVvuLJP6yEHmJ641M/W8hcBTTig4
	 DNnPeWb0czSrEROPhe/m90Mui9PZDIR7k/6Z5IDaz7ROT61PUqx4D0IM3py99wIWTag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455299;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vdD9OPY9UYtyBn/C3k4L8sYequZfJvdB/Suh0yT/byo=;
	b=dklKowacSuHMvWw0Z4rHFut3dIatXth/Imt9sjytPrEjVFkRJJteDIiijFaiaK8bY39/
	 GcgoQoMbIxBMU0n0YNQ4nvuoXVIkRL4kRPXJfyLCjjJhsIHk4shYJ1bcdouuN8s2KwrI6
	 LlkQYkY5eoBb53WKL59ZNwQYLcxGgC01F1n2/JBCgiVWa/WO0GZMP0y9yzEu98a/LOaMM
	 U5NOeRHGYZ7Tt42K99SJX9xzQU4yCxYyd/5rZIBeW0qlv6ibdUsEXpfP6N1h5Aw1BevAu
	 9HWVrDNvVjjiVTTNEWXKO0IZ9iiBsLy+UQ7khWqno06gOR80hMpre3FZ+j9FYEzszdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZhRRV7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A961606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZhRRV7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9C91F00A05;
	Thu, 12 Nov 2026 03:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455298;
	bh=vdD9OPY9UYtyBn/C3k4L8sYequZfJvdB/Suh0yT/byo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aZhRRV7tKzw0JrEmmnwZyV2P1VjNLROqAF2p05zPOSdx6zWvQcrp1fBOC4gaavG4v
	 JjIoTA55N8AbOL1XNYqKhM5O5Wq9OZwu5M8LQ6OP/oqxwqU/TuGXCUy4Uj9WvFyTJr
	 FcLci0u5nbWcKyMNVnYgn39I7+bNT6VkJ0ySigZJ9kpoOxn2BSM6KYxzx1XsPL7Muc
	 1BvQ7AQ5QwnATvXJO/gB7vNXNa16/N3otoYx/tzTCpMwVN2Q7oeamM3DUT14wK4Iga
	 oECRty9ZdzhRrrvCuIXUVwdVtEPjBG9uZkborRgDnU81XqlgfRC9omy/cpflQZA5EX
	 ZLp5xJNLBtgEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: enforce the read-only share flag when creating a stream
Date: Wed, 11 Nov 2026 22:48:17 -0500
Message-ID: <20261112034715.1496141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201055-failed-6.6-09139429fab3@kernel.org>
References: <20261109201055-failed-6.6-09139429fab3@kernel.org>
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
[ sashal: omitted the writable check for the AFP_AfpInfo special case ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b05774050e096..bc005da55459f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2546,6 +2546,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
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

