Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF92438014;
	Thu, 13 Aug 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641853; cv=none; b=tQi2PyS4qQs1tcZ9GYSXNd4Vukuodhqd2kfhlk7MX1MwI9jQw0NrPvCg4hdxQBsHrR76KImWABqctoB61/zrxuGq/km8PWIF2AzSVmyDvsvB5aAm4z9PuW0myQIunp6+LREaReNcsaLufQ+6OC+97/2QP7yDjnV07K/Yh9BQfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641853; c=relaxed/simple;
	bh=XHyIg9N7atPTVPE/jkIkUfgWNX1SrxAnr7rAiiTBTlc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HqW+CivVJ9uyQ1Rbu7IIQCiCNE3MbfWo2R/EEvKBUGN/d80dbAbGCvvPmucEBEVgST3Cc3bGoXUxJeMBT0HXTJLRbU2VjIah4CPyvCfaSuERNdfhYbUxwFXkgFgsF87/sG8m9cf6l2eNfcyR7Jh7G0+fgJe24zTzZ5DGCWDSM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UJ5uoZ5T; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UJ5uoZ5T"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F22E640E014C;
	Thu, 13 Aug 2026 17:24:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TVj-N5WKAZy7; Thu, 13 Aug 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786641835; bh=XHyIg9N7atPTVPE/jkIkUfgWNX1SrxAnr7rAiiTBTlc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UJ5uoZ5Td59CHdLiaeAnxSPslsm+K8uAvZVeIUvLq2LOCtSIL/1TEat1iZjkU7IGf
	 bWHW3/RN7pLQRGbovVC13WRNYKXf9PYpB4rIuEpsGroYX4uMmheGA/4wn2PIxWrd+J
	 aI4+xbAdwFU1b79IlD8mGPAZBZWAgFQsLvDQiGO6nZs4kALs6nyKoF2IO1Q7Szjwz8
	 m+jBhydkVqePKUrhPhVC8u4sL593VoC6452uBl2ciwIHFgbeQHL8OAnP+nG7rWVF5N
	 /7ljH5n4fbnyDxlw6kwQWZomvBZTM5/4gjysaAnQqFAywyGKiL2y97I8GCVyOBk/8i
	 1tHHD6C2RRWerQHE33Yi8vMYN+YQci9JUnzGpIgiydktqps0ijSYO9W/zJXc1Ct1MT
	 Tc1Opor4TPiqRcJQviK2QKAV/hm7Ci3DJEz++6+KET5TYjfaBQbLf/HwahcpCdCL+l
	 7zBAXsNk5O3E5slR+yV4F+H9PXY1lwiPgjLWTvsWMuRh4baZzvA2y69P+FBSDwjA+w
	 bvJVI3O69SFivEJQQpDHf/SMtYPfKloal/1SD78UzRa5hGdYjLJ1CPKfTz7RsE75n0
	 QE0SwTf05yN422LoIWq+HOvtU5oSsMI+8POmu90vvW2wKieyoK0JkHWBc80yIx0XeV
	 +yWaAb4wNV3oiuVntSWVGf0w=
Received: from ehlo.thunderbird.net (unknown [IPv6:2600:1700:38ca:c00:f14e:c43:6b6d:c6e8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60B2F40E014A;
	Thu, 13 Aug 2026 17:23:43 +0000 (UTC)
Date: Thu, 13 Aug 2026 17:23:38 +0000
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_x86/amd=5Fnode=3A_Avoid_?=
 =?US-ASCII?Q?divide_by_zero_on_virtualized_systems?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260813155621.GA1384528@yaz-khff2.amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com> <20260806160159.230453-3-jason.andryuk@amd.com> <20260810144706.GC57095@yaz-khff2.amd.com> <20260812193117.GBanzKBaDLIdI_1Cfa@fat_crate.local> <20260813155621.GA1384528@yaz-khff2.amd.com>
Message-ID: <EA7B273F-1BC6-4685-9568-1F58F4AF91AD@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 13, 2026 3:56:21 PM UTC, Yazen Ghannam <yazen=2Eghannam@amd=2Ecom=
> wrote:
>On Wed, Aug 12, 2026 at 12:31:17PM -0700, Borislav Petkov wrote:
>> On Mon, Aug 10, 2026 at 10:47:06AM -0400, Yazen Ghannam wrote:
>> > I don't think this is necessarily a Firmware bug=2E
>>=20
>> What else can it be if we're running on baremetal?
>>=20
>
>Could be the hardware convention changed=2E Unlikely, but could happen=2E
>
>Thanks,
>Yazen

That's ok, we'll address it when we cross that bridge=2E=2E=2E
--=20
Small device=2E Typos and formatting crap
