Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AC3FA5C7
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965236; cv=none; b=lqZ3qRhuq5EdAfPswQtpQGOfPHNVX2PizQj1JWgamp8OlVhXz42CsIrsXcrcz8q85pLwkmWrxbyhFPDu+2pEiXD8pA0F/3TZMYrukqLE4sNbmXMv2vKNyUDyoiBE5TGYNj5Jas5qZ/pxrA0dwobPk7Nxoy6vGZDOOh5SRdNOTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965236; c=relaxed/simple;
	bh=yP5Z0Zw9/7oyNxvKw0EGDkO5COXnnpYOwO9TLA5kajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4Akc5rGN+F2Ui+flXfkCaLFckzvmg+ysLMlii+u9Zu40//eBrg56hc3O0J08gFFX3iAvtcq1XVi/mTR7rJi8IGqO7eZi66zjZ9KA1EEcn9FgNSCw8sdtquqd6WlTCnCpMxQzfaVQPiPT0O0fWJvfooagyR1bziUU4OwHH48RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI/Y1qcc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI/Y1qcc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4815bce4652so2012911f8f.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786965233; x=1787570033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hCAG987424i5Op1rCNWT0rT5ZiBWCiG0rVbJNv0+R6s=;
        b=gI/Y1qcc3n+3rRwDsdh0X1yPdlpux6pSdx86dKdRaNl3muQ/J4rCPYzBLmOSK7sfIX
         ixnLFxu4Tpl+ZKFXqSJZc4bpJ6if0XGXUuyr+TPLGH8Z3mbXGnMcCOYRyk3XGxjO3dIJ
         kD5NDwtFA9yoAjg1FSpKntmX3G0I3E7s7TqYwQ/5F9AQrqr3/f943qByszPwj+McKVlp
         SMcv154Yxng6qNu8him7naLaf3M0CHo4D7l+Tw6ldjwy/BjKb4K6vvjHTqvdI7e+m3xx
         YQvnFJud9yj7vIiNp3FiHDoj7XxxACSe3Bb2lk6AtPd4eKSregjP6kW2aUZ/+OJdL5eg
         SKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965233; x=1787570033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hCAG987424i5Op1rCNWT0rT5ZiBWCiG0rVbJNv0+R6s=;
        b=a5zJHY3+9Yvl2H4Lx053IJhVTss4YNP5Uw6Iz56Xjd0rdLm1UBIaPvuQXw2HHngw/X
         3p650Kt8ve3/t4D2DvHpgx41FvXTFu/i6ZWLxQVYHOUCRl2k0QqPz/Zj1FLCofA52fT2
         4Zphv4NFU9QPJN9Es4Yat6bDLGHbCnrxtiFuwD+Fylhhkz1S8pQ9wHxJQeqRCOEnoeqJ
         4KFGz9TH1Ba6hnsuuehhS1UsWJ09F/JVuafbNiFqlf+rDmPn+uwnk+dJFEdUbTHKZ0Rm
         5sCJSJRXSZKTlqK42vAC98pP9+344L/gy2HvyVpllflQmn14XsYBYRCR7t9HGZtI8jDS
         T/YA==
X-Forwarded-Encrypted: i=1; AHgh+RrGmke9BHFgMj4pWlNRdhl6s1q0hNncoFPfWlxsKUJwJag5dnKMzk4pR2BCnZcYhb6xgfojwlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSu9bSR6NCO45qU4vepSGawwvlgLVjl4nGSeaZct1ni8anwV3
	jVHjDEjMdF442H0gExjDMLxbWeqrESTIp/N8UkIRFWl4bTTHQ2/bovOtbXonEFAh9fe9nKqw
X-Gm-Gg: AR+sD11ALbx7DL0CIEaGlHpDQpP8/Mam19bU0DRtRFszf2hAd6HbKPO287a2FLh2Gdx
	PtGX1rskkVlwTa/Mnot/B6vWkeeNF24cabnfFQ8bzHmSbsfd7cMzeZIRTR2dXzDF4e4EkHsFYOY
	2SVytu/R/Gwm5IG31qQ/PNpE4aFaI9RkrxwQBOYWclb6rfw31Q5cqXrbULvoOApInlb61gwX9Vt
	/xaAQVGnJtdIBMKVcVzBTPbTypjR0BK0JJmLLA/xfLxb+wTpAyPYBByV/x6oDGYVaMtVa9MmMkY
	PhZBktsdB8Qtd4hX2de1qf69Px7NFSJU5eCKxslq4pZsKQK6CfkWYRtubxFh1WzW0f2PQDvGG+3
	DN0BoKzLabDSO7HmL5H8tzvt8U7+mYuD57GR3lfqP0HxmEEVOkY1whGxgD4nolivxJ5oamsB8qm
	EOi7YEE7hzqlJrXPpZaG5pkuhpnI6+Lh7tR9WUYmHYxwm2V4c1K66sVxDEFfL7sxUdma2W
X-Received: by 2002:a5d:5449:0:b0:47f:5369:bba with SMTP id ffacd0b85a97d-48160782d05mr34547608f8f.15.1786965232687;
        Mon, 17 Aug 2026 04:13:52 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:9cf4:43df:e612:817b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a315bfsm3270339f8f.1.2026.08.17.04.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:13:52 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:13:37 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yuhao Jiang <danisjiang@gmail.com>
Cc: moonafterrain@outlook.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
Message-ID: <aoLs4RsoS7bB4v_2@stanley.mountain>
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>
 <aoLbbZ--FrkVN3SU@stanley.mountain>
 <CAHYQsXR1RS+kzFUQQ24YFyxxUJE39Yk=YfuFgAsvph1hKqqd9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYQsXR1RS+kzFUQQ24YFyxxUJE39Yk=YfuFgAsvph1hKqqd9g@mail.gmail.com>

On Mon, Aug 17, 2026 at 05:49:33AM -0500, Yuhao Jiang wrote:
> On Mon, Aug 17, 2026 at 4:59 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wrote:
> > > From: Junrui Luo <moonafterrain@outlook.com>
> > >
> > > sm750_calc_pll_value() writes pll->M, N, OD and POD only when its search
> > > loop finds a divider combination with 0 < M < 256, and returns 0 when
> > > there is none. ddk750_set_mode_timing() discards that return value and
> > > calls program_mode_registers() regardless, so sm750_format_pll_reg()
> > > reads the four members uninitialized and pokes them into PANEL_PLL_CTRL
> > > or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a mode
> > > set can ask for a clock the loop cannot represent.
> > >
> > > Consume the return value and reject the mode; hw_sm750_crtc_set_mode()
> > > already propagates a non-zero return. Initialize the structure as well:
> > > sm750_calc_pll_value() returns early for SM750LE without writing the
> > > members, and returns non-zero on that path.
> > >
> > > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > > Assisted-by: Claude:claude-opus-5
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > > ---
> >
> > Greg is not taking AI patches unless they can be tested.
> > https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/
> >
> > I kind of hate AI commit messages...  They are so verbose, confident
> > and reasonable sounding.  But they don't answer any of the real
> > questions I want to know.  How did Yuhao Jiang find this bug?  What
> 
> We're working on an LLM-assisted system for vulnerability discovery,
> and this bug was found by the system and checked by me.
> 

I feel like this is always part of the story and should be told.
Regardless the firm rule is that everyone agrees on if you can't test it,
then that needs to be in the notes under the --- cut off.

(I sometimes skip this, but I've been doing this for a long long time
and everyone knows who I am.  I should follow the rules too.  #shame).

regards,
dan carpenter

