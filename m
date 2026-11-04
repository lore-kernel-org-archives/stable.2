Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804573;
	b=Ox11BWpr8LUEg5Eh3t8lNP6fvdWwJJmP2P/PaQRkorLfg4BNgIJDW4JRq+aCGB/d+BCs
	 ztaLjvF2pS/RCB42ThBmQOpyruVeWtnFKFvevBDa9AdO1SGKk03TTiSf+psPOfRv4zbkS
	 fNMvRiJ+PtzB1Ii93TqXat5dPLkx/jxVqQkAMZOwLnNCpFQr0lCP6IocsS02W3xcToU6O
	 6+AA+IBpdwAft6bH7UiKgTywqGal/5o9lwPdmb5SqQ+fdfhqiI+gQ5Pk3E3cDOdzcBhdC
	 kSfRVDCG/ayQm+EaXwwmsKJxi3WhPg2nU4jyTCi0xXAYpIQVZX3GWr0yghsU2W1waaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VRcviXFa9rkB7KYLvZ2EGeC1SAJ3+R/ZxlW12h1h3dU=;
	b=bV4UPXeL5FlUg+72GKq4fY6bkrwOvdF1rpobmkjgdSJZmE8Mcgluhbfo2sQOSgnNUp8A
	 2bathwUZSRIXVRVs5ubS5RCI4RybCszVYjw0iVf6T9AKBblfNR2fSTvfuCpkxtB3M5kf2
	 DIVmLdPMLFt9c8i+U5KIexm63ieCJNoDG5CNciGaisyFa5NYcnGpttcPgGoC2slR1wPKn
	 SaKFJZpPFGMT6ztz7bdPlQYPKIUrtMXnXE0wHEpVMSbn0irWIVqdu042+6pb9tf7EfAgI
	 YiEUtEU1wOmPBvQqpg8hHPGwgo/kRWJcTyGs3/NvRwB55tR/CS4crCQp6GfE6vElJ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=G5Sa9PUn;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B4606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C7B4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=G5Sa9PUn
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6767d92cde6so980910d50.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793804572; x=1794409372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VRcviXFa9rkB7KYLvZ2EGeC1SAJ3+R/ZxlW12h1h3dU=;
        b=G5Sa9PUn1Mj5I8Osq6ere8TbLXiHE1wcqzVnZUMRHT/aAz0eTMAdvQttJXJmVwGquK
         kogqp9BQwfOm1NvE8m/gbYDpg3qD/sqjQhx7VsurmVC0+qUAJEjbmrcBtCCNY7X/qUeb
         YQ5dCeYPYn0aHuhgKlqoLC0kpWddU8OSHrXe2DbuHWMbLhgBnjhJiL9yqUYjgJ2HkYTe
         MkpfLyPHVXuAiBFtE2n/Bio76b9sy5ZTbIdu3tv2w5NdVrxEiocYIuMXyQjgs+tfp6Jf
         lU+zFRbMk92GiKs/izMMB8BqDUhabGORNhaSIFQ3+lbL5PBhL9DEJsrqgxUNtRzipDCj
         8VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804572; x=1794409372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRcviXFa9rkB7KYLvZ2EGeC1SAJ3+R/ZxlW12h1h3dU=;
        b=WUcL+niwN6ioAbPD2hv8BLAEOhQz9H+luMwM8i19wl/VQlKXTOcaMkjbsph1dCPoYG
         fYji3UsAvwcBlEpuO4o+2X5abYlL0NCi1frpD13S+4Lp7GO6j4PTCsSzwLZLkncpA+Jg
         pSZ6Zpg6cieMvRnniktzoQH1vcQ22I1X1NHs7qaIuY2baDfixZ/GSMxq+31OQpHLqXp7
         oWj93enREV3t4UgCVpjHJqrXj0QuIsUgN08t/YYQidHoFoKW3pcN27YQ4kzRTlXtHtaM
         K3vPrEMmVC1YA6vJOzm20icu5CoBdQRX+G1fpTaELIXb1Wy0R3spKi42qy7xqLAuU9U2
         O3fQ==
