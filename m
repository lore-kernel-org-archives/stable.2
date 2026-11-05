Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901026;
	b=fZREWGF1qFrqaPVH1QGfCb1g6fBzwcaePOtG0N5YY60EamNBa8gD5NGI7hdfK+7rUxX6
	 KMpwjnZOtY3gP8kMiSMsgXGqcSBWMbsvR75HBdO8J0bb+VgY47t6+qcowDQasSyX8tljj
	 eef6xcaO/f9vMUS9QAlgH/oc0PbiD25VOZGN59dL0jhYbvqLZWO59lDP1A3dbXzj47oTJ
	 xwvrGOAU+d83zgt73jAfGlhngQlAm+vbjm3pmMYda1ng6y4BG8aIhug/Zz5TewSSnQE/U
	 Wd+kW9fzC0P4wgOGdBImqHHlFjfhXgN7hXxNZEz/R7meAw6bx6BK699V95huZS1ax9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sXt2+U/+wuZRkL7GsFFQurxO0OxNvpNqXIqSluDEFUQ=;
	b=va7xqWVFwpENPWwc24TsbKkcCoXt6vy3eTUFG3KXVPZE9b+z/NQPX8ge4N+mQa+I2jLZ
	 Og6KBYTSELi43Ofb0470iGDQUIs59oXCRajFZHj7fBZJjI0K+8957ZL6rYZEKiiYXloim
	 xgjSznLnV3hwtDrMkMb3XG2AtdgszLEfh+HbQKbAF1dTQl/o4Rs8DOvGK5oiinn1R+MuO
	 jfsf/r8GcntHD6XbZ0pGZ0pMklvBlKJEoVE9HaiYg9Jau1Vycqzi0v+Xuk5XXzEuQzyjk
	 yzw1ds6Cpu3OxoushtmRabfTYtKX4h3AfnzNGtSuCmvt07WvemflyqbNv4SyElfMm7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRbQUCoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8D606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRbQUCoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FEE1F000C1;
	Thu,  5 Nov 2026 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901026;
	bh=sXt2+U/+wuZRkL7GsFFQurxO0OxNvpNqXIqSluDEFUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRbQUCohZ3ClRKApvnNVw5nBWxE4YvJYf1L+H5zstIC1mN2aYeeQ+jInLhQDohoU3
	 f0qws8PIgq/vFrcAP59wsjjs/V0bkivThB1X1Ld9cfd2pm1hAzfTT5KzXrvprboch7
	 kIAf7/zKVfwKlZbxb2Fo5pgzECOblNqiJMCny5uTi33uxjjNHgDOT8ASq7P03oXxfH
	 m7h2VJ7FL0DOMpxq0NGTsla8mjDK7CiYWW0U/fmIqoTJQzv2deEsg6vxjstJ/LGNEU
	 lIi30Za+hx0ouUxVPs+i+NPagwXN7mECqzd0lwhrivBlkK/OTyj9rcNR6Mhg0Qz5Jv
	 75NVqmh6am2vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: VeroFess <coderzeng@hotmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: server: size directory name conversion buffer correctly
Date: Thu,  5 Nov 2026 12:50:24 -0500
Message-ID: <20261105175003.2184217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-hypnoses-average-6482@gregkh>
References: <2026110424-hypnoses-average-6482@gregkh>
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
[ sashal: used GFP_KERNEL instead of KSMBD_DEFAULT_GFP for kmalloc_array() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/misc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 98da57bb5fd29..ea6eccbe81bb9 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -289,12 +289,13 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
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
 
@@ -303,7 +304,6 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				      d_info->name_len, local_nls, 0);
 	*conv_len *= 2;
 
-	/* We allocate buffer twice bigger than needed. */
 	conv[*conv_len] = 0x00;
 	conv[*conv_len + 1] = 0x00;
 	return conv;
-- 
2.53.0

