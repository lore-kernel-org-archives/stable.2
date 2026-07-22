Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233D471CE4;
	Wed, 22 Jul 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738454; cv=pass; b=BUQ3XBevRVkAi1HdHgg++yEK9vyNPcY/IpyWyZazL29BTnwE1WrhUpsK99MYQhgB2N3+JgQWnp4ZmpNVH9Zp0YiiSChwdfh4e0Ia/wlPKTjfQj1lIdDZc0UWEIjo8wuUwqAfz3hrbGbsBcxoXJDkAW4yZye28C2Fv6Tx/QYKLqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738454; c=relaxed/simple;
	bh=Hqd3Wa56l8zrCTwp+7xadt4cULrUkJxHXjy6wNs66S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgAxYJe+pG0Wx5nWfr5ocBpGbCEaoRWlOKd6Sti4dP1G+pX6zbReOzdL9FOteJw/gkz945dpprBHiS4PMeZW5BDRUVFzqO8IsNB2wtXpJDdOAwulEvo/Rtu6bhIQ0aaNg5JNI3j6C5vdPLtP7QATFvkyjkRbRF+YzV4So4N8UBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=EnkHAL99; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="EnkHAL99"
ARC-Seal: i=1; a=rsa-sha256; t=1784738413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VvrCmdmIeAP+oHE3sQxIA438g7kMdBAJxBc/5MSdQ278fwNQVWag2tA36Mm425SGY/u04Ig56vT4Q/uyOmgPp3r6nyRRUocm6kzTqPRAPEPccj003TZjdvL7BGkcSjZkl8qEpEaEzD4e/ko7SloG8SvprHNlSPsEqUsUdUCSDXs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784738413; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CFWy8us/akwOtk1Shi3kFXagj21q2YwusuaALSq7GP0=; 
	b=DNQvvbCH91niP29JhYXBGcc9QnfTHcKl9JOH5jlUnKZWBQowZnhlGqqPof+B7DS0hE/gitAUSJSxPzHGMTSUgIBQeziKJBrj/u1TD8NoZIOoH1vDtDTXGLxf1AGux6T2euVGDijAEfb+/u8zVLd6uQaHr5kxp+IkYKoAlI6udqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784738413;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=CFWy8us/akwOtk1Shi3kFXagj21q2YwusuaALSq7GP0=;
	b=EnkHAL994i7MjiPYJwIs9mPD+iem5vMahUKoh5altZ5+J9so3XpHydS1E3XS+LtO
	IYDwHCJQImi2JhGLv60v3bhiNFzT+wZOqnfbUfjZvv2sQ/82d/2eepz8h11sfvIdRSv
	mRq4Q20R1QxpFm5UysqgA1QRv09ZHyls9OTsPy+c=
Received: by mx.zohomail.com with SMTPS id 1784738410484852.0707588581733;
	Wed, 22 Jul 2026 09:40:10 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:39:59 +0000
From: Yao Zi <me@ziyao.cc>
To: liushuyu@aosc.io, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
	Yao Zi <ziyao@disroot.org>
Cc: loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] platform/loongarch: laptop: explicitly reset the
 bl_powered state when resuming
Message-ID: <amDyX9gPxjT4Pd1d@pie>
References: <20260722044457.1333404-1-liushuyu@aosc.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722044457.1333404-1-liushuyu@aosc.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.732.17
X-ZohoMailClient: External

On Wed, Jul 22, 2026 at 12:44:50PM +0800, liushuyu@aosc.io wrote:
> From: Zixing Liu <liushuyu@aosc.io>
> 
> On EAECIS NL60R with EC firmware version 1.11, resuming from S3 has a very
> high chance (>= 90%) of causing the EC to lose the previous backlight
> power state. When this happens, the laptop resumes normally from S3, but
> the backlight remains off (when shining on the screen with a flash light,
> we can see the screen contents are updating normally).
> 
> Since there is no generic way to query the EC's backlight state on
> Loongson laptop platforms, assume the worst-case scenario and restart the
> backlight power inside the kernel each time the system resumes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53c762b47f72 ("platform/loongarch: laptop: Add backlight power control support")
> Signed-off-by: Zixing Liu <liushuyu@aosc.io>

Tested on my TongFang L860-T2 3A5000 laptop, which isn't affected by
the EC issue, after resuming from S3 the brightness kept unchanged,
no regression is observed.

Tested-by: Yao Zi <me@ziyao.cc>

Regards,
Yao Zi
