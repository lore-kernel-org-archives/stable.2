Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B33D5C26;
	Fri, 28 Aug 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787915509; cv=none; b=G6TdNt65ie497MeGi1eFNOSEKUj1BGoTbI0ZGk4pfkmnZxfIlpK1fngCP9OMZ8ytNy2AdCi0URUsCW34WNVS5u/4FEvagz/LLLMcWDixXqpak8tY96fXoaHgpRan2wMlTCQFgiut7vOUmKgncc1JBzOh7C6+BJRsJMHwrFy4Dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787915509; c=relaxed/simple;
	bh=PSo9BgFYo5VyoCM7hYc6YzcbekbiINnRaRZN56rwelg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMWEOu3+lnp2EVS7ijj0UtBWZl5c3rFzzgbZzUPKHRk48J5WW9FK9qBajSL1488s5WuawqL4NZA5jg+A1gV3hF/tWt66+xt3ACvYviHIBgM+VU9u2DE29DCw+jDYr1JGAeA1/p6Naf1uxajI64UA5xJxeWLjiuV1kadbUV1i3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=npr2XV+y; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="npr2XV+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PS
	o9BgFYo5VyoCM7hYc6YzcbekbiINnRaRZN56rwelg=; b=npr2XV+yMJSpydLfyk
	H1EV4PH8+x6o6zn0++6i2MGoHspRce7pzouCMsu1pQpmWhXhuS18qsO/W+PB4HOO
	N65E1Ie43d7zpHRfoZ0oF0VifIAqCpi/8b18fIudQpCv3lMYRc/zqqCKs1ap7xyE
	P3W0/t+lyFgs1VbFSFnUdMTKE=
Received: from DESKTOP-CK0O7BF.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnZtXgbJFq+6M2SA--.41442S2;
	Fri, 28 Aug 2026 19:11:29 +0800 (CST)
From: MicroFish <f13208471983@163.com>
To: jarkko@kernel.org
Cc: f13208471983@163.com,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Date: Fri, 28 Aug 2026 19:11:41 +0800
Message-ID: <20260828111141.1515-1-f13208471983@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <apDseLwm7saXAdbd@kernel.org>
References: <apDseLwm7saXAdbd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnZtXgbJFq+6M2SA--.41442S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUeOzsUUUUU
X-CM-SenderInfo: birtjiyyuximiyt6il2tof0z/xtbC0QFSqGqRbOECVgAA3I

On Fri, Aug 28, 2026 at 05:04:54AM +0300, Jarkko Sakkinen wrote:

> Cannot and will not move forward given undefined and open set of gear.
>
> There was also a corrupted email address in the CC list (microfish at
> kernel dot org).

Thanks for the review.

The affected hardware I have confirmed is the Lenovo ThinkPad E475
with an AMD APU.

This is the platform on which I reproduced the ACPI NVS and TPM CRB
MMIO region overlap described in the patch.

The incorrect CC address was my mistake. The correct address is
[f13208471983@163.com](mailto:f13208471983@163.com).

Best regards,
microfish

