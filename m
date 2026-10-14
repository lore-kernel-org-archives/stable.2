Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37174FD27D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975938; cv=none; b=Dq13shQuXfioqkQ5ayi3gkEpnDBzlxvXuE3/fWbLTlIFeCERWvGljlE+H2nMw8lR3fBlcFewlQJCgSORyTAfVsmXw/dz24sY3kQh7YIjdqDXJ6/it2KXX+XdFo3oLDOFBqnLu5TVDDNsyrGQ60f4is7Ww1In2YHv6/XywewGuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975938; c=relaxed/simple;
	bh=58y+6+mIb1R0gGxoPk0voy1cUySSJ1rejVY29k0Nn0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgF3ZROcytiVcDul/1Q1QwHeHVsqBWxe/Cq8fzBNPYkcslOpAITQ7OAAoDwg+fCF8Xo+YDieQVAx29XU4ivpE1plwRp9YlMB2wKsXzo5JzLaJK/isPkn7UBGvaH1yID2k0qBzXfGrwGA9koce6sbj1fyJXGwL+ddA0YNCTXSVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/WBH3Q9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/WBH3Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD951F000FF;
	Wed, 14 Oct 2026 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975933;
	bh=BjvsMvvKN/6VkaNwjW/lbCkjw6SAdZV/lcF5I33NCkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/WBH3Q9rDsY8azxB5pCPzwEH/RHFBWufE+EUqecFaI7r69Ns7n4DpbUX5gyZAYkn
	 0Txkbu2B55rrJf3Cnr6G/55OCsi1F4+2rJURElNdQuRFNRuodzy3aE+Yf+/Bgvz+ke
	 qGb3MgUwaO4K2TFHSwtO/16JrauH3XfreHYK2TJks0UlfYgShhTT9jDX9dP8qgDIXA
	 X89hE5cEs0QrabGafEiGESPBZo99s86Z31r8Iq0jIb9Bdmvt63z8N/SMFCA83Y4Bcv
	 IzjkpiypCKEV0/Xtl5Yf8ZBSAPPJIo37e0MWt5g9kEqUfp2LFAqB1cmaoot0T0x+PW
	 wFMzhV93L1/eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fcntl: refuse F_SET_RW_HINT on an immutable inode
Date: Wed, 14 Oct 2026 07:05:31 -0400
Message-ID: <20261014110453.1964456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101225-umbrella-overlabor-1e8a@gregkh>
References: <2026101225-umbrella-overlabor-1e8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit b0d1022b9bdb1e98aa7fb3244fdd50a58c61766c ]

An immutable inode is never written to so write hints are pointless.
Refuse the hint on an immutable inode the way setattr(), fallocate() and
etxattr() refuse their changes.

Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-3-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Moved the check from fcntl_set_rw_hint() to the F_SET_RW_HINT case in fcntl_rw_hint(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index a06b51f1af5cf..df1acf6236ee9 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -306,6 +306,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
+		/* nothing is ever written to it */
+		if (IS_IMMUTABLE(inode))
+			return -EPERM;
 		if (copy_from_user(&h, argp, sizeof(h)))
 			return -EFAULT;
 		hint = (enum rw_hint) h;
-- 
2.53.0

