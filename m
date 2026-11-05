Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881238;
	b=YGPpqu7HakQLekb64mSuvdUbTQeejhUEwB+sDGmylYAP8HL9vd9nk6pk0aJzvKUZBsSc
	 Xz7ax/tY7y+Dze0MFvDpQB+1aq79yuE8oXnEx9cNx1RfJqJ/rJw8mss9AmZV44QSF453f
	 dvHGJjxAiaGxCx3ms+qau3oSl3cjCcCVoo6StdmykVyXf7knsqDh58fCQp5PdNvH9ni+G
	 bM8NhR9atdhRJUOMB4Wx58Lyslac/p+daYDq0tPIR6Y3FFYbO83c0CCYspC1bOk7u8VaC
	 s07j+oNh4917Taf5Zzot+nOxmHB5UIUI5xX/pxgpG1mlTBkUgIxpVE22nIPif9aKtDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eljYg29ISc7quLp/sHTaCZh8K85pG/MyjlCOLv+A17g=;
	b=ymbDvYXEpIahl0KDbwjGrO4oEnI+hGCw0rApLIAO3sxudIwXvsJLRd5CQEPg4vEgptXy
	 9dhbbfjzCC4RC37ioopJ556DPQJjH5/7NxdtSY2vxQSCJ0K6nAyZnn5OYyOj0UCm1zC2D
	 apchauaCja8bQg40nOfQOy1xRCBtkULBtXbW2CcKygH8a9IGyg8kIOD+VOeHFH9drYJly
	 ZIG1hxYH1m0QzGhs8VWvja0+sVu8Wb0fqViTMnfFVKXlOnDBZhf6Q3RpRjI+lqip4eZAN
	 3HW0nndWUOZHLi5djFuVGf05JGXoUd9GB4bOptSaFV9qJRCnW7wra/V1U8HjuYu0OGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsCoSR6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC1606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsCoSR6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD7A1F000C1;
	Thu,  5 Nov 2026 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881238;
	bh=eljYg29ISc7quLp/sHTaCZh8K85pG/MyjlCOLv+A17g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsCoSR6VH5NMFWXRyB0do1MLAPXaisrETIQq3HzmW2w6YWQRulQo9yVggLg6N37l3
	 WfPesMSltNKJEs3FBaOVYVJmiI2A8DxrPSQGv/TP6ygK5vo1g+gpfUVIKTvaxOmsIm
	 WGgJYk507T4r90WLMcFFqPlzC7nUJh4fFdskwdHcjjvmNiodnTBCktxB833qHrNVNM
	 Qbwpu/AdELI4CDUbc1HdS9+z0xFS9pLvnasCVKzVttjVaC2p8uX79IYwkBd9xmX3Mn
	 KtVzKX0PySzGZkMyhGw0i0yAZ0yavBcIq32iEkB3Bu2P2z+pxwbvMyz6HSbG8CRho6
	 wRtjqQHXcVbZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] ovl: add ovl_upper_mnt_userns() wrapper
Date: Thu,  5 Nov 2026 07:20:33 -0500
Message-ID: <20261105121919.1276067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110419-skeptic-dictation-d90e@gregkh>
References: <2026110419-skeptic-dictation-d90e@gregkh>
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

[ Upstream commit b65c20acef23cea2989c9f23414930149d38962f ]

Add a tiny wrapper to retrieve the upper mount's idmapping. Have it
return the initial idmapping until we have prepared and converted all
places to take the relevant idmapping into account. Then we can switch
on idmapped layer support by having ovl_upper_mnt_userns() return the
upper mount's idmapping.

Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: 755b5c5c9277 ("ovl: do not copy up an xattr value that was never read")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/ovl_entry.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 08031638bbeec..e319e9969c3a6 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -99,6 +99,11 @@ static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
 	return ofs->layers[0].mnt;
 }
 
+static inline struct user_namespace *ovl_upper_mnt_userns(struct ovl_fs *ofs)
+{
+	return &init_user_ns;
+}
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
 	return (struct ovl_fs *)sb->s_fs_info;
-- 
2.53.0

