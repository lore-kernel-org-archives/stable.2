Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876625;
	b=l6Gzwfl1/qFilyeCe49jrQa071kZp6zvniZ6bG6g2UCE3R1z1QHZhxcfn4zFGskTOCxM
	 rh4yKCWMyHtdVU1MABBABl77fuzeEJiiZwhp3qsP7SF8ufWnKjkBYi7A++I91NXa3eo2v
	 xA6+e4Qjin7lj7xjqRpz8YRBP7CAZ89sVAwWEChSMTvklxegt51rrnAyDbYAft0BncJG0
	 ZbHDlI3qwKu9KmNvhVdhgp/OBKWGuSNMc6rF5zwL2XKK8n1v2k7+EZEJUjZqKllYFhz+I
	 kD6WYlJmq3gOEWfvF/ktH6YO8JLZYnublqR7ToZxxVmxz5QptPWZzbColRAMiQj37QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LvA7KEH6yP+f436RwxVH7W63a6lypb6pYWkMfhLxpI0=;
	b=3m8aiLiFNMDcnUvf33u8Zd3R7l0FZWC/fNOfgQCjiHYlLstVBFL4aKntKtOvOLMQU3aO
	 VN8vkwr+pkE0V/tRJt7t0vrvf9iyroONrx2KrTwxcCE65wLMeB6+FhQawKPC3z9ph5rdW
	 Yb/NFOAqpNePprEpraWtdptI3R6vpbOo3NFvbx3ooIUB5R05IApr1tERbrciYqDaLl/95
	 ll+Lu6METyOvJYKVtYSwsf5OUGdDSbdv1K1B+KwlQqyDt296YjtKJL7c0GCwoZG+PMXOz
	 h2WTz+FwJwX44CTV6DLLaWOY1c/fswJhJ70IyPiN7nP115+SznmjuI7AXt+IQCgufkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6Y05fdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0ED606A326;
	Thu,  5 Nov 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6Y05fdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAB31F0093A;
	Thu,  5 Nov 2026 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876625;
	bh=LvA7KEH6yP+f436RwxVH7W63a6lypb6pYWkMfhLxpI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6Y05fdcHjlvz9xbOvt9aO2hDEJypsE+JMGEgDQflQxInnU6ttxEEo2YIsuDhCwAo
	 phYH6Ub8+S/Wr5NbUOCDr7XV9+LAVxdv2C0iG7i7AJWPNkClSjMFy2+Pe0clgH0oGw
	 dXMiD8bAGPG9TBSCbmCPTwy0bP5ZjsK3Vv/jEXfT2KvU+a1cE0UQ+EGxFnwga+mQaO
	 pUUMSSCh4ohXnxlWB35a6gtTke6IbKsyjCIKD/9huKH/mcpSPkxiJdX2kTuMuz/44i
	 FYEibOT29v+b6hiROp4++oqn2xNaKPOHKuWA4W1kQRegR47f0KUQP8TN9K5MwBYhv6
	 QuOmOwgwRut1Q==
Date: Thu, 5 Nov 2026 11:03:40 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/10] pinctrl: sunxi: Fix out-of-bounds irq_bank index
 when first bank has no IRQs
Message-ID: <20261105110340.GH1650678@google.com>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-2-lee@kernel.org>
 <e7cd2bf6-f9db-4a90-b11a-665f8219f7ce@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7cd2bf6-f9db-4a90-b11a-665f8219f7ce@arm.com>

On Thu, 05 Nov 2026, Andre Przywara wrote:

> Hi Lee,
> 
> On 11/3/26 22:29, Lee Jones wrote:
> > In prepare_function_table(), irq_bank and last_bank are initialised to 0
> > and last_bank is updated on every bank regardless of whether it supports
> > interrupts.  On SoCs where bank 0 (PA) has no pins or does not support
> > interrupts (such as Allwinner A523 and A733), the first IRQ-capable bank
> > has bank > 0, which causes irq_bank to be incremented to 1 instead of
> > starting at 0.  As a result, the final IRQ bank receives irq_bank equal
> > to desc->irq_banks and writes out-of-bounds past pctl->irq_array during
> > sunxi_pinctrl_build_state().
> > 
> > Initialise irq_bank and last_bank to -1 and only update last_bank when
> > processing an IRQ-capable bank so that irq_bank always starts at 0 and
> > increments sequentially across IRQ-capable banks.
> 
> Can we please hold back this patch for now? There are more issues around the
> IRQ bank usage on recent Allwinner SoCs, patches for which [1] are on the
> list. They should solve the out-of-bounds access, I think, though we might
> want to add explicit checks, maybe.
> 
> But taking just this patch here would torpedo the efforts in fixing the
> correctness issues that we see.

Sure, no problem.

-- 
Lee Jones
