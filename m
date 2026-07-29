Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F52F3C1F;
	Wed, 29 Jul 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332841; cv=none; b=OU5OOpte9s0i6CO1vurE1Ko3bCoDXp6GNesF10k1kjFALKdkXYFgGcBH2xBxLnHNaoKY9Xq+aHUMjNHKtm1HfWC9jdFfWpJ/fGoWfFalspHs0dnkMcXNtG7TU0dNBqzr0y9wV4Nki02PnOvzNONs5ZDjaknxfgZKZVeOYhNtTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332841; c=relaxed/simple;
	bh=UsDNzdLfuSmaH0XB12bCXaQ8NBAStOBIOuBPf4lrQGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yf1CTYl4VTKgWywepSO4TRwmCqF+Y00HJLW8OLttIgIotAvdFzFqNbFj0nE3sKAYs5HEwAArfMaR8mI8EKLBPdmRhBk7fOoRJXxnC3pzov4dwl6HbjRloSyItK0jpVbx0WmEr3+rn//5sjOaLDO88P89PfHjp89gZyeXvFPurJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQbDn4eh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQbDn4eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804531F000E9;
	Wed, 29 Jul 2026 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785332840;
	bh=UsDNzdLfuSmaH0XB12bCXaQ8NBAStOBIOuBPf4lrQGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EQbDn4ehE2DH6inJix/DIlms19ZrTM8N5jZiMyejVkJ90aUMcTI/vgciwCz4lhcX7
	 9d4XMueJWfZBq+W2U1zP8k+3bA5jhRB2zqMdsvdTIQMy5l/6agIr4VI0f9KwFmN3ZT
	 Cx7T42ny+CDVcnnaQh6ZD0+2qrWnEXpJOmQAIGQE8BB0fikSDaslCJTDODJpwNRot3
	 6/0z7SkhR+SoRSrJWffSiUlFjcOWQ30jsYoj1ESrqDfqFDvGeReIT41z+BdEBn6Cxf
	 RCV+2X1kkzibWzvEOoTix+yTkzdZYFdYCmNNyeKPAKtX2nk8U++iAQmRPMjuesaIxJ
	 bXVNDuHg8IJSA==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRwf=WA-O_+NtEx2N38wO4qLJA7YBfDh1Ds88Et9hxjqXA@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87ik5yhisv.ffs@fw13>
 <CABV8kRwf=WA-O_+NtEx2N38wO4qLJA7YBfDh1Ds88Et9hxjqXA@mail.gmail.com>
Date: Wed, 29 Jul 2026 15:47:17 +0200
Message-ID: <871pclhpqy.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28 2026 at 18:13, Keno Fischer wrote:

> On Tue, Jul 28, 2026 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> Seems your mail client mangled the patch. See:
>
> Yeah, sorry about that, I've fixed that since. Gmail is a huge pain here.

Can you please resend then?
