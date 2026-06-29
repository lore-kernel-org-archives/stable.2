Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86F3A5E94
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748344; cv=none; b=AKj0Jz4GPe7DJah25Pr7XmYMNHY23ihzvYifcENO1gpruiOsAJb8UzG7GpN4oFSuIR8L4V6x2eUdUUf7vpau+OjinqJKe2JUK/GfjojGegmAjxM03sGz/nEgOII8WTIv65zXKMs0Jvc+KuKdJO4KKTBz0qLrnoHhV0bwnrp3gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748344; c=relaxed/simple;
	bh=cvcM/ZJkq9K5u+aJXpeMJwGY6cJYVvwJRXjmMiSt804=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEqlquhKvHdTpyZGkoNEymvM+aj4QmPLEfk3jebgAOYQLFwpOhz1hLWQFz+I0r1M809mZ9pJTZjYiVTl6gqW9ldDPwLbcEzhVJE+oUsL2q2zbbZ9X5kMzVVrorfC6KHMX+dxZulf3BljuZKsh7X6olGMwJSHMuL+NQdkRFYARZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+viujm6; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+viujm6"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30e7eb50b83so2124075eec.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782748343; x=1783353143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIRBa4MmxxU4Y0T+DwH5Gv5lAJ/ryEEkU3ZF4zzK4Zw=;
        b=b+viujm6ijHfSLlo1lF8LS1vc4oaF3Ig/NVGNwp6RWb+S7rB43QkP7yuH88r+aQEYf
         sj9IPRWKaL5KQ98gNOZ37Wm0C+ZTjPO/HP8QRm6gzm94pO1ZfVZs1mz41jKYHmYiRWfb
         Tcjbp0MrBunbxn9AwhYmhisVczLo3kb2L3De7TfZK1/DwFzROpIKmv2fR/kYqi6yUAYa
         rr1HTmTzAjafNrtn0aRJYeObIVnqQuuqlNoK4w0a1bUxDSD4UlcT2mm2RNfOpithEp7p
         fHG6wR/+GIh9inYzv3T/28swOpYGXBd9VQRWgXkCOQQ8/HxprG2V45J0k3Xma69mm5SP
         3njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748343; x=1783353143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xIRBa4MmxxU4Y0T+DwH5Gv5lAJ/ryEEkU3ZF4zzK4Zw=;
        b=HKKYCzcL08cR6uHZrQe6HgHHxQZHcGkGgybNNYfPDqY/MzauQF7S7m5bgxyRgnp42K
         Zj6FxnHMKyA11zYw/G/ErUNoBnxJXmus8bj9NaRZwM1eq/hSql9UMuPvKbWK1E/VGe6T
         NfVWiVGLdgy7QynpLjNOnmHM4Hb5bVwv8pVc/6MN4MWAkIVRgO/mMf/8e6h7QtUQNjjZ
         sIQKAPpyK2HrizleYNoJo2ZXIWDCBt+moaZgaBU3h/kgwbEDGSgM3CnCUcMyTfi5M3iV
         7yrxmqkk0LuqrsmtYrFyhnIeflMqJsyGrhxj/mgytJWs3LJK7vnLMQo187kwJ0yMBxgz
         k6aw==
X-Forwarded-Encrypted: i=1; AHgh+Rpe0Iqy1zeA/HJNmEt8aWvDaKZxkx+LiFviV9ud3xQ91mvZMAxKhanrhS76keNfyA6ZHTUP2Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfmWj43YxFxhEa4BOXds+8nbx4/DI6/jRMb0K0cJhnbYRvuhF
	KytgyFrFUerqmE+v8vSExb/gC5L8HM2ULdPG3YEPnoQP10Dt7wgWWp69
X-Gm-Gg: AfdE7ckXyTtYAC4IjW+QOkwwAcegDWMLfLkS9tQO6SEnPOhnZu7FhtQb9oyhwQVxY4L
	7tMjmYCg7Ms+Y7c9EemE2qobnyGnkb3SFxhtLVZDNgBVomUE43N1JZAeCdcNbObzRdi2kcxxrxp
	FQmT5H4YoHySMqFrvUo5S+v/8SslNRU31RfD39HSfdBiFME0awNtLmsvRTRV6EBWnptCZ+rn/+p
	VhHcA/NoIIERoh2S+B/d1CwRUkEMnEEWxWOSxjakpjAHU6soXUJUd/QXG6ezyX8FH4QC2vqfiDv
	GpGys9HBZw1TuRJbZ5/1TypMW9VDc/N/FP2v+ZfO3Fcdk15eyVdV+cpF4ksjduDGIQUT+IVfNdc
	Z0W3C6uG1UWr8BuH7uSbdms7hfYG7DvlUEQCRbjQpNnljtK/nHt3aqa+URMS4Nrhsk0Q9mghH3X
	BEfanE71w399hfW16Dv8YlC9QuDw==
X-Received: by 2002:a05:7300:3245:b0:30c:1865:d9f6 with SMTP id 5a478bee46e88-30ee11ad57emr77370eec.6.1782748342416;
        Mon, 29 Jun 2026 08:52:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c199561sm55887025eec.0.2026.06.29.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:52:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jun 2026 08:52:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus_atk0110) Check package count before
 accessing element
Message-ID: <b75ac6ee-9d22-49a5-b6a1-fd98ab06ff24@roeck-us.net>
References: <20260619122746.721981-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619122746.721981-1-sammiee5311@gmail.com>

On Fri, Jun 19, 2026 at 09:27:46PM +0900, HyeongJun An wrote:
> atk_ec_present() walks the management group package returned by the GGRP
> ACPI method and, for each sub-package, reads its first element:
> 
> 	id = &obj->package.elements[0];
> 	if (id->type != ACPI_TYPE_INTEGER)
> 
> without checking that the sub-package is non-empty.  ACPICA allocates the
> element array with exactly package.count entries, so for a sub-package
> with a zero count this reads past the allocation.
> 
> The sibling function atk_debugfs_ggrp_open() performs the same access but
> skips empty packages with a package.count check first.  Add the same
> check to atk_ec_present() so a malformed firmware package cannot trigger
> an out-of-bounds read.
> 
> Fixes: 9e6eba610c2e ("hwmon: (asus_atk0110) Enable the EC")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied.

Thanks,
Guenter
