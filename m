Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531342;
	b=rih4i9lZnlwq6zG326TBdbKttnAtUDy6OyvurRcbkSKf3vTrA5zUQPPBJJBZeb6ZY8ZM
	 kzaqQwANjZ863wW/zO/vojTXzWrk8nP4gjlIT1jggQ4wAYmpfceBhUhVxG2TVbXHj0CHV
	 EHQj87p7JEUZTfIIOKdPlKOa8a9QnHOg6JOr/2CW7wDKReVEZn108BP9jl8slrEHhC9GA
	 Xvf4gNiP0MdMh5ORZLKGD5fWwxiLfcEOGdIYky0NO5zGPnC+jdlpCn0yOc+qqy4JOlqKG
	 Cw0MV3y3sLAoF0slYfJaf8Ewza/eJ/8/v4eGWGYiCKmeexQBX+bkPWaw1SssNiUporg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jcVy99/4546IpPlUV+chsxZxg6fKFHtjcBIv8IBgnDA=;
	b=EFsTA9RjhpjYm1nH+Lq3FNVGPcE6xrIN+jfIR+ELG3kAZKAykAwxHyefi7nGeXZO/AdJ
	 V828x05nofl+AmF+Kce0QjvtF/BMklDAOoykiA9yywPGLk3ulHWzxEiRBe4qogY1UqF6N
	 Rfe96TuqbSDqIKg388o6ul02tiIbEnT1vvYGZejSlgXk56y2/5fhX6rXBtYFlI/nyjmFa
	 HhoFL4DOv5wir53Lx2wznDCWiR1ay0VyWp0KFvzn0CNFs73ePy8K9OSaF38urMrwlAYZA
	 u4nnjEuuctEKTXXVT1fu5vIOONX2Cte6eJATP3ZbOtZDNdWO7X1+Eth4fE2btnjOrNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lbX7Xkre;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D292606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D292606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lbX7Xkre
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a208d93758so5083155e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794531340; x=1795136140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcVy99/4546IpPlUV+chsxZxg6fKFHtjcBIv8IBgnDA=;
        b=lbX7XkreAKRNKOu5bAAr78H5T54rlJTQ+uR1EUX5bsk5/uqD3MSuwb5tv4C5IgnNeB
         /xFLviFjffv29Y4A6i4p9ESY3p//U32kUVrP6/heuTyMixYJ+MTCgu7Xc+gRySu5Iity
         +vYENv1ugwa8Map53en9lcSuS7np9EDqY4nA3rVGk4qxz5H/P5miXu22NmtXXHrLoqm+
         fWQwyl9ni4L6I8m1pxTTqBFC3p2JqByRwHUEIFNy8KUfRJrD55J/wN7a0ZWJ5SX+HWxA
         AcSij5PmZOQdzDGw/IV4F27lA7imS+nAbkzEIBaCqJRoHgzTGIjPHpUxDWDzNfFNRWxo
         zABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531340; x=1795136140;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcVy99/4546IpPlUV+chsxZxg6fKFHtjcBIv8IBgnDA=;
        b=bxSkbUKLR3Dd9FNnWpxrpDixANNLQ4oQwKiprhjsYjhSq5IfHsx9cJsge8f/7BR+tO
         57JlfosAsSf572Z4AtBFOnkzUSVypT4u2k3zu5ffWuaoa2lGovBIby/4/M2c6B/oZ+uh
         yHgAQvHkj5YLZu5V8sOzDRz1K4zWCh5bE2TCs6YzxN32mILsXYc8H6sr12Rpux2cySiF
         gptevUkRReVHPg559o+Sj31Mn7mQRMX/myOoLEKImwT9b67fmsYlQcYs0uhI/XmAieIf
         nmndw0ikOiadaoYVxQnej17a/ZPYnC5RX0JG+0UicG9GSzgJax/PvEcqWwRDqE1MN0cG
         QFqg==
X-Forwarded-Encrypted: i=1; AL+hErE9CvYW4CCq49mn/OVxeogJuuLkVdja/fQC5SzGWjcDMO2+yltqus/Lu8lRvxxnQI2MIg6p+94=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dY/qW/JqxPuOvwHV4ItjcTU15QkdrQY+KRXL2dMKAQBh05pB5
	lRfscOQx0Ig+/za0K7SRgX6Ykmmx2H1CWa5NI5XQWFCiG1zrxuSW3g8wdDWP2uTp7GM=
X-Gm-Gg: AYBFou0UGf5rtJAp0u7uT9KaMQiqT8tQws6F5JHMnDnwB/wS9GCAUvPiw18fKHLA8Dh
	3aakvvug2JSfOWDHK0jJkHXbP1L4mbD5aXDya8fzE/SLMnFo9elE3pw4LDMfg9BqY1LK5z2f8Lp
	sokkYMlMEqUB0vJ8FjTtgZQxQNQDWQYnmw8fe6BAIPlXdwdp4wfS4HN9vko/p9peNmqyeGVk1ir
	wEWmul5OwcDlO3wnL/r3ulamV4rX1OnUFHe/SCHeyEzNMaZ1l2QRigDv3mJuFeYz4DpgO0EprFC
	nEyBAMDnmGxW5/gJTrsprXILD28EdrlWg7iwBgjOXJNL3or7lQe9tU0uXg9Z2RVrrZKryS0EptC
	Go3dSNJITb6uV9bchr5OQt1QWAxsN5JuPmL/36FgHlYGlJ7D5bpBbdCSEhEkbwvg56tary6JKM7
	dI8LpI5cta/AEykgclGFJpacyLI6ch4WxvdeSXJqgmnkmGB3ZRZck+bo4Y3r4Xt8zxMCW7xti/u
	CR5XVGl+g+0fUXKrqWiBB0rDVCKNwJ6E1TJ/CGpNDocfII1DIThKNXzb8Fnu22EonsODKA/cDib
	KEbH49zjBOhz+yvwtKj+K+IaQ3OBOHsu4Ut/NE+LWA==
