Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372D47140B
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928061; cv=none; b=Vt0JXeX9oRLzboIktqmEYnV5kDN9cvkF3KdfXdx1MfCHNw6edWICtn4u9azDx+64YnAjOdl2viQaBh7tyxnLH5qphXCE+eVrM4wAdM1pHqTSl8xPPNXUhM6fmQ7fClJ04X5JKABFlhdpl3M5y5TtbD2h0Jp1+Fy8Rna6JaSTZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928061; c=relaxed/simple;
	bh=8bS40oV4jEPLs9Cs2elpr2P5JyOnyCM4culKHiPewYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7w4Oq7Ooe/0I19iXf7lK8cHsR8Na9FV/s9jxv9rt/J3zh+FfvqF4O0eHgPCFIVUoZpaZ2Y6MTG0TpRT9Gn5n7ZTRpZuIGyVvOyNyyLjromuP5LoqTsPq/KS/ssz7iHkN8qiX/Dd0rY8F+6Yj3v+c1GjMq2kLK3DbDk0Q/VQEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzPYzCVI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzPYzCVI"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e347638adso1052999a91.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787928059; x=1788532859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bTIogw4TSRkuHDeXsegqU7KIhcr5PJJOjQw48d6uweM=;
        b=MzPYzCVIVYQyyLIja3YyOiiedr3Prl0zqCx+F2B+e3HeyAW43HXlxqsePkTSncQ9jx
         D3lCl95YSTX5uqpYILI+eUq8ukE4ImpVFZ+VAokMq3nb/rBy0vrXpo/7/1XGuXzL0jQa
         qt6Y7XQ7bzBjV8yW8d3XSV0OG37OfRXASv7p2IpI/bW7iVmnZP+m2/EBH+dzeL6m8MrH
         lWVwptsRLM9vJ2qkjzei6vyzaL46rlSHAOG1mwhB32zNYodNZwa5gbbMNEgUI9qWavT1
         N8ETDQaYpIhMykRO+V69zJSYZfSuwn68fV9nnJa80rBr0GvI4C+RvFji49KSfReQTwXM
         TG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787928059; x=1788532859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTIogw4TSRkuHDeXsegqU7KIhcr5PJJOjQw48d6uweM=;
        b=JXat8nKFiTOwEo1YCD8oCzEdfq+GDiDug0URfs/ii7rBq2a1NTzjOcLFW1JSzhi6oP
         2p2Nzzyn6sV1Nr9rqiJYnxX/4Vl+UToQuXLtNWBT5x5waZZZhHjQEgkzsFA6ZAHtZ9VR
         dsSaqTdbMTwaNRaqrU2QcL05VBN8JKXSNcQ0qjXiD+plL7AzZ6wvhG0SswhO8393LjVN
         ywPlWzlMKOXtTxue5ExXDlg3luxWR/f5plK6VNgO9LQmwquFM8hj6H8zDNs+/xeieOn7
         peaGrDPlaBzKuTb415+kv36WjgSEMfnfGqTSyGUOyaSyH9Iq8SZ/gnoWYeCR/xxmuhxn
         LWJg==
X-Forwarded-Encrypted: i=1; AHgh+RqpK4iDqjOd8/+sc8VjkiZ1xQrlDCweGhHWIsJjIYWTxmENMpJT/wsUWX8WLnzbZRgGjwTA020=@vger.kernel.org
X-Gm-Message-State: AFuF++mVF2uFxnsE6QpWd0k9nxVetVP7uHeqio509Poy/9gFayJmEyyd
	8Ujs4KO4CrM0vOjqpYvFPZntD6RYlwLNJWzFjpB5Q/v74gdbl9dAO/r+
X-Gm-Gg: AR+sD10TJ2R8xNJGLcA5I7II3xpeFmtEjQ+80smj3SowOWhKCSR8I44N1v6JrqPJNTS
	ATKpVGs75lNy3TQk0bYqYj7GSEDaSbCCkByL7tJn66tDhDRBMgtDqwJQpHyKN446GXay8f1LGV+
	GfR0FihY65FvnzxIf3Kza+qz7kPTSSRh8fAXX49n+oedztuJsou2RGDDcUutTGnaN+Ca/3JLNcj
	nO8+1Vd+Ge+AvJFwsfs4bkDzaT0kX62FfRLzt26Zcr4ZzFNzWfZuCLT+YwLOBDm+AVeIr4abVO/
	0quG1mjVipFvN1ICewQRoTD5BklVSIAK1KzTe0Ay1KLoHxBFfRUgLR/IlrxMsAp7XM2DKNgTA9L
	MgP4uJf/1yGwoYl/8558nQB9zog8Q+NW3aBPPjTDAiEwxcVDKtVIo9N3DD9M0GfNcJ74Imb5MVg
	o1DCOAn1Wq71ZkceZ4jLvt8GW10AZN7YCJSwmhB/MwB2/BcNkYDGVm7RuH3kXcH5+dUg8LSt/3z
	Q==
X-Received: by 2002:a17:90b:5284:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-396d0e5f5ffmr15894627a91.1.1787928058655;
        Fri, 28 Aug 2026 07:40:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm6759748eec.24.2026.08.28.07.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:40:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 28 Aug 2026 07:40:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Carlo Caione <carlo.caione@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: sunxi_wdt: preserve boot-enabled watchdog
Message-ID: <e1332541-1751-4a9f-92b6-60636ffa0a99@roeck-us.net>
References: <20260827-submit-sunxi-wdt-boot-enabled-v1-v2-1-610d37dccc97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-submit-sunxi-wdt-boot-enabled-v1-v2-1-610d37dccc97@gmail.com>

On Thu, Aug 27, 2026 at 10:42:31PM -0600, James Hilliard wrote:
> sunxi_wdt_probe() unconditionally stops the watchdog even when firmware
> left it running. This opens an unprotected interval during boot and
> prevents CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED from taking over the active
> watchdog.
> 
> Detect an enabled watchdog and decode its programmed interval. Preserve
> representable timeouts, and round the 0.5-second interval up to the
> minimum representable one-second timeout. Use the configured timeout for
> reserved interval encodings. Set the Linux reset mode and ping the
> watchdog without clearing its enable bit, then mark it hardware-running
> before registration so the watchdog core services it until userspace
> takes control. Leave disabled watchdogs untouched.
> 
> Fixes: d00680ed0026 ("watchdog: sunxi: New watchdog driver for Allwinner A10/A13")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Applied.

Thanks,
Guenter
