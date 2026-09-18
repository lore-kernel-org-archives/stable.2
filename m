Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72D51CF42;
	Fri, 18 Sep 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756543; cv=none; b=kBuHPdhnh6DFQGeGKjyUI8eKq3jEy5W9WkK6uLheoiXYdgasIJCJ1mqL12xG/l/PUEwr60dx4d3siMpySlt6G8WfO2xF1pJQm5VytYZKHDINGNlpdGUt8BNdwQwYSFFQYyW6+KtSVcCyipchzmuG9Dgm60G+xRRbcAGusjaBkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756543; c=relaxed/simple;
	bh=Q3shEf2EjfI06CcjJTL5r/WFrgN/wx6sw0Nne9aaOYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKQyMk/JcTD2NFqYvEEhs9zOJEi3yQvya8Fsp1ODGDPpYLehm+YcJvNASCOk1k6qRGcIWxROI/EcaJhUEti9O4144ip2lwYPlAzas5gT/l3Y1G0Kqxcg+E85puuGhMY7zC1MkYOgmvf6FdgZskimNF3ZY2wzbZipRwYKicmwGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=duxNyn60; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="duxNyn60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789756540; x=1821292540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3shEf2EjfI06CcjJTL5r/WFrgN/wx6sw0Nne9aaOYU=;
  b=duxNyn60/S3jSAPpFRFYgRh3DdaSl5I4mKux3foZlHXHuK55GG2IAh05
   RLW7kT8HcAfY2TqtAGrwD3wdYI4bxD99s7r0N6n1wYhRTI3DJxs8sHK5y
   albqL0wAGa+0mRno7nev5I/ojoUFuatPnn8PA2ygWRpM32DyH9GR8o8PB
   +H1RiDmPQbxKbnzziUIqdBfCMoI6annCQxyNIKgKOIEYk+tGnMwr4kOrl
   8KPWsT2qekJvAt3KC2TqVKZ7GPGhMHYR8NbjhHmMUYz7miX+oQipI2BiF
   mvTBpxFUN5wiHND/7blU199OJMqvQR+I3FWi7tDLOMvKDUF6+ABjlIy17
   w==;
X-CSE-ConnectionGUID: YGpOevFGQOaa65utPBc2qg==
X-CSE-MsgGUID: 1VnxgrRHQC+bpV/qZepyeg==
X-IronPort-AV: E=Sophos;i="6.27,109,1787011200"; 
   d="scan'208";a="29053002"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 18:35:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:5493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.40:2525] with esmtp (Farcaster)
 id 2f944e19-0f04-470e-9731-5d5bfd537fcf; Fri, 18 Sep 2026 18:35:37 +0000 (UTC)
X-Farcaster-Flow-ID: 2f944e19-0f04-470e-9731-5d5bfd537fcf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Fri, 18 Sep 2026 18:35:36 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Fri, 18 Sep 2026
 18:35:36 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <jarkko@kernel.org>
CC: <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <peterhuewe@gmx.de>, <stable@vger.kernel.org>,
	<stefanb@linux.ibm.com>, <surenkj@amazon.com>
Subject: Re: [PATCH] tpm: Disable TPM on null key name mismatch
Date: Fri, 18 Sep 2026 18:35:04 +0000
Message-ID: <20260918183507.9418-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aqykXxFybNMB_KSv@kernel.org>
References: <aqykXxFybNMB_KSv@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, Sep 18, 2026 at 05:39:27AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 12:07:31AM +0000, Surendran Kanagaraj wrote:
> > The null key name check exists to protect against TPM reset attacks, so
> > a mismatch should stop the device from serving further requests.
[...]
> > Set rc to -ENODEV on the mismatch. The error path then disables the chip
> > and returns the correct code to the caller.
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

We reviewed this internally as well.

Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>

