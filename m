Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961375;
	b=WdrCZ2O3CjVZRTtTDrrK8lmI6Iax4muJr+jk1J1kBvwJx5uXMN6fsbhSwaDQGcn3eu7y
	 DxY+cbPHQUJHPIoBjpTmP6lhNhQ169dyXw5SKYgx3uL8BJUhWNvPfwam+Lye6vCSwclJU
	 pi13CPE0LodUcZbb6SCZy1HJgzGE+Bn97KujE+qXXzo4miTHF45xj99q6P+qVAkx9mzsT
	 xOfNMo80G7t1ynwc3//7GKMZD7bDgSVQ5c0rrk+8BaV5MSCxKrHNqJdwn7bz/VE9Tw8cr
	 4pyskX968OB3MCOu/tgaEXe39BzzbD2Zf3bQJowxxy9GN+iRFEZGAruvTyGtNBGN6zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6so24GezOUeLshnz+r9/uQrQbBVW4KNO24KQxAvhjmo=;
	b=PzlwI1AiSgk6h/EgB22Y+aTiWZ4NkT7ObqtLoSGak63+z50/l2FzMGY6VIc9m1DmFxp6
	 dxLmVnIIFfN3ntRoRxQ/smI6SmzRpLpWcdIdqKDNclgiRsnsyTQzTkaajn542vflt+Y5/
	 YTUhHBfuYNlW1Qwf/pzkFuSP2alkz2p0LHUkv3PwklNK4IXYITHgRaj+gM0RDmBQ6zOB8
	 fxjzJT2deMZulPece8Xp+temCuuwYysRXSEz3EzD2/BsiXogPySk5P9c/2Xb5e7DCXcdS
	 edRcHU9g89DB5O9NjZuiEvJsQB0nL8HArLGDBIN1baNhXlLAiPQINpfqUzzFPL4iXjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbGudHeU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD21606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbGudHeU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C971F000C4;
	Wed, 18 Nov 2026 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961375;
	bh=6so24GezOUeLshnz+r9/uQrQbBVW4KNO24KQxAvhjmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbGudHeUqCweEAeMPxiCQR2wgMSXbyEfLlDLwKsKbJwxdiEqhg4DKnN/yezAUat6O
	 mbJP3K/MFBCYPuJih/nKmMYCfmRNanyhKuKV95f9SotOSy46BKSCStWd72S+bdT37w
	 Vn+Yo+aVBHFsK1PIVV5Fhe59rrZ3fveTguqnD/RecHwvxPFDeYpwHptd65QFnRpI10
	 qYzboD9Nz835D385n4tpWqET7uH77Mlf/DaVJ6CGXet2/taglWqmGo7+AAN3G41h7x
	 T4v4RXogGhQcxBmRDHR6d/p5hmRi96bQ0eBa1fFa2Vrw0C8pgYmJTvMC627uPdfOxN
	 sAvojtphPURNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	mathieu.desnoyers@efficios.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	Dmitrii Chervov <fary.ru@gmail.com>
Subject: Re: [PATCH 6.12.y] mm: fix OOM killer inaccuracy on large many-core systems
Date: Tue, 17 Nov 2026 19:22:53 -0500
Message-ID: <2026-11-17-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117124938.72111-1-fary.ru@gmail.com>
References: <20261117124938.72111-1-fary.ru@gmail.com>
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
Message-ID: <20261118002253.NgUEjNodcPBeGhwfwXzA9_1KpkwJWY4xmNU87htFCyI@z>

> [ Upstream commit 5898aa8f9a0b42fe1f65c7364010ab15ec5c38bf ]
>
> Use the precise, albeit slower, precise RSS counter sums for the OOM
> killer task selection and console dumps.

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
