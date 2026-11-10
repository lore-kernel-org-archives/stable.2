Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344385;
	b=SH7pMEwCOtfmcfokE+2nvbM6USBFewdkJRtXvnj9dEzwvSeAAuoyLnYoAH1Ie+VAvI/4
	 QdSdOJ7r2uI9BinHctOsWDkmpe3GjUdJ5tpczic/2xTYDV90ETL918gy1Oq1RX5XGcvLP
	 PRbOhWTfu4HSpn9fr5p4aIhq/dnnu/nWd7ZtlT4EcnNg9cizyMNtw5A1i+uPgO8S0E4Hw
	 CoOf+F98Q7L+pYFoSm5zGJdR+hcoQHADxVl+zBApi75GC8f/sj1zvzL9VPLK7XIPd/q7o
	 R/+gn8hPCtvY8AkDTEE/EQFjoMox/suQ0u9Uh0TxrYUt/tPy/qI8deo5tnFKOJq8EQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TZH3XAdxxDeMkh7WuSpbkPg9PuRsc7ZJCy7fakvZh70=;
	b=q4hDQRHdIWq2Jn32VdI7G7QGFWd8i1AXqW2CnWKsTyvAmQ1MbMFoOJWAFEIfUBpM3XeI
	 FUZxlyjayY1YHlggIUhkbZgTUFVo96idWi/Y0ixCed94QiKg9szepMH5mV0VGeB9gzfIv
	 Wyw0vJljJT5Jn0szt4tBXcdeLsL88Ke6qRwMz6Inr3smuQXh57UAbLVRz/I+H+CBKhJHR
	 SsK+1wDSE+OgFgnE5OXfqSJXnN7TJlRH/0er0xMmQwi11KnawOAQLr/wvlZl4w4waYk2k
	 kAEtY9JpEy2kqNa3Gp8Gq3y7wXZoPGiau/bp6bMT96GGJUXz3BzhBCeJQaNVm0bUgBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSMvLrNp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD94606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSMvLrNp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04051F008A1;
	Tue, 10 Nov 2026 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344385;
	bh=TZH3XAdxxDeMkh7WuSpbkPg9PuRsc7ZJCy7fakvZh70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DSMvLrNpRG0cgo+b1JiFby37sFY95kjSrspa/ktNFuBzycwbcP3BwtQjJfxkqCX7A
	 hjM5HeSGiuTESldD1AsbrUUygTfLmoJfLYsIlL3yxbh9N3BXxR9WtHAhcoWLXTxhVI
	 9u86+TvFwGVoHQlljliTkpMMAjsTHdUe2yutF1+287Ezs/M4/8CzYrTDGOMLjWQezP
	 7rXmBZBMlHtXJocZPDRcurCuPPPaN/w62nLn081vhNHieNIKEKbjRkwrvxVJxYftFi
	 S3llGNtw7IdzfRhsNhiF3sznbszeEDit8UZ+J+LlnD5ELlUSL2j6iQS2y5Zo2urGcO
	 poI7EqQ75gsAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ramin Moussavi <ramin.moussavi@yacoub.de>
Subject: Re: [PATCH 5.15.y] microblaze: restore the ABI argument home area below pt_regs (PTO)
Date: Tue, 10 Nov 2026 15:59:08 -0500
Message-ID: <2026-11-10-1-daily-reply-0012-microblaze-memset-5.15-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110094211.427348-1-ramin.moussavi@yacoub.de>
References: <20261110094211.427348-1-ramin.moussavi@yacoub.de>
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

> microblaze: restore the ABI argument home area below pt_regs (PTO)

Queued the two memset backports for 5.15 and 5.10 together with the PTO fix, thanks.

-- 
Thanks,
Sasha
