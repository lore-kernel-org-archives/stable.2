Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087665;
	b=AN1iqh8h/0RBorE3aCWUeg6dObmlQ94PaXSPyTGWtanG+o4LHyTSbHEHQXKKEUH9lC9U
	 n1HYXUDqsOy1jloJML0mV+AfbKu+nFJHBffsHQFrmgdpM+pl4M1Mz3dArBaD2ATV6dXLD
	 JFpoiaTQpnMB5+lb1RtkleR0SDRngw/uU1ABFLD2mInGnnG3O7EJDCy9igPcoQUg0b3NB
	 kqU26kfn3gP4I6nYDPW+7kVChMniAKZJuNNUem66AcNKk1iBbeoW0ZQqbQOSLSoznX2AF
	 F4bJlz83lDwJVy0ig0YA8Tq81r6yTLsYiWFaaXfukH+bcsug1OExB1JWNzC1EyxhbMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087665;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C10/UwY0vgcLZUDt7ami1ayVX3pRMgH9t04Cv6vtLks=;
	b=BBHaDe2FXSxE72U5/hQ/iadVXSV9mgr5LBHXM2NgzP4p/B6t5abp0Zvgwn9llmeplhGS
	 LzvBp/NR3mmliqk6dmbmlfDsKxMWzMP7G2wVHJfYQQkzL9UWuAOJ5n0E6VFEY04rYstG4
	 iIq9pusg/E5m3k6knxDyRFVr5zD5+OY+DYa/Bny04MDCg1mVlp4VNBvWbSBgol+2g8c12
	 SwzHz3ASHQ+a3UqxdKeuzG73cn6TCW6cqrLmOFa4qNCmvv8wyejrUh1vSYsBj98WZ2vsK
	 A/UJpjHooOHLd/xXOzcjJdqxpiNPExQpcsq6/ww7As+bKj/2S5BJujX+Ggss4k98qAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lruVJiHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A1606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lruVJiHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9691F000C4
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087664;
	bh=C10/UwY0vgcLZUDt7ami1ayVX3pRMgH9t04Cv6vtLks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lruVJiHg73pqTOwyz8gqmX3D1HROGYBqLpjhYFcSkRpKTEzXFRMHFFhEfK/XR3K9x
	 /9+iW+N3LMq1NFcGojQb19LyQXUIlgdDpvwbzDW8gDN/nTcOHe2IyFJkCGA6wE99aH
	 xWn9LF77gMU1rj42itXkMHjOoQsvk9qZAmuK5TeMCsJOiN7G18HPJuX0K015bt3LGo
	 4Nf5D9TVWjc8dR6BHUf5EJ1Y7AaOmO9KWBEQXy5YNBSYb4gyPI4sAkVxxnH1Lu/Y8p
	 LXNf6xR/wctV/SPhxg9BSLDmCRthuYJI1OqPLg1YR6FpcG6B027ylyQzCi/5AakyWy
	 HFhpOnU6xMLaA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c5124dc427dso140021866b.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:27:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGXYrC8nQNGT25YBfU92RHuawdV4CVgMeK2Qu2dlWGckphhEiKZcArQ7qQOt4TVMTZP72Tsx4M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GMBKe5dtUl86hcorZyKh1QqiEJyt6lSbeQocljdT3BCsFdT7/
	uaiCVFKtUttN0Ay8hv09Ha/8rZtj5uuoVeQg6og2igjQWM5aA1uoNs0Qyk6AY4dnJxGclR8zfaQ
	yc8O96hVje3vw+COiXVBDYL39mzrUJCY=
X-Received: by 2002:a17:906:7946:b0:c50:d92b:6f40 with SMTP id
 a640c23a62f3a-c510e2d5928mr493622866b.20.1795087663605; Thu, 19 Nov 2026
 03:27:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119065652.116074-1-icb@fastmail.org>
In-Reply-To: <20261119065652.116074-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Nov 2026 20:27:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-WY1s-4rk37QZ1TKchby_+n1LD44tPiEVWPPQsVh-TUQ@mail.gmail.com>
X-Gm-Features: AclHuK8gH4_BlZQVcilNEIdLYT7RBGGX5b1cm_i5R1sumAtwAaGEqiEf_qqO1PY
Message-ID: <CAKYAXd-WY1s-4rk37QZ1TKchby_+n1LD44tPiEVWPPQsVh-TUQ@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: omit the DACL flags when the query omits the DACL
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 3:57=E2=80=AFPM Ian Bridges <icb@fastmail.org> wrot=
e:
>
> A client can query a file's owner or group without requesting its
> DACL. ksmbd leaves the DACL out of that reply but copies the control
> flags from the stored security descriptor.
>
> The reply then has DACL_PRESENT set with a zero DACL offset. That
> combination describes a NULL DACL, rather than saying that the client
> did not request DACL information. The reply can also claim that the
> omitted DACL is protected or auto-inherited. These flags are wrong only
> in the reply. The server still enforces the file's stored DACL.
>
> When the query omits the DACL, clear DACL_PRESENT,
> DACL_AUTO_INHERITED and DACL_PROTECTED from the copied flags. Preserve
> the other control bits, including those describing the owner or group.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
