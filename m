Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669748;
	b=5UwhoPEjzbnchg4gC+Y0GLSY+w6z5U1fnKVLzt8E/FBx3mNXfIzRLbTXvkjOGe9lK92F
	 DZ1dCS5bTpWVfoeV+gPSj/CUlAAx7WD05HaArnpKGJ/petAyvfiEu9GZ9DIOTJovM+I7y
	 qKhBjyhW0DFTMO4p5HnUbublQLbflys6jHwytuYVh/vvsflD0VoTVt1MubPiSKlQ79T8Z
	 Q3QYV7SHBLi9TcoU+WBnbyk1KnUrkBoaRGo+8o2QoIQ49NujNJhwRqtA6h9LcMshDsm02
	 TUhI+LNq5O2i69JjQC7JVQCNH3v9BEl2ZBE6r8/TpTfvZtCo2g0yXgfQS6/EXPf9yQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669748;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D3pqen6XtofwE5K6hZVB/4ljEI0gtaGv/M0XzvrbPe4=;
	b=fsDbDmYaozypXg6mph6eB+OWbWpw6ENNJu9yQKQTWjdAzrhoIBHh8lPlKdviMwGNxY3t
	 0u/RP6/iLXCr9dySmZSFMZ/QaBH+LFGVwiQFX1RJYJJrMZJHZ86xMJVeQBb7RYSjRrHtC
	 oqFK8jfp2uH6ODReHY5KlLTehnZ1OO2FpHzoH22NrvAWpKqhaQls3Sax67eO7kJrPl4dH
	 Li9rPis9SMCoYY8MDdCjapb3Teiu7jqLh75vidHypuPOXEB0ItAP3HUqqbb5tlMBLSJVt
	 AeK+Ce4Lh1zCYlgG5bN3yM1rnNPeAeIyEnVnjTFCbaQEOhs8eheIcceCT9pr6Yf8yjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRSMXNLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C811606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRSMXNLL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3621F000C2
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792669748;
	bh=D3pqen6XtofwE5K6hZVB/4ljEI0gtaGv/M0XzvrbPe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QRSMXNLLnqYfwvBj9SRe2RkGdQJc0AEECJGc/6lDCWM37e76OouJ6wmRbHY5XctRS
	 sh7DORNxi7DmMdlrIpcSg8Sn6mdUngCAN3/xwFgIuNC6CvLxgSH/7AkIBPzPUHc5u3
	 ihDE+W69NfqLGL1vOA3a1bHtP2GnHQInQM9KvLINPbau+FdFmIIS2pgIZvL4CZvuTs
	 wERe1WYxSiICjDX6JtXFOWsMLXKSl5GzHF4DMAhl0Pjh74S1wLYprUyhEpph0CVsQN
	 zA/sCIWa98tXlPBUJ9rfdd75yBodUhE0d+7P3/WGJLDrepdSkWjDPHiwZlOLgqN0Jn
	 BWrXiL7XTBK0Q==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c34bff61551so225355366b.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:49:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwAJ0uGDY8JgfhZM/VSmtj6D+ztxmO5tm3JhjIWiCcH8FTl066K5qaQbagxzut50LWcBiSNFac=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSfdAFrHduSNlGlOVYrZ4Y8BokvlPobkhiTrVIeIbn52UpDgau
	UF40BrFItm+MZSFkqtOuufJ/ZGPT63bKafNZCHJ7jVp3oHbWdGboA5gH0O2+/FB6NpxSmyVdglm
	vsromahAJhFXcmyfeBVFv7XkYDY4s/no=
X-Received: by 2002:a17:907:6d12:b0:c31:8984:7fad with SMTP id
 a640c23a62f3a-c4679611ee4mr506777366b.15.1792669746875; Thu, 22 Oct 2026
 04:49:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021115400.30885-1-mike.michalo@gmail.com> <CAO+rqLj5rF8MGMTRSav1n43NqLbazwyuPsPKgiQT2qtP+EDxeQ@mail.gmail.com>
In-Reply-To: <CAO+rqLj5rF8MGMTRSav1n43NqLbazwyuPsPKgiQT2qtP+EDxeQ@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Oct 2026 20:48:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-D=8fK8rT0aCrpPEe7ezQ7Q6qdOiAy_tSp6Yy0z4T8cQ@mail.gmail.com>
X-Gm-Features: AclHuK94t22vzU3h4aqXcwOpvZpOlnnNQW9zL_24PA0tOKWccvisgbBgdOZ6eMg
Message-ID: <CAKYAXd-D=8fK8rT0aCrpPEe7ezQ7Q6qdOiAy_tSp6Yy0z4T8cQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: restore Kerberos logins with released ksmbd-tools
To: mixalhs <mike.michalo@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:14=E2=80=AFPM mixalhs <mike.michalo@gmail.com> w=
rote:
>
> The ksmbd-tools side is up as
> https://github.com/cifsd-team/ksmbd-tools/pull/347
Okay, I will apply this.
Thanks!
>
> Michalis
