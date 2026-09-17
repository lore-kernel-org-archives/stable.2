Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF031AA8F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604764; cv=none; b=JOl24T5EmIXQXrG1TfO9Z8ICDDi3u9wjRImV/gw6Tsru8q8FYhTY8x+FBYla2kQVh0+KPEwKVN0BsLxWQa0IvIJh7QWSbZudScJXTBHb3LfYGmRuL21IsKHHSR/ZoYWU9/1THI8FaWS3VQD8eXFi9czMpzGEjmlZaC3XFOBd+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604764; c=relaxed/simple;
	bh=5b/u82wL27/Fu9PH2a97FNdOABh4pOizTMteEoxSlJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSA+4pDlKVnWbmcL22UfS8MD//cWTAeBc6Gw1MEVSdsM/8b3d/3ShJr/P2an7FaX1iXRI80K1q7U5Vx139tzTQG1wcf7mltHG2xPdZHbYVQac7BO8h9PVYtYW3389iebmEW8Xai+AxsslEvYN+H3xkm4DE7SqqLeKmPVo6hfszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7IQBgPL; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7IQBgPL"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8686f46e4adso225804b3a.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604762; x=1790209562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vV88gSyI1c3ZYT2h6e0lSF5RM8fB6PlCcIwJXe36LlM=;
        b=j7IQBgPLjn9sH0nV2YvmCk6T2O2+TXlNsEyPEGYiRAwXEDeUO4+RwOQLwZnua0Bgk+
         oO4B1NnOarcDEGX5DywGc7yhbfC/15WtUOrEIvt8iGp9pJq7p4RXMITE0onw3QS3zoo0
         8X+xPaA/cKJk5OVZX6Z/SzS2J+mUMUHI93b70jbiMsbuzSCVDrzy3hrVbceTBaJfVO4C
         rsWKGiYiJUl6oLibqw8Mbbe5Xg/9beBxjp3Np5KHkItCZ9C36gKe86M2GPkMPwvgPbOM
         BX3uJIShx5bfXFvg6XLIbO2Wh2HxmU+8KDrDZLIX8i/6/RM1VRYs+j68uuIN97ZJHkJA
         tncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604762; x=1790209562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vV88gSyI1c3ZYT2h6e0lSF5RM8fB6PlCcIwJXe36LlM=;
        b=YAiHrRPBgQK+zsNgfJSmNvkLtwcCx9TBL7bxODzXllKNdx6XfMGKlGWZWKWXv8sS/Y
         FRlciYEw0bQbPswtvwn+zP867209UUTVHa99FnGhEDpof/+SGrsEppHWdvc/RZSR6RDq
         sW0lYwa9bKm7BolMxXN88DD9hAVRD5olxNtpeSxIOE1xxo8W3JaxzBqciGO38hx+WWrw
         RebDO9hlQQEYDmfWrdVnGsT8M8kpKrQaveH/SbhBinlgXz99I+P26MxTCSAe4xt9yj3h
         PFCYllWaUf24AgCXtY5VIylUhAFSOBTzqCEmw8FockzgraqpetF1XW2jkaa9T540V4Sm
         1gwg==
X-Forwarded-Encrypted: i=1; AKwUvByU07Pqsq0VkaeKTtjuo4lH0gYWqRBVU+UUsXmvD1ye04UOrppZIaFzrsBucCw2zVD0e+0KEFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ku9wOvnE3pZaKSKMSqp6P5JMUocQAC/JBRkELa8hZl9PWs4rFT
	gqze7WJTo0gi0sGsGFB+EPeiyLf/uECFDmXM4ZpwpjHCG09IbOrO+tus
X-Gm-Gg: AYBFou3Rv0C9UrR+c/KvZkHGQbW4myWkb+Rl4AOcZKs/V5wAoQucAbCV7AqV6s7Ys0P
	Y/ulPT3HiZNOAOrumaNDjcHETmoQJVx9VyNwWjP1G5N3kxkxOO2ffQoSNpct6sx7aiku54oEkRn
	nZPG84D2CFBRR6J1BT6NpPe9DEuesMM7jKeo+iEVv5hQWqUIqo0piHeiK9re9AKDCHd2JymQ8TP
	HuSm97O9hbDz/eBGeLESWRdZCOuy2yXbtOZjbsIiDGYclydq+PCXrUFENn5KlOo/S9YgoikXJcT
	Oh4adoJhD5rUoeogtxGNP3bcT1RyB+eErMS0PznwZyJsRTUq6cC4eL8xeLr0gfQAKRsYFhrywZP
	ElqSq24w1+KXSEOGXCOOIcgCFubfAWViER1eEkdydQbhHuFj0P+yMB+NJhkivnF6ls+Hn7XNjOH
	d6fAiwz2n0jYM2n/fX09mj3W1B8K071O2OcfIQRMSZzntIokcwZQlM3RJIql4k/AIY09iEvISn7
	SicfeTU2il8
X-Received: by 2002:a05:6a00:440a:b0:870:c2db:da40 with SMTP id d2e1a72fcca58-87239a9dce3mr9776123b3a.24.1789604761569;
        Wed, 16 Sep 2026 17:26:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872025dd04csm1926956b3a.60.2026.09.16.17.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:26:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:26:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	mikew@google.com, priyankag@google.com, wim@linux-watchdog.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp5100_tco: Fix pci_dev reference leak in
 sp5100_tco_init()
Message-ID: <8df16733-9a20-45eb-89b5-c396244f0062@roeck-us.net>
References: <20260916170511.2086199-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916170511.2086199-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 05:05:11PM +0000, Wentao Liang wrote:
> sp5100_tco_init() stores the PCI device matched by for_each_pci_dev()
> in the global sp5100_tco_pci and keeps its reference for the lifetime
> of the driver, but neither sp5100_tco_exit() nor the error paths of
> sp5100_tco_init() call pci_dev_put(), leaking the reference on driver
> registration failure and on every module load/unload cycle.
> 
> Drop the reference when the platform driver or device registration
> fails and when the module is unloaded.
> 
> Fixes: 15e28bf13008 ("watchdog: Add support for sp5100 chipset TCO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied.

Thanks,
Guenter
