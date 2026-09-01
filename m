Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4B3BD642
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.63.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250343; cv=none; b=fXffdufME/6zt5FKLHzxYtnJkI0lxa+dnZZV0/Uuzb3ON0y8CZ+Hcl7eln3dLCaZq98l8dE+5HQMWQzKuo9JO/fx7Fa7htWMS4fp7t21pYLjo+b0uQavDVJPu0nWA0KiAeC+INoU+PQTQZrAxSplY3mWHq3pUCKG8Yn7S2UHoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250343; c=relaxed/simple;
	bh=4CeqSY2daCzZGDUhTeQYopWIF0FYm4SjwGcx/hkVnwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luHEhYv91AcxzsotNhwbouTx8iTxt1dntdHA2SnInYlFxU1rinrzavuLL3k5+O3VEuZFQGpjl5EfOfHab+2MqyBOW9vspQUT1izD3fROt2GG9EnVNi5nSByDVcU039GuZtGt9ySs/RE39Sdf+dl9TqxkIVoTDRiKNee6WDlmouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quelquesmots.fr; spf=pass smtp.mailfrom=quelquesmots.fr; dkim=pass (2048-bit key) header.d=quelquesmots.fr header.i=@quelquesmots.fr header.b=YO+VOiUT; arc=none smtp.client-ip=46.105.63.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quelquesmots.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quelquesmots.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quelquesmots.fr header.i=@quelquesmots.fr header.b="YO+VOiUT"
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.43.5])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4hYz9Q0d8nzBKpL
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 08:12:09 +0000 (UTC)
Received: from ghost-submission-c7b579475-ct55h (unknown [10.111.182.37])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CD200100109;
	Tue,  1 Sep 2026 08:12:07 +0000 (UTC)
Received: from quelquesmots.fr ([37.59.142.113])
	by ghost-submission-c7b579475-ct55h with ESMTPSA
	id Vk3ZJNeIlmrHvBwAxQ/CHg
	(envelope-from <l.wandrebeck@quelquesmots.fr>); Tue, 01 Sep 2026 08:12:07 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-113S007f7893c6a-f9e5-4c07-a8dd-8242f6b07fe3,
                    D46D84C90CB7300EBABF53B96F8CBF09A62C48CE) smtp.auth=l.wandrebeck@quelquesmots.fr
X-OVh-ClientIp:109.190.254.62
Message-ID: <78225f07785ed89e0c3e5def8a8bb1a48e444322.camel@quelquesmots.fr>
Subject: Re: [PATCH] x86/mm: don't apply va_align to hugetlb mappings on AMD
 F15h
From: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Oscar Salvador
 <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Tue, 01 Sep 2026 10:12:07 +0200
In-Reply-To: <20260829185120.GBapMqKFM35KtL0Mod@fat_crate.local>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
	 <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>
	 <20260829174704.GAapMbGAZMwImcvIN7@fat_crate.local>
	 <0B48BE2C-2E72-4961-91D9-35E215F537A9@quelquesmots.fr>
	 <20260829185120.GBapMqKFM35KtL0Mod@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-ovh-tracer-id: 9860912862624480539
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFsmkFUMtWByGmM70DePpwoskH8cmhNdO6dO/1vSIKzHgGOi4MeoPOioQln2xVnnxk+sHkiB6jXJaUNVdk/S/ga7JWsyYaPhe9kT8Ewfg5VFy0DrELYYOY/dEwHi5ybkBUDAx/mS6Ne12nYIEIUlmhKMnl1S8zeW3zhvXPZd9Hu4ZrREoIJuctr4ONjRqmuFtQOYdBonaLY8Jn1JvA8Wb24/l5KazOavli5H0Tl/U2mkbQ0jnrJvxOei+GsXYnAkYeapyo2KjdSQxiZ/u+p65pjDp0wYcjhxDYYW0F2znd5+Ew69K0vRtCL8e8HBPFcVZO60MBp9X5I5Md4mn59Mv1ibYDVsL95q2gL8RWmKhzlqjqfBApT2yQDnWUe5V2IkPZz4YEM5nZE1RGM1L+7QZjnCAULgLVX7dqw5+SH/VC0WS5bn7vKM0mOOKDcmmuRKRR7JMHhfSxLlKnuPWYKMHg4CE2wS9rz8y9SRTAudhsrj822v9n/nB/ndccNZuBM9uSuHKlJwEEwNceZz9bpo8G/q23Jw/3Dfi9PzyCI4XIPToPSNXg/Jq43FbY2F0VHkqAfizUaDiQhS7FJ5PtTJwEMu3pvBvhjDe2fxSWZ3Z3gI0FaXkRtLMjTOul6X37zG7qw3+NX+pdW+YhoNahb596VqIujR5vJg4mM6OMoFM7P3A
DKIM-Signature: a=rsa-sha256; bh=RUaynCIfI2k00quB79erNLXXPtwh5LI+gQzFVcNXhSM=;
 c=relaxed/relaxed; d=quelquesmots.fr; h=From; s=ovhmo4049951-selector1;
 t=1788250330; v=1;
 b=YO+VOiUT4XZ8qoDOI0Sv/3sl7ux7MlR1c9FPLb4+gbU6h8q9lAxlS6tp/xFtxh1jkkT8QKkE
 /zxMZs+6DItQA4fnklzYurD//FrJ9OE935U1MsVOu81gYq00Sv/GQFGmPg282ir2KfgLkV2iA1E
 jXXJ5758nEK5fcsBkgrUcGvQGxi/Rt1Kf16HvXxL4rTbl8a5aaPKl5QbK/y+NXYT8Co25kaIL+8
 R5Lyy4gu67PhyqbIli2LKPvRbbQgOLmtnwJEbQ6k68uk0CkgA/Knxzy6MaJSOhFrmb2BykAcR6r
 gNP6PUjosKEBX2vD9UqJS9Be0nJ7z0MPMdLJBZg+aiG0g==

On Sat, 2026-08-29 at 11:51 -0700, Borislav Petkov wrote:
> On Sat, Aug 29, 2026 at 08:15:40PM +0200, Laurent Wandrebeck wrote:
> > My homelab is indeed composed of 5 thinkcenter with a10-8770e, and
> > desktop has fx-8370e. Actually I hit that bug running 26.04/7.0 and
> > reproduced with 7.1, 7.2 so I dug a bit more and AI (I'm no kernel
> > hacker) proposed this patch. I'll happily test and report on
> > whatever
> > you'll propose if that one does not fit. SSH+sudo access is
> > possible too
> > if you want.
>=20
> Thanks, just please do not send HTML mails and put your reply under
> the text
> you're referring to when you reply. Like I just did.
>=20
> Thx.
>=20

Sorry about, replied from my phone without thinking about it.
FYI, patched kernel has run a couple more days without any problem, and
I=E2=80=99m now running 7.3-rc1 with the same patch flawlessly.

[Tue Sep  1 06:55:41 2026] Kernel command line: BOOT_IMAGE=3D/vmlinuz-
7.3.0-rc1-hugetlbfix root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro
hugepagesz=3D1024M hugepages=3D7 mitigations=3Doff crashkernel=3D2G-4G:320M=
,4G-
32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M
[Tue Sep  1 06:55:42 2026] HugeTLB: registered 1.00 GiB page size, pre-
allocated 7 pages

Can I do anything else ?

Best,
--=20
Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
