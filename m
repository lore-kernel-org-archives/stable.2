Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793461530;
	b=QOIUo0wCx2sJxbzHaFQXS94EY00YYGeG+vKWqRwJL2DbEU8hLIDOwOdhAOsrAgqF8SL+
	 Ni/h8sjhEsFcSqkpWOzqZlz4veJBJUpzmeYF/HuYjR//aJb3ekyQwXUa9FtpQ309cD65z
	 WVucnAKev/hcwQAHh0ZdISlvi0wKMS2gUAc2BRfDYxrwU26qPi1CTX6z/xHb7AjhsdpLP
	 lp+IxcJRv67oyOveQuMUPSJaPahxvzEKnR9GvEASCS8zwqd6vFCflvd9m//wyoBLdF2kl
	 KItGXTRdL4ZQn3Fnp+BQumo2mfl1yHpljala4xnR9O/VTFaBuZ33SbS9afUJXfhHp8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461530;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=qD482B1x9OW46mcV0NOxxvY9DRkgOEV3+OdPHjQp9+k=;
	b=dEeNT93J8DLD+CScaX0+C/RCZq6NwHtTjl2nCzpBOG0p7ia+64z62Im8H9r4rphaxmPi
	 YgK6j43mA46QGIcip0qPK7Z+jJMqnRNTgHSdRRhKAN/tWqwdMZDqnkvsUlx4cHDsHzeCZ
	 4wc20FgXZmPnJYYB/qutolLQlWkvtwepor1xsRtTtqj2TuL5VCtKrP9GFXfnk1tyG8OxU
	 H0qiF9JjbOq6qJzOMvSH7/ZRFYRX2uMYfaA5Y1V5vowYvJgT20EJabfKeM7LKJbpPhMB+
	 bzpzTb0W4kS95tz2meR9ySWg/ZPUNN9icWnDZaqUODmxP0b1PZREv3k3Ii5mvKhxQ9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=8alias.com;
	spf=pass smtp.mailfrom=8alias.com;
	dkim=pass header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=pdmSeHB3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
