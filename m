Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97413376BF4;
	Wed, 12 Aug 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562931; cv=none; b=JMJRS7tB1V5Rlk4YLR0Rh37Kxnm7AMk50S8C2VQB5dfE//yP5e9u8a+9WeNUr14/TrwvrtfxZMABE2IatlMLvpLHHBBIZD/gGVPmyMp/ZtNt5/TYJdoS4T8v1DYJ4qIaoJxAgnGXAJ5z9V/VT679smZUEf+EOwnkKyQ6p1D7qa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562931; c=relaxed/simple;
	bh=3XnHC0DVllVOt6/ZQ3t5ZEH3jeWTipLeQ2oyMlfWXOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUJtvoKnJejCJkYb386N6VRuxkgxe3Pfef4x1H7vR9gJ2+qSh3KVYXUIPxdeop2mHj4iD64re67ObyURTM0gAL4lNryv10pTSr9cHJuFzjKvDWgAvP9sxTtZZo2jOhkG5dwgWw/XvQ65uNhQ6BbA1PZA9zyKxzhlCQc2hPaG0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HBhviH2p; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HBhviH2p"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 62B2C40E019C;
	Wed, 12 Aug 2026 19:28:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zBwp3l6Z0Srq; Wed, 12 Aug 2026 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786562900; bh=9loqUz4Pcv54vP+W4tVu1J1nngYvbZQEx4M/Vf5L2MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBhviH2pYePIGeKUdNUQ2Z+WZokV5t9k/fTdi9i61bksAZveU663mylib7cf05WFk
	 YMOV73rhlyopJe/ITGNzRL/J76d80PPvOrUjBfwQggNcVr+pas4kJd2qXnauiA1OnK
	 8x2k/jv7Idnmrhzkc/OlNCDBhyl5h9WFEo9EhSulCTJT31xupZpBhkFbqCho6CCgjG
	 1FmXxkTngIECxObnPGuY//GbWrk0h6sm1ygyvZ6fIurZ7O9oDVVCgWhSKe8q16ZtCP
	 HecItBZnIstsllVWiNDKdt1HR+x5V3jjQy65T7j9Y6HG9X2I4O6l4yFZ8DCmSVSSR3
	 MSj93v/9IztReuLbd55EuNLfgVvAjP0D4t8IQUzE0jfZIojZlgOcKGO3Y5pyN+yUPM
	 d1FoQWmiBoYvGhAaatEPWXBg+83WKqf/xMBnTdczdAJ9MlsdE2GF5v47eUZYdsm6le
	 DyDpmYTd/jOK8iLKi9u+eBmpj/lg6GsU8PRxioraKW3uRA00VXLezVW4uJMXxGmIe/
	 7m+KuGAKGocz6pGaAPVYOjwcQeyebhA3MZBROdmivZjBzEybVmIVwn83s4HqA6lJ6m
	 qvArS46iqA6cGrU7i1LU0eHUrka5zbon4kQqVTiyuYRuZKBrcqseo7VkJap9zGQ2mF
	 HOKjzlKbB+ytWdgi1n/a5Tnc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7D8C40E014A;
	Wed, 12 Aug 2026 19:28:08 +0000 (UTC)
Date: Wed, 12 Aug 2026 12:28:05 -0700
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
Message-ID: <20260812192805.GBanzJRTgkrti3Bm7F@fat_crate.local>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
 <20260810140747.GB57095@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810140747.GB57095@yaz-khff2.amd.com>

On Mon, Aug 10, 2026 at 10:07:47AM -0400, Yazen Ghannam wrote:
> 'smn_exclusive' wasn't originally intended to be used for bounds
> checking the array. But the original use is no longer needed, so it can
> be removed.

Why is it no longer needed? Apparently I didn't get that memo yet...

83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access") is
talking about the potential concurrent access. Why is that ok now all of
a sudden?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
