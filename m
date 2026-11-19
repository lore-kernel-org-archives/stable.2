Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074297;
	b=ctFMmDzMYS65MiWArRNVkCojf3xcXvf2aczpTo5xWlrT4S3KxH7c2OxsDFmovTmIOSbo
	 Oc0riJq3D7I3sFsgVCpFSqRzUot/82fvuD4y8O+ZQPXFaiekGxNlHq/lD7m5YN+6cl+3D
	 Eab1XCa0RI7qs4ZZJB9eDo33yWdsjqDfbXU5wInM4ky02RwiTGE9W/anUH5cFjZofwXL7
	 nDw2h2MPncd85j4PByIQlvskb1j7pxCYbPmp5hWTc1lgtlYQbQFfdK6+p1zUQGbDJrKKW
	 GpLZbJNE5/JAXqipa6T07404I9lrGoti+AU/fyFG1rxv4QSer61y8Cy3eqFbHl69U3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=qYfKBxWqJqldBkcNu1wH5zrI4D2hprilAOB9axqrEy0=;
	b=E4nc6Kk7Hs/dGeqpohq9bLGJsdaiSN3e+ayv3ZhjEtd24XgD94/kytgtHP4hLDQNRMce
	 p2a5J78Wh4Q0dh7eZnCx22CRNBph3u/EsSy8gLsyzSs5hjhz31SkTfuI1PpgKH042IsIt
	 6acP2LpCu+8nJLDqAY6xpQZfTszM5QWxu1w7/0rw1vW+7qIJ0f/Bt362W4Y5LgdLoc7Ln
	 ivldrLBf7pnrCtD4RDuOgAteBO0tRca1tHqEYyHdCUsQfRusCeRcTaX7LLw+vsHBFV35P
	 ekYj7QEOhq95Tmg8TcVFFcOMzE48nFRmlnd09g2Y9+vIPy3JTPW611FtwJ3Jol0teBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c94JkHAD;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95A606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D95A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c94JkHAD
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3413266a12.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795074295; x=1795679095; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qYfKBxWqJqldBkcNu1wH5zrI4D2hprilAOB9axqrEy0=;
        b=c94JkHADGfhPq6A6ZvheJ32gdwXx14gO+Rsijyxxs7AWo/6kbLTjI1NiVVkhCvLQMS
         pafk4gu1Zp5KUtpKB7L+/o8/Eghy+DJhphCjY4PxIWdgSHAH0fXiskS9j5NYk8YdPDgL
         APZYYEYQ/em/594L06MXbpQseEoisZ0KwEa1m2cz0VdYG2SQAPygXEujBHWr9ihX3GoM
         HXKtNfomEAlSY8agcKbvH4hFE3UL+K2AItTjWi9dmSSOUU3f1bTUy36iHDTntUeFarmn
         5PPI/CPeOF1CMo5ybMG2rsHKJh7bGBuNBhQWyz3qmHWf2jK+ndmFAchNwVbOaDEcdcvG
         9vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795074295; x=1795679095;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYfKBxWqJqldBkcNu1wH5zrI4D2hprilAOB9axqrEy0=;
        b=tuA3TDk22vHkXNNLKQo3kFrBNUEyqClEWMyJKOUX38bib/vP0JXzlK8YOmU68kdE/L
         H4cZqjaQxvPlHERgh2JU/E2irG7nKDhyuTWF8xH+6v2jPG3iE0XmaRwqdgaAbYw4cKF8
         Jfq4ORwI75gQHbDS/ZUyzHzCcqMB3cvAsQ2+zCUDmbCDchH0QcsYJAHbd18Lc48UQBer
         ZgKm+c6LNjs6eDkq88ZTFeZpA3Zh3v7S8EAhwk1iNZkpVrGxVj6kw2TMuCM5VAN6brw/
         nAQMZcV03k29ONKpRvgHNhC1m8674lk0foHRWVuhQ5wlRs84YHsUwiTLGTzDmDlg0OuM
         4h3w==
