Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67732E7F25
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938682; cv=none; b=kwYgUa5mcuiwESNUDIJRk6rOWd3fV0AVUP9CNGK+9dVuK9fxZ6jjhMyexI1Jw5IAkSppwJV2nA78LpjKeoD3joGMB0wL2YiG92yZ8fPRbXjK0r5wnH1sR4UYxmJ2xQzjPdYNCOtTZ4Ll5me1dHFO6zJotT7/o5U//IhOQK5knZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938682; c=relaxed/simple;
	bh=F0rJGptZS9wkoD0qQ282BystLHkDX/e5BdO7XFA63qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKZgqJ7q36lOld/QzSRpShAhHRsq/0jO+ii1oycNfCrbOEeGodVG9AvAcB1FU5YI3Q7Jq773i1YJG4sWOroeDb6tgm325/RQROKhjc90XAB6fMO+v+r2BydBsUe2zJvC8iT+QhcOUqPz73QTPJ35SMQZM/wgsv0JNh8495e2NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv2x5JG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv2x5JG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312851F00893;
	Wed, 14 Oct 2026 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791938681;
	bh=AL+S0FCxaXNdlCoiAX/1LXThwI6k41QXYAfGGqFNUSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mv2x5JG0fZCTm0rc9dbBHKKh9s4UOIhkwmrRtRjOWnEZ5XE3QKa/D0D+AMkITgiir
	 pr6GpMS/08J4/ZPd/Ob5yQxrpDEULw1ZCePOAFhkKF5xT+9P4nbTmRHl00N3ntIUz2
	 WK/TK6kOBVoHbPJklWApzHlrAVEWNeFxx3CghPrUwjWlSHJtScX+yDWiWzrM1NDbpZ
	 PklKbWAJGnepqgVdR/IncwXFLhsUaLk5lP2HlZVO7f0CZfC3UTt2Wn1RkOlCWPIAVm
	 I8FbEZ7qvMAhXv8w1Ggkv5WJXl05+pMMLLEC4/itcUkJ3GDNHzXMjF5GuTxUd0uSTU
	 r2YwDcz1KyKGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] fcntl: refuse F_SET_RW_HINT on an immutable inode
Date: Tue, 13 Oct 2026 20:44:37 -0400
Message-ID: <20261014004346.1478485-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014004346.1478485-1-sashal@kernel.org>
References: <2026101223-sprinkled-coming-7d84@gregkh>
 <20261014004346.1478485-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 8e5389151804f..d2f2b27ecaa70 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -296,6 +296,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
 
+	/* nothing is ever written to it */
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
 	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EPERM;
 
-- 
2.53.0

