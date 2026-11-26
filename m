Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719051;
	b=KHGNjE2d6vehn4IUyiD5S1L1N6kV9yxQWH3T5x4kuHDTmscB1w+k3phCgSaQ8/CqxdA4
	 Ef8u4tbiSKznWUA/gAecZrWEH0okYG+03ibzKfFLwmHjADYieyCeCyo7GL0xQt+97cATg
	 Evn1P6o/4yyienyQi6gbTrrx5XYYyAS9qPZo2oTWd85i0V+UZLvMbMn5g0/0HNOCTnwNN
	 wqz18OJ83Jpwizy/qHlYrYRBAzKtnjxOQQUHEk507RbzKsoTdnBoe8sUzmScQ6NVkXTtW
	 T9a9ONksMULYPxIo9ZU5VLVjvwF8NHMKXWNzpOK5wcRIXIe8KUPZF9EnRpnZ4dtjE+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719051;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=rRMqTA9y4q1/feYnbWuhgBQMBo65uLHovNvV51CubRM=;
	b=BPNEodZyZ0EgM8km0CEqSwkyzWUzMZCyhfRKRctEmcDVUV5pxQtHjTkSSrjr2A/h+xtm
	 n+j1C9B3YkYFB75q0bb8Md8h2DVRlk8FM1G8Cgcb3K3/VRoYcpHReQ8dv4pIzVx+Mx0jZ
	 RSSYDQ2rX/uO8Qe5ffZ98VmkvCt+j5PCJ/6rJk4YuetDUFpjLdFFHQwYpMAaT6j91cewL
	 NTi0mpAfukcgEU8VKUO/D4PsToFMld96etrZkAe6lmOSwgn1ZTqbWFeg79JdOFfRIm+aD
	 UeSy3od1skcTRAwq6TlS/WGeerv/ouqtJUgSs/GVYRwQX1f0St7oSW3+qSRDL/x8Uvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyez7plw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4C606A31C;
	Thu, 26 Nov 2026 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyez7plw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759181F000CA;
	Thu, 26 Nov 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795719050;
	bh=rRMqTA9y4q1/feYnbWuhgBQMBo65uLHovNvV51CubRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oyez7plw3Pnp4KN/cPbxRlYQNoWaepmpwBx2N2wB6ukponzEPgFMYCHj8UzsBRaWt
	 n4h2OHuRUAYzhWzZl3CK6UT2oALBhg9yiw22sRUtKdy10nzzb6Vk3aXUA6rfiI4SjD
	 ahzMg6XtjduWPbOEzOzdxXEXjwfzQ0HZYg/2pbb26VtGYqThA30It5ohq8cXzbeGkf
	 GmF/8O2VqszVGsKsySp9LH+DMgyg7qsW66DHVv4WqBvC2OUvjwCrVblN9uldf84Oaw
	 D1GSOkiEDc+ylj1Med278C0gJyUX3FU/CBmaE8xUMinFVUvHENiCpp1HmrmkBmziF4
	 NrNDMhWR5v25g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261119-syscon-clk-uaf-v1-1-dc4a4c1be353@gmail.com>
References: <20261119-syscon-clk-uaf-v1-1-dc4a4c1be353@gmail.com>
Subject: Re: (subset) [PATCH] mfd: syscon: Put the clock after
 regmap_exit()
Message-Id: <179571904924.17438.9838642142341171263.b4-ty@b4>
Date: Thu, 26 Nov 2026 18:50:49 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 19 Nov 2026 16:49:56 +0000, Arun Iyengar wrote:
> On the error path, of_syscon_register() puts the clock before
> regmap_exit(), which then unprepares the freed clock. This happens
> when the reset lookup fails, e.g. with -EPROBE_DEFER.
> 
> Put the clock after regmap_exit().
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: syscon: Put the clock after regmap_exit()
      commit: 3b325481b239a9d9c744f10143e59b252eba836d

--
Lee Jones [李琼斯]

