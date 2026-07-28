Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED8370AC2;
	Tue, 28 Jul 2026 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274665; cv=none; b=fUr/tJQt9f4snoA9XdHVJ5MbgJzpOKNoPwBgNA7yFVuBCAtK08K6IbhSpwCZZLsmXq1Lv7tjYq+Qn2ssMAHZQXp5mvotivtwBH1WlDHUAqtdx0thvY3VVQXt1c7dbMJ+uZbWV5k/9oZRUMUDaJcaN/A06vJXXI+ZT7XC6kGKxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274665; c=relaxed/simple;
	bh=rJ3m9Gv2J5739IjOoS5qvvTHsD1y1jikN8n7cECQnh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQarfQzroWh6V8KutUa0XRAYPRKXZ3kczsoW3oaWtK4PQYwZbWlYhcrAWzFZxlXFZCaB6BDUnOVPHjLd5LZGCBq2Vq1clFSOSotqGok7F1HK4DOKTv/TNqZtv2R2mY9dr8V+9SUiJ6QGE/FKDoBHn2COPBb5rl4zzGCPcn4xuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdMq2g/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdMq2g/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02901F000E9;
	Tue, 28 Jul 2026 21:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274663;
	bh=bn47SGtvzlqa35ojKMRqPlcCFuAdF0eQiPnc1PYVbPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RdMq2g/Y4mzw97shcj6AUMf9JcGHzdX5MlNowWljcF7OI7PMsF+9f1K1BnnQl0zIy
	 wa7qe/z0cAo6hCoUQi8RD/0Pei0BjQr5eBcmwILbXoAHNYkeFddkzFV2pXEFYOeHiY
	 O2uoRdJPXO2jTkckeBA99+yLb7FGV1NJjdE4al0M2HrclfZgEvID+8w4lrpYyxByCy
	 FOPNitEsIRUL9Qyusi1S+3Jxs2UXHTGW3nczn0hUXFlEzwae5KazLL/TZWTH4uPmOe
	 iM3X4qyHCPcpT/lyk/qxTFo9KCVaxo1K3nRZ2bExi4MkG4O8mkKyXuOmUEZnKiM8lk
	 ypiaMg0Nz8Zyg==
Date: Tue, 28 Jul 2026 23:37:39 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Wolfram Sang <wsa@kernel.org>, Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
Message-ID: <amkhCsPknnM8yDVk@zenone.zhora.eu>
References: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>

Hi Wenmeng,

On Thu, Jun 25, 2026 at 05:42:45PM +0800, Wenmeng Liu wrote:
> cci_resume() unconditionally calls cci_resume_runtime() regardless of
> the runtime PM state.
> 
> If the device is already runtime-suspended before system suspend,
> the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
> As a result, pm_request_autosuspend() does not arm the timer,
> leaving the clock permanently enabled.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

merged to i2c/i2c-fixes.

Thanks,
Andi
