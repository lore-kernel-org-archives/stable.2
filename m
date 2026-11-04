Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807756;
	b=UQHyrMh00MhACG5mR6d30YQz2ztjlHeI5EfzpY56hqkpFpqaBdw+4PBYgS2mm4UHJys/
	 w1Y9sBcndl1LoSyWzu3KHVwurB14rKmGBnQkTPshuJsCkYhzDu2CbyTLKuKnQMZ1qgLCE
	 gFGVXrYkzOEdkj+52INJSsNRAdutnG6b9OpURIYgoK87MXMQvqWTzwU+RJFXJY44RHOAL
	 ZakIiU5R6k+anmlhyhUUutJyOYTo8ZoQQ+n3PswaIpggfUpAvZKPh7Btty2q1InggylbA
	 rMT3Iz1iPiW16eoxl3MvXjLeTdleYHUoaStYfZMa3/CWPAUfc8Eqzof6SI8jQ7mI4hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807756;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=p0dbpZxKDZjwc5Ue6sP7ZQyfRddfvPs1oTGO/ZNaY0k=;
	b=MhfeVXY98rric3mbsjDw7UQiHXCsMyM2fnKaGNYgAplANZFY1ErgeYwG80Vsp1I5Af0f
	 ly9TQTaVydM45kUH4PWJC7gvdQcpN/0h+9IwfAgAWWjec1oriRMcsZ4XjztWM/LuH/CJO
	 oBPDR3NJLUYZnG7mnWngWSpY2N/LEeD511ZmaPyjh584BAytiZqJPwGFimK3mLZYy0Jnr
	 CGvlRuy32Ifqef+zQU5+IF5ntpMA3gUMiH8h2fptV6/j/Ns9Cq8Fqd4LkZt9mRihUTM4M
	 avB1cYNny+wBuxDxhfwxo1zBqfNIXmkaYWzsG7Md+my3uomQ6jzVMsuFIRcSh1pg15w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D2D4F606A326;
	Wed,  4 Nov 2026 15:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D4F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69268.dsl.pool.telekom.hu [::ffff:81.182.146.104])
  (AUTH: CRAM-MD5 soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000A0070.000000006AEB5583.0010455E; Wed, 04 Nov 2026 16:55:47 +0100
Message-ID: <7cd4c010f13ee085e3aa4396705b6b06ed58f7e1.camel@irl.hu>
Subject: Re: [PATCH] ALSA: hda/tas2781: Only accept CRC-less V1 data if all
 entries are valid
From: Gergo Koteles <soyer@irl.hu>
To: med.jebabli@gmail.com, regressions@lists.linux.dev
Cc: Cristian Castellano <cristian.castellano@icloud.com>,
  stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
  Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  Thorsten Leemhuis <regressions@leemhuis.info>,
  Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>
Date: Wed, 04 Nov 2026 16:55:36 +0100
In-Reply-To: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
References: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
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

On Tue, 2026-11-03 at 10:27 +0100, Mohamed Yassine Jebabli via B4 Relay
wrote:
> From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
>=20
> Commit 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data
> without CRC") only checked the first device entry. On machines where
> the BIOS populates fewer entries than p->ndev, the remaining all-zero
> entries are applied and tas2781_cali_preproc() divides by zero on
> playback open.
>=20
> Accept CRC-less V1 data only if every expected entry is non-zero and
> self-consistent (R0 * 1/R0 close to 1.0), otherwise reject it as
> before.
>=20

...

> =20
> +/*
> + * V1 data without CRC is only trusted if every expected device has a
> + * populated, self-consistent entry: R0 (Q27) * 1/R0 (Q31) must be
> + * close to 1.0 in Q58.
> + */

Just out of curiosity, where do Q27, Q31, Q58 come from?
I couldn't find anything about these.

Thanks,
Gergo
