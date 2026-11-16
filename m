Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794834239;
	b=ydQ7cQV6ZPXQMq1DgDQPk7Z5oaRH8+xNtHtRMH/Egf5FEJvTi4rzUxGD0G1nK7f1qi6a
	 KI3fg7PPRd0DWsYxYkRoQIFlas277H8r4jMUeZeA0rdiIzRuXfFXGQMQpOyVIkIXxooL5
	 I5EMOCoKZypRRQ+7stn9bD9vFrhDJ3X7mbDv/nkpLXYu8DpQ5kVdjG/h3BYM2euVKGdax
	 CeFNcqhipF49STqqrdV8oIb/qPZQxc0qkHCDDnESzarCKUZEXCxLV1WisKhJK2/nBm5fQ
	 O3GXGv4aCh6ZU1kpXjNBt1Aee0NBE/r+W7idCpP3A4e74Sr6pg/eiOOvAEPne9wlbGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834239;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=KPYkIWZhs3H95NN4p3RKCVS3MwCGaBCJ5wMRZZhvXy4=;
	b=tCTnDCy+I7XYidWjs+2MPqTIjT3kTXUyOJpIojn1m5m5upippxjsoMr5UYGllmcwQIju
	 EQ7Ay0uySLo3KmNrPc/OJd6Wfo32KrDlaf3ahrQTSbjAfPNuTmps0uOjT7ARGaujPm4ra
	 82XllRGb83IK6TdBaq8fPhonw+kdph+mdR4IfDeiQQpNP42sDGxscCnT/EN/DhTbqgwLV
	 N0sMWRue3dF6sCMocCKa0RmkhbD0ajpYD45Y5DxcN8XrcxgwNnwKcJDrFHx13ki3+AH3I
	 tpH8kAiBLaWRQC/rbOJUX8U6rfAAULpPG8DNOUhRLh020/wyB98WxA3YbyKzv6IbZRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=rJBoxq12;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7936606A31C;
	Mon, 16 Nov 2026 13:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7936606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=rJBoxq12
ARC-Seal: i=1; a=rsa-sha256; t=1794834217; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OAvEYWTeXEV1ufSwWHz9pxnUblLOslPWrnzfHc1grKvdJ4dZjwENG26dQcRoXIBMcuJt2itcuBWMbQTjI8phtotccNdaAyNOh+87JmJbCJilx3sySOhIdO8dsAAo0ebsAYIOkYpz3NJiL106et3D89TyF4xCbkMmiNjwMS+b/oU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794834217; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KPYkIWZhs3H95NN4p3RKCVS3MwCGaBCJ5wMRZZhvXy4=; 
	b=XOALMFv0dVI1gzSWsSPx/B8SKPOKnuDZnFGvpKmRhtDlxXhKyH0uypTFRlRCSjIDryB5BdOQp5QrcMusD7Yi6sNyLQUdWpnDseamo3IljnPUVOSu2JpN/FrwmI50mTtt/MWgHaGfqxJp/GqOZLlQEMKIkG+xXgRIyd7+ijVx/NE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=rJBoxq12x8Z3dTikubS6j+QJrSWk7fjborPjQX04fLVEX2z2lJWxwA//WitSw8WCpL8RyRDPCayx2Oxk9RjYMQbpz+1ElrIrLoVheBIWI1+6SDG21MnYh2ufHUNLpTdeBzoEmZRLVJWuHUyG7lL9/QsW7nuc9uuL7mtKn9OWA12tcro/fuACJwFTHC92YzhHWBRxWJTr2K4wkRKfUReVy8QB2KVaTIsZJsRrRIQb0I9hL6hJ1Qv8UoEe4ZKKOzKv8Ni7pRlOEk0MGGrbr/9lm3hoFhZqXTyiLBc+BnmeYiaBcMT00YkLxhygfLGsC8a81aHsqzAkMEIBcFjOJeh0eQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=KPYkIWZhs3H95NN4p3RKCVS3MwCGaBCJ5wMRZZhvXy4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794834214683661.5338127039739;
	Mon, 16 Nov 2026 05:03:34 -0800 (PST)
Message-ID: <9678d609d13700b186e647ee31b2c9b9788f7206.camel@rong.moe>
Subject: Re: [PATCH v2 0/2] extcon: synchronize all-connector removal and
 fix Lenovo fastcharger teardown
From: Rong Zhang <i@rong.moe>
To: Hongyan Xu <getshell@seu.edu.cn>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hansg@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
	 <cw00.choi@samsung.com>, "Derek J.Clark" <derekjohn.clark@gmail.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <179474326098.103840.15531040789536968458@seu.edu.cn>
References: <179474326098.103840.15531040789536968458@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:58:25 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Hongyan,

On Sun, 2026-11-15 at 19:47 +0800, Hongyan Xu wrote:
> The Lenovo Yoga Tab 2 fastcharger driver releases managed serdev,
> pinctrl and GPIO resources while its extcon callback can still publish
> work.=C2=A0 Ordering the devres actions alone is not enough because the
> all-connector raw notifier does not wait for an in-flight callback.
>=20
> Patch 1 converts only the all-connector notifier chain to an atomic
> chain so unregister waits for callbacks and is safe from interrupt
> context.=C2=A0 The per-ID chains stay raw because some current callbacks
> perform sleeping regulator operations.=C2=A0 Patch 2 then installs the
> managed work cancellation before the notifier, so reverse devres order
> stops the producer before releasing the resources it uses.
>=20

Where's the link to v1?

>=20
> Hongyan Xu (2):
> =C2=A0 extcon: synchronize all-connector notifier removal
> =C2=A0 platform/x86: lenovo: cancel fastcharger work on detach
>=20
> =C2=A0Documentation/driver-api/extcon.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/extcon/extcon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 28 ++++++-------------
> =C2=A0drivers/extcon/extcon.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../lenovo/yoga-tab2-pro-1380-fastcharger.c=C2=A0=C2=A0 |=C2=A0 6 +=
++-
> =C2=A0include/linux/extcon.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> =C2=A05 files changed, 20 insertions(+), 22 deletions(-)
>=20
> --
> 2.50.1.windows.1

Using Windows to submit this is quite weird.

You submitted a lot of patches to different subsystems at the same
minute. Did you send the email yourself, or asked an LLM agent to flood
LKML for you? Did you (or your LLM agent) test it?

Could you at least figure out how to send patches in UTF-8 correctly
before deciding to use git-send-email on Windows? By using Windows, your
configuration couldn't even encode Ilpo's last name correctly (I've fixed
it in my reply) :-/

>=20
> Discovery: found by the author's in-house static analysis tool.

Wasn't this just LLM generated?

Confused,
Rong
