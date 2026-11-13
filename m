Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533601;
	b=rX8WPFBnLwh6r3jeZ/ES8q1LUDeOuHMtATAR50FhTNoEmE0n3qIZeIVuElTtbnzUeXpy
	 OOjZU0ZsTR/QJRT+BqtE0/eCOj6f0PEKGSD8KJigeluMKPicjXWe2dSsg12MS/oHJZwU3
	 0T57h4EQTaP7zgxolSxYPI4kaLBcmEyVwsvQpYclsihp/y8PskRtbWcPkftW/mNtVJQ90
	 ip37WtVbdDxxmORLwG9D3PMbJTOxW7EdSR6qxMrVsqG0UTCs5M/ZN5KwBaOUT4bc5zG9Q
	 gJILv5GlfJDz9v22S1Vf/jZVbz7roDz9ePiNqCwSdD2GFlR7CKK/CBBeOepTlXjUtgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533601;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NiFkBtdlf69jAlk3vtnsU3JfD+qZUSIIy9+AOL4jaRM=;
	b=0JQkC6yFvtd5nbi0BhTMb7XzoRL5FZoLmKKADImGU9oVZwTlo8KoMEsbzdjK1N9iQ3CX
	 A+DsZP6snXjEZbBXKl7jc+VL8+geP99O3VJP1k++IYbpgaE1jZvhQz4nqNE0QIrNe91PI
	 ui4FjEgCM/PSM8fFSLWC+SJ7D4r46+/lff41RsUyFiqQJ1te9+AnzGe0p3gTwaGdTby1z
	 Mmi+3sG5fmMH69McpinenDlHeq/MYTYC+iPa9fuae5V1z5IcZBmCrBfzPLmQAOPFUoqA7
	 bDaT4Bma2B4apJomGEF6ezEHmlbpfVrud+sjm5R0AfusYLXsiTYv8vamRZ8HnEFnTQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoO6wBop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B8606A31C;
	Fri, 13 Nov 2026 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoO6wBop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291EE1F000C4;
	Fri, 13 Nov 2026 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533601;
	bh=NiFkBtdlf69jAlk3vtnsU3JfD+qZUSIIy9+AOL4jaRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AoO6wBop+R1gHyC/pR2/jxKK87XCtn4sUAsc6Dt/0gcDiSlcIKFagNKPlgxXICj4c
	 nZpgND/pRq0m9poYXVs+B88/okopMD8/ZcVEveWW5CV9IrURqFl2htcrYDKDY5gKnf
	 8yJj+KrKBwWQAeySkf5HlR5v4gOrnTuy3713Vj8ZFlhAr/aPKBJtDBMguskbC1ZnkS
	 lO9ctZHaJzTZS1c49Eu6uzWI0mucIVHmn2lCPdxPDpf4aegj8SAucCpAEGCvjv3kjo
	 o006mXTvFhHhJUXMTDmm3uEL9/Kz6SJ81d/LamEs7FCdNKQVXQ6kgi/UfKUQKjWsXN
	 8K2Ej1uIOcLuw==
Message-ID: <713418c4-e84f-441f-a5cd-438ee7572300@kernel.org>
Date: Fri, 13 Nov 2026 01:33:16 +0000
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
Subject: Re: [PATCH v2 3/3] media: qcom: iris: Fix IRQ disable depth imbalance
 on watchdog interrupt
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hungyu Lin <dennylin0707@gmail.com>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
 <oczdbf5-XlKLK_XWRsYOoZxRTcl-VoOjdI2mGoUNY0r9wGgG2fWWgq2eXT3xLL_DL-m9xepMPjfinxdwASiagA==@protonmail.internalid>
 <20261111-fix-disable-irq-safely-v2-3-8e13f68c2ef9@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261111-fix-disable-irq-safely-v2-3-8e13f68c2ef9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2026 09:05, Vishnu Reddy wrote:
> iris_hfi_isr() disables the IRQ for every interrupt and the threaded
> handler enables it again

This reads like a statement of a bug to me.

> except for a watchdog interrupt, which is left
> masked until the firmware is reset. 

Which then gets worse.

iris_vpu_power_off() decides whether
> to add its own disable from core->intr_status, but that is only updated
> by the threaded handler. If a watchdog interrupt is still pending when
> power-off checks it, power-off adds a disable and the handler then skips
> its enable, leaving the depth one higher than the single enable_irq() in
> iris_vpu_power_on() can undo. The IRQ then stays disabled after the
> reset and the firmware can no longer be reached.

Why don't we just do the _simple_ thing and enable the watchdog @ 
power-on and disable it @ power-off ? Let's at least investigate that.

If its infeasible or too reductive consider: passing IRQF_ONESHOT to 
devm_request_threaded_irq() then the kernel will automagically mask the 
ISR for you and will re-enable once your threaded handler has run.

We can then remove the watchdog interrupt as an exceptional (no pun) 
case from the IRQ.

Either way this flag mechanism smacks of spaghetti code and needs a rethink.

---
bod
