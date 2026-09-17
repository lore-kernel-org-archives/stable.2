Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9F511209
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650237; cv=none; b=RVpLS3SxxjETpWhlv2pW7fiD0a6yIY04uNk0Qjf4KYTxWPnVlK1BqDNwNeBOPBoc+ljY19xUHYJpK5WL8XurKcp9JBrcjNA0BKG+1+1+FvuThXm7xenzQ/JAm76pT39Wv6auq9hNtizahkDYAY5aWSG/DQZU4wFTV9k9T4WRWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650237; c=relaxed/simple;
	bh=EUH9DEYmVGiG5UtFgK2sx6AphJaQuZsmLfgpqlsb7yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhB6W8r1DP7qT7jm0OA7ts5YK7tB1vbZuowpuaI0JxyScDu5nUFHIbaTbJEbAwhbMFIYKUde19u5/ND/Ei714QPlxFjYm2CqiH6Zsnq2GFhb07K9nxBu6PaIBVCeg2pTS5LtaApv90OCXJES30t7USImFtUxqcb90hbUd8HPC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdDjvttW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdDjvttW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C211F0089A;
	Thu, 17 Sep 2026 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650228;
	bh=8TfHwkKN/YieHWzcfPbMRRzAbH186bi0/2di+sx+kCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdDjvttW2GShMvJQSUnPMWkcM7fZNm4/A28qdprvMCL3ItYbgd0Jf7FeeWqnPaRos
	 /SOtoYhFzeYsuh6oLDtiUPgyJPqU9nuv5Wf/kEhTpdfl1/0nPWynbltw4vEbf2e/cL
	 /nqHsNssa/5emFX8bPGTXN2nSCZmz34z7Ze3MHv02cEmnex7ViII9uM/u/IIQbSesr
	 A4icnJSXzkAZVZyeX5t6kfp2hlZla0LFgpiV6zhjFYPxEABrdfWXgzc6jjnsUs4vgI
	 5WE60He3shpJIx400CpJJXEEZdL98NPs6FVaC0Azkug2tRRUK1fuUjjLZ5CwRRAPxj
	 K74DDF6UdV4Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
Date: Thu, 17 Sep 2026 09:03:46 -0400
Message-ID: <20260917130346.320238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091632-favorable-freefall-74c4@gregkh>
References: <2026091632-favorable-freefall-74c4@gregkh>
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
index bb0b172c5a74d..388904b6bc030 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -623,6 +623,7 @@ smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct smb311_posix_qinfo *
 	/* fattr->cf_rdev = le32_to_cpu(info->DeviceId); */
 
 	if (symlink) {
+		fattr->cf_mode &= ~S_IFMT;
 		fattr->cf_mode |= S_IFLNK;
 		fattr->cf_dtype = DT_LNK;
 	} else if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
-- 
2.53.0

