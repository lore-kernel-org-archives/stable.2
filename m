Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010803A5E97;
	Fri, 14 Aug 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713209; cv=none; b=WF0iu79OjAG5M1vcCtTt7AHFZykCdhf2kGqJHm50dy6ThwJtejaO/FRL4FTPhloMogU1KkxR+KInPOh581yFPirUmgdQqtHgkR5UIPPxRmACG+AiP6DqVKVlzQ12xR45h+SdV1vMNL+3YtQN/C9mu/sgKYYNK1Y4NXQuynEFyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713209; c=relaxed/simple;
	bh=T1iIZQOZg2IIfWHZgVvUDs8UhOL1OzFRx2BzTeewfL4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iVPN2SXQcg3SjmzsONNDi4m6GfaK2QppS+SmoQrf4oC4ou3o04RS9YeARmX2rFgSy9P4h4MB+TLpFOEQ8tr4q4jT/vIDmf/n3AJhWjeR0mv6YSx2LJ+3Q5QjU5vLMdTlUOt4qP01ut/IspwcnOvLUX8U9dj/+5lGd8eKuTX8dPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAL5/1qX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAL5/1qX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E71F000E9;
	Fri, 14 Aug 2026 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713207;
	bh=OISl6t3JYdQjB4/NtkW80JP73/n9+0Kec9tYtBPtrSA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=HAL5/1qXAlTBhv0GeJsNNHUw9hR2OmcOAxGfSmbYmyQEuhcRpSFsaqWE7iHsbmfPq
	 Asrxxr+G5f9LkmUWxn7rJODFXQA9WvIjHjqSKsVg5mAE+nb2OlPXmj2V7d15ZXxDW1
	 h6VFSe37ivOMwgkHjilyPdouJFRJm76clws+gNjeoKSCm8rSCUs3Lxv+gaXM/61rBK
	 engrHdm6memkFq/SGiRLGqzXgSMNMatmmmTJ7k5Av6Lb6sTd11sMAWUJHe71um1X9i
	 dOhi9s+DtjPxpg6e4tGrCD06ypwDdDqggM2xu4A/TJC42nfb/gh6mhVWgryu8KP6NK
	 7i6PUj/c++n+A==
Date: Fri, 14 Aug 2026 15:13:24 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sakari Ailus <sakari.ailus@linux.intel.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
In-Reply-To: <20260808145748.2926096-1-lgs201920130244@gmail.com>
Message-ID: <886oo2s5-nn90-755o-927s-0o1q3ps7p3s8@xreary.bet>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Aug 2026, Guangshuo Li wrote:

> quicki2c_probe() calls pm_runtime_use_autosuspend(), but
> quicki2c_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 5f420e8215c6 ("HID: intel-thc-hid: intel-quicki2c: Add PM implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

