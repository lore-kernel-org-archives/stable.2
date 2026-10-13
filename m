Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983135625FE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932689; cv=none; b=r76uSLr4aEOE4Zna3nEXNr6NP1xGyT/ku5rQCmxlSLmOei3uwJ+KxUnuLU9YHFvx2nUkhwMCfM/TDLw1JUMufU8Q1w3qpU+/5RGQ3aOwTgpwno23h7Ixq5oNQaOLh2yv0hQst62yI4gKeSFGlbu8DCvar6VtwdO1ysKJkxFkBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932689; c=relaxed/simple;
	bh=RibZqkAW123g5McNBc/gZ14G0thh0uINRssN4qvv3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMIH8FsFKA6NJm6mj0pD85UF4FDBfniISUcKkf08pKKWsOwg2QwrZ9kZfaL4XlxwXEQRyFYdjmH4XARQHMCogPAGlut54gWXPadOG+oVM0BmRjEiydDVc5RXdzqblQv5TSQi7XWE4zS8rNpi9eld1Cu2XdZbsZdf55vdcM9se8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT2rUNN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT2rUNN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E511F000FF;
	Tue, 13 Oct 2026 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932687;
	bh=sYT2WG19xbMfT2Mkk6aQwhwVe4LU3+cp52YSJ4IYr0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UT2rUNN0Me5AYqKn1Yl7Dz7Di362kMLFuesSrEX8DvbnDTdB43P9vNwrQoUsAgx17
	 5AVNCQbLpCFoOQqAhwMVbZj5WAN9Par4UYP2Wct2Ddqo5gJ/fPFXppBpFz0h0AGyU3
	 SH/TbCnuih17QhkBkWbXAdxzy/5s3v9mBa4eaEDR0P2mZ5eEyUkRumQNlxpfAKSOzj
	 sPP8DBZUzHXl+INdpjvUCkAXP4qUwbpMM1LOUU/OSin7k4HWHxBtOghMnCfmP7br+2
	 ofk5buGCOmqveXW0MKs29ozcOfwqisjLd4b17dtt4xQVxtRwW0+EvSfWSTJw3RMOHR
	 P1ktwUZ6JoCQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fcntl: refuse F_SET_RW_HINT on an immutable inode
Date: Tue, 13 Oct 2026 19:04:45 -0400
Message-ID: <20261013230339.760451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101222-human-eradicate-1a07@gregkh>
References: <2026101222-human-eradicate-1a07@gregkh>
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
[ sashal: Adjusted context due to the missing inode_owner_or_capable() check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c4cdee6a78005..cb40e1f661eb2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -374,6 +374,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
 
+	/* nothing is ever written to it */
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
 	if (!rw_hint_valid(hint))
-- 
2.53.0

