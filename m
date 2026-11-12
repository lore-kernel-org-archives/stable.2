Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494619;
	b=P5FMa0q3fY2OfI39rkyJ6aa65Ipnw8P+EeAkX5OyYz2AR5jmuHexZwbWcNVpPqOUCEfk
	 /V0QIE7ADmzCV5vBK3gcY3eZyFOZgjdgFl9W9S2hF5Noc/tmu/HH0nFBJVN+D0VLOn/xt
	 6SFq4rt7XaTJZ1tF7fPrXhKUitJRFhajk+cIAXTkTr5dS5O8r8KuQ3ef7OzDJKtD9eexZ
	 X7u1wN2pMCBb9K3B/+JRaXsQCgNdweeQrwlAtNtWgEJkUfoWpSim2RBjGKyuIZMVVzFlU
	 H23jxlTILMZhsxy70p0+ADG7CUVOFaCJf10MGTXUzJS7R06Zo7XA3A9a/YVRgk89QtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494619;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=BmLmIRXTRT6cun9WV23K9Y6TFiMIhvIIl7/j6XtjqH0=;
	b=FdC0SS8jX2nD9NRXb0FK0ZXpyK6l2ADN0036iOl+sqdMx96miPIA5cOgc/NpO1ELpcpP
	 +XsoDz5/K94PWuuZDssI6WEKCY7TMqm9UvKwxCgdw+BlF83DoHVsmd31RdpDT1gtbseuW
	 yyfShoEXFGiewxskpYbDwTTQwoU7ghJypKBwmZEVGXx/75av+1dHQAh32ehLW5H2JE+qu
	 qLPz/HLSq2d537TTFURXW+8GAWMAVy6CLahAOcWZuuaU55R138BlErUqXRE7HjOApxj4U
	 36mJyH8RpsJJ174zH0EDW77kAQRgmwPvkio1kFN9aMitxBwPzzPwnatIXV6eXFRfNqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id ECDF3606A321;
	Thu, 12 Nov 2026 14:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECDF3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b6855e.dsl.pool.telekom.hu [::ffff:81.182.133.94])
  (AUTH: CRAM-MD5 soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000C60CB.000000006AF5D092.000045AF; Thu, 12 Nov 2026 15:43:30 +0100
Message-ID: <504167422048bb8197a1ca3fac079cec9dea1ae7.camel@irl.hu>
Subject: Re: [PATCH] ALSA: hda/tas2781: Only accept CRC-less V1 data if all
 entries are valid
From: Gergo Koteles <soyer@irl.hu>
To: regressions@lists.linux.dev
Cc: med.jebabli@gmail.com,
  Cristian Castellano <cristian.castellano@icloud.com>,
  stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
  Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  Thorsten Leemhuis <regressions@leemhuis.info>,
  Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>
Date: Thu, 12 Nov 2026 15:43:20 +0100
In-Reply-To: <7cd4c010f13ee085e3aa4396705b6b06ed58f7e1.camel@irl.hu>
References: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
	 <7cd4c010f13ee085e3aa4396705b6b06ed58f7e1.camel@irl.hu>
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

Hi,

On Wed, 2026-11-04 at 16:55 +0100, Gergo Koteles wrote:
> Hi Mohamed,
>=20
> On Tue, 2026-11-03 at 10:27 +0100, Mohamed Yassine Jebabli via B4 Relay
> wrote:
> > From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
> >=20
> > Commit 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data
> > without CRC") only checked the first device entry. On machines where
> > the BIOS populates fewer entries than p->ndev, the remaining all-zero
> > entries are applied and tas2781_cali_preproc() divides by zero on
> > playback open.
> >=20
> > Accept CRC-less V1 data only if every expected entry is non-zero and
> > self-consistent (R0 * 1/R0 close to 1.0), otherwise reject it as
> > before.
> >=20
>=20
> ...
>=20
> > =20
> > +/*
> > + * V1 data without CRC is only trusted if every expected device has a
> > + * populated, self-consistent entry: R0 (Q27) * 1/R0 (Q31) must be
> > + * close to 1.0 in Q58.
> > + */
>=20
> Just out of curiosity, where do Q27, Q31, Q58 come from?
> I couldn't find anything about these.
>=20
>=20

I think it would be good to be able to see which commits were generated
by an LLM. This way, people wouldn't have to scour the internet trying
to verify hallucinations. Furthermore, it would be possible to see what
percentage of the kernel consists of public domain/LLM code.

Best regards,
Gergo
