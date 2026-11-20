Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182108;
	b=RfCSEobl2a0+zhyJqSHyh2WMH6WLIuHlIHP7NQFhaxLmDUNox3QoZbLsnWABLcDVTjX1
	 fRUy9+ZhOVIIal9/MPo58OwJKmHPrPJXWJp0Wck487UCK+kBBYctJ2bQmwwmENahgn/0A
	 thQQqSAMvi8VrgbFdHa0Vlrq6zFSxMJg78kGoXnYQO1Aa+oNmJ+iQ94KO5GfSZNYmteYu
	 75mfohRk5A1MFFidqrcz60qBgPyifDEU3wDVB2bM3BEdRuC5J3wa0MBNDN3vjklQZAjLQ
	 YeVCm3xz4n6tKPKxqCzqi1VIMaUi/OcNMA7PYCBl+0Pe8M0RI0xxV4TYpv0RDk/SDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182108;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=tRI1lv7rwB7pS9lT/9hl+4HCpZZZ86A2sPjXr1pUkYo=;
	b=rBNOBjdOHiRVPhuU+1MYqzViVRSW0XIS/FIshnmKNVXhy3LS+0cgTsRqNdtVnATVWWYz
	 5OCzLuKw9gITkxOFW4h+FJTK5en3nCN2Hq/uBmO/kvQVcCBS0V2DBYRexmGc05Nsffqkh
	 lM+yDtB6wKGtNh7cpAjPsS0N9h/9CutQw8GsEofBzL7zmrcwX533rViYi6QOOwgA0BHgK
	 oqtFuLqNFqMiLFltE9Nx/xTyBYUXxAOLRpI/ebDf01SyQSX1+IeFINKpE4QtfKVG0oofU
	 q16tpnM8HNurocuS7iYdVBuxMcOzq9GWOHfODuskI02DrUjnKE+R4yFhzWO0d2iaa8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXgwq3h7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70683606A32A;
	Fri, 20 Nov 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXgwq3h7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B151F000D3;
	Fri, 20 Nov 2026 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182107;
	bh=tRI1lv7rwB7pS9lT/9hl+4HCpZZZ86A2sPjXr1pUkYo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QXgwq3h7JkSkTkVr7JMeyzaBp9dINHjddc5AKYiT90rXrIeFFuhMEGkGduxO80DJ0
	 CbAWlRXBQqsgS/Suthbv9KgGim2Y+kOo63+su3wTnt50qdRI1Hd6bbWGMO/Z1AGKfW
	 M4RYyuEbR2Q8N1RWHtz0D6u1YZ0FJJQeDqb6fG0l+rgjrjErYYJ3WWEmwWdYyYPxeD
	 lmMHzCezRdvdMtfGaqVRI7VZHFOWyExCNVVkcObnXZqS5qjj/ytN2syS27asWYKUBx
	 mp3HDym0VzQj5GufmEA3ugXI7ZFsNcnVArBD6O1qX/HQ/IadAupHVVoJb/ymApnfeb
	 bHDfNGA+OrkJQ==
Date: Fri, 20 Nov 2026 14:41:45 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/6] HID: wacom: guard against NULL input devices on
 successful probe
In-Reply-To: <o25qn5o2-2257-6rop-oo57-9o4o54sn688o@xreary.bet>
Message-ID: <q336n60p-2903-2481-12r4-p8rrr295qq66@xreary.bet>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20261024033040.316652-1-jinmo44.yang@gmail.com> <o25qn5o2-2257-6rop-oo57-9o4o54sn688o@xreary.bet>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Nov 2026, Jiri Kosina wrote:

> > When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
> > the corresponding input pointer is set to NULL but probe still succeeds.
> > Subsequent irq handlers dereference those pointers unconditionally,
> > causing NULL-pointer dereferences reachable from a spoofed HID device.
> > 
> > This series adds per-function NULL guards across all affected handlers.
> > 
> > Changes in v4:
> >   - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
> >     NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
> >     suppressing the spurious input_sync() the old "return 1" would
> >     trigger (Jason).
> >   - Added pen_input NULL guard at the top of wacom_intuos_irq() to
> >     protect its helpers wacom_intuos_inout() and
> >     wacom_intuos_general() (Jason).
> >   - Added pen_input NULL guard to wacom_bpt_pen() (Jason).
> 
> v4 now in hid.git#for-7.4/upstream-fixes, sorry for the delay.

I am dropping this now, as I am not sure against this tree the patchset 
was generated.

"HID: wacom: add NULL input guards to wacom_intuos_irq() and its helpers" 
adds check for !input into wacom_intuos_irq(), but there is no 'input' in 
that context neither in hid.git nor in Linus' tree.

Please resping against something up to date and resend, thanks.

-- 
Jiri Kosina
SUSE Labs

