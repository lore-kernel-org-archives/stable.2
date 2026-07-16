Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA262E737C
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183257; cv=none; b=UuuEZb1iDXr9s+Cr/3FRhPVVmi5OkzelK7jDMUhhOK8vpe0WpffLDyBm4QC7uEQ+4VLw/rgUjxoGzkpZ5w1PI+QVuOH3stwi2M+acojzbdhcXyy1bYbrATJSpKm6zoWZapdgzYXEEdejhsnJLloLt0NynAltGXwKbp6kHSK3u90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183257; c=relaxed/simple;
	bh=NRmZN6kBrUZzlGpzarB9t5FQkrrI+SYFTT7heTbf5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLIUhEui9sAD5c27ncOQP++UNb3nDnjRXJReBUkI6hTn9S3/U3VtInBAi/LC9S/o8ckA2roDfhDTmCj6PTAUXpe38PFJbEiMcTrPG0ChcnYZO5VwJuAXe6rcA0QJ8wPTDzlpV1E33/gfCapyfdzjCprn2iYsXZILSqunPo7tDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2mVZ8J3; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2mVZ8J3"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so1284128a34.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784183252; x=1784788052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=efE77uhj9nQCyKWP12csM1pAoAvN9Mzss6mQMwg8AtY=;
        b=D2mVZ8J3KnuQwVnUNjKlV5DkACX7enxbYP7iwPS4hfgSQA7MR9n3cEeiUdX3xvvSmP
         AqayJm3uAwWwg1s36IfaVaZrm6JiIa7OLZulc7GrVSZHy4A6G5jnebfiRY4usSTvyWnx
         KOYIvsHO9jjo4acWOF9EOV6CKdW7qZ+x/eYcirv2cCe6CRqH64cubWCjD613+BiTUx8u
         t6EJv7Dv935sp9mbXd6+TqKwtlBrZVcyfP5MxlAecep2KpOH3HxffGArDCVQFtDsI7+2
         R85MHk8Fn/obMCcDncG+A7+qTFYj3r9npb4b+FFdAlPAoasHz4OFiJ41og6pCXCXlTab
         e/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183252; x=1784788052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efE77uhj9nQCyKWP12csM1pAoAvN9Mzss6mQMwg8AtY=;
        b=hNA2whHJoDiLY61/YYhmMfwxHbG+zwD0waZlUTw9crluvW9xj0CLFFvKaLaRPUgEBI
         k78Vbx2SXiocoqGxVZwezrwMNhuaY9S2ej34DcTKNpswsvNzHZ2T29+1dQatCBP2LdfT
         sR+wG9V7dPeETx2lSH1aPqXMs+j7eVRy78Nr4HUK0Ku3C0Nx75R9bRsNDU/4dwFD3CPh
         55ryYrC2x+SvCtqRyCfMeVEh56Uhptzi6GJXuC3aeL2pfjyrzuAjtpdlqJVasP3nRYCF
         NwK16yab1aJxDG6Sz3rABy9CC7TMyZey3DxVy4tw00vFYSDIL8FF3F4ox0NW4kJC2a+a
         hw9A==
X-Forwarded-Encrypted: i=1; AHgh+RprSRu0fIL19MFYyFE17vE1o8xChNGDtumNNN9LRNV2jJmGyoKWO2ukqdGrx6kl25o6N0AD9PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4fayEbC0deeLSp9ECHzooN2tjKIFpiVZbzDlP6ZFgr4nC/oC
	v5SNGiKoTEpZUWYNg6GjJMXaZDOTQ7U+McxusCgClj+oGSBZ5ATyR9Xq
X-Gm-Gg: AfdE7ckjVf0lLQF+gEbwTyex641drDLLwdy/GvSyyxFOlt4Nc0cEEJNEfCSv5XfEni+
	ffwRf7PQhyy2Ni+i0oaOXy0x0HHohJiKO4j8wm7Xag4KhufO5zpuNayRxjHbCggKyCgeufXl2Yp
	YTJxLteJJ+ivffcLm+Irv4i47xLFfOuxSWEdvqnnZzEH4qsilYeSYpMH4oFe1474OMTKIJWzK7R
	rdgor13v4vq/qCC3ytq10baphd+MxZoDTrq98HUt6zatncq7wtzJ9ymOgvNXYtzarjSPs9gTSVA
	IuHXbwerAvuGLw8j18Bgi4e6irq/7ZEnBplcJykrPXGGTBnrPXjMJN+U8NmQZis2JkJf1xz9VPz
	8o+dQ9hYmo6v4ajvj1dDn3cDAxlrKy8RVUitWhq9eWbYX7NXBEga4c8ti4aTndr+7ZTbMlg==
X-Received: by 2002:a05:6830:83af:b0:7dc:e37b:b5d3 with SMTP id 46e09a7af769-7ec096001bemr14090360a34.7.1784183252499;
        Wed, 15 Jul 2026 23:27:32 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec31ee6e1fsm7525573a34.4.2026.07.15.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:27:30 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:27:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Georgi Valkov <gvalkov@gmail.com>, briannorris@chromium.org,
	kees@kernel.org, johannes.berg@intel.com, bhelgaas@google.com,
	s.kerkmann@pengutronix.de, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: replace one-element arrays with
 flexible array members
Message-ID: <alh5y74H5bJyDSSP@stanley.mountain>
References: <202607150932.F2A0836@keescook>
 <20260716001728.57799-1-gvalkov@gmail.com>
 <20260716061638.GB9973@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716061638.GB9973@francesco-nb>

On Thu, Jul 16, 2026 at 08:16:38AM +0200, Francesco Dolcini wrote:
> On Thu, Jul 16, 2026 at 03:17:28AM +0300, Georgi Valkov wrote:
> > Replace deprecated one-element arrays with flexible array members.
> > CONFIG_FORTIFY_SOURCE reports the following warning when
> > one-element arrays are used as variable-length buffers:
> > 
> > sta_cmd.c:1033 mwifiex_sta_prepare_cmd
> > memcpy: detected field-spanning write (size 84) of single field
> > "domain->triplet" at .../marvell/mwifiex/sta_cmd.c:1033 (size 3)
> > 
> > Convert affected structs to use flexible array members.
> > - Preserve existing wire layouts.
> > - Use DECLARE_FLEX_ARRAY() for structs inside affected unions.
> > 
> > Tested-on: WRT3200ACM, OpenWrt
> > Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
> 
> Cc: stable@vger.kernel.org # 6.12+
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Are we CCing stable for this sort of thing?  How many FORTIFY_SOURCE
warnings are still remaining?

regards,
dan carpenter

