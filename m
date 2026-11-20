Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194143;
	b=jcxvM9/DAQunmfY6yfFdC2psuysBBfsFSjVxsDkoXca8fEnmKuh+5T4UmDCw+se4ddhr
	 khjGKSJWB4JPOrpf0pXtLPeCDvvmiK8m3LlyAD+MiW2xpi0q8yFhT70vfKrdpVuuHPZH5
	 cWaduLFKS++bqhipxMce+8fq5YtJOeQn12BPswJQsOKTpGEP/Wbj+PfjEhN+w7Cz/HRgZ
	 saU0isYCx6LDFoKCr/T2yRf/Km02PHim1uEqE/YGJ5QCqYv8+tzgElFIpW1qdnqE3naPx
	 PgXpiSaf9UuBXoGMXU8IahbOT5BUBnF3wTNyZkUhZQ9cNUJSu6xqWRq1P+6XldttIkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194143;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MKX+MV7ZS3pgsFPhLXCL1R4hUb3A9oRc7oNvqOxwIyA=;
	b=MbzucjecD5AftRPIaJObEwB+X8ghFlKm2BxeRw3jX5N64rx2zuX05BhNXnKmMhy03Y5U
	 PVsunpAJI/OI+UHUVsnmrV5tG9f6mcwqZJangNn9l/mpFRh+7WOhPoJDCKJJW7PRUGmFC
	 C4eSUKmBDvx9/eZhwGAHbJo46wPjkrVPj9jPnoc15KwYH1L3t6B0YRwnjL429mS1dqHLI
	 Y8Osof3LL1zB5+FsB6Xi1l6sZSAkjcW/dMJ3FYaB+9M7JnPJF9POLvNwt80dmkVlTZ5se
	 3uq/UEAUihhVVemGhWieHzMrErOU08U2EJeLUxfKaGyPRb7FekoC3qkC2E8D1BcLguQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRvOCKze;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AD60A2601;
	Fri, 20 Nov 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRvOCKze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922DD1F000C4;
	Fri, 20 Nov 2026 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795194143;
	bh=MKX+MV7ZS3pgsFPhLXCL1R4hUb3A9oRc7oNvqOxwIyA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HRvOCKzeP+lAiBOiaMhi1HWvedsQWFTwQ7q7Kukfy3BIpdZ9kJkLPJDb1mtzRaYjy
	 95PCzDa8kyqtrEUvAA9nmLyBUpENicbsGOJvELn52JnVjHugaOIwGXwFJLQB0+eGS4
	 8k+qwiE5hWKlYncPzrTpOu2dDyJL8ahj8k/yJE66hrh1IKkMxx0hfsJoy4I4DjBStt
	 xUMxH4+jnRdHg+8nkzWWXrANx/g2SZTy9HnFGsIDqjkIX1CzJTluGUlsAdSVfYDPIq
	 ciVe5EsgbK12h+HmVIONxU+plLHmEQVr/KrzhQFLcueGtcTznqcPboDfn1EsaLkfML
	 I4SMFT8gxKWAQ==
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
Subject: Re: [PATCH] media: iris: Fix encoder reference buffer size
 calculation
From: bod@kernel.org
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261031-fix_enc_ref_buf_calc-v1-1-54dcba5977a8@oss.qualcomm.com>
References: <20261031-fix_enc_ref_buf_calc-v1-1-54dcba5977a8@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 17:02:17 +0000
Message-Id: <179519413781.2846709.5558343764676918132.b4-reply@b4>
X-Mailer: b4 0.17-dev-e3fc9
X-Developer-Signature: v=1; a=openpgp-sha256; l=726; i=bod@kernel.org;
 h=from:subject:message-id; bh=jwR2z26GK5TFE9poCpSnbg53tGuW0J+hD48Ood694PY=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBrAH0alj1JIvwF+dHPKnP5zx+N99Gw68XngabRc
 S/AXlnUr8WJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCawB9GgAKCRAicTuzoY3I
 OtH/D/9DFJsagmGGdmiADwwnP7QnD4QQtgO5iEJgdme/c/Ycu55viyF+SJM/oZA16hu+iAbO+vx
 7aeQdypHK8nRy8YyEAS1iEHT9B/l25xU7VXMdPcdRltoEYpenzh2syZ9+r8lhYfymXqKZHmLp4z
 2CdRr8505zxn9B7lPA4xKdw4R0Q2J1e8WWi969jwBWFL0zh3uWj5Svx81W7Jo+skU1T6JlQD3pW
 /3FbU701I2EozZyHvF2Hx876dIsi+g4jT/ECcvyWc/9GRRX9WtcTl2O8jG9RavjHVqhEg7QefTr
 xDrCyV4nYQVHEr4h4jt9WAml4ZMZQoArQliajpNmlL5cZfc2Gm+w2uTzggNkmyftILjrdchPzaL
 J6JDTBzcm09Xrud2IHWO5nnG9P7Jup5Ysqu2B6SUwDaxlSJvRczsMV36boQt8p4kfpxUWFiwtba
 Mb0MaBLQxbIRHuP9DR2CimR0Qi5tCPdGLWZeCILcZjKU//duA52Q/u3Al+J+gGfDpU+fF/DSlp6
 TlIj0kxFp197nt8o7BEJBXbUviBKBogLU4Juc4+Mlx5zlY/FJU0O8lmn1Y7aedbrFJikPFu6kNi
 F8Rkqr1rm2w9vpYT2cshFXOPMiap5WgTEmOQD6p7h7lr6HDJ8K5Lz5Mg1csKDrRB6I36pJyXSB1
 eR5izCX1SOYIibA==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-10-31 01:43 +0530, Vishnu Reddy wrote:
> For frame widths that are not multiples of 128, such as 864, the
> encoder reference buffer size is underestimated. As a result, the
> firmware reports a session error when starting the encode session.
> 
> The encoder requires the reference buffer width to be aligned to 128,
> but the current calculation aligns it to only 32. Align the width to
> 128 when calculating the reference buffer size.
> 
> Fixes: 61528e86687e ("media: iris: Allocate and queue internal buffers for encoder video device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
bod

