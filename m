Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907F30E0FC;
	Thu, 17 Sep 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605006; cv=none; b=TnYn3toJXSxNiiA86cIW9rXGXVzsi+2865TAcr4iVQVbnWsOE8bPk5PW9fB3PKdZLLE0RFgWibtCvldZ97wb8WpQv4qb08wq0LxOfOpyWRYC1vG6QLJPQ9ypbLssuEDD1xpfiy7LmpzbOGo6gz0oBEVGTGJ/MnXcfthk5gEqBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605006; c=relaxed/simple;
	bh=vvzu4sAGTtkPemytDhKsoYAd1DuvuQNP58x2EA0doQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2cx/MtJoYCRCXPokggTPpF4B3kV2KRVjmO3ikhxt05vxt0hTFKRVFENwKic/P5Bo04olxp/YjhFU8G7bDeHLA0YpXTRLpEOaQ0ULlgLeKr1fdsBFtpStbQcnw5DDsK23NIj8Zcj9mlzSxBFtJpAj0nw+teKaX+88Xr6zv2J3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1QUjy/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1QUjy/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5A71F000FF;
	Thu, 17 Sep 2026 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605005;
	bh=oVH2I/KEoi3a1Q015F0HYH/NNevNrhbbgV5TeRKqe/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y1QUjy/BGIO4eWuYOjdt1BGBe+04lHE6ZcPCBQc1b+lEc93mF0IahtY8xFq5fLORD
	 coQVF5PLDIZXVgloLOKv6pg1i+/GIPJWbwc+dbmEqwNGh4QQl3keXbFneQu3Nny58x
	 2BVEnzXiZkQFpHWk9HuVJPZcFxD6283bpLzAXYTNtVE8GLoveVD5UL1/cPVAJMjawz
	 WhHriUxX9QY7Kuzpy9L+9Zzz55VuDifPEays30ivXogEvQQR8Dl8kSVPf00noH1w5d
	 Nl12AB1s7Rq4QhLM5fDV+B3jo9Pd9kTHVH16wIybGbWrCDxr94Eynh3A+lWlhFee/v
	 HVe+jzbi/2Cfw==
Date: Thu, 17 Sep 2026 01:30:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, gustavograzs@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ens160: Fix trigger reference leak in
 ens160_setup_trigger()
Message-ID: <20260917013000.40ba0e90@jic23-hlaptop>
In-Reply-To: <20260916162638.2083538-1-vulab@iscas.ac.cn>
References: <20260916162638.2083538-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:26:38 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
> devm_request_irq() in ens160_setup_trigger(), or of chip init or
> triggered buffer setup in devm_ens160_core_probe(), returns before
> that mode is set and leaks the reference acquired for indio_dev->trig.
> Request the IRQ before taking the reference and set up the trigger
> after the triggered buffer so that only failures with the mode
> already set follow the iio_trigger_get().
> 
> Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Same again. Not this solution.
