Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=98.137.64.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398058;
	b=pTJR61qmD1W5ifF+owMpAtUNKtB1D6Mc17kKj+xUmxwq0jRPQFFbTvBZe4OuGaeu2Duw
	 TywYRv9WnQQ2km+svx+rilenzkKCSkYp2z8WimlphWE3HeBc88d1EERscGv58mJpqncgV
	 RX5wUMrRrQXxxx35yKv+8/XNkhdDABiYVmwoc/u4n8z9RElpPg88AoGamgOms+o3r4/T+
	 l5p0EpISD7NsrkGWciDgoN3fKu68iCnnfymF26Mt5yXmHxTlhIFgHTdDAvVWd5WA/NA7H
	 eX2VmlNIb97E6blT6qbkHA8IX9RaR06FzpO8Fu1Fiq2kk6G1VT7tCPePWAACkgMAm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398058;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:MIME-Version:
	 X-Mailer;
	bh=W3xEz09NSTWCs5ELOd+Kq8SsN3edtI9KbFEvSnSmWuE=;
	b=sOAJ0QkZ7vMXuoYL17iw+RysQq+0MMqhGMzIAWiVwcpSdM7XbJltSjcUaOt6IYzm1utZ
	 fT+vDoDwnYin/78wMo/QEDc0G292YzUs2plaHLToAsGK5riJowJzRNe2BxsvDw6JySXoN
	 379HhH0iWx5RqpoAX6cVEOLvvTWz6UAxKx4eNrXzreDyFWlosgIorgDbzmXvsN5NiiA/3
	 UJoqGKfIrELP/trPQqB6DqhzG7w2hNi+3k0sMietQ2nyrh4XvmEaBZZmARM+vnQAikTuy
	 tGar55haEoMJbClsWrVHbtcwySZrFpWTgQS1s1oiLss35TeJiqZVIGtCRr6Yc9io4tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aol.com;
	spf=pass smtp.mailfrom=aol.com;
	dkim=pass header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=D1TS6JJm;
	arc=none smtp.remote-ip=98.137.64.84
