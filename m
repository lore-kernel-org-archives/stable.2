Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BC40B6E9
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594360; cv=none; b=uokCe9UpBN9VDF0Vd8DEY5JiRDl7iHdy1NMFQcxnzjLUzf2tkzpShCpnqs7LyYEhRy1PpN+k5ASR6QeOukOuLKht5nyC+xrMSUl5GeBdRMpbLci+tp7ctudA//v02Xs2Se72GsNfLHKs1m/Lj0+oU70Lms6MLOZu5wTViUZGkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594360; c=relaxed/simple;
	bh=tT+rsXtyCwdK9hnBUqWrLDMFJQTbKewUwmQ5pI7i0gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxxieQdIOLIJPLeEd7ga6nN6YzJJI3yj234mnZoe4vWGNg99+Vg1qLt0TENjzr4F09RqGs5l0fY+XKEQvg4QbYP5rKtdTrTwhDRKUN7uGALiI8Yl1lW+5EZwnKyVmZZweLtz3V9nFKZ7V7FeCErxpmsCrDvsm1cg2QeKV26XPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4kBJYXJ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4kBJYXJ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb9b427da2so467868a34.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783594355; x=1784199155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QG9Jt3raC9zxX2MSD3KhQhG4RBmV8v+5QIW1bbTsOTs=;
        b=k4kBJYXJ5myAVWNu43HcfR1nQJqQNSDj5bLAImSqRthIVv950ZRa7UU3AKMS3EWgSZ
         5/Xu2v49A69iaAlnqtApjLM8zTJKvTyPTfC1YTOrjj7wddpRbJ5a15POwvs0z5JcJCHl
         di/EOxCR0TpGWzl81sPtQyPYvMwCOuAG3E3zNAvkLaNau269Dg+EXCXIWxrmfYZvGZY/
         x/5rrEeJpdXbW/zp63KqxeEOuaA6W6KeWt8kwZuRxXTJxHFfRC300SPPzwfpC8i2Fpk6
         EcjHtnvSLiCmeGY4/gsJkKcNFUlOICHeJpXpDXG9oieX+rMph6ljEsvLn3gBRe3j8j4R
         8Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783594355; x=1784199155;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QG9Jt3raC9zxX2MSD3KhQhG4RBmV8v+5QIW1bbTsOTs=;
        b=Gkvi6wOdjPpzf85OtG30YHGWn8mxfB8j6LCwoFRAG4XDY2wK5aSPAxwkWqzVcBzhDY
         HuN3LbajnLZa6Ph3HdK6ngOVh7uQzjS7clBHnVGxs/IZB3R5BJ1kebNy3CI2I7YHlkYr
         Du3GZCVvV5UE017u7GBSx0ORxNa4ml1syJWplYC2dkZxlef5hrUC/5XZE86rBSEPPLn6
         ukLlqRK8OstSIM68KDZZgivNinVaAYtKf2eFq65M5+r9oQFH6obmUdcSbV6wDizeoj3y
         XRAQNOeoErmmF6LtLSqtJlnKu2qlCLj0oBWSSEI9k0b811yXPQ4tSh8Ct9gvV/ML/7X0
         fxSw==
X-Forwarded-Encrypted: i=1; AFNElJ/ITZ1emGlvrOH70/f/iKdyYP4rYpCbFgpveEsCVUk3EXaJqiDJRfasPniGmgh6mP1GejXIQMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNb/TMVjgSmvI30dk1lX9PC7ictVA7bGM97mmHH0fZswc+/qQ
	T2vymwfb5axE4cXex8e4MDIzZEYeavcTrCexgOdUNNvI4HcXb3gLJBha
X-Gm-Gg: AfdE7ckGWu7idUIxSmvold1/iITGTHm7B6kBMDIA5pFEL01Sx4Lte8XQr4R433a6gkC
	BGOQo+yLJJWpqATbd992zIfsfv5xYevJ3PNOciDMR+PqIdbwCNdWbWydw446tQQoa783lTEuvbT
	SNB0lyfsVGfHae32jJ2hNiwlq0uSxIbz3D098PIO9gYSslf9fGJQN/u+04rSwuGkGEuemmLwAmT
	GzAMiGC8THVU4MfhPGggoM4SjGIjyTK4a8AIhzEdcelMY9jbtn1yOtlNWRFpnskBxC16kUqjjWg
	+j2B6LNgDpsL7B0gZuURQLGf04MENm1QAR5gY51gq/7sVDJoC7AWxPdWTSucbPuBLU30+XgKUek
	JK4i/WBoWug7ExAQHaBBftsj9ZGs4rb4UV1CkEK14fmgAQ55Ycym+H7Si2X24tf0ofpoePjKtop
	HoCLTN
X-Received: by 2002:a05:6820:1ca8:b0:6a3:68f8:69e5 with SMTP id 006d021491bc7-6a37d88343amr1884175eaf.13.1783594355599;
        Thu, 09 Jul 2026 03:52:35 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4519124d07dsm1652855fac.2.2026.07.09.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:52:34 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:52:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hao-Qun Huang <alvinhuang0603@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: hid: fix SET_REPORT return value
Message-ID: <ak99bENMWC8saJL4@stanley.mountain>
References: <20260704081613.434445-1-alvinhuang0603@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704081613.434445-1-alvinhuang0603@gmail.com>

On Sat, Jul 04, 2026 at 04:16:13PM +0800, Hao-Qun Huang wrote:
> __gb_hid_output_raw_report() stores the result of gb_hid_set_report()
> in ret and even adjusts it to account for the report ID byte, but then
> always returns 0.
> 
> This hides Greybus transport errors from HID_REQ_SET_REPORT callers,
> and makes hidraw report zero bytes written to user space on success,
> although hid_hw_raw_request() is expected to return the number of
> bytes transferred or a negative errno. The sibling GET_REPORT path,
> __gb_hid_get_raw_report(), already follows this convention.
> 
> Return ret like the other HID transport drivers do.
> 
> Fixes: 96eab779e198 ("greybus: hid: add HID class driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
> ---

These kinds of changes require testing.  How have you tested this
change?

regards,
dan carpenter

