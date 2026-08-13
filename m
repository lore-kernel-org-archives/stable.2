Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83B47DD4F;
	Thu, 13 Aug 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629097; cv=none; b=aTzqKw5sdc54x6y4ExelD0CpqmzEwtllbzzHXLGZj76dubwXHlMPMqYxXZFxaDPshfanRqiJThnzWBkjpP0rWSqKwtarvbPsMoql+oD25O4YUheO/dUoEYo5FuKSIuNKa7ZC2bJCiEcyBIWtAvLh0GaHfr53WktaUT22/2YsINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629097; c=relaxed/simple;
	bh=Zzfh2mdMV4V6s2Dgu528qo5qOVHq+rpvBmigHkEQBAg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUJSNrntiOk2gCByLNKwGbZYn81YFeATHdX2i5j/+gBCgq5dqVmkOdEb7ELddBudmweUzj3WvV+vn/oYrlMIQAT55EM3uF+35cLrpAzswPKOcYicyqwyw/XJCDr1WSlPSbMHsdq+taU9np/UBKUMtG13JSrghtl9/4cKnpzFZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=llmMdKHJ; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="llmMdKHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786629096; x=1818165096;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zzfh2mdMV4V6s2Dgu528qo5qOVHq+rpvBmigHkEQBAg=;
  b=llmMdKHJS9QUgJTh4wVJMWUUo1ST+f4D65noKx1IyZv2Q6+YGoJKKzOy
   sBlcdZAV54vrTb7T5WpwoYuSJo+Mwla8EKihQVpv8tNcmk8waS5bY3bZr
   RGNuMFCnkpkliK9ix1xpoylsHVsveFaD7hpegvRODYfl/YFhJ0UAStTMu
   OaluMPOqdHPhDl2xg2lM+hvxpvdfQzzk42hwNToVkI7bgM9lQL7gtF1d8
   V9YRsMjMYk0CSYxDmDjcxp+MhfDMI/l7jCTTFwhOOuX9/tU1GaRlga0sK
   WtFpLKCIrMMZRypMZ3CRPtdnTJi00++uLJ69FG9HXU788lUQTOBh5rDUr
   Q==;
X-CSE-ConnectionGUID: hGtI5w70TSmbSlEcHzU1UQ==
X-CSE-MsgGUID: 5m2RVy+ISuKoiLZGDq9gxw==
X-IronPort-AV: E=Sophos;i="6.25,221,1779148800"; 
   d="scan'208";a="25643882"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 13:51:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:15536]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id 51736fc7-28f4-45d6-adcd-98136b9d0585; Thu, 13 Aug 2026 13:51:33 +0000 (UTC)
X-Farcaster-Flow-ID: 51736fc7-28f4-45d6-adcd-98136b9d0585
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 13 Aug 2026 13:51:32 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Thu, 13 Aug 2026
 13:51:31 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Eric Sandeen <sandeen@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Alexander Viro
	<aviro@redhat.com>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH V2] devtmpfs: restore mount option reconfiguration on
 get_tree
In-Reply-To: <b1bd3b15-78ea-4487-b6a8-aad0b05dd3bb@redhat.com>
References: <20260810083438.764684-1-simonlie@amazon.de>
 <b1bd3b15-78ea-4487-b6a8-aad0b05dd3bb@redhat.com>
Date: Thu, 13 Aug 2026 13:51:29 +0000
Message-ID: <h6dsxwltuuo0u.fsf@dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Eric Sandeen <sandeen@redhat.com> writes:

> I think this might be a better approach; more involved, but it uses the
> right type of context for reconfigure and avoids the nasty ops copying
> I wrote the first time. :(
>
> First, sorry for breaking this. Second, Al please yell if I have mis-attributed
> or mis-implemented your suggestion from months back. Third, I have done only
> light testing on this but it seems ok, built and booted with CONFIG_TMPFS=y
> and confirmed that a fresh "mount" with new options takes hold, and confirmed
> it builds without CONFIG_TMPFS configured though I don't have a system
> that wants to boot that config.
>
> Thoughts?

Tested-by: Simon Liebold <simonlie@amazon.de>
