Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40FA48DB43
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174616; cv=none; b=nhsmyXgpFKlvU+vwSydEGy3h9gScP5bzfRMFKgCnVBaego0ano31OK+MN80peX8rY70ViVlh0UuQAQ3gTEk0CEniGA4UEiudk5+RAhas37yG4OJmWXDqzUY2xBQpEi+tdxeXgGkBSTRRuO43TiARbDDBXyFru+bR3XNbb+AtdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174616; c=relaxed/simple;
	bh=jwx6jBRjTpzEH1P7oEb4BrgdmEHEUfzaC8Bp/2eitdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkm1QGUMp+1KODyLbmb+K2whIjkUtRX2eh9Gp0cyot4ZZSGLjgKte7tJz0/JWVK3rR2MwymYc/hfzwDkrHdAbr0qJOmgf6AMzWr+6DiSTV3NErnM4FoAvVT8MYDjkInutMTP5+c8DOSLHWfmsSyQtgmjELaLy3/xcoGpovyiMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASm2gonr; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASm2gonr"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so203626c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174614; x=1792779414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3p4ECn3lIOQmDtAocqLgwI+XAjA3TkgnXps1pr1IWI8=;
        b=ASm2gonr2srwmHZjJvEg8jyrSgmVXT47ylSp5KoTE0CRVQuRLb7udDY1XqILS+qNsC
         gDCyD/5oRbUAKtqchu3Q1Sq3nTbiqp2JKjRSX5XWGG080MUDowplbes2r1X0EUs1l7i/
         zi3o4A9CD3AQIYMSLvYnoK9vqI+bFL0pD2EqFfLfN0cTC8XOTCKpMVaAX0PNiFVeIIRb
         aODDy08B96IA9T4LCT/m3lHi6oFJ6RwPWVZpWMBJjpMxXt4YpTqcMIRT6tSUusVKWcS3
         Ymtgeaq+ZlWZEUIrglrS+tUQ+786C9gW20kEzFgZ9XTjbeu2DOjhladWkXfLr0njgzM5
         bfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174614; x=1792779414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3p4ECn3lIOQmDtAocqLgwI+XAjA3TkgnXps1pr1IWI8=;
        b=g0HHkGtni0nnBfT3bjW8bXPC7JruT6MCngbcx+8QDKlYo2+NDZuIWShrc0QA6eAzoq
         jbT3omxjljm/UsOR0o3rnMsxo7aEDzpV/fX5K2Yku2F1xhxk/SZJ18dXZq1vdabmGe+W
         qW4xshO8G3tPAYqLcD18urTT/XckFvYjkg6kuks7Xz1KYXbXMlWkT1zPrTLYl0H1/n0k
         283+W9pBdtYWohkpoqMCyxLm1lsfgSkM66X374Xijpuhn96XOpbWw5Qodln/JUBkt25l
         avvEBxNcXx7zsBvzRbyvwza0H8bu+pSoiITj6kkF6dPXbsvChvio3b7JZPT9zt5y+NqD
         WKkA==
X-Forwarded-Encrypted: i=1; AKwUvBzRksJ60kmoE0+M5cwO9zp8j7QZqaTKBVvvqa4YUAmvkt36fUlncMAYaK2AVgxL2mQ0VAXYD+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJANM2P9VqN1v0wliL3IHSWQp8P00e1El0FxHj68ZvzRt1b8HZW
	F0lXO/xMViNaYuC/wN14t2f0LVKPSxFFXPC7BSUTUP5LbDh3oeaUq+iP
X-Gm-Gg: AYBFou0HNSotJMLesiSP7AzGETvAxdEa7F5dhhsEvNQzPbZCT+4/esFAYx3Fkaa9MVd
	jSfhCwIpyzUOQumzk7w41cq5fLzg2o8XS6ZVpKYZuNEDn3NxZLtaTJxJ5p8TWCYZoI/PQVIaRCD
	1mjdU8e6F+if+6+RYQF4i38fC5RmZqE63BcDmTexB/NyUkHwybwvyqW695tFADfmSN3cMVL/TAc
	hSj/SXtiZPprsidafgbmjj9YJd91rVYJ6tQUiiTFt3Y+ih2Z6Pt4nDdDWnTD+FpQf4bpOCvM/Q8
	paygANCVpNIUKYWPDqO0stq8A5Fgw4S0jAD1v84mQuPP3r54ZhGF9qcXhlVXBugWrua1fmkI+YY
	CJBPgC1Bk8tGVnljRQr+inp7iBB4JVsqc09w8HLVVk78kVopj8U8M7SYf+ZOTO1ZHOzakpwgjKq
	2Dx+FzIpJBLwTRQ5VeflAhyN72IXA36coP7d6FoSvS+Zr/uT1E97LzgCwjvnGkPuqr7vk5zd7Kw
	vSrR45de15DGqmHiiCY2F1nKks9/dfk4TuDJHsX
X-Received: by 2002:a05:701b:4204:10b0:144:f85a:a188 with SMTP id a92af1059eb24-1850c5f8391mr847757c88.2.1792174613831;
        Fri, 16 Oct 2026 11:16:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e6ab:aea2:fd2a:caf4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f5a13sm9076869c88.12.2026.10.16.11.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:16:51 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:16:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] HID: haptic: reorder try_module_get/get_device
 before input_ff_create
Message-ID: <atJSOv7fRdtyeoH7@google.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-2-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016163349.3293666-2-qwe.aldo@gmail.com>

Hi Aldo,

On Fri, Oct 16, 2026 at 01:33:48PM -0300, Aldo Ariel Panzardo wrote:
> Move try_module_get() and get_device() before input_ff_create() in
> hid_haptic_init().  The original order placed them after
> input_ff_create(), and failures went to input_free which called
> input_ff_destroy() without ever setting ret.  The caller saw ret == 0
> on failure and kept a dangling pointer to the haptic struct.

How about we simply stop pretending that these can fail? I.e. replace
try_module_get() with __module_get() 

As far as get_device() it cannot fail and is redundant:

- get_device(&hdev->dev) only returns NULL if its argument is NULL,
  which is impossible here since hdev was already dereferenced
  throughout hid_haptic_init()

- In hidinput_allocate(), input_dev->dev.parent is set to &hdev->dev.
  The driver core will already hold a reference to &hdev->dev
  (dev->parent) that will only released in device_release() after
  input_dev_release() -> input_ff_destroy() -> hid_haptic_destroy()
  finishes.

Additionally I think we should simply fail probe if hid_haptic_init()
fails instead of trying to limp along without it.

Thanks.

-- 
Dmitry
