Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665810;
	b=jDNL+Mxf8fsYFhChyknKY4BRLbEgMW8bx1Qex81eonsv5QNcOTMM3KhXM5jo459OA6st
	 WN1n2kG4W9CDucnTrA1D4n1HdxL+cT/NdBTmWssndljHArGKsuzlMsK4E/hX0T/K6xL5o
	 hi6vq5gYeheCmfD9YUcnjEJtIBjV1E6mUMvV6UIk0ulnpf3yYHWFrV1OKu6j+FNMMVl41
	 zgAtQD90egef+Ue5Sw0wgbontNi/O3iiCiW+5q/m5Wx9LJf97n9Ir771fK/nF0j7D0dog
	 1SJ/MCxMfIh08McDNdMa6lhrnEM6nCthPC4gmlk+X26KLM5kkA1i/Bwm206JwVTZoxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xpsOhr1byMMyoT5ueSWzzogFAMSwGwHJVxjGF7NfHAg=;
	b=Ujc/JNv/uRvsc3O1+k699IugKT1mIMTTOVVA+QjQ+7lQvpvF0jRpJ4U/SjncejXexTD4
	 G69OWG28GDZCzfaXvT6FcZEVx8lOHQ+IUkaTzrhBtMJ6lsCY/KBpOUUz+rYvhYp6akLir
	 eSiJC3UUfvQvYuLCCChJLquOiVjx/VKJedhQqcmlqKRVypeE7iOn3mj96v8qOm9MZ3hJD
	 VEUI4DnRIaTGl9VDpnCVIQzACU9ZUuc5dO3yQSRNouY4d8KapwxQYuXv7yHcYLjBU78hO
	 ZrFkHoidR2XAjNNthVlRCEq442+BLKDKmfCEedKpzF7mu1bNwKPbQkjb3A61+SS21ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m49J01Jf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D7606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m49J01Jf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6F91F01564;
	Thu, 26 Nov 2026 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665809;
	bh=xpsOhr1byMMyoT5ueSWzzogFAMSwGwHJVxjGF7NfHAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m49J01JfaVoUuU6vy9tgJelut0gI6ylRxj99ELbBaidoE+4X4qLx49G/egcZPcY1M
	 vMQuRtpXNgUxl/cOAKXVKABGItGbTMwCiw688yhkVu91DIZXBF3LeoYruL4ilEbxIF
	 d7rRy2cxwEZA8I+hT9HGRbg6/SDf8ihDeIwVAIWr0+pAoxdp/O6xEiIsv68TBPbU0W
	 I7NEohi4Hw/7YZXZcpU9TeGJGfVCdNnbq6yKfADMwjGV9CL36WlBBm8kT7khI25D7p
	 ar6oaglowEzxS04/P39vsQ67UdrkivFvwuDL7Ga4nuKqWuZoSrNwPrO6YrJ7d6lkPP
	 5V5uPVschC5Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifan Zhang <yfzhang23@stu.pku.edu.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: bound invalid NTLMSSP signature diagnostic
Date: Wed, 25 Nov 2026 23:03:27 -0500
Message-ID: <20261126040316.1894686-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-calamari-disabled-3216@gregkh>
References: <2026112511-calamari-disabled-3216@gregkh>
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

From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

[ Upstream commit 0584b02669c3e76188097174b4f25ed13723e94c ]

The NTLMSSP Signature field is an eight-byte binary value and need not be
NUL-terminated. decode_ntlmssp_challenge() prints it with %s on the
signature-mismatch path, so the diagnostic can continue beyond the received
blob until it encounters a zero byte.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in string
  Read of size 1
  string
  vsnprintf
  _printk
  decode_ntlmssp_challenge

Print the fixed-width field with the bounded hexadecimal format.

The patched kernel reaches the invalid-signature path and returns -EINVAL
without a KASAN report.

Fixes: 0b3cc858003b ("[CIFS] NTLMSSP reenabled after move from connect.c to sess.c")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: adjusted the file path from fs/smb/client/sess.c to fs/cifs/sess.c, since the SMB client code lives under the older directory name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/sess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index cf6fd138d8d5c..a7b027cc9c099 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -577,8 +577,8 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 	}
 
 	if (memcmp(pblob->Signature, "NTLMSSP", 8)) {
-		cifs_dbg(VFS, "blob signature incorrect %s\n",
-			 pblob->Signature);
+		cifs_dbg(VFS, "%s: blob signature incorrect: %8phN\n",
+			 __func__, pblob->Signature);
 		return -EINVAL;
 	}
 	if (pblob->MessageType != NtLmChallenge) {
-- 
2.53.0

