Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513456;
	b=v2NPTgGYQInVVMsV8MhoIDRpeSegTICfe3aa7mDLEVLu4pNXsBEqIQuoVhxMcEIknNz8
	 bpCRP/wRNPN/8Fzg1tBdmuGent4S5vfA2d70y20GQ9QCZVixakrxDTXvs0dzdl5fKvkJx
	 4s6VXGdjFyfcrssn2j0k65kTga/XKiWKO0Dm108Z4YOns2xvm0wPGjQmIk79sKO3vg3iq
	 j/qrh/007n7A4YR8z8QqnABSD64Wam+cl9JXybqxbvodg/Wi7WMFQs7ImxFi+GCYelxQ2
	 FjjuIzCc34ajhFvhIG03L/ud+PAviQqw6jxCBxsmsx0A+B8KavqMfOTicQ7J7S5tsVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=nG/lLkqQ0rdJBUmgF+0ZHDQjmdqunn63tZ9hH/Qnp9w=;
	b=cGmjg+Xo3E/19gTgK4wUL92ENh4ybMN3zR/jSUmD8rAE4CBXcqgjJmUnawucoAo867i6
	 sdD790WpxllbakToJ6akbHsuhlMWQHV+9V0lJSyt733O64bSR9oqTg2lzSXA3NfohPAN4
	 03iBIRdfVEpShXopy6GkjpCltmdIDJ4Bc52d9TTkZRJDZTGjAeVgtfeMBwcX3olWVVJSa
	 gSuNpo2cAM/Wu5Cg5r69EYwVYFtNrMjofIwTEdhdG87BASC6eZYfigUTkqO6GABf+B6gu
	 C9H6vaeITgC5mBYLaG5qXLtdX13O62PlfJ1ulc9MFwPPuWmQSdV/dAplWOyXGI/MV0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwtQlMy8;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF6606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AF6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwtQlMy8
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so27982a91.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513455; x=1795118255; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nG/lLkqQ0rdJBUmgF+0ZHDQjmdqunn63tZ9hH/Qnp9w=;
        b=YwtQlMy8tzw38kivYwSxsVaNkC48NjO6zR8HMolDidk13wZwdwL8G/pT8tl/GFrfTG
         u/rerWG2qSjiC3eGgoV7XJBnRYu933lNqf5mqTQE9Z1LonLa1ldVJeEtpCDScXlV/u7T
         a4iklcV9UQfu/chino4vWs/c47DgX3ABVgT/1gCYj95tTh/kF6piFL97/1YEWUHAztky
         FBO9nwTGkihc8nXWTBcneYJBqT4vj3d9kj/uwpci+pshkcSThMNHate41TMitBuvpu6I
         j/eqehGvkpxbrTAiz/a9gbU2f5M6+k3yBvijC31uB3NJi3I4uzcxiNn5J7IMPlJH1KBY
         LjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513455; x=1795118255;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG/lLkqQ0rdJBUmgF+0ZHDQjmdqunn63tZ9hH/Qnp9w=;
        b=QiIUkHumDyE5cDZ2abQ++nIc2dMLlA3o95ysEneMpgnJ88jFJdRc/OIQT56e2DlAo0
         4MCyDD8FA59h3dBSb1yIh4cHr0w20RV8ruOGedNxrJ+4G7tG4+Wc0JlCjksZw1SWJ1Sq
         /BhSG6kcPSESralgNBeCKQ0aww360+9k+V6XIFcb/I8rX+wcX9E+6UaF7IErFm8igscE
         uXtRJWF8/G/qQ5wG+ks49cthUIYtlwqEpXwe8uPTfhUtUiBtZU6RZCFCROBAvu0T2oNY
         QkLvzan95P5O5/EgKwR1WJ6azKCTH4heQhZDwR/w+GQTw2BT4CFZya9HamxU/ljgTs2f
         7Q+w==
X-Forwarded-Encrypted: i=1; AL+hErHqZi50thmH2R64GrzRubIKeeIIrvPaxJ/Ac5WTzuF2KrdAoCO3jeMPEW6hR6P4+tBIwYfg7Wo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hKcip03LJysWYKuSEH/JkZ+8PLvze4l0TNqUY+hoxfSGmZHMK
	uSo2Z6e4GnDavn4Q7jl0kPokht3T4/T4FWzJ9pN00YfMUFzLTnGj0fbg
X-Gm-Gg: AYBFou0oWkONgd562bMZ3gmUdchoN9hr1brTEhS87cSdc9iESHwTKSuVpq5a/hgsVjs
	Gas89CnaZIKXXeJzevYnGQjTIXdqedCC0Y0Isd5WxqTe23tPh6Dza39ZasxTYsE+9aLC8u2E68i
	5iLNjGQ+7P2Knx6CVz0R5iuJY5rkWnrNJjLH95vAkXBgFDkWp7TnllIlzU1UeS7QJtrKmziZFzq
	YEJf9jNQb7RimL5iQ7NBS73xlpd0mHocKo4bSDylyeZXskwvvIp60TwGq1hdHcPnpjsTs4RlNzS
	MEABqoUNDN22/sYhiv7/x8IAQ8KH1DOUjoj66z4WrkNhIlp9KrEOf3BGGlDJauvfRW0h0Itzlu0
	L9FhVhPl8sovmBrkK/pDt8pt/YIImSjZJ1d5F9rAHICpZwqSdEqVWBSmU2dIJ1N9Ui7dDsbLreA
	ibuXnivoAgaem42oZAcvL3APweDomDH4j/GeYmAqn5VcjVtNYKwvbrLhcNfX0Ta5XnO2TQ+G3h5
	pIfS7Ec1+DH7hNt+umoBJ2oYXWh8Wt1qbqjeDSILyHfF8MNzxKoKYdF1dPI1dIyjOneQygI4r4j
	svRV3s73ThHtsuKdWRYV0sYa+o3goawxKoagknSHfx4VnzHE3ku6aOsFFdyejSxtn/sOKNOsYQR
	+bAOtDPxOENQjQfpPNjq1ukt2DoEeBIJM3ok=
X-Received: by 2002:a05:6a21:6b05:b0:3e1:8300:f6d with SMTP id adf61e73a8af0-3f7a8cd3babmr195219637.59.1794513454592;
        Thu, 12 Nov 2026 11:57:34 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d11ac8sm91909b3a.55.2026.11.12.11.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:57:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 19:57:33 +0000
Message-Id: <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tadeusz Struk" <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261112134942.288831-1-shlomojune6@gmail.com>
In-Reply-To: <20261112134942.288831-1-shlomojune6@gmail.com>

On Thu Nov 12, 2026 at 1:49 PM UTC, Shihuang Liu wrote:
> replace_effective_prog() uses the position of a cgroup program list
> entry as a physical index into the effective program array.  When an
> OOM detach falls back to purge_effective_progs(), the detached entry is
> replaced by a dummy but the other entries keep their position, so the
> list position no longer matches the array index.  A later link update
> then writes the new program into the wrong slot, leaving the old
> program pointer in the array.  The array does not hold a reference, so
> the old program can be freed while it is still published.

I doubt you managed to reproduce such scenario.
So wont-fix until there is one.

pw-bot: cr
