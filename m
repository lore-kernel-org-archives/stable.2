Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041ED286AC
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886213; cv=none; b=CMkkyvRgipv2fU/2S+6TCdTfPXxBmaT8SFuo5YTR68MS3dyS2kTWt9Hj+fYhqKSATUzg/3VyAkRzLIHV4jc/JC9aaew6Cde+y5OJhyO5EV5wIFkyb1eErgQ3ezdoEKrUSlhOqUHm3P4jQ7osk8rL4L9UHY2LCwFum9UXw5h1aTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886213; c=relaxed/simple;
	bh=hKjcfysmqpwkfoKcmOZNV4zNNLgROO+mCygL3RPRE0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtgNYxEp5I+0zQatzSIBjMXIFuYmo3ZMoWwdKtLqLX6gOBawRnk7DSrded0d8550CSV1Al/VZRbcCkWNkILYckIohaGrnYTxenPttHClh5Evlg2y4rvhy8GsRonlqiRXvsymbBYFZGAS6miuKMeu6rXf4tv1iDbRTYQi3/cvQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=uIiGQS0l; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="uIiGQS0l"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8525efa7274so533895b3a.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787886211; x=1788491011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/6wjXJ5t2JcwV8iIbOzHQwgonuJXRvuDvZRhLDazjw=;
        b=uIiGQS0lCLCPCmusn0yZEF3h+v8Pn1tC5GSproN6glBsYySEbAvYPsHTnVkbIfdFXK
         EGWx4lb5Sai+vK/nEu0GJ7P5IoLkD//xpGRIFPpGC8ZCrBguyUQGZnvJS48Ym+JxgBM7
         ZmTSYkBoH9XZmH7T5O5NSWfrfBQJcUBw+3ZD1IlYUg53yv/Cst0G7p5upLLQp9q7872J
         vNTO+5VMUz/mo1/y3WGKVWhawpOkAMM2oupWtZVc7ZG9EhnXocLxjaew5AbMzdYP2ONf
         JgjoJnd5SjqSM9IaAgrNd3BDDx9ZhUZMNfAQSfwUCLa1SEJQCvdVb7icPdkjVUMx1ZTV
         uPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886211; x=1788491011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S/6wjXJ5t2JcwV8iIbOzHQwgonuJXRvuDvZRhLDazjw=;
        b=ca0lt36WGcMzmub00kEBVGaxifpHhmyVMYbKrH6dDReDFZrbTwLey2qhMcYlcWQXap
         TCUDWZZv8SXAsU+rYcDDRLK6oJ0kR5LwMEG9j19cD1+CcTMtYJTnXVcpvCg8iJGQ8BYp
         k3NpEBq8Cp5rMiF50rfRuKSsmXk5WOks/8GrYkGHGfSPGw7pHxA8viAd5HVgAoClA01C
         wHghbJfgZs33WpvSACs4eYf+eS/iuQE51LI8YZrdMRnIsraI33+YmmSJKbRLAtdlzuOr
         cssZkeQyg838Mnh0C18LQG9jQfNZrgaIHokrPCXTVJ5IeN5wC1SgoxAFmb+4/hMCAavB
         4cmQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1xrfEpDXwiMhl1gnlGDgm2uxC9QtjbxlrhBaycBbJxUFYB3jy8W0UR1qAWZrM561rV6Q/7Tw=@vger.kernel.org
X-Gm-Message-State: AFuF++mNyZwDgQ+GrvQFQZYfV1n8CJDZFeXgL7US/5cJ4FXn/f2EuIhY
	x8SuvUiiyiqIHeJl2z2b8XJ6mBo715hG658DM7ffCXBCO5mnYo7Ab0FooPFiyDBN068=
