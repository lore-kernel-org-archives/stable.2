Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FA4E8E00
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562699; cv=none; b=NOyfDHIZf6aNzFr1TOIThu9wGTELBGIzt7h6mugaXL1M3bC24TOVQ3c5r9dapQLFISYiG0JDw8EIsZyTGEAvDBsqEREm8wE65fXH+2mY4xVHxsNrbELy+S+HskyqVzWf8guJYxnfb5JQxUQi8ihKC9Mb30scwpXv44v6P3Ow4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562699; c=relaxed/simple;
	bh=c1yk8Di/jmymkTJRvn/VaUEImzqv1dOE803I1gGu0iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+xp1QPIMD31YrMgV3MTm0IeWspiL4dQCkLmaRvcjLeP7Dz4ZZdJ7K4HTHQ1Cr+n3Hh0nEXFULZW7BFgW/i2RE2f7LLhNMROxsRzj9gWsN92jNyCqtceYYbyk1XQR57EZyH69acZs+ISMgxgIJE6ktp2zZy2QuZQnILW8lFg5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAOvu+gH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAOvu+gH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afbd2c386so3218219f8f.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562696; x=1792167496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BT3Kplva3WiG4o+dXirMa63CjRV9ppQitco44DeQ3bs=;
        b=HAOvu+gHu/+LvgQyUO6Q08suImoV0dBQS/qSd6jRa9lKDWPJZ67m1FREcYUUFIkW/l
         yf2CGukmsT+ehmXGP5DMTp+7AnI3bw9TMI6p/agKn8VRv/1aF4KVVbgGHPS4jhkwAjkX
         IuTK8OZLHbrg6Yg8P/FXUe/2E46D15D38uhT0rX5bU8BouXCZWyeHS8nJWi3gtCaveNw
         EM5TK0Gx8bGSxlQ13zHX2NvJhzxAbo7ca7rDhc8wV/9vokNfWBIi+QMsVC4l7km7uslv
         oE8MEPTYbyDrkuhUx3quHGGKC3rXD4R6IQwaEEbBNbok5UZ+VF1y9//GOuk8ZhRDHZ8y
         6NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562696; x=1792167496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BT3Kplva3WiG4o+dXirMa63CjRV9ppQitco44DeQ3bs=;
        b=fItYXNBI2T+/XCitl59+hJ2EIYH051IAhKboxfxici/LhLxi5QLHXFjLd8MqlGSg9t
         pqrj9qKUlLS1Zlyq9MVtQAtVyPHK75npl1oESQ/A47cWIBCRKrugrHAFHHLIDZ2yBhI2
         SUJQPEmOlCk3RTWBHneexxmUlUtSEkslx1Az56aG3YFPeUWpJZt5QmKeXSY5VHds+KWa
         bpbbnZgbSMCrmjzYuEdp4Y8Khoi/IP5TBd5n5uP6FOlyuLEId0X2rAP2V0RaSOEC24St
         zYLNB4ChM6ZO7N4H8pDffy5kuZhYfEYauJ1/67tFMyMI+3CK1c5Re5cJgNtHCeRPxsz5
         lXaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNOM9O7YdzaGLk9Zs2+XEOA8WJ4EGYHz+sJmo1SCK4JBoPZgpS2x35lAWQx5xO7UIGaIPyIIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrmjCsgiCDnJp1LYtpQt9gOt83NacV6pNe+tQonbfrEUSiqcnZ
	ifeSbgrGgmo28sbsZ/rmmVjpfBshB8KacDXKtrFTXWGBCd22LPVMaW+y
X-Gm-Gg: AYBFou2icQdOohl0/XwWFLTSV3pfkxM6ft52T/6B6lt5uqaROy055JnB10RfRgnW0U2
	HL62NpV99yTreuFl9Y20+d3BWFbk+Jv9TpH3GYI7xeyStKdkcM11qm0lrJgfR17/1UGaAHM2LQP
	u4gZIrqZp1cKRISbAUIjilX3yXKUMMU05Z7VUdcnp8Qd32FYgzCGgJVlZ1YXhSnGHlsU8DdZBSi
	7xKyhpjjP2W1W7m/0h+IkHRcdCm10Lm25BGMO5WEV2aFf0BUnZFVsx0Us4zXWiHO4lDvYLXWm4o
	f01+cpQUw74RDm2BWdD7C2W7LCAdl09JgSDZuUnWdWUYObFMeHppYT83tn7e6cnpRmyfyPO5FTm
	klQlSN/GTaXRyHHcOvOlNUQ3HXk3p/2h61B1zYgP70kD5vszOKIvuS+RrF5o46WVR7wScLamNgw
	b2FST7SZniDdazT9mD9MwDzexRL/d9O1DOXlHKYZKdB9zNXWglo92tEBla9tpgtKn+U9sENdODY
	sBImqdirojBVdj6K1Hx5UB/tYY8rw==
