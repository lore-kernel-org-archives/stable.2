Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D7456DEF;
	Wed, 16 Sep 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589027; cv=none; b=AnhHsEQR1ZLfaZPRmEUQAC1J/H0d2G6mBs2ncx04p6nJkTQ4j9YDpFKxH9YcduC4WxG1Wiro+pGW28/YaK96uuSr+JfLOyr1lp8Y9BrsObeFlH/GfoZF1S+B1VXlCA9zW6EY04fDr6KXtuWQUHgai3wG3DhmY8SgFN9ROm8shHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589027; c=relaxed/simple;
	bh=tX/XxkdJiKGzp+iHYDN/OmiukWcwyM5FfI5SaF1oA8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJUAT2uI13m8aljo6e3VNK6SNQgnjfGxiBy35BWGKa1QmusNGpzenxD/fhlWc6Nx153lB4e/lKE3h+odmo9LJUJJk3hh373StZdBkNLaQBdWnpKpkBlElYFCeVrJQIhCDW96YPq1vJ+gHN7yGkeFSnaQcXnJ5oHUyFnvUEqAZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=blk2F85Q reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="blk2F85Q"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D9B340E022C;
	Wed, 16 Sep 2026 20:03:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RmiEDj15sgaS; Wed, 16 Sep 2026 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789588982; bh=tt4wGiGWSGVWCHbdak83aGerpHRJn8vrvoGhdde9P2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blk2F85QFszaob+Y1xO6ahKBOS2FgDvoEvkATB/sVUDpf1rkDZvEkxvnXIYfMx9DK
	 rj092M8OcL76s0/QHurHv3WifWK7tiMADyWig8Kj1NUtCiIAlMRj1f6MGiTYP/QL8+
	 s9iVQpUP4Xh+1n6J6fyqiK5jxNpPtU4tgeRjKVj5RVzkCREqlmgv3TQRa2BQbfSdB9
	 XWBem+1JKnnNlDzKBNC26wfv9FtanTuqDcR/5kJPQXTnAzJHKD9C82mGx6l8WXrjMF
	 nTUTaOfEgL+DhJn5Bar5CezMf4zzXUJ0yRKIVTm2CDsc4IdI2VQ/wPHAr3+kr+9B8u
	 G0IVD6BIegxGt/gbLEifGe91mzFdC0nN0DAb/w3Zwlo24prvNav3a8dh+UzfQYZpWD
	 Y84NxQfJ5K12Wx6uG1tAx7v55XnPyFw63HKRAScwteodUibkfDjTmukB9EDROcYIsr
	 hO2W9VFW509dBSlfBL5mVyt/eBB6sH4S/diucCUK3sUbZ63cgDM1xu/LAmb4x6mLp8
	 +TsVQO/hcF1HP0C69Jh1aykMcLWFqyLVoAuNNjaskXC9B2DPOKY/JsEAThY2Ap/8M9
	 9ZmnGuO1Wv9KWdxZbpVkzHpPD2QGUEqkdkHhtCCF44+Q3PqVemUqWcQnbRjpYzkGYW
	 i93Um7YzT0iEcrpcjnnY7ys8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23C6340E015B;
	Wed, 16 Sep 2026 20:02:49 +0000 (UTC)
Date: Wed, 16 Sep 2026 13:02:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: don't apply va_align to hugetlb mappings on AMD
 F15h
Message-ID: <20260916200247.GFaqr15333nu5IAfjU@fat_crate.local>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
 <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>
 <20260829174704.GAapMbGAZMwImcvIN7@fat_crate.local>
 <0B48BE2C-2E72-4961-91D9-35E215F537A9@quelquesmots.fr>
 <20260829185120.GBapMqKFM35KtL0Mod@fat_crate.local>
 <78225f07785ed89e0c3e5def8a8bb1a48e444322.camel@quelquesmots.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78225f07785ed89e0c3e5def8a8bb1a48e444322.camel@quelquesmots.fr>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 10:12:07AM +0200, Laurent Wandrebeck wrote:
> Sorry about, replied from my phone without thinking about it.

No worries.

> FYI, patched kernel has run a couple more days without any problem, and
> I=E2=80=99m now running 7.3-rc1 with the same patch flawlessly.

...
=20
> Can I do anything else ?

Does Dave's suggestion work too?

https://lore.kernel.org/all/3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.co=
m/

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
