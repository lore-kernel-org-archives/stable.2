Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68A4DD3B4
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168743; cv=none; b=DELSJXqdHPHOc/a6jBBvh0fHMJ+d2SsW6wtVCPAFC5KgMIdasRH22KsFACXP2S5XFDc8KXkRsBq/AhZ81vPYctZjSmEwzv0GSLU46Mq15mz9++Ltr938K9971sfei0iE7BQa8CeBc0JkRVv/u+XpWeHcSyvNrqjxLXTmHRkg49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168743; c=relaxed/simple;
	bh=EmwwAXEipiNfYhbfqADwjVeALPrEjGJ8Heaicb0+RCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMwZ0xHL7OrJSebv5EpktlfwVcwyRCcSsxzme7vRTyjhliw7bT8gmXUYBepC4RUzDSW5t4Or6Ns2udRS8dtRRcatGDoo1CefZ1fCBfFS0azjbuLdtF8AFE/nA7NAdbbXkU3M3EdfDv5n2+VCREQyR7utcVbf9uVgnNOk1+1DOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VmaUg7Pm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Px2TqF/c; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VmaUg7Pm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Px2TqF/c"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB0B87A00A5;
	Wed, 23 Sep 2026 09:05:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 23 Sep 2026 09:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790168741; x=1790255141; bh=QkaqSStXQT
	WWkXW2QqWcC1CBYRuYJPDe12Q8vuYF63Q=; b=VmaUg7PmO1XUWdedk/wtcZhB/m
	iwEoPg2LPuVYaUz05/wlH3bEzMtJCq/CElx3zktaEmQpzDyUFMLOEsGHYB15VZFt
	ddoU6APVg2z1UXiqiCmu2D1bCC1+9QFbLUJwOedS/8mGe60JVFOAgwbKjE4wMJQ7
	4ydzI2q79DGhUnVBVQOuIwQDt98LU9+Wmns85fl33Md9Zp+GD+6Ucwziggw3n0wQ
	8LUdJEtzQgUy+ojkNdAqLfTz6wdQq2ShM43tumbviBbdhTELqJqTO/cdqGfuyBU2
	+jX3S8N6AISKf1zCYdLiK8l1CtbqfWHlBrkXopMc/sabmw3g9wnY9Z1J/QNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790168741; x=1790255141; bh=QkaqSStXQTWWkXW2QqWcC1CBYRuYJPDe12Q
	8vuYF63Q=; b=Px2TqF/cH126w1jxHfJWEQ7CE3dQd7x5uicAAuk4ihfjXyIVNG/
	1y2MElE5A4UBVRHS2avom+VQAFLSvnsQXEknPOXw/ElsoPf0T/lvi2EJpalU8vQt
	vr6uCrSZiMbYKKytPPOs8m0c15mTKk5p+kM/bSIpwI0t5WGLWIo3RQD0JcP50ILk
	DJlnk/YQGGUQZ38wmEgvFuBzz96vYNw6iwkYJ5WWev9Cs579yW3VlIqsQkIL6U0E
	zsGcKc0/kD6E3/ktqjB/1TKrAqgW0RK1WvvegH+Oz2xsmKa478R9bS0iW+/lhNG7
	YakLFqKssjyIF72Y4ejBb9YizXVN9WMaN7w==
X-ME-Sender: <xms:pc6zalSNGquFOv6nHS0NsAo_h4JnVDNXRpvMgl7HZDypYx0kc5ULWw>
    <xme:pc6zahCphdW3YDKkijXSsbZbrQ6quU7qNKVz_fqtZf_sXB6wWF-FBKov9t37hsN-y
    XXa7UEXx2FhCPtl8dgdZlPo0O4tqygcI8qzBAkLnvklEA5qhY0>
X-ME-Received: <xmr:pc6zatE30aVzxHf3IjRcwVfbT1UiSOkTHk_3wjAqhJ5VVBevP4JRjvPXqkFy>
X-ME-Proxy-Cause: dmFkZTF9JPtCBl77XF3AIysiAb7nIthj4TASURBktHQsSkKeDMz+rs9DiCRuMzorwMz59q
    8cfXSu9KHw9OoztlrjaTDrrG5ed440SMjUSFjnQ9OGuw1M/IQ8rJ7Z5z0wmwIre3k+IqlW
    87azPEyCt6kvc9i2HRDBQZ3sMFO1YqsmmaQNDX2eWE5rQBS5OiFRPin9U0MHyBppUaRFqb
    QROFZMmwgwCxKSNz0P9CGHS83mRpsKJaRgLZHUxA0828HQTlBwYP+2TL6p3Ii6lyT2BkGA
    TdcVNOs3EOOEPpriscvSwX4EPkNnQa8mGgNb3sUruPUkerP0qR8lLQ7aVlM7bI92mRYAeQ
    cBWkF5Y1vbbskMeqGrwNdRsYclvyHaarpzB9HSvI7DdpoP2eU9hKIq7WkC4VJcB5sIr3S4
    R2i+7yJ+WD2KPAhxKOzkKjv2Ax+kZy2r3uKm8W8kvZRuutBEnn9y5RefBRsrEpC6ZVBGEz
    eVshzt3wDjaEMuy8K1k8GjTu0Fs8nFAKb5f/JaILfV7T6P6yYopXO3iUKukHNQskqDFEEo
    SSUGz8ingdBZglO4qgFkgA5IBDjuUCHMtvTrMN79sITsKn7GPnT0wdoWkFOpYREi5rgaqt
    CCpaUBRXXhIHpIZ4bJ91cVKzW5cvjXSTcrd+Njsu2U/Pvoz/GOVNFi3PLi1A
X-ME-Proxy: <xmx:pc6zajD4ldPFvSpF06h8Iz05R3LxllrHeIpemXSrwfKuNvs16ciRKg>
    <xmx:pc6zatWgyodTDcpFDOkvjGT-6AtOoSqF8sjS1FcTKFDAAv4BO_Zu0g>
    <xmx:pc6zano4byphuXErdTtbu_08MMvyzD8eb9HwnPeaaWhp5d4tFpGSww>
    <xmx:pc6zapQDa0661gmpR1OfRJ2rpbMM1GOZ406ZN5nY9PTrySSjf7u1Dg>
    <xmx:pc6zajqp7gWtXd3zGvFesCiIW2GwwYjY2wuiCg588FmZ700jEej5JzfT>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 09:05:40 -0400 (EDT)
Date: Wed, 23 Sep 2026 15:05:38 +0200
From: Greg KH <greg@kroah.com>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, stable@vger.kernel.org
Subject: Re: [REGRESSION] stable-rc/linux-6.18.y:
 (build)"do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined!
 "init...
Message-ID: <2026092332-census-hertz-e67c@gregkh>
References: <179016114636.454291.10412763598292369896@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179016114636.454291.10412763598292369896@kernelci.org>

On Wed, Sep 23, 2026 at 10:59:06AM -0000, KernelCI bot wrote:
> New build issue found on stable-rc/linux-6.18.y:
> 
> ---
> "do_timens_ktime_to_host" [drivers/misc/ntsync.ko] undefined! "init_time_ns" [drivers/misc/ntsync.ko] undefined! in Module.symvers (/tmp/kci/linux/scripts/Makefile.modpost:147) [logspec:kbuild,kbuild.modpost]
> ---

Now fixed, thanks!
