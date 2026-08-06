Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1353CB544
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042416; cv=none; b=J/MUC+CrOrI1Oxh9YsF6T06U6Q5OhZiH0JkYvH5TwLo01cNEjR8iNl7/zfxGHiwdfiSS+4C1uUxBY0PXAPHu5pelohhMDHslnkHBtfSSJbMl8pPrMhX1FUoa2f0IZ0Cx6PnoSba1a+FJb9sxjw+ZVndOXpmyPLKYakVxr4GjOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042416; c=relaxed/simple;
	bh=XvRGBejZkwe+z3UPXhAL5586MWNN0X3OsM+qNWmX2NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHSiqFGeVB7tKEC6lh3+P+MXjV4mtN1ti0rUykQf+p3mK/PBA9hYbatyFf3Jr0yjRVWyNUQYoWdofI6BOvqWZw93cBnIyA0OUMXApkCB4AlHP5nYuepvc6sHXnLSAhuJ/HEXyHfNdpUjVmM4fvBJ8XlfFPXD3Lz9Sgrsp/QxTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LcRFkv2n; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LcRFkv2n"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbe3fed2f58so2214505a12.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786042412; x=1786647212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZnnN9xL/IVhnObQ21eK79r561Sek84n29UHIzEFuiSg=;
        b=LcRFkv2nSgX8Eclm80kfCz2lXjDmJx7b3TtCoBj/t+HSR5UuR7DL+RsX2cWxDYaT5Q
         sWESgrj/NtDIVNCER8AAyL0IIUtjU8EpC2aAKJTdHo5/nF0FTiiwwyzjeDKPS4vGbY/x
         +ps1ZitlpYJLiHI9uT3yUejv2LL/Xc0wV7cpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042412; x=1786647212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnnN9xL/IVhnObQ21eK79r561Sek84n29UHIzEFuiSg=;
        b=PKzNJZ8XNQczerZwIlO3CYGlZg2t84FhlkMNpWGtiRzehHAQqZ75ALEXGlazWHEzm0
         8fz5ViDKJWgbdK/pTLoT37kCmMkYSMwfgP2KXtg6JdYUX9vd//N2JBqFoG6X6SeuEglt
         hukBOiLZIgRdy8f8xK4UF5z7Hh6AJv7y4pEXUrDI1Z4IoKIs7EK6wRnTWmdQ3Rbibnwj
         BMN5DaAgyUFQQ78QU/nUHeyHFaVkQhIfIxyr8IU3W5/sdvsal5U9B4UhlMmoZgpXOKQw
         VfCWDCf2/0e8LaqGI0VzPXBbRCu9GC/xiAeWlsqVjqdyzca94kvlrlACuuRM3dTG+742
         ugyA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnngra2bW867noBOOAhOvW4WhD/A/9ZmYomS4MqO0F4ohcKdEe+UEOR+fLKVJoJw7/1iZ3cIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsySJe720O3g3tMzZm1QNXz6thCW9HIeSWh2KHSzYNQf3mRSv
	hj1G5kIeJNCj4sUwE6Ac9dizdiqPycMULqYSVvsNRQiGx3qrTwe4cxsepSYb+we7/w==
X-Gm-Gg: AR+sD10cUVXJZId2WeYsc7liyfitg8aZdBDQYeQL5TH4kjfgUSrAz9jXGDTWB04SgIL
	ejnzyoHAyb85jcGYuoWgU/WxG4LUUuHkYdunLNm4CUnGAwaB71wO94fcr0CJQVGXsM3Fosl7hNP
	UBZDixmhlLF4BUt4xvtvSZrhGg/VS1uZ4hWl+Jo8eRCGH6JxzpVK8296FFQumh7bV0OAWBsxyyo
	zICX3jygsLjGv+Ame/ZXeT7sWf6OzaWRQKRHgfUtO2wnHRavrl5VuIPEXk00V1RygcM7OZmhe1V
	N7HLYzApiV+d+2ZVQ93RnT+IrGQDJnBaVZ1I70LZaoWm+F+5Uhml5FY/CY8FpOx4+Agy9BMIEgX
	/jepuSanK/dGqTLhobuZy7MiKIJHZtENtCzLy+gNHhUBA8ZzyVKbVTqA/spTipEtzekmqCLot+H
	uhnfAzLqcvGqomxJ8FusI/oFliDv83/5yh0WjTsXS+OX9ij+I+F5sQ3GK2Ipf+ee+4JLKkmg==
X-Received: by 2002:a05:6a21:a38c:b0:3bf:a681:a262 with SMTP id adf61e73a8af0-3cb8603af5dmr20789320637.38.1786042411898;
        Thu, 06 Aug 2026 11:53:31 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586401507sm30516587eec.9.2026.08.06.11.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:53:31 -0700 (PDT)
Message-ID: <95115007-a659-41ff-a516-5c68a1e38d36@mojatatu.com>
Date: Thu, 6 Aug 2026 15:53:27 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/sched: act_gact, act_police: range check the
 fallback control action
To: Hyunjung Ko <hj351016@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260806101252.809593-1-hj351016@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260806101252.809593-1-hj351016@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 07:12, Hyunjung Ko wrote:
> tcf_action_check_ctrlact() range checks the primary control action:
> 
> 	if (!opcode)
> 		ret = action > TC_ACT_VALUE_MAX ? -EINVAL : 0;
> 
> TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
> cannot be set that way. But act_gact and act_police each carry a second,
> independent control action supplied by user space that never reaches that
> helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
> TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
> verbatim from the action.
> 
> In particular user space can store TC_ACT_CONSUMED, which is
> TC_ACT_VALUE_MAX + 1 and is deliberately not part of the UAPI value
> range. That verdict tells every caller the action took ownership of the
> skb, so nobody frees it: sch_handle_ingress(), sch_handle_egress() and
> tcf_qevent_handle() all deliberately skip the free for it. The result is
> one leaked sk_buff plus its data buffer per packet traversing the filter,
> unbounded, for all traffic on the chain including kernel-generated
> packets.
> 
> Both are trivially deterministic. act_gact clamps tcfg_pval to >= 1, so
> with pval = 1 gact_determ() returns the fallback for every packet.
> act_police has no mandatory rate, so rate = 0 leaves tcfp_mtu = ~0 and
> tcf_police_mtu_check() always passes.
> 
> TC_ACT_CONSUMED was added by commit 720f22fed81b ("net: sched: refactor
> reinsert action"), after both goto-chain guards were written:
> commit 9469f375ab09 ("net/sched: act_gact: disallow 'goto chain' on
> fallback control action") and
> commit c08f5ed5d625 ("net/sched: act_police: disallow 'goto chain' on
> fallback control action"). Neither guard was widened when the new
> verdict appeared.
> 
> Factor the existing range test out of tcf_action_check_ctrlact() as
> tcf_action_valid() and apply it to both fallbacks. The helper cannot call
> tcf_action_check_ctrlact() directly because that also allocates a
> goto_chain, which is exactly what these two sites must not do.
> 
> Reproduced on v7.2-rc6: kmemleak reports one leaked 232-byte
> skbuff_head_cache object plus its 704-byte data buffer per packet. With
> this patch both configurations are rejected with -EINVAL and kmemleak
> reports none.
> 
> Fixes: 720f22fed81b ("net: sched: refactor reinsert action")
> Cc: stable@vger.kernel.org # v5.3+
> Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Tested-by: Victor Nogueira <victor@mojatatu.com>
