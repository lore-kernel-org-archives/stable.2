Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347647;
	b=Lc871d+dT5bizvF9wVShtAL3cVit5vRZH4XmUM/FBNU/XU5KsiU/qVod5bIgH4w1y5fP
	 PjHSlhJ/9jSrNFxh9lixgnzsfCfLIAuaME3eFd2BoiASLxAFWIUiPTayptWMBcXjcIjX3
	 /R5s2F1vKkQ6gMlDlq/leZPoyoTb+wMtWCGCuhI4nsyUgTazlCoBQhxkDvJamEtRQNl2+
	 fQQDG0GmubPkUHJLsguH/gOE3imtyw/yrF8rhDn0Qq6RvZdbo+81XSpbx71pvKXkcfWrl
	 I0oTNwRMDJKAKj0LWuCNM31zkc29ftDTW3DdQXz3FmEW3jKa7crzDNyXqmE3/ozpToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347647;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vx1nbI8H5SPVIs7K1QTdSx40kl0+EAzRn/9rTMIQZ3o=;
	b=VfSxIk383GB4wJKjVvF7AV74cmkJ1HyAMTSYHIrFpBowaFLxGvQhTkG5I3oqbktLKSi+
	 f7ctYimzyftt03C2nQU6At5ZKChpl7r4ijcCdL+sIbXkAm8cx3UZd12mzIP9Y74Jl3OuA
	 Zujj/LkBT9BFocX6v1feaefcsSG0JR4LR0uXG/Gqkm9WD74pCnyN/KRLfl7dh1rwktoNT
	 rnOBJY6363m9QHXQmujGqcfmLZQpvcXlXz2FKFbHMAlxNk0fQKOWXyy2qGAyneLLxDBuV
	 sleEV1jq3eHLJTSYZpNDETvop7tpE1w8Izv+b3Wwa4Ntw71yzknZS86MXgjw6u8uWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Ou2MxfjY;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693A606A31C;
	Tue, 10 Nov 2026 21:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D693A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Ou2MxfjY
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68CD740E021B;
	Tue, 10 Nov 2026 21:54:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id czhD7jfCKnPg; Tue, 10 Nov 2026 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794347641; bh=vx1nbI8H5SPVIs7K1QTdSx40kl0+EAzRn/9rTMIQZ3o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ou2MxfjYszDDOusFqyzE2NCwV2TIw0REH1b6qaYengEmZgqcgPNWoWfFH7zoanOT/
	 YUnJjOuYkEX1DWVwsj1sd4dvUntoVdVIiebg+1jiS2GDqMb8n0dw1SyEzoM6gE8Rr6
	 OuZ/GhgJks9kUF5X0AlIvZw83p29yR0DSyCBW7L9II1kebOFADENldwh0VPCDmd0Q8
	 OJRM/ftgOdu6BiBSonKF654i3pMfANFIsBhpBYTF5XFZjwnZFyEkQW0Uwwmfi+Hxj8
	 7ov4RY2OaEQHUKx+VhJFbSu/A7jr8geceLx5/zH8p9stIjc7UXjb468OzU1pth33Aq
	 WoVoETOr1xCCEt1WmDTIE22EZX/JGmfKyh0oMAX1sn4C0zjE6R8vLszZtAEnl18BhR
	 JNz0vpaI/w+8ass26npR8dhbSjuws4oHjKVyxtn1GjkqI3vTy47SAukQlHq2es5DtV
	 RANFO3QtttLajggJo3IzzerHM2LOyV9qUBkqc3qE1CLHNv+ddkQvd8nAm+Lhzn34Du
	 Ne6Fql5NOu9a0WvmXCjiCMVQk14nJcj0iWrqgM3bNvArnsMp39ohDEoY7hqzHLMzOb
	 zsWNRF5RUOh5aK+yJZ3sPz9blFOqdpI8GHfVqflfx8g/85aobJPjh7B3iPyc9q3DC7
	 WqIrVx2tx/t/3VZlOLxV6RcY=
Received: from ehlo.thunderbird.net (mobile-166-137-178-020.mycingular.net [166.137.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E09540E0219;
	Tue, 10 Nov 2026 21:53:28 +0000 (UTC)
Date: Tue, 10 Nov 2026 21:53:21 +0000
From: Borislav Petkov <bp@alien8.de>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?ISO-8859-1?Q?Onur_=D6zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 stable@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/rust=3A_use_=60-Zindirect-?=
 =?US-ASCII?Q?branch-cs-prefix=60_for_RETPOLINE_builds?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CANiq72npfiOC2ZCan-zAe-h79kba_5jtWFAeAoigCs_hnO8gJA@mail.gmail.com>
References: <20261018175457.87803-1-ojeda@kernel.org> <CANiq72npfiOC2ZCan-zAe-h79kba_5jtWFAeAoigCs_hnO8gJA@mail.gmail.com>
Message-ID: <E91BAC6B-9F08-4801-8866-2BB0ECAAB349@alien8.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 10, 2026 8:31:08 PM UTC, Miguel Ojeda <miguel=2Eojeda=2Esandoni=
s@gmail=2Ecom> wrote:
>On Sun, Oct 18, 2026 at 7:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel=2Eorg>=
 wrote:
>>
>> The C compiler is asked to add a `cs` prefix to the `call` and `jmp`
>> instructions that go through the indirect thunks for the `r8`-`r15`
>> registers, which makes them 6 bytes long instead of 5=2E That gives
>> `patch_retpoline()` enough room to inline them, e=2Eg=2E as `lfence; ca=
ll
>> *%r11` for `spectre_v2=3Dretpoline,lfence`=2E
>>
>> However, Rust code does not get the prefix, e=2Eg=2E for a
>> `CONFIG_MITIGATION_RETPOLINE=3Dy` build:
>
>Any comments on this?
>
>If it helps, then I am happy to take it via one of the Rust trees with
>an Acked-by from x86=2E
>
>Thanks!
>
>Cheers,
>Miguel

LGTM=2E

Acked-by: Borislav Petkov <bp@alien8=2Ede>
--=20
Small device=2E Typos and formatting crap
