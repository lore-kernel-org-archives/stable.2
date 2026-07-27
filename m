Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9F3BB67B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190873; cv=none; b=lfrreOAVeI1Kl87Qs5Qr8wuyexBqNX+xPkk8oMr1/ZQJek4wTfOHSKJEevcxwkN/4eULgwm0h4krbygISQ1TWM/SfRuBmT2SA9Pc2yVbXFWkmuaSmrXLkeOAeQ11pygX8MZEUZEtLjyWt1p0JxQlcNkQRqI0tbNORZz4V8laSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190873; c=relaxed/simple;
	bh=A58Mb6ah+c/TzyjxA4HLFxh7uPE6/RJubaqdQx8QvK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh/30ZQkAsQS6LcF6JG/ZP0x5vgj+EeE5F8xafyQ02bW8H97CLh4xddbtFQpFW/tbR1WySUSnZ/Ayn8SUnEVdvO0JJxUL9g/fD1uq6sAHV2ShT0kcYYRGBs8xlJiAmF5+tita5fAtEJT7rFS3rilQoZ5I8JH6Rg6cxq6ZtA5epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUmnfeXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUmnfeXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8B91F00A3F;
	Mon, 27 Jul 2026 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190872;
	bh=VACQneQv7OjfAoaDqcnh00ITmYgvQGRj0wD+VAoOsSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUmnfeXjuA4+Iuil9yRdaXiK5Qg/wPiUVG9KpVW1MEYkJ30nDMbkezl82bslntWIP
	 ci2ZyW9mKIuNMXRSfIj77HAUwAnqf/Vcox7S3tQ9FAxx9w8HDr8ROG0ahKzlMnQLds
	 s7023/hHufC+T22BwWUI7IV+rjtp2nbO64cAp0KuvzGYY+Ahoan6bbNUa4dO72jp9t
	 PUA/EnuxW+c9aPPnbTV5IXmdOla8jgdVeUD84dUkMf29/lFnnrEUkSJ0fJ5r16+poX
	 IElkoqmgH1aul+pwTGp/JhXrFydLaugmxFCaNHCRXuXP8XBZ+cDkRkdy8shkvynZS/
	 A2ZL8ZeCmOFGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] cred: add kernel_cred() helper
Date: Mon, 27 Jul 2026 18:21:07 -0400
Message-ID: <20260727222109.2119761-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727222109.2119761-1-sashal@kernel.org>
References: <2026072043-kennel-tasting-5eb0@gregkh>
 <20260727222109.2119761-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 4c7ceeb62d3330b6fb2b549ae833a92c0f481f3e ]

Access kernel creds based off of init_task. This will let us avoid any
direct access to init_cred.

Link: https://patch.msgid.link/20251103-work-creds-init_cred-v1-2-cb3ec8711a6a@kernel.org
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 981ccd97f715 ("dm: avoid leaking the caller's thread keyring via the table device file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cred.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a32f..50a41b82f79c70 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -20,6 +20,8 @@
 struct cred;
 struct inode;
 
+extern struct task_struct init_task;
+
 /*
  * COW Supplementary groups list
  */
@@ -158,6 +160,11 @@ extern void abort_creds(struct cred *);
 extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
+static inline const struct cred *kernel_cred(void)
+{
+	/* shut up sparse */
+	return rcu_dereference_raw(init_task.cred);
+}
 extern int set_security_override(struct cred *, u32);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
-- 
2.53.0

