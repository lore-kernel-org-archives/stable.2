Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795108039;
	b=NqRHJwUb5jy+PxbUx61/i8LJeTR8CEalpTj4YZSGN4IYg7+HZlcwIHObflL/3tuFwSxA
	 bG7e/asjQA9DOC+u/hoVCzUw7ULWp1Vv2ZcLg/d0cLLsQE+BeyPB/azBivmkq/PzU50VK
	 RqEB1ED1kZvg7dwd62U/RJz0Z+4VOnuwkYanT+w6vQGDGUgPImtEYucRHbbRhQXEcDmM9
	 cn8TysPsN2vtMnbkcJFkh/Fry6r1q974GY2DO9ZK8sV6I725jf2L9mBWx/IVyGbzIA9v5
	 GYoeSyQXmglmONSc6e5CZ9cx0zHRfUIxdwq/uaHKO6rR70GrYvlqDi8wMoA9Y8qK6aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z9rjfp/okberZ5UU9lPDDwdQHhMlVJDqMJwqhBEnUcg=;
	b=bZgZy+Kh5MRRN6oYSPmoKKlv4Ccf1/bp8FYwmqJKYDPiYVSf2ieVkVCZh5ujABEsV6Sg
	 NL5TwNCTRKFv/AeOWquKzhRLvS6DRP9ghQhi6sNoFZTnGzdUEYXVeObqlaVSz5rSuEDmj
	 KCtF/VZTTvIPplQvS4xCZ78TwQBXaZhNPgLodZCQqLkQzBfs6FVbV1lnvDvbieoTIxY2k
	 efjvYN+qDzX1Yvf4P7bch/ROAsBaW2K1kRZAqN2pxdJAk4H+LgzP2BAKqixB6qFhhHVa0
	 Z+tG6ocU9wVC5DPxnLvce0N+usPPsTGZH8Cdj5H5LnkO15sYWbXtaF83nxlsNA0jKFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wRLpe/hA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21860A2618
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E21860A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRLpe/hA
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so243978666b.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:07:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795108036; cv=none;
        d=google.com; s=arc-20260327;
        b=JuO2pDSeXGhhTBj5Aj12ond6MH86x5KbM7hQPCwWM9w+j9yHshZs2Ipc5RYYElIfmw
         CVBhHgJMxwacEGz8IMOFZoYmi3uZYgbWJZAJawkVGdQvn8NtZEqV4D6+A9PSc+AGzur7
         /KkRWB6q5MzrXFIFulwv0UEr/vt/xrY7+Icrpjv+irEVtKoySvR/zxn0F0H0O09cwXHQ
         TeXBbp0tPGjJfbXuAtpzbhIchgX0Yxt2fV3+yCsPd5b0kOpmi7ti3X0R/uULKpTeFvR7
         wFZLY5Ys1cHmxuQ6U8Lu0k39pd/5rdazMnZOtCeX9hJRgIgEcVAaK1edzGS34D/7kghZ
         YPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9rjfp/okberZ5UU9lPDDwdQHhMlVJDqMJwqhBEnUcg=;
        fh=CLx0K2LYEx82fxAiWVDZ2Oq8gr/o6Y8QCIsGO1dd5Kc=;
        b=GS3ltaeTA5hyn6jV01TMnHZKoyj1Rb5pbDUPZiy1COlXsV9YS6MQ2ZizEqJm8bYRm2
         FyMgqQc6nsM1VxotMNRR31yrZy5l85mRLX8yg+aJknuYYsTy6/x1X25npG1QXCCCmazX
         W7+6Yq/cBmjl3BuyKZnDoew9oirnqhbVJzfXk8lqJTZpr5r0Ve5mylieHAgeowm7Sfns
         suICQn11Pm+b/qZ42AV06jAkA9qEvR4aYtIthncV6zg3Dlr5Vgo/wjR5F/eoMgKwbL3y
         S7OKO78Uz8xjD2Wo7pM4vPmalRnL4aEH0gHuzabe2/y2ln3uglcksMOkCzXJ+kHwHKSc
         JK4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108036; x=1795712836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z9rjfp/okberZ5UU9lPDDwdQHhMlVJDqMJwqhBEnUcg=;
        b=wRLpe/hAAlQfJy2zz9jkXgo+e2IgHoHG7qcMY8CynhTQitdmTngCVmNATKq/DW2K+M
         XSn6cEE4E+4tioV9Jf7WaUweYgmRO+9aVBgwneYN1nTNROateHYH4yj66SlOmuDqT/no
         A8J+CydLa1+2cRL+XG8ACF+7ajxTjIc83kpd5uLpcbfuA0voT7bqnkpeLee/CD2OTKmm
         YxCwTPxZ4OmRr6tRwtbAhmW2yFM9aVQnn7a/ne8AHLuiT75e0BSu5OwwuQ493t0fZEHs
         yKdrqdkkVaUwhNyvK35zHtcnJEqEAM272ZL627oeLeSV+iUr/YnUFrE7cLsiLir/Qdvl
         tEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108036; x=1795712836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9rjfp/okberZ5UU9lPDDwdQHhMlVJDqMJwqhBEnUcg=;
        b=RBI8hhCWWoCsvyfn8e4Nt1S1eb4rdB3tTbZpzWl61dV0I1GmRx+c90FlIY4RsXjB+2
         +RBHv+3BUMRS3RipQyyVn5YqVr6+3z+/h9lUcgnnIX+0bO4O+nKxoTMf6kFTyrDpeeHD
         D7lU/mYrJ3L+v9qbKo4AzWa3Vwa1bC8FQxJ8iKxAdeeZosKrrJuZCIJ7qOkajxyp/zDN
         IuPmLCD/J0wv4qVu+8IX5kkukVPc9vkD7OKsf8qx/a3fTlfF0UEfuiwAKRt3r74tAo++
         kQlC8cBcjQe+FIVSWBWp64vokCDAAlhfhoi+JWX01ayaUNwL8cdlUjlVmXkY+2ECOJUb
         KodQ==
