Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245BE5B21A;
	Mon,  8 Jun 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940792; cv=none; b=FivtThMLqnw5hQZJJ1+USbcV3VpcQIWxleN9HIEwFz722E9IYM9V5Fm378ko2KIL+8j19Jjg6jiZXZ7lui74S+BYEDkL1/+RwD1MXELoIXxcr5dTVYBNcPALnrtYBfEDak2FvYCCTFGmgqkN/RGBh85qsEd6FmhhNYHQdvBoIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940792; c=relaxed/simple;
	bh=hQvm9rd1vOBTEA/CfDYs21FP8Qkng4Kq4J9BylD2768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyM9HqWkb4mGkNC9eyraL3aQo4VhagSK0jzoilu5V71mZg/dsKA26Eg8BVT282VwL9wGS/i0lCeqsm0nSOYSIiPxBoeA1o+VIUs0gSH6mCR2jNjZ32F8j4N86MYwI3a+fbd4PLkD4fARm4ygIsMsgOxNaH8/hpncpbCrFZrUzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjgmbzJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjgmbzJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E11E1F00893;
	Mon,  8 Jun 2026 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940791;
	bh=71h6rAOlIU4z1IUSO/OhHJCXmUdHXGbry+6wbBzzwng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IjgmbzJmcGsy2+q1OJn8D0JNNm1G0O0839MaDRkTiet96F+K/CzZZr5/hDUYqY5Uj
	 SiJNPzyL5dREe0OExIGm/YkhiIQjrkR9AC2P/+Y7Ka70vdycJvgduCmmI8Lu5a7eUN
	 DxOBK0aMZtPUfwADj/KvoNX8zkw1+pNZRIsxtUi9J0GaLEx0ZuBE3jLH8CKpAi6pgb
	 5CBxYKFMJ/L/ia5iIs3jPCvl4OTDtbB6iBoCReKpjFkwz19EDDxy6oZzEZsgk6qpff
	 Z3X9MU7nt1qxbYPXPfhkXmNO8XAo+/nhXVEbZFMJLdClKhA0rRr9ve4kBrn2jT2kd2
	 PQRQv/r8R8bxw==
Date: Mon, 8 Jun 2026 19:46:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: fix clock and pinctrl state inconsistency in
 runtime PM
Message-ID: <aib_3VNHPuaZn_l9@zenone.zhora.eu>
References: <20260520104939.2897110-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520104939.2897110-1-carlos.song@oss.nxp.com>

Hi Carlos,

On Wed, May 20, 2026 at 06:49:39PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> In i2c_imx_runtime_suspend(), the clock is disabled before switching
> the pinctrl state to sleep. If pinctrl_pm_select_sleep_state() fails,
> the runtime suspend is aborted but the clock remains disabled, causing
> a system crash when the hardware is subsequently accessed.
> 
> Fix this by switching the pinctrl state before disabling the clock so
> that a pinctrl failure leaves the clock enabled and the hardware
> accessible.
> 
> In i2c_imx_runtime_resume(), restore the pinctrl state back to sleep
> if clk_enable() fails to keep the two consistent.
> 
> Fixes: 576eba03c994 ("i2c: imx: switch different pinctrl state in different system power status")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
