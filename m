Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F86376483;
	Thu, 20 Aug 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237767; cv=none; b=Ydq1T1+7CVIjR+TxxZf76mn12B0IsMpO58MfiBtlnqfaDnrWSQNkZabAz2ErB8/VH7b07ZktWOCfgwZOGyL6qX5phfbyxpH2bpWbZc9ErG2FvKYdU5HumhMx6yWdgdCM3tAli+kXx1EfOywvXKJYpEMjAs66cseSWDz00AGIONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237767; c=relaxed/simple;
	bh=LYha1bT/7V4JT7uQ7b1QhF+FeAyNprTRP1rFt4CBD2U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZsynUOktc5e5gCf8maTN+UKdyaO+WStREjWbZZkADis6oPE6eeF7r7XnMsqskpbdCpi55BS5j+7Jyi6aCpxrLiD5u6imaVO+q/YTTQWbJ5cc98yGaCGotoxPJPzEYB3yZtYqQCCtlqswzOREsun8vsgCR3JjocHq1Bu+I/7RuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=abVccrGo; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="abVccrGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787237747; x=1787842547; i=markus.elfring@web.de;
	bh=LYha1bT/7V4JT7uQ7b1QhF+FeAyNprTRP1rFt4CBD2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=abVccrGo9mfh9G1QS405CKfKp0zJ45ZNvN+a8nbX1pSw/jlcvxladM/NP7TvsIou
	 BIO5qP1nfH+z+ws4yC90imHibgP0oJJltse/NBUvmRCpzbtuYegRjV1bmmhh4eQXD
	 ynTk2Jl8q2YLYWsNVq4z8s5ADu5m0IjaUAg3gQrRaXjpx2QaU2JjMVyjOfPmQdsOS
	 wo0kAhcIyWLOXM+mumTEwsq2clCiDGotFzCVDGquGSbQHsrtb6x+FPo0ubZATLsFq
	 tVMWRlqpB+rhFZAtF63/4ZxDbWosVpTZy4VUhvILu9E5gqqBU8CBHA/bfKQUmGElY
	 plGx1BbOc9iAB4NXvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpGw-1wcsq83KlW-00dL6U; Thu, 20
 Aug 2026 16:55:46 +0200
Message-ID: <c72da648-4d8e-4f0e-90f4-fcbd82d73424@web.de>
Date: Thu, 20 Aug 2026 16:55:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>,
 dri-devel@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260811194224.121597-7-megia.oscar@gmail.com>
Subject: Re: [PATCH v5 6/6] ttm_pool_mgr_init() does not check return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260811194224.121597-7-megia.oscar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6i+g1HM1bL6razm1EJZ+LpvjH44QDkYBfufO6YNYr5DyiN/DGb4
 YzG8/FSNddXqSg+w+irWI4a5C8NOmUy5V6trCRbs+PfGSghzvukCwuY4T7kz1FjyW2cfrPw
 gPjdgFeIc9R+/RkUquBlufQubF7V3FZcV2SNTkOFircqmADrRnPAIQ9eLh8Tex6ztsT9/9i
 0KANjJnYL6u8Vt5MB9EnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Khd2CvtRGAI=;+JA2TqJEIBRvwakMwOVpzEnOAQH
 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
 Buhm8IWB1+hcdlyXRSnI=

> Bug: ttm_pool_mgr_init() does not check return value in
> ttm_global_init().

I find this wording partly inappropriate.


> Fix: Check the return value from ttm_pool_mgr_init() and propagate
> the error.

How do you think about to omit the text =E2=80=9CFix:=E2=80=9D?


Please specify subsystem information in your patch subjects.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n688

Regards,
Markus
