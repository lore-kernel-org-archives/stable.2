Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CD318B9C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941318; cv=none; b=uXoHUps1nWOY6FhVGFGqEDUwg4C1k+yu/bwkEU9DDc3MCdHNJjpQhl68RLZ81Gb+mbDtfPiSDs0yXgeGt7lczCRx8lxaIO8NLssdvAtxZy1Asvh+7JtQKuw9rBOHa1EhTsNOqHwf7zagg+8Dniivd1ffKivGZxbhhQWGlxIPwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941318; c=relaxed/simple;
	bh=Y1AU5/CLMU9460AdK4MoC1kWgLdyfvMcFWeKgfAvvRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5wweJbqARDf1PnsNGMhYuSgzQNRKgd4U8urvsYQPUi8liP8TDRWfyD5Wt8PxAsh6bHTgBlY+Her45ro9+ORvLxUdJ6+ulIV77iN4oY4/hultTgKIoBlfjWPIyg2gEbyZ0ya1w8Zjoa0r6JNlqzNQO0MZbkHnbwov/mjFePqbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULXHODt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULXHODt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15831F000FF;
	Wed, 14 Oct 2026 01:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941317;
	bh=LMJoG/c0mwexSbuKltSyYmegn/4pQ1M9dRkdBn3eg+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULXHODt4iUQaI497SXXpEN5K2XvvwjcPc2mGpEfo3mtGm9vwtZBIwkGwm/a8310QT
	 0WROO2vq+uSjYrpe/O+Szq79p2F/+aYrgbMIEvxHFDJ8pjwaYVoaWVpumXq7opRjtE
	 uHDTTViTqaxUMOlHcjcN9tHm8rku0B4txL/yoZvPIp6Ov6OBYP6qdOzSLtmV2qB3aO
	 sjT7olRhrAb9XfvVgA0NCcWVsxnIy6MBxXPwWnwmAvoW31+bd84phbcaJo0iDgyjWl
	 IIGcRsa26sLs/DFNL49EPOIV9BFDB1Rtg806OrURSBJctI7NuMNBlTEEiVhdP33AQu
	 1Fe4jDFQUsLMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fcntl: refuse F_SET_RW_HINT on an immutable inode
Date: Tue, 13 Oct 2026 21:28:35 -0400
Message-ID: <20261014012800.1615012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101224-scoring-lent-e33f@gregkh>
References: <2026101224-scoring-lent-e33f@gregkh>
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
[ sashal: Moved the check from fcntl_set_rw_hint() to the F_SET_RW_HINT case in the combined fcntl_rw_hint() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 1bde178e4aa2e..13ba6b47877b8 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -290,6 +290,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
+		/* nothing is ever written to it */
+		if (IS_IMMUTABLE(inode))
+			return -EPERM;
 		if (copy_from_user(&hint, argp, sizeof(hint)))
 			return -EFAULT;
 		if (!rw_hint_valid(hint))
-- 
2.53.0

