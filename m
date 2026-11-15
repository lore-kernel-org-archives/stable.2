Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735690;
	b=HjMh67y4L/KTNsP4K2Ui5VEh8b+w8fjJDZM6d8u+6xxV2IJySzaUeC/h5pW9jOXlwcQ0
	 +Q3ujhpdlc2nMs/DRxP9/TOXBG7zCg8MGewcewM7iZoOPgUavPyok8aaYBSScuyv9aAcU
	 EB0bqqjoGg+pT/DcJ0l6xMQ6hQKJHt6LGnDAXS42ng/khwuVWAhKF4Ig37EMt4GUZXKxG
	 +R5UpzPY05/by+wUjbPNuIgT/6+PddcI0iiWeBtObJ70JE4e0zHI8+74AivJ4gCphSGSS
	 iEePNKTXfeGpGAlB0G1aE5IQS7u6qvkrt1DzncyJqe+O9bfuPJ+GnHj2MtU/H3Mfg3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735690;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=LZYkjRr27NpPjrqvd+JcqlBpgfomsPg1KNU4BHdFI7w=;
	b=YYBItySpVR1VnhMCemhHWkIUdI+Rlq+0rPEQQphjM475tg2IebBfRFnIWE9JZrnqvWHN
	 5Rij3OB8+kUhFODGaovKBV+gJ23TZFIKFJhjj9cPUJvpdR/zWbHglclRPEgGzcV5D7Ni1
	 9L9sncCsvOkIuoY95bqgH8LiS+frSXHVeTv++eEKyyKuzfwwCRJ2zqq7ZyzvcF5p4+TRY
	 2TeJiiI3nJyvfMg/PRYzt72GauAWq4FO4nTiLM8OlXcguRZcv/0T7oPi2zB+TB+vRLb4e
	 GE2BQ8pONyiEAKnhi+ko4Rg2BEyphXE0C+Z5LVnQqsASFtg0vT4NNt3pOQ52hEWGs0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho5zCD20;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B34606A31F;
	Sun, 15 Nov 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho5zCD20
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C761F000C5;
	Sun, 15 Nov 2026 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794735690;
	bh=LZYkjRr27NpPjrqvd+JcqlBpgfomsPg1KNU4BHdFI7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ho5zCD206rnLx852iEbpOOVmyKXF9i1DcDHzYqIy49aE1868GulR5Fc8133qXK/Ic
	 LeR+Tzh4NSpecXTspBUF9AHQtoBSEmpsLIEANVGtXmSv06kvXp/qApitlJW99rzwcM
	 wPt31ShaNPD8AuPxv/u5lvrCkj3vK6aunE1Hzy5zE8zlF6VaX+Zo4gsbgnt9ECBQB9
	 /ybTm1IOLrEH1NDTDw8oMbP4zCRK8KkodgWfZSO2bMOt+hJ92/8lyb3g+90dWRyj0G
	 j7z+Ktc9ET8NSwMG+yfA2XPG6rRmbrmSNJhg13B6fbHi9tDOjtamZS0S9IthLx7ZV3
	 ib+zo8PBh7+rQ==
From: Chen-Yu Tsai <wens@kernel.org>
To: sboyd@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, 
 andre.przywara@arm.com, Ilya Titov <ilya.titov@wirenboard.com>
Cc: bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261109090914.46872-1-ilya.titov@wirenboard.com>
References: <20261109090914.46872-1-ilya.titov@wirenboard.com>
Subject: Re: [PATCH] clk: sunxi-ng: h616: register CPU PLL notifier before
 mux notifier
Message-Id: <179473568811.3056166.5724569905086596761.b4-ty@kernel.org>
Date: Sun, 15 Nov 2026 17:41:28 +0800
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
X-Mailer: b4 0.14.2

On Mon, 09 Nov 2026 12:09:14 +0300, Ilya Titov wrote:
> Currently the CPU mux notifier is registered first, so on
> POST_RATE_CHANGE the CPU is switched back to PLL_CPUX before the PLL
> notifier re-locks it. The CPU then runs from the PLL while it is still
> settling. The comment for ccu_pll_notifier_cb() says it must be
> registered first, and the other sunxi-ng drivers (A33, H3, R40, A64,
> A100) do it in that order.
> 
> [...]

Applied to sunxi/clk-for-7.5 in sunxi, thanks!

[1/1] clk: sunxi-ng: h616: register CPU PLL notifier before mux notifier
      https://git.kernel.org/sunxi/linux/c/0ec5e7572ddc

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

