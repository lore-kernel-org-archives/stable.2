Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962829E110;
	Wed,  3 Jun 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492990; cv=none; b=CAQxzLNbdWrkz8ZOq+XgXpc8QJqOtRKb4FdMT89Fi70p0Xh91tlOvaUwESmUrXOdmzISbvo7rqbpXKYfLqhaFsLXqa2KHiqC6YAh4vEgpADodXMvYVmQvVncUzBrBCUMYE1sshUtFG2mkL6cHj7jqSeVEHdbWsjwVR7DjCjglU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492990; c=relaxed/simple;
	bh=V+oYBHuxLeUYkA0VMayHZIinYKwJnxHfYknGW33DJtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RYa+6tf5KkRv5A5F5aWkVQPf+r+AKv7Oz99Blfmbs135PMenxld5yLmlmyKJuD6EKLMEsFLQkh5FogVsbrGT3GaQZ0xml7QG3Gsrsiwbi9wk7Q9XDGqqmU+w+osKPoO4i8v2eUVF31dmbW9yknap5OAJFI1MzJggKKS3S4w+FPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1MMETwXU; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1MMETwXU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wpv2sBaYYFs0xNXG/8KbI1KISPXU12LoYQ2EvtHEOvc=;
	b=1MMETwXU+AUBfiHDi72EGGM8LUZgVQVyz9ARFR0TKhkkM5p+eNNpYvBp+tFRcBki2Jxu3Qjnc
	C4xD0YNDGSBG4dVT2FBklVM6aLypoluN2nGexDXh6Qq2O1aJXoyF283eqFmKh8wlEiRcyjnsgrn
	FNetXigRPv8zBn+CWicjhAo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gVp8c5rF0zLlSg;
	Wed,  3 Jun 2026 21:15:12 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 793CF40572;
	Wed,  3 Jun 2026 21:23:02 +0800 (CST)
Received: from kwepemn500008.china.huawei.com (7.202.194.149) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jun 2026 21:23:02 +0800
Received: from [10.67.110.89] (10.67.110.89) by kwepemn500008.china.huawei.com
 (7.202.194.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jun
 2026 21:23:01 +0800
Message-ID: <e49fc109-41a2-449f-a232-d8beac2c5e08@huawei.com>
Date: Wed, 3 Jun 2026 21:22:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/5] phy: renesas: rcar-gen3-usb2: Lock around
 hardware registers and driver data
To: Claudiu <claudiu.beznea@tuxon.dev>, <yoshihiro.shimoda.uh@renesas.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <geert+renesas@glider.be>,
	<magnus.damm@gmail.com>, <horms+renesas@verge.net.au>,
	<fabrizio.castro@bp.renesas.com>, Greg KH <gregkh@linuxfoundation.org>
CC: <linux-renesas-soc@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, <stable@vger.kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "tanghui (C)"
	<tanghui20@huawei.com>, Xia Fukun <xiafukun@huawei.com>
References: <20250507125032.565017-1-claudiu.beznea.uj@bp.renesas.com>
 <20250507125032.565017-4-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <20250507125032.565017-4-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn500008.china.huawei.com (7.202.194.149)


On 5/7/2025 8:50 PM, Claudiu wrote:

> @@ -348,6 +349,8 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
>  	bool is_b_device;
>  	enum phy_mode cur_mode, new_mode;
>  
> +	guard(spinlock_irqsave)(&ch->lock);
> +
>  	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
>  		return -EIO;
>  
> @@ -415,7 +418,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
>  		val = readl(usb2_base + USB2_ADPCTRL);
>  		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
>  	}
> -	msleep(20);
> +	mdelay(20);
>  
>  	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
>  	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);

The fix for the rcar_gen3_init_otg function has not been backported to
the 5.10-stable branch, which leads to a "scheduling while atomic" bug
in that branch:

rcar_gen3_phy_usb2_init()                    ← phy_init() callback
  → guard(spinlock_irqsave)(&ch->lock)       ← acquires spinlock, disabling preemption + IRQs
  → rcar_gen3_init_otg(ch)
      → msleep(20)                           ← BUG: scheduling while atomic!

The patch for 5.10 is available at the following link:
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=0f86a559900fbe96af08a3a226a86fac27b02b8f

Perhaps the stable patch for the 5.10 branch needs to be updated to
fix this serious bug?

> @@ -456,6 +461,8 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
>  	void __iomem *usb2_base = channel->base;
>  	u32 val;
>  
> +	guard(spinlock_irqsave)(&channel->lock);
> +
>  	/* Initialize USB2 part */
>  	val = readl(usb2_base + USB2_INT_ENABLE);
>  	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
> @@ -479,6 +486,8 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
>  	void __iomem *usb2_base = channel->base;
>  	u32 val;
>  
> +	guard(spinlock_irqsave)(&channel->lock);
> +
>  	rphy->initialized = false;
>  
>  	val = readl(usb2_base + USB2_INT_ENABLE);


