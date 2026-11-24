Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540455;
	b=qfig4GhFeI4TOqckQjs3Gg8g/L0fYa8X+B6qb7ydO8jUchM/no6bzavlScyF24ZOwpcz
	 Z0A3IvYlhjSsjbd8y7A24m8M+D8mgteoMzVXcV1ufjAW5oO1iWvhsKHgsK1mngahql4lw
	 P79txmt9L0Unk5qfKzZ+mC0FzumYtPkRoDEgP5GCnuBbH+t4KfurPanbviH7h7J63xxpC
	 sKyI2UgpWnEAbqzD6w5VWwU5PPABjOrsudprJQvDc/fBikCt34GfEmSxWsRWOZqiLOoqx
	 at6gi0zRImNMXDmnElT+1At5DkfN9ZlHD779+QYhX2g2H/Wuly/esr7hWEXJB+egO0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540455;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	b=UiFgVeRrcw3+/k/AVK2b/dtRBMMhOjfixii/VF1HdsK38NFZ6LZxiFV+K2EQltx6V/BV
	 ZoHaQI/iKUnZLYL+8MHTJ2F4eyisaKEdYa6ZQL217iWiS3iuUu7816+1CTTbciZzlQOxu
	 +2Qwsm6Cf+Km3jYsmZbY5C3m313S8mpEWuKb3EAj5+/oPDErz3XAI+0eWtGurSYKIr37I
	 aVx19B7H/72LPgtBc3gf8wNMP0yOLTSfTonH/1qzRWypVkfqLtu9X9iwTnXkT/kAtnvVf
	 evx9JQX97KE6iW8s0Lmo+hIpDp0sQz+cMGS+fa5U8ILVCgptnQvw7tb0EI3k5o92sAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHlLUHU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE042606A33C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHlLUHU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35D11F000ED;
	Tue, 24 Nov 2026 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540455;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aHlLUHU1wH+0m+gyGcIE+CSqt+VIyVpHxqSEgAz7MUWRLCT5UD/1fIMRvmM/X5vwF
	 KgcMp5mtVCZ4WO+iwsVzLHcgfAL4oOfSKv632NiAqLsygrckD4p44tDZhZfLatxtvr
	 4VMX7wMsNgiFxFec4ZhE3uKLoIZOV7e+vJQljb0HPZoieGpkblSrowtq8J5WIRyMk2
	 ooNMZAVjkmSHUPROovfoNymf/ksQmSjcO7Aq96YkBAQo/FYbKx8w4XRVSVw/AansWd
	 /sjpYJysENMg5W4Ti8QrhPOK+A0uN4KfO6mQRTJ5EVDSMnszG1NBHfyXxkdQjiIko5
	 mFSqaW7LCiIsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Tue, 24 Nov 2026 12:14:12 -0500
Message-ID: <20261124171336.1722903-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112439-grope-bankroll-ba51@gregkh>
References: <2026112439-grope-bankroll-ba51@gregkh>
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

From: Mohammed EL Kadiri <med08elkadiri@gmail.com>

[ Upstream commit 1b9524250996b1f2f49833a1b2ae21c34e486f85 ]

Replace two BUG() calls in keyctl_pkey_params_get_2() and
keyctl_pkey_e_d_s() default cases with -EOPNOTSUPP, matching
the error style already used in these functions.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: bab48a104447 ("KEYS: Protect pkey method checks against type removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/keyctl_pkey.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index ba150ee2d4a37..15b6bf6399b59 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -163,7 +163,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 		params->out_len = info.max_sig_size;
 		break;
 	default:
-		BUG();
+		return -EOPNOTSUPP;
 	}
 
 	params->in_len  = uparams.in_len;
@@ -245,7 +245,8 @@ long keyctl_pkey_e_d_s(int op,
 		params.op = kernel_pkey_sign;
 		break;
 	default:
-		BUG();
+		ret = -EOPNOTSUPP;
+		goto error_params;
 	}
 
 	in = memdup_user(_in, params.in_len);
-- 
2.53.0

