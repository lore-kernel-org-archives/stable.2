Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448809;
	b=xueg9C7Jha/HBvvG56VBveco/Oi6+BX4q7XEVQWy9I94qmnk3osWqBoqqffjtclyWHFo
	 L2g/sWnZLqzT7sz5oRh64rgjjWB5UbWeRzCkXJbV4Xk0hbWkIfwDiexOQTalnfZsZG3mw
	 k9EgdpybTKgR+SrfWoPoNukSRQZEP7uxhUowdXZzB/4VQi9WI8DdCZ0PA6ljT+uM+RRJc
	 8tFlzOjZzki/glgD1f+hffwoMVIfRXj/TPMM5iP6ThmlXWj2q/55HgyYhPnCvw/zForJz
	 2M5lR1dPtIQd50ZEUNii8aOUcKIhdeQG+9sr3m/Cgnql+MOpHKKNjM/nQ84aQ3ewl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p6pv7M/JWsaPvSmlv5KJ1696ZIru3UxBU6noSW7wdAE=;
	b=sB4wRI1huBnJC9HpFblVF3F+Lf3EsfuVd1mqsgYblUpKyI/3acvKZZxPn/GpjM1p069g
	 D77CujvCdwt9Udn8+WtJABpkLy0BoUhB4upHj+x+5NBX+t7SzlUn2rb2L3MThGAvqh4/c
	 1igSmzNGJBx9splM5xtrXYniLoZ2i00A8kii42ICqwzZoVidHNLTEUn/RzZrlZ+8s8iCR
	 rm46ijaDPqc7XjyS7ofIng/YdgReR1toxIFU6c9WAdKh5thznJVtxiymJ7MtqXLkwqwbU
	 3U1HpaGEtU58PrtdLuG0rP7kEuXx/BADSriapC5bhVWFDQTgZXCz9bHmRtqEAck+Qqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aL8naP6N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D5606A894
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aL8naP6N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270881F00A06;
	Thu, 12 Nov 2026 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448809;
	bh=p6pv7M/JWsaPvSmlv5KJ1696ZIru3UxBU6noSW7wdAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aL8naP6NLwEk34W6ygGLVZmfjm84Ih0QNjUcBNMEco+usckxtSCph9qDu2RGqO09Q
	 vi2hMIiFPIXo4BMfTKYxlwGkvWQm80L62PsHYMOGs6kRbjSdfT1mkb0HkpVMGHoDDc
	 pmMmO4Td+hx2d4EuNZt7otIizfpxQP5X7CfrnEZ/9q30v/pFlJjoC2/LWHNQ8Tkfga
	 v8b8CnLVMMkcUNhZjb54gFXtfKgnKA9MYL+mwtrgcm/M9hmSxwEDvBkvPN//hxbJ/J
	 Yx9SDpHVUGByF8RNUDtaTf73rli1P6rJCMZ/gFYDVO17x0y1/rteEHTECztjEXEeWR
	 ga2+MMG4IT/Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ovl: port ovl_dir_llseek() to cred guard
Date: Wed, 11 Nov 2026 21:00:06 -0500
Message-ID: <20261112015754.1242132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200528-failed-6.18-323899b4ed23@kernel.org>
References: <20261109200528-failed-6.18-323899b4ed23@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 5517646e14d18768ee72ae2f4320826f2169329a ]

Use the scoped ovl cred guard.

Link: https://patch.msgid.link/20251117-work-ovl-cred-guard-v4-26-b31603935724@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 323899b4ed23 ("ovl: inherit FMODE_NONOTIFY when opening directory realfiles")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 9ccbf78389f82..7fa4fecf15360 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -959,14 +959,8 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
-	struct file *res;
-	const struct cred *old_cred;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	ovl_revert_creds(old_cred);
-
-	return res;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*
-- 
2.53.0