Received: from sonic305-21.consmr.mail.gq1.yahoo.com (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AA606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 22:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=D1TS6JJm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1793398057; bh=W3xEz09NSTWCs5ELOd+Kq8SsN3edtI9KbFEvSnSmWuE=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=D1TS6JJmdJ9LWJsbsPVYm+pBiofAKsX8zcH2CKIxI8dC0jiwVzkCOFlgMkWMkyHqt9loyAXr5c4+cwICKPPbjiQDkgjznOJ70apvoclrDQOaTjhrugFbkh31ModgAQOcgmr2XNqpYEAkXl7m0mgXpuEOr7q/KZbH9vKlg3PKt3l/eFhlWGdFLm35NYDDb9JYU4pFMMe7H08uRTmjvwtKhYfTp+OkaX7MeG4UqFaruHdtIXYb1sAgaBVt+YAnN18iU6KaVfdJJReDzUSopIQuh41GEh5G6jzCjgxcLKAGDu0guKNVM7XlxobUQ6gLiPc8i7485g+3lf78qlePxhh4Og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793398057; bh=cSHclHRN6xp3xnbBiMzVFWh/Ms79A9Zxd2Sq22Xa/yZ=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=JbwNLCrfthHoWCqzIuaxCCWQQsHGswtY8uVgPD7BM1iVbSf5d8kbebjpPR1OXdy+ndAN7yVV6YpGCxffqLjsKI5okbs4o/awrZIPWY8cg9sjFVGiESAnVxVJgU1RJi2brpgQsalK9RY3pMIyijmBdj5n7yVeeWHNpjNJkQocw/xkNn5jNGApqqWunpV3Ic85LPXGoY9QSwGPKBDOcG73EERu4+nbw6THCC4RkvafHKQ1YeuioE04gKfiZX3ovMMROtAxl1VkHdghYXTaMk6rj0goM7sjv17p5WnOf9odi2oclLdKa5GhU1dKVKANiYCBviHjIa/yL/XMaK5Kt+R9Dw==
X-YMail-OSG: oJDAY2gVM1kfqtgcsQq8fn6grC96khexQNThYQOfM51Pg0Zm1kPt.WJ4JMc84pO
 QW0McqID2D4Lk_JMjRZmnFHhSydvp6sG8avM9ZdmbJWWyHL4ARDBgNB9P6mpuZXYy9a1hdaJfCIK
 YV_9JdGiO0PxYxa6LKXTAShAilMuwerwa9o3FaKgelzsrUtI2dZuwHxVC3XxOtIG_5WRvKqAm3Ct
 Fp8nUsj_WB8cz6Woib9pDrbPkOLL44VdZcuUP.KAXJo8sJ5XzA0vv.REoXSBsnMICsk98Vwwx7c8
 Ntyh6NNR4jaZpuj1qQi6lJIjYvJpKNyzJmjf9BJskstKHz3kxqMNr31Byv7RlBl5QE40HZXqQXNv
 EJsW7k7dzWcjhC8umoX73z6ZUlDVZKHQ3AIQQgvHS.PKFitHkUPgDkyolYUaxcEwyJnGmt98rAgR
 .lwtAubZnZf7YbgJOF_FNL9r25FbXzZI8UIs4WM0mKcrtgM3cbtZeJH_W4T_7RJimpRBJl82jU.3
 fVzRJ8NLWi51PGKpge4DYH8wALrC6xMyamDs0T8D1jPVV1uqix5_J8o6LKn3nJQL_eJSjQIJkJjZ
 5NZskzaR5D3TYd_2LhT4C.0Jp.L5V8_wvvFgesWRTjkxdCDVUYuyGzE7P_W9knHTrDkMahRHRFBF
 z5.4jUJdr.A42z5VU20iBnZ4Tj9k8EBiL2vIVR22y2kLNdvtQMl2Vs2t6OqnWdoBPYmkq6RHy1NX
 69GN6jsl_MJ59Eylie0Na.t9tXlqae3NUYeq.CDPru3XmvEte7.jWyZee90PpGo_4zEA0Uw8ILEQ
 neon4p9S3eSC8XEDzbIqamfG_vDN0d0j1t0rR780p4vG9lhHQsPUpIBkhKZFWC72uV80Zhi._FE9
 XfzGDwHFp_0kiHTKmoqfFHrjcWUScvaI9A.aQQVhgUaBSG6CEQaEsZuKSbSa1.9wmogIxNwEKhaU
 gzMiErY2D9IyWjuGIl2kjDm1.n2ElhXkXxW8wniQHRtCgasSfCyoVeMoTX1_V3Sa41uceWGPr3dL
 ihWFKMRKJcz_s6vxVfVkK3eKRTfY19UJv0m9vp9eyaQJaWG7Uk7YlSCpVwsR7sWH353RpADzdwg2
 y11EIYAU_KJm4txKc_9I11LJMvf4kohTQldOhwGYObXGzwGKTOwNzjqMMUq2K95YkigIp.K_wndC
 jO5jc327SUF5h5WPhKCwgp0jnVz7NUOVEYTDcHwCpFRa.Qg20YaWYSXeOOwR8YIM.FNFbD.r.ig3
 ue0MfZGYXZA.a_iBemyFXLeWpPrQuWAlszzYEMmr6x82zI83o0bK5k.QRzv23Tc5ka3vkRwsB97y
 uSitce5sJw0uwRNPQ7n.G8m5FaBMDMhJ6GdSVMxEH4ZABqceC2CGpH5uBMFKu5CiYIuvKkkV6wwU
 R1_Zxvv0tLNEBdwgzjkFn1bltdFB.0ZA6SMbtnj84Ai3aGHYkrGTwszGAvevFCg.zXy8.Vmq785Y
 ee594_5IpJEXcoA_2Hx6QHuDPM7mMUlwPckH1fLY0wKoCB5AqH7Q9m2CAchLicmt7Qh5QZSFLgWk
 sQRiSI1_QPwu_M_F4neGePXKgqO1tnl7AXIUGVqBxlQIIJdgAR6e_5jpTCHE746rxRoCIX3uJpjk
 U.3s9UPRBJcb_icRLRP0ucjZWmEF8p2Gf7zv2jIPUyKW8K9X0Q5XIs6G9X7X2iY4g5Tg6xRwWWeu
 EWnPqh5cU4gGLs6KIki3rh66Z5CNL8ANxylo1OHl9L30B3qNpdrZfBdACI.LF_qtIkNtex79u2IE
 PGfqk5C6VzAtntJtABDus6apxSdM98Yr7Z1vGBBtbK3mB3phbzEKIqhQm959cl6vyp1YGmmUfTuw
 lNtDuWIWJEgyTDEMXhvLFk6qotZY.7Vjf1gLDmdgr_U3_CNOTOoElRgXrkRwm9qs20HR6DDzWAQV
 URGclJ9faqin8ZMfNxb.3AJkYmM.U8ka0dcNfj6Gu6bLTGh.i61.uFIWi2fNFskLD0CHm_6oSV91
 xHZGRuC4ogMM8KhJ.YzLYW1hvBe3x1j_LG2IEZbPNNnXNJyil6KOEkFx__m8AJ492SckIjfr7DRM
 wzz6NrkIfeiuY0sFcQhO47ZNAbtwE7PgnfbqMMctEDAkMTSdsLoBn6T0rEkznyq_mNt73gyR25K_
 haA_nptrcUh.h_XDoiNexRNnSr4KwiswZ1Eh2f11mzFeUYKwk41kkMFPYlzRaYCCNhbxkcWFKRc0
 n8RELzoJepBFCiNjDaZBRobKxo1aa7o9c56IrCL9RiM0Ur49UfKz8lFi4NvKb1x_hfhUp158S2qf
 L
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: a7c0e6df-35fc-49f9-80d0-8095c35df019
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 30 Oct 2026 22:07:37 +0000
Received: by hermes--production-ir2-5dd9bf4598-jnk89 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ecafedbbc6c5b5b5d67564947fd852e;
          Fri, 30 Oct 2026 22:07:32 +0000 (UTC)
Message-ID: <962581aca91290526f4cac2330fa97b4311051b4.camel@aol.com>
Subject: Re: [PATCH] drm/gud: avoid divide error in gud_stats_debugfs
From: Ruben Wauters <rubenru09@aol.com>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>, Thomas Zimmermann
	 <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>, Cheng Wen	
 <wencheng@xidian.edu.cn>
Date: Fri, 30 Oct 2026 22:07:14 +0000
In-Reply-To: <20261029073311.14556-1-25031212351@stu.xidian.edu.cn>
References: <20261029073311.14556-1-25031212351@stu.xidian.edu.cn>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 SWKQ8KA==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qRHY+pDfID1XrGDRy1Qi"
User-Agent: Evolution 3.60.2 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol


--=-qRHY+pDfID1XrGDRy1Qi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-29 at 15:33 +0800, YuanZhe Liu wrote:
> gud_stats_debugfs() computes the compression ratio by dividing the
> accumulated uncompressed length by stats_actual_length. That counter
> is
> zero until the first framebuffer flush has completed, so reading the
> stats debugfs file on a display which negotiates LZ4 compression
> raises
> a divide error before any frame has been sent. The wrap-around reset
> in
> gud_flush_rect() also clears the counter for a moment, which a
> concurrent read can observe.
>=20
> Copy the counter into a local variable and skip the ratio computation
> when it is zero.
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Acked-by: Ruben Wauters <rubenru09@aol.com>

Sashiko highlighted a potential issue with reading stats_actual_length
twice when a flush_rect occurs between them. This *could* still trigger
a divide error, however, this implementation is still better than
current. The best thing to do would be to put a READ_ONCE when
stats_actual_length is read.

This patch is better than the current implementation, and I don't think
many compilers would optimise it to two memory reads? But it is
possible, and compiler optimisation is a fairly complicated topic, so
if you do wish you can add the READ_ONCE, but I'm also happy for it to
go in without, as it is better than current.

Ruben
> ---
> =C2=A0drivers/gpu/drm/gud/gud_drv.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_drv.c
> b/drivers/gpu/drm/gud/gud_drv.c
> index 3a1b9e2a2eaa..85ddb302d2ba 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -329,10 +329,17 @@ static int gud_stats_debugfs(struct seq_file
> *m, void *data)
> =C2=A0	seq_puts(m, "\n");
> =C2=A0
> =C2=A0	if (gdrm->compression) {
> +		u64 actual_length =3D gdrm->stats_actual_length;
> =C2=A0		u64 remainder;
> -		u64 ratio =3D div64_u64_rem(gdrm->stats_length, gdrm-
> >stats_actual_length,
> -					=C2=A0 &remainder);
> -		u64 ratio_frac =3D div64_u64(remainder * 10, gdrm-
> >stats_actual_length);
> +		u64 ratio, ratio_frac;
> +
> +		if (!actual_length) {
> +			seq_puts(m, "Compression ratio: n/a\n");
> +			return 0;
> +		}
> +
> +		ratio =3D div64_u64_rem(gdrm->stats_length,
> actual_length, &remainder);
> +		ratio_frac =3D div64_u64(remainder * 10,
> actual_length);
> =C2=A0
> =C2=A0		seq_printf(m, "Compression ratio: %llu.%llu\n",
> ratio, ratio_frac);
> =C2=A0	}

--=-qRHY+pDfID1XrGDRy1Qi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQLCBAABCgCsFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmrlFRIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRERTg2Q0QzNUQzRDBGNTVFNDI0MjJE
OThEMjdFNTBDMDUwQUUwQ0UxEhxydWJlbnJ1MDlAYW9sLmNvbQAKCRDSflDAUK4M
4XY2D/0erGtyjfF6Fub/jBkjPRyG+MoHEmMuS/wNCBC5Vly/wT7pRTqjs8RPep0N
Mme5h2xFaRTtmoe9uARge0eVdr2TLc7MmacV4DbIrUwd1ILfvpcdaI6ekM0bCyk3
Ff2IAKLSKD2Qide1fH9VyQ7DqY4wwROCKEccSsZtm4SMlsuehD9balZuHCjIQ0g9
0YS3p7EJwL3JtFhVR2fOVbVbeoH6neuAvmE0ubU1JouTgTUUtaOBTwYTcRbIgqSP
sTXlQ3D79N9Et4OmT87V5KUxJNTwK0dnbUP5L5V033vSgvhjOjhKO2d6139yJTf0
BlmCaQDac6JqNkQljrsa7omaNtM2HV4KKWnrP4BZVDfwHHlaHfgVcBXUrquSB3V/
wL8bUWU8Hhg6mWTeVao3PZ7Xkgi9ZAQojreKBVLA297PHr2B4FpvnNSirA0yn8Bu
onVuaco+NJ8xm34tn186/eD6v0kG7Uca5mlVgIZ0iz/zSod8+FSuK2hsp9hiI0zX
aG2vM38uDEIZPPEaXNXVjndcvINiNAQonZ82fIeMjEfp3bd9duYTI8XLuPeK5ihs
LzOWpPK3YrsCu6c2c6sm2bTbmlaZD1maDcUcxe7PiQnJgmT/hu83yu6tty/mJAyh
V7oEpg7FwoNnOtL0eqweLAoMNFicU8ZZcFJ7Xez6uN/jo4QbqQ==
=EQGU
-----END PGP SIGNATURE-----

--=-qRHY+pDfID1XrGDRy1Qi--
