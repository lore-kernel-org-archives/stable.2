Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD04DBD62
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647068; cv=none; b=PiO8C/XkgFlTXCLghPPSeme3L43HRErdQajlmwZXlDx1HoFM+VD/JY80u7a+DkxwHoFd7BTPMU5is+WiOUD9WiSUKSvI1OOgeveMS5KHsDKzo7OAFNUeH8QOvF7mk1bTxoYliexXL7SsfvQKPNPgOwkm8zGb+YFIi7kLYBLlPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647068; c=relaxed/simple;
	bh=2IuuBesuhtQABZX5aTgcPIV5cqFrtbm6oW8Rke4nfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRMdF6+GVXYfmHwjD5HuKUgxui920dm1ZYqMNWmxmaI2rb4LzRHRK6tuzFeIyYPX5ihYGH3UqQ+bLEFsmmWk1XXYomft6ZOOVrBXwwE6GwO1XV5dV/lq/nKH7PrJZ1GIhCV2mxwVBmf4MODxLGDL3pX0ohpyZpx2G1Tt5XlcTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=KGZi5e8S; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="KGZi5e8S"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d37f94so471874a34.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1789647049; x=1790251849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHax/jJrt/1XwwtW9NMv6p1y2gNa0xD70FHoF7NK73g=;
        b=KGZi5e8Srbkk19d0xhNeSKueOlytHXJn2Mnb1IgZJcFBE63RE7LSz5Zq1kSQjuS1qg
         h5n3EU2zFAEv+PLOPQnr4ff9LN33FG6GUXiLB5TpEz3QATMvIF9l8MFFE93aD2DHHfGj
         x3G1ckFmdbMIUdluJFQvViAKg8mohr5QEmxOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647049; x=1790251849;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHax/jJrt/1XwwtW9NMv6p1y2gNa0xD70FHoF7NK73g=;
        b=qlYw8Fb/QUhcx9l3XFHH1LzgpFEGuqWuEX1zyU6yt/4TFbL3vwzZTbwXJJC+m1h7JM
         W9xnENZ4fVtL2uNmOLl6QlEc7OnrOee4qv56cOV8U2hpN6JD+HlPP9jCi33Kb+uOnegm
         dielrsU9XoPs16WpR2XrZL89BdAyxRzn+ym++st55R1o4tnn9mi7aN0eSJP01qMdu9Xm
         Q6oqMQo68/LygRDMjWgAfk4VD25XuDwKyefJpCChaQjjnxobMzOj8kryCQQG/ped+GWN
         lVDaz4x7LCB32kWa4MFiUXrBQr7eTf65hG+lgVtfLf9Nll5h0DTk9FfFT+JIXRMwC5Wy
         mepg==
X-Forwarded-Encrypted: i=1; AKwUvBzV3tzv1CQAelznRFtqoeEsp95HtI6JjapNLmBHeec9uyuxeNwVQyVkJKfdMrQTii7apYYgXz8=@vger.kernel.org
X-Gm-Message-State: AFuF++kwuATVS16LRolJvfU0SaGT6r05T4aFodgfitluGqaZyI7RjSk3
	rZY2kXVg8wlUd3gspAQyas+Cos8X1fAeNYhTii6X5aTX/viq7I7M5bWhHZ7qy8vMmA==
X-Gm-Gg: AYBFou1gYJCkUSDpDca2uXoCQO0RiRWVnDggw/TIrYLr8YM/Hz7VoXygQxwfL8dJ4Ib
	PrucZ9hGzMvTfzA4nFtulD2ztZQcVaFQURO8n/+n6UX+z0PDO6z5SD6DmA9uvThpiL1RebIz2kJ
	a1CZxhWTctISKr94ojV78HMXQHb293ghzcDHHgfFlToD5fZ8JckapmPYQiAamUmZu7lnTovl90N
	abGsANM28pws5NWLKyKlKKSN4N7L56OJu+aENtEjivfB9YVUVSx4zIpMiMd9U7vwKOYJlAUMF8A
	HwBdtt4JTjEyqL2HWiRzOpzwaJAQnr6Yv2EDHzEZiWkwIujpJlgXPCnPbuDBzci6DxCs7Cm9jA2
	KDqJyCCIrwbPjSSy3RSITHy7bZva1PMyPZtBjdDE5L4uzllxLEAF0xxZXS+BC692+Myw48OLwvr
	kcf95ydpg54UXQwBuRzGF/fg4J3qiHvxMEylc07RcsUEJ3B6cgy0bYpGNnrCUwLsCQwA==
X-Received: by 2002:a05:6830:640c:b0:7fa:5c49:5258 with SMTP id 46e09a7af769-80b2eb61acdmr7602954a34.31.1789647049145;
        Thu, 17 Sep 2026 05:10:49 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c466a2e6fsm2510405a34.14.2026.09.17.05.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:10:48 -0700 (PDT)
Message-ID: <7509f005-709d-46d5-8554-b9d2fd0cd218@ieee.org>
Date: Thu, 17 Sep 2026 07:10:47 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Fix runtime PM reference leak in ipa_remove()
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, elder@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stable@vger.kernel.org
References: <20260917115115.2149796-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260917115115.2149796-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 6:51 AM, Wentao Liang wrote:
> ipa_remove() takes a runtime PM reference with pm_runtime_get_sync() and
> is supposed to release it at the out_power_put label. If the modem fails
> to stop, the function returns early and never drops that reference, so
> the device usage counter stays elevated forever. Release the reference
> before returning.
> 
> Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ipa/ipa_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4..aab38fea91c6 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -975,6 +975,7 @@ static void ipa_remove(struct platform_device *pdev)
>   			 */
>   			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
>   				ERR_PTR(ret));
> +			pm_runtime_put_noidle(dev);
>   			return;
>   		}
>   

This issue has already been fixed.  See:
   6b9eaa61ff2df net: ipa: balance runtime PM reference on remove error

How did you find this problem?  that commit indicates a static
analysis checker was used.  If you benefited from any tools like
that you should probably explain that.

Thanks.

					-Alex

