Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E4560ADD;
	Tue, 22 Sep 2026 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098156; cv=none; b=gPCSTjlAE4Dmbd30TSgwhNvwcnFshEAVBsi+vxRBIkW/rrHpRfDjqeZbMkY+gZ8mx16jTw1Z/kwaPklHOY9LjrXagxZum3FyjsCTcGCM0sCedcgrPW3H4C2zzpVjYd7gMOCFrJRBK8spgrqrdT0cFZDFkmyHD+ogodofq2/2EJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098156; c=relaxed/simple;
	bh=WDdU+RoIRC74e9CNP7qeqsxMqKdI0jxRfUEfZ8vb/Qo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q5q4DxUkMaRkjE0CE+Maz+KupOlDtGQUWDRJfstnkmngu1D6EDQRt75JXK54UG1dwt4NPsb9ICo0HJqWt1cmJynIdYB96SMCSbIKJoWEkQrXMw5J9G5xZIVUwXfieCQWYw7RUdGw55xk8QG1d3JOfQMHoml8oEfW68NBnIFBAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=serow.io; spf=pass smtp.mailfrom=serow.io; dkim=pass (2048-bit key) header.d=serow.io header.i=@serow.io header.b=qRIpIgE8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6hniyxL; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=serow.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serow.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=serow.io header.i=@serow.io header.b="qRIpIgE8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6hniyxL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B39F7A0063;
	Tue, 22 Sep 2026 13:29:13 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-03.internal (MEProxy); Tue, 22 Sep 2026 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serow.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790098153;
	 x=1790184553; bh=wGjntAVjqqMJdW+oeRuv+YV0f9faSeXFe/ciJuzRhTU=; b=
	qRIpIgE8Yomm/t81NMgQzV0c4xc/ELq4g9PEuXtSg2+lSvNOeUF3Jaa0Vplmt3MD
	rz7vqRpzLAwhSx+kXgp89AhvQ6Xbatz+gXcpBqG4Qt5tyUL1Ay88AoIeVwLsl3X1
	GcHGWVSprwhDyzYgAPxmjcfCqAW+R8E/niBbhmTQog0biiDCXpzP31Gco05jghw/
	02OTsBPb/lopUhbEHBqBrIW6SJyUqk40SAs7kcz7vw/FvsGogok12rzB9UdgItqs
	1OelR0nbGEndeCOxWGEiUxhkA0GoreTasg+HHzoKQwq7T/rsyoi6q5Lt5Gsrh042
	SpdL6a99xftgrCURC2+LvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790098153; x=
	1790184553; bh=wGjntAVjqqMJdW+oeRuv+YV0f9faSeXFe/ciJuzRhTU=; b=i
	6hniyxLue5YP+0v4HjV0TcfPTZZ2wAGLLOBuCWaU9jtG012kWQOy92MpxO71eTxW
	dz2kPrq6dDBEOb0lYwA5Lgl8zpClhLx7zWP7JkuXOHNzHMcHreLCybFJd4545mal
	SSnVQQPsb75PxwhaBqrNTIkH3IhQIcl9vTIACcRWt/AhDnSiT8qn76Nwm/8ALUnp
	or6lHDuFAgeyIPzpS0/RkGtFeGXEbNr0LILl0nOfZa9ve076IvSAPasdI8BhgceO
	NP3yfPfg2UhME/ifT39vqDCHqni1MXCLW6vn/IZWof/iHPJCdHIRob0ldnAiGNfD
	k6buptfMNFj/xLJF+9Wcg==
X-ME-Sender: <xms:6LqyalHESznQplFV479Cz90rP1K6EWrd00hMLS8_l5PmxEslfUT4Hg>
    <xme:6LqyalIw3ovnINwiW3qoO5FgXkrm8AdCG-AHRlw-mzWmwBqfL367vv8cCZPZ9BJYt
    pL_Y5rmjQk_VdvMswGmNxHW9UT3Yy0qnJrDiu1-LIh7UEay7wnqftbI>
