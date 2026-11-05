Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904881;
	b=1BHFcMo9Lo9G60wheOJ+zBKyzN+4e6t0woegf07gm5qmGsA/JBRS+z/TxGwmfXFfdWnE
	 jofUsW0eKCXu6uPamI3QNWzCRfHJXp55NKkByy1+CzCYRAFHTGdnNNNULKrU/fEPetI/m
	 64dciP5kA5jwS2JnHSlpMz8PxTZGeUcu3SG/gs6Uozj+YDNecMoIhNIMN0lYXeHMeIjKV
	 WDDsMeuX+rG0COxD56B7RSMLBAUBYltICykQZpSmnVslURii7Hzh/1oec0PESp9HcLybF
	 X3O/ewFA4nLkMxI4mr6/ikNs2haUdKxmAX+5BcWAr66s4qZEKZkbDTX1akB4m+R3gMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9L9I/in43IWbNs7j+C8FRahBLCI2ibZryaerFqjUezw=;
	b=lIsfcTX43kxvDD0vEDxD3HL6zph2YS00M+TOwBslGX6nrj9L6n9f2qaSeA4twcwAWy+0
	 ZoVKQZCmotJwbb7B/u567XxMUYypbDSw43K8kMWYGCfjb5OPFVM7urxvB4DbMiXVdzCge
	 RYJIfdGE09U4XVGj0RdG96P2GCXvpyPTNb3RbxTzDCC2zNEUyDSniwioFvvw0do2jnp00
	 7NjpzRqbDe99SBE7FQwlRFFY0aeP53fLIXtVuz0lqnTWGG6ci3JhdtRb15Sh5nqSXERAO
	 /CGp4FGTuc4sKkMiCodlW8ZEWtkhMuZp/u9f1810LCn0bHxhlrHn6IJmQqqjTnhn+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMWkIR9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3786606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMWkIR9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06421F0093A;
	Thu,  5 Nov 2026 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904880;
	bh=9L9I/in43IWbNs7j+C8FRahBLCI2ibZryaerFqjUezw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMWkIR9rGexAavg6ezj9GORNB7jHXLj47jtxIubQcQQV6ipchIZ6Sl/OGXAPSFKsM
	 sG8PXjPsVebB+fJllTZhSkspufxqzVDY7tFM4Fh3tl3qiCyb4TO82k3eUkN0LUBs4v
	 G7IOrLOYY9ObnvO60SsHmeHtQzUoXCmIEV1XKuyvGYRETfuBjPsyAk97+A06/C/tMt
	 wBb9Ajzgk2pACVpirH2XEHfbs1AlGoPh/h9JmttudK4wHrV8GCIs06fc3hppy2MbKf
	 RIRPnYI6yI8LpA8bBpnTcvDO1hlf7rIjk3jJj0JLQz0zEvCCVdJ7+ipT856TkigJSN
	 owcvr8M9kWcUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: VeroFess <coderzeng@hotmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: server: size directory name conversion buffer correctly
Date: Thu,  5 Nov 2026 13:54:38 -0500
Message-ID: <20261105185418.2278834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110425-refining-slum-bcbe@gregkh>
References: <2026110425-refining-slum-bcbe@gregkh>
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

From: VeroFess <coderzeng@hotmail.com>

[ Upstream commit f1f37834eaba5904103af1f18afe3510c7e9dc71 ]

A 2048-byte ASCII directory name needs 4098 bytes when converted to
UTF-16, including the terminator. ksmbd_convert_dir_info_name() caps
its allocation at PATH_MAX and writes past the end of that buffer.

Allocate space for one UTF-16 code unit per input byte plus the
terminator. Use kmalloc_array() to check the size calculation.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: gpt 6 sol with daybreak blue
Signed-off-by: VeroFess <coderzeng@hotmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: replaced KSMBD_DEFAULT_GFP with GFP_KERNEL to preserve the existing allocation policy ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/misc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 11314f7c622a6..42fa55c0027d6 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -322,12 +322,13 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				  int *conv_len)
 {
 	char *conv;
-	int  sz = min(4 * d_info->name_len, PATH_MAX);
 
-	if (!sz)
+	if (d_info->name_len <= 0)
 		return NULL;
 
-	conv = kmalloc(sz, GFP_KERNEL);
+	/* One UTF-16 code unit per input byte, plus the terminating NUL. */
+	conv = kmalloc_array((size_t)d_info->name_len + 1,
+			     sizeof(__le16), GFP_KERNEL);
 	if (!conv)
 		return NULL;
 
@@ -336,7 +337,6 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				      d_info->name_len, local_nls, 0);
 	*conv_len *= 2;
 
-	/* We allocate buffer twice bigger than needed. */
 	conv[*conv_len] = 0x00;
 	conv[*conv_len + 1] = 0x00;
 	return conv;
-- 
2.53.0

