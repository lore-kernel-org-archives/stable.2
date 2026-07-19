Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125903A1684;
	Sun, 19 Jul 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473225; cv=none; b=hQWohOg5eoVB8UgykGwPsNQ+SBrpwPRKJuy25xOCirqXOpX6FYabEVYh5smsbkYi37kN1pmShGjEWtfltQSRDw9nJuFt+fYPa6+kU5LKJZj++ejzp7M//Pojh4nsojZqClSrIbDIIOyq10Y9En/+VTFaVdMKsPR39Xv87yefir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473225; c=relaxed/simple;
	bh=9O0SETgCiOjLCkeXO1CAXA78MOsEp9iS46buEHZ0XOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQxDrms9rHSYGUobQ6JC29LNpQGBB9gwGyJbxn3HdXtvYdz3cSADDiOELBvl+p8dMJAMFys/qBzqadONsPFmL610WX35Gh0p1bYgiu22QviOwOxIwwVsznyTCY8wQ44esLV5tu8807QIuAifUoqlunkbdbYHjYOJJevHhQbObFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nzqRsjop; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nzqRsjop"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h36JY0Vt5zMlK1;
	Sun, 19 Jul 2026 17:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784473213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQasB/C5wEpNQ7fhFD4oh2Wno80mHliSytH/mtLfpLk=;
	b=nzqRsjopbV8nqOPjTr0IL9Gur7hx+R3+3jfTDthPmSMkndUvfG6p1VTd83RgClxz0v6nEe
	S4Uks77L5y9rLEOb/tdIL+w1R2B+RhRKohdx4QLen/OoeJbKlScX0X4HWLIpt+mydy/V2N
	RJjSsrWpTvAI6vVS3SCr35iYKCxmF31+eAn8n0Jku7mrGpPk3EskAdTWCknuh9gNG4eA1z
	yXN5QIXlpViZWGbXsrJuX7wxNwJzVcF90R/3x2ddNsDTlBpzQhTxnkxeGcYwY16lv826Ht
	WwPIf+fY8uNjsolyJts2J9jRHKJX/FreLUhKai0C3vCEhobH22PLMy6yKbKlFQ==
Date: Sun, 19 Jul 2026 17:00:05 +0200
From: Benjamin Boortz <bennib@mailbox.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linusw@kernel.org, andy.shevchenko@gmail.com, lee@kernel.org, 
	vladimir.oltean@nxp.com, colin.foster@in-advantage.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] pinctrl: microchip-sgpio: add missing select
 REGMAP_MMIO
Message-ID: <alzlLy15fAFPuLSz@bb-82jq>
References: <20260719094427.1328725-1-bennib@mailbox.org>
 <alydngVPPaqCoaw9@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alydngVPPaqCoaw9@ashevche-desk.local>
X-MBO-RS-ID: 3722eea93bdc0f6e911
X-MBO-RS-META: 9rf68bxrmzze46y7pcjsaqk8rr5y8e8w

On Sun, Jul 19, 2026 at 12:49:18PM +0300, Andy Shevchenko wrote:

>On Sun, Jul 19, 2026 at 11:41:46AM +0200, Benjamin Boortz wrote:
>> The driver calls ocelot_regmap_from_resource() via <linux/mfd/ocelot.h>,
>> which internally uses devm_regmap_init_mmio() and requires REGMAP_MMIO.
>> The Kconfig entry does not select REGMAP_MMIO, causing a build failure
>> when no other driver in the config happens to pull in REGMAP_MMIO:
>>
>>   include/linux/mfd/ocelot.h:34:24: error: implicit declaration of function 'devm_regmap_init_mmio'
>>
>> Found by randconfig testing on arm64; tinyconfig reproducer below.
>>
>> Fixes: 2afbbab45c26 ("pinctrl: microchip-sgpio: update to support regmap")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Benjamin Boortz <bennib@mailbox.org>
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>> ---
>
>This is v2. It misses a changelog here.
>
>No need to resend _this_ time, just reply to this query with
>what has been changed v1..v2.
>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

Changes in v2:
- Reduced error block to one most significant line
- Fixed Fixes: tag to 2afbbab45c26 ("pinctrl: microchip-sgpio: update to support regmap")
- Added Reviewed-by 

BR,
Benni Boortz
