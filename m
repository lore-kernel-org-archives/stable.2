Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB7317143
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765354; cv=none; b=CNuQ7K1cNcemlBdFFnOlVKlyodQ1HT8ZajwIKq3g0LcvsOO46LsNu1OSmvUDZUPiGLCKqT4rSt8eYvimkvB7ofw8ROLNbuLXy7fF/MtUZOSfB/RI0xwHA2+1sYoZXM6DUxA/aKu5ow+8oKWy4k4UKYWdM8TJDYk2MV9jNoF559A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765354; c=relaxed/simple;
	bh=GCkRijoG9BNGbYpuyEvzcF76JMbdLKs8xL0i85od9YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdrUcVoMT2Iu0KkDcpCJO42GBSaLaqp66IAAuly9AH2WCLVpTj4EM//+E0isgc9DCXo/zU4gHeidHRdQiYhXqCntjV35Uf027WQBbx08+t/6Aiu17nMe+xLJ/wp/VXSbf4Mvs0tzXydcmE8f3Ou9+YScCyb7+MsaJ8yvneWhdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwRLG+5y; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwRLG+5y"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13b2b92b0bfso23440c88.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782765352; x=1783370152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUL654ezc/90NPCUZ/g4JqvtVBcPucQUCRqJ7rGnxFE=;
        b=UwRLG+5yVfhPcGqPRdBRIMmXk6kmT8shTMm5WKMlgW7ePZuWwelSGPLJ/h8puxuIjg
         zccnSsmrvmQOjW1ICcy4HkiD3MC4ZejVHxDFD9BhHmi4lr2VnDxudzgcZlypSNo8Py/X
         oFW/1kBDsNkWx0aZqsUPz6DOCRiK5gRZXbagNOjPOxq3W85vf3OFJEKEO5+PpjgIADkx
         zfppDnuiGIFmeHuh7UtlRiSgRkuLvmL9bmZrDI2/QCnujS9jSzdt2g5rUMS+4TrDdZ68
         +g2DQ4odz1AHKKAJIYIFAba7+3T8NC+wpdZ64ZqZTON2dgAbNmfBAujymn5dgjlxEYIW
         OiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765352; x=1783370152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fUL654ezc/90NPCUZ/g4JqvtVBcPucQUCRqJ7rGnxFE=;
        b=DqvWAFTfTie02wBYF547EyVp+qKsk+a0JfbT4aLzr44zWoSv2VrsGIhLKxkUHD/pVf
         gDRq699i9S8X2OjnD58jIrgdYFjImagShf692EVSNEVnSsPXOBaJ42MFW114CBDTiH3n
         qe/JAMOwbActxalvdudZ8OrilAYo4PLJhc7WSbrLNXEgZR0QA73HvFDct/6L8yY0Yc8n
         5JhHWdro+J7Hokpa5/fUQ1m0xTs6fI8G9rxcrIvg4L1a3gbDx8taFxkjpeYQin7KboZo
         LSzRxcSsRmdS8gFlLjgv1AmMyHL9CT8Ijhvo37ZCfQk2F8Y4DCS1VIlyFVdqQiul23nC
         2RFw==
X-Forwarded-Encrypted: i=1; AFNElJ/RfbajjVsj7W0YDQ6/A6A7wyRiNU67EgwrBXeaLF4egFBItmM9MHjvK4Dh1NdSca8uKSJNpIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2qB2qLPHyvDcwrUwL0+DTpo21jGOZ1tTe/87YSG3SAd8QAv2
	LUuiDqLUDLMlSZNSKBqO9GWXDwYjiAl7wBJPJhRaQfdjcBWqAqIK9yC5
X-Gm-Gg: AfdE7cngtWxzrYxIZfthCaIUf+qXxIeLdnGoSSOVzGoykSpeNZVGVPxAuHQayy0PoSC
	7WW4fiAmm1XHNwOquz7nqIup7Y74JiZc0ZkgpYtDgcSLfWDbsf7mdPxPv7Lx6147n98sHEm7MAY
	2cNTCsDqwGp2kieKWTrrpBJnn0dZqxaCnWWCEeqM5luntod9m31+p9+R8xC/Hcsky7K2L7zM8gN
	MOGQFbiBRKUEJvJsbHQeYsSv+q/kyklaMokDQaW8kR6N0VcATcvW2/32vVHp52/2cWreyExCOka
	FNWJzJx5r7FDBzGe7UsjWJsf460E3fst1BEXTv+p39iLuWs2aW7s2NKVOmKmuuv8Po5+lXfiJfG
	yaENlbNc9oqtplLdpWM5RoaHSd/IbU4fqe0dxnlOFY0lpu/lM3qOV0/Jp9H159yaoxskniP5Hd/
	HSXGV4Nkf49soHSMJG46IplJBfRg==
X-Received: by 2002:a05:7022:2389:b0:139:78a4:f57a with SMTP id a92af1059eb24-13b2a1c4ecfmr571385c88.23.1782765352356;
        Mon, 29 Jun 2026 13:35:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab30047sm803621c88.8.2026.06.29.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:35:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jun 2026 13:35:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (max1619) add missing 'select REGMAP' to
 Kconfig
Message-ID: <f1738266-5d64-4e42-8f88-71a9126de021@roeck-us.net>
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
 <20260629-add-kconfig-deps-v1-1-8104df929b1a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-add-kconfig-deps-v1-1-8104df929b1a@gmail.com>

On Mon, Jun 29, 2026 at 09:17:39PM +0200, Joshua Crofts wrote:
> The Kconfig entry for the MAX1619 sensor doesn't contain a
> `select REGMAP` parameter, causing build failures if regmap
> isn't selected previously during the build process.
> 
> Fixes: f8016132ce49 ("hwmon: (max1619) Convert to use regmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Applied.

Thanks,
Guenter
