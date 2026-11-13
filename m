Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539991;
	b=h1/L7KCPEUrOIgFwjDq20w/w049279w2dnTsqnvjA0/PEbbkDnBnvpiyu7fHs4rgx85J
	 TKRKMGF24pRBc0BQvc6jq/RiDgeFddaophqv4Hes0n56Yc91Pukx+OVqOCmuesx8kNWOR
	 lkdBkzDiaUiCwlOgSGkvsjiIZFfFc7OuoivuzQcaImhpW9jHM2x+D0i6HPOPuFSEIvK3t
	 dBEalm1/zECmv7WBbGix6omQzzONy0Wdk7DedEIfgyRmU7826sCP7K6vWjHEFy0tRNoip
	 p8wjqa9clfiHPS+bdUH8iffmQZ/qWMdd4uhko5AGjh6mwpg2ISWt3lTVT4x+lzx9IGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=voIys8EwQkhUIwCPX9c3iOQmu5IoCkbo4OFDmG1MZKU=;
	b=UgyaXTiFPaTfbn7pPSd8S6haBP/KOPLb0rWwkAFIqJS7m0tyUWoyPgQt/7p1y235P+IH
	 /T3za+I9NyVhc/FeKGCKqJiCCowNDlLHTKHuy6P0tnaEX5R2MEeM5ksCdINDzszKul/6C
	 jxoXsCB17yfj3vZmKPhY91xoRqTEWiwdQdQMP5OVyoyzPccrEmqI13jiFu3Wx5gygX3Dy
	 lY3dxpXaD/AcYU2KXTEfKUDrRwOhL8XW7jrTPkcUa6Qf65bRpd8P6GHqldnjmFKFXmthY
	 xQMj5j+punTD90l+GDQdCotwSbP91v8HEmZkUtvTWmKjcXxdhFPGIbBdJXaV/HCu9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inbDH7TG;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CA606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 902CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inbDH7TG
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a60f90a924so178971b3a.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794539991; x=1795144791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voIys8EwQkhUIwCPX9c3iOQmu5IoCkbo4OFDmG1MZKU=;
        b=inbDH7TGQaS8YIhofdyopjaj2vvIPI0MTAVjELPvx6T6yv1rExDdkos8qLpXEzBV8s
         rxjjuabXt9Yk1UQfzs/6nVzU8OqKotcTOuwtPs6quzFFqFvd3g26xehO7hCtbIFbEHvG
         XzrnV0CaAiiDqw5y2bz09mWyTLLB4NlNw5oW3Uat+GXEqGRxgb0M2Z2FLdgXGNsKljLH
         10Uf8DjwaXdkPK93j0BNkU2N/w3iGR3O+45l97ydQCR6qVMOqmYat9Sd6tFFdycaJT1n
         sFDsiOm51XoRPLfzQWd5DVgadoQCH+7WGh+zac5y6UpmlEMd2ZANkGOEff2vVS9TWX0u
         R75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794539991; x=1795144791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voIys8EwQkhUIwCPX9c3iOQmu5IoCkbo4OFDmG1MZKU=;
        b=gwE1eBoBtI4oPQ/NIBwY+VfUbQGAj2WpSjxLrwyX4OEGkmu0XdvGs0jMG/0PzPTEQA
         aupdowoFaPmI/ebmTisGR/hy1QeX6u7hY7CRUT02tk/snmv8GQ2klvuEwyvDqc60ZJGp
         r7yESHneT4xany2DWlyLq9tkwZQmsXwKL2wSQf0HyI54QZMrPVMJk6IfLmpwVXFsHNbR
         fsy8etPIjAVDIqHVjybWHYep45zcqPQoNjh75rm7zYcz7iS2+7opKiyapVOe/ije4SYv
         TcWxM7gwRSBCpfspxcqri/d93Zvcq7lc0GjEUii7fxuwvW0YXKgipSP+CipS2AhSu25t
         9AEQ==
X-Forwarded-Encrypted: i=1; AL+hErE61j/12k7kc/pZ4Y5ZHtOSXBTkjeiYFwf8rHV+5P5TcWhswvy58HMMnu+R6T7XMuUEAYTYRX8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EeIkG5ecgg7LP1oZqRVCDBznjji+7M31eSmQVMP+XX16Fp7Mw
	GtAO7HZzmy0RBKlaRXGVN6SVHEmnLCP/hjGk44hZ9LBkoYj9L4a1ENOx
X-Gm-Gg: AYBFou1H5ArC7PhEk6Q2j14iZuKi1GnRp4UG9Zxok7MN3crfSUrbar+K4UMQfeqHPAm
	LagoT/XiiP0+Ijf2ECPdDLocMUAsur+evFbLarANbiSbILqH95KtLN/3+dQ7FJqkUEkgUhw4d+z
	4pwPWOMtLmIxwneIiS065Oh+trwgWR8UBfxPcIYYORqYycpIxDREnMxMpdwk3E4+C8U52VURfqY
	tQj1XcPXAyre2s6/jMvf5NVpVLcy825LBfZqWcs2N5DmAJjxEytB32VdRGXKKT/Fj66D7KRpSdM
	wCGA6TUrqoVi3cN3sMKyVB8dKIAyoQ63lOpHstZ5AN2UcEjqltVWYsd5LGlMzgJFea8ugzDRLiH
	NXKOxEteClBoeFG9YHuTmz6D1zY4j585XiXIFydiplPOdlhinIQ+yycbLXzQHdc895MgpxA7Cc+
	DpOIq7ykVNCS/+IBxhXm4BtriXDyPsQNqA9Un8i/HxuLq6Y5LVqNmdKR8UcgNVn8OoGNhv8CzA+
	9L5ahCjj/bJwXZXlXKnQFymGNfk4kVOZg+vVWaA+Vul2PH4phnZpON762RWGcJG9xXcCH6l9dVe
	EcXL9pciz4eKCl83JQQ6YtE0tvlhnylMMDMzDCXQ0AkFyMqx
X-Received: by 2002:a05:6a00:1989:b0:89e:33ba:54ce with SMTP id d2e1a72fcca58-8beb753d177mr1447093b3a.46.1794539990691;
        Thu, 12 Nov 2026 19:19:50 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed243e643sm388162b3a.42.2026.11.12.19.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:19:50 -0800 (PST)
Date: Fri, 13 Nov 2026 11:19:43 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
Message-ID: <20261113031943.GA39484@rigel>
References: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
 <20261110-gpio-desc-flags-atomic-v3-5-2f463bce8086@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-gpio-desc-flags-atomic-v3-5-2f463bce8086@oss.qualcomm.com>

On Tue, Nov 10, 2026 at 02:47:05PM +0100, Bartosz Golaszewski wrote:
> linehandle_flags_to_desc_flags() and
> gpio_v2_line_config_flags_to_desc_flags() read the flags word with
> READ_ONCE(), modify the local copy and write it back with WRITE_ONCE().
> 
> The per-request config_mutex does not exclude sysfs, the irq core or
> drivers touching the same descriptor, so bits they set or clear
> concurrently can be lost.
> 
> Build the mask of bits owned by the line configuration and their new
> values locally and apply them with gpiod_update_flags(). The whole
> group changes in a single atomic step.
> 
> While at it: rename the functions whose semantics changed from
> "conversion" to "flags update" accordingly.
> 
> Cc: stable@vger.kernel.org
> Fixes: b7adfb6076ff ("gpio: cdev: update flags at once when reconfiguring from user-space")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Kent Gibson <warthog618@gmail.com>

for the series.

Cheers,
Kent.
