Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5B2DF126
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960771; cv=none; b=SfhqMzvJo4QZmBUKacVuP8JcujqvJkPLsm5pe/+c+ud8/ug2JzX68+J8TrMrgVt0YkA7PyylGa83Ugd0B96NCBoDui5d0W8a6cI/9AlW9kwBmWeCTS3/2b18qqUj+OBDFM9jQo3ldhd2ylwTPR2U/et1Wswgn+0KEyGUFEkn0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960771; c=relaxed/simple;
	bh=CBhBOxKW9DXkHE6Vdw9XCfb+WTJBsS8SlILHHvnc8TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Jcxl2iK3Xxtntf754exCR7yMhNXbQOlW6KBDybupOqhMTMQIDkPcoWS8/PB4tTEjoLX8flOkFR5U+0SYZTyM3IHGOG0hNpO1Y16caDHtvOyQ5sDBHqg204TOfl1sxFfJCcqc9Sp4F7AIl2y80ToV8PpP+l0xlJ92tXoQn4Mek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r58tA3a5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r58tA3a5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49558ce01afso24341365e9.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786960753; x=1787565553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n63sUKQMdSKf2IRWefDfMPcW8wjg+n1z3lYjhlrIgr4=;
        b=r58tA3a5JpXgezjaC1WENgcDK/zZhZPyZZq/kRqG8yfvp+6KVaGI+rQyx7k8pDDJhx
         5OPgbeqf68/fkhNYOHToyU9UaRmS0LSSd84D9fkKV9v9rtEHnzugLEvDstrPfQBbgmW9
         AXtKb4P01885viv3qCujfxuQR7Pa16eDUZfEiuOb1ERALdHnyUZsB+tEhyNCdJhxawcB
         /0HUsE1fs5fUhFGEEqfC175+yLKsITkopCrG4VtB0d2KohKsC8zv8JZ6B6n+gegcac83
         OeDHwtq7+onVRpDqcWgGqt6vOaz63uwzhRteI7fxokuruEl6qduZ6xGe6Qko0eyngd8f
         CjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786960753; x=1787565553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n63sUKQMdSKf2IRWefDfMPcW8wjg+n1z3lYjhlrIgr4=;
        b=iHBZNddJ6y2IVPUdXO6gitv5XZTUsLEREx3IckOcE6z89kVCMgxPteXa9+nM78oP3C
         MXUvwPBu7RvMMo1bvHqRBB0ijmRWe/nQLuLQ8tAjXXFR77PlqRFispJeDX7pZQ1JIrFv
         LJ4Wev0qeUbWSGd2jiOnTDa5kM4uVqZK0GU5vmKqnGC7WbC+dJ+OCyxiDq/uUJ12whep
         loRMpXzCm+uex3ciTSS5CrKIUaEym6CTdiTun8x8YARZF32yYjbkgdvnr5Mf/UIv/JYY
         XdjLfVg7dl9pYHhU2MHCjFL7z+1cVsiyc7qfwxf22hJdkDxi3tQ2YMvqnojYsbzC5Oed
         ahUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgHpt92l6sZGXvpAUYye2QZZ2dH9FiMYxtF60ykkemZ90iF+5IlHklymJsYIn1a6BcQq9j8YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUx2Cq5XCqDcF8WrUyfqOu1dLBGXevvlDqVuLgDeDss8vKbv1R
	+pxQJhNVjXrX5IDbuNQZFCY+GmpD9t9RUV/Hc1ftdl5amF/913mt7yya
X-Gm-Gg: AR+sD11h4AS3s1Jd6Gz55vcmbhj+90Yme2Spj/oDHI5JbziE0RMmLAKhXWetDagXMgR
	X249NQIuAHKlBrVMrHcX51dHxgjF/PL8Y1Az0K7B0aOkkFXoSDTInc5z1isz392X1GUnCw6ScCB
	TZHgMvYoMODNyBPEk0u/mtQXK1N2BbstVEKs/qvTk0+9g8+OSWhUGoeyph/4Dhs02jsY/14tYiA
	/FA+u/oPSMuDbxs48odqraRfXd7CDeTGp1Gc5YR/kBOaX3Ea7+TWSzHbGHtTcrhawJOd3h9+AhN
	w1t0QmTdD/lS3nTb0XAi5ep5cwulyCmLBFcquJmgRKBdSMJWJTMqU59j6BK21bJxf6CE1g3E0DG
	4/UKbV6BB53mkShauUr1LRFndSzhXuMKYJpikv6PwgMy+t5zzqyXTGDp4S0PEgrd4tcrUisEZnh
	r+lC6knDnEyBQxfyZNVp/kgqiv8YhUMHOqtrdl7wUZcrcuWgV+gG20ZACtgQ==
X-Received: by 2002:a05:600c:500d:b0:499:86f5:9e33 with SMTP id 5b1f17b1804b1-499879bc10emr392118895e9.18.1786960753464;
        Mon, 17 Aug 2026 02:59:13 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:9cf4:43df:e612:817b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm2863663f8f.32.2026.08.17.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:59:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:59:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: moonafterrain@outlook.com
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
Message-ID: <aoLbbZ--FrkVN3SU@stanley.mountain>
References: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>

On Mon, Aug 17, 2026 at 05:13:53PM +0800, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> sm750_calc_pll_value() writes pll->M, N, OD and POD only when its search
> loop finds a divider combination with 0 < M < 256, and returns 0 when
> there is none. ddk750_set_mode_timing() discards that return value and
> calls program_mode_registers() regardless, so sm750_format_pll_reg()
> reads the four members uninitialized and pokes them into PANEL_PLL_CTRL
> or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a mode
> set can ask for a clock the loop cannot represent.
> 
> Consume the return value and reject the mode; hw_sm750_crtc_set_mode()
> already propagates a non-zero return. Initialize the structure as well:
> sm750_calc_pll_value() returns early for SM750LE without writing the
> members, and returns non-zero on that path.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---

Greg is not taking AI patches unless they can be tested.
https://lore.kernel.org/all/2026080354-skater-urgent-31b2@gregkh/

I kind of hate AI commit messages...  They are so verbose, confident
and reasonable sounding.  But they don't answer any of the real
questions I want to know.  How did Yuhao Jiang find this bug?  What
did the symptoms look like to a user?  Are there ways we could
improve our QC process to prevent this sort of bug in the future?

Probably the answer is that the bug was detected with AI and we
have no idea what the symptoms look like.  Everyone sane automatically
initializes variables to zero so probably there are no symptoms.

So the problem is that the user inputs invalid var->pixclock, and
it leads to an uninitialized variable usage.  This patch addresses
it by initializing he variable to zero and checking if
sm750_calc_pll_value() returns an error code.  Either approach on
its own would would fix the problem, hopefully right?  So it's a belt
and suspenders approach.  But isn't the real solution to reject
invalid pixclocks in lynxfb_ops_check_var()?

We're not going to apply this patch because it hasn't been tested.
Probably we should invent a new tag so we can create a TODO list
of rejected AI patches.

KTODO: investigate unintialized variables in sm750fb found by AI

regards,
dan carpenter

