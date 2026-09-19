Received: from 16.mo582.mail-out.ovh.net (16.mo582.mail-out.ovh.net [87.98.139.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21E2DCBEC
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.139.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825025; cv=none; b=JvGiPb7Ai6nr81X0X98Sli27iGyqpWMG6PaJu7TytB8tsR6irBdfkhXt/AugeLux2+bni83we+Lhu3yOzAWjMJt7K58AVT3EDGHJoB7EEwfan5MbR4t6zPlbw8Lbo0IUwU6zO8pkx9ty0KKinuMHTwIonQ2LYsCcyB+LTA3k41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825025; c=relaxed/simple;
	bh=aOU5wawSteXdSqWO4qzo4hFyuEUf/Z6xXw3ars+XFhQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xew4DqxPiCjkGI7wSXUxmIiQYVoHu0epNwfspCiQZk9QCeZjyc1WClT+yu1ZWinyU2gOAgkpb5lgThwe1EAEJFY3Uky1dobxbZL9wVozj3IZH2XF3dS9y+/MYKK1JPV6Fsp/vv2/FmlU7Vj6oXJM+Y5A371oX8553pzMVAVrX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quelquesmots.fr; spf=pass smtp.mailfrom=quelquesmots.fr; dkim=pass (2048-bit key) header.d=quelquesmots.fr header.i=@quelquesmots.fr header.b=ifxda4BP; arc=none smtp.client-ip=87.98.139.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quelquesmots.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quelquesmots.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quelquesmots.fr header.i=@quelquesmots.fr header.b="ifxda4BP"
Received: from director11.ghost.mail-out.ovh.net (unknown [10.110.37.197])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4hn36C75bzz5wjr
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:47:47 +0000 (UTC)
Received: from ghost-submission-c7b579475-bj6bb (unknown [10.108.54.81])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id AEDADC2D7D;
	Sat, 19 Sep 2026 08:47:46 +0000 (UTC)
Received: from quelquesmots.fr ([37.59.142.107])
	by ghost-submission-c7b579475-bj6bb with ESMTPSA
	id DOQQHTJMrmqqKz4ARPrK6Q
	(envelope-from <l.wandrebeck@quelquesmots.fr>); Sat, 19 Sep 2026 08:47:46 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0010625eb38-c7d4-4fce-b293-e10b4d451288,
                    EE4819A1D5F070B8F0B9E6333000BC2C31875CAF) smtp.auth=l.wandrebeck@quelquesmots.fr
X-OVh-ClientIp:109.190.254.62
Message-ID: <45dc4a4f62e49107de788b4be9a4039e0d772fa1.camel@quelquesmots.fr>
Subject: Re: [PATCH] x86/mm: don't apply va_align to hugetlb mappings on AMD
 F15h
From: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Oscar Salvador
 <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Sat, 19 Sep 2026 10:47:46 +0200
In-Reply-To: <20260916200247.GFaqr15333nu5IAfjU@fat_crate.local>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
	 <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>
	 <20260829174704.GAapMbGAZMwImcvIN7@fat_crate.local>
	 <0B48BE2C-2E72-4961-91D9-35E215F537A9@quelquesmots.fr>
	 <20260829185120.GBapMqKFM35KtL0Mod@fat_crate.local>
	 <78225f07785ed89e0c3e5def8a8bb1a48e444322.camel@quelquesmots.fr>
	 <20260916200247.GFaqr15333nu5IAfjU@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-ovh-tracer-id: 5490732374257761563
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEnAYiyCbDbtqCO/4FtRp/yFaFmQHNQgZOSH9SGuFpLvQNjF5RY9vbvT3V+1MciAwHEKuwmx9I1vZf2xrThz2rSnRNDD22BBQhUY1DvwjF3mGZIlQBhegbAzkASiQ1MUbmQYBccAB9TFQZiiR+eBj8CfhR7hXv84juPb3eERuElnlETUfi+TONnSESzUiGrOkZ0+rRNEPjhgHtiPMq/Kh4jypy9vadXp/QKn+YJqPmHhtB+Bdn8tIpGZHQ6x5i9NRLCBKIL4CRYG18wjEScQjZ2BS36Zx5l4HQllyke+CRUOcafclYK4T19uylNvSHUeX/IknndJCCv6mazVB9tRkDwMkbHSjlHzFAHOZafQGZPDPtm+0X4nodoaN9F9GStGFT45nNq9TRZ4zsyz75Bqs7MRHshAlaCCL8am0uO4W+x7wMsRqwZNyYz/z1cQEjPLvsCkS4cwT7E72aadTheQJXq2DSQX0f49LCU6vs8G9JCoJdHH3IRCwDENcSmaYg7rOMmcE4XEVH/2JoOfrm8Vb5fdJcHaQbwRgtcJjNQp4nkg2Nt7kreouo9x+xm7/ap86VqdLJkpmiu7vRk3AvwORnQuvLVn8lZJOZFneMbragdCGJOkW586Q7OaOs5YWyFj8iz6aLkk3XfHIwCzskLWhJ/GvoRlhSEjRqqvRPfRzyG1g
DKIM-Signature: a=rsa-sha256; bh=dJ5AQwi4ZkHQPw/8D79gm21ialov4SoaTR54NOHjovs=;
 c=relaxed/relaxed; d=quelquesmots.fr; h=From; s=ovhmo4049951-selector1;
 t=1789807668; v=1;
 b=ifxda4BPcutZg/RmXXbM1TRNY7BDmuwrfDdRJaQ2rz99cFcLvxeM1kfIE25DtLkvbTxMjaFY
 QTp9QYPeVicqXI4BCxt5FWYtCPr99ZYx5Rw8GguPsVmAU0SylovIIwBAQNZi9WEL9IMcHKZW117
 aOk33DpkkvoG5HI8XX7ejGDzZZu41hWjgaxqCXUWPyXdEnMQdfAmSUgPzTLMw/LnKmM5w4HQEyW
 uEd8N91mgoZd3yxKPrsxDBEf9hx056SPbUHJ93ZMO0xhbe3I9sXT1CuiXoe0LWAegn6RijoXwRm
 T/yjNfOvCuoOCTfOtWU+Cr16zM28EBFX00+nZu5Jz8I0A==

On Wed, 2026-09-16 at 13:02 -0700, Borislav Petkov wrote:
> On Tue, Sep 01, 2026 at 10:12:07AM +0200, Laurent Wandrebeck wrote:
> > Sorry about, replied from my phone without thinking about it.
>=20
> No worries.
>=20
> > FYI, patched kernel has run a couple more days without any problem, and
> > I=E2=80=99m now running 7.3-rc1 with the same patch flawlessly.
>=20
> ...
> =C2=A0
> > Can I do anything else ?
>=20
> Does Dave's suggestion work too?
>=20
> https://lore.kernel.org/all/3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.co=
m/
>=20
> Thx.
>=20

Here=E2=80=99s the =C2=AB v2 =C2=BB patch I used instead, on top of 7.3-rc3=
.
Works without problem (several hours uptime).
If this looks ok to you, I=E2=80=99ll follow up with a proper [PATCH v2] ma=
il.
Thanks !

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6fa7f2d..a54f930e2c9a 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -28,7 +28,7 @@
  */
 static unsigned long get_align_mask(struct file *filp)
 {
-       if (filp && is_file_hugepages(filp))
+       if (is_file_hugepages(filp))
                return huge_page_mask_align(filp);
        /* handle 32- and 64-bit case with a single conditional */
        if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32())))
@@ -50,9 +50,13 @@ static unsigned long get_align_mask(struct file *filp)
  * value before calling vm_unmapped_area() or ORed directly to the
  * address.
  */
-static unsigned long get_align_bits(void)
+static unsigned long get_align_bits(struct file *filp)
 {
-       return va_align.bits & get_align_mask(NULL);
+       /* hugetlb mappings must stay on the huge page boundary. */
+       if (is_file_hugepages(filp))
+               return 0;
+
+       return va_align.bits & get_align_mask(filp);
 }
=20
 static int __init control_va_addr_alignment(char *str)
@@ -157,7 +161,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long=
 addr, unsigned long len,
        }
        if (filp) {
                info.align_mask =3D get_align_mask(filp);
-               info.align_offset +=3D get_align_bits();
+               info.align_offset +=3D get_align_bits(filp);
        }
=20
        return vm_unmapped_area(&info);
@@ -222,7 +226,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsig=
ned long addr0,
=20
        if (filp) {
                info.align_mask =3D get_align_mask(filp);
-               info.align_offset +=3D get_align_bits();
+               info.align_offset +=3D get_align_bits(filp);
        }
        addr =3D vm_unmapped_area(&info);
        if (!(addr & ~PAGE_MASK))

--=20
Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
