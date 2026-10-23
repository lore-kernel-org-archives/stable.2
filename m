Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768084;
	b=LdBQdVagYDb0p0at0XCAmLQc3V4QZWx+R+hIXf/5E9iZNXubjaj1t1USo5MAxDZmjzm3
	 rlploI0I2/xfbQD4dTOX3tKXR4N3iWwHPVVxL8nVm10xXfGRAzcLvFun84656ZjZCaq2w
	 xIaDaZMkUOIW2Yjfrusqq7tkLuANLTnYSi9h4b7d/8ZVcxZ+v25LZxTcQiMy+xkb1j+vN
	 RN7W3k1yVhpOaLuOnHvp/DlQVQ+eYdzgkVs58oPj67ENgejQAznV0uqIqDyGk8K2U7qGU
	 U6uuFT9BMdUKxXXRLxHBjoEiBLTgIDv9jfs4+ohviz881O2ikMxkK2a0m1l8OmRjZ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768084;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qdrUlsvoldYcUDWpeedZVww31s/jOKEn4B4s+rGecvs=;
	b=GgMPxxz1+zWLOyPQO1zma02Uv+5GohBhSoIjg4CgAqVNHAXSb9zgD7iayOPpCfY5svdi
	 QlE0bkBCpfu+xqCSNb6zjGfEEx3L7LUukrSneCnic8egfZ9kf2LHFBjBJ4IbRijRHb0I6
	 nqPNCQv63Yp6s8sRG4JdCfetD9lZgmXUiUJm2kAWoQQ0rWuZuBu2yhF/jyT40MvyxEMvI
	 0FU/2bdayNuqk46ZXhOefz0cn6gptF7NR6kZ1UvEnBXANVEdDeyZUncLJr8RINPCgZZUn
	 SEuyEy9Vkg8nhMMsQ+8d+vaZ2YDrDuTxh8Upe/YcAf0qQpP0z09HlkWvM3N1kafBeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D70606A31A;
	Fri, 23 Oct 2026 15:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Mehmet Fide <mehmet.fide@gmail.com>, "Felix K." <fk@mutemail.de>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH ath-next] wifi: ath9k_htc: fix beacon slot selection
 once TSF exceeds 2^42 us
In-Reply-To: <20261023135126.4118569-1-mehmet.fide@gmail.com>
References: <20261023135126.4118569-1-mehmet.fide@gmail.com>
Date: Fri, 23 Oct 2026 17:07:55 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wlr8qwtw.fsf@toke.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mehmet Fide <mehmet.fide@gmail.com> writes:

> On 2026-10-23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Mehmet, any chance you could test this one? :)
>
> Tested on an AR9271 (firmware 1.4) as an AP, 6.12.113, with the TSF
> moved forward by up to 23 wraps of 2^42 us. Without the patch the
> beacon goes out half an interval off from 10 to 22 wraps; with it, it
> stays in place throughout. Beacon count and a connected station were
> fine in both cases.
>
> Tested-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Great, thank you! :)

-Toke
