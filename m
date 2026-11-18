Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002520;
	b=RuJeiIQjzenA2tmMqezAL581hgn5PylhtlomR6fJf1eXn2kOaFhLN7G4kXLG21Sjx63D
	 a08SdNqBaky5I6wdZnMAvuzx2eeeApMLgMfaLo8i04FLnL1L/p/ED8uoThSOy61FdCtvy
	 wTDm+lay++Fj7hd/Yf1aftzBA+uJaFhp/z+o09IEUUvJFeFeFH+r43ql7tZsc43Nf+iSr
	 jDRcnLbpQNOTjw3jpkOeZ+EnD4mc3tKWxYQam0a3LtnkF3IlIwlAYRvGRJBtInvkcw7G4
	 qY0ZbVi3gljdMzabScNyiOxlmi6T8VSughMzYgjIGGANRtcUbNPfksWzmVMRZ1bMBKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002520;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
	b=aX4THV0rNYZ3MbHrCgF4dIBnPCFfo8YrpBIAXV5uIYbHXCxXb1WHo/pYTUr+C68j6Apx
	 enwnLAbpr2QB575Oika5OWotD6k7LWHZNpM8gXALsdUYkmbCLoj3vDftQjPFr4CQPJ6EP
	 0ppxt0pCQeq/UmBqeu5amjELEtGS8wLdj0qCyYZ4Z57uizJAdIUb79qgbYW1097OQ1eLE
	 YwupA5GNdpHd8u1O1PuxRYcv6voKeVr/9uYnsVndUclfd1a/n6DuXh57MCDjHLylDu8Xs
	 SFVwvXafo9n34+mbbyNtoinTmaMucvWCYuBx2klzqmYR2cI9qHmsH0CbuRM2LhUAF2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOboHHby;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b9U1X+n6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F947606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F947606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOboHHby;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b9U1X+n6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795002519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
	b=MOboHHbyJ35oOb6B0yXPSBMkxuCxSy20/HU0am4Qeil0R+2Ig5K+1ols+UUWrYfiG8E95p
	sXZ4sx3NzLF8hF2ko4Qx0aA/t5Nq+gOtsvcDEaqrGyu/JohB6sbGtBFPOeEFvagtb0sY/S
	7jJxUswbat7pYYz69igmBRctmSS/RCU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ceP7-YTIN3WGPd0JarrGfQ-1; Wed, 18 Nov 2026 06:48:37 -0500
X-MC-Unique: ceP7-YTIN3WGPd0JarrGfQ-1
X-Mimecast-MFC-AGG-ID: ceP7-YTIN3WGPd0JarrGfQ_1795002517
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3a73a82a1so1065211a91.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:48:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795002517; cv=none;
        d=google.com; s=arc-20260327;
        b=IBdYEgrwjPGOCRgVrlR+K/hzSNhy5no3kD59cBoSFFgVBy8daDTy0ZsYRAp5tphXvo
         T5jZm0wLocajrWGuXJ93YsftPYqK6T0S0DdHPRaJvG1xlxtAYFzLNNRjVx7PrNHisluM
         is4AB2ciknVaziBFBYBHEGjFQaDGUYDkwAt/oNVguj9fm8EwYQ10RtB7ydJ/IxL4QTtA
         /4z/dix3MI9BW1JoD8pv9cq2RHYKaE97ZAHXfF2DBdN/Hg5bdmIbrJHDy8GM826PG2FH
         5zW4cCqxT2G1JSekk4hHbQtV+3PXajRKCea97KpczHuxqhBVvzMKaTdb2I7eUdYPXpTN
         jogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
        fh=ISA02YCw49GWEZ2rkqdstMx8TF7pz8L/MtdIeb1QKmk=;
        b=Q+Uz+ThEgcyU6uEHUcRkcV59R0yiosS1zyW7ZCK3nQVCfJq0tO/Y4uZG+8VLlv2gGg
         IDsC89dWjgIIduzZwbPgKbgJAVU8WOBFU7Uns+uzMH7MNsbRzPE9Wk8H+5N6AsK4c1aP
         Qf2FCIRenrjyCIs9if0hO13pSSwfqLlj/52D8gXlkk74NdG3Z3egJMHWCnDJhf+F2xb2
         m5E6mI+1h1/q2/WoKY6a8L/eK/aIKY9XbjuIp3yDRd6CKcY3PtdU7yNjZTciI8u6StgI
         4DjXPwDOK7Ai1PiXPjJRjvWjsTYpZP2d36ZsQCp6Li51mmiaZWZxKXXGXFQ/GbUfvBJF
         SSgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795002517; x=1795607317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
        b=b9U1X+n6xWG0saynKKIBdiOIHp0WnH90B8WrvdS+lyFXat3VTvRo2YcXmsD3V/ekAE
         vyzj6Hh0jgJc199FV51GSp9YzneoiCZjjx+68OdHLwwGEap7jneBVR1dB70W2hJ863R9
         9pIo2ils8+pbbuVjUtaCjKwhqMRbGfAsp8KYRybMsuaPNgUrnypG91qf+sErV2siFrBO
         tXmQYLQhMq6wIIRgVWch90CbBoWRPEE7z5h3HbTDgbi6Sjnudcy/V+1gDbQkxzr/WL+i
         tYIrIeufxppaNObWkDJvJBNrOslE0780EIwSq0RkPMzKZM0/fZJLXn9JRE50bSwScMXr
         2c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002517; x=1795607317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
        b=BwIQ5+rlsYMAdykAjGcXRw4G/8tRhPTktOmWznYF5Qlmo8gM/ehABYccG/chKow28r
         LqvEKhTSz5nJ6bHawS/EYYrHBU9/OC65+9NbrReWEnYXkun4JJ+jC/ADQFMvKH3biA47
         Las7837v5ckDEZwlFvyRnYHCGjXkn7sxmqKay/n60D9nxJC0WgOGfTK790TFkH2bFEhf
         6hCJFvmkvy98JFfBmldobSX5Flx8KmR0aJfMS2Gtx0R84EWgANInsXxctRWMfYEXFVO+
         b8lz9+JTOhN6uZOHd+XMtKEos5MoYaUFyBbJ/j3m2ZoKS9x3QZYQrb5zxjW63WRpRbhw
         z27Q==
