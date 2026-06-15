Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23553BBFD9
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507784; cv=none; b=uZQGoCz9aJNY2J8A0VfvlxMRqThEjYZF6WNoNjf7LbU2P6sabYCZ1k8+KurLserqy1hRxylTh4ZAm+BpQWT/Lr+UDV3CRMWGeG0uL10ehLaGO1l6rpUMfZCJt7U20j/17sSixxjIObNiWD1k/qmkjkNP7y2BmAqgUawvUAJhjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507784; c=relaxed/simple;
	bh=pMkVa6/D2V5ktOGrf4lKmOuLSpOlfMitckdfGHfEAXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDofxGiDYFfad4HhvjOHEIhqB6nJSMsyssNjoOf0BQDMns8whw40anxFDU/NsbW5svK+o3WbpTIJoVNubUN1yYaPubrqOeWgtwhuQKqxsHXNdSqFkpLtih0zuC/m4NjsGxE308vxjKrL/QlZF52tlp0hraTq9+n7xZNIlmoY0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWjVpC3W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWjVpC3W"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b64c8311so30476455e9.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507781; x=1782112581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMkVa6/D2V5ktOGrf4lKmOuLSpOlfMitckdfGHfEAXs=;
        b=kWjVpC3W3XixNCMfI+ottBHYx6Ct4UnxBrtFmkXzHihZDGxSiOVjUi37TgIov8U8f8
         3pFalL8D8sVh89laF/HDnASgaHJYp2pjES40HFA3b6lHOIOZbYQYvtYDyvKYtOcP9bqv
         34dQui5m3cvmQbm00l4M9jdN+frC2xuh+dfi8a/ucI4tLkTmOu4hGewJdgJYy2nFguC+
         /uoeWHLWbleNxsGAoVnig0g8XqWOcieJJ+aX4ZkwuZ1gQ01KiAG+JrWs1ggpTrGPt7CM
         YgIRgKdzw0+mRZg8GQD8pQpm6lk6rOElApV72jSM63/cvBQq+2LFrcwo0ERU2ioV7iS+
         Mtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507781; x=1782112581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMkVa6/D2V5ktOGrf4lKmOuLSpOlfMitckdfGHfEAXs=;
        b=s+ORn6d9HGZxCzwEHWAmPa0Z75Nm9TkjeIcAXoQWt/r1uAj6Enm5LU4sCbwQ5eSkYE
         tIfrTunhzvXOUpnXGM7tAXwgZ2fyf7EjlrdTMvsTPL3waAYi3cRtgG4dvLpBIxHyzkpN
         oiLA2Oyl9H4FVy0T1NCq6e5Mvjik1SigEQqvWWI+iwW8zA/oBAvfU5YBowpF3iIoZzT2
         D1ootH260bIif10n/7kOTXjZkHQ5vr0RKBq7r+Vf/j7oEPOTv08QWOhJ6orrZa35xlAH
         9q5whu/zEjXpOmSHEiLC65j7o1SaQ++HqlTN0So3vxIQzoBXmLAwMSVVEXRnFOFNDmUh
         9VNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9u9UVuxcgTCt5AN/YSmh4Mk4ipw6PuDETqctiRwZNjpy7vubItVsXMulJShurONhyaFRrBRMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+KEJFpaFLDB2895tOMN46yEj8zv+wazeszKP5KOGD3AZyerf
	No0CVBuTWXjGlj3dLSt3LOM4bXrLGSrtESdm1iSnPPRXUBUAYQCbukGP
X-Gm-Gg: Acq92OF0D6k52Cr/A2AK/4SO+e7Bj4SsTjZOTZ/3VDd9IMKQ2Ru6p8P5vpjbObUo3p3
	92bnJ/1p2HK8PhbjGUfORAoi9+Y0YM7Uaks7LTeDy06RNdgo4h9KQvHSWKLFNfymDmeB773Y3N9
	4+y9+qrLePCUO4Cjxu0DVG5rS62gSkFghpUN8+ZnH2xS5hRny58DgTzUoxb/PvXo6HK3GjsbkRb
	xPyGeaOvw+xpgX4PB+c3eh7VLyGzKdkUy3Oh1zNstVUMCWBgXgGZHTKyXSXckVGbOSqV9qZcEzx
	RyiBFaXrPaC7hIDrRZ+xtiLQZIbeV2A/zomnYynpsqF4bs+Ard/1+AdFWljPCnh8O6L2+FWYwau
	RV/OLC1MOCFkc2P8Z9PbE1vrqhsMjFOVSCqU9MC9/5ycM+z+tl4eBZEaHJlN5qcHHoEky7xsZKn
	sDxvMaLUA2ch1WasHXo5+9SSNqaICrPX2la7wEVMo7dj+/vxcOSlQQJpEWU0tK2BNTDhGHyyRTV
	wLVSdnawfWq4cyFg4+ZI2jbfBrEYdlVtHrd
X-Received: by 2002:a05:600d:8653:20b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-490ec4a2984mr118495565e9.3.1781507780666;
        Mon, 15 Jun 2026 00:16:20 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b21dsm219645595e9.6.2026.06.15.00.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:16:20 -0700 (PDT)
Message-ID: <e9696d4d-7cd0-4d7f-af87-2b4631549475@gmail.com>
Date: Mon, 15 Jun 2026 09:16:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
 <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
 <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Huacai,

On 15.06.26 09:09, Huacai Chen wrote:
> On Mon, Jun 15, 2026 at 3:00 PM Jonas Jelonek <jelonek.jonas@gmail.com> wrote:
>> Hi Huacai,
>>
>> sorry for the reply delay.
>>
>> On 10.06.26 08:05, Huacai Chen wrote:
>>> [...]
>>> In theory LoongArch has the same problem, but I cannot reproduce,
>>> should I enable PREEMPT_RT? Or there are some special configurations?
>> Sadly I cannot help with that. For MIPS, this seems to be the default
>> behavior.
> This patch fixes 91840be8f710, and 91840be8f710 adds synchronize_rcu()
> in irq_work_sync(). Your problem is caused by this synchronize_rcu(),
> right?

Yes it is.

> However, synchronize_rcu() only gets called in the
> IS_ENABLED(CONFIG_PREEMPT_RT) case, so I think your configuration
> needs PREEMPT_RT, right?
>
> You said this is the default behavior, but PREEMPT_RT is not enabled by default.

The condition where this is added has two parts, see [1]. While PREEMPT_RT
isn't active for MIPS, arch_irq_work_has_interrupt gives false for MIPS (since
there is no implementation and it falls back to the generic one). This then
also calls synchronize_rcu.

> Huacai
>

Best,
Jonas

[1] https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/irq_work.c#L291-L302
