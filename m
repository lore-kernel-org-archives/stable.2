Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868591;
	b=qZENnCyziPrblz4mgVrQGbqWA0e+Zde+fZPo1ZneKOD9r15jY7L8/3x3s3rX2PTnZtn6
	 CEPfWeTG0udJOZV+IjLdAjTzsmdeKiNMXfI6ZunjficnDrcOfm2jmsZh9dILn+ux+NP9n
	 xDrRL4ywLgQFfu2dWe8wW0u8j2AZQ5esIsiclHkxtN6cjfBe9H3HTF809YlHAAe4SpSgp
	 WdKqLGRgnKRH/wOq3bFj4RL+aL84YTlwoDeQYwwQfyHTNVB+5uQC4wBHmCkt0RVnTViaT
	 WbYxiH5GtzxYm9U8hkjKFTlAiHXvuh5B1xR/SsTWfSgrb3rfbWiPCPJaWZF1AzbiX+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7eskyEXW2WJu1OAVnH2Z/C+gXSpaGa/nzLhd+PYAulk=;
	b=RnPtIuqjWzl5JvH5SioH4atPZXw3DQRkWewTiw0I4d+wn90lCF8B6DWhMt0iyb5sh6VZ
	 YaY2f+87t1HEplzAfTEeMVzFRpnBOKxKM8/obEhmI1SLzAeaVKrD6Hlym9GFCW6lS8s7t
	 31XRRecnm/GXg8tgHbPijD7CMNSXXHheFYRsgKHKjwRHPCD/GUeJX9TRYZq9w13VujVAH
	 8Cr1QLNelhUsjF+9C+p4cdatmVDqnc0vnZwaZIqbkXrrt075Oa7qs2pDuBmq5kn2SsZem
	 +DApJWbhOAoB12UidbDrwNY2RSomANLWGWw74gqWmKGyTrj1xdm546PRJM8r/lQElTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ho2RKx3r;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C1606A33E
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 836C1606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ho2RKx3r
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so3466385f8f.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868590; x=1795473390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7eskyEXW2WJu1OAVnH2Z/C+gXSpaGa/nzLhd+PYAulk=;
        b=Ho2RKx3rEO2FcF7PE8ocDweY86W0zoAnenCU/35zG2WC3UmxIGinYrRzcyNY4fMZzP
         pmOTim/ajW0oE2Vc6v9ZiaDR3xtyFg3UUlPkbkByU24SB+naN8aPsMvG6mrB4gUU4o3a
         aT7dP4DcGLpPpvw/L0q7i/jRpmzSGrbj90bmB4Yu66QdxwujUFcz+AL/ysjpT4RL8PUR
         SmAKBxEVfocPjFzODut4/n4szJF4GoebMhd81kh1HCWD00plY+Z865Jduv6t0A9h7wT8
         p8BrpHQ5YzCQS6euDyTLMjjV9SdeVVXkVYkABCBy3eTrnUzDFguCiHMIA/vVukhjp6vU
         KzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868590; x=1795473390;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eskyEXW2WJu1OAVnH2Z/C+gXSpaGa/nzLhd+PYAulk=;
        b=XUent2srKUgf5L5y5HAdnXmj6giBXchQOpOsmIv6XXNFm1/1+cqUiajcEx2L7b1K+w
         N4zCh7mFdU5g69xYGGOBrZC8+o2nR4WV/9jnKmWyE/8Q4dmum7jMmjc0YpFYuVA44ebE
         nFJurB1PVgMfuP+NqTNg3s85c0NT7fw+bvL+Hxv/UW7ejxSCbSuWhtP+JKmHaqW3NIU3
         sL30197LcvMMis4/197sQhzeEjWG3vDBfXEk+IBc1ckoFM+vE5an2SH8WTtop0ZKFhwA
         /B92zn/ZsqxaCnGi9fp9SwvphYQ8klnZTMmbLIkw0PR5/50CqVvR5NceemaG+FgAE5z0
         eDsQ==
