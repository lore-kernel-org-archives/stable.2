Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B44A4EFD
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105640; cv=none; b=fthfFazWmo3W4x0Sxt7WnR1/C04ggr5hABkfMc/bKfqjcMxmUjmD3Z3pgb6491cDhRqmTtcmrVcOE9tO4MRKtscFc8o6fgHNdrZ2ZlKdJg4esibOHsjbyJlLcR6bAcQ/f1shjoZewPNyRyS9xGr4tXcj1LT32hCFFZNbnIhYKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105640; c=relaxed/simple;
	bh=bDuBuAQ9lK+WseZYkkKDPbltdATfGi+USN1Ltt6otK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJEej4c6PoAbsLfeI6tHuFsQNbh9awuJZVfwPpLuTMygLeX5Nr1uf9gff5MiNFmRNRZ5ehbnd3uDh0N9a582OtOWpX61pOlvbtfGZqw/d871L7EVHB+fpx7o1r4HuFoX61tLZ25U9KsTJyQ7sQke6C7N9sin8lR4AZE/mIN8x6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0d+reFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0d+reFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456381F000FF;
	Tue, 22 Sep 2026 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105638;
	bh=FG5LVEwpdDNorrN13hXU4Tu2wGINFbp7qCSznSR+rX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0d+reFwCJIvrr+giNteHH0RZIvzsGhSJ4Xuu/uDIlRcS3ht16WMHewXfJARDtgFD
	 P79JY7C5Fxm/Fq3rVoeeoUgYKFai2hWivgWtxUujiOorMUKeFRqRzpLO4hBjOsBI7R
	 Di+QM5+GLd/mw05BdggKs+zatSwtUHt8LnDaAbgiyuZOiUNDFwry3KmRETWO7LNaNC
	 1JpgWIzpoKfMi6NOp4C7uKxaUWybMmROXPOBOLmZN4aPaOxMpWc0p5bzHysF6eOAoK
	 +Xt8ELybV/7e72imCS514V4UX8A1NuOcSngG/4gor063CqRhUPO1TmqoGi6DBOJdyx
	 /j+nPntW+Qx6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bharath SM <bharathsm@microsoft.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] smb: mark the new channel addition log as informational log with cifs_info
Date: Tue, 22 Sep 2026 15:33:55 -0400
Message-ID: <20260922193356.4155447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092253-trailing-directed-c0c9@gregkh>
References: <2026092253-trailing-directed-c0c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bharath SM <bharathsm@microsoft.com>

[ Upstream commit faf1b64888ff13caa94fa09835fcfdabee18b057 ]

For multichannel mounts, when a new channel is successfully opened
we currently log 'successfully opened new channel on iface: <>' as
cifs_dbg(VFS..)  which is eventually translated into a pr_err log.
Marking these informational logs as error logs may lead to confusion
for users so they will now be logged as info logs instead.

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d034e836eefd ("smb: client: fix use-after-free of iface in cifs_try_adding_channels()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 458d6922826f5..84bc7f70dbbea 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -267,7 +267,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 
 			iface->num_channels++;
 			iface->weight_fulfilled++;
-			cifs_dbg(VFS, "successfully opened new channel on iface:%pIS\n",
+			cifs_info("successfully opened new channel on iface:%pIS\n",
 				 &iface->sockaddr);
 			break;
 		}
-- 
2.53.0

