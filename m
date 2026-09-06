Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64E31715F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703383; cv=none; b=hs/z7fBruwBWdqJYidIM3IpMt9WdOYD1WB4WZiNruE4kdq8CbhV1rWTcmwQwpZjAvKlZlPZ6Vgk4NA1Iih6OVp85bw5N6aQOEhCXoyNo/s+WbMtNC4WprjrNbCkJtFHCSXcgYo7gAM2xZLjjVHt50ZfniihdHjb1jwsr5t4y9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703383; c=relaxed/simple;
	bh=aBL2Q+ay9Sl1XHHZAUW1SLris8znZOlctUEWmfLEiGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tom2jeaDBp88xVKAkufnbaB4R3LBktXeQCULzqHWxLLO1Tt8l4m2aFeMmPOr6/+Pmu6b77duSolCj3i+TcMDYxiyENvzY44PjQQw64yUi5rtqyKo4SZNoZIUZvQzlFbT3ePxVgAdN1FOx2T/ubyArkWGHM/NseDdaoxkUa0c3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCFcKbjh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCFcKbjh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b9320423cso28641905e9.0
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788703379; x=1789308179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14jJVZF46y58TMyS39OsdlGX+U+N7xxuWdF3HxtoPb4=;
        b=QCFcKbjhD2vue5f7VklaFEihv1dXKUUaubJ3ggN7JwdPCT3yzjB3CJsLH4fKe54GXn
         Ax+QG9SGsIH048tYbKyDxPgHcfo8Zb+U5NE0OVx1bEl22CzQ79O4ovvu5AMkL6GbnI6A
         6MfcE9wVvQfmo8tWCiOZMDteKJv/mZtCE0/reXnT5PD7sm4Sv0YgcRSxRqN5AvUDAHhF
         iCGa78h6gwSuoRBOqN34+0F+/SUj5g7gSPcKuMw0IzFB6AGTcYuK7KLVfS8mQgEDQlGt
         73BK7axhgBEyoI7q1XxreiTH+2euXcqXdIh7BABA9j/qxme6Zs53LR6irY5sdHOpUitU
         F+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788703379; x=1789308179;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14jJVZF46y58TMyS39OsdlGX+U+N7xxuWdF3HxtoPb4=;
        b=iDnYs4y1DICaKoEUdJgWYgMNec4xTejq5hMbImVXrICGHMYRTW5YthFWmZBuQjuzNd
         5WDLioK3ZYVf5SJbcF0rBZAxSxUKbKzM+sbN7i4FR9OZ2EjeIdv2fZVoyZpRub7/oUx3
         dnfqW6Hec+7g8B5qUBfu1eKXmdjbmBbIdyhi6IrIuhxSG3K3vnQ444I2H7L117zoAXzt
         3geCTdmk54PmKLabjgEABM0+O/QfjjEgXaRuOEMnR/jtUVXrIcKSxF9NHbxep1jgaGQ1
         yCBAKMlHDJguyn0Vho9p5le2vhsmhIIOqau+DdcI+EVuHCV4QWbQ/NqiKAbH+9OmCvNh
         l6jA==
X-Forwarded-Encrypted: i=1; AKwUvBw/o2Cb/ecRa0cOAG1VrUxnFw/MjLCDdSFjqXlXpXwXyhROjaIGPPtp9Is3zsQShLxQ8KqV7n8=@vger.kernel.org
X-Gm-Message-State: AFuF++lc9LueLDhvCFQ38hoOUhMqAsb4i30Dt1zwFxSOaYMQAD1ZlaF4
	ntC6gy/eOzQMZGLY3skVyLlXKtC1ehAaCgyDYSMTF5f7Aimj7SJrV1KY
X-Gm-Gg: AYBFou24QZGlEy7/67fVXVWtsj763raZb5PDw99Bo9CiiQNZF30R2pGm9U3zuFP6Pjg
	CeeEPohOgOvuB4SX1sqNVzheWg7NF/NLkTMMzix9br5Ipk/8HJaXkNxfrxQ1T3fwi7+YPA90igX
	QqoxTNGRfrochBwruit20Vfkm6MbY7mulf9Ym6G5TWiNUVPwJY7vUVU3sSp/pLAMjSh/iIFyHe4
	o8yB0AhArsSUUUtmjOHco+qXEMgUWJRON84oEEhZ8BPe6UqG4vUp/a7wnYcsU8z3cJZRx/ZmJem
	OzTxY8+S5ZBz/1rwBHQ0327MDdezMKZ6BID2phiiKai5oS9FMW6hE25s/k6wWHI9JeGfZhxzYkE
	RpYGWmLzl9yC4rlV9WqvF9FrbAT83mmXi/5D5lex65pJ3J8fktyTr2VMDJEIlBW+Lee4jUXj8t1
	KKayyU18ym5ghu9WJKqqzYoG32VX/2TiQ9qg/r8TXe5UDTKDEMzCpeDzB+j8yph53WxvkuTiYhT
	L8KgjXVd5slh8q6RyjU1HLQNN3M2FRGjYRf1qhHKRqLXad2CBUHds8bSjJIH1rv67YzGi3iBYLQ
	eg==
