Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AE312832
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962194; cv=none; b=nKKQR1Xi7gY/rFsx8PWp9pNfwCNBqxpIEADhbPR++/1Xj+ZTocoT/dwkmU+jYR1KiFiujaPWNGxvqC52wadpdWe5d5NlYWo0s1YlClFS/c2/Juf8iwVCg5sp7Kue6+vF1+8VFmSQgbonXeEHSy1ilBaYXp79qgB1lrJbpYL8k5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962194; c=relaxed/simple;
	bh=9wlhgsYFVANXrsGvOVk1u9rJqFRS9TBMyUf0j+PmU7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7Ym9UToAXxseZ4JfnMvjN0rJQBuhPBBVKAuTLJxjGuFYHTZkua38K/5iDHOxIoylS5FjWCfnlGSgC2cVdKkEddGc/LgNJbWKvRD2RPwl5GayAVhjiPBxT3xNWCOB7rFQkYFhwJW3Peb5biR1J8GK9zWElMEXkOwZVBd2nMRdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WLT19dGn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WLT19dGn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 712C9C2BB17;
	Mon, 13 Jul 2026 17:03:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4506F60345;
	Mon, 13 Jul 2026 17:03:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E486611BD3A78;
	Mon, 13 Jul 2026 19:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783962190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9wlhgsYFVANXrsGvOVk1u9rJqFRS9TBMyUf0j+PmU7g=;
	b=WLT19dGn+cJ1Dzz6CQFTzyLAjIxLnhZTgLz+fx4GVHml6BKaoTs4zVApWN6wo4V3WZc85Z
	vYOkkYCAKZj2RnttPRYJH+OmESurFg7IOFl02rf0qKTF09ccv9Z+wvyypwOcoMwPSe59E8
	Uk9v7Gx9K6lMifmPn2dcUL0w1gf/maEa+q7awGBgIaXgEEbV9DfuAs3YEcx05SVLWrP4cY
	cy8zRMpGUrOAFlLRu4rsKMyxjJ2OZjB4od6pNWOboDUda5d0AFFzL353NBcsF24Aqf6fHf
	hrI5nI8ZgoceyqRCYMo5czob5qGiIHlLiI5cUBu/o98b+QSrco18SBfFQ1/77A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Liviu Dudau
 <liviu.dudau@arm.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mtd: afs: validate v2 image info bounds
In-Reply-To: <CAD++jL=APPmdAg1y6igZ5qxihUAMkjvRUZ26gmCBGdoA-N5edg@mail.gmail.com>
	(Linus Walleij's message of "Thu, 9 Jul 2026 23:48:11 +0200")
References: <20260708014906.1463-1-pengpeng@iscas.ac.cn>
	<CAD++jL=APPmdAg1y6igZ5qxihUAMkjvRUZ26gmCBGdoA-N5edg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 13 Jul 2026 19:03:07 +0200
Message-ID: <87bjcag6us.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus,

> I don't know if this is stable material. No-one is running into any
> regressions, I think this was discovered by code analysis and
> is mostly theoretical problems.

Thanks for the detailed analysis, I also feel like many of these patches
do not fix actual regression, but I am inclined to take them as long as
they do not darken too much the code. In this case, except the very last
change, I am hesitating.

Shall Pengeng extract the last bit (which is useful) and drop the rest?

Thanks,
Miqu=C3=A8l
