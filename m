Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102640;
	b=b3XKen/ehQ1nDNnxKD8xy6gTUBEU4yErcHcFUSmYKc1a1TMJcyNKojIFDQr+1o/QGgZN
	 VY3omK/uRyt1WP2A7oHCW8zjcBlE4+IFtTAlcZ4Ueyrh8SGtXxnjC/uk+XTt+D9HMof6e
	 hURojqizzob+gDq8GJxA+qlpYk9ZEc0kgfpnicmtriWU44WY2oDuzWYhTMIOLVarNYVfi
	 TRC5XHWfQUqV6BhClRf6AH2W9GZX52rIe6ZV7Gp+AS4GrJUYbcZg7t5zxhbKkXgIy7VEY
	 ymRU3H7G5tvRnP4+fdOpsmItkiI1VODIJ12AxID820wouhVbFKNzgDtWWLMxKZFLaYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102640;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=TSxbIF6ipVR6fHLgyUMCxXOSJD1BZEEyFNVMKykwb6I=;
	b=qguMyTCOSUlpZEgWCATKFMr6lgUeUKaAn0ut+zCnTkFaYpEyTozMQPvOkyXvgBtJ9gkR
	 tr2eG8JhvTss3wh+WxkfId5oTWCkdmw/SO/sVgr8RchUcF+hiUHubuQQws3KEvWG67rIv
	 FxA/8mpuTyx5hwYnZyMwBVm4Y1Nyz17BU6htfcO+6Le5a9+FSjWfrIXXRKOHDBnRYxziR
	 q5xcBnJIzCHa3OPt5j11goQm+U7VkbccYTOe1KKAo5fbjZN8vDKI4JHRY832hOPEHvCMH
	 QU66J0FiTCQQyba8UDP47ES/Igppk4X4RJn6/WK3OjmXNfV/GMD4EIUyita1iBzuV7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Jq3MCcnR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDC606A339;
	Thu, 19 Nov 2026 15:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FDC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Jq3MCcnR
ARC-Seal: i=1; a=rsa-sha256; t=1795102631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EWq/QAxU8knIWa7pj5uFV1/HfTLbuNuJBOFIirp4FmQemAIixehZotOV3aQeNvMq2hRaRPxDXO6wWhVSjutpKkHk6rjefVVlIDEbHPBgsO2ET1dhML38OeVINfMVbHVwtJdxBwpDyxHA9AA/N9u/PW3x/wGmv/8vmATxfqj8OgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795102631; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TSxbIF6ipVR6fHLgyUMCxXOSJD1BZEEyFNVMKykwb6I=; 
	b=lvqrd5MnR2VIemRNJg/tCUz77SBrTDaBhTkO5EKTTNPNISSPQCtoExUBSKYZ6kr34R+HN1ZZA7+OrGxcwD6gc+oXMPXOh34QibwWwQsc7+C9niM7I+L7mgVWhVnPVJVXataenfQLftHUwsv8Z47BGAmbFW+lV+VEcF6TpbdHkO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=Jq3MCcnR+a4aKJr+Us+J5Wus8w2GCbsj5NS7hnjOBvKb5SjbNTNMPsH8NAEDCR9ZSpdkU2ClQSiXb9m5TnjU50ZWkdweafkaVVUDDyWqD4WemsCeKWu2A87UivqbkLIJWkCS3aW4I+al//VXfMIqCom4sevuf9YPPqMgnI14Eu7MMYmWfA41gqy0Yt+MOpfPozWi2HmkLDL1PHKZdlJj4/v3hcsNQNptEhAjT6iJ7emrBJknqkGnos5ptHBxulEAGfHe/JtHfWFVLFOf+ipXPif2Ue56u7INqpVGEes2h00ReLPU8HkbzEWsirDUWRkjLHRZ1uIiTRlBhlnu/15VIw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=TSxbIF6ipVR6fHLgyUMCxXOSJD1BZEEyFNVMKykwb6I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795102629481758.6470088288984;
	Thu, 19 Nov 2026 07:37:09 -0800 (PST)
Message-ID: <812366f4131b1e92b80c2f216d1ef7400400e9bc.camel@rong.moe>
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Fix unexpected
 charge_types on probe
From: Rong Zhang <i@rong.moe>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ikepanhc@gmail.com>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,  Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
In-Reply-To: <C49666E5-E76A-42E9-8CEA-6195D066A02B@gmail.com>
References: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
	 <DB59F3C0-040F-4663-9750-C387963DCFE3@gmail.com>
	 <e7e6423eb2a358faa0d2a26fddd0f992e3d03448.camel@rong.moe>
	 <C49666E5-E76A-42E9-8CEA-6195D066A02B@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 23:32:03 +0800
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

Hi Derek, Ilpo,

Whoops, I somehow forgot to reply to this. Sorry >.<

