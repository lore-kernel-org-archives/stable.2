Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330521990A7;
	Fri, 28 Aug 2026 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878579; cv=none; b=i9P1r4dsik0M80M3gdVzEB3sRTdNGPFEcUNnrE1Isj3j7NEPrYB658dmScb0F8DKPAsmvugmJgKEVhZjdXdSPwblupGeXygHwMbKc6/5lQccTNSsXPw25eizJDTMrMwGNTPgtPx2voDwcBFjIkLMqrbQCoEymX6dY4fnZXmKWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878579; c=relaxed/simple;
	bh=yvPeGpWHCbKwTZF/cuBsW0J2qtW6g9A2DtckzYmO4S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLoTXSOVvmjTTG47IUcUkGvqJ4FYgyO8qlzecs+69HIeXiT40emEyNSuSiR22OufzrWxUNeQ73jIxPZL5xSyawilP/K/3/HkbaT7YVKrpw+53eeJQ8j4/y44TyN5/p4QdF0OTUb/LzcSVL5rRzIDxJluDBLZ3O0h1+UWsQIWPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma5x5bYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma5x5bYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABC91F000E9;
	Fri, 28 Aug 2026 00:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787878577;
	bh=EKWVIMLjuqiZHTIRgJpFJCAMP4yhuBa8RStZMoMCJvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ma5x5bYKNbUbVoQsSNtkqRSCDgvzI0KIplOOmZKIdS4JeBRkaR+qU1eLueQd12c9t
	 +4A67GawOdELSWMcaD75YAIBGP8h+Brc2VKIpHVdAO4sZhxayEZHA+P+vIszzYaGw6
	 MyhMqu1iDr/SPeFRTbXQj3zVjufmcBBq0vDGLpBo1ZRbftlOLGKiXVoOUPB9EvEKhH
	 Z66aksnNI9GR9Y1OUJZxGqPXCVLS18uUersdt2RLVbT/Z4EXX5vm+XJea3rc5FsbB7
	 xm90uszTUaq/lCXL/RZvGROiUvSTVwPNm59DVl0fZrK7C4m7wKcCjy+GM/WVRZUA3d
	 O1Fj8MV9HA/tQ==
Date: Fri, 28 Aug 2026 02:56:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, Wolfram Sang <wsa@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
Message-ID: <apDcMmn6GB46gXfU@zenone.zhora.eu>
References: <20260812094425.3515179-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812094425.3515179-1-lgs201920130244@gmail.com>

Guangshuo,

On Wed, Aug 12, 2026 at 05:44:25PM +0800, Guangshuo Li wrote:
> cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> does not call the matching pm_runtime_dont_use_autosuspend() before
> disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without undoing the autosuspend setting during
> teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> state. Its managed cleanup disables autosuspend and runtime PM and
> restores the suspended state on probe failure and driver removal.
> Remove the now redundant manual runtime PM cleanup.
> 
> This issue was found by manual code inspection.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Although Krzysztof's comment is very valid, I can't ignore the
reviews that have already been done. I pushed this patch to
i2c/i2c-fixes.

Thanks,
Andi
