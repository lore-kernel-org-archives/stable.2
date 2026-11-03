Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741865;
	b=RnwE2Zl9N99DKjmIRyPN9u8dUfmd0+qia3pL5Oet6j1GzR/wsbN0ORzE725rUFtJtzwN
	 /2I9cOjYG2N9+08GEJh4mUNOTQyh8NacZkY8jTclfoqc+uY/GZecJUp9+FCR27LITnN7E
	 TKLvnuXjdkkzN+ofN0+uKkPh2ZuCrMxYViDjSPkfnkNEzFZnYzz3fKEfxR/xwQaFDsOlm
	 dA9remKee6RecqtVmKonsyKZyB+hu4Q1s1H98BGg+L/eMXMv7HwDrHDo6TVxsDDiHDxrP
	 LCbmgsz4MEPTxcCIqsJjnfAAn+E5UrydZVlqS2BGfHn9T3QtZMELGlSlblK6XvlKUjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gipMuse1MEws36NFmi64SHa/mSusb1/HuuIBLTmKMy4=;
	b=SMPXgvB1ebHePP0Dq3xhN+HUiUl6Q/9roTj5G0V1EzJoufmx+AtyljbGk0Wjoe2/KZKL
	 3ENhW5pKhIXl9MdmbCohIUBFtVVkFhM3T22G+6uo8UsFk4ocLFNNUORFc0yYHb951soj+
	 65HXEex+0Vcufl6DNz6RHtb+c9OHi7IwgwOrWxE9GV7rQmiHbkkm2Cv46w/uZzLz5UI5X
	 g/LpEie6rZszrBoKCc7N89G5TzPDUypt0eSJ4ePbit4aujbogJCXTZG7NVialujSOD/bF
	 BPp+Z+97SArcrSVw6R1LKPMkeIiTst0LYg2MeFSw2jx1RaDyHDX5t1vzwnQqJbEc1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCJPAmeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6E606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCJPAmeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7B91F000C1;
	Tue,  3 Nov 2026 21:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741864;
	bh=gipMuse1MEws36NFmi64SHa/mSusb1/HuuIBLTmKMy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCJPAmeGvn7Cv30k4qEbCs4IDZs5um0C/ufc9SLZboE3ry84wqgPwPepdbK3kC06j
	 DmMjq3GvtX8Wb5GSdL+C9bQnTt+DaDrXFzfR1FBnudtAhXmqfOyov9MqHoeMQswYct
	 Gy6blg+uZg3/livy852f18vaKBLAoNg2nMC340iZDTJFiqTTfqgwUUhiTarY5dmlBZ
	 foFR0oAvLNaFGt2Z/LAL/mQR9EDW35fkdjPqDfbh2b52/sewrIQYapCziZMo8D6eb0
	 0AOFs3S4nj0qls/EDH3CIHVzZt/Snk/b2IW6brLYnGg5dHMG6/MUtKkio6XMJ5omrJ
	 QVpOavA8FisFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Zachariah Mithani (AploSec)" <zachariah@aplosai.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: prevent share root removal through empty paths
Date: Tue,  3 Nov 2026 16:37:42 -0500
Message-ID: <20261103213708.1423611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110337-undivided-femur-faa6@gregkh>
References: <2026110337-undivided-femur-faa6@gregkh>
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
[ sashal: Moved the empty-name check from ksmbd_vfs_path_lookup() to smb2_create_link() because the lookup helper lacks for_remove. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..3ee1d981eb961 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5841,7 +5841,8 @@ static int smb2_create_link(struct ksmbd_work *work,
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

