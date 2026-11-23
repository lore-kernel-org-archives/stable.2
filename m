Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468822;
	b=kFFfqmbNUxlJB3DssRa2EPmHTtpu98/U8vnZDaYGUli6sc9pAuQh45cmpqUb4QEva0OX
	 HP5n+pjvJgkKcwLP1E1/eJNZt9aWcKIqsH6nP72dV22e4pUfbqLCMuevkJrbQmrRyw/IO
	 7wULE0GcLKJhuGbRjplQkItXQCQILoKTIunTYBWSPuRGFjYCF+AoU4UVEyIMVc2sqxqcp
	 zuQnjuDzGdEvaBB+yrDqCKjfj3PUSh0gi1ElrDzo2MNraq0W+CozqxTyal5ApAjopI8tU
	 Xu4HgaKqXx1jcQCNu9rNKk3UX4uFbzsUx1OPb+yInf9aLEBnHWOzZEv0qKoll1jH6uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lF6EA19xpJo1RJXNKpcF7Jqzs83FdkAm01ir6hnlf+I=;
	b=XyzoQGTsuHlIjrD9tetm8xu2CD/vvN6ZLLQRwGo28qerHMqrab1Gf1jBqkU8cjdHo8fN
	 i3fs6bNBPntu6qhR3tUrkYtyEQI+7JKb/PmhWFB+XybpQ/lHvxbqjUy69UpITTD25WLPq
	 hlSuUAmyUO8ub9Tu4a0zfEFv/8QKBautGLBWwRrSlr/ZLJLxxc3eh/GhwUzsshp1NiWHb
	 5BsC1KbzO0KeOcfxhgIEvng/YsTho8j++onvuViNSRdsa2u7UZrWj5OUrDtgaBNHVIEDJ
	 fyJOi9PgRCRpn1bUOJSrC9/WIvPFbZq3NYkBh+5xK3nrDySi5drtR5xDEuVWMxc3ShQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4IFEnq+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9F41A606A32A;
	Mon, 23 Nov 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4IFEnq+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A61C51F000C0;
	Mon, 23 Nov 2026 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468822;
	bh=lF6EA19xpJo1RJXNKpcF7Jqzs83FdkAm01ir6hnlf+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X4IFEnq+imB2jNkfJMTCcslMrZBF8fmVm4hS4rRjhKCB/woSHBwtexAiFLmtS8Y1g
	 AOlRBqhtsafnUjDNSazWERbMHB6oBA2+04rVvlFXimoWp8o/RYReUBPJGf1+WVxe84
	 oi1Q9x63lon+KHqSb9bQnSIrOiEDdfs3fzb5obLUdQW/pf+i3w10FbfsCNTXd9y9Pt
	 m5d6fYR/4sULyi6lTmYKAHF4y1u2lK7MinWNEeReAzeymmSLXLlkZIrYV8HRTD9MY7
	 UKUoYaxcQBlGm7NF6oftNWOcP/M+nEXyYbMzh87zG2dE3IbfMnRs2Q1Fc8G0PdBgT9
	 JTm9rPCLQlgpA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Guicai Ma <maguicai@kylinos.cn>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] KEYS: Fix asym key overflow in keyctl_pkey_verify()
Date: Mon, 23 Nov 2026 23:19:59 +0200
Message-ID: <20261123211959.4102708-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123211959.4102708-1-jarkko@kernel.org>
References: <20261123211959.4102708-1-jarkko@kernel.org>
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

While verifying a variable-length signature shorter than info.max_sig_size,
memdup_user() reads past the end of the caller's _in2 and passes trailing
bytes to ->asym_verify_signature().

Set params->in2_len to uparams.in2_len in the KEYCTL_PKEY_VERIFY case.

Cc: stable@vger.kernel.org # v7.2+
Closes: https://sashiko.dev/#/bug/linux-dd9ad2ca-a846-4d0d-89d6-aa262ffd40f1
Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/keyctl_pkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index b5f82804b5ad..662226576954 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -176,7 +176,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 			goto out_up_key_sem;
 		}
 
-		params->out_len = info.max_sig_size;
+		params->in2_len = uparams.in2_len;
 		break;
 	default:
 		ret = -EOPNOTSUPP;
-- 
2.47.3

