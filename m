Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481068;
	b=gMZljx5SBTYDjzuU36UjhJwIqBlvAgpuWcicMl7Z9ORMiRwHzcuay/mD3a8yof9Tjj3x
	 grXE5RMoiLlvYCnp2KRFTX+ObMSWZe0FdwjWPKZ3l+6CjZYBr1wZDdNTAsKLqja50uK0A
	 xUnqmbsTu9ErlHZKjIc6RwpN3g8g1jT3dZlRIDCJgVjru/4XcP4rrYD6UvT83ClHrjAn6
	 h/EAxSj+OyMdhIeAgB7WhiWX2U0o/ze4EDHDaj9NCzRTDmIym4ZI+W9prT7ZZ/A7ChRNP
	 FEWf9Lfdms0OtbL7Y3cliKHiJNGvnibWD7fHyFbau3SQVPmNa+xgVZUWAwgX1wf4kYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0MScgZgXeIWmjS6hoGqe6kXsg/e8o8ts/nbOkXEpNcs=;
	b=Lvo39yVZfJy9m+jm8eEgRtruQygYurt8SNEtyf0/e9TvbrDd318gA4DIXCKZtB+C4x1+
	 FsFNEpkq/EG6I2VHgubPc6kLsi7EJeyha82MTQ0EzUF3Eh0S+rS7Lf+vJ+5JvOeMzmkx3
	 GPfnCl2OMG/eNYazOB+LPfASTe6vLLUc6Ob/+DhFvw1DqfuAfLijkkyBFm0QzaEkISlpW
	 gTm4BJ78ERz/nslTGkBoeIAEW19Yn7HefKq/65oJ7V7+o5VGFpPtkXewmxUXV6bzUZWiS
	 W9i3Gf+6fz7R82dYl+HP07025h3ggj6+eJqPgqopHQrcExbGDBMyKEje5e19+efA9Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9RyjsI5;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463C606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6463C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f9RyjsI5
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso1488196b3a.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795481068; x=1796085868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MScgZgXeIWmjS6hoGqe6kXsg/e8o8ts/nbOkXEpNcs=;
        b=f9RyjsI5BlEiP+ogUL82p4Zw2/oIInh0yzWd4zl3Nzz9yX3AjS9uJvGArF4X9sQ1Dv
         t/Zemesbv+oPAotN3AiNR+cAc7SZK8XyhoPrOalw3XPafnkPzqPtKf5QspbIijk7jBmK
         KSH1oO/ImNUem/yw+9s/gCVmNdTGMgBZyQ3iiAT/NQ2+mtXquoI8i1MB7dwOxMRWNplg
         lPERUKetm1oqsjEDslCK7WOVDu8BYirk3nNZ2THvGNwQjlT682gTTARQiMeOqypTVAau
         iVQaUzAUALq81iVGZMOOFhFCfL+IjFP8WnE+MMTi7nG9ANAR3Y94b9siGYjaiapXTBLv
         8+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481068; x=1796085868;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MScgZgXeIWmjS6hoGqe6kXsg/e8o8ts/nbOkXEpNcs=;
        b=XSi++eL+s/NBHPW5tw/oGxmqkPjF6JYbNVBckQ5VmpS6xjZ1NAPzqEpgAVXsyRAA3R
         FMRI1J6oe9Aua1kcHwpyZWjzY1/WMIeODuei2lnV8cJ6dkO9a3uh23mHQej3tA7WCERj
         NNojw/OvyeuHd7bj1bHzZ0L7Wq/CQ538loxYTJFKp3oAN5mWHxGwGQgZTK7eJSMzpn+s
         80whMR2KZ/vuXyAFvEim7NyxWrfSzCnq2+u/fQzZ8rlCGQBZEsMuLVi4rgr/oflf+jik
         MHjjxjQZWhvd2A7ROe9jLad/97LrFLIL9x6bSRW6ZyxiaOGXo5ciipA81nI4zNeKkDIp
         VnEw==
X-Forwarded-Encrypted: i=1; AL+hErEdnPekyeRKwQJB0xihmd7TN8vh5h4OzT6ujBRukTAQfbnLzHfCLg0uywpkYyfhaWNK5q2lInw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ki8beh4rNoffZsDeCxjyrraJMk8fT+Cih7/Nm5bOkuqL1ilZC
	NlWHvg7kBkfyHsAbMOxvYA94mNzwGpPkH/kPivsgmADsLXk1MT3OA4w/
