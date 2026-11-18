Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018036;
	b=bxhKZ9GXwJc0yxRO9MzHQjq8w4IF/pgwseVwjML1t+n50GZflL+itb/kCtJ8rdGiI0XY
	 UBcooxHaV441FqUUwwUnHGa9oExl6gm5i0Auqc56Cj7CkxFK3mVbEw1A1mm260jHfflEh
	 2dbC5iThQmK96m7e7nNTevN6QWJ8swxUKtUoXaXK8G1SHg62UZnoM0d5yPypuF4WhqfPO
	 e+VCvxm1utpFzRKta00sonH7eBztw6+BRjCYMgXRf/Pnvd2JUwWxL4sfBN8NZN5j+bnda
	 5sKfePjzLN+lv1VTinlmfGDSwA2EIj4P+PLd+xDULvhP5KkHvRJHLaYGuqz12oYzAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018036;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ngBn9IgkxuA1QATjbZhn0dD+vrQfjiVM3wD6LtiJpaM=;
	b=TNLum1jSyWtHrWgzq5gFnSb+rgXz4uWMJZ5rh4D7d2RCbUYAS4iJk8DkVD8mtVqzeiUL
	 dEIjkJvG+FZ3jzt4TUP5Ecil0wxeHKbNRilTJ3RMFOv4x1DLcA27i6QRCwNvGBFG0M2/1
	 R6yAkTK/fZtD20HEGFZgWrI4fG4hI2IjF/IR8GgsvGAjnjRTSpNqKtE2wDRy/laNf1IH5
	 G2F12HWqrerbvwE4rr2EMlSwoQh8Lr+158OBxbl6VI7QsQdtp8+rf4YfOZAwrpad4KHfw
	 W0HAoGhMFnZIhMmStBL0GxEC7dom5Yv/tozRzsBIgc+O3H2CfNpSjcNsV/apC9Kjsrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKIZcolW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEF606A320;
	Wed, 18 Nov 2026 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKIZcolW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4E81F000C4;
	Wed, 18 Nov 2026 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018035;
	bh=ngBn9IgkxuA1QATjbZhn0dD+vrQfjiVM3wD6LtiJpaM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dKIZcolWbnuLTKqutq9BmxD9ACQlJdPkqJmQ7dOWKxPpMdvcVKulma5xuQHT0zwHf
	 v5pqM2+EcmxkfVsmgN1TYYi0ZFoLR4hkQTg1mROqw2VQHX3at7lk8d9b/21gNCnRBz
	 gk+madvKADNedFNMXuYlAS6UBm77p1LRimtoaPAASi75cwe8gj/NGMvNu7WTpMBhk5
	 U9+7qdaslGzB6uFNngTzB3NmxhhP0wWAEnMFdMgFVyQTVtk6RBmer8daPM7fDLUB4C
	 DTps3Soa12TrpMaJysTncT+Y5kn9JLWb3reuFwAGCJpA7zviedaeLHGFvTZDrFebtp
	 1T1ZmcHGVDWAA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] media: iris: Skip redundant HFI_PROP_TIER updates
From: bod@kernel.org
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vedang Nagar <quic_vnagar@quicinc.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261031-fix_dec_seek-v1-2-cfedf0c267ee@oss.qualcomm.com>
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
 <20261031-fix_dec_seek-v1-2-cfedf0c267ee@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:07:10 +0000
Message-Id: <179501803041.2846709.479596500645471046.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=bod@kernel.org;
 h=from:subject:message-id; bh=EzW7ed+tOi0UapeX4dTOqd0hl7HzztMfnZPqsWsSQGE=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBq/c0uqfS6qXMMAwhT4jq2zif+9KQU3YgpLK+o2
 EMiw79tcWCJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCav3NLgAKCRAicTuzoY3I
 Oqd3D/wOzo0O3Pql77X+XK/wM4/eGgLw2WK1pm4gxuxajoZC5gpbangHaQ/mT1oN4JJ1txvojhm
 vaWxTkK8w+v22I9BTD1j6EHLekl9pQrzXxjHL+jpjmrANFRTbWb4vTWz0W2mthjvuvtQu3/i1Dz
 MMqkaq6q6Dk2D/joH6jsrXeUCrj1Mqoh+PZCKQuUA6Rx6pDc6OtPYBhzQVRtmsrV+KXtvntHXsp
 t1Lhja/dLzXdDKxMKt/jxGbikKRHZtAHcOjP7BqG1cghbV+gQIRLEtjAov8NXBK87iBumVHiFfi
 7ouVIKFt08bH+4bHPR2opGILO8q05T0l5KkngsdD8NnnD5rooctnzH5YeXJ6rlkckMS7nsZJtP1
 JcOPHfgUQM2Asr7yVqlPdnEr4lHrOBxhXp8lV3+P/pK3seP7+wdzT4VQ/rye4MbwmkEZGP8Kmmu
 EMZ3b8sLjZ4JXIg+6h3qJaFi2Jvot4ZXbCSs5yxSmAyuI1O+vyUCI4Ps9mrpYWcWmvq2af9vwjx
 phT09K347Kk/0kdGHw4RnoqGMuCQYVE9Ehf6/gKmNttosxxhcdiEg/jtahy8pcoGejsb8QOalhS
 VdivwqQlynI1oTcydsCOqLbk8xEuD9+n18dnba0ib09VjBoottVnRDfnNtDczIhf/7mKSv5Pc3Y
 +Zs9PEwUHda8kXA==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-31 01:49 +0530, Vishnu Reddy wrote:
> HFI_PROP_TIER is already programmed by iris_hfi_gen2_set_tier(), which
> selects TIER or TIER_AV1 based on the active codec. The TIER and TIER_AV1
> caps also define a .set callback. As a result, iris_set_properties()
> programs HFI_PROP_TIER again through the generic cap path.
> 
> The generic property loop sets TIER first and TIER_AV1 last. For non AV1
> codecs, the TIER_AV1 property is programmed after the correct tier value
> and overrides it. Remove the .set callbacks from both caps. This ensures
> HFI_PROP_TIER is programmed only once with the value for the active codec.

I think this commit log should list where and how these settings can be
applied three times ? and what the sequence is exactly which leads to the
invalid setting.

It's not enomrously obvious reading the log and then the code how that
happens and which one is so obviously wrong.
---
bod