X-ME-Proxy-Cause: dmFkZTGrgKU1K1Fms1e0Iz+qWUb267yIf1P3GMeglKx7fTpR1GDVFzSYc1d4P5/ZNYTzPy
    PkPpKeSNk7/eX7Ur3tca7BOfjOtFJRcJijDNl3+zXekfN2E68Gl+6uYLzdwwBtuheqYk+O
    kdNVX2Cgcmt5S+oFV8bWX8ZzSiv/7uRisOD1k3GPLo0vAjAyBU+be2GUAdVsGDV+llf3dH
    yQQwATv82dX7ZF9iq/EB3rDNsYOQL+DjL3lnTOzRSUE3qYxTAtihkjl5B2iztWFGrWi9Ia
    xIZUgTy5KV/6hQM7tyyez1f7tdxauCgG7J0jHHte6VK0xO5GPIBk8g1pYrO+XQpLYVWdSk
    7yM/eEqZmpX9P/C4bM8vTPbY2g+QFxOj97Ed2YI5TaAL6sNxkrf+3L4K6XEbdZTMueZFoe
    Aun2h1fIbmY3jOVyn9A7n9O2WuZ0n9kU1IfK8GXP8PbHUHsq1O3mzpbQQ5B0oWLINffkAD
    km0ME+xwlsx20wzCqemaPkCyRKPIXdpSlmzXMpWSVKK/pAFmkBibfrfoRLDD8vqMi+FUlk
    Iututxu5C9gH/Ax0bnNKzwZb96uDFb4wMTi7oJgmMvOa2/VoIVgs5pK6F+rnZQ4NbL+IRs
    yxnusZ05t9ZeBxMGvp/ViNq+g8DsCyOu99Jax79A1NKUESLv32eZkJdCT54g
X-ME-Proxy: <xmx:6LqyamXmm_yHjFK5qQV0I8dXHo0qLIrS7cSdqHVYGU-qxaU4AtXYFA>
    <xmx:6LqyatDkFGR11_9TFBQH3hMjrTpcdvPLpQwKxnwsFHJ_MCwZXKzfgg>
    <xmx:6Lqyah7LogQRonVpttgVCVz9EjpkS_puK4irYMUGntlT4kNcM8YuzA>
    <xmx:6Lqyak2RZfzpk3qBvf_pfMlPBUJClLJjM4_m7aZlwvhi4WBaxaW9NA>
    <xmx:6bqyauiqVrqpWa4CqPnCnGNeH9ed1FgvcFe68TEH2DzVlasfFr-YTQd9>
Feedback-ID: ia6364811:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 758512CC0083; Tue, 22 Sep 2026 13:29:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 12:26:59 -0500
From: "Grant King" <gking@serow.io>
To: "Sasha Levin" <sashal@kernel.org>
Cc: "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>,
 linux-input <linux-input@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Linux Stable" <stable@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Antheas Kapenekakis" <lkml@antheas.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jann Horn" <jannh@google.com>
Message-Id: <4a7814ba-5c50-4c03-b998-2bd83d5011ce@slotpi16m74>
In-Reply-To: 
 <2026-09-22-daily-reply-0005-re-hid-asus-nkey-regression-report@kernel.org>
References: <069bd866-4eb0-4c42-bcf4-6983ba59aa49@slotpi16m74>
 <2026-09-22-daily-reply-0005-re-hid-asus-nkey-regression-report@kernel.org>
Subject: Re: [REGRESSION 6.18.48 -> 6.18.49] hid-asus: ROG N-Key keyboard dead, also in
 6.12.y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I can confirm the keyboard comes back on my GA403UV with e82ae34af29e on top of vanilla 6.18.49.

Tested-by: Grant King <gking@serow.io>

Grant

On 2026-09-22T11:38:58-04:00, Sasha Levin wrote:
> >  If you can confirm the keyboard comes back on the GA403UV with that commit on top of 6.18.49, I would like to have that before it goes out. -- Thanks, Sasha
