Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536495;
	b=Uudk0EAq2oI9PnFLAkNb+++JM6hddhQ0mXU6VyXbCtiX5wowpRsS/+78ZhYcMEJBONMd
	 CacuuN7Upa5sJ9ucR7T4XHqVJ7GA1Y0hnqsJlKfzIsxUI0pBL/SC3LiRGoPf51VsXe+WX
	 ei5GWseO0mL3OtuV/GJfFFgpcPsQslE1O5qaWmYUN7CRP69dEiNF4/O4lk2CQsgnCwjr0
	 cvWgUTYXpHxWF3X6xwtreJRodZA4p6U56R5LYkgm1ytYz7f0pHI9uRhUSaSuFc9vs+rS9
	 z4tbd3ZgdB7pLczAFkJYx8pIFombuTv53AXgl6bo5W5yehsHfDJC77/2jynOLquZx7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	b=CveuW/VepnrWn4O7tRNEg/LR7hkRga0YABtf+NhfEBw4pZY9QtFJxsVVl9JTEPgtZ4fZ
	 yMXBLpK7ZRb4uvKrZ0OFFI5hJ1PQBDq8wdrtqE7w0qfNZMLNLxBnE9SUHT+acuk+Kjut9
	 ipzR+wv565gmxLbsl6NAnFF+xEp24gdKKJ5lHhFTQaVpJFIW7YsOduqfWiswKkPb8lprt
	 eUaDYv0B+I7yVaCv4ipEKaxaGvJw58JzoymxCJ1wXH/S7IMYaEYSC5DG7ddQaa64mDLsG
	 rqsVdZGD5cuWcbtUzAv3KB0jxAj6+Uq/6JcbbvJqFfEdITSOfShyoF4z/rqMavTIVPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kapMGbGe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9D606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kapMGbGe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0959D1F000C4;
	Tue, 24 Nov 2026 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536494;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kapMGbGejeGOeGxO54S+VCa4jp5NyO1AxuMpBYQ8iX9gMvPnxrvtsJet5F8HOBjcf
	 KL6Pu8hsxX7wKpkxb+8TMYPzBXIpFWrTmu84bGzLJoSmAguF+HP+HWAZa2EasrhrDR
	 FcCQZtYpzRjLJ2YvlCydltiAr0SovU/MYNzPGo2rYAl7OGGCAYL2fEFlZ54NX9LXUd
	 XbHk+Z5ksRlrXIuGJlUCABgItkNCagN/UBIvRCivV50TWsVeJnbfMpyZDoCwMha74K
	 y++V5I3QNldeFWHNEMsvkeaYkT4qJHDMYcyqSuXsTwmkNKrThHuoKyj0mfZXTCHPZk
	 cWCoYjbILuAoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Tue, 24 Nov 2026 11:08:11 -0500
Message-ID: <20261124160735.11606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112436-utility-parasitic-7f63@gregkh>
References: <2026112436-utility-parasitic-7f63@gregkh>
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

