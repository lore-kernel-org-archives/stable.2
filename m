Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449808;
	b=JMD9vYVVcGODYfbb03JL/sVN+/HhHueKlnJii91+Y8QfmH7jLJ2s8cEZ80JIxT11DAvK
	 JFlp/4/rgOajhvl5i4FIOqKudRqR1e5cmO0ITj/gpBYbvkPrR4fdWFp0ms/wre7dgv9g0
	 63/LP+6RpgIY1K4zdsSsLxfoh7rTaYDagChSEgpsBonDUnreM/sq3fgrzvwzVmSX2PrLz
	 ATmNc6WLjwZMneYiv7uq0OyhJNefQxedv7TmW93y6N+URBzg3ipLHlRoOcjEIy2+7ZHwI
	 cQ/u0Vd77+QX8yGErWbx2C3rrizbaYOCn3D3wFrkRXTuCJk5ZpyQUYMfCRtWeCFsgjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5qhvkHyzIWFGrKgL2TfStK8aoYD5bV4KWXUl/ZwsGew=;
	b=IptdNT2rJuyA/aW9MxZ24cz6N8pwgZgM9zfXpWRotix6EcKFy8zU7/5rwz+XGGEM4KVr
	 MSXlJwvJsxdZ1xJwHMbwlAkL+b1ALw7/FYNwBGQH1N2Yq7NcZpQvi97C9X/DSaLSK+NHQ
	 +OtQNhWOBnhvTaxXb7Z3OP5RxcBYyxQfvUzQA3hYqAMwBq/XSMu02/X6tnSFshvE+PBif
	 wNl+UywKnkULbbM1hhYDd4/2GXmVMy7gJn+x2xUM/FkAQ19GUirNe3+T5trPOo5SEj3Z6
	 NCJQIj8y9ilvyaKidDmqJv7LU/gT7oZHudvnoK5W5JhSz4G8r3CdHUABzIvwGddrjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iG5mTp8E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iG5mTp8E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018EC1F00A05;
	Thu, 12 Nov 2026 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449807;
	bh=5qhvkHyzIWFGrKgL2TfStK8aoYD5bV4KWXUl/ZwsGew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iG5mTp8E4WzdVc6Q+EnWN9Cc/v5vSXuPczdOnse29sNyi1dAr70AEjtzXNfc9zE/H
	 l8Ocxb55a3xOPG4ktAsEqquOsbOa09BAsawJrZuWOMLarZ0Pw1E2VDdyFMuC2/OjqT
	 1l/aUFGDh1EKjcEVAK0fzLHc9ExH+Zy+Ih9CIRlGZ2NsolVCKoQXt0GiKanPeNAmdB
	 PVOfD6cIubQS+xzFqfWHy/Bf2//V17JdoeaAwYsmB1/nedWepbmAvIdYKYwehjPIah
	 5mhT38b7BG/G8Tn88tFhDoYiHxl7ys67lalr75GozTVptyxRA5dV9KHBU4s/L58LXm
	 bwsYGS2HAlnyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: enforce the read-only share flag when creating a stream
Date: Wed, 11 Nov 2026 21:16:45 -0500
Message-ID: <20261112021345.1241054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200241-failed-6.18-09139429fab3@kernel.org>
References: <20261109200241-failed-6.18-09139429fab3@kernel.org>
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
[ sashal: Omitted the AFP_AfpInfo creation guard because automatic creation on Time Machine shares is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ec4c54c9c6dc9..0e65fba990d04 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2567,6 +2567,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
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

