Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB041A922
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528110; cv=none; b=kLjrbzum4MFil9nWkLuZ9bKYcYdB/tzxqKFFhjevIDbbQTfCFQTaaXPmNyU0wy0x77I06LCZwbbM4BBfuQS2PUYBU//QUzNngh/WPl5/JMlFlEys5q5wzuh2/22Brm1fgwdowYi0LbyQv8Hfke9MqENhbvMa/InFDzL9O2/Yqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528110; c=relaxed/simple;
	bh=zfcQ4EG2OtCNn5ocZf9Krc4CphTLDxQS5rKzoGFUnbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZTijX0/bx54J24Dk59tfdg467b40RgPu0axYwcjX6QQ/idqbBo2SnfnOvXhEsLwo91yYeS/TrDPWyA84wUW1j5AE59yHzsIAf/52lKeNVfznsqAylgOQ3VNQUjx/1cHwInhD1zk+cxUaEIFBdSYZFPbi/MEpmt18nUM0393USc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsAFTU+Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsAFTU+Y"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so8303755e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786528107; x=1787132907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgAavsMPfj374Y2O8g0TeLMK69exN+jOmzYmrQT4dPo=;
        b=wsAFTU+YCu1BRUS2Johz9KzMzmMUPRt15rEHcN7+aIWDwqJi5gjCSVBWUiWTF4gvvv
         e5OeNYSBCtV6mtp7CXlCPMLvoDGqzkv8d+ryOnSfytCLlV61nW90JxFCGxFssbc2X3QZ
         lnrWvE5eNY+uQIE58Xsl5arfgcD1m4Dra+VnQbo6sMUb09J33Oh8VWvjkbGFC0FFaZ5K
         ZPOPrKT8b9XdRZFShmc9LUHlncwuUfaTZN0w0W5qUzYwp/BkQv169/pKFbV188Dq68dy
         T/po6fdWQuhDr/HovQ0vBq6aGzPB+rbDqwmFl5IOzNUHei780S2gC7dRRoEQN+He8QXX
         7BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528107; x=1787132907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgAavsMPfj374Y2O8g0TeLMK69exN+jOmzYmrQT4dPo=;
        b=XRTiX6XUp8yumXM5eRKj+sWP1nriGJGRgi4h6oMFY7T1vB4R2ouYCBDkLYeGfTfcwp
         51scmWE/P7GpnGQVDf4vuNvH/tPsfTu+BPkwE8rebIMeGCVAcJJFPjoJNUIm7l4LT9Zg
         bx7KtRwVEaVjWGoNSC2tqm8vt3QsR4mIgwuhWkcKAZ/+wUk+LxPFAgi/YZ7umleEukA/
         8Ha06Nluca7jX6dZBE8yClRH64x6MZQhdWMaq+aJRjz831x5xGrQ/WCnEQs6rPOM7yRu
         X5R3ibx2pINDY5weGXYdddafES2enE5PyAPNLqrMSaSoeqbZnHOQiNLz+BkgLZrWVZx6
         +U8A==
X-Forwarded-Encrypted: i=1; AHgh+RquVvXVHEc0PoXu9CDm01SL1gASef/FCYxBIbqKA4DZQV9Eiah8tg59Ih3p6OnU0g8U5Od83cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/3ZmrKZplesoLkLLWJKDHya3G5A2lRaIs1zfwMa9S7v2Gd4r
	8ppbRC5z7qtOKaWRyJfyNLXX4V6EjFK/2D+PDSU9OWeyxK7N43L5kik85155j+zqDhU=
X-Gm-Gg: AR+sD11BaWTEiKenhHY8cjU99gvK7JL1NCLfZBgk349xIZPGyAJ6EVx5lbuGXWkuh5m
	ffiyKk2HonbopY6LGN1esv2CEf9VmhLbc/1xddf9IQoG1jeO/gBxSG9eb9o29Zwu8T55q6LDAAW
	TufJky+iZbnnD09H5DcnGtHNg2wcm7rwqQyBCFl+MbjRmjYwPz/9Wm4ko8MofCqXJkUWDi1boux
	IyUNGhe3JlU1dV4/dYSMEuHw5T/zGTnSXAyMLI+oV8N9GwK1BzqQUAPRKlhMytX8GEujp+bUXGS
	6KL5fer773+2dbaHNiXyuUdiiUF7MAVIqon9AOmasZ33Mro5uLV/jHx/+28eJJy20J4QtCZqXfj
	CvILsjKmJOZgTFaQtgLw84h9YB2OsQLZwKIWF70lh4hZ82YGEMxjsSUlqRbtlIp70TYG91+MBZL
	v5dybRTW052OOaM/vzvnwiiOIBF3PiyDOXJdGyb+d3v55AXAjlaKx3EuRfiG7/8bTmeDZuiLXvx
	vPF+u/d
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4997c0d7775mr54602815e9.1.1786528106684;
        Wed, 12 Aug 2026 02:48:26 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.63.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4c10asm5835562f8f.20.2026.08.12.02.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:48:26 -0700 (PDT)
Message-ID: <754d6dc1-1993-4fe7-ba45-31d02f7e7a0d@linaro.org>
Date: Wed, 12 Aug 2026 12:48:22 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: scope the exclusive RWW lock
To: Michael Walle <mwalle@kernel.org>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>
 <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
 <6e208a8b-da11-4ba1-adfc-f1e80c891310@linaro.org>
 <DKMQSZRM4QEZ.2EXQD5U58EVTI@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DKMQSZRM4QEZ.2EXQD5U58EVTI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 9:14 AM, Michael Walle wrote:
> On Tue Aug 11, 2026 at 12:05 PM CEST, Tudor Ambarus wrote:
>>
>>
>> On 8/10/26 11:25 AM, Michael Walle wrote:
>>> Tudor, do
>>> you know why you've omitted the guard() in spi_nor_rww_start_exclusive()?
>>
>> because using guard changes the behavior of the code.
> 
> But that commit removed the mutex_unlock(), thus keeping the lock.

oh, the horror, indeed.

> That wasn't the case before the commit. IMHO the Fixes: tag is
> correct.

+1


