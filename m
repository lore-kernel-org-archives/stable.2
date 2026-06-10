Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287336A355
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131779; cv=none; b=lyMoBpoIKu83QqXpfEg9OLctyMCt/yVgPTw6QmYq0mA6Nxas9GvZKnJp5kKBXZ46BXp34W4r+JmyOpU68n9KOzi8blLMEwDNcAFqFrzhhO3pZ7epcQe80z0x/NbnX0GfYzVdO3lbcDhZPEB57+vVaFYdQlpEBFUweTjl81VSLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131779; c=relaxed/simple;
	bh=8f/3NqncAopUkhQQ7pVzzHLYV7a2fGjbRa0tql4HClA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkxDR3xFD6h9C2YYhkIffWTMqtiZeMSghX+4Og9qMuiAabDK6qsshjuQ10FMOeIeJCpDdJ+bUCAXdOcWdnES48/kxhdoWF08XePtfVbqJ+SiXv2nOFWKocKSwLxXVAYu9Sy6U1TtW8jbeFXX56OwWiNiZAwRGFpMzqzSOC81TSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhN7oK/b; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhN7oK/b"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30759632453so1898460eec.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781131777; x=1781736577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iI334LxgKLmlRyNgL8Ur4M9ac5DP95VOVSvPZmKZ8RU=;
        b=KhN7oK/b7a9RnLa9mMF37ZK+61y4EPpJqL/eyVcaOOi8WXls07hj/HNRoHXMc0TLv2
         q1yN3KhGDnEuTziYHIHOhESubSuGRtGdqrfLmJwuQGt+ySMBlnV7KEG/rf3tijK4eZRa
         PueZi7+rCSNUtJqMUC+u7+qczgWuqThNgX5QehFr1eGeGs8ravUBC5gPlIR7Pt0yn9B+
         ytYzLvNC6/1WlXASHQUIXM/LIisIZrdlL2dYk5GNBUs7oBJhjpYLOPSs304IAI5jq17a
         Vv/X59nrCo0YGwd1Gnv5aYro4rimJ5bOTHTxpTPbtMqT/HTcISaeqtUpkkYr5c46aMP9
         viHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131777; x=1781736577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI334LxgKLmlRyNgL8Ur4M9ac5DP95VOVSvPZmKZ8RU=;
        b=Fvi/767zBElBC8E6fxFshsm796ESmH6BUbKHi5bA+MbvDcbeMwHQF3OL7k2L39J3Dn
         jEm02M2m0TN2jCeJws+aY/1EQh52BVFcux6ESq4leqbXSRbviHFpnZIMx6XqoriiB5Dv
         qUbrCJNnQKMZtU11YnmpQ2lMQrHBgur1Ns0ivw6FcyPjQ6p85iJXC9NOkIWHFtHjDT4H
         a2VeJ6ulqnE+XCAatvEIA6LQzgJityXfN2Dmr9sExqujpfM+/Kzoj4ieM9Q2V/t1Yx8g
         e4PBhWvbEhWVBqjSJNpTcNeLxcwmsJU/6D/vxVrKOK8JOMqIhj2O+DF4eKS+PcCJ99AB
         Q60g==
X-Forwarded-Encrypted: i=1; AFNElJ+EGheXCH8bcRFuDtbMIjpiC13m+mLEQcoz463Dfcof2uZQ/gDDVZfx+XqW8NLxk9f8p9vM5z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZYzAMEkO2TG0+qSqDbRzQUKRlSLC1r/qYbyPJJytIvyKS9pU
	0+koMhpSLuKaLFNjYJlzejmOUoftVOmZcKa5CXdcOEcfiF0KXXQAKW79
X-Gm-Gg: Acq92OE0Ll/hgTOZLWv5PDwvbyF8inCeYhQaLj7/g9g7cZSxHv01Z3ricBQIfSf4++C
	Eu/rrUnvWKRg1A8LH07e80lIj34v/EQtK7KVycRr/ftYrfpf/9g/Xg44z+VpBzERMVz6paXHD4H
	9maeBmASiIWnecPyyPYMcKpy72otqRNxowrs01sLx7Q7BZpyfsRq4CILGfbs0yZyQJd7Mx4JTlH
	WU4+aRwW80CcAlt3BXXp7w8ha0gF190LE8JOO6jBsUXFQxhR7gdBaK3s0SaOtAbESXRjYL3ipXa
	2unr2nHyeZtGqW1Ozxe5qspr9/cgHxqXIjYCUhPDjsYigpb0IBwpX6eauqbTa80gZfslmuo7zNl
	TenzdC55X33DPiD6uLj6+m4h2ID67viwsnvEsGW8QQ48Q8vOqFWZ068yWk9toh83119taZ2889T
	I5cMt+e2KrgqRUBAepsy1vWwuc+wT+oRizX7pouVzZj3RgY56XtSJEDrQC0PPfcm4LUZhFut8Vt
	D8=
X-Received: by 2002:a05:7301:9bc5:b0:307:3a6c:ecf4 with SMTP id 5a478bee46e88-3080465303emr215050eec.9.1781131776830;
        Wed, 10 Jun 2026 15:49:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm39841199eec.21.2026.06.10.15.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:49:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:49:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <ainp9-NDND6AFLWk@google.com>
References: <20260507164943.760009-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507164943.760009-1-kris@embeddedTS.com>

On Thu, May 07, 2026 at 04:49:43PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits and use the scratch variable for the rx_buf for
> both the 1 byte command to and 2 byte response from the controller.
> 
> Also relocates the scratch member of struct ser_req to force it
> into a different cache line to prevent any potential issues of
> DMA stepping on unrelated data in other struct members due to
> sharing the same cache line.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>

Applied, thank you.

-- 
Dmitry
