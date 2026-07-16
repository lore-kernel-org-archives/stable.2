Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5623536B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200848; cv=none; b=LySBXWSGqEuWDpE8/f354mzNKX12dERhNU9nkfFU3+ZUgkIJqRsd21i2AnGEoHy3KdMJyqV1FbbcNLKe2IgxSeqsi94AVAE6aZrbyKLLZEn59wYivT/8np4DJQ+N3SIaPrWDKnEXiMJe6Tzf3CrpTFgUeboFW4en0iIN8WQ3D6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200848; c=relaxed/simple;
	bh=uFIxZogsCMPPblt7t3e9ZnJgdtq8ReFnbVz8ZGkQ1+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thjF6nT7mKTm0Hx8gWDGFKXD/TzoeRAN76TC09J29rMpXP76o9FkfaBGCql91V00E3yce6hfOfjzEvnEMlaoXGrBTCKvXFm8g6Lk+EOIciGo4qPQSqTMJxtQE2Kdr8TZWJhn+T+RWNEkfjgvDyTb9guB+62TKyr97peQJ2QJBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3d4mjQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3d4mjQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C931F000E9;
	Thu, 16 Jul 2026 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784200846;
	bh=l7MOk5pGF3JykyNMbehVAEnsm2wMl2aKoJOI+dCh3BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k3d4mjQ4vtQnx4FCR/gK6KDrIRizkY9UchBW3/FGy5PvLs0VLDdQ8FgIKgVrBohvV
	 uegsFeZ5rlsSgu8cIK7iRwmmDM1dKi/LOc/XxMPFkMtq18aDhU6cSCzQoEagDkTBZC
	 ZhMPORbdMsejbhTo2TIFH99hPSaWqJbSFXAQJRHQh75CnxNj/u+9HjGiEVWTnTob8t
	 yMXFerXzj/ACFnyAHbEUva2/uMr3+83n9dF0Q4jZ/29cJUuUzmeQcbLPz6paVOEHIr
	 qd/zV+5tRO+NDOwW68etev0DN2m6auEGbXKGXeX/hfZRDmCOvgK7AwbsIzB33KQee4
	 YbRNGfi2rMf5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] ksmbd_vfs_rename(): vfs_path_parent_lookup() accepts ERR_PTR() as name
Date: Thu, 16 Jul 2026 07:20:41 -0400
Message-ID: <20260716112043.1732826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071450-trespass-dispense-fb1b@gregkh>
References: <2026071450-trespass-dispense-fb1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit ba33ac100d3feb1efb43b32e63cc0c6430936aa3 ]

no need to check in the caller

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 1c8951963d8e ("ksmbd: fix path resolution in ksmbd_vfs_kern_path_create")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index eec509d3a7fa01..a630994187a775 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -708,10 +708,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		return -ENOMEM;
 
 	to = getname_kernel(newname);
-	if (IS_ERR(to)) {
-		err = PTR_ERR(to);
-		goto revert_fsids;
-	}
 
 retry:
 	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
@@ -812,7 +808,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	}
 out1:
 	putname(to);
-revert_fsids:
 	ksmbd_revert_fsids(work);
 	return err;
 }
-- 
2.53.0

