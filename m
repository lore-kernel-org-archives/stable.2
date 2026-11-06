Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962064;
	b=eVtjDjEwekSCXXdtD2JkCA5VAPtOP6zQPInFV+MuMuvuWMuZ/atdhd6mnhqv86wjSTow
	 n4SerEtLjGAg97ae8mEht0J745BO3leMO1rNlP6rxCvxF1kAgJMCsG/3r4GciZZHodQuq
	 TXVMcEyI/4rXQzXQ68QvqpirJ9BESe/aWILYXing6WntGMCFkQ5YICSEr1UUJn2oJjOM2
	 BoN+PJlslo8fli3cXXaVzdVjn90r4/u0b8cm75gScKgyyIff91d4SSgMF2q5Kcp7Pr0qm
	 KDB42C/Qo4YixskClqG+RiXehic6hQGXJilk5aGrejIDgAkf5+ZAx/iz5xk7jI7OZtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962064;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=R9S939twrj0SYcNyyNMpKYYBYQFDO5nmOtD0AYtvds4=;
	b=ZUxpXoj7GGt6O+jBFSFmZBDEa3HXLg+mXud/i+5QtFY9DHkiuYh19vd9pXPu5eeo/UxI
	 nLm55Q/31rc4ijasXfXp/xzLEMQnkaV9dBKamxTy/+V+nzUCw02rn9DmHcOWpWQrwOOB9
	 t50h2XtJebfbizUyl46R47Tarxpb0JUMiXVafSPTdgIpUMhZ5NSvdXBS+TW83BYSDebwX
	 XZZqAMyuGdyYwSqrF8MRZBsci0JEuPRxrggQTZJViNi5CodrsOAQ5V2k7fxxUi5Zl5I9i
	 I+cfwRWPry4cSbUgnHRhprX7Q3uipigDAskiQsq1JVhmIAF7FDrtGwQluIChpk2WEaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=wIxBiPHJ;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BC606EE8B;
	Fri,  6 Nov 2026 10:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D5BC606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=wIxBiPHJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793962063; x=1825498063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HRuU2J36shbnhHng97OPy9ikYDpcOLXorav4tJQOvdo=;
  b=wIxBiPHJcdtHv+H32kJcw2m4PYUNJ3f1egBncWYYh/yD4RSnQwhRRW5A
   9zb5TdyIucXz0EoJdjUh6qOhAM/l7ia7zbU1xdSxJqat10Xi55c4tFPHp
   VLoVlRIgFgX5/n+g/hdDBylgJh5KxdmhEVRI5aKOifybSyNoSGA8DR2kr
   QemYCfhym/pMKmkpfoaltjKbNR9JqT1qHRbf1utx1KqRQXVVCR3JpTUP4
   MuexJUPfumQC2vzG8P4MxARuAQFRiqK4IBKsuHCBbNAlXIsqoqC1iHY4M
   gk88MQQn4JlUO8tYMhnRwmoECncx/P4e8d853tIDMm13ijPdeL7mV5KvG
   Q==;
X-CSE-ConnectionGUID: /Yq7+t2mRZiAwkDH8CMhWw==
X-CSE-MsgGUID: bVUN6M8GTjCPROh6upyWsg==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="233192553"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 03:47:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 03:47:42 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 6 Nov 2026 03:47:39 -0700
Date: Fri, 6 Nov 2026 11:47:39 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
CC: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <Tristram.Ha@microchip.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: microchip: initialize the IRQ access mutex
Message-ID: <20261106104739.gi2mfz6mmek2n2ya@DEN-DL-M70577.microsemi.net>
References: <20261104-ksz-irq-mutex-init-v1-1-e3bb7d9dbd80@vaisala.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-ksz-irq-mutex-init-v1-1-e3bb7d9dbd80@vaisala.com>

> ksz_switch_register() initializes dev_mutex, regmap_mutex, alu_mutex and
> vlan_mutex but not lock_irq, which the IRQ chip takes in its bus lock
> callbacks on every mask and unmask of a switch interrupt, and the PTP
> code takes the same way. The zeroed mutex happens to work on the
> uncontended fast path, but with CONFIG_DEBUG_MUTEXES the first lock,
> from the IRQ domain mapping during probe, warns:
> 
>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock
>   ...
>   ksz_irq_domain_map
>   irq_domain_associate_locked
>   irq_create_mapping_affinity
>   ksz_irq_common_setup
>   ksz9477_setup
>   dsa_register_switch
>   ksz_spi_probe
> 
> and turns lock debugging off for the rest of the boot.
> 
> Initialize it with the other mutexes.
> 
> Triggered at every boot of a KSZ9897S over SPI on an i.MX6 SoloX board
> with CONFIG_DEBUG_MUTEXES, on v7.4-rc1 and earlier. With this patch the
> same board boots with lock debugging enabled and it stays enabled
> (debug_locks 1) through two hours of unrelated stress tests.
> 
> Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
