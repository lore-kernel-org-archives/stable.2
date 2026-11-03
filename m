Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745834;
	b=hh0nsu9qVMk77kABuQRsG28C7nojfARllHiAM4Sjy1+Q/ZN1KChklNwt4rI0TQb5hBfR
	 OjtrQy3d1glKH0xtcIkUn0uH8ljjX0Vqfo6Ii+c/2HsK1R6xdAgseSRQB0dW39C0FBlu9
	 mP68aMet1nRiu204GzE4PI+K5EvZg5hdo3h9cWir1cVa0iufh0wunH2MaX+xPQ8a1AUau
	 AaSR0194nUvpwKFYYrFojw4ZgJEiWxgXDRMU3g+/cDSspbdBiSsx39mWgGeEZCJZmwUvN
	 BXl1l/KHFVY5jaavVagEWCOXug42N1rsJO7hLzWpWCbhwpx1lBqiLsfPIzdMBmlvgRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R4T8DG2/upTqXCaJBjYHfdzL7xIKY3ifGSNHNZYv3L8=;
	b=tWdJb5vZ4NhPvMN0NKAOEDpdiQHEEXVNB6/4u70WCTfEZRlPAWVC89cD7dDL3ui5Q6Hp
	 RyXu/1PnNS3B1DCWcqeVL2syNhvY7kcwHm7++lEbyNO3rZU343Esj5M3HiJgqkRG1YCS+
	 hAnuSWJb5N5AWVp+/Ne3/o7UPd5vj1WGwpY6qFQA5HULEWT7A0MGaRKat7Lg11R8c2d4J
	 zOzv09vqVY7EuFRmfXPy+CBDunKtK/fyiQCm8zBFYn0399vcBTqrX4jmqUFsXue5qRqdR
	 HqCXJfFNMWCUJljGKV+Pw6qjEYsyPsNGQ8XutdBkW4/UsjW4Y5eWTh7WhZ1lBB9GdaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhZTDg9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB46606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhZTDg9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5AA1F00919;
	Tue,  3 Nov 2026 22:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745833;
	bh=R4T8DG2/upTqXCaJBjYHfdzL7xIKY3ifGSNHNZYv3L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NhZTDg9mgvWe5bf2lsg7jQcRHS4TkitIa+YakD3qK2Xp795w9Fm3Sa3oZdCp0Y5aX
	 6byB3FZAuZjDk6C3tIyJez3MlK9oQ6C9+jljz5seY0ZbP+aJw2P+ZWgUyzvXyApN6W
	 j+IaeDoeNlqM1S4C+sqVUyGWrIKzv6WmwCa+cjb9wtlv1Fbwst8y/L2gWN3kC88pQg
	 5sXbtx0e0FWks06GkY+YstkrBLcUEDaBVbsCLytikW8mQhnH6AAk1d/0WzYjBD50Dq
	 OrM+W/DlNOCf/yCeBh3e9D9QwKS7zjiHujqE1TC7UPqXmTLFAGahTggjwaC0+GtuXt
	 uQzsESeN56BAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Zachariah Mithani (AploSec)" <zachariah@aplosai.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: prevent share root removal through empty paths
Date: Tue,  3 Nov 2026 17:43:52 -0500
Message-ID: <20261103224336.1548343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110338-sandfish-raking-bd5b@gregkh>
References: <2026110338-sandfish-raking-bd5b@gregkh>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 9fd1fcbbf84986a7bcf601a2b90540899069d263 ]

A FileLinkInformation request can supply "/" as the new link name.
smb2_get_name() strips the trailing slash and passes an empty string to
ksmbd_vfs_kern_path_start_removing().

ksmbd_vfs_path_lookup() resolves an empty pathname as the configured share
path, without LOOKUP_BENEATH. With ReplaceIfExists set, smb2_create_link()
can therefore remove the share root from its parent before link creation
fails. An authenticated client with a writable share and DELETE access to
a file can trigger this if the share root is empty and the mapped user
has write and search permission on its parent directory.

Return -EINVAL for empty pathnames when for_remove is set, before
resolving the share path or acquiring removal resources. Ordinary lookups
continue to accept empty pathnames for opening the share root.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Cc: stable@vger.kernel.org
Reported-by: Zachariah Mithani (AploSec) <zachariah@aplosai.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Moved the empty-name check from the shared lookup helper to smb2_create_link() because the helper lacks a for_remove parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..0daafda3f59e6 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5711,7 +5711,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 	link_name = smb2_get_name(file_info->FileName,
 				  le32_to_cpu(file_info->FileNameLength),
 				  local_nls);
-	if (IS_ERR(link_name) || S_ISDIR(file_inode(filp)->i_mode)) {
+	if (IS_ERR(link_name) || link_name[0] == '\0' ||
+	    S_ISDIR(file_inode(filp)->i_mode)) {
 		rc = -EINVAL;
 		goto out;
 	}
-- 
2.53.0