X-Forwarded-Encrypted: i=1; AKwUvByu8IBQKpPAP7O6YOSqwqc5/8za5Me06IDg5MnHxveCDWx8qE6eSzTU4n84MsEafUjxNDsanlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LYrDutrm1fWQqavSVp3oAlLodkcEhAak2R2vFnNhyuZ6HDjne
	eQD0WVFnGDM6nFf+XZXa4J6Vc4ShplVSbDCay55Cs5PveuzvGkkH0qwffsXKC4wfUQ==
X-Gm-Gg: AYBFou1AjYJS0RmMgKcl6CluBXWEIVGurkjqCJ6V4DDBHyOLZCOoHTruXVbGzK9HUXx
	3XRzPVM2WEgl2x7auXTkgSLv4bzgKBrkVcqRAhqYszwqVq6IOihV8OOMQ3EtafP5oDsEHfHu9K3
	50lL41XTv9h+wbcVY2qp1cNSrvrJ8YoXXufL5dSb+h6bd2FpORSE7RiamVXIDccTspPrLjY+dTs
	z2SAXnOkzZrVYo0PmTagCWyq9IAr5DK+TMutabuPueZD0n4DQMdhmvCgt7xCO8HYQttFeeO2r7q
	zbKByiqV/AP8zY8u5D5PulJbDL6Sje1bJ5f956F4Q9AAHJzea8NU/6QjhHeLG/JP0PWbGMcK5OD
	EFRhHaRXE3LL998M++AmsPeynWHZBJ+EW8af0uxg1hOd7XF1/0SDn0dks2e8fm0b987jV2m/KRA
	jumQFMDj3aQhKEFXIlGtvaRqOqqs+lrfb+GMFjz2U2DDdPJ1mEmkVsUuvUTVL5JmTsbThcFq5l+
	P5q3HNV/PNumLlA9d2UrOJbtdYB/8yzjoYenuGyUqeb1ug7LyHdjGkr+rEf1Wh+2Vft7hmqi6JS
	LpC6ap9TmIRxSdGE0dz2qSCyZNE3
X-Received: by 2002:a05:690e:11c5:b0:67b:f39d:89b6 with SMTP id 956f58d0204a3-67bf39d8a2emr1123228d50.32.1793804572093;
        Wed, 04 Nov 2026 07:02:52 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e75b24asm20768526d6.39.2026.11.04.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:02:51 -0800 (PST)
Date: Wed, 4 Nov 2026 10:02:48 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v5] usb: xhci: Fix use-after-free race in
 xhci_stop_device()
Message-ID: <b8ea2f8f-ff9e-4cc6-853b-114fe51173e6@rowland.harvard.edu>
References: <20261104000031.679944e7.michal.pecio@gmail.com>
 <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>

On Wed, Nov 04, 2026 at 11:56:37AM +0800, YuanZhe Liu wrote:
> The port suspend is a hub class SET_FEATURE(PORT_SUSPEND) sent from
> userspace through usbfs, and the teardown is userspace releasing the
> hub driver interface, which quiesces the hub and disconnects every
> child under it.  Neither side takes a per-device reference, and the
> usbfs control request is not serialized against the hub driver being
> unbound.  That is also why xhci_bus_suspend() 100 ms after a disconnect
> looks fine: this is a different entry into xhci_stop_device().
> 
> CLEAR_FEATURE(PORT_SUSPEND) is the resume direction: in
> xhci_hub_control() it ends in xhci_ring_device(), so it cannot produce
> this trace.

> The patch makes xhci_stop_device() re-read xhci->devs[] and the "device
> is going away" marker under xhci->lock, and give up with -ENODEV
> instead of touching a device that xhci_free_dev() has already detached.
> For that check to mean anything, xhci_free_dev() has to clear
> virt_dev->udev under the same lock, which is the second hunk.
> 
> If you think the mutual exclusion belongs higher up instead - do not
> let usbfs suspend a port while the hub is being unbound - I am happy to
> work on that; from your message it sounds like you would prefer the fix
> there.

Don't know about Michal, but _I_ think the problem should be solved 
higher up in the stack.  It sounds like the sort of race that could 
affect any HCD, not just xhci-hcd.

Alan Stern
