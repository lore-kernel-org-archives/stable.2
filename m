Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081044;
	b=SdxKQGsIzAcd7rTAdAok8kx8K5Gn2eE1xZQRMxDXsODmWpWmkVxFvU7in+G+X1vD782O
	 kTsnRQbbfCoQx/esCzY5ZroHfOTuXdzb2LIyQb1Qk0FBMlIl2+8STTT4uYR9swLq2LN9U
	 tmoHASDXKHXQayx2N9QC02TA0TYcwNOVR62QqP/HILmsDOW+uTfHNCX2uk1CGoannP5+n
	 y/HfPA/U6txW+tSCrJ1op3YHnEZC0rX1tGOs9zq0AG6G34lwLf4r4hdJzDHdD5wJk1/Y3
	 8FSzrCv3zB/qbcOiOqCQ9wXWtraTBkjkYoORjpyTXyl6DwcZdDbNIRyznUWyBytpvbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081044;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t4OoGf5gHVzRGe+YIjw2VuUWKRz8U6K0v5JtauIuYFg=;
	b=QAZvEYU1M3w/BReeGzi0ytLVIqvCz3K76Nk6ODcXq5tEzqsGooNlFel4M7tXo+CSS04a
	 xAXv3IQ17PvDb8JMyBuxA0E+uOtGXCA92CdbZaQ8afzDoprIF3VznbEzTWLv+OsDBvpXX
	 etjrqTdIiyocVP6OQGtEtegaGcpVu8jnf2PRCLIlN+bqKJnCP2SZkICJUf6N51QJWP/GI
	 tB8P/Ka2vdtO4sCPXVVc7jwVdDwz8tgJkXR+8rrewhICkMWXOytO7Nv0OaVcuXtgLB8C4
	 dKsqG9MV+xHyuWGONCT7TeGaTWE4ZfZXn+ajXJTttdQFNl3FpSXhgrjv0YSMELSmsDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=pBmbRuK+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IlFiGdCd;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E8606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=pBmbRuK+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IlFiGdCd
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id F2748138033D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:04:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 02:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793081042; x=1793088242; bh=t4OoGf5gHV
	zRGe+YIjw2VuUWKRz8U6K0v5JtauIuYFg=; b=pBmbRuK+RpEV9BFZTEEED1+xQn
	QxhzwuWaStp0492F1sZlJfdb5JrjYSCV+2NYVAHtlzBHez2rPZGHA5hVzwPIReU0
	PBLDTVnFMvFnxG1AZV9TRR631wBSiqcqUraFNCcatQe9H7+KVdS43vEmJH/IjCmZ
	segcD9NSUwmMGgDgk0RzIRq1Us9+nZTxJ0pFEN1sxF7h3bL+Bw1xd8n/uaYXPqT9
	omVT04BOGkvrKu/VnhPQ53HphPOrrlfa05snlpXQQp269jbsx/ijs+qitlvwPu6v
	F2n5RJVA4zJ0ZAEuGcZEt+cqQuYI7ADvrfw/g+X2wZ5uWhG6ftAzAbq5zRbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793081042; x=1793088242; bh=t4OoGf5gHVzRGe+YIjw2VuUWKRz8U6K0v5J
	tauIuYFg=; b=IlFiGdCdCTlmZWowaWNwwI5su5BcJsv/nw1U199AnPalMMXClCC
	JvQIFOWvHlwMeYSvzJeOZZNcO6ZOGMDS25kTmYL800KodK7FH7fXwEuIT+uX4V7U
	rVAQJ1AI5ksxoeIKCUgIxYxR8UJl8LQcz+oKvB4Es9pUur6G/j4u+wGDaQ1FW4kf
	EiGZ3QNVlV2cyobajY0wEQB0cShOsgRHkbLUcui1oCyGlZ1g69kIaweh5EMX1/31
	GdcCyGXRf59NPD098Nf3wePdwDKNi7p632hU9F/LXKuawSkV58au96Lo6rjtFo5f
	AGh6URukYmKewPtpVJ3Nkg5aikN4j5BEOeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793081042; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VbsGGBqSlaTJZXpzLkYp3nFPlzanySPyz2q/l1AppTCC5he
	P5Ihn/gv1gIuAs4ynQkyyv+mDXEOJVaF1ixJr08gVacjr3/OmrxvBCkApDJfY+YV
	UgqI+ykLZfxNkyWPSeu2evPj5HqX5UNm8l+Ff4+YMJALKR5nxxvDkNU/eNn5vHEe
	/tLZyUz7V2ewox25sZyi4m5dVVTkdLz9PpnhyattlauTtJZtOT6Md9m8sfnX9sJ5
	NdFUdqqjgCfbls4vJPPQstXQjQqQWoQO1BquhaPSKXzxMBHBL3I5QLtVrtwc1lCF
	EEwB/VKOy2lC4tEWypRR/6/DCDHhSZxVXFsksSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zoLwu0ba4hLP136iUKXuQNMXsdfdA3aYEIrrMD0JcHQ=:0fCBaab8hkFDDaJ/Ih1bLvqwAABT2NnP0tQ4AAZGSwY=;
