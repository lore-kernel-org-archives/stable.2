Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F82EC0A7
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643533; cv=none; b=rzSwLMNWosgrc2n73rnEXy8OhWI3O5IISFxWFyUTSVT/ZRO86rc/AtozeNMyOs1k+I2kME7EqEqi5vZclEwViQCbue2v+tZS2uq3t/KXsJ+SB7AdmblO95LuxPcyqY7MSCaZcSFt3jgKLVQddAqGZNWvJrII7qXz0iUHErcv00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643533; c=relaxed/simple;
	bh=LTLQc7ME7J7eUP93Wq//rFEEyGgeOk62Srx02OHipjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYt2UrSTslwtoKe4TqrEpqI6896NS7zPvlbJNm5/Asa/kAL8wd5EJYb1MwdYkoe2FaWsNUdfQ9mpuhkMa1JkqpO8PFid0f6L5WmP8aUyDMesu6VGbhJrpvy5W8fg3QtC2YXWKSXZwdcLDTBs5IME07PZqNkSgXuFq3ZDz/UOyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps89oNVR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps89oNVR"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460166910e6so835815f8f.2
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643531; x=1781248331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayZZoFINc62/YbxwsJhIjKy4nCpiHkUbwPnuNcQomCM=;
        b=Ps89oNVRaZn5rmNq6doJt7zy/0DrYF9JhbwicNE+Arvwr/QS1dll52VQdATXxAl48g
         vJa3dIJuLWcz9Z+1UqLWbuec5xfR8G9UTJEdP/g0E0+bRhq5wJYc4O0EZ25CO74oXFrA
         ZJGMYMQkh99t3sgdCc5krpCpSVmBI1xsnLaxJz4dRrn4OaeNwBR2BICfsCa44Cw28Rfp
         jhFVXxK2hx9Pzn1H27o80FXr/LOoeOSMlb1ClJBWz0GW6yP07MqpftLhWzl7rapOl4lk
         zlPP0XJR+u8Dc48d3/jTu+GnODEcYz6kcZyP+INTfahdmu7YAf7gu5uqx0Z8SLIcNscR
         pB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643531; x=1781248331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayZZoFINc62/YbxwsJhIjKy4nCpiHkUbwPnuNcQomCM=;
        b=Njr/DHKLIsfac04rNF4/PmV2tWHNO/hmCtneeDbV0aNaaYKYNcsvUNsDEm8kR6pxdV
         F5cipDyisoBWcmbaKUCzcNscJfXrEXqS1U43fyisUF2+UnKRiIi+nLvoBhWV0LZbiVam
         OFT9KXQMPnu7hBKYj6KVHV0a7PtcKILt00aB4NY5++qlr7umNWxeaHpylmCDBD58Ls+K
         GLwWNj+W/HX24bK7wiQ2n7Mn8ldhV/YGvcKZtXPWf12or4cfkq0xvaQTj+loWV6morl7
         WfksdHK5nwjmpbVOlNCrkRws+tmvk8JH8KpVgkWmlYoloWb0N4q8CTig7aghy8Mq4+cw
         CA/A==
X-Forwarded-Encrypted: i=1; AFNElJ8uRJaT8ljrTVuYxffk+RH4tTuIhDoZZkIVd56HL0jv5i6kbuoiYbsloUuIqusYLvKkaQThKN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeyp/gIjXFFpebibe/tWd1gDSMf4pcAeFz+fbk48fO4J05jlb
	pdoAxKSeOAJwvgk9v7KyHpx0Jsrq8uvx86WWfLmzg5HzRQEyG5zj8Hbp
X-Gm-Gg: Acq92OFxpQavOQnvLtu3pl/GAA77oQsqWR09uXQ2fGJAmlCeF6LBKSK7pf7G09UFSA2
	PZM/oqFX2oeLhb+c693Qatln7rxMKlZwLdvfE6pbm7bywAPbnV6NdxnmA9FjgW4kTWQ7il9YY7O
	yfoxbw8l87VTcsEQCippgXeRC8vd8331uCGpDEnAXeFh0t1okY3uqWcB96Ohvc9d305NhXwNlSg
	VVdL3kElko/qKDgcDEVqHAEsQP0ndMQnEoWG4bpV/juDZ1UFYbFtcFwARxMmP+R0jUN4r4nxOVx
	Zb/gwHda/i1i4+ONaRiwQw9uzrO296xz5/WR6FDwJyOPtW5RAtEu6f7TI2EJuvE42ObGLDjevIp
	H6IvFsgc0pgyc8gO00beZb/LS+JEWJ3UBptX2EacVGvJTXhfv89l1sQilEHiaDS/hjgHRuW7DRi
	dGoXrfPWASRMpZFYOtWB3CjGWRk7eCfp4rXJ1TPPOzSUdETW9z4n+bY33VYzxOAeWJyswsl2peP
	yCRm3gvSUfx6V4NMxPif1vS3mK4RXuGkSm8bB3+21TzSU4=
X-Received: by 2002:a5d:4e09:0:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-460304fe066mr2960398f8f.21.1780643530812;
        Fri, 05 Jun 2026 00:12:10 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f133:a901:840b:2bf2:919c:cec5? ([2001:9e8:f133:a901:840b:2bf2:919c:cec5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm22213455f8f.15.2026.06.05.00.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 00:12:10 -0700 (PDT)
Message-ID: <02b1e77e-5b7e-41cb-95b6-731ed00d9e74@gmail.com>
Date: Fri, 5 Jun 2026 09:12:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
 <20260605064250.q0aRKkon@linutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260605064250.q0aRKkon@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

I'm not an expert in this area so please correct me if some claim or
explanation is wrong.

On 05.06.26 08:42, Sebastian Andrzej Siewior wrote:
> On 2026-06-04 18:24:07 [+0000], Jonas Jelonek wrote:
> …
>> This issue popped up during kernel bump downstream in OpenWrt from
>> 6.18.33 to 6.18.34, since the suspected change has been backported to
>> 6.18 stable branch [1].
> I would avoid the link and simply write after the backport of the patch
> or so.

Fine with that, I can adjust that in a v2.

>> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
>> generic CPU-hotplug offline path (and arm64's stop handling), so RCU stops
>> waiting on the parked CPUs and grace periods can still complete.
> This is part of cpuhp_report_idle_dead(). Is it now invoked twice? Or is
> something else missing/ different? 

Those seem to be two different paths. To be honest I'm not confident
under which circumstances which of those paths is used to take down
a CPU. In my case, issuing a reboot command reaches smp_send_stop()
where the issue explained in the patch message then happens.

> Sebastian

Best,
Jonas
