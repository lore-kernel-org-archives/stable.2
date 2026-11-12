Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496696;
	b=FuBVw00CpymvV0jS7/EYavsH/9fnfn5uF1j53CoKBL9L7QJTB+ucLC00C7eK9ZTtaItV
	 Q8SwBwczY4AKt8//Ny3hLRwDwmA846dki1If+h6XxlZQt68XRUQCJp8TbFW0jOA5xmLfj
	 EGPKu2XneI+tHah9r8MRAW/r2tcxjFqaEudKRIAsRNNxmqJsj7Fcn14dbxw5Y+usPYQFr
	 buuRtddgEb9hXaLXQdw6uSALuJT9eokFtzYv1mIoPi5NqwcAM1rNVjATjViycdyF+DPYL
	 DbSCCthfonIh5M+MCinyGqRziCBapPaChNVADfkKUVI+E4+az/VhPbEKx1/2m2rvVCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496696;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=r+yQthmGpU4dLS0axjn4IZvfIRlCVOqVLewaA/Ebjsk=;
	b=HOwKldXGBVmhE1JDFgmHZA4zHtREBlUzsWIE0+7OA9huUmchBOwXAISKe+52QRb/Wom6
	 ijMF6mp3PzA9q/aI7f5bIpJoofrj5O/4kD0g6WHdkSNY2gtpzmug/B2nfela145w/dwn5
	 mnOPlf/HWo/sl7abC65XWqV8fdmUTTRDlvhyOZStS3lZlacndVlwk9dmw5BBTh2pmIfMf
	 Cl52nGAJEjNGwVyI/egfArLNV6jsrbxkVVGzzFoTqvRw775HW6JrSOP9hrfcf3cOof8hu
	 IwSZD7BXLHDwwUbwYbm8flSSDP8hYIFXV92v/+K9Zq425dtN7xSZXPmCpXLBlITkvKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BDD3B60A262E;
	Thu, 12 Nov 2026 15:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDD3B60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b6855e.dsl.pool.telekom.hu [::ffff:81.182.133.94])
  (AUTH: CRAM-MD5 soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000C60CB.000000006AF5D8B5.00004720; Thu, 12 Nov 2026 16:18:13 +0100
Message-ID: <0c5d5163d292c238a27a77eda2690d8cec025b77.camel@irl.hu>
Subject: Re: [PATCH] ALSA: hda/tas2781: Only accept CRC-less V1 data if all
 entries are valid
From: Gergo Koteles <soyer@irl.hu>
To: Mohamed Yassine JEBABLI <med.jebabli@gmail.com>
Cc: regressions@lists.linux.dev,
  Cristian Castellano <cristian.castellano@icloud.com>,
  stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
  Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  Thorsten Leemhuis <regressions@leemhuis.info>,
  Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>
Date: Thu, 12 Nov 2026 16:18:03 +0100
In-Reply-To: <CAN6p6iiFz-JXOt9iFUPa3x4Aqu2c96=ERf0AMZ6pPVWspd=jLw@mail.gmail.com>
References: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
	 <7cd4c010f13ee085e3aa4396705b6b06ed58f7e1.camel@irl.hu>
	 <504167422048bb8197a1ca3fac079cec9dea1ae7.camel@irl.hu>
	 <CAN6p6iiFz-JXOt9iFUPa3x4Aqu2c96=ERf0AMZ6pPVWspd=jLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Mohamed,

On Thu, 2026-11-12 at 16:09 +0100, Mohamed Yassine JEBABLI wrote:
> Hi Gergo,
>=20
> Regarding the Q27/Q31/Q58 formats: they are not from any documentation; I
> inferred them from the data. Reading the first word of each entry as Q27
> gives a plausible speaker resistance (3.82 ohm on my Legion Pro 7, 3.64 o=
hm
> on Cristian's Yoga Pro 9), and reading the second word as Q31 gives exact=
ly
> its reciprocal, within 1e-4, on both machines. So, for a consistent entry=
,
> R0 =C3=97 InvR0 ~=3D 2^27 =C3=97 2^31 =3D 2^58.
>=20
> The V2 dump from the ASUS ROG Xbox Ally X thread (with a valid CRC) fits
> the same pattern: r0 =3D 0x3c5f7222 (~7.55 ohm in Q27) and invr0 =3D 0x10=
f615d5
> (~0.1325 in Q31, i.e. 1/7.55).
>=20
> My guess is Q5.27 and Q1.31, but I have no TI reference to confirm it.
>=20
> Finally, all testing was done on my own hardware: the original patch was
> tested on my Legion Pro 7 16IRX9H, and I reviewed and own the changes.
>=20

Ah okey, these are TI fixed point formats.

Thanks,
Gergo
