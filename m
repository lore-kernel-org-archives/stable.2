Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537139;
	b=3poypSFpMPMtVWNx4uEZeFLR+q7zTcFpt1g2QrjFFyJ5UPh4YdjBQyxAmceRA4khzqW0
	 Zfb88XDvDDZY18gIO/8mTLYsy+tcgzsO1aC3QK9a0sCwZy82Rs9nKrqjxQ9+Vwugq+uPF
	 dbSvO3js1XKR9xO6P0EkSjqsItObXFkVkdAFfEYf2zoSTiZqIeooH1utR3ahEeI9YPAKv
	 ybzPZa4F8uBxbJV99lxmY7z+n7OBNm7melZSz1athZ8KT/weAPmnPTeZnkQhsAbpCB0/i
	 3Dx1zybNIKp4Br4UkaZOX6A0ECK3QZUgI+sOIFuBgE6Kmn73MRAFKwx0b2CL4spD2fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	b=FczqQNKJE6EqGYRTXwE5yuhsqDOeMZqFqSUWIoxne3LGIF2SBgrMkXrf95cr0103YdEP
	 YtOgmp1PRXN5xZ5KDu+UAzPAXq60/sdDmxOqKv5ZP8r/Dt/Vt393accZab7fPhWVvz4Hj
	 uAFJT3KXWRryqY9C0TT4hp8suojclZXLk+ixjg2y2CGKxegoZxLRyfou8a43BlJlkeINg
	 7OWmrmx3wZZmNUgltc1ZSaGMhIDi7iT7GKqMRHFkEZBbbPRtAu9RsUPMrESCXJfGyrLQD
	 O8WY60e61rW57dqx3vjMUe7C44U/q7bCOG3cuovEkw3+0kj3knuV9RWqc3o7/FMBwgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LrOd5Lx/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956A606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrOd5Lx/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227AF1F000D4;
	Tue, 24 Nov 2026 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537138;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrOd5Lx/HEZEwias3VRg2hGuwZHEppXvpGFm992M/QDYIKbKRxVhktzhcYxfEftgZ
	 9R4VLdgHrYD9AaHfgPJQRI7Lb4K/elj6vNUobkKnS3SSOy24/fFOEapkXkd+fSbQnG
	 h0+I7RzUMq8YrACTuSi7CDXc0LY6Yb//EkyV69ckFK3kUa7/Hyc4EZ8qvw0Ijtorwv
	 1w5ffBHduzeC4R8wWOV2G1oeVtUoJlzo6lw38Ix51d1CGAThgLwPxVmz29v7fEJCV9
	 3A2iUDCFbZG0i9nrmnE9LyLqNKf3cNS2wesHRQ7PSYGW/+XEv10bSWwRk7rKksL2SV
	 9XMXjHD+Q8cOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Tue, 24 Nov 2026 11:18:55 -0500
Message-ID: <20261124161827.974466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112437-flatworm-handprint-6101@gregkh>
References: <2026112437-flatworm-handprint-6101@gregkh>
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

