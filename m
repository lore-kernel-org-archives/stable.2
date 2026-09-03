Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247C3FE363;
	Thu,  3 Sep 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429492; cv=none; b=mP1699QCZDiPcSbJXvWBGrd8651fqmxoAlcfKbsZ6iDo8VQxBw/UyxTq4bulIwXDhXeq98NvtKmMXdUdTA6ioh9PcQxNFj+pU+J6aUPD9OKy3ymUDgOsn5lnIJtYS0Ii4OGmXFFa5R8F3HWyAxmLmBIXuhm5x+77lUUnx7RjHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429492; c=relaxed/simple;
	bh=fRwgEYGItg/BspoQU8Cd0R1u8oFtv7rMnbB8ZHSfbRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rza6pY5s/3IcWz6ahESDVMvw8ZjBCQWliQlRWSN0mvmekqSTDZwNA7MrdG5tbFWcDxB2OiY7DugbjhBOMMABuLdy5hvzjg3sQvMohcAHB5npSozaFdN+o8XYiO1AnrM5IwcL4tcXFIxjJvGTDHLvqrXy7PdTdHEDKjvFr4bUvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EBzNOV51; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EBzNOV51"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A2CA51A1975;
	Thu,  3 Sep 2026 09:58:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CEA3602B8;
	Thu,  3 Sep 2026 09:58:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53B4111C79654;
	Thu,  3 Sep 2026 11:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788429484; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fRwgEYGItg/BspoQU8Cd0R1u8oFtv7rMnbB8ZHSfbRg=;
	b=EBzNOV51j1dg+dq8phVr6PjKQkRZ8y628vNuUFxB39MbG/OCCfEyqhNOEPpINDpmBbLkaq
	SZyupqL46w3GPIVS1oHns2PjxdKWkCv+78qnlgCfyMNYJzy6KQKNlpUkyfQ9wWgitDRt+g
	3fEzLMs2RCHnnwblzvgjXdDAV22JbgxBX5fdl4v0M9CshbaecPNY2isN7l+mmbqi8yOjM8
	7bK7ZHeC6HR/K9RsxKXITHO2CRDciNcwS1+Cr/J8mMqdP3fGD2fnyLmY03nxhdb2NRGjH5
	986anQ/bkVbK2xfbJ5DgkwfMVbba/ORJ9sr0OICQBMlXPpgpjMBRT2togmm9SQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,  Bartosz Golaszewski
 <brgl@kernel.org>,  Rob Herring <robh@kernel.org>,  Saravana Kannan
 <saravanak@kernel.org>,  Frank Li <Frank.li@oss.nxp.com>,  Kieran Bingham
 <kieran.bingham@ideasonboard.com>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Stephen Boyd <sboyd@kernel.org>,  Brian Masney
 <bmasney@redhat.com>,  Linus Walleij <linusw@kernel.org>,  Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Geert Uytterhoeven <geert@linux-m68k.org>,
  Leonardo Costa <leonardo.costa@toradex.com>,  devicetree@vger.kernel.org,
  linux-gpio@vger.kernel.org,  linux-pwm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>,  stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
In-Reply-To: <20260902185513.4867bc92@bootlin.com> (Herve Codina's message of
	"Wed, 2 Sep 2026 18:55:13 +0200")
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
	<20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
	<CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
	<qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
	<20260902185513.4867bc92@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 03 Sep 2026 11:57:58 +0200
Message-ID: <874ig664ih.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Ernest,

On 02/09/2026 at 18:55:13 +02, Herve Codina <herve.codina@bootlin.com> wrot=
e:

> Hi Ernest, Bartosz,
>
> On Wed, 2 Sep 2026 15:22:36 +0200
> Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
>
>> On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
>> > On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
>> > <ernestvanhoecke@gmail.com> said:=20=20
>> > > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>> > >
>> > > GPIO consumers use of_parse_phandle_with_args_map() to resolve speci=
fiers
>> > > through gpio-map properties. fw_devlink instead parses GPIO properti=
es as=20=20
>> >=20
>> > Unlike PWM, there's no such thing as "gpio-map" properties.

Just as an FYI, there is a pending series to extend the nexus
node concept to clocks, this may also require some fw-devlink magic :-)

Link: https://lore.kernel.org/linux-clk/20260807-schneider-v7-2-rc1-eip201-=
upstream-v5-0-8785f9531cf0@bootlin.com/T/#m16ddef087544db31b5f434fa44be70aa=
d0b5e37e

Thanks,
Miqu=C3=A8l
