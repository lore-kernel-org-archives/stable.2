Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878695;
	b=LDb1SPHXxVEoPxOVosJWxQ/0FyfgieTRUYm8JogrsJRzC7NmEoNvlGmHqftW6CeNs1Am
	 auFcqmVt0VxSpqpPgg4ezF99rJAiuZ5Ca8S9JwJrERh+9exv0FEAMPPsgYCq6Igp9ZmSt
	 aOOKbtT8af6kWOckYrGNmC4umGW5ZdmDuVMHoNbEChXkC4B7rfPh+Xp84qZWrvGJzdd0U
	 xvh/uwqbXR51S+BHgf6vo7HNlrh63nZAp281uxUkctvBz8BIq5tSXp4953eaXlH/aPRSW
	 VGhq9xW8eanhiyObI5/G8+QiE75F0XEBqTDL3LK0kP5WxRg+H28yaPgMkS6YwDVLZEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878695;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=tbsBhorpX5/hg11/oBkLoGN5x3wli6X3ebAisCWgK2c=;
	b=S4i99eNGdatGOkC+PE2eayBtyy/ISTPkT3RHus/5SvRZZQwAW1sMux2IIBiAjbH0KE8t
	 uj7IqeY3oS99SqP8e+Fgm3hOZRIvuuHoVYFolDLYi2DZ9VK0vA+DjXARf07vXxs2DtSCE
	 c4YeeL2kJ8bjpk2ptHGVL90BaTSJN2hgEgW+4+AmY43hpU98dLt3C0O9Y0+OBFb8qkVEL
	 P7AGSlZNcTxudL86FX9Pt4m68Z6rHvEu9GqTFa//LnGzafrTaQdRCnNqWUngXtRgQ/wnn
	 6T31ma/EIA2Y1a17/nl4PAYxf+5AH1xadOzB8yWTH8xk5nP4YLhMwxN5qhy08EWL4yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSBKd+Qv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFB606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSBKd+Qv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206221F0093A;
	Thu,  5 Nov 2026 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878695;
	bh=tbsBhorpX5/hg11/oBkLoGN5x3wli6X3ebAisCWgK2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fSBKd+Qv9jpEqzpBaAREyG8s2z42IgL1Glo07+CfdW3vbfmgOhKIrXtU0j2mg0Glc
	 MnL+E0KHDIEYrIu8hBNFlpV/zeObvBuh/GlYNWLRfhm/KdhzZvOsJie96zNO3YRQNa
	 ekNk6j7jQuKLlL5CSZ+sZ2nS9TiNLib3g7VW3YID+9RmGGCLmvxwyXs6cuxzCsB61V
	 SbMW+MD36sss6mQJ+6XhVaQcPsTxx0MZmbtlqcD+3xVPkLhL9wE19M2kNRTZK69VPI
	 Y7f3vfXlRUpZeDpXy6mH3NQZkp/CFUthmzY1xPyPTzFLRZWH81fDJxBnl7XzUwTkXR
	 o0XCqSBloEJQQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 6D272198003A;
	Thu,  5 Nov 2026 06:38:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 06:38:12 -0500
X-ME-Sender: <xms:oWrsakkGlgKpR4wSm4ye8vv5csIAo86ksnI3CRCrKjaIAGWH7p4RZQ>
    <xme:oWrsajYtjeGUs_u_kIuefPOf_AzTPUtWXK-DrRSGYCrQpC4L5EcIZyN7-INXKLOrj
    UGT8w0Zod-RsEbrQCenUDhV7iSUy-tD9bftu208ILE03j7t44SYUg>
X-ME-Received: <xmr:oWrsasBHzt1eXTYkDr6ygg5y9ro_Ytj9FkIMPtFlnndtttzqxgzJyhCDHMo>
X-ME-Proxy-Cause: dmFkZTFgCBY0H5ERCpEWHMWeRovHwsuqR+Zb+dTNF6i0Wx6f7bDy0HWpqxM/ilEd3SmjwZ
    vjJAUFeZ/zBNEC3KI2YM+ad6PmkKx4ukR8n5J8nEiKNFWVXyvayr0881g5/mna2LEZcqam
    I8+YZ6HPM1KFewLEYnolCm4NMYZG7n/P92+sSLWoLbVmG9/cM8ddAdCMCI/zzzsvgYhWH/
    U0/un/WLwaEnnvjrs8TM7ghH3lFOprirTdMYV8lQR2O11uKvbkktYbVoKk6QpJLoKDlpMF
    htE8GiRINFSaJ74JopyvAxB/OOc/3hMfEeCHd9+w/qJ7P2Stp8TOD//K8G5YrP+v/+gaSn
    rqCy4qK4skVM4GvMeNcty2X+jEl/W9vNjpmQZj7NSp3HcqiH2ME/3kKmcO4vdSZxh38I7J
    hm8EEkedoYry5QczVgTb4gK5JbJXByKI9E/D12mIdar2rGXlzoLvqb04B6flvcbpWOUqwa
    xWodXioGRteUh8SVPRSz+jSe33SB4Q/D/xWYp5buKmkf/K7DPwLQz3JakHyyAf5XP2v2k0
    ypce1ZV2IEOqx+byeARzy6zXkHBuMXRBPo8mflhhICtYm4kEfDGfscjBvW7nHL41WdHa5c
    0QTbN74SZIEmIktDxDq1ZWXtR6RQcPexInTsmSlhYzkCOES6HqFBvU3HrZ1g
X-ME-Proxy: <xmx:oWrsapZ0sJZPaTLJohiTbQH0GBzNwIUuyVsQjhPFgXtwhGjHo0Ovuw>
    <xmx:oWrsaghIMK7D5dEeDwAHlTtyLk2v7kb6ZDy0SBbzNCAnWqhCAjKzVQ>
    <xmx:oWrsapw5fN2OQzBsVBeThBvK9xYPabwzuGCdda-JmTfst2VqD70-FQ>
    <xmx:oWrsar7ua-Gcqusx-0RQROs1qZszuYf6_HFQ7zjrPjym7UOkp0fL0Q>
    <xmx:omrsai0JtSjuBIAGCYf8dN5F2ipy5pl5kQbKYWQ6nBG8-gYebIvfqvyX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 06:38:09 -0500 (EST)
Date: Thu, 5 Nov 2026 11:38:08 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Breno Leitao <leitao@debian.org>, Dawei Li <dawei.li@linux.dev>, 
	mrigendrachaubey <mrigendra.chaubey@gmail.com>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: sdei: Run the event handler on the kernel
 vectors
Message-ID: <auxqaslfm5t3FAPL@thinkstation>
References: <20261104180936.2981070-2-kas@kernel.org>
 <20261104182842.3436759-1-usama.arif@linux.dev>
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
In-Reply-To: <20261104182842.3436759-1-usama.arif@linux.dev>

On Wed, Nov 04, 2026 at 10:28:41AM -0800, Usama Arif wrote:
> Would doing the swap in __sdei_handler(), around the whole NMI
> entry and exit pair, close that window?

Yes. The WARNs you point at only fire when context tracking is already
broken, but the same window has tracepoints: trace_hardirqs_off_finish()
fires irq_disable exactly when the event lands in user space, and a BPF
program attached there can fault.

It applies to 2/2 too: anything that traps in irqentry_nmi_enter()
overwrites ELR, ESR and FAR before do_sdei_event() saves them.

I'll move both into __sdei_handler(), around irqentry_nmi_enter() and
irqentry_nmi_exit(), in v2. do_sdei_event() still needs the interrupted
VBAR for the IRQ-like resume, so it will get it as an argument.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
