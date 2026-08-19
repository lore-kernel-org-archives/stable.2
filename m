Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC0332EC8
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171737; cv=none; b=uYRHZH57I6G9OQ/uTx6XQhhbkoqiuVR6nZj67PeUxvC4iXRruVV2KqaL2ZdZQKfa3qpZXyvVBs+/VvPZwlioTGkWtwxUkxZqRXGPQy+OQX2F9t4qPPYYUhjBq5vmMuIoG5YLVRV2xbclkiAcfGG/O80njyFoDRLzOJIKZReXl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171737; c=relaxed/simple;
	bh=gWZIWSn+QfY9cjjDsXtojf0eY4HoNp4FjP4izH32dsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfuq9YVFHkpXv6+zxCStQ9zmpWdFmVN1EmZLuFIX7BCevQwUlFLwLzAuG+REK/IQ9k6gLxvjaBGzcumO/vupI4WLbrpeT9ExhygcCoXZshuy/1WlzYwAwHrhlhjZt+NawgTN4hT6r7eIwxeoz4eTuMMTmUGwrh6V7VGSRrkDbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsDErefp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsDErefp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2360846a91.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787171734; x=1787776534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=llCHg1ZM3NUt07Qz1SWo3LquYpu8FhSL3xCEUZRGbuQ=;
        b=nsDErefp0/+GF7B245+qnFQmJfXQAkCLxcc021eHtMO8kBKMELcczm/Kvs7ZyfOPYW
         AtZiFe0/LV/3e8bovP/RDc0o6soskAr+d23phW1Ense61lJZw1MvcNQkoVFfqA+UmmuO
         4/UnXaMhnEJvvFzjNIoSMTsbuOmE180qfUSGqCfLnAV97xV/GC7zNRXBl3iKKG37J+Ow
         ZQsXUFKgxssABBLqgatHZh5OsouuUSNzEFy6Ds50JWQ1OMM9kwy6gvdj+L+tAJuDeZ5h
         EynoFW2TX3iSdB4iAO3B7FFu+JaK5FAy+15pzQvE+N+NG573xYjuR8DgSH6PwkaS1yb0
         smtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171734; x=1787776534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llCHg1ZM3NUt07Qz1SWo3LquYpu8FhSL3xCEUZRGbuQ=;
        b=AuQZ4LKni5anGTj4vUABL3mvFaYoTQA4SOVQFUx3B36/FCPPHPEw7Xxx2DpaJ4+FpO
         fNsJclmF/lk/rP/afzmvlsiubjjCaNWn+5G2RJ0FTlWyKyn7ex+NO4BBSLIj9/xbViba
         GV12CGH6EyxkjmRrYNbo1GbHJkPSy+YAeCsxygeKF41JJCV07H/I4jXIahfE2MY1Zlfo
         /qefbFId9W5wD9xdWslXgXsXgJsBlF5GxJdBqbJmmQpNVn24PUvtc3D9OABdOU2wq9/u
         9yWfIFGNqWiCCxO4RFoRZnZOUwGf60u/efI82kulEXoTD7TZXpWSkVpE8p+XXEkXRqYI
         /bug==
X-Forwarded-Encrypted: i=1; AHgh+RpNj9+tewz33JPGWe3wFlj1g7Pp2Yhl4dEuakvlOJP6oAaFb3gWiNMm+JaQYG4PnG5rvsIdLfU=@vger.kernel.org
X-Gm-Message-State: AFuF++nyhurqlBFl5CNDHmmv9NoMoTsmXCwBrUFOGlq3/km8tWk/cm6C
	9IIQz09+9DFPHOhcbluPPc4l11PfOEpjnlck6iC9fbFrL7AUg2+KcQlg
X-Gm-Gg: AR+sD13Bnd25VY6NBDzUSJ6WLKaaaCL3Agqg+uuioyZiYIn7ibTIio3uodSqw2ob/IQ
	5N2s5gwUMpOtSyyJvDnbIh3QbMow4aMBa7qshT5DaKBjl0qMX/Khhc4X6EwazFR9wmZQh+IWf8/
	ZSr52RglrSEnziSzgWtMenxZoLpmGlo1ewa9S9nKQ7JOJaBYv993n+/kFBrmMG6CVTIdenkJ3ae
	iiGTjuMND8TvYlqrHkcGZ+X5IbsD1rAV/EKzsSDOTW7bE65iemmYE1of9Ulv7cRhgYf2h5fU0nE
	OyyqnipfD14mDuKx6HvtpFCuixg4bxbgPlKvFHAMyBYCUL7p2DwxjnC4LnGhJcMY+voOGWYKAg3
	fLHdvCpNetwD9fR93mSLpbkHSym/r3LrvHyBFaD8m1oKVcMJJz/+O+8lU5dRvkmYTDPRPz+ic/s
	Fz3XIEipxrhr7fQ5zElVqR3q4clQRNYoNlE6PnNRAehADmj50yNgocnfjyGqJf+nl8dbnHLFP+T
	g==
X-Received: by 2002:a17:90b:1e49:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-39580f6c037mr12721775a91.10.1787171734135;
        Wed, 19 Aug 2026 13:35:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c3fc6675sm13265576eec.13.2026.08.19.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:35:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 19 Aug 2026 13:35:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gpio-fan) fix use-after-free in alarm work
Message-ID: <634aec56-669e-41e6-9086-cb0fd8729242@roeck-us.net>
References: <20260819033317.446191-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819033317.446191-1-fanwu01@zju.edu.cn>

On Wed, Aug 19, 2026 at 03:33:17AM +0000, Fan Wu wrote:
> fan_alarm_irq_handler() queues fan_data->alarm_work, but nothing
> cancels it.  fan_alarm_notify() dereferences fan_data and its hwmon
> device.  On unbind, devres frees the interrupt, which only waits for
> the handler itself, and then releases the hwmon device and fan_data,
> so a pending fan_alarm_notify() can run after those frees.
> 
> Replace INIT_WORK() with devm_work_autocancel(), registered before
> devm_request_irq().  The devres cleanup then frees the interrupt
> first, so no new work can be queued, and cancels the work while
> fan_data and the hwmon device are still alive.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: d6fe1360f42e ("hwmon: add generic GPIO fan driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied.

Thanks,
Guenter