X-Gm-Gg: AR+sD13LKABCaP317D+OXRFVl0bT4pLXYuzW2UiQT1NEPTvhcTMM27YMvmVJvdzzXS+
	A7c9fiMei6V8rRxnjR4IsOQ9K24WwnuAk1hyksJ85KkkKL3vMcy/eA6hj6YF/KWdw/2KSptNDTd
	WeqCCq3NKz1jIiGvucLo98NoDy2HQdGLgm+SpSOJ9e8JOAd2xqIvMQg6NYQEeyD0f0JFMHS2Zd0
	aQnz+YmuMdzCaZa9qsiHDJDZpY49aopv3SwmYWeHrDlqJwOodgrsy6RxPIMeBz1YT59Rv5Txcta
	15SG7yvpsgxlWCWUw8ZPrzrpRSSfdvfeJYUCuCLLnwv3UNIeiJ1CMYxU9RuDeBDIV+1jdSXirSm
	3VfLITL5tKqf6XmW5QW6LSGoiPq4/nNksXBUi/nXFTAjjuX5BWP0M9pAeMdI/kK+Y8+x+FvnbGq
	71MkpDVBCGhv3xFLFVZIDbGl2VIQdfkgcN4gSO18qJxwUfvOQwzzsU
X-Received: by 2002:a05:6a00:4210:b0:853:59ed:5539 with SMTP id d2e1a72fcca58-8562aeacd01mr7858899b3a.16.1787886209642;
        Thu, 27 Aug 2026 20:03:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569fa7d94fsm137211b3a.17.2026.08.27.20.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:03:28 -0700 (PDT)
Date: Thu, 27 Aug 2026 20:03:27 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v3] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apD6fwM7beKVGz++@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260827185700.2157164-1-joe@dama.to>
 <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>
 <apDLEbEu1PLTGU+f@devvm20253.cco0.facebook.com>
 <CACKFLinQHs80MQbn8o8Fw3Qg=1DJ+7ZMevPkDzxnDr+mNX=SfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinQHs80MQbn8o8Fw3Qg=1DJ+7ZMevPkDzxnDr+mNX=SfQ@mail.gmail.com>

On Thu, Aug 27, 2026 at 05:00:29PM -0700, Michael Chan wrote:
> On Thu, Aug 27, 2026 at 4:41 PM Joe Damato <joe@dama.to> wrote:
> >
> > On Thu, Aug 27, 2026 at 04:07:16PM -0700, Michael Chan wrote:
> > > On Thu, Aug 27, 2026 at 11:57 AM Joe Damato <joe@dama.to> wrote:
> > >
> > > > @@ -3831,6 +3834,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
> > > >         int i, rc;
> > > >
> > > >         bp->max_tpa = MAX_TPA;
> > > > +       bp->max_tpa_roundup_size = MAX_TPA;
> > >
> > > This is strictly not needed.  If we return early below, it means the
> > > chip does not support TPA at all.  We skip allocating the TPA array
> > > for every ring, so it really makes no difference.
> > >
> > > BNXT_SUPPORTS_TPA() will be false if we return early.  LRO and HW_GRO
> > > will not be supported.  So I would say it's a false positive from
> > > Sashiko.  Thanks.
> >
> > Sorry, I should have been more explicit in my last message: is it worth a
> > respin to remove this? Unless I am misunderstanding something, it's harmless
> > and while not necessary, might be more clear for a human reader?
> >
> 
> Yes, the extra line is harmless.  But I think it will further confuse
> the reader (or AI) into thinking that TPA is supported when we return
> early.  I slightly prefer not adding this line.  If you end up
> re-spinning, maybe add an extra comment explaining that TPA is not
> supported when we return early?  Thanks.

I think I'll propose something like this for the next version:

@@ -3832,6 +3835,10 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)

        bp->max_tpa = MAX_TPA;
        if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+               /* TPA is not supported at all, so there is nothing to
+                * allocate. BNXT_SUPPORTS_TPA() is false in this case and
+                * neither LRO nor HW GRO can be enabled.
+                */
                if (!bp->max_tpa_v2)
                        return 0;
                bp->max_tpa = min_t(u16, bp->max_tpa_v2, MAX_TPA_P5);
@@ -3839,6 +3846,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
                if (bp->max_tpa <= 32 && BNXT_CHIP_P5(bp) && !BNXT_NPAR(bp))
                        bp->max_tpa = MAX_TPA_P5;
        }
+       bp->max_tpa_roundup_size = roundup_pow_of_two(bp->max_tpa);

Because otherwise max_tpa_roundup_size would be 0 and bnxt_alloc_one_tpa_info
(and other tpa functions) would use an alloc size of 0 and return
ZERO_SIZE_PTR (non-NULL) which would then break checks like:

  if (!rxr->rx_tpa)

because it would be ZERO_SIZE_PTR instead of NULL.

Am I getting that right?
