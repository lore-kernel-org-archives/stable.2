Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720042;
	b=2nmkybaRcmryuFoXOiS/Mn4CMuyUw8WKvNGvwZYBWlI+12zu6e3FpAQnfLGSrtgskrKT
	 dwl78U6RBxcJfxhmZuYEAQaKW/hYYrxE+qq5tGaWuMg6N3ePFXQIoBQS5M6WS7iANgyhU
	 fAUuch4K5+xFc8Z3D92UGO+trr4lozDBa1ag/YRUJS5K8uq5DJHAQXaLUVJC3b8xMPAnH
	 osW/9uAzwoqQwQAJUomG0jgQL59cK9XBAkK03beZExDEUFgzlzQWQCOjYP/vBrF7vrCQC
	 E0uNEFxFKhVVJ63YeHWI0D4+FraczmhnV2x5cNOgvvoeRx1nB6ILSDCglUCB2Cn7MDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OwdNvOIMTgypH3BRn/FZACmfqmexMZYIgFxM8aJWOSI=;
	b=0nXDTymm68q2wkxUWrpP+CEti4fO8WFPX0c1FI7bUS3RdsFHwK15zw+kBWVU8vf7AYxD
	 iERda+B43Usm6jbuHsOF+vMP/b/fHvzeZpe4V8lw9CAh7/I6pVRIiUxJ8O44maXOWgfbo
	 QNeJhDrL0773UMGiS/x4QESaHZxrJi010w0P4pgjeZSE003Slx+iT+1GeMfpMGQ8oxVt2
	 o19IQp++R2TSs6vKO7jP6QnA0TmpIjsyQDyuCZYp9Au0Kk0209ZfwqWOV25OdjE/xpwVT
	 fg4PKqehh44G8FiN/UTzXn823ejAN9tMrZpVp4dXjIVB9XJkjiisDMiVcTj00adASgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XsVt/3U0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29647606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsVt/3U0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599221F000C1;
	Tue,  3 Nov 2026 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720041;
	bh=OwdNvOIMTgypH3BRn/FZACmfqmexMZYIgFxM8aJWOSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsVt/3U0ui+Zpa0O/iPpLU2f/BAvI7jwR67cPd/DHI55Fyg4L6YdvJetHGM2y5F8z
	 r7ozhsnSNbpYtCK/2XYcZxZZO9SmFWuJpl5oCgw3rpSf99cXLT9N0N6rl4PxD7qM6v
	 rgVR36Duozi1z47j18+Fg7Cr0GPr8tQofnOGsbfeRzZlKLIAEr9lLW8ViT7iM3hUUz
	 HicTzWfc0XTGaZCBOON27ilT05qt3DrTYUbWO30F9LsxrJMKgIglCAm+KEXJkaVGMu
	 W0oWozXSHDhik7+ZB6IhzkWYze0CGYBxSJCCltN9UjY/ypHv6KJeuyCZnTCBgTT92F
	 W/ZqynXjGWisQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Zachariah Mithani (AploSec)" <zachariah@aplosai.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: prevent share root removal through empty paths
Date: Tue,  3 Nov 2026 10:34:00 -0500
Message-ID: <20261103153340.375429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110336-chatting-upstage-25a1@gregkh>
References: <2026110336-chatting-upstage-25a1@gregkh>
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
[ sashal: Replaced for_remove with the existing do_lock parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c18ab8431e0d2..29b204776b961 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -78,6 +78,10 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
+		/* The share root must never be removed. */
+		if (do_lock)
+			return -EINVAL;
+
 		pathname = share_conf->path;
 		root_share_path = NULL;
 	} else {
-- 
2.53.0