X-Forwarded-Encrypted: i=1; AL+hErEPMceyt+2vvT4jhxAiqjjcIm7WI+CMLDQShIlVc8sO0vr6xCgmR+bk9GQrPDNXKgkxRUBIP38=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uQq6IEuuIIp6EzppsjsKQF24HTYP/XBXrCRyaK1kOK/zcDV/D
	8kHhhguLGpaow795qFR36Sn0zfbHZiluYMpVex43/Xel6esI46Tp9mbQxZ4Z3p3ob7/p5/qTo15
	UzA5a4+3ia26Wp0sqw4P6U/PTftYhoPc=
X-Gm-Gg: AYBFou0TEtzNgLEMQQe8fN71pTwLOWg8UX47zD3JVaOSsd3z0E5cjT8rLmr6bvRdmkn
	DqkqOCtgUgpdSS9+1zrAqv+9Y2DD3eAG4RU12zJe3dQwMH4QeUZ19kTo+V7E0PY51W10J4gJoeJ
	pDO76LyO2wRID/Vgob3ojjlxhO2CcYo99VGSQNRGeaBM91QphnspuLG5rlaBXuJ36NoLg2yHh68
	dgx8p973Xbgn20rQUeme2ePTlQk33MBGvXwwO893LSEb/FbQgjZZM+fXNCu9a0W68ZGyFtHbuZf
	jXkguCOR96FDUJW+5ysi9c9qgbU+xrEYaKr4/H8evnHeXJrHNX5quVPCSBUtZ48CBGfFp3RCiIw
	RL6JYdSzsWMxGHIUXSlBuY8Eu0PfGkQQq9RP7idob9kYRwQnq/mhVXLh05SKEe4LYpAb7XKVd2Y
	vwyiOWVG5Xx4N1qa0TudpzBK/V7qiokkqpZxQrgIxKHknME/+nL1sRJ57efXILgWfp6t9Ajmzbx
	1bo0+tIhxAigoWn1AzklOtNSQvMi5skCJU/pnjtjw6TkHrEg2M=
X-Received: by 2002:a17:907:968c:b0:c51:205e:6e8e with SMTP id
 a640c23a62f3a-c51319b6e77mr189422866b.24.1795108036207; Thu, 19 Nov 2026
 09:07:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-6-f8e7fe60594c@gmail.com> <av8mu_ZFxNKSgFTK@SMW015318>