X-Received: by 2002:a05:6000:29d3:b0:48e:6a23:4a09 with SMTP id ffacd0b85a97d-49c731641bamr1485962f8f.54.1794531340462;
        Thu, 12 Nov 2026 16:55:40 -0800 (PST)
Received: from [192.168.0.167] ([109.78.26.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8e794sm2106178f8f.59.2026.11.12.16.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 16:55:39 -0800 (PST)
Message-ID: <c5444a64-ad14-403e-8453-0bb0a16dcfa8@linaro.org>
Date: Fri, 13 Nov 2026 00:55:37 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] media: qcom: iris: Wait for threaded IRQ
 completion during power-off
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hungyu Lin <dennylin0707@gmail.com>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>, Birk Skyum <birk.skyum@pm.me>
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
 <20261111-fix-disable-irq-safely-v2-2-8e13f68c2ef9@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261111-fix-disable-irq-safely-v2-2-8e13f68c2ef9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2026 09:05, Vishnu Reddy wrote:
> +void iris_acquire_core_lock(struct iris_core *core)
> +{
> +	mutex_lock(&core->lock);
> +
> +	while (READ_ONCE(core->irq_disabling)) {
> +		mutex_unlock(&core->lock);
> +		wait_event(core->irq_disable_waitqueue, !READ_ONCE(core->irq_disabling));
> +		mutex_lock(&core->lock);
> +	}
> +}
> +

> +static void iris_vpu_disable_irq(struct iris_core *core)
> +{
> +	WRITE_ONCE(core->irq_disabling, true);
> +	mutex_unlock(&core->lock);
> +	disable_irq(core->irq);
> +	mutex_lock(&core->lock);
> +	WRITE_ONCE(core->irq_disabling, false);
> +	wake_up_all(&core->irq_disable_waitqueue);
> +}
> +

Ouch, this is some mad amount of jumping through hoops.

As General Pierre François Joseph Bosquet said of the Charge of the 
Light Brigade in the Crimean war "C’est magnifique, mais ce n’est pas la 
guerre" - It is magnificent, but it is not war.

Why do we have to hold core->lock over iris_vpu_power_off() at all ?

- What is the data-structure or
- Logical state (the state variable I suspect)
- Or guarantee of atomicity

We are providing holding that lock ?

These are pretty much rhetorical questions - the above locking scheme 
can't be right. It implies we are doing something wrong and not really 
fixing that wrong thing.

Holding the lock across power_off() seems to be that wrong thing.

disable_irq_nosync() seems to be a correct fix - so if our locking is so 
muddled we have to go to the above - there better be a fully reasoned 
and unavoidable reason why.

Perhaps I'm being overly reductive here but - why not "just" refactor 
the code so that the power-off comes after the piece held in the lock ?

i.e. push that into a worker and then do a synchronous wait on the worker ?

The chatbot told me I was wrong about the worker because "it would 
deadlock" and I can't be bothered burning the tokens to tell it "I 
didn't mean hold the lock in the worker"

It did make the point that it thinks the only thing being protected by 
the lock is

intr_status = readl(core->reg_base + WRAPPER_INTR_STATUS);
...
writel(CLEAR_XTENSA2HOST_INTR, core->reg_base + CPU_CS_A2HSOFTINTCLR);

Which venus does like this:

static irqreturn_t venus_isr(struct venus_core *core)       /* 
hfi_venus.c */
{
	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
	...
	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
	return IRQ_WAKE_THREAD;
}

i.e. power off in the IRQ.

Perhaps even simpler - just do the power-off directly outside of the 
locked section... once the IRQ is quiescent ?

Either way I don't think we have a good reason to hold this lock and can 
certainly find a way not to hold it - assuming the only thing we care 
about is kicking that register - do it in the IRQ why not else do a 
worker with a rendezvous or even more straight forward.

void iris_core_deinit(struct iris_core *core)
{
	bool power_off = false;
	int ret;

	ret = pm_runtime_resume_and_get(core->dev);

	mutex_lock(&core->lock);
	if (core->state != IRIS_CORE_DEINIT) {
		iris_fw_unload(core);
		power_off = !ret;
		iris_hfi_queues_deinit(core);
		core->state = IRIS_CORE_DEINIT;
	}
	mutex_unlock(&core->lock);

	if (power_off)
		iris_vpu_power_off(core); <- this ?

	if (!ret)
		pm_runtime_put_sync(core->dev);
}

---
bod
