Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC93FE66F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309756; cv=none; b=RXFS/jSRMbFm4SxfzGBKzdVdogQrPc81n0/Swdc3/h9VAUZv/9o0uWRpcm4qAD11HqYtCgyGfBsJ8fglEtJX4rRkWNOiPE+Cso0E99O6VXLAD0ZTpZRWlRrmTZlbpKgRF8b7t22HxTEXd1t1ryiGY7ZPfWYJMqcF5PeHF5Ldj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309756; c=relaxed/simple;
	bh=oxfoMY7jU7rL2S1wDkwe5zxb/9tOoXPbLVw5tK67mu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCHnBXvxJ+HyTUnvw0d/G8m5YSht/JLlSg/3Sj1oxuHGMCboewY7O3Kst+BYf9xbWWxl68q4L7tu7gV3cPND2pRKBXISYkcifjRrenlHFpdWLlrYcp7GCQ38Ewour0gOanvFkHo56aYYkppZRSEIm4vExu1Mw5q+BK9wdtuolgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmupPDRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmupPDRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CFD1F00ADE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785309747;
	bh=oxfoMY7jU7rL2S1wDkwe5zxb/9tOoXPbLVw5tK67mu4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QmupPDRhZTb447l1aChITnMPwy3tbmBMfJufu4b+eP9hCv8rDBfgo28vfJqXYaEWd
	 WqzoAEwoSdyrP60mBkjRRH6/Umse/xxC+Ukgj8W3RpBqseZT+r9/NxhetzqkkymgJc
	 JJ7WirCPWOETGpd1dbW7XlDxfm9rxCVWZ9Sw/+0G53h+7UsAuYik81c7UdyLiOFIXM
	 NgURIFw7rwqkm1zDLyliPyjsuuI4tRHNaA9UQ8tVHcJZg+wYnQP2+kmzrsXiuzrlju
	 OuR9cVFU9U7kJ9kaImxfM3XtCs4k40DnFkAAgGE39LLLeZnuxuUmcluVsuM2lWJ8Jd
	 hgzef9niYPDRQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c83acb86eso4868871fa.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:22:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpj5ZTalLmhjcPzN2rgdHgUjR+LS+j7jxfrc/pJS25Y+7uC17acsxvWZzAblMxfnWVwr2+YdJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwutqBDNxDpCco7GZ/mgyl/WT9pLiyFUxig6nSOWkoTY3Go+P
	n6VcLoaEjvvzsbXw50pLoQ73Uon8ZdqrOjaJv4XXFVCQ5kwyf5mjKr+7keIHEULFCy7ddg4ic0x
	cisYxNccCAcAr+DZ/VTF5LIjCQ6oUMr4=
X-Received: by 2002:a05:6512:138b:b0:5a8:88f8:9ed4 with SMTP id
 2adb3069b0e04-5b2d025abdemr1268412e87.30.1785309746211; Wed, 29 Jul 2026
 00:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723014129.1129730-1-junjie.cao@intel.com>
 <CAD++jL=EJyWpqjwCdfosdanjS9GUAwMEJjHFrcvMyBV3iKHZZw@mail.gmail.com> <20260727151902.214691-1-junjie.cao@intel.com>
In-Reply-To: <20260727151902.214691-1-junjie.cao@intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 29 Jul 2026 09:22:13 +0200
X-Gmail-Original-Message-ID: <CAD++jL=Wu44V2CyZaky35+mb2RBJ7d3wRsmYWfK-8D5_Pck=dw@mail.gmail.com>
X-Gm-Features: AUfX_myrF7H2U8CBCjS7yTzN7BwCEf9LS0EJzRBLZWBze4UVLnMhUDojAr3396g
Message-ID: <CAD++jL=Wu44V2CyZaky35+mb2RBJ7d3wRsmYWfK-8D5_Pck=dw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
To: Junjie Cao <junjie.cao@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:19=E2=80=AFPM Junjie Cao <junjie.cao@intel.com> w=
rote:

> No -- it is indeed not a regression: the lock has been a plain
> spinlock_t since IRQ support landed in 2011, so it never worked on
> PREEMPT_RT rather than regressing. I Cc'd stable because current LTS
> kernels with PREEMPT_RT hit this sleeping-in-atomic BUG today, like
> the two fixes I referenced (286533cb14a3, 90f0109019e6, both Cc'd
> stable); Bartosz has since applied it with the tag kept, so I'm happy
> to defer to whatever you and he prefer.

It's no big deal, the stable people pick a lot of random stuff I don't
even understand anyway. If they want it, they will take it.

Yours,
Linus Walleij
