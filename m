Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384603254A5
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765395; cv=none; b=sH96/B0BUcaDhcVlOXW5/3Jjuzt4k1VukAYYkoZhklXAuNOxyDUH88TB7Qk0YnwX0tklUTvJMBDpmhZS4oHSMBkcgIH+rq86EKiIWsJKVWS+R5M87lKYs/4JTCF+FpaoYlZDuNH6kB+u2ckpBwD9sRkVMAA0z+psEeLVCB+jTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765395; c=relaxed/simple;
	bh=HEP+DiC6jQvELx3nn04legxg8fd4z2J1ikTtQxw4O0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3qOJ0+o694T/uGBKe458ZS7Cg3+kY/4nwWdykGRjIAcuonrtPIXLZEs/el2GiDiclvQOkWI7KBdw6EeQoHlm801E6K+oKjcPcMjFGCWEH503MJT3+dGm+rAiy9x4tG2pYwOZ5fZDYnHAAkZVTcaPt5JLTphpXABuqbBhzqnVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik3ozHSZ; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik3ozHSZ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13809223fd4so4598939c88.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782765393; x=1783370193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V6RMQ3j2//CIsXFskysCb9hJcebpr5nsrI9QdnpxDDQ=;
        b=Ik3ozHSZOeTq3LLdycJDKIVE+rf9PgHzu/q9Q3W9eWo22cQ3OYcuteCRS4LBxcGA0P
         Pq7IOBP6RWSENlalM2IG3Ia57SbXNAJxIIaPD5LZ1HsinNRWSGOiRr5qXdxrwokZlc66
         QRMPyqZWP4Q2q43/Jl+9MeAgdggWExGKyEati/gltBegjvmliC6JT3kFgNwzmuGZGnWu
         QfcVsYGWpXx0IyX/i1AZhoQ2qChYiaw93fhSdGIwuh5EJ+9MfxsesXxcPdUuBfK5b8yU
         CIQNeu7G8EBuAw/sx64JHSejAme7eRTT4DXcA8mx/mxdmMZuylhlfiYAiLA2cUQdir+w
         vwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765393; x=1783370193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6RMQ3j2//CIsXFskysCb9hJcebpr5nsrI9QdnpxDDQ=;
        b=Fa9T5n7wKaXtu2eZ22csVFVmZEIKsm/1JxlJEa+5bPK51ZroLrbQUWMlzM65WqcWX9
         lAuEsKk0CgB05kUAg2mmMZlxxKkbqyAwUS0L3YL3n8dLrqFLty8FWDhD1y2cYf5c3fDL
         boGbjcNrwJ4fiVpTyGPO14l+CHEluWLNfMI1XXPKejlrJdZEvuCEjeaT6afrXNsSwIe7
         1rfaeFqua8AoheqJdYItdr/uT9N0GYY2krociCCoK+v40/32Z803+oM3EslKHb3fvKiV
         c20M7ZkE1KfkYfAdjv8p/6Bmiwlf7Dvoz26M+4jM2rsULTwbnZK6+2vW40lS5eGk/fZj
         W7zw==
X-Forwarded-Encrypted: i=1; AFNElJ8nHBTIj4HAJ7nADnwchReVb/UEjUDZpSNxYlCwXTwrZmG7krAKc7qURgMeBMeMMxzbRSg28bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0l7Av/xm+7qiUM6lerZVwwtSfHg4vYwX7uAv7zyWsbGwxt19
	0iRz1nqrP+HPrRRneYxCoKriXMKij1aMhWNgexaItNi68N997zle16Ku
X-Gm-Gg: AfdE7cnQ5uCm+YlsyM8dgImPM5OP9b6UAAfNV/Ck77JKwGzFpiVX7ja5/5hTT18a2J5
	iji3Hh/bYbr+a2aWgxXRsw0snnCxjDYl0sKezw20tVcyWsA9Z6eRYneqOMgnQhhTkVzzDhlhuMk
	kB4GhM0Ks6FjpY2ExKJIRsDZG3V1f8tKp4t9FY330Jgs01W9yjVsaDAj3kJsK6gEXoDLsmb+vGL
	qCa/hQovd31IhN8sPHi5YBgGTfJRhqCqQxaPGDiStpEOHK3v43AH0oqCcMygvAa2PRV10mcfUkE
	eKoPRh+IS3oCsA0qGzutPHuT8Evud3YDG2PVF/NIy5I+V7utcYB1OCEX2KC8U3FZ8ydB1e73tB9
	90yD2RhHBQaIm67jP/6h3yb7hc2NYpqI3FazZvZAqoqpjHb+O7e+KIziK3iS2Wchq2hcNrxHUB1
	SNb/Aow+F8y4XMKYMsxR0c5fmSC87PCL1kbvBe
X-Received: by 2002:a05:701a:c950:b0:139:ed5d:5ca7 with SMTP id a92af1059eb24-13b2a1ccae3mr523917c88.48.1782765393315;
        Mon, 29 Jun 2026 13:36:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab21932sm845147c88.5.2026.06.29.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:36:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jun 2026 13:36:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (ltc2992) add missing 'select REGMAP_I2C' to
 Kconfig
Message-ID: <9945a3de-6f5a-442b-abfc-b32df3d40771@roeck-us.net>
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
 <20260629-add-kconfig-deps-v1-2-8104df929b1a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-add-kconfig-deps-v1-2-8104df929b1a@gmail.com>

On Mon, Jun 29, 2026 at 09:17:40PM +0200, Joshua Crofts wrote:
> The Kconfig entry for the LTC2992 sensor doesn't contain a
> `select REGMAP_I2C` parameter, causing build failures if regmap
> isn't selected previously during the build process.
> 
> Fixes: b0bd407e94b0 ("hwmon: (ltc2992) Add support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Applied.

Thanks,
Guenter
