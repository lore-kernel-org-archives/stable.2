Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B7440638;
	Mon, 12 Oct 2026 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838419; cv=none; b=tPSUKlvbAb3qFOpdi8hdZfQrdJnr4JMCoTC9xo+AjYfdEt2ra/KBYOtNthZPE1ruI/cGW/dhWRPCu9ntk10Q4jn0kArOZLDYJ7lr0+BBD3MYLkAvrqjV3ayCRv3Hw2yxm5F0+xLYoNbvbdnaIQ7O1qLVZvpuepJx9kt3JgBuLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838419; c=relaxed/simple;
	bh=UtrlsS8phsymac42K0cda/Va1ulluctSzlmp79L9vqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=evAjfN7+1fUKFnvH8N9RZhMOC8GBe2aegXvMNLD4wyMG6H5ZGrTOVCNMGsFPN6zIVYVI1Fs0gq7j7cidN8UxkSF2N/76FJNaoWCWlbhNLuaZHN4A7kBCfaMi38GUbZvPSJyDTD2c8Dx+fyhKb6X5331IwZKnZAMCpS5LamGfl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TnqxEC8o; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TnqxEC8o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 565C41A109E;
	Mon, 12 Oct 2026 20:53:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20E96601A6;
	Mon, 12 Oct 2026 20:53:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8162311D70BEA;
	Mon, 12 Oct 2026 22:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791838409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Yzsm7UcLWz95w7mf2csUHMiUJrt8gEY4jLejuhdiuAM=;
	b=TnqxEC8om1vFtcEub3V/hkQWm1SBJYORapt54lhZfyc8VpvxaKlWoT/AP5A82neKZGZrzA
	P/1iSrfE1Yf+O8OJOQUbtHcvABWj2WNUpKdVe3pBwUL1aP1XcFZlef17BmegzDl1yKfuvV
	yUKT+fDCcr1RV4nxqc6OzVFANsub2kAmba3+Av/8HezTYdNhjhnLGbCoc2KK1Fg35ywZZf
	wtpstfHAPYAtF4uYod7oKQIfRYfGP5eozhv1hQfSr0Pou/wWHDSvgMWqZ9d+/zSSwacz9S
	hrNaBr2GD2Wt4uc2m5jA+sndXOso0K0gEf7Ec+SNaYaOnJUli/zxWNHVjzfZIg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@kernel.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Maxime Ripard <mripard@kernel.org>,
  Richard Genoud <richard.genoud@bootlin.com>,  Masahiro Yamada
 <yamada.masahiro@socionext.com>,  Boris Brezillon <bbrezillon@kernel.org>,
  Brian Norris <computersforpeace@gmail.com>,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-sunxi@lists.linux.dev,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v6 01/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
In-Reply-To: <CADvTj4ppQannShF+dkLreST94g_vSAg4QdMqxhNORzkvci3O1A@mail.gmail.com>
	(James Hilliard's message of "Mon, 12 Oct 2026 13:17:23 -0600")
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
	<20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com>
	<8733ua23xs.fsf@bootlin.com>
	<CADvTj4pmtGZ4c04q+5AE3trrfshToD7BPtF-8kPxPRZ25hOTRw@mail.gmail.com>
	<877bjmzqkr.fsf@bootlin.com>
	<CADvTj4ppQannShF+dkLreST94g_vSAg4QdMqxhNORzkvci3O1A@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Oct 2026 22:53:22 +0200
Message-ID: <87pkxey725.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> >> commit log, I now disagree with the first part of:
>> >>
>> >> >The old handler can also complete the new wait or restore an obsolet=
e interrupt mask.
>> >>
>> >> "complete the new wait"? I don't see how a stale handler completes the
>> >> next wait given the handler is a hard IRQ and the interrupt enable
>> >> register is cleared on timeout.
>> >
>> > The case I had in mind is an already-running handler on another CPU:
>> >
>> > CPU 0: Read st and ien for operation A.
>> > CPU 1: Time out operation A, mask/acknowledge its interrupts,
>> >        then eventually reinitialize the completion for operation B.
>> > CPU 0: Call complete() based on the saved st and ien from operation A.
>>
>> For this to fire, the hard IRQ handler on CPU0 would have to be stopped
>> between reading st/ien and calling complete() long enough to span:
>> - A's timeout
>> - A's cleanup
>> - B's wait being rearmed
>> On this hardware, how is this reachable?
>
> CONFIG_PREEMPT_RT provides a concrete mechanism. The driver requests this
> IRQ with flags =3D 0, without IRQF_NO_THREAD, so the handler is
> forced-threaded. A higher-priority task can preempt that IRQ thread
> after it reads st/ien:

That argument only appears in this reply. It is not in the commit log
nor in the diff, both of which reason about a hard IRQ, no? I'll happily
take the PREEMPT_RT case into account: in that configuration the case is
reachable, but it reads as a justification added after the fact.

Then, I'm curious to know how the AI justifies the use of disable_irq()
as the RT-appropriate choice: doesn't it block without a timeout on the
very IRQ thread the scenario relies on being starved (and gives no
priority inheritance)?

Thanks,
Miqu=C3=A8l
