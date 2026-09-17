Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEC517BCA
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650649; cv=none; b=C/sJ4jb9gGFMmuc055eWG0l2Ch34mH+eWGGDEaEvQKLffj1WprC5qFGFCcIRcjJB7MUKVScfztqWc8vgGGB6/gk95cyx8HqQ+YqsQb6SsfMXWWL4FVTXDnYRQUB3aSsLeKuPHsXx9u3OVk1gTO6pxUIWJLtZTkJvgMZ2Vs2nBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650649; c=relaxed/simple;
	bh=tM6H0kKm+zCw1L/ZSV3ZU8Lmbd1KUOpFQQ2SxtiFpu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJDXmnGiUczHzNA0gsqvFc8Ifo8RR0wFZU/MsL7V/82n8CTYiXxSe4G1ydbf2hYJWJDucSTYk+Si529Y7rAO/XGsLujI6z+zLBt8SmXvM96CzXboeOawlojTJcKtu95RMm9OlpMYAEWJqMUYjRPTO1hQG7iC+dqjH1YbMweRWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K32l5Keu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K32l5Keu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6061F00893;
	Thu, 17 Sep 2026 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650642;
	bh=D7WsZBhmYtHRDio2uimqpexFDqdPWwiVH52mS+HkUIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K32l5KeueJK9Nc5zXfhY391TWiE59+xpFzR1UCdDxaCIv6x3+KdpL7XwYVq+9OVvJ
	 s4ZymT9pmI/t50rlYTZwhS8PI7w7mTWSrithUMGH796QtQ58l+Pk4UW86QJFprtCEX
	 z6S8nWuNla6+8PH4dSSIBYsi3yQq/X5BkW+qz+5POxhUjwShJXNmFyFPr6D3LRPFHi
	 d3c68JKCq4R4GmVPAa7QkFeVCWBe3Sh5OkMeH3Idjrjyh2xDs02JVDvbhXNZmlWzGa
	 fd4VSn1fYlvGbWJuQ94inqXPlkFF7P72C5Kw99TXKPbsb/0b5lzz+Xt4K+aMCgu4cc
	 Mdmw5eE/HfA2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
Date: Thu, 17 Sep 2026 09:10:39 -0400
Message-ID: <20260917131039.335457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091632-lizard-catalog-5af9@gregkh>
References: <2026091632-lizard-catalog-5af9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 6bd360447941357e959414a525aa62576a448116 ]

Setting the file type in cf_mode without clearing the existing S_IFMT
bits first is wrong as it corrupts the file type when cf_mode already
has type bits set (e.g. S_IFREG | S_IFLNK == S_IFDIR | S_IFREG).

Clear S_IFMT before setting S_IFLNK for native and SMB1 symlinks.

Closes: https://sashiko.dev/#/patchset/20260906181540.647469-1-pc%40manguebit.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ Moved the fix from missing reparse.c to smb311_posix_info_to_fattr() in inode.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index b11a919b9cab0..be31bc04a7125 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -632,6 +632,7 @@ smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct smb311_posix_qinfo *
 	/* fattr->cf_rdev = le32_to_cpu(info->DeviceId); */
 
 	if (symlink) {
+		fattr->cf_mode &= ~S_IFMT;
 		fattr->cf_mode |= S_IFLNK;
 		fattr->cf_dtype = DT_LNK;
 	} else if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
-- 
2.53.0

