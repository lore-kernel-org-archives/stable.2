Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0B470439
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806240; cv=none; b=lLyp1gj5bT3RZxV5kHvyavBMI5PvXoS6IV74LG33XmVCwtTf4m8E3pzrMnZp1TxwYj5yueSHEe6vHoO0RW7XaYgPwTUexX60Amdwk+Xn9UIJzBeJmH062X822p1fOfXqMGWaimvlg40rwnxG7lAGANvshTIoBM5dmw+F8Jk7V6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806240; c=relaxed/simple;
	bh=Eb4s4/iQHSUXZ9HuzdIz7QSVMesCI0MvaBjzTEDaKaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7mypZk1Z+DKHQmbKzSWztotT0Tv8/G2kZx5PyEq8fYLhT9zu+Rx2auZhttvcK6nCkAGJTTMiQGY8jQLTymsIwHOScJDwjLR27WYhLJ+7nXiUhxcp/vAEZo49j58OzOEE2zDpYlNzUGe/xPdraGfqDU3WWghbi+9IUUOMF4Ltrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAvG5St3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAvG5St3"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2af9beee4so120590e87.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784806235; x=1785411035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=87QtCEbDS1yneeD8KD17fyRLqP9fiy/6kt3pJMDAIBA=;
        b=IAvG5St3jeYXItKhzczUcDNpVd9GzRRBoVtxAKKOEx0vfwRjOvNjR+Ss9GqNFSG1Ey
         aqyEEbCeE7tCrZR+kVjScHLdYt4hkhWIMX1IigjKq/lQvlRkL6XbJESSl/0hUk+3bzO8
         5Bb7gNljRmBIvsNPEkOeAuxcsKiTSL1SLbsjxAo6XGeWAexSQq5Yy8SEmeE1I3e4Cmsr
         94nKNsdWD3aTgnS0l+KwPaZgap437zfMxjCtKCFXKh0lQau/Q2xLmbF8I0iaO6wKR5IE
         l8QWWfrlhhBASjL4bTGJCGmyM61Fjn8PwS0PlIepBKOJich4MZZnedviD9sQNsybe/lZ
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784806235; x=1785411035;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87QtCEbDS1yneeD8KD17fyRLqP9fiy/6kt3pJMDAIBA=;
        b=ZXp0t91zOx/q1qMXbzLp5LyUZ13cPTEXatrfTPLpLVCF33iVLwzFCNX2yCT2qkx2+4
         o9eNvyvifEspnc9njK8z8v4MNHdCfz+BgPKrRcF+yXHU59NMXTkDgtqpOK8bhjtauLcv
         +8LlrBDeQ0Ewmzam/NPi/Dp6tvaNkWjl+2V0yN0tgUh+QWOh9SNi6oNhzrE6wPfcVNOC
         bb5SypgfpeR0pGwwC6a9HieLA1UkwV9EEo8y49qN1x3f1a3Ra9IPddivZrffQR7tosqw
         rKf80CqcKKjde7vkaaAfg6inclj5hWPpAjl5jSQaoMI5njBbZJ6IBwN2UqbWSiDrY1NV
         mEfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFuNlyCSzdbD65kgffF0JptPO2tdb2pZ/GrKyW7zTgCzwcECIuta0GSeQuH3dsdN5fhkVFU5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQy9Dfxywya/yV4xd/5WCNKo0FL1x7UqyxSeWKU6DS9UbsqAd4
	KJ1+ksIzOU/fMt9fGggVBLbnjtOvK01L0cv78DhLS+8NaDYQ4g1VC3JgIGaEUFK+3Ho=
X-Gm-Gg: AR+sD12HK9bBC0yMmhhHnCJv4vE0xmuIiODI2AVQzmKlG5sq8QHgQd5AHztmxV7ZTI4
	pn0D44oatygaNaR8wkl5sb2lJbgX7mTZpQLiJ1cbSP9DouXmMsb24A4J4i6BET+0OWd9Iy5Y5kW
	aGzX+pcp0K+aiWv6Tpbcny35TJRhGd8uQPPYPTyQnJ5QaoZhKsm8bl7NhIkwtyoisLMQNLsXJHc
	1ydejM9tucu9EbGJjuedvvIr+accKK2lcE/GKmh8fO7A2e0TfGBMcooR7piTaSNbfNy68zvIcbN
	q6LlUtbLdiyj08IBBrEK8p+Ju5K6qYqPeLGPkAQQWJVuhjBuwTFOO++Up+AdmQ8BulMtOBz3hqi
	hvgyGJfXGGKI6ip3809F5y831vUQogKozZR6J9RUpdRnEefwktCBZDvJkrCPTeVp0XUBvfonrO7
	uUJBlK7O2s0yyFx45I8D8r3GYnH3FQWQ1Qt/bjmbhfX7mc6G4PTrkBXWq9fL3mLJvD14U=
X-Received: by 2002:a05:6512:3e01:b0:5b1:5e89:30f6 with SMTP id 2adb3069b0e04-5b2b2f6efb3mr290535e87.3.1784806234965;
        Thu, 23 Jul 2026 04:30:34 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b0c511sm985237e87.0.2026.07.23.04.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 04:30:33 -0700 (PDT)
Message-ID: <58bb39e6-d87d-4c47-9d43-aa878199c31e@linaro.org>
Date: Thu, 23 Jul 2026 14:30:33 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: qcom: camss: Add "gcc_axi_hf" to 8775p VFE
 lite clock lists
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/26 14:09, Hans de Goede wrote:
> The "gcc_axi_hf" clock is correctly listed in the clock list of the
> 8775p 2 main VFE-s, but it is missing from all the VFE-lite clock lists,
> causing these to not work on platforms where the firmware allows turning
> off "gcc_axi_hf".
> 
> Add the missing "gcc_axi_hf" to fix the VFE-lite blocks not working on
> these platforms.
> 
> Fixes: 924f45e58b1fe ("media: qcom: camss: Add missing clocks for VFE lite on sa8775p")
> Cc: stable@vger.kernel.org
> Suggested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