X-Received: by 2002:a05:600c:6383:b0:49c:e88b:b7ce with SMTP id 5b1f17b1804b1-49cf823f147mr339885125e9.11.1788703379146;
        Sun, 06 Sep 2026 07:02:59 -0700 (PDT)
Received: from shift.daheim (p200300d5ff3cee0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff3c:ee00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm131583525e9.8.2026.09.06.07.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:02:58 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.100)
	(envelope-from <chunkeey@gmail.com>)
	id 1x3DST-00000000Dzs-36fv;
	Sun, 06 Sep 2026 16:02:57 +0200
Message-ID: <fc0a0908-aff5-47b0-8575-0016a3cc7b6f@gmail.com>
Date: Sun, 6 Sep 2026 16:02:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: p54: validate curve data length in the
 calibration curve converters
To: Shengzhuo Wei <me@cherr.cc>, Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260831-p54-pda-validation-v2-0-dae566b388c8@cherr.cc>
 <20260831-p54-pda-validation-v2-1-dae566b388c8@cherr.cc>
 <f3eb0dfe-3b9c-483b-b802-2207fe8b747b@gmail.com> <ap1R0jU3UMVGI3ml@pve>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <ap1R0jU3UMVGI3ml@pve>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/26 1:43 PM, Shengzhuo Wei wrote:
> On 2026-09-06 11:31, Christian Lamparter wrote:
>>> diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
>>> index 95580921d933..0dc848d77c5e 100644
>>> --- a/drivers/net/wireless/intersil/p54/eeprom.c
>>> +++ b/drivers/net/wireless/intersil/p54/eeprom.c
>>> @@ -414,17 +414,22 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
>>>    }
>>>    static int p54_convert_rev0(struct ieee80211_hw *dev,
>>> -			    struct pda_pa_curve_data *curve_data)
>>> +			    struct pda_pa_curve_data *curve_data, size_t len)
>>>    {
>>>    	struct p54_common *priv = dev->priv;
>>>    	struct p54_pa_curve_data_sample *dst;
>>>    	struct pda_pa_curve_data_sample_rev0 *src;
>>> +	size_t needed = curve_data->channels *
>>> +		(sizeof(*src) * curve_data->points_per_channel + 2);
>>>    	size_t cd_len = sizeof(*curve_data) +
>>>    		(curve_data->points_per_channel*sizeof(*dst) + 2) *
>>>    		 curve_data->channels;
>>>    	unsigned int i, j;
>>>    	void *source, *target;
>>> +	if (len < sizeof(*curve_data) + needed)
>>> +		return -EINVAL;
>>> +
>>
>> Hmm, Puh. Interessting. Several things. But yeah, this should work.
>>
>> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> 
> Hi Christian,
> 
> Thanks for the review and the Ack.
> 
>> Still I have some questions: Did you write/touch any of this yourself?
>> Or is this patch straight from the model?
> 
> AI found the bug. I wrote the fix myself and used AI to review it
> afterwards.
>   
>> It's because I can grok (heh) why "needed" ended up as a separate variable next to cd_len.
>> But why was the sizeof(*curve_data) not included there too? It's only used once in the
>> if check so and this sounds like the "needed" needed some extra? Maybe because it was
>> already checked?
> 
> I kept sizeof(*curve_data) separate because I was thinking of needed
> as the input data size without the header. But since it is only used
> in that check, adding the header there too would be simpler.
> 
> Would you like me to send a v3 that makes just this change in both
> converters?

Well... I think Johannes already added v2 two days ago to wireless + wireless-next.
<https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=ce858fa6b8a214dee5adb82358885fa024cdd887>

So: 🤷. I don't think you need to bother with making/sending a v3.

Cheers,
Christian
