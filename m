Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832D7083C;
	Sat, 29 Aug 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788025662; cv=none; b=saSF5hKZrIeqVCWWo+n01AZR6fKlpKzdBchHSYvqFeJXxvt8RWopIw+yNZnqApffyQCnotVzixsDvEMtTFDUeItja5Oagmmu/BDtBlr3AiEyKxKYCbSUmPep94Vz/QBn0+NWN9cA98nQ7aSEWMNYe4Z8VoIPZODk9TYe56PGiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788025662; c=relaxed/simple;
	bh=Be69LvdchDAvYdhTylQS8PXG2gNfSMvIBqg9kh5d9OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ9Sxr0pETnc91XzeqcjSY3nezJTqac0jM9pLR+bzj+ypeHakSzPnq8E2RD9tdq1X84uh9wP3R2NANDtIV4X9o6eD6oJ6w1Swix5hL67I5ImcFJg+zn89p+s2mBaQFFLeyRS1VJOKAKqfiCUR/Pe2UzyzZHpi60suj9so+vlhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Yb+cY39J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yb+cY39J"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4451040E0386;
	Sat, 29 Aug 2026 17:47:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pk3SwPdkSou1; Sat, 29 Aug 2026 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788025640; bh=a/Fkaccw9B2NNKMBP0JXWptT1XXIEIi6C2kYt98ic7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yb+cY39JXT9OLBpECQxPOLbnSFWZ0MqAkTB9i44u1KU3K4urwEeBXcTF4+VTo2qE+
	 eYI/e3IruiOjfB/CsIIVoGn43ArbvsiD3x7YjjPW6mWvKQQepItC5oK1LQqYhoQZ1e
	 5GJ4FufqH5pR8YVUPJIoYUz8dGAv/v8Yf5P+ZWRlN36x9bvTIld4dGnFOgguSWirfc
	 QVnIommyiC6DcgdYIv28IF86v6NIb6ZKXmW0xPacKl122199vrBKB83OQPjRtX9VyQ
	 AF+tddUS3+o0hzGzyk2HIM8qtXfUqcAr0hNdbisFjAXCdtklnX5kJ9wB5kG+ZaSrQT
	 iqxCLjS4mJ2BwMh3GDXJZGA9/dPvRhGkIl+3jcbIiAFpr7AliJv6i5GVdCs3ym/Vhx
	 ElT0/Z1A09tFX+/RG+pNfxJT5iBAljaX2cYh3fHkroUyfcfCh9AzdPggvU0foHxWG+
	 Tsd9U4Hf0iasl23CCdKbDe8ofzr65pzGgimLtpKjbIB18yXJjmOoxL5wAIBoBXssgq
	 cOI8wuIocNklbT4Ww//Gh+/82frNeuMikkt/ERCuRtWJhJUAyoC3rz7IZI4IQpp+Yz
	 05QyaLOKE25xWlxWY8sHQFc4mTz34wzuVsNqZFdjbtSYZZDbpopYe2qPsYQrkWY5DS
	 tS3h6OpCPoXcY0YCsghPypR4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A52040E0377;
	Sat, 29 Aug 2026 17:47:07 +0000 (UTC)
Date: Sat, 29 Aug 2026 10:47:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: don't apply va_align to hugetlb mappings on AMD
 F15h
Message-ID: <20260829174704.GAapMbGAZMwImcvIN7@fat_crate.local>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
 <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>

On Fri, Aug 28, 2026 at 10:07:42AM -0700, Dave Hansen wrote:
> These AMD F15h CPUs are, what, 15 years old now? How bad of a
> performance hit *was* this issue? Is this optimization worth keeping around?

Oh, look, even back then I did perf measurements:

https://lore.kernel.org/all/1312550110-24160-2-git-send-email-bp@amd64.org/T/#m04c05a9a6f59b73d610b556f1efda8cd9e0487d1

8s penalty for kernel build workload on 3.0.

Do I care about Bulldozer?

Meh, I only have access to a laptop with that uarch and I've been using it
only to test kernels on it so, not really. Besides, we have Zens now which
are soo much better in every aspect so that Bulldozer looks more like a energy
waste than anything else.

But there are apparently folks which still use those and run new kernels on
them so we probably can't axe it off yet...

Looking on the bright side, Laurent can test patches ... :-P

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
