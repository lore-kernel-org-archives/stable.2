Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FA3BF67A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190874; cv=none; b=othehoJF4OEddx72mrcWXEH5evRMhIHx3YTzi0JQ4xMdAmxwbRK2UseQd0ldfu4zKAkD5Peapvb7dTM6nMko36nmgLlz4YjnGFy3C5coU9squcD2t9s0VKks2AS3E6XpFbkjtFA8dL4v1y0OI0/7CaZqBPtmVOdBw6AotQSueUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190874; c=relaxed/simple;
	bh=Kg07P+FgDiQSHEZ98cXQVq0tex3XmnfBrd2e8iWzJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgezWZQM9IJEn5olkQiy8yQG1NZK/JvXzzGwueMLh65tIylUgnjKLSNbQ4k0ruanOa5U0nlQ/54rNM2WLVF28T1JE17q+XMI792eB9f2LTmJ7b1jpVgf//WN7hTDtwdLY45zgtHTKyEGw6THTuO8aMEiuvXoxMruEOWofaF8ixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnZAG8WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnZAG8WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACC41F00A3E;
	Mon, 27 Jul 2026 22:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190873;
	bh=2TwWrI5UrIkTCUqjmKLtoctC3hzS98ZuUmbUDjPTDB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnZAG8WWa6qKPRrSYorXrMt5OYTQD7/F0SPYYFSk2ZQNvaBJNmH3vaUOQzR9/BglQ
	 vqrM64maJI1N8sGYT6xqNE3cX9XfoTUC6p2A7ALfC3D2s1zR9Ug2HEmkBmWHQDj54C
	 XVRvsQl5SZxgaAy/XnOZSO93/QPT5UdNHiBzi+Eh1MB+9OSEA6kjeaf84LZcIKikCB
	 45aRLLkbwAtYldZaaYv6KAIacgzAM1U/sBZ7BpAbdrmVUGbsBzJgE4CI9T4VcmUQX/
	 pTMrqtYXPYiqGFb7usAbp9JdNMk+UQrTm3xQlcI8ctza6RunLtwq643OOlxG9ye5zE
	 dmME2vjs+mOGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] cred: add scoped_with_kernel_creds()
Date: Mon, 27 Jul 2026 18:21:08 -0400
Message-ID: <20260727222109.2119761-4-sashal@kernel.org>
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

[ Upstream commit ae40e6c65791f47c76cc14d0cce2707fe6053f72 ]

Add a new cleanup class for override creds. We can make use of this in a
bunch of places going forward.

Based on this scoped_with_kernel_creds() that can be used to temporarily
assume kernel credentials for specific tasks such as firmware loading,
or coredump socket connections. At no point will the caller interact
with the kernel credentials directly.

Link: https://patch.msgid.link/20251103-work-creds-init_cred-v1-4-cb3ec8711a6a@kernel.org
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 981ccd97f715 ("dm: avoid leaking the caller's thread keyring via the table device file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cred.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 50a41b82f79c70..bc1ee63a572c0d 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -205,6 +205,14 @@ static inline struct cred *get_new_cred(struct cred *cred)
 	return get_new_cred_many(cred, 1);
 }
 
+DEFINE_CLASS(override_creds,
+	     const struct cred *,
+	     revert_creds(_T),
+	     override_creds(override_cred), const struct cred *override_cred)
+
+#define scoped_with_kernel_creds() \
+	scoped_class(override_creds, __UNIQUE_ID(cred), kernel_cred())
+
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference
-- 
2.53.0

