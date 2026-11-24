Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538234;
	b=VIqZ88lOWu6msx9PfvNz3G6tLAm+28tgCy1WVYh7pSXCRDXYPE+5o7UX/qlz5k0spNrE
	 XRo5GJ0cWJiofg5IW07IJmnVgXaFziI35gB1f4zKZiVs084FYFOrtakg/z1OYTs2/HFd4
	 UVJfMKDu+8k5dzDegaSMu3Glbj619KNzHM8lw44rAXFV9Ao7N0p1Ihj9OKaDV6AJ8vMa5
	 AZGIRYSrkFhH5oOmxT6m9KSh1S0X+l21Vo6Kh6uvDeRc5oM7Ve+p+YTAAdvtdE0l8+jLo
	 8jkNpaYa4E4wHXWsf3xNFeVk90gjZyJ2GbUePYt6NSb3TRzHSMhGKzt0zCvE4m5YM3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	b=dG0pLrBA4aqO04oxISCn64Bgp0Xemn8mkQMF/eahiPjGuiRlCuJzreU4ZApKhepyfGkZ
	 eVLcsk3AJV+KZlpui1xHxwhZjzqdkgCjnQDMvhnf8UCiNfV0A2jATFMqFoAXZ+ZqMprvy
	 LaVRSPYV/gMO5061WSsuujyYOojCgXDfVzPFvRrqpREY5n2bUUNCRT/qp3EbwoKzKHeYJ
	 RlSWdazL0OvGcTSuTXIqSJXsRp/ZdziZsXfS4vMyTxyOt57pm37Nq1YME34NQ+NhPvwBO
	 6bxTY8SM99YOJ0m39/uW3tTK2+ylISwFesffuacmAWU3KIu+gyb9//j6bLdgbrOVogQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJ6XKA7B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81E606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJ6XKA7B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF3D1F000C4;
	Tue, 24 Nov 2026 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795538233;
	bh=KqBiztSQeQD4jq+LzznM4b8cED7lYqyt739F8ZCBk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJ6XKA7BBtNc1hgcsCN0upViRr0pVj+2BrKB/XVgB6iSVSnrEXZLY9UbENxiJJJGk
	 fn+5XS9Q8TkldTrfWE0+Oy8/39oZQw1O9XcpPnclxg7QfWyRRxulEpLQ178vIkNg8Z
	 1p8Es6QQ6+iqEOQtUSQ3nSPQsNcRecuwRhyqVC35RoXwsAbnz0e+9RI+vbSGBcPhMr
	 BSGhWG7r+5/kCtQFepxeJqZ5ZJmJK+Pr34/KW5Hz64pudqaZUAlZSuA+B3k0V0fcdH
	 WoIwblBeg+IZXXPH6zNm2pbJjD8HzsyLOpOJiBuTlmIMJXuB49toEggB6JcM4QK5Qa
	 +K8lnGyuXBOuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Tue, 24 Nov 2026 11:37:11 -0500
Message-ID: <20261124163645.1587846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112438-irate-occupancy-7430@gregkh>
References: <2026112438-irate-occupancy-7430@gregkh>
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

