Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649321;
	b=Zc/mkYPZgllSTLO5/l7c3LRix/VhpJEmM2FX2ijSPEwJh5jphiSbNT+w4sZeQoAveajr
	 es222QJAPHCp6ls5wTkChRrSObl/AjJqC4Q59O+yAqcrD0q/eqJidQTRMWDMi5clL/1fn
	 sxP5MRG+P4E5gwOgtMKGE4h3Pvd4X45wKPogpDhgiXEv69U8EUtNHjSEYZMRX1FqKtpgq
	 P2r46BnnnJeZmpKmvdlRA74zyGmcfc1FYOW/akbuu/866s+sFd578N3SewW3Xog/Ixpe6
	 jFiTy6l/o0vxe8DbHwu21fOYGlfP5qYeZGC8o/TfE93eHoui9LOKf43SXTNjvCSbThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649321;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=SYP6lfPeFWSP2++HKhm6SwHrewFpKVlzGh/7WBXkbSE=;
	b=Sw8XCt155LOZehEQQj2XYrbuRa8+kc74LCyc2LMLmvnarYiWRP4xpi3WMx2Q3G/bZZTf
	 e5Z7SKf4kQhQqlJSL9CJH+32Trdq/lBl8aIyA8WBOKzdE8BSinxuB6yqDLHjUg9Ltkubf
	 t8x1nD7fYnudvWogJoxSdOQS01sb/45L7d81YrXXCDVNRJhd0Xo99LlNg1ogozSevTrM0
	 Q8nBrEXiDp1bvIbFgxGn4OCeFKH49E6gDXRL95inuOcUmX6NuoKo39mx9QCYnb/sOO/RK
	 Ne7eW7qTbO5YuA18ZKPKbNUcyLI4nPswGGnYvQTHIPI9KQ3I9jozoFMWchIWv5YwbNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LnYamxh7;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33721606A31E;
	Wed, 25 Nov 2026 23:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33721606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LnYamxh7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795649321; x=1827185321;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=d97WQeRKMr+7348RlaZUJO4IriUW5mBJn39qaoByShQ=;
  b=LnYamxh7/1bNzwisjCkMrsv/uKolx9J8/BOxcXFYqSa79xLGNzXc5Uve
   OimP9spqA4KIK565Sqs+K7udM7UMmoOkgBrQ+8YRsJq/3n62fIBu6FoEh
   c5M0vXE4JRcu15XBb9imWar4fUi6yE3VGgcdOxCfoJPKh/OuigE+wpVZM
   qNdH3ObB3YlJeKhKZdUA3l4nuaWVGb4g8RpM5F6T0Szh6JZBJ/eF6X7U1
   +bTEkLj9wYslkTeNBQSQ2cI4YQmRgL1kubi+hDfr3XDbo2Vzk8/soq7RF
   4eD3Uj+ykL/M4M5qBxxgt5bi/ddzq01cj6bEgZbz9XU4D5DHFELQC7xcZ
   Q==;
X-CSE-ConnectionGUID: pVVQfkeaQgGiA2itG9sSZQ==
X-CSE-MsgGUID: rwyjqvlpTmG3MNfxcKU7zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4436585"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4436585"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:28:40 -0800
X-CSE-ConnectionGUID: /tCpGy0bTPuLSQ7lSQAcmg==
X-CSE-MsgGUID: y4WVKpJwSaakf+YoTaCZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12311772"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:28:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Hans de Goede <hansg@kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, 
 Benjamin Tissoires <bentiss@kernel.org>, Moad Tarrih <tarrihmoad@proton.me>
Cc: Sercan GOKMEN <gokmensercan@gmail.com>, 
 Burak Goncu <burakgon12@gmail.com>, Denis Benato <benato.denis96@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261116-asus-wmi-kbd-readback-v5-1-f2f170836bf4@proton.me>
References: <20261116-asus-wmi-kbd-readback-v5-1-f2f170836bf4@proton.me>
Subject: Re: [PATCH v5] platform/x86: asus-wmi: Ignore unusable kbd
 backlight WMI device on ROG Strix G814FP
Message-Id: <179564930314.9828.13260879670237100649.b4-ty@b4>
Date: Thu, 26 Nov 2026 01:28:23 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 16 Nov 2026 11:48:12 +0000, Moad Tarrih wrote:

> On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
> backlight brightness in sysfs changes the LED brightness, but reading
> it back always gives 0, and the read makes the Fn brightness keys
> misbehave.
> 
> The firmware reports the keyboard backlight WMI device as present
> without implementing it, and the backlight is actually driven by
> hid-asus. DSTS(0x00050021) always returns 0x50000, which is level 0
> with the presence bit set, regardless of the actual level, and every
> DEVS(0x00050021) write is rejected as an unsupported method.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86: asus-wmi: Ignore unusable kbd backlight WMI device on ROG Strix G814FP
      commit: c53ca788e3a20b2319c3b6fbcada620b2299bb80

--
 i.