X-Forwarded-Encrypted: i=1; AL+hErEZb4CtTg1DZDbiV5IeapHGa3tf4EJ15ISTHvqRpmx+HzqTdVTbkj2qMZrNSuuyITGO1sizF7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HBrGLv0IlkpPxSUqLGETXvC/ICz54Fg+v/MOl4VMw9gJyxtYq
	tJceDNAs+UlkiB3GESJJQdCGcQTKXDvgctwY99KBy1QYWjHxWRqcxu4P740QNvOTCLkW74C5pqQ
	KGwji23XoIsd9+iI1IJy8jsw/c0/NRQxZ4a1DJbpDWh3P+LFJJLbOOu6qD4N7MwuFsYMCYAHTtA
	oO3Kl8GKP+WkpXzxIf1QcN5OONqIo5JnSa
X-Gm-Gg: AZFdTZeSmrYGLkbd/M2+M9NL1l16r4vNugKqCUOV0BgmmwLEnEMY1dJoJnbe4Zl5ju0
	T2cb5R5ER9DFlPhVHBpww+J8uSpUTxIYFb8qRDAo3PmRDBvo938jP0MuFl8d1LL5xrhXduIEeh4
	wjCBAiZCvgzrlPaQX1tDo3hp8ncvzeC9N43ySO8yP7cN0n4TZAAxbjqtTU0hEjemjX9kUgBd8WF
	zjsSDLrJUjN6R733Io9p4zP/YYkZfAu0s5K/aVtHuro5YbBidL6nkV+D8AH
X-Received: by 2002:a17:90b:3b41:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3b3d07e0e94mr2527726a91.57.1795002516692;
        Wed, 18 Nov 2026 03:48:36 -0800 (PST)
X-Received: by 2002:a17:90b:3b41:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3b3d07e0e94mr2527703a91.57.1795002516247; Wed, 18 Nov 2026
 03:48:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118114226.26178-1-naa@amicon.ru> <2026111856-snowboard-unknotted-8b75@gregkh>
In-Reply-To: <2026111856-snowboard-unknotted-8b75@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Nov 2026 12:48:24 +0100
X-Gm-Features: AclHuK_SkztaxopbIwr99Ro1CdCVO091ex6AgTNU_eGvL9UQpODpc2_cWbFfUrs
Message-ID: <CABgObfaQnCtORj=EwjSWNAaoKZ=D7mO7BqgGfCQx_qJit1AKVQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 0/5] KVM: x86: Backport shadow MMU GFN and role fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Artem Novikov <naa@amicon.ru>, stable@vger.kernel.org, kvm@vger.kernel.org, 
	seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, 5.15 has the fixes and it should be old enough.

Paolo

On Wed, Nov 18, 2026 at 12:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Nov 18, 2026 at 02:42:21PM +0300, Artem Novikov wrote:
> > Backport the shadow MMU fixes for CVE-2026-46113 and CVE-2026-53359
> > to linux-5.10.y at 3a323bc22b88 (Linux 5.10.274). A linked child is
> > reusable only when its GFN and complete role match the current walk.
>
> Why are you running KVM on 5.10 which is going end-of-life 12 days?
>
> Please don't.
>

