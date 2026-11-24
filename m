Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540900;
	b=XjxncETGvE8iUiLGAUN+ef4ZdTZt/nBEs1Ky6OzRz2uZ1LoHqFe5ky/y2MCs+rE68FA6
	 CV3SK/XdRqsJosPDNMVBuaMxMycW3MZg19y2+q2HfKMP7+/rRNUsOHAaGtP2kcJp9QCtp
	 p5io0eK3ArXlmmyj+qjkvZG83+45UAKpWvR+9IVUoQN/z8+E48ESaw//Xn86nrFInDSFX
	 iKBP/PbNWhW7vAODsVUoYVzUCXrEpLmUBQ1rXeWvGSX5UzQcabv7iR1kmGSkhaNLIeG3x
	 FueNtAZnioGurr82CRZxU4ayR4T1vgyQw30DBO2nmBcP7sUiV1Ul1oMnsCo7b1UvjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jZUUNYODgZKN87dk34nuoXd4h2XTPIa3enPcStjlaNk=;
	b=vLiVWfWsWc0hKj0NKMAUZQjns3e+OcjM1RkSsyNjAvRUPW44FrVar8xXdDmAD124G6Zb
	 YfDzCxAqSOz8xtKsLMHmQptZGE9fboKRkXh9mZvLq6whr8MOcdPRDuDVtgh+K0AmwGQgX
	 xKgxGHc+07czXgFfcmOmNcdlv9imtbaYnncQCdx07cHWX6NoJsOoV9d43pgqJmPa0L4sT
	 Lg/bB0UwKgw+xt7GmH4IVfcM/fHV5i4YL9ubfpB3fEuNDgSeLTFrqyBOIrEPkba7lyVCk
	 FSCrSmOOUKNPA4/nVDkIKlvfGLR7+WBPZHjAixscxhaxGZ+K+JJR45JW3ibj7TLyzfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTYHu0hv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D004606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTYHu0hv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B4F1F000ED;
	Tue, 24 Nov 2026 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540900;
	bh=jZUUNYODgZKN87dk34nuoXd4h2XTPIa3enPcStjlaNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTYHu0hvIzDra/jA3xYDp1w0fLAuiJOX/P7Scxo1AEFLd0uK5vInGBFsYQ/VML3wT
	 cYIgzKwp5+cJG6W7bFOfU174igu46XkKQ+nPMjY5WyWzXbi2fX7GKOxnG6bZcMOgZs
	 GczAiCByepGisyMHZivMQYtWpFSYtC78lzV4g/9wgxP7qcbUWoSE5Q5Yg0tXD3stv/
	 mNuvUwM28y+lnNSPRZQdshLA5Un/UnjC+1z3hsP9iqeKfqZzq+aApT8Jt/a4Nb6uMb
	 MSe7Ww1swn7+5ue+59flA6dI4WqSkDOY69r8UjiaAppYV2hppDnpiZsI72HeFZ6sgX
	 M7H7GRk2H0bTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Tue, 24 Nov 2026 12:21:37 -0500
Message-ID: <20261124172109.1965048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112439-exchange-tissue-26cd@gregkh>
References: <2026112439-exchange-tissue-26cd@gregkh>
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
index 4a9c61f7cdaaa..3ab2a29c5b0ee 100644
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
@@ -247,7 +247,8 @@ long keyctl_pkey_e_d_s(int op,
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

