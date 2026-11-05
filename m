Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898830;
	b=WjH0O3rrYhxyVPu8XlrrIdzyntP//ZZbOdyPyMrCS1IgLOepUvNkFdNiyGsQ5DdFKEK8
	 K+q/dE77wHk1lRU4+mhKvwxw8tRrioy6KclBzdNB4JBudb3i4C3tZHpBQx5WhhlatMd7y
	 cEAXyr4m+feq23Kwt8TgquFh0JLaUwu1xX389TxfxszbZW8bAmujhuK5sf6Si7BTr9b15
	 zkSgslLgxoGa2kZWmPVKAbqH7w3CTmFGzpWaUZymVtyFplVCrFwN/AwrIziw6P66Pavsl
	 LZqdWbbL6pIG7RcsjzYuCwJOOFdL30oSknGge5khUBec+09R5LEOZrAzNBK1QcznBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e9lbHjL1/Sm4sdjLBSc6zBB9t6Ek9LZiuMFNDdw3z94=;
	b=IizghSPLbR3F+A+r1ACz5cUz5S/5jMCtHrTR+crg0n1HyoJc2P/WLdU3vuLgTC9LakA/
	 YfJG1HPPoQqgEhBlFHq648si83Gmrc71snGW9yQvCKt18djny5l0ktruS+6fXwGksscWY
	 AoPu1rBm2ugzxhO6qmwqOJFWdlYlmpWbY2qKHce3iLwqTEBPv+tgIZYRuEYrHbYWR7HgK
	 9Zk+J6taFqlbWo/3mkIwx2mEfw9XLlsi7ynDNb4OSwWgGME/+mYmLA2Vr3WzszXg74Ems
	 dw+pEMZz23YwZNppntH//azN+XGJSjRJ+2nDG3GTJv5hgCAa66vYMkUJECRgYv62GyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJZD6iPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1699606D822
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJZD6iPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D8D1F000C1;
	Thu,  5 Nov 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898829;
	bh=e9lbHjL1/Sm4sdjLBSc6zBB9t6Ek9LZiuMFNDdw3z94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CJZD6iPEWVQhhufMFCs2qSw3Dl33p+B5JNCciY0Qxn/RlEQuXDq5T7hNCmod3aLGC
	 6i4DztO/R2HnNEjx82MKNxA8Ck012O9xVCuGwmZYcAcBHh5GYgfOrq2xJizk54NPeS
	 sVIocPW8LLnJerBxnLjyA8nm2B+/d30MDyss2/HcTt8P/zy07mQbQsCUquHTWncaM0
	 pBHa8b0/hWIXO98jmpX47npFJ5qg+kVJjo3QfGTKEhD0O9objoC9xn6GI6fN1utqhU
	 6YOJ2+AB0XFfYQDtfcUuqs18uJSg39JqXaS8fiezonAUoOEC6XCyN6FHVbDhMSqBz+
	 RY0nqYggS3FwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: VeroFess <coderzeng@hotmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: server: size directory name conversion buffer correctly
Date: Thu,  5 Nov 2026 12:13:47 -0500
Message-ID: <20261105171319.2151172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-submarine-stool-e2c1@gregkh>
References: <2026110424-submarine-stool-e2c1@gregkh>
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
[ sashal: Retained GFP_KERNEL instead of KSMBD_DEFAULT_GFP because the latter is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/misc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 79de46a0283ab..604d8584fb2bd 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -290,12 +290,13 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
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
 
@@ -304,7 +305,6 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				      d_info->name_len, local_nls, 0);
 	*conv_len *= 2;
 
-	/* We allocate buffer twice bigger than needed. */
 	conv[*conv_len] = 0x00;
 	conv[*conv_len + 1] = 0x00;
 	return conv;
-- 
2.53.0

