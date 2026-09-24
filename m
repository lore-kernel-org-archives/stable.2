Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA83EB80D;
	Thu, 24 Sep 2026 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269275; cv=none; b=mBSbkvjv8Xj78jgtf/mQL7+TQz0XtZZXQqg5hrsWFh0XIRM6pRnLJn+pV4BDlHiL1dkmnrkkbRvHiBNrRQ/OnIwwkcYxpUFxB2il5OHehAHMODDBQFTydY+i6LdRCwc4DKP/qm+PVEP5EIfeMbwxEdWG2tDLjETOhDHaeF7GjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269275; c=relaxed/simple;
	bh=MiAlFzz/JgKGEQ1e00PaKqXcB98BZc0aDPq4O46YCEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjkM24Kv3KC22M16hZxKi6rh0r+bfLvWiTdkhen8kJ4pjzQp9X7LPOfkPbk8GpzqS8glNSqiRHj7Ns8YPl7kkUr2cAHIAwSAQHTKf2HfRe90SWxN9G0Emdb/2gQHXS7EMFU3jR+SBA5fqrzqMkMHB2JSxBtWiub/J53ZFkSM1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FrbCG3sk; arc=none smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FrbCG3sk"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A70A4402F69;
	Thu, 24 Sep 2026 16:42:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.96.3.213])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 153B9402BFC;
	Thu, 24 Sep 2026 16:42:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Industry: 23044e9a64930f9d_1790268171342_686159737
X-MC-Loop-Signature: 1790268171342:3160133764
X-MC-Ingress-Time: 1790268171342
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.3.213 (trex/8.0.2);
	Thu, 24 Sep 2026 16:42:51 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4hrKQ22WSnz102x;
	Thu, 24 Sep 2026 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790268170;
	bh=iQSb0yDnh3rC42nJgA6uJqywfCVo70Z2eMm5wrmYWBA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FrbCG3skknlDwgQDxmuHsTp8S3fYtvbiBlG6xSVWdcSluf/D4jsUtSEyYCbNZBNrv
	 joSMU8fxdTGRUWd97w5G43PA9FsXQqsyYDcHFl5xkWIz4bznR9yKsLEZC2PGhr9+/V
	 ejL7xXf3SLDt1sKaq0fQYdIbjNDBkwibC+H/8bKNfvd4KmUcuR+KOOoHBzW7KEBg52
	 aCwwMX4bA5itzTkGlS1AaWz1iDPirHSKCUW+WraC8dz88jhi+79GZNAAK3OuFD/2kL
	 fKthIR+CrnemWRh4hCAnB/oOsQub8Ig9Tud+eGNuguXiOCz53jdzcp1TD6be39A+3J
	 9cIRKemJUni9A==
Date: Thu, 24 Sep 2026 09:42:47 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Check ACPI companion before use
Message-ID: <20260924164247.rsb4h7qjx5bvrthg@offworld>
References: <20260924125404.923551-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260924125404.923551-1-yaojiale02@163.com>
User-Agent: NeoMutt/20220429

On Thu, 24 Sep 2026, Jiale Yao wrote:

>Platform drivers can be forced to match devices outside their ID tables
>through driver_override.  cxl_acpi_probe() assumes that every bound device
>has an ACPI companion and dereferences adev->dev.bus without checking the
>result of ACPI_COMPANION().  Force-binding cxl_acpi to a platform device
>without a companion therefore causes a NULL pointer dereference.
>
>This was reproduced by setting the driver override for the pcspkr platform
>device to cxl_acpi and binding it through sysfs:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000280
>  #PF: supervisor read access in kernel mode
>  RIP: cxl_acpi_probe+0xf4/0x220
>  Call Trace:
>   platform_probe+0x4d/0x80
>   really_probe+0x106/0x370
>   device_driver_attach+0x4c/0xa0
>   bind_store+0xd0/0x100
>
>Commit 2b3a5dabe89e ("platform/surface: acpi-notify: Check ACPI
>companion before use") fixed the same force-binding issue in another
>platform driver.  Check the companion before setting up the CXL root and
>return -ENODEV when it is absent.
>
>Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jiale Yao <yaojiale02@163.com>

With Dave's comment,

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
