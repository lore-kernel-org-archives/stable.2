Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658632;
	b=RYuzzVpUaH5+zHcOTyrRM0j/bJWGr9ME79dbDD99qg8Rgvgr/CAvtzviS7cem5cSDE63
	 o+Us8QutyomwSFLAPSSn+0SXRj+7MDyIOKHOFzycXaDeE5VnpqGnNepuw+uYbQQXtJaJF
	 mBN5a7vAZ0O4pyiqhH2M3Rynl0HNVXqvld3Tvnen593VmaFzxbvVKe9Mk8SrD4sDQ6BrX
	 a+QcYEpVegSZPi/zqfMBPJW5zwqPh2dABiFmxcfstsh8/ayEv6MhdsnhOA22GP/6o9Noz
	 32glrZJtxAr2iihhdCBB+OSqd6ekzOofNALi/yxpf1rMLPeK6974/uU/5hNnC59pCKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XvP7vor8njeylWRaQgFcnSfpAOGtdso7JsoES3ggOpA=;
	b=sSkp8X1oZM+hEVTfBjUAFEh/HXXX/LcK9fuSuF0m7G4q2aO9/rN2NY5vfsaFe1JEQ/UI
	 usQFZDSKmFhAudrn+7LgNP8zqkHFtDXGY9PeITuJoSo8QGCWc21oUvm0uBfxuJuUU/0SO
	 atfOWSmXenQGk6LTK8KFqITMZVL/Tu/iL7/uRUlemmCWy8O5LXEvv6DNv6ThzPiZkpVSu
	 AYMkAbvITd8NVgNREbT6GILza//7tF1ZnvAarKjMJZqrDWD/LcP/oAVithL1vmxb/Hx1M
	 bt/4VxzHpeKpqooJ976W8CIX/I9cvXNtfBxn/O/JrS5Ev+NbVCmhy9YRHXWdD0mnfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6tRDfIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC88606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6tRDfIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129871F000C4;
	Thu, 26 Nov 2026 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658632;
	bh=XvP7vor8njeylWRaQgFcnSfpAOGtdso7JsoES3ggOpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6tRDfIiVWkRk30Q316B0qDJYcOWv4Gw0pAnkY8ZY6Jn9KU1YZtq46bjmEbJWxxk2
	 ibegREy3ugwN8xj8ra0xLIsKtY8FLk2LNvAuNKq/JuzSXclbX9/ue3sHjPWFKRwNWO
	 egSBzmvhllCbf8jy628+oK7zHKiwQ2w0+YvQKqiayW1o7J0Qo+GtloMjTAwmv34MVH
	 3B2IJ29R7YwYIjbqzl2kAtKSp9rXFCkt591JGBwqt714U5+Yx8VisQr+OtRFvG8Ha9
	 haLaSEngTscIbtAedk6WxVaiOKrrRrSrtPhmT5C2Reryy/mSoj17dLP6zIDjEMgsEp
	 kTHG+zZRAOrNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] cred: add prepare credential guard
Date: Wed, 25 Nov 2026 21:03:45 -0500
Message-ID: <20261126020308.1696715-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112548-vowed-carded-1ef2@gregkh>
References: <2026112548-vowed-carded-1ef2@gregkh>
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

[ Upstream commit c8ad3098e1272444b6c75910d6196a36f5c8bc17 ]

A lot of code uses the following pattern:

* prepare new credentials
* modify them for their use-case
* drop them

Support that easier with the new guard infrastructure.

Link: https://patch.msgid.link/20251103-work-creds-guards-prepare_creds-v1-1-b447b82f2c9b@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 86e2facd8630 ("ovl: bump the impure dir version when linking a file with origin")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cred.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index be2cd07b174c5..418c4a4ac2955 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -278,6 +278,11 @@ static inline void put_cred(const struct cred *cred)
 	put_cred_many(cred, 1);
 }
 
+DEFINE_CLASS(prepare_creds,
+	      struct cred *,
+	      if (_T) put_cred(_T),
+	      prepare_creds(), void)
+
 DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
 
 /**
-- 
2.53.0

