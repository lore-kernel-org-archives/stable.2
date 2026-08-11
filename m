Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6C44D01C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464962; cv=none; b=KcsWD1qOe+tioGwsE7ZSqukWCEmQ5f/wRDJdCbQtaoJWBGfcb2zeCO69gONW+Sa7gfpgbP6slsL4Vwy4OxOHQuLX71zRq2ahn/aEy+Rxfu0n+2UB7QLaumqQF/wFqKjA7SWBPNRxOw/+rfXAqrbSM6cN6jzTmxrvrjTt5CgR9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464962; c=relaxed/simple;
	bh=JS7D+SgbO2rWylaJpeRBSa2yY/t94LjRjYNzDF0WYsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7lCSwRNwENlZycjllu1pDMA4AADHW2HZiaCPIFEC2SWrCaTJafOhQYrQdqyI8ltTM1tKUCPWysCN+YpXFngHDLcJPVMKC9/lvHsaeF0KeCg3VC1UIjVK3XKyGleKokzbTTtohSHlSvRNIAD5gs+tiqcA0mWycpUDrufilZT3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekim1aHR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekim1aHR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90a60a3ee0cso20576d6.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786464960; x=1787069760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqTXzLSqi2PHpBqXcfI0CNlUPAV+a1jDZqtX7tQ4YaA=;
        b=ekim1aHR0t22v+zAL89e6QEnzmHeK0V7iMwoHogEbIUGFblaDROVsce4xyiCbAySHy
         5ToCs/w0j0ytsWcOmuxAgS6GIoSZa1r/8enOV1PAmmeNxURFzGJpqPOE5vGhj2lTPuu5
         uRpz3m8F/xlauke4tmS+OuXp5wJqutEdfjJ7dRHZbrHs/VbUHRGq6kuuOF9h0beWhni6
         s6+HTmGPQmQJnAUzClTJ2dpnWxp59l2bV2HR08/2MpM6v/Q/krSn+IH5UuqfYsCk5Pio
         O/433LZm4xvvK0xRGU72Mgm8i+hMwVkV6BBNR/717PG9vKqoAFnE+Pp8uSl6ABl4nmah
         STng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464960; x=1787069760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqTXzLSqi2PHpBqXcfI0CNlUPAV+a1jDZqtX7tQ4YaA=;
        b=B69AMaAOM/JcqoalW9PR51wsLbbtSZmjSRQjgcSf5Jvf71p1XBFhGVQzDQFixuEeU/
         fAdVYJ6eX60QULhFDVFEWquQUiqKdrs4E0pJTf4Sz4mglcJsV1TLA9scKt6zjkzqf/DH
         34Jzj/VQtThuJoCENfxnkJgh2dHIwUfpVwHWFLCI+pHXgGwFywnvkKeE3QoWRHNJcbAJ
         yrjKATYH30BzsS9YelIQvMWF7LQkmIRTFblAVUlk0k/PnL+R/QDt7hy4vXSLUeWFIUmE
         u5Tor0OXpeMUOaoFCd3pJBa1Zq8U21NMJwfF22UR4MUTMdXj9Cn7BBDsCvWn5w8foJu9
         vypQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9U9X9M67BiTZbN5eCyUzg7RJ66S2+4FCBCk191F10/JSpU8k84CmgaDUs46cu667bJ8uJkjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKvX5BusoI0abQH2yVUm//IUeZTjgTVYEHXYKptvEJJwFjObb
	E8wg+RNq87tgpCXvaIV7jY9rBopVPk5wGQVFizrScVggVV95GOEiz/YK
X-Gm-Gg: AR+sD11PXZ6hm470rxzHSIxKntHJ1SvTYF4Z1el9pfAh4DkpaBBl/htd0m9iiONw+It
	oTZCQdIcrxE2kxVpMHHcDuFJgrBpKvJwLj8rUa9P4wGHJk3x04nIi2v/047qpVeNGlEKcrwKon2
	bCYbfuNWNtFFhbpSzK8kNG8/nrarRBOV4B7gNGjccjubpuS6e4ZoOja5cf4z5lQlWDmeLn3DfMa
	qqYbDEk6CTqsiRa/nychdMwo67V6lbPqocAmfCWmqRD9XbCB2XqVGZLDy3nu2kLpucsrmocoVNq
	oaGxM0A6+1Me7ThKP50TEjDFbYkqX8ALENN3Rbk1I4X1Y4UClXRs/Wn318Gq1onx1a+IL9t+s9/
	0TVOXPczvTgK4AsLeozu3Gix5us/8QciOtu16dgvDSLoYJTfCyLRj0whqCx/MrAsedCg+v5GoNG
	YXXEE8RWuJWSoeUqV8O09ozfYnFoteCftsTauhCMI1rao0tl2CHcsDC8zgX2G3VC5I9uYaTJfvo
	83qlLvdtqNTY/m/zPZgrBHH9xwlBfDTmec=
X-Received: by 2002:a05:6214:5b85:b0:907:c025:e4 with SMTP id 6a1803df08f44-90a667db293mr50971636d6.13.1786464959922;
        Tue, 11 Aug 2026 09:15:59 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L ([2600:4041:5d54:8900:9c8d:ddb9:b1a2:735f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29a1f3sm2428656d6.17.2026.08.11.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:15:59 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:10:49 -0400
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <antJiVOAmzR5LNPe@CW-D0XG2Q16P7-L>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
 <anmKnlBmOssfqdbL@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anmKnlBmOssfqdbL@kernel.org>

Hi,

On Mon, Aug 10, 2026 at 11:23:58AM +0300, Mike Rapoport wrote:
> 
> Can we put this on top as a separate if, like
> 
> 	if (is_kdump_kernel()) {
> 		/* disable KHO */
> 		return;
> 	}
> 

Sure, I agree early return is nicer here. Sending V2.

Thanks,
Maxi