X-Forwarded-Encrypted: i=1; AL+hErHvtanfkXlB/fqiFeABmvf8cghGzRqhblY4/A3t9oQbcGnXx+KPYd7PcoF+L0MqptNydBXXBx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TyCzWXziRCI/OETcKtwUP4QMBfnLm4RoZtc8pD6kP5duE+0m7
	4fkf6hScnqEJIpxTaJgSovLKi2awRTYXn5OpMPM5gfEphUbgYoXUL4yG
X-Gm-Gg: AZFdTZdFdC+wKk5koxEuXxKh3yPsz93WY8E5tFwi4QSqVMoU1jnDLzR0qMVI32rP+Me
	K2tQRIYpPbpbeTrtM/FTkmCHhfNowXf2CSgpmsfR+BxyelE7SrLb0dlWgYMoasBp6bvmSBSMe6M
	ANv7xNUOzDck2vBq36s6NQi2wqPnKkHO+jSXLchwZcTfSNJ4ovcWkTNnMOCKj/4ihy7ZpWbiwCh
	UGmvZeE00cZZ4WMXcw8anEmxmfUVLAFyvujLeaL+Z636DPaCdPlT4nl73hGvA7p77U46RFeZYGt
	EmHRpmoR/dfRe32lGW9v3k2+pDM9AXvVQ7vpcUEFVPLnEZm7cu2KcZXODQQMACNX+JUIuT0YmFI
	tsmWk2eTuWcnlQBeZ/N/kLfhr6Rey/jUAtzQdennTWO+8HT5g1g/trIWb7JyoxJUJW+pYLaMiFj
	vmcmD79VSD4eJ5vMaVLHSmfYB2BE/2HPg0bnyoASehAk6FPqLY3ht2vuGnwJSt4OOoe1ULQM5iH
	Yq71XmBY4CMqkG0gdeHdDeblFZiccEamsixxvyZEbKPylCeN3YB9Ogow98mrvG51I61WSnZ6u/Q
	O3G7VBSi2pF3j+efK5qDTfx5p5WHfbPrbk1sB7A5EnFS8klN++K988EHbfcJ3wyVtbA=
X-Received: by 2002:a05:6000:2402:b0:48e:5550:c64c with SMTP id ffacd0b85a97d-49c70ed7fe9mr26111904f8f.14.1794868589842;
        Mon, 16 Nov 2026 14:36:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm27428709f8f.11.2026.11.16.14.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:36:29 -0800 (PST)
Date: Mon, 16 Nov 2026 22:36:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, "Borislav
 Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261116223628.5a6139a7@pumpkin>
In-Reply-To: <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
	<avrPcQ4sOkgJPbkZ@gmail.com>
	<20261116130159.GA1327949@ax162>
	<CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 07:48:34 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 16 Nov 2026 at 05:02, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Nov 16, 2026 at 10:40:01AM +0100, Ingo Molnar wrote:  
> > > Can we just limit the feature to when host == target, ie. to not
> > > work it around in such a crude fashion?  
> >
> > That was my v1 but Boris didn't like it:
> >
> >   https://lore.kernel.org/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org  
> 
> Well, that is admittedly very crude and hacky.
> 
> Maybe we should have some config variables that depend on HOSTCC, and
> detect it *that* way. It does appear that we don't have any model for
> cross-compiling in the Kconfig setup, but maybe  we should..
> 
> I'd actually love to have support for making the compiler itself part
> of Kconfig, so that the gcc-vs-clang could be *in* the .config file
> rather than being an external thing to it.
> 
> I've mentioned that before, and the problem has typically been that we
> end up depending on 'CC' outside of the Kconfig scripts and
> independently of the current config.

I don't even remember a check that the compiler is right for the architecture.
I'm sure I've got strange errors when I've forgotten I need to specify the
compiler for a cross build - and then forgotten where I'd put the compiler,
Oh and forgotten all the things you need to set to get clang to do a
cross compile.

David 

> 
> The recent work to move the compiler flags into Kconfig itself may
> have lessened some of those dependencies, but there's probably still
> lots of small details.
> 
> But for the whole "cross-compile", maybe we can just say that
> X86_NATIVE_CPU depends on '$CC' being the same as '$HOSTCC'.
> 
> Or even do '$(CC) -v" and '$(HOSTCC) -v' and check for 'Target' being
> the same, and having a CONFIG_CROSSCOMPILE thing for that?
> 
>                Linus
> 