X-ME-Sender: <xms:0j7gampYv-Qepawltb_5zxAQ7r1uchBwfZZimwmO733hKQn8Cbz_mQ>
    <xme:0j7gamToaNKCO405c8j4qnNn8oDC9GcI-bmt-9T68gkY2hk1SFn2qmEzyCKYevmlZ
    B57DUNMtjkDDojoSiv0dO8sbVIz2ttKdhs0T9HRTjl-WiQEqg>
X-ME-Received: <xmr:0j7gavSvZjItNm52khlx_AHH4858akhyDGWcKxwdSjhzRE-p8KbOwE2JDov5Gs8y6phc24nFABEsjebIymvUVEGZBPD73h9Tp26QQ698qbc>
X-ME-Proxy-Cause: dmFkZTFX46FHV+PvV6KGDcfkleNK34N2X9H1Al5LrxAe53ONFm9S0IjeeWDzhKxG8Shv+2
    2Sn379VUd+VqaQMqSNIr0RXE0+SOVRfM/Gx63Qebrl2PemtKwduXbWRECrBTGBGfJrULBQ
    YffivZZeuaqa6DZI7pcpaDtiOVdw5kIrTCL6r+s1lX0EQtvi5KXdkVtZXgpLmiCeQhkyo5
    0RBDkNxGhRvHg45S2izMhkaFcV0863KLldUCedNcqH3+jgrZBCN9SeN2y6dCFRcMN42C1t
    u00FOS5PhnGCWh3LVzWtg7Y9UnqD1Eeh27e8Hg6l3YKmlHNF7H1Kh+vihbmSX9fAbHYDo0
    vqvwH4vETUN8Zr4DxgJ4QOvXhjERnzK77P9A+IdCgjx+wiWLtKkc6LZFFD5Bs6Z1sqZuVz
    ckKV1E0wb9arx8YX8MtEsQsRkZeuM118FdGNbvrDBaRqe0x0rhL+VYYeX+8ZFBGdMjUawJ
    tKIyqkzcz7czfyfY6rW9sNJyuz8PObfbf9f+DG/Wm/50xB7NDGRNqMS0hrstNZ3Z4TQGvn
    In1zUasPgunc5Wwdo3htDug2OGygn9eWE+LyMfxwElu7DqFy//jpxmpCS/DqHVPA/Mtm6Q
    rFKbHh41mZeRGHIV2EfmG7gi/NY8DRdJ/daoTWFCIqbRlpCr+MY0uSnnyS8A
X-ME-Proxy: <xmx:0j7gasXJz0oNMX2i5_bjE9RmmTYq1qyKsyja06RKL9Hq3lr_R_tPSQ>
    <xmx:0j7gak2DVi_NcPVHQg6hlEYpymXWNP0b7tuqiwndvmNWu3vC3cUm_g>
    <xmx:0j7gaj8JGrWmpkvDmF71-9Qhk9DLNlB9oR-l6Rg1izzFGDRuZ_9BHw>
    <xmx:0j7gaqeapAAVpdYV6w0VCFpM8W2Hnjk4hM-u81q3-PiIB6n2GiqYyg>
    <xmx:0j7gahODWA6oPkTa3xcC561pcBpZh3fFk_WjMo6To3dGYrlK1o2PazpU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:04:01 -0400 (EDT)
Date: Tue, 27 Oct 2026 07:04:00 +0100
From: Greg KH <greg@kroah.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>, Ivo van Doorn <ivdoorn@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: Re: [PATCH v2 wireless 0/3] wifi: replace open-coded IE searches
 with cfg80211_find_ie()
Message-ID: <2026102756-geometric-swept-9e61@gregkh>
References: <20261026223153.2087218-1-tristan@talencesecurity.com>
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
In-Reply-To: <20261026223153.2087218-1-tristan@talencesecurity.com>

On Mon, Oct 26, 2026 at 10:31:52PM +0000, Tristan Madani wrote:
> Three wireless drivers (carl9170, rt2x00, p54) each hand-roll their own
> TIM IE search function.  Replace them with cfg80211_find_ie(), which
> already provides a correct and well-tested IE search.
> 
> Changes in v2:
>   - Replace the entire open-coded functions with cfg80211_find_ie()
>     instead of only tightening the loop condition, per Johannes Berg.
>   - Add pre-subtraction length guards in p54 to prevent unsigned
>     underflow on truncated beacon frames.
> 
> Tristan Madani (3):
>   wifi: carl9170: replace open-coded IE search with cfg80211_find_ie()
>   wifi: rt2x00: replace open-coded IE search with cfg80211_find_ie()
>   wifi: p54: replace open-coded IE search with cfg80211_find_ie()
> 
>  drivers/net/wireless/ath/carl9170/rx.c        | 27 ++++-------------
>  drivers/net/wireless/intersil/p54/lmac.h      |  3 --
>  drivers/net/wireless/intersil/p54/main.c      | 30 +++++--------------
>  drivers/net/wireless/intersil/p54/txrx.c      | 12 ++++++--
>  .../net/wireless/ralink/rt2x00/rt2x00dev.c    | 30 +++++--------------
>  5 files changed, 29 insertions(+), 73 deletions(-)
> 
> -- 
> 2.47.3
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