On Sun, 2026-10-18 at 18:17 -0700, Derek J. Clark wrote:
> On October 18, 2026 7:19:33 AM PDT, Rong Zhang <i@rong.moe> wrote:
> > Hi Derek,
> >=20
> > Thanks for you information.
> >=20
> > On Sat, 2026-10-17 at 22:30 -0700, Derek J. Clark wrote:
> > > On October 17, 2026 4:16:17 PM PDT, Rong Zhang <i@rong.moe> wrote:
> > > > It was reported [1] that some unfortunate combinations of BIOS and
> > > > Lenovo utilities (e.g., Legion Go 2 + Legion Space) may enable Rapi=
d
> > > > Charge and Conservation Mode at the same time, which is very out of
> > > > sepc.
> > > >=20
> > > > If both are enabled during a previous Windows boot, ideapad-laptop =
will
> > > > see both bits set and correctly shout "unexpected charge_types".
> > > >=20
> > > > A planned BIOS update will address this. Before that, if unexpected
> > > > charge_types are encountered on probe, enforce [Long_Life] to preve=
nt
> > > > the device from operating in an out-of-spec state. On check or fix
> > > > failure, skip registering the battery hook and the conservation_mod=
e
> > > > attribute.
> > > >=20
> > > > Note: the switches never enable themselves autonomously, so there i=
s no
> > > > need to fix it during runtime.
> > > >=20
> > >=20
> > > Hi Rong,
> > >=20
> > > Note that this isn't strictly true. A known bug in multiple Lenovo de=
vices is that querying the EC too quickly can cause it to reset into an inv=
alid state. I.e. some games run under wine for check the state of the AC ad=
apter multiple times a second. In such a case they can reset and then repor=
t both modes on.=C2=A0
> > >=20
> >=20
> > Could you confirm if it's a completely different issue compared to
> > https://msgid.link/58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.=
moe
> > (i.e., an ACPI mutex ABBA deadlock cause the GBMD method to return
> > garbage data)?
> >=20
>=20
> I believe it is. The invalid state survives a power cycle and is preceded=
 by a process hanging for a few seconds before the EC resets. It can be rep=
roduced repeatedly by a simple bash loop that reads the state multiple time=
s a second.

If this is the case, I don't think it's safe to fix the invalid state
whenever seen.

>=20
> - Derek=20
> >=20
> > [...]
> >=20
> > >=20
> > > Lenovo ha mentioned to me a BIOS fix for this issue will be coming fo=
r the Go S and Go 2 at some point as well, but this isn't exclusive to Go m=
odels. It may be prudent to fix any time an invalid state is detected.

Frequent read attempts may have pushed the EC to the edge of the cliff.
If we fix the invalid state immediately whenever we find it during
handling the said read attempts, we may push the EC further off the
cliff.

> >=20
> > I am OK with the fix-whenever-seen approach, but in this manner it'd be
> > better to wait until
> > https://msgid.link/20261018122348.679126-1-aliamemis@disroot.org is
> > applied to solve the ABBA deadlock issue, so that false positives durin=
g
> > runtime are reduced.

This series has entered 7.4. Let's see if it helps, as it should also
reduce the stress on the EC.

If it doesn't help, I believe the correct approach to work around the
broken firmware is to prevent stressing the GBMD/SBMC methods to much. I
will prepare another patch for this if the feedback indicates the need
for a workaround.

Ilpo, I noticed that you've applied this. Thanks for that. I think there
is no need to drop the series unless Derek is opposed to it. Further
workarounds (if any) can go on top of it.

Thanks,
Rong

> >=20
> > Thanks,
> > Rong
> >=20
> > >=20
> > > Thanks,
> > > - Derek
> > >=20
> > > [1] https://github.com/torvalds/linux/blob/32c52ec87d6245ee2d12ed5dd5=
09e40062939b50/drivers/platform/x86/lenovo/ideapad-laptop.c#L286-L296
> > >=20
> > > > Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_type=
s:Fast (Rapid Charge)")
> > > > Closes: https://github.com/ValveSoftware/SteamOS/issues/2876 [1]
> > > > Signed-off-by: Rong Zhang <i@rong.moe>
> > > > ---
> > > > Rong Zhang (2):
> > > >      platform/x86: ideapad-laptop: Factor out charge_types methods =
for internal use
> > > >      platform/x86: ideapad-laptop: Fix unexpected charge_types on p=
robe
> > > >=20
> > > > drivers/platform/x86/lenovo/ideapad-laptop.c | 113 ++++++++++++++++=
++++-------
> > > > 1 file changed, 84 insertions(+), 29 deletions(-)
> > > > ---
> > > > base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> > > > change-id: ef28eda4-ideapad-fix-charge-types-067d46d08945
> > > >=20
> > > > Thanks,
> > > > Rong
> > > >=20
