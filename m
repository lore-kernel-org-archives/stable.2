Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539940960D;
	Sat, 10 Oct 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617237; cv=none; b=acjyOtgYQCr8e0bYI8ubbZnKFxLCWGPNXQFiM0jl4P0hiwNDkbJXy/mwIYOIzvSGOOS3+XE4Wn/Hrlmht1QGHA2vkETM206CQUUbwrhGDMzK+zaemZAi/RVqxUApZU/XhlJXziDjy5RFbl/qlhqtZZqf7GWBz8qWY5yyglDAd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617237; c=relaxed/simple;
	bh=g4eHFf/k9paFRp0bk4uNRxT9u/IvDo8cgf9cKjk1OyI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=YZftWK/KGkW/p2lAOsqYCj2H1vYmnzP/oETmtC6mC0DzboM4G2qDoAj50fYF3ayzvYzTS8bOdgin2WVyhfcH3U14dFKU8iW1FTxpu8a7k4wVEiBmUapTpToReiBAiV2P2BQg2+6GxErfpZ+ECYScx4WDFCuD38gAPEvmUbcINPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aaGfZ6nV; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aaGfZ6nV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date; bh=g4eHFf/k9paFRp0
	bk4uNRxT9u/IvDo8cgf9cKjk1OyI=; b=aaGfZ6nVvr5053xP9fbRflDYtanq/h4
	mm5OyGlJlMbWLrNGesOYoVNI2Ik2BJflnXQ10QWgQhitzXEcM5NZRcyJPkpnaGdO
	SiZfXLjevYc478arFYPcjDAic2LUaSR4xnRWTkR5FWFFNpsaIDwDXrQoHPtFqrAg
	alTT1Ouw4e1U=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3n4W66Mlqc7usDQ--.33285S2;
	Sat, 10 Oct 2026 15:26:50 +0800 (CST)
Message-ID: <23f74656850cf78261d84fd18bfc7870@163.com>
From: Hui Su <sh_def@163.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix use-after-free of a destroyed user DSQ by a deferred reenqueue
Date: Sat, 10 Oct 2026 15:23:23 +0900
In-Reply-To: <20261009220001.196762128-1-tj@kernel.org>
References: <20261009220001.196762128-1-tj@kernel.org>
X-CM-TRANSID:_____wD3n4W66Mlqc7usDQ--.33285S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUmiRUUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hp11GrJ6LojjAAA3P
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi Tejun,

Tested on x86_64 KVM with KASAN; sched_ext selftests passed, and the targeted
DSQ lifetime test completed without the pre-fix slab-use-after-free.

Tested-by: Hui Su <sh_def@163.com>

Thanks,
Hui

