Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322649;
	b=mYx4pYypbbkhyibUCO93Yco5xxn6Ey7alsb0bfvgwyJVQFme0epUKSEBZwHejQfj/9Cq
	 Vw3A0usGaSiLsP2FNOQ7L36+r4e360E4+2IEf+vEzSEd1Xk0vhvv0dSLAOO+c2ALUe2KR
	 f2L3ISSbOiprB0SSnmn3FZjEQni25aEBeas0JTuQrNFCf2q6VcLL60cK61XgtfgZuaGhi
	 2t4X5LXCkE/Qi1Ht+wMRpN2IjF1NWJ3aVs4qAznCefVaKjO+LBIAeaLYIQsbiVxXr3qdw
	 NcO6VmkTW9QXiDtk9N6SEgip5dfT6hzAOBlWG3erqLgxOqEqVJlmhQkzFtTNzUBpZlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322649;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oh4yG9NOUAfpCtnzTEnP89jyoSqnXOuZC9TM1PcPNdg=;
	b=xp2HDczt6AiGZaH8I30t07fyCyAcIfwuCAOHvVBg1MSG+qbSj0QZO2ZL2dQfVHk7Sq2G
	 7WFz5JgOeGgmglQYlZTsYIpDJmU6mtUBWC/3gVRSfe8123atblTKHhJf3OrG+m0JMqJnP
	 Ii3/3Yq+0E0Y3v3I53HXJJmYDvUlRkNVDGgWJolmlGR0YFVj/cBllp8BdIH8gJhGu/BNj
	 njVc2uelzsqKPmi6gUdnC9Y40OaI55uuKal2PbPheh5UFtQmxKv7jpyqLOafs4KQQ/zoe
	 gIR8X+tywU54roCrqFmDjKSdMNt6mCOn6s7XajYEZ8/zA1J92VNcStO4J1+w3Vql89A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhk0ABiv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhk0ABiv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACF1F008A2
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322648;
	bh=oh4yG9NOUAfpCtnzTEnP89jyoSqnXOuZC9TM1PcPNdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lhk0ABivNnU3S88s1ukwtFAklNxvgs9TICfGSJEmgriy2JBWGxvwGSL0tfZlA3+5S
	 xzFIHN9J9KNwRJeLxRpgTfo2uw5PVfJGPGDHwX7k+pe8Z3t4bAHJ4MY/QIg/xUNMXT
	 +S4ARy7RhXxCnlzcYLLautoMbFFoS4udN2EzKmgnUjQUIZP9WjWzxsRy9IPkTBzp0k
	 QivVyLdoULNB2z9q/b0ZO0/CVsb9z5BArdcYHmoJGEMJfPOO5LiRZ7WYWTdT1vDnsY
	 gwDBKYzp3BgxvuW7KRrSWw7P2uH55onQBqjtFMlKXgfePrJk5pL7fe8XPrYWnYdlH4
	 fBKsxPPEQkbNg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso2328368a12.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:57:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEgDFbD3Sw6Vj/hPMsNcB12zLSpaWklAwDI4x+5qCLxc5Xv3oxA31ScswY9+onBpz/PGr00VmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E9nUOR0eX2kvEyjlGDBgW32ObBr7TLLOY4SLTkDXaxHpB8AX/
	aGNpZI/QZhAI9xDXQ60+htcLzZZegZGzmbdcwb9+XSKrrBBqGVztGFmEA53eTYjlgTOwh8mWrLS
	kJBAGelz7z1fXPcxcBy+vkCoPakKoZkI=
X-Received: by 2002:aa7:d58c:0:b0:6b3:c422:9257 with SMTP id
 4fb4d7f45d1cf-6b756ae1e9fmr1840057a12.25.1794322647248; Tue, 10 Nov 2026
 06:57:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110023344.2105916-1-icb@fastmail.org>
In-Reply-To: <20261110023344.2105916-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Nov 2026 23:57:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_cmLv7bM6ZQJNS=CU9MHGPJkZjBD4RNTnaSGS_1oz1=w@mail.gmail.com>
X-Gm-Features: AclHuK8yUXWZTkmnwrOZJOIyVL-xjDKwS1ouvX_skQFgof_Rc-YmlA5vKTXAMwQ
Message-ID: <CAKYAXd_cmLv7bM6ZQJNS=CU9MHGPJkZjBD4RNTnaSGS_1oz1=w@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: keep group denials when a POSIX ACL entry decides access
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:33=E2=80=AFAM Ian Bridges <icb@fastmail.org> wro=
te:
>
> When no ACE names the caller, Everyone or Authenticated Users,
> smb_check_perm_dacl() lets a POSIX ACL entry for the caller decide
> access. The entry's rights replace the result of the DACL walk. Deny
> ACEs for the caller's groups, and OWNER RIGHTS for the owner, are then
> lost.
>
> For example, a deny of FILE_WRITE_DATA for one of the caller's groups
> should refuse writes. A POSIX ACL entry that gives the caller write
> access still lets the caller write.
>
> Remove the requested rights that those ACEs deny from the entry's
> rights. The DACL walk already records them in grp_denied.
>
> Fixes: 42ac1f1917ae ("ksmbd: grant a caller what its groups and OWNER RIG=
HTS ACEs allow")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261102200353.884509-1-icb%40fastma=
il.org
> Link: https://sashiko.dev/#/patchset/20261103150458.11591-1-icb%40fastmai=
l.org
> Link: https://sashiko.dev/#/patchset/20261107062233.1579198-1-icb%40fastm=
ail.org?part=3D1
> Link: https://sashiko.dev/#/patchset/20261107231941.1824289-1-icb%40fastm=
ail.org?part=3D1
> Link: https://sashiko.dev/#/patchset/20261108182011.1888520-1-icb%40fastm=
ail.org?part=3D1
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Bridges <icb@fastmail.org>
Applied it to #ksmbd-for-next.
Thanks!