Received: from mail-200171.simplelogin.co (mail-200171.simplelogin.co [176.119.200.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6D606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 15:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8alias.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8alias.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=pdmSeHB3
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793461522;
	cv=none; b=R1yaqRoAkJutIgCrLEX/vyf/pc1F7iJ6ImnoDgWV9cFJm3lEWumVvfycF4yVByHm6oYJymTjcETsFHmCej8HHXMHOdzcGf+exwyGoQ5VxIif1+ozRL7s5Ws9zLTvx1awCEaakZOuNW6ivKk1eJY4/aeHzV4BGjM98UtcF+xktt+uL6uq7cL7Ehgy5yZoBr4ZaxXNb8XyOqf9FS0Oo9y9ggx7Rvkvp3kaHkr9TtiE7j+cM5QWDVnvQiXiZ4I15uq/cWwislZI9dkog5C9d4Luig87n7gjlV+FR+irsEVMpUG+ThB/hMUESuhPcR8bRPoY8YmaEcAl5GsAd+kY5meRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793461522; c=relaxed/simple;
	bh=qD482B1x9OW46mcV0NOxxvY9DRkgOEV3+OdPHjQp9+k=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=1isziRkVfAFINB+SSUOs5Obv+evrJQkOW9IvLevXdy5tSEee1p0mGXEpn4NaUvuBUrqqVmETGUiyuYs/9sHhtPq02hJJJcBg5vIpxrHOP340YzK9dt5J8G1F/o35FP/yQwe9QAODspSMyTftt+hv6UScz4m78tGylDlSqJibbfBlbjW4U6wtHrAgdtnDfzS8N0nT2fRaYoO9AAlEJWsmR4TgZVaZ9X99awff7Br+W+wo4+z+5EA6tYw9UDslLQ3C844LzKcQeNAY5crveq7guv5kz8FnLVMbLO3kOP1i8dx4143MMZqWWaOF7ft8OI2sHHw9LGsm5Gc2OJBFu5PyZw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8alias.com; s=dkim;
	t=1793461521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qD482B1x9OW46mcV0NOxxvY9DRkgOEV3+OdPHjQp9+k=;
	b=pdmSeHB3HPsR4w43goZTKVojtsSynHw87P4a1NEOtPmgtZT5QfqZEt+qXvamcdJmvbaMrl
	ork4p8f8wzDYmAZDHHTzv/3AyB0VTL+ZFAWUzl03YR8y0iaEHHa8SOZYJB0cudYdEBd1YI
	4bzM3VSVh8nmPFCX81qVRycp2p990D4=
Date: Sat, 31 Oct 2026 15:45:13 +0000
Subject: [PATCH 6.12.y 1/2] x86/ioremap: Sign-extend PAGE_MASK when aligning
 the physical address
In-Reply-To: <179346145167.7.7861216093151225931.1735978772@8alias.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?q?Radek_Marci=C5=88a?= <github.unusual340@8alias.com>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,Ingo Molnar <mingo@redhat.com>,Borislav
 Petkov <bp@alien8.de>,Dave Hansen
 <dave.hansen@linux.intel.com>,x86@kernel.org,Andrew Morton
 <akpm@linux-foundation.org>,David Hildenbrand
 <david@kernel.org>,linux-mm@kvack.org,Arnd Bergmann <arnd@arndb.de>,Michael
 Kelley <mhkelley58@gmail.com>,linux-kernel@vger.kernel.org
Message-ID: <179346151984.7.6028133845439165356.1735980824@8alias.com>
References: <179346145167.7.7861216093151225931.1735978772@8alias.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1735980900
X-SimpleLogin-Want-Signing: yes

From: Radek Marci=C5=88a <github.unusual340@8alias.com>

[ Stable-only fix: mainline is not affected since v6.13, see below. ]

On x86-32 with PAE, resource_size_t is 64-bit but PAGE_MASK is an
unsigned long, so in __ioremap_caller()

=09phys_addr &=3D PAGE_MASK;

clears bits 32-63 and ioremap() of anything above 4 GiB maps the alias
at the low 32 bits instead. The RAM check runs earlier on the original
address, so the alias is mapped even when it is system RAM, and the
caller's MMIO writes land there.

Commit ffa71f33a820 ("x86, ioremap: Fix incorrect physical address
handling in PAE mode") fixed this by masking with PHYSICAL_PAGE_MASK,
which casts PAGE_MASK to signed long. Commit 4dbd6a3e90e0 ("x86/ioremap:
Fix page aligned size calculation in __ioremap_caller()") reintroduced
the plain PAGE_MASK to compute the size before the high bits are masked
off. Cast it the same way here.

Mainline lost the bug when commit efe8419ae78d ("vdso: Introduce
vdso/page.h") and commit d4a65302dd84 ("vdso: Change PAGE_MASK to
signed on all 32-bit architectures") made PAGE_MASK signed on 32-bit.
Those rework PAGE_MASK for every architecture, so they are not
backported.

Fixes: 4dbd6a3e90e0 ("x86/ioremap: Fix page aligned size calculation in __i=
oremap_caller()")
Assisted-by: LLM
Signed-off-by: Radek Marci=C5=88a <github.unusual340@8alias.com>
---
 arch/x86/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163568a7..14529884671e 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -223,7 +223,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned lo=
ng size,
 =09 * Mappings have to be page-aligned
 =09 */
 =09offset =3D phys_addr & ~PAGE_MASK;
-=09phys_addr &=3D PAGE_MASK;
+=09phys_addr &=3D (signed long)PAGE_MASK;
 =09size =3D PAGE_ALIGN(last_addr+1) - phys_addr;
=20
 =09/*
--=20
2.56.0



