Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA3360EC6
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380024; cv=none; b=M8N2jbJlt9I0EQuUnn6klRXGD+UYPi4mZ2+jXKcVs2xFk149J5ZU5o0S4wDQKyfNmoYr/uPXUaxBX9FwP1/MIPhZwBclPnqx91KlrIuzRGMLzYGcjD0pHZO2/nGOgI1XK3zOvO36gSpbzwoILeo9czwmw169UpX0xkt9cx5lmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380024; c=relaxed/simple;
	bh=ixVG5jnclY6GUK1uHMRK74df2HiEDlI6ELwweSSTzR4=;
	h=To:Subject:Content-Type:Message-Id:References:Mime-Version:
	 In-Reply-To:Cc:From:Date; b=jY9T8g0eex3RukICW3+DPgNdMG+IiE3yuTRlO/1wsthWtZKlYozWqlUjtJAK6/BYjEMdVjhR7nriqSIQZpppisGhPM33C3ffPGwbXWk9qZIUqR0L60ll1kSngGBFtHyXER81OAF6mz79KME3ECcwMTnTnPDEMTqxRJRdKB5j+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=westexplore.com; spf=pass smtp.mailfrom=westexplore.com; dkim=pass (2048-bit key) header.d=westexplore-com.20200929.dkim.larksuite.com header.i=@westexplore-com.20200929.dkim.larksuite.com header.b=hgaJlvPs; arc=none smtp.client-ip=209.127.231.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=westexplore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westexplore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westexplore-com.20200929.dkim.larksuite.com header.i=@westexplore-com.20200929.dkim.larksuite.com header.b="hgaJlvPs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=westexplore-com.20200929.dkim.larksuite.com; t=1792380006;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ixVG5jnclY6GUK1uHMRK74df2HiEDlI6ELwweSSTzR4=;
 b=hgaJlvPsRoz1YixF8793VnWU7kKU2qm9vpGtZlQzfVvPvij1MZB2iCUb9ixtMLiYPa8lk7
 7W1hm1RMhDaSN3NLGgjcZ0wVXzvNFptJlHgofjqB5cdhHSVanl/RvH+3nR80z6gbCQbEMh
 MSUVwiF8JoISbAERKYm9+p/twkiUbPCxzxBjAro8hLhktBvmjL6Ct5jKRnuBUfqvzk2ImH
 kC3/9gBd1esHZdD5KDlfDMEd1Qc1tF2HRVTltKjNEZ6XCZ9SROPZuse/4CpwaXVzI1bjJP
 CUwU6HtLO+hoDVwwVjg1JxGPjUZfW0QFB1WdfmN1fWnsS5Ppn2m/NsXj/meaDQ==
X-Original-From: monty@westexplore.com
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12 000/869] 6.12.114-rc1 review
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ad58c65+3f5fb4+vger.kernel.org+monty@westexplore.com>
Message-Id: <8a1d6da45c83460e6809b471555f6501@westexplore.com>
References: <20261017160036.979869304@linuxfoundation.org>
Received: from [127.0.0.1] ([96.9.225.215]) by smtp.larksuite.com with ESMTPS; Mon, 19 Oct 2026 03:20:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20261017160036.979869304@linuxfoundation.org>
Cc: <stable@vger.kernel.org>, <patches@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>, 
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>, 
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, 
	<pavel@nabladev.com>, <jonathanh@nvidia.com>, <f.fainelli@gmail.com>, 
	<sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>, <conor@kernel.org>, 
	<hargar@microsoft.com>, <broonie@kernel.org>, <achill@achill.org>, 
	<sr@sladewatkins.com>
From: "monty wei" <monty@westexplore.com>
Date: Mon, 19 Oct 2026 03:20:03 +0000

Built and booted 6.12.114-rc1 (1cda2e472e80) on x86_64
using defconfig + kvm_guest.config under QEMU/KVM with 2 vCPUs.

The build completed without warnings, and dmesg showed no
oopses, BUGs, or WARN splats during boot.

Tested-by: Monty Wei <monty@westexplore.com>
