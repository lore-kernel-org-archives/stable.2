Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF49469832;
	Wed, 16 Sep 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546023; cv=none; b=DhjjmJMjEI/JRjqsGPynmQCaD8LotmV6/kMyV42qw8r6Me6lyYPGVJ0vgCuDllHrW3KS/hOgOSApngwvCNQNrgHJQQmDXTsxTLwlSYBMrGdbu5Vm/SpzzGsPI+0KSpzZgYES3UD4QwkizL3QV6mRFsTbDd2wrObS5cIk+e3t87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546023; c=relaxed/simple;
	bh=qBsLtrgL2BsWhME/6IWoxSDr8ZGQiCX+IM0JwRh1Urw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJSPVECcaY8h1wI+55xYeQnNNdMGgiuEhwG7q9xaY43uLpvx1P/evvgbfF9BcrV1+AzNktQaBvJVyBZUaf4QCTUSo+aT6hE747UHYawuiHFDAGI2/2JI9V8UNyX0IMd8NDqhCDTwBMzwfgOJ5IsVlGbcRd9SuOV1Coqk5a6ZC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0Z2VBTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0Z2VBTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5891F00893;
	Wed, 16 Sep 2026 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546010;
	bh=HZnVVpBc6Aa4FKuBAu2dpMsjkz+nKUCxaxD6aVitHxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0Z2VBThJSc9KtpFtp7CDZR09OkwOSmlMIWDrqV7Rp4OXO5OJRT76/yXk1jM0Dtg4
	 7T04UfkfCaLVTJyCpbPVKTNV+b2SuRc7PwXr21pAvVw300fBE7Woy4Br7d3zXRMMPg
	 A2BTWEKrKZGQWs8x3CHrf6le4bFS5eaKwEYfI2TcGHxnbIIQdK67HUF3X4/o3krdEz
	 jo2DYJwNuojyH9KfDDioT4DkraVTJwOKPB51Qtifg/Hzmh4CKyICYaHpiiZT6OvFXw
	 EWotJc3uTHeeMyYMB53LsDxtmqzmlUJW+dC8ZL4UiFmx4s218lu2B75GE2xrXfE3os
	 unyUBIwvh5dKA==
Date: Wed, 16 Sep 2026 10:06:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Liu Zhenlong <dragonliu2018@gmail.com>
Cc: linux-i2c@vger.kernel.org, konrad.dybcio@oss.qualcomm.com, 
	stable@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in
 cci_probe()/cci_remove()
Message-ID: <aqpNxZvYu8pDCchC@zenone.zhora.eu>
References: <20260815140931.53297-1-dragonliu2018@gmail.com>
 <20260818175750.4205-1-dragonliu2018@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818175750.4205-1-dragonliu2018@gmail.com>

Hi Liu,

On Wed, Aug 19, 2026 at 01:57:50AM +0800, Liu Zhenlong wrote:
> The of_node_put() matching of_node_get() runs after i2c_del_adapter(),
> whose trailing memset() zeroes adap->dev and thus adap->dev.of_node,
> making the put a no-op and leaking the node on every adapter removal
> and error cleanup.
> 
> Use a devm action: the pointer is captured at registration, out of
> reach of that memset(), and devres runs the put once on probe failure
> and detach, replacing the three manual of_node_put() calls.  The
> setup loop uses the scoped iterator form so the child node is released
> automatically if devm_add_action_or_reset() fails mid-loop.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Fixes: 02a4a69667a2 ("i2c: qcom-cci: don't put a device tree node before i2c_add_adapter()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>

pushed to i2c/i2c-fixes.

Please, next time don't send patches as --in-reply-to.

We should train LLM's not to take much freedom as to send the
next versions in the same threads.

Thanks,
Andi