X-Gm-Gg: AZFdTZcLG/JJC5yW4nXJvrxr/I/1H4EHY7T9h/jhMloIvY/pd4vX+6ViyyFBcNEmtId
	kIH+DxirfT6XoN7UjM/Q3YT5/GnlZksAW/LlsySUTlfQCLGDXii+CyVV9QMlHwvXSVH4DmdFPmF
	FxgrkUiPjpSVUBxGMAHigIJ4Pdc90GCE61rTmGiwUQP9QaTEfYjTfZtpcApq5dmlQwPT6Do/uyL
	HqcfYN+xmOHgylNHVkMCyrLJrHaEpcUUlnUA55W33c4XRCBXvqFlFqwGs6DeGbBWlU2/vGiYk7T
	JTMcYHpw4tO/5wAbsbKJhfzIbLRwV2GOY2nYc5zJ+xSj0XrLKiBTXv6DdffNBa4rmUvm3kPF44e
	8M5eCxYmJhTgwHO8hWUKIkwqrRRoMkXd79vOo/WNbrLd6MxlAPyubkp/aHmE7c3nWaOdSAWyEp1
	nSi1M4JlzEbseMTJwzQEWc1RC6Y6nCaiVy8w1esofX47sHRKu/6mPnLd31J6f/TzlIOJf0COYiG
	OEKi4NsGGIcb7WHhg+C1JxsmQcAuef4W/3I5EAFVfvPRq2fSTAqLcB+NB5OH+mbmCQOEkn0FboP
	Vi6mxqksuynQLxdtVU75e5/H+NFcqhuHaOsIDC76ovSw32oflF0ty0vOCtEPk/6M
X-Received: by 2002:a05:6300:48:b0:3dd:a195:dd5d with SMTP id adf61e73a8af0-4014ed36da8mr13462544637.63.1795481067613;
        Mon, 23 Nov 2026 16:44:27 -0800 (PST)
Received: from ?IPV6:2601:600:a482:7d70::b4f9? ([2601:600:a482:7d70::b4f9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm855550a12.26.2026.11.23.16.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:44:27 -0800 (PST)
Message-ID: <e4a05b89-f9ca-4082-a203-07f6a00f8913@gmail.com>
Date: Mon, 23 Nov 2026 16:44:26 -0800
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
Subject: Re: [PATCH net v2 2/2] net: wwan: iosm: fix S3 resume by re-binding
 the driver around it
Content-Language: en-US
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, m.chetan.kumar@linux.intel.com,
 linux-kernel@vger.kernel.org, mail@maciej.szmigiero.name,
 nihaal@cse.iitm.ac.in, stable@vger.kernel.org
References: <20261119042714.505405-2-davidlwesten@gmail.com>
 <179541107082.3135.11504382259893948340@kernel.org>
From: David Westen <davidlwesten@gmail.com>
Autocrypt: addr=davidlwesten@gmail.com; keydata=
 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
In-Reply-To: <179541107082.3135.11504382259893948340@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 9:17 PM, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Will this apply to the stable trees that this Fixes: tag selects?
>
> Commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by re-binding the
> driver around it") added pm_notify(), pm_notifier and pci_registered. That
> commit has no Fixes: or Cc: stable tag. A tree that has 1f52d7b62285 but
> not 0b6f6593aa8c has no pm_notify() at all.
>
> Could the prerequisite be named, for example with
> "Cc: stable@vger.kernel.org # depends on 0b6f6593aa8c"?

Yes, v3 will name it in the stable tag.

> [Severity: High]
> Can this expose a use-after-free of ipc_imem->ipc_task on every S3
> suspend?
>
> [...]
>
> The unbind and hibernation paths already use this ordering. This patch
> puts it on the S3 path while the modem is running and has just been told
> to go to UNINIT. Could the MSIs be quiesced or freed before
> ipc_imem_cleanup() tears down the tasklet?

Yes. v3 will free the MSIs before ipc_imem_cleanup() tears down the
tasklet. The teardown doesn't need them: ipc_imem_handle_irq() already
ignores MSIs once the phase is IPC_P_OFF_REQ.

> [Severity: Medium]
> Does the modem now enter system sleep in D0 with its firmware still
> running? This applies when the card keeps power in S3, or when freeze or
> standby is entered while mem_sleep is deep.
>
> [...]
>
> Could this raise sleep power, or keep the platform out of S0ix during an
> explicit s2idle? The changelog lists lost data sessions for these cases,
> but it doesn't mention this.

Yes. With the driver unbound, the modem gets no sleep request and the
PCI core leaves it in D0. That's the cost of re-binding the driver
around the suspend. v3 will mention it in the changelog.

> [Severity: Low]
> Can this register the driver again in the middle of a uswsusp
> hibernation?
>
> [...]
>
> The hibernation image would then be created with iosm bound. The later
> PM_POST_HIBERNATION from snapshot_release() does nothing, so the unbind
> added by 0b6f6593aa8c is lost. Before this patch PM_POST_SUSPEND was
> ignored, so this couldn't happen.

Right, both paths share pci_registered. v3 will remember which
transition unbound the driver and only bind it again after that one.

Thanks,
David

pw-bot: cr
