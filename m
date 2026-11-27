Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795769418;
	b=X2wMxuiO0ntZDh6b3lVi12Bc3SmDa3Oh/nnJ1G4FgYH+9t2gddnYLiIryIsgcfvbdOUv
	 RX6wvVo9F5sGb/DrmXJt8eInD4jnzj1qoiq8zHm1eedEmvb0FKz7bdX7Owr+dUArM5LGe
	 uNG0k8+AVuE/tSq7S2isZFOLVY5fbVGwri0s9e29RFoSMExfVihkwYR1ai9iMayyAQAMX
	 uyE834y2iWrkM44q2gXmGyxjnlPWzhVE8OW3mANlopAXD9v04A1uE3Hrf/NGVzjwJGzW8
	 kzCWA5oRxsZLgzmr3+Xsk8nJ/Y4Zzle5x2v/47EXyakkAar1pLAeDW0TG+xC0MT/6OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=1nkmCbt89mOXVsYZ+bIViUrNgUgYNTWpmaoubmDL04k=;
	b=nxtBVdB287PMYAt/lnBLstgi/WAWqox9z0dfhHUPYb+Tvyn2GQimmmrJiUlxLGXyU7J8
	 r6pxoleusothTvG+pePJ+qj1grhm+SH3KE8uUuVXo6oaQrexz39Vlf/C1Ckk8sKF0Vro2
	 bZkFdf2/2PFe8cMfw5b3I96xcpU0BWvd+326qRrNBk05yORTgiGm34PxK+RMhXuwCCWmS
	 dkuRXI/csU91LCb1Biv3MDUhydGCdHDSm5RERUhwBMzynsO7nlwWB3vzipzS/ZdYdtVY4
	 LUeTpxbY8szsuTIH5OKUqJEkcBQCLslfO9C9PgMftzOtyf/LWHPcbYqM9eDUqjQjILQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=hFaLEwnM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F88606A688
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F88606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=hFaLEwnM
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67da69e7c31so8530285d50.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:50:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795769417; cv=none;
        d=google.com; s=arc-20260327;
        b=G7xGPbuQ36a64ZaYhkvQqB2uKaIJ1dvT8/ISnN4NJBms80lpnRl4JizTpKUYmmlN1D
         +dygEh/UZiWXTSIE6dQnHe608hABeD2txRV0nYHIDSgWhxPlsJVfR279XqGyajfRZdY3
         kkks16wLuI2hFGwyiTOdVNe613aYPWVuw0DqcXx3GvVM62SAdE0gZUeVvW9yF64DswSy
         hTWJzmEP3Ir4lNbLDZpv29yg/Qp2TPS4b9VYcPTKm6gSJqkqvMVH47IRFumPhW4c6/Uy
         sWUWr2LZ5xHlD7lT+iQ3hOmzc1xf+Gnj33oUN7kYZT+ZTu0Mf/PED9znkKLXzvNQVlUC
         ++aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=1nkmCbt89mOXVsYZ+bIViUrNgUgYNTWpmaoubmDL04k=;
        fh=jQFHF6sZb7lePkUMHOV2HGjT1sGUBL5aHicLHIgGdX0=;
        b=ipOa36d5jk6tx7PxC4pJiaX0nQR5KJxINjZZ3wskixY4T3s753LAIDhgR0Q/TjukpJ
         AJnb6o0fbbtFXhwt5kJthmdhaGJ5aGyXvOEyQ3bF6UlkztKizKiTCE33oYO0AcbeqTO5
         G26+rAGuk1egSBozaC7sbVs0dm6VCJmeQiOrWPnyG/qRPh+ROjkmTpAQkEZb51D19dKE
         xe2I0/if1C6eV0SecHAn9V89sBCxOM0xJ6LUbmX/8McSYRC4KPFyLDdWcRYboaUIT/5I
         tht81/Cw02nxeN03x7ZuU9MKL9q1V1n/tKWTI9LDowBT4mF0Mg9624aAfLwE/DqM+qkt
         GOxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795769417; x=1796374217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1nkmCbt89mOXVsYZ+bIViUrNgUgYNTWpmaoubmDL04k=;
        b=hFaLEwnMzhXcGovvL0mg+lbdY9/lem7uqjl8y7WuF8N4rduwhcD1s2bXEq05mmniKL
         1a9imE84VVSqBBqQQL/wCKixAU1LL3TQFqgOIkkwGa61usurF0HKwngfzmm0jCeeaPk8
         OBF2r4ZwDxLLrTe//+fwuEx1tSI9+BLRcCCns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769417; x=1796374217;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1nkmCbt89mOXVsYZ+bIViUrNgUgYNTWpmaoubmDL04k=;
        b=qRMIu8gCi/WqctFaWAp8+lMI0NKAW5RrYue+g3JAMU+fe993QpCpmXW/T9ggLrwcrq
         E3NGLrWVraVhbDNNXKIfh2ATQ1WeU+gphbAYZNFxZWzb0u5RmwVdtIIRwAuhEgXlVUst
         +b7vq1kab0oqJVLcRTeb7mGPHCRoDhgq7pRUSZrvgmkollOC2oZnTSN1OH4+CW5ZZWuh
         095vsutZbTucxffELqwkIfxFotuJJ7WoFSEAAt59dPdv3VTUs+MSG5eJqiTiRiTzAfye
         fWMOalXed/xowdLI+BnhqaBmuziw42dyVzRKmjjTgEighgu0Ak76xfL7R38Y0nUL8z1K
         wfWw==
