Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4330BF6D
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416339; cv=none; b=W4Ib//W5xm8JvIXzgXwBYFtqoYLKy+L0T9pgHRaf9CI3g3WQj00XrXL4WoJlvTxRa1tjzjj4o7o5llsaHuA5aXCD3gmoUs1ORgIMXKFB76BSSJeqFo4j9gZqih4PAjEW6QzYm81oAzFP1sVKVQn5vHMLq2mVaueYBO/+wDO2Jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416339; c=relaxed/simple;
	bh=7/8RCEkUMYwUf/IJNQzM/95RFtF6Kuq8j1WRmuAmYy4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c89haA62kxjlkZgGjeqQ8UCbVVBJ9+92da34X7F+V1JJDQWE5kHHLl4GM7VAOr7ANS/CY5gVAgrx8pF5JnUUr3vO6uEEO0I9zKOGI8e2EL3qOxC3tl6uO+WndsynhsZfCOz6iEnI6SolO887VT8eaipAOjhrb0gFqScrv9H1ZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCHiIEab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCHiIEab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450F71F000E9;
	Thu, 25 Jun 2026 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782416338;
	bh=xLQcCAMEOvQdcLv3+MzAbVm2HFmzZFExyG15mB0wLCM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JCHiIEabKjQQPJQdsdwZj7fhnuqGop1QeyjrrOCRHdV3B6w/tX9ZnZLkD7LIq3u3j
	 0tAq37MlFjz0Y9X6RNpPGI979ncY7Ff/L+6I6/mldOZqo5jz0OiNTP/udYnrU1gRno
	 oKw9PlvQateha5VFFMpfQVDZJmyMyfsjf9q0u6Lu9H341P/5gAcNOC9ktX4o0xpb5z
	 GJbnCtTIMx+b0Ce50U/Szpfh3oox2hUSYGECZDV6jRBkjqq/YYu3Oizkf4JC5X5vnz
	 l8g0Siew3u0EgvgTnB949ykTJiiNRBR2mpqwtePwkW/4iZ382ooEMAV0wEZrrCwo0E
	 EyQSekkLMaabw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id A297CF40074;
	Thu, 25 Jun 2026 15:38:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 15:38:57 -0400
X-ME-Sender: <xms:0YM9ai2S82dlX67lRbY5rN6bQdJj4ZDP_RKGTCLCaOknpPgZ6079Hg>
    <xme:0YM9amroMxKbPxc7dJ3vOoEsbVs74qBImX585isnkbQcLaM6Ka0VCgclmfs-bG6G0
    vo1FjP2xvEf1r8L2tqBxz6rGSQTFCSzcANY7H0qaf5khwcQo_K2YUE>
X-ME-Received: <xmr:0YM9aqLHK9f4KGQkquODK7geOzWKeSBxts85MajOFzFh63JywSwfr8qfH7uFyIALrGi46Iq0wq1gRqe_GFUS2Lq1G_70KiCdP0Y>
X-ME-Proxy-Cause: dmFkZTEscVxItEhJ/0BB4j3QdsvuuL7z5cnLZXlhkLDQtYVZXScP3IMKt0Z/oqjjUoxp7S
    mzaHS480dtsIO7W7Ej3+aH0wt13aw6QpzcYhw6gDqLAHIBpL+Ls31IbXXuDbGIzTJA9kGn
    BLDEDW7ykgnfDpDN/9zgMEzADoEHU3VDZZY03jw1lRuV5sYJD99sC4WusfgCEvNSoU8se5
    Kk/c8G3ZEeKrYDJaWGtFOcez9j/itiUa+cGysbVumeGE22M1bJ6scqNKY1ojd5j2B4QrqQ
    /wsMn8vY7t4a68tWb31WbeufPgvceIMWlrQqw96Pa5i2FwY2yls2DeoNhJikEOGJRRn0Qx
    pwuHJ+Ee4FbNgr/eCg2Eudy4oI5oaAXEDdKvb0Lm8/uFEJ6aquBln5q6j6teplDlvQm3ZR
    5069vnlkl81v7ZSq8W0St+X6gK0YK8zkTTcZX5Ais2KELYwMidqgEpEc9Srxfjx7V2aiZN
    tKuitf9gaGUDCT7BpNv2VniP4wfArao5BksVe5ea0uUrGrconk81p/yb0EDcbKus3Blsdm
    UXxBNkCD0S1VOp9sxXn177yQ1EuoX7P95t+9JIsWEXRTSKBO9DOsnk9t4v0EHA1KAlTisf
    2M1DLnCT3MkFWg1PrKPihMGpVe0iBVhuWgg/TiSZURm2tCfXmo5NKESa801A
X-ME-Proxy: <xmx:0YM9aqRdVqMmrwJcz17mgLQfmoqCYz4v4cfK2NUHCMk59gE548pFWQ>
    <xmx:0YM9aqNEsHgC2FYETgbF5WlPh8EJtWqO-QWy8WD7u8xMeyhD--s62Q>
    <xmx:0YM9avUpZrNvJAww_J1FrVVM3Un_dbRfsmYbV68it6OxRRY--em99w>
    <xmx:0YM9atgc_sw_886SkioXQrW7QyKX2OFKDAe9HteSx85EoBZf01pWXg>
    <xmx:0YM9aoj3qeLw2REFEdfTfhQlOZ5NSXjjH12CntRd1XRw1ImOX-f49axq>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 15:38:56 -0400 (EDT)
Date: Thu, 25 Jun 2026 12:38:55 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, 
 Dan Williams <djbw@kernel.org>, 
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, 
 Anisa Su <anisa.su@samsung.com>, 
 stable@vger.kernel.org
Message-ID: <6a3d83cf9ee43_164f9d10042@djbw-dev.notmuch>
In-Reply-To: <20260619055932.1354182-1-alison.schofield@intel.com>
References: <20260619055932.1354182-1-alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alison Schofield wrote:
> The CXL NVDIMM security passphrase key is looked up by the description
> "nvdimm:" followed by the device serial string. For serial numbers of
> 10 and above, the kernel auto-unlock path fails to find the key
> because ndctl names it with a decimal serial and the kernel uses hex.
> 
> That means a passphrase-protected device cannot be unlocked after a
> reboot, and the pmem namespaces it backs do not come up. Devices
> without an enrolled passphrase are unaffected.
> 
> The mismatch occurs for any serial number of 10 and above. Since CXL
> device serial numbers are vendor-assigned 64-bit values, that covers
> essentially all real hardware once security is enabled.
> 
> The 'id' sysfs attribute is established ABI that ndctl consumes as
> decimal, so format the kernel's serial string the same way. A u64
> decimal string requires up to 20 digits plus a NUL byte, so grow
> CXL_DEV_ID_LEN to fit it.
> 
> The issue was exposed by CXL unit test cxl-security.sh when cxl_test
> mock serial numbers were recently extended to 10 and above.

Good find!

This is a good fix for folks with new kernels and old tooling, but
leaves folks with old kernels in the lurch.

Not sure of the priority of doing this additional work given it is not
clear the CXL PMEM devices with security commands ever shipped, but
userspace tooling can workaround this problem by always injecting both
an nvdimm:%llx and nvdimm:%lld formatted key descriptor.

For the kernel change:

Acked-by: Dan Williams <djbw@kernel.org>
