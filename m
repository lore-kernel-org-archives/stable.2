Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF573D668B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649385; cv=none; b=RP6fTaZulGt2FqjfsnF2dL38+mdb4e98dXwi3roUtMJ2LWSXK2hQVtQds7HNRXxkA8FGbaCB3aZ3F7Aouap4yKzGwMj5H6zNj5M/xU6W1OYWzc9nfI7uNiwS8zSFISRFB1EYaEjm9zEAxIPS/95xl/l+UYkxACIo+Gigzmd1Ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649385; c=relaxed/simple;
	bh=I96A8Moz1Ti1D1nMgxeSfe/kzDg/5lTS6PZIUkDnGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4qNTaU4BRR0VgQPmBzBzU9kuMunX9EasHMKf8HdvYfB0DwlhAhxAzo2rQw6kNq9Ddc8JjQF37H9mnQ3QlCc0flv5ntyv32NUngHfmSf7+oPf35OWFtUhvi7LJ5B8G8AjF+9Ma8c1u4yYfvjXFmbLdMBHrkAQl7XaRX+MwEwaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKccjkMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKccjkMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA61F0089B;
	Thu, 17 Sep 2026 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789649370;
	bh=7H9L5uqLPsmiGDDOE7N1d1DRLa5HE5jRGSTgbDhmWLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKccjkMYy+sgfUbgWm2ywmXSxM3qKlnSNXwqPtNeAU8IYN5xNacjD6Kl55LGp2V/V
	 LhkEqgOjq3UA9XT2okthfdHsAi/qT1fVAG1utTArsjkJP3kyBEzGfX6OTrvjfk+hnK
	 k5uGWBoUTiOPuTMuatLzu9i0Dvx8RKG+lAe+CCx3iwaKTBv6rZZiv3Q9jNSIf1hYO+
	 a3717sneOPirbY5y6xSn7UJLEvvE6eydyvqSTbQ2nco6vKARzzlssCPCMxZOg2s3b+
	 m7AE5BFdWsU3KPvo9J0RKV0Oj0GAKTHAWcc2aJ51js/whNvtnc2QCK7S14BuRslMgF
	 YhoKHwuJBBsCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix file type corruption in cifs_reparse_point_to_fattr()
Date: Thu, 17 Sep 2026 08:49:28 -0400
Message-ID: <20260917124928.227996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091631-outsider-blog-cbef@gregkh>
References: <2026091631-outsider-blog-cbef@gregkh>
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
 fs/smb/client/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 51d38449ca855..5d21cb051a602 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -672,6 +672,7 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct cifs_ope
 	/* fattr->cf_rdev = le32_to_cpu(info->DeviceId); */
 
 	if (symlink) {
+		fattr->cf_mode &= ~S_IFMT;
 		fattr->cf_mode |= S_IFLNK;
 		fattr->cf_dtype = DT_LNK;
 		fattr->cf_symlink_target = data->symlink_target;
-- 
2.53.0