X-Forwarded-Encrypted: i=1; AL+hErHb9cBE/MtocF0cflKEB/q7O2kETc7RaRvo219a1mu/e6rknAb2lpdq/2zkM7HgzbkMoJFUrOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rVfWH0Nn8gm3wrItA9wp/HyvXjCKBtu3N1Kfvn95WrBoUjeOg
	TY6gq0O4tBvDGUoWUvFJlXavF+InwMsytuRs3W8hH5dhuQ4ct5Ul2fKk
X-Gm-Gg: AYBFou1Ws1Fy0npmxSkSgrYl0lTTwczuxzKed49EF4OU1HIZMiP5R7yLwdoZAtiYpCT
	Cd8EahkHLUGUZ+ZQo777s8a7prhiwoNf15EysIkbAvBq8WE9qRmTiur+MsRihXzYcR/+RsVEcCY
	AZIswSXG5Y9CuUKf2BtabGZ+hUIz7eAG5CwhRG4CFDs/s6Dbswb8G2kvqNxU3Hjomiw9cRpt+jH
	iLSWfmDXfZKGY8vSjh8bUtva3GaJnKF44t56dnxGO4CXbLnedLQ2DG9j8ovLrOZMUoEB7N6tvGP
	rYPhScTBgwqOtdE0zVITFo9vrtYpW7/SvT1rQ7krHvwtBg2Zhl7cxM46VHnwWQzm+9cNOoBamSH
	psGi2lKCLPQnIqwYxM0ivs3XTw+7mqewSlb7eGQlFqbto2eYYOXMrVYt20Rnf8oiicMz+MdkYbO
	oMCrWXghBovLXiFf7wpmvnSDsaG9YDmbJty4ElWCbmwmcdVhQp/IsV6YJd2cglyzBXXJ3gav13h
	1KYZ7N0nxH9Jkac8ms7zclgrHp5Mq7I7J230p0K5/ZB+CrfZSKQG6pxVLnZOuMVs1lZh6klVKdw
	/mvB1iWxM8kPnHypjnqjQPdA+24fyuLehRMIgZVLAnzHnN8tmUwVD17GQpFzSw==
X-Received: by 2002:aa7:c4ec:0:b0:6b1:c2d3:6a79 with SMTP id 4fb4d7f45d1cf-6b887ec9546mr2981335a12.12.1795074295471;
        Wed, 18 Nov 2026 23:44:55 -0800 (PST)
Received: from [192.168.2.32] (clk-166.netdrive.pl. [185.24.27.166])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef9423sm2158552a12.3.2026.11.18.23.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:44:54 -0800 (PST)
Message-ID: <637b6c46-dac9-403e-bc13-5a3b2e4b4b44@gmail.com>
Date: Thu, 19 Nov 2026 08:44:51 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] media: em28xx: NULL pointer dereference in
 em28xx_close_extension() on disconnect/unload
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 linux-media@vger.kernel.org, regressions@lists.linux.dev
Cc: jiangong.han@windriver.com, hverkuil+cisco@kernel.org,
 mchehab@kernel.org, stable@vger.kernel.org, sikorski.grzegorz@gmail.com
References: <ec1ffcbb-1625-4925-ae6b-f2b04dca1e1a@gmail.com>
 <f5864dec-ed41-4285-b888-737f3a38b33d@leemhuis.info>
Content-Language: en-GB
From: =?UTF-8?Q?Pawe=C5=82_Ziemniak?= <pziemniak@gmail.com>
Autocrypt: addr=pziemniak@gmail.com; keydata=
 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 Yt7+
In-Reply-To: <f5864dec-ed41-4285-b888-737f3a38b33d@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nYQU0oRfPYb3sqp3iHI8k0K3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nYQU0oRfPYb3sqp3iHI8k0K3
Content-Type: multipart/mixed; boundary="------------NwgqydRh0N514dRn0iPJCO80";
 protected-headers="v1"; hp="clear"
Message-ID: <637b6c46-dac9-403e-bc13-5a3b2e4b4b44@gmail.com>
Date: Thu, 19 Nov 2026 08:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] media: em28xx: NULL pointer dereference in
 em28xx_close_extension() on disconnect/unload
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 linux-media@vger.kernel.org, regressions@lists.linux.dev
Cc: jiangong.han@windriver.com, hverkuil+cisco@kernel.org,
 mchehab@kernel.org, stable@vger.kernel.org, sikorski.grzegorz@gmail.com
References: <ec1ffcbb-1625-4925-ae6b-f2b04dca1e1a@gmail.com>
 <f5864dec-ed41-4285-b888-737f3a38b33d@leemhuis.info>
Content-Language: en-GB
From: =?UTF-8?Q?Pawe=C5=82_Ziemniak?= <pziemniak@gmail.com>
Autocrypt: addr=pziemniak@gmail.com; keydata=
 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 Yt7+
In-Reply-To: <f5864dec-ed41-4285-b888-737f3a38b33d@leemhuis.info>

--------------NwgqydRh0N514dRn0iPJCO80
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhhbmsgeW91LCB0aGF0IHNlZW1zIHRvIGJlIHRoZSBzYW1lIHByb2JsZW0sIEknbSBzb3Jy
eSBJIG1pc3NlZCB0aGF0Lg0KDQpJIGJhY2twb3J0ZWQgYW5kIHRlc3RlZCBjb21taXQgYjBi
YjlhNGZlMGQzIGZyb20gbGludXgtbmV4dA0KKCJtZWRpYTogZW0yOHh4OiBmaXggTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlIG9uIGRpc2Nvbm5lY3Qgb2YgZHVhbC1UUyANCmRldmljZXMi
KQ0KYWdhaW5zdCA3LjAuMTQtMjktcHZlIG9uIG15IEhhdXBwYXVnZSBXaW5UVi1kdWFsSEQg
KDIwNDA6ODI2NSkuDQoNClVubG9hZGluZy9yZWxvYWRpbmcgKGBtb2Rwcm9iZSAtciBlbTI4
eHhfZHZiIGVtMjh4eF9yYyBlbTI4eHhgICsgDQpgbW9kcHJvYmUgZW0yOHh4YCkNCmFuZCBV
U0IgZGlzY29ubmVjdCBub3cgY29tcGxldGUgY2xlYW5seSB3aXRoIG5vIE9vcHMgYW5kIG5v
IFVTQiBoYW5nLg0KDQojcmVnemJvdCBmaXg6IG1lZGlhOiBlbTI4eHg6IGZpeCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2Ugb24gZGlzY29ubmVjdCANCm9mIGR1YWwtVFMgZGV2aWNlcw0K
DQoNClJlZ2FyZHMsDQoNCiDCoCBQYXdlxYIgWmllbW5pYWsNCg0KDQpXIGRuaXUgMjAyNi0x
MS0xOSBvwqAwNjo0NCwgVGhvcnN0ZW4gTGVlbWh1aXMgcGlzemU6DQo+IE9uIDExLzE4LzI2
IDIyOjU2LCBQYXdlxYIgWmllbW5pYWsgd3JvdGU6DQo+PiBDb21taXQgODI2OTE1YjZiNjVl
ICgibWVkaWE6IGVtMjh4eDogZml4IHVzZS1hZnRlci1mcmVlIG9mIGRldl9uZXh0LQ0KPj4+
IGRldmxpc3Qgb24gZGlzY29ubmVjdCIsDQo+PiBDVkUtMjAyNi04OTg5MSkgaW50cm9kdWNl
cyBhIDEwMCUgcmVwcm9kdWNpYmxlIGtlcm5lbCBOVUxMIHBvaW50ZXINCj4+IGRlcmVmZXJl
bmNlIGluDQo+PiBlbTI4eHhfY2xvc2VfZXh0ZW5zaW9uKCkgb24gcmVhbCBkdWFsLVRTIGhh
cmR3YXJlIChIYXVwcGF1Z2UgV2luVFYtDQo+PiBkdWFsSEQsIFVTQiBJRCAyMDQwOjgyNjUp
DQo+PiB3aGVuZXZlciB0aGUgZGV2aWNlIGRpc2Nvbm5lY3RzIG9yIHRoZSBlbTI4eHggbW9k
dWxlIGlzIHVubG9hZGVkLg0KPiBUaGlzIGlzIG5vdCBteSBhcmVhIG9mIGV4cGVydGlzZSwg
c28gdGhlIGZvbGxvd2luZyBtaWdodCBiZSBzZW5kaW5nIHlvdQ0KPiBpbiB0aGUgd3Jvbmcg
ZGlyZWN0aW9uLiBCdXQgRldJVzoNCj4NCj4gIEZyb20gYSB2ZXJ5IHF1aWNrIGxvb2sgdGhp
cyBzZWVtcyB0byBiZSB0aGUgcHJvYmxlbSB0aGF0IHdhcyByZXBvcnRlZA0KPiBlYXJsaWVy
OyBhIGZpeCBpcyBkaXNjdXNzZWQgaGVyZToNCj4NCj4gW1BBVENIXSBtZWRpYTogZW0yOHh4
OiBmaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIG9uIGRpc2Nvbm5lY3Qgb2YNCj4gZHVh
bC1UUyBkZXZpY2VzDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MTEwNDA1
MjgwMC40NDU1MS0xLXNpa29yc2tpLmdyemVnb3J6QGdtYWlsLmNvbS8NCj4NCj4gSWYgeW91
cidzIGlzIGEgZGlmZmVyZW50IHByb2JsZW0sIHBsZWFzZSBsZXQgdXMga25vdy4NCj4NCj4g
Q2lhbywgVGhvcnN0ZW4NCg==

