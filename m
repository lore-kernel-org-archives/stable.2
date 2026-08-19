Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA837FF41
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137424; cv=none; b=Z0d3PxuYH3ZeFC5q6Eg5HhijQBn1TGOwix0Le+CHz0/pCN96SnSeV59GELT/lfYsMjEh7cX/h9GzF1am26JmH19Ryh596ZjVzPu+CDsGmulwbivCeIFBH4lVTrWwKZ3WYfazlM+npCNR3mErnsMXuXjmZ0TAtsVpC6yYVXynlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137424; c=relaxed/simple;
	bh=QBojQsi8wY+kAhHZS4n4dE92YBUTLKJtOxmkrL4V4pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgAVQsuLLk42+ab0/mb13ttIQaBD+oKVKt1+1fwFlnfV8Td38zH9Mc90v4u24TqJYULf6VumnWeKRx90IdfuETlvqpcQdv0XrSe2J87dz2B+rzL9bs8pY3hRFDG1Zlx5pYNJ91qWzyRGcs5OeSDsdkqNHSLb87C8MREWbVlwLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pg2z3eWx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pg2z3eWx"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aec090da14so122058e87.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787137420; x=1787742220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A4ELa6x+Yb5HCgORI6eX8lid0seyZkrG1l18lRvxugE=;
        b=pg2z3eWxK7eWErztV+PPmYVcQa3PCKvlEAE+KVuS6Hw9VpalQcpiPtIr9ueHzNZHZc
         zeeoDDcITYKYRILPgfe82rXRMvcULtYKFMaNIo8I1NE7xdOwFQ7x3D85S2mSNM1q3lzK
         nBFoG9hjmH9xFG8M8UAbW0I2tZuNYXp3+nB6ooO9M8ypah5QQ1FYDx+fTALdkkCRdUtg
         tzCkAkS8yz1ZzK6ZjU0177qb0yY2o/SVP2BgWlkhNmHDpcNEx2ShiAPynA218hLpq26h
         wb8s2m2bU8+bdK7Rc7I8fQufXbvHKpp91sqzoQONqLERsAvBX4mVTZp4FLetUw7Y3qox
         KFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137420; x=1787742220;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A4ELa6x+Yb5HCgORI6eX8lid0seyZkrG1l18lRvxugE=;
        b=EyLrSapexA3wdPUhKh4JesrDdHRu1fzvGelwk3jpVqd0+13L7htcoO7JehMeXBosNc
         +yPSK2JFgRP8lgqBcT/Emn6Z0l7dIOosYuF93e+cSTAz6vDce6lHqYGLu2GVtkdEsjZW
         ItJkp3dT2U5+7rkszQqNApZgsJrvVfxjw86Sll4AlLjKCH0HnVBCuSmutV4k1AR0qaHj
         aNCvY6uNAXvPDuebFYKVhhASFaz9JpUZn2k9MXbLv6/gbvNjfb1uH2jqQ3n4Bzx9kxE7
         28Fw26kZGb07tiDLeawrLgO+SAJEhUTBpsFcxsoz8LWayA6MDbEZDQwydmqd+igW+Ctj
         6HCA==
X-Gm-Message-State: AOJu0YxooDLaiTJEJ3SW/j96QsyFvTEUQPjCI68IMZMKF8tgnz7k+Cde
	mBkBdq44UNHaJNkPb0zQCECzDneHqK17fmBIgqQjb08dXhZpvcSOve7FTy9tvII5qA8=
X-Gm-Gg: AR+sD1268RpwqFucxf/oPnRBsd0YFHQeReLDrmwGq0/GTH7IJFcg0R5eDJOTHbW/3CA
	0kZaWI4CnmW79/evE7VALwuncgJAcNC2FnWmiACZGl3t7HxO/ja1WeTWhS+Yyd4oXD8sZq1i8aO
	2FvB+GexZjpQC6WPftqE71jkryoccd6SDyYs9xJ7fw04IZdYtp550E3J5SCteJc+0iJHEt15b9M
	jD7GrY9X8M1Fd20ge+hwfmoBrY1YoJQPZiW5pDpY4/hQDNJG/mH48VWA72BT9UST33VNJ3IavbC
	/HjEX5Vow75ldTWEaL3AyxNcT6H3hBo7zj2ose/9sMgVCJcY0ssvWhDHgCAyo8A8cz9SMM9Dc6N
	gBe+GplhHd0jxptVBpYezmlSrA7gHCOKr85u1k+PzNDVBy6AN4gzpl2b27yYgDEgu1RZdr+Zlvh
	FQ3n12cK1bclR3XJfAUV64j5lf/1H/isehvBFKC4HoMS5hj2IFSEqVxt1q+Xr5XPmZsBTQvD2Db
	URIaXX7MWn31vLawcfbKVjbOokEoiwFzXvew001wg==
X-Received: by 2002:a05:6512:3c8f:b0:5ae:b2df:c11a with SMTP id 2adb3069b0e04-5b4788fa611mr702473e87.0.1787137420382;
        Wed, 19 Aug 2026 04:03:40 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788eb02csm430814e87.68.2026.08.19.04.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:03:39 -0700 (PDT)
Message-ID: <440f21a9-4564-4f89-bbef-4095414e486e@linaro.org>
Date: Wed, 19 Aug 2026 14:03:38 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Wolfram Sang <wsa@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260812094425.3515179-1-lgs201920130244@gmail.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260812094425.3515179-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/26 12:44, Guangshuo Li wrote:
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

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
