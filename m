Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829B37DE98;
	Wed,  9 Sep 2026 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990952; cv=none; b=Qco67Usx8kZPeFxioCG4Lny78FAgXB3neyc6lDdHpeSdCtElCxEfKsbbe8oBAcEzx5sOQX0uwwPlSJfWOyg6hwKxDSUCUkQgDhXfLSc3BRKXJS7xYzTRnaaA9DgRKt3yZOF8B6HA/yVPnyhrl5emutexy1NWQjSbg2gZJpO7U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990952; c=relaxed/simple;
	bh=WNvfI80uxTVeUrnoBu6fXotJGMQ7lem37/0Mxc25Yr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lubMc22zJfgdT9hXO383XfH4INxijA7WkJhha1ipWdFwdrWAD40mamOXwemAlclboeATp+8Hof8c6xWGBiS++YCoNjShibFCrPUwTdVcIu1OmpHlWr2iMXb9BROSinXp2iZJyMyItnyum+EOXj7xaNtpJaKXrUeDPv2p3RBK+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=JhV8iheC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPxIPKJY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="JhV8iheC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPxIPKJY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A98061D0008B;
	Wed,  9 Sep 2026 17:55:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 17:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1788990945; x=
	1789077345; bh=CkqDikOvmpFfv4y915Gn5kUk8zQmpb8qmUsV8aap1KA=; b=J
	hV8iheCsqGOiGxAq5+ubsu0LCG8z0016kfvqAIZ6JAGTFhFx/+ngVLAZj25S7P16
	eF9WSgkJJ73gL6uS7Td/HUX9mo9NnvCLBAHQB3PF33HSbWMCK5h7zOB8x5BKo2I3
	VGIcm1BmCiNXgYuCdf1+5Fokq7GTAXNw8RnwM1ZtqLzm3UNwiMHJVk6vaTVZ97xE
	nA1NHMF48ag8D52MFoa1dgvyqdgU0W7FLS70zUyx2f2ES7HNJX2ZNZf5cLwINIvp
	NdI13tkfiL+n0FdtY2g6biKtvISWjze4999M2OQeCpUzNPqvYfZzV5NiSrViNm2j
	rNYdKLYvgxVfsw+VGVskw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788990945; x=1789077345; bh=CkqDikOvmpFfv4y915Gn5kUk8zQmpb8qmUs
	V8aap1KA=; b=HPxIPKJYMLVxCqOslUAHS/s6D8cIoiYNsoRe1hsHBMWI2/xdjvQ
	CDgRCUnmhueeNPPT1TXHcE1uCm6DZzHPgF3FDlPV6PpHlZJ2pf9nmPrYMwgfw+yO
	7odrF+dWH1RE5fXupDcO58i+XZ2x6KvMVA9koofNzeqrhaTsEAS+I7QnbCeukHT+
	1jROeA9Cv+gg/zNRim76U25JQGC36aekAWE7YBaW8+ZO2/dt9nQ3gHunaU07RkHB
	9owt7cjjKYmC7kE03OTMjXDJB7BviojaludFXV7aEu320aVpiJGqoZoFm2TF0mHl
	36069fe2AqGKuryPCMQ0dlP+BVIl/By8IaQ==
X-ME-Sender: <xms:4dWhakIX7-MXW99KWlyj3IXrdmbw4lgLagQPSftx-jWlxUCMJ48vpQ>
    <xme:4dWhakS0G5PzO9mVhtpxYCFo17i55CQP-0xllz46wNrSCzkNsLJapb1PuuccHwbzX
    KyHoVXorGtcfBcSJ8MRoKRe_7SCTHg2QZuDj9eHRZsDf7jiqT7jofY1>
X-ME-Received: <xmr:4dWhasriQxvOvBRFzneENiV7YJUUYEOOAFz0CV-RTNmIPKobqieyhD_9Ts5MxYw8UO8k2gnf0LsfvMjucr9apEdTdiWFXQ>
X-ME-Proxy-Cause: dmFkZTF3FcRzDKud6NDYkeS9wCndHjIGzvV3w4z6pZI7+hEgUCysoYXAgO4lEhLp2sYFOG
    PnYfQ9Tz9KBpDT/FZgJHObsgWpsAgC6TovrhG0pcTM5dZtTFsUG4ZlCEhMN0gwiLDodz/R
    joZz9HuhUIwHunVfSVlsCCNfC1+Mvpgw8le/gvVUY5tqVuxpkVQfvzUjFkVZLLbeCpsQWz
    uxbuVFsZgqk+em88Y1t6l8oq+Es5mjnh4eGI/eLSQxPDxY/ypx466VOR4U0eUhVEshjweX
    aLKwAqaP0r7klDQxNMMwDdo5tU1Iawdhs8INISa3n76r8V0EvvX++1djRn8M82hlQaRYPD
    jQqGFTRgEcdTmkosRRuLcCbSLhl7G97c1bvZewp2DY+5b4Su4R32YBBv578sf5dAFhqQKF
    DFa3IstfdcmbFBvU7h8rW0XZzqk5KT4icXnaT8NMrhLNDmz9pHeg0m7/Tf7StogePT0V+M
    qG7NknwKg1bsi+b1njm8IDB9+F4CrU74shrYv4LoCZOviDjryYqtLnbGMnnMAGdPTqRHLD
    pY23+b8HpakhhSq6b83UvEOoUXkKjt3yfAyMHh/0HStgNY4UG6/YxzzimJ4+XZYgNfHxrq
    OyxJv7St8iOG9JBG9LBYGcOLQ2YP5oCDC61CSJv9siKKoQsypPsnQmUJZxOQ
X-ME-Proxy: <xmx:4dWhaprMDzsleWEH1N_8cLT7WdVU0UehEZU93Wuu_PEnWsgDlODOpg>
    <xmx:4dWhamOHbu9Q-uIQJDcYz7Yb5HdsgSg7oNV0eLy1jTPUc4a1NEeNEw>
    <xmx:4dWhaiylFsIJcbMluggqWN7L7Cr2hkqHNNJnEwM4UqGbEcpkqBCtSQ>
    <xmx:4dWhansR2xWCOF0xZJBu4vfjat6sIXSiuuqGEdfR8v1G8UsBoVpnxw>
    <xmx:4dWhagM90KibvvqiT0iOuTJ_65uCi0HCLBEtfZgebbF1Mnalnj_NhbdS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 17:55:44 -0400 (EDT)
Date: Thu, 10 Sep 2026 06:55:42 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix source bus ID detection for AT
 context in big-endian systems
Message-ID: <20260909215542.GC2981831@sakamocchi.jp>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260908122840.2886621-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908122840.2886621-1-o-takashi@sakamocchi.jp>

Hi,

On Tue, Sep 08, 2026 at 09:28:40PM +0900, Takashi Sakamoto wrote:
> The source bus ID bit in AT DMA context is not detected correctly on
> big-endian systems because the little-endian data is not converted to
> CPU endianness.
> 
> Fix the bug. The helper functions related to this are never used in
> driver code, so extend the test to check the field instead.
> 
> Cc: stable@vger.kernel.org # v6.12
> Fixes: 8db9d1557122 ("firewire: ohci: add static inline functions to serialize/deserialize data of AT DMA")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci-serdes-test.c | 4 ++--
>  drivers/firewire/ohci.h             | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto
