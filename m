Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036103;
	b=I5lGZsIttQuxwxUu+90EDcKvb5GPEYQC5uUqjbTq3ceWCRX8edL3WKaiQpreXzMJaAgx
	 OpEbPFRhJdmeujy5JCDjN4xxSCi+fQ8k29HK/EjfTfa95BFPf/BMRFAC23q0AjUYF1SAm
	 kCjKEG3IdOIRIGgD1HWTUmtGyXLMRYn6808slTtKNgE4KJ1RWl1Sm4s2TP9jkXrzWCjUD
	 Fl0RXRyHrbzPlqJR59YgdhDdHtVb8rKHR59iAfUUsoHxm0G9LouF3FQ5GvqF4nX6uxxvM
	 Sr1d89KhKCTmg2oy+veGNv2PueB8p5Vc24jIuPzGGCBAyTRY44r6tqlsvo0WuYFiOYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036103;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CLltlh6sC7r7rj9wfuAWPf0WXTYFuQ/Kfp/4na9601g=;
	b=2/7C1OSv/n20/1da5uJK8A16TnuniI3j5AjLky74dZud1x79uj+xw6X9Vsiw8BEafiCK
	 iKYGcefuz5Rh2g8OMaCFeTFzk9vk9YSKSKuLOyQFFwEkbm/Xj9Wry4dL+zJ6t2EMfsu7h
	 WbZen4YnDx6bUU7UfP4uWFkfFHfg9TnBRhrjzauLp6j9O4M86unUIdWItAv48TJmpaq1q
	 S8FbTVzPbgLmlhP2Bc3eNzjqoOG4coaAjZTuw3JTzZE3TZIggCRhfqWdJdYK5+xR/XVRs
	 TEVyDgItYOETFdfKVDTBXIKz7U4GQwbeZeT6pgMpnd8yEw0cIfnk+3DFJhKutD4qccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3lUipxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EB606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3lUipxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23271F01828
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036102;
	bh=CLltlh6sC7r7rj9wfuAWPf0WXTYFuQ/Kfp/4na9601g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y3lUipxHsc+8yOCQKHZ+4WiQg45grQtnp7qpt74q2XZYwgyYUHbh3X8vEaVFcTaE2
	 voniBXnQalcKfhG8h556CcNputTcGJKxBLF5+BciJIkVYUVmzleIQZ9ricR2oxi6Ek
	 /0xN8aubSEFgum5ve4WkXpi3toOZRUPn5kwHJd7N6PugslDqHpn6kNbau2boxAIZpA
	 uxa3b3EeDT5ZpgENbp2gK3PFTgZq6SjsjvR6unVH++XdECtoh/I/vgtnqMI0ka4U3I
	 HFNNH1nGDGUbEQb1zZWtlpoL439wE/dpVEjYPVjZlOUSomnryGjSv0GFMASKahROFw
	 4RPPBLfUKXrkA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8479f46ecd8so1513647a34.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:35:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw571ZqIe4kjWYPcrb8I6OPbT37N+NmI7gdqPkgK4CInqX2iu8CFS8xQ3x/TF8a3zAWye1Nf0M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIias6qj0p0fgcuBs/UE2rXm3ViIZVKOUYiSRBMUx2kuJhN1H+4
	EuP0ONRQ9+c2lSyvE0UmuQQptbYYx/4xKCTJYctvxYyqc7vA9ww1Bacr8HCoH6MD5zI2kV1JNgU
	Bboe5vFdkMhMFS9u06vchTEN7S/BOXJI=
X-Received: by 2002:a05:6808:4f0b:b0:4e7:c6f2:75a6 with SMTP id
 5614622812f47-55c0042ef3fmr5156313b6e.68.1793036102120; Mon, 26 Oct 2026
 10:35:02 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
 <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
 <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
 <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com>
 <CAL4WiiovvM9OTbMdN3+-74gSV520ihh1yqevH2T+OoWNiL2k4Q@mail.gmail.com> <CAM0EoM=-JsC1YhodxNUqv95zZST=phXFupg+Z-TSP+UWWeOYxg@mail.gmail.com>
In-Reply-To: <CAM0EoM=-JsC1YhodxNUqv95zZST=phXFupg+Z-TSP+UWWeOYxg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 18:34:51 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqdts2TKS1QqQmc9wqTGKi2UANF0_NDTFHNLON-ZVO7KA@mail.gmail.com>
X-Gm-Features: AclHuK-UIDM0MyNqU16f8_PXSAAqLu7sH8gcO6JqIb_RJufO5tUQ1IcaIWeiznI
Message-ID: <CAL4Wiiqdts2TKS1QqQmc9wqTGKi2UANF0_NDTFHNLON-ZVO7KA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 17:02, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> My position still hasnt changed at this point - and going even a bit
> further: fix the consumers in "net" and this whole patch series goes
> as net-next "strengthening" patch set independently. If you fix the
> consumers the bug cant happen. I understand your position on
> performance degradation and i empathize with it.... i am curious to
> see what clever thing you come up with (you always do ;->).

OK, let's see what I can do.
I really want to inline eth_type_trans() in the future.