--------------NwgqydRh0N514dRn0iPJCO80--

--------------nYQU0oRfPYb3sqp3iHI8k0K3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER04UmKeiiaaq41dFcmYujAqyJDAFAmr+qPMFAwAAAAAACgkQcmYujAqyJDAW
iw//fT85NPSOr5HWVPGcBN+YVKVxjtESNst7eruRQGyXNplo9UjhkJN4X6U/XiUsgGDvxSLNqkbK
dJPZaR5tWB+yLQ5bSbxXLfkcWYUDRMP/pe+kD+oFwTIkzT+beHWUrj4xksCcPz1znO3FuH91A2hN
G+EreifZEj8/r3tFfGv0BNZEnOIcLp96eL1fxn8xreLj/VCLJjnVlTA+TtxLWGpPVjJe3ipFNqBf
Jx8oy/J+RIHvLqDG5L5x4cxR3L/AXGoQGForsyElZbZ5DGv0BMGQBGr3RxFIacnir6JLkq5cTKWH
t2iVZV5oM967SgsUhBEGcMphvws6dxkr90aLEZ+1eZsGyw5q84QgXDbM9gf6v4XBBwFmNLg9nJ1F
hJ2OIMji4G+a4E8gQDvLuN/QGWA0uAXXqGr3LPYxtIlLabeQePfXT+Tga28XqRqADRc85eWgiIjU
y2MnzNx8n7jSAomK/irDop9cPbPwDivdPsZru0q1I/uJ83JHOgQ7OeqEuPlPr2j+qspQHLRMOXer
CNrR79ZYNSBZVK7CsivqFtZ5YGK6guNCpdaRELpg/nPm+TJlHFnHYP8yvu9Y1PiGxXwqMiDIqcuk
YbHWUigJMy6RRdxSsHlNfK6fPhBkpOZYRLrPkNp7e0ms5cEaNIQWmfhn2GNc+hx2O3RMY80+N+xx
8Rc=
=LAtx
-----END PGP SIGNATURE-----

--------------nYQU0oRfPYb3sqp3iHI8k0K3--