In-Reply-To: <av8mu_ZFxNKSgFTK@SMW015318>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 10:07:00 -0700
X-Gm-Features: AclHuK9wBfnKNfQrHKAEZR21ICySZpM18zy-as-MrTLPIUB6oIUYW_Q6FeHZQ-4
Message-ID: <CADvTj4oMoeiqsnLaojc0G-P0twOqUqO-rhGUh5aJcbt7wuhYxw@mail.gmail.com>
Subject: Re: [PATCH v8 6/9] dmaengine: dw-axi-dmac: retain descriptors until
 callbacks drain
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Sergey Khimich <serghox@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sia Jee Heng <jee.heng.sia@intel.com>, 
	Baruch Siach <baruch@tkos.co.il>, Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang YuWei <1973615295@qq.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:41=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Thu, Nov 19, 2026 at 09:01:01AM -0700, James Hilliard wrote:
> > Termination frees every descriptor while a pending period callback can
> > still refer to one through vc->cyclic. An executing callback has alread=
y
> > cleared that pointer, but still receives a pointer to the descriptor's
> > tx_result and can use it after termination frees the descriptor.
> >
> > An error interrupt can also move the cyclic descriptor to desc_complete=
d
> > before termination. Looking only at the head of desc_issued therefore
> > does not cover every pending cyclic callback.
> >
> > Use vchan_terminate_all() after stopping the channel to clear the pendi=
ng
> > alias and move the collected descriptors to desc_terminated. The existi=
ng
> > synchronize callback drains the tasklet before reclaiming that list.
> > Descriptors already detached onto the tasklet's private completed list
> > remain owned by the tasklet. Repeated termination preserves the retired
> > list, including when called from a completion callback.
> >
> > Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cy=
clic()")
> > Reported-by: Wang YuWei <1973615295@qq.com>
> > Link: https://lore.kernel.org/r/tencent_C00D995A9F70206DFD1330DCB1222EE=
BCB07@qq.com/
> > Reported-by: Mitch Barnett <mitch@accuratesound.ca>
> > Cc: Wang YuWei <1973615295@qq.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/d=
ma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 99b648d4ca76..2547f9596ae6 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -1202,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan=
 *dchan)
> >  {
> >       struct axi_dma_chan *chan =3D dchan_to_axi_dma_chan(dchan);
> >       int ret;
> > -     LIST_HEAD(head);
> >
> >       scoped_guard(spinlock_irqsave, &chan->vc.lock) {
> >               bool enabled;
> > @@ -1219,7 +1218,7 @@ static int dma_chan_terminate_all(struct dma_chan=
 *dchan)
> >               if (chan->direction =3D=3D DMA_MEM_TO_DEV)
> >                       dw_axi_dma_set_byte_halfword(chan, false);
> >
> > -             vchan_get_all_descriptors(&chan->vc, &head);
> > +             vchan_terminate_all(&chan->vc);
>
> I have not found this function, Any dependence I missed?

vchan_terminate_all() is added by patch 1/3 of the sun4i DMA series
[0], which v8 lists as a prerequisite.

>
> And keep allocate_queue when terminate,
>
> https://lore.kernel.org/dmaengine/20261104-dma40-fixes-v1-1-48c5180f5210@=
kernel.org/
>
> Look like we new APIs to distingiush terminate_all() and free channel.
>
> when free channel, need clean alloc queue, but termiate_all() should be
> keep alloc queue.
>
> terminate should means terminate all DMA engine own's queue, before
> submit, desc should be own by consumer.

I checked the helper, and it does take desc_allocated along with the
submitted descriptors. That means a client can prepare a descriptor,
terminate earlier work on the same channel, and lose the descriptor
before it has submitted it.

Termination should leave desc_allocated alone. The channel resource
cleanup path still needs to collect that list. This distinction belongs
in the virt-dma helper rather than in the DW AXI caller.

[0] https://lore.kernel.org/r/20261115-submit-sun4i-dma-callback-lifetime-v=
1-v2-1-fb7d258702f8@gmail.com/

>
> Frank
>
> >
> >               axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> >               chan->desc =3D NULL;
> > @@ -1234,8 +1233,6 @@ static int dma_chan_terminate_all(struct dma_chan=
 *dchan)
> >               return ret;
> >       }
> >
> > -     vchan_dma_desc_free_list(&chan->vc, &head);
> > -
> >       dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_=
name(chan));
> >
> >       return 0;
> >
> > --
> > 2.53.0
> >
