Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BC311C2D;
	Tue, 28 Jul 2026 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252934; cv=none; b=APJivTHaobsKn4qFhxu9tSZhUTslf0zVKEscCvyM8I2+GtHU3iTxsMq71vvSn7+2zjFMihfpvkc7eVvetjVjPZMcbuLbVXfU3kq4LXS2cHCjb5yucg9oS8WKEs+86um4az/Y+uOraCZ4awy2orm2HI0yZ3Y8qTUYrw9OTPRhJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252934; c=relaxed/simple;
	bh=IPH5DR4CEcMk8mXrHvfkSxL1RleRmFiRI5etHGjCTag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2x//H7NfqkHY6hEP48YvZhX344KHjj3vxl5Wf1MWVvf2M5iXH0yLtwzE/rIZ830arDYpzzKfFjjXBlvx968aBu5sTvBqMssU8uzo9f5nX+c8noXIgMSCLNmT3dv+5McyWExdPyzzd1RhHN1tMz9+RdquVAZfIPzyBKPBlJBh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHVlee4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHVlee4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D75C1F000E9;
	Tue, 28 Jul 2026 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252932;
	bh=MFk55K1kly3QmDyy19/fsabJcJ5u/gTtXyl/wVnrSrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oHVlee4AjFj4Rr8cc/GVE39rWLIiCURlB3GmRiKSJRDRNVMJL4v66BJOrC8/YYLlg
	 8OoNDHzJsSsuW7Og+m9+jPZAbm920D4Gb4htpYl623fj21fyxb0JUGLqhu/y0QSXYu
	 l/dDL8eWwjONd3Ss5WBLSj/iaJEo23i6JOidM/FzOyQuu5EmpN7Bd6qkAjsqxmaDET
	 K98qYzlGLL8YR10Z46EZ6hUW9AY3WEMHPxaA4Es39nfn2cdH2TW/biCkMoCyTg/wBK
	 yTA5zc0PcUvDvZ9OlA4jjQwk9wt8lUGhpDe71B8nUKgYj1+5EBzBnst+OWQywdGwW8
	 ZL5WQWKAQiwBg==
Date: Tue, 28 Jul 2026 17:35:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, s.hauer@pengutronix.de, 
	festevam@gmail.com, carlos.song@nxp.com, haibo.chen@nxp.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] i2c: imx: mark I2C adapter when hardware is powered
 down
Message-ID: <amjMGwf682luwT22@zenone.zhora.eu>
References: <20260525030400.3182911-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525030400.3182911-1-carlos.song@oss.nxp.com>

Hi Carlos,

On Mon, May 25, 2026 at 11:04:00AM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>   - suspend_noirq and the system entering suspend
>   - the system starting to resume and resume_noirq
> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

merged to i2c/i2c-fixes.

Thanks,
Andi
