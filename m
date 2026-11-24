Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537808;
	b=1wRbPXAQMx5P8hP/RoCp2rSTn70CMoLRaV7Cc85Ajv0OD1ZuS+KKNe/CWl76uYp6jDUo
	 FgnQKgYDOhKc2dWXWXMfAN+zDyd2LBnpCzkhprVlTcxXNJVS0YXTlSrROb7hLAKhbTuIM
	 x+ifukfCGfGPcaaKYK3Jr5/Mk6ijdHdyDzZLTs5fEf1Vlj+vbBmECoDlffw6HyhmcauPZ
	 qv0eBV0OscmPKnGl9mKsiudcTJ6nktf8drxSKVQSzbZ4j37Ic03GM67Wd+XIv4Yk1OS6E
	 99X2hVxe1J+vTVilaF9fbZI4NJpRci4/Bmz2LwMUDOwy64am7GYuT3E1YGXjeKRUXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	b=YcfAr9Tk3D7he3YBaPKFYIYHprrNU5C6SVLRvSsfVhtFHXXQcSl7lmM0DaBPW7LZVdeP
	 ztNpogBewtwOHJf+7qC++UtHGY9NAgavsOLdvIDubJQ7win3F2UFBXWfe3289lWnW576I
	 TXoasLsrIq29MIH0idKgx8paN7JKkWw7OUCdQADnaTLBer86L61JmfsdX4XP3kDn7+sMx
	 iuomj3/v0lwP2RAoBSggyM6QLuDP9YQ8D5cvC1Z1YqJFHNrTgRwz5VFLuIPiuLpSZ6dPl
	 MnTtexNqDyy7nnVeI4svjJ3YI9ue/N/SImNxjyRI7ckIEclwyK/u3DOO1j1qF5xcbZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtPMlNyN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtPMlNyN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE91F0093E;
	Tue, 24 Nov 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537808;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtPMlNyNUXgzNecjn537OvP86tDUju1RqLd5I8yf70FEKffav/9ttBmTA2SsiZnbz
	 V1wSGNkkzVESnbbmlJMG+k59bBsIrC5eH61IGDeTBFliSJakezyRFOGH9Phgg/cbfG
	 9Ji7vgw1Ffs3eDZiKYC/T82xc4/gfxQndChIMmtA1avtIW1IZedKnjljdMVdZWuAiS
	 yfvY1aOyYB/fuPh3/7vExHIJIzqitJQHvOiPLlHuT+/QocRkWGtnvt3pVzxYgrH15w
	 OPU9BpjKSpw1RPbKLRZ1zHBULnIMZpeIQ6cqjkevGawl59rOZY/uqxM6E1Q3PxcUZY
	 /S1wSuNzT555Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Tue, 24 Nov 2026 11:30:05 -0500
Message-ID: <20261124162939.1246818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112438-freezable-bash-6910@gregkh>
References: <2026112438-freezable-bash-6910@gregkh>
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