X-Received: by 2002:adf:e006:0:20b0:48c:54ec:ebb with SMTP id ffacd0b85a97d-48dbacf598bmr3401360f8f.23.1791562695687;
        Fri, 09 Oct 2026 09:18:15 -0700 (PDT)
Received: from [10.147.33.44] ([135.136.51.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm4576018f8f.49.2026.10.09.09.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:18:15 -0700 (PDT)
Message-ID: <b74e53e2-600a-4aae-a401-2d1ba59bf68b@gmail.com>
Date: Fri, 9 Oct 2026 17:18:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
To: =?UTF-8?Q?Fran=C3=A7ois_Roux?= <franzelfranzel@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261004165124.4277-1-franzelfranzel@gmail.com>
Content-Language: en-US
From: Dale Whinham <daleyo@gmail.com>
In-Reply-To: <20261004165124.4277-1-franzelfranzel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/10/2026 17:51, François Roux wrote:
> The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> current level, so that a WLAN module left powered on by the firmware is
> not switched off. The FIXME explains why: toggling it would take the
> PCIe link down, and the controller driver could not recover from that.
> 
> That reasoning held while the PCIe link was trained before the
> sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> powers the endpoint through pwrctrl before it starts link training, and
> defers until the pwrctrl driver is bound. That driver cannot bind
> before this sequencer has probed. Power-on therefore always comes
> before link training, and keeping the firmware state is now harmful.
> 
> On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
> PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
> bound, the host init is deferred about ten times, and each attempt
> powers the PHY and controller back down. The later power-on only sets
> a GPIO that is already high, so the chip is never reset and the link
> never comes up:
> 
>    qcom-pcie 1c08000.pcie: Device found, but not active
> 
> The endpoint is not enumerated and ath12k never probes. Bluetooth on
> the same chip fails too ("QCA Failed to send TLV segment (-110)").
> 
> Request the GPIO as GPIOD_OUT_LOW. The chip is then off when the
> sequencer probes, and pwrctrl powers it up cleanly right before link
> training. Drop the FIXME and the code that preserved the firmware
> state.
> 
> Tested on a Surface Pro 11:
>   - b921aa3f8dec plus a one-line version of this change: endpoint
>     enumerated at 2.4 s, ath12k and Bluetooth working.
>   - next-20260929 plus this patch: "PCIe Gen.3 x2 link up" at 3.4 s,
>     ath12k and Bluetooth working, Wi-Fi connected.
> Without the change, neither kernel enumerates the endpoint.
> 
> The culprit was found by bisecting v6.17..v7.1, with the DTB and
> .config held constant.
> 
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: François Roux <franzelfranzel@gmail.com>
> ---
> Changes in v2:
> - Sign off with my full name.
> - Use the Assisted-by format from Documentation/process/coding-assistants.rst.
> - Add a Closes: tag pointing to the regression report.
> No code change.
> 
> v1: https://lore.kernel.org/all/20261003091451.4727-1-franzelfranzel@gmail.com/
> 
>   drivers/power/sequencing/pwrseq-qcom-wcn.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> index 7f88a29b2..636dd7e63 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -526,15 +526,8 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
>   				     "Failed to get the Bluetooth enable GPIO\n");
>   
> -	/*
> -	 * FIXME: This should actually be GPIOD_OUT_LOW, but doing so would
> -	 * cause the WLAN power to be toggled, resulting in PCIe link down.
> -	 * Since the PCIe controller driver is not handling link down currently,
> -	 * the device becomes unusable. So we need to keep this workaround until
> -	 * the link down handling is implemented in the controller driver.
> -	 */
>   	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> -						 GPIOD_ASIS);
> +						 GPIOD_OUT_LOW);
>   	if (IS_ERR(ctx->wlan_gpio))
>   		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
>   				     "Failed to get the WLAN enable GPIO\n");
> @@ -545,13 +538,6 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, PTR_ERR(ctx->xo_clk_gpio),
>   				     "Failed to get the XO_CLK GPIO\n");
>   
> -	/*
> -	 * Set direction to output but keep the current value in order to not
> -	 * disable the WLAN module accidentally if it's already powered on.
> -	 */
> -	gpiod_direction_output(ctx->wlan_gpio,
> -			       gpiod_get_value_cansleep(ctx->wlan_gpio));
> -
>   	ctx->clk = devm_clk_get_optional(dev, NULL);
>   	if (IS_ERR(ctx->clk))
>   		return dev_err_probe(dev, PTR_ERR(ctx->clk),
> 
> base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac

Tested successfully on Surface Pro 11 X1E/OLED/WiFi model.

Tested-by: Dale Whinham <daleyo@gmail.com>