X-Gm-Message-State: APuU4Z/u3CsfrJaCOB7PsTUgQkexdQkwbt4tMN3n5QNSoeuFRpnOuuKa
	Y4xSuYmUqA04IlfkCHMrlT22gY43TaGn+L/WiMgi+AwSDob22uKLKl4BsKqC0W/0seABvWaLyfb
	/D8I2wQQ7SKU+py8AUCRy9hcjTDRn+gUipLV+0kRrwCvBO2RTMt2X6RPpXQ==
X-Gm-Gg: AZFdTZe0jKWMrqQcq7zNrbqyJ9HiCMOCuxhVflFFwnx8M7g8PD8fxJ2/JqHaRE1oeWZ
	o0DAlShkxetYys/ulJtct+DG4due31IFFc8ay756txT09DX1XlCWLhrEQDKjRbzIsx2hNlDT/g2
	+DDyFrXGIulyhCQepXBFKftabXOCLFIxLttolgUN3ykaex3TK8n1IdTJe4Y1bGRUomruGXMGSBz
	JC4ECkF0HtsvPqll58qBaayA2QW5oI1XOj7L5ap2FRt2PjrHC/Eu9c3GJYyPHH+2UlVOir0iJWl
	xDP2Mby4E7g1cF4l94D47YwkGnNzym19zw9loCVE/+YjCvxZawDU/SCqjRIy5foNYKdhE79Ja7x
	IPCVn3wXPvUM+RH2iJL3Zls7D7GvPzpVRlmK4lhUasyRn+rgmhki5dLX3ake71YyfM8mSBWj/cF
	9N9SVZ2PP3zYud31AI9NF1n2Bef7dUxG3BUGP/fflAvUyggugoS5Zt5/YEESdaDuBY6ymQFFQkx
	CTZd1+6dq4hXnZnoQO8s1mTLdzHCZfl/9iR
X-Received: by 2002:a05:690e:4002:b0:67d:e75f:1219 with SMTP id
 956f58d0204a3-67df44d750dmr10295274d50.87.1795769417217; Fri, 27 Nov 2026
 00:50:17 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 02:50:16 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2026112723-jogger-splice-ce25@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh> <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
 <2026112723-jogger-splice-ce25@gregkh>
From: Dickson Wu <dickson.wu@certik.com>
Date: Fri, 27 Nov 2026 02:50:16 -0600
X-Gm-Features: Aa3M54pQVGXii3tmxYaC79h27nvtIxMZ-_g64TL1BA38Z4_z863HNZvJOTVri2E
Message-ID: <CAFaZ9eqpPdQ3fiu=gO28rJY48Jh9SqiRxdpXYtBzB5hcoGH7Nw@mail.gmail.com>
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 27, 2026 at 08:05:12AM +0000, Greg KH wrote:
> Thanks, but as both of these are going end-of-life in a few days, and
> the final -rc releases have been sent out for them, they are not going
> to get merged. Anyone still running these kernels should move on to
> newer ones now.

Ah got it, thanks for the heads-up. I'll stop sending for 5.10.y and
5.15.y and stick to 6.1.y and newer

Best,
Dickson


On Fri, 27 Nov 2026 09:05:12 +0100, Greg KH <greg@kroah.com> wrote:
> On Thu, Nov 26, 2026 at 10:57:03PM -0800, Dickson Wu wrote:
> > On Thu, Nov 26, 2026 at 12:59:23PM +0000, Greg KH wrote:
> > > Same with these, please provide backports that you have properly tested
> > > and signed-off-by on.
> >
> > Will do, thanks. The netfilter one is out now as a tested backport with
> > my Signed-off-by:
> >
> > 5.15.y netfilter, a81047154e7c:
> > https://lore.kernel.org/stable/20261127-so5-nf-515-v1-1-ce02c323f842@certik.com/
> >
> > I rechecked it against v5.15.226 the same way (SHA reference, patch-id,
> > subject, and later reverts in mainline), and it isn't in yet.
> >
> > The other two:
> >
> > - dmi-sysfs 18e126e97c96 for 5.10.y: dropped. Getting it right on 5.10
> >   needed new lifetime handling that mainline doesn't have, which is too
> >   much for a stable backport.
> > - arm64 ptrace pair 88b839ce497c + 5306f124f317: on hold. 5306f124f317
> >   was only queued for the newer trees this week, so I'll send 5.10.y
> >   and 5.15.y once 6.1.y and newer have it in a releasea
>
> Thanks, but as both of these are going end-of-life in a few days, and
> the final -rc releases have been sent out for them, they are not going
> to get merged.  Anyone still running these kernels should move on to
> newer ones now.
>
> greg k-h
