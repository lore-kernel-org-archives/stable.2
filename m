Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B03BE174
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137237; cv=pass; b=PfeA8irM3hIh8JPel4Vr8bQIQFxlT9Iyc2O7b39X4zkCS7Tf9MvRKOgzfXg5MR8b2koy56nvETA8j6/XmpM5gjkH5TICan/IX37kh/e1Xm4iMcM0vsaWQlscLs3IxGM/z5JQwDja3XSmWzeGSidioU3sOV3p3NYho9eWvgHAmzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137237; c=relaxed/simple;
	bh=Cwfh6nfa/UOLSAK3QY/khC+MQR1CKVHT9WrzBxS+zXE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XeITAvwnN8mMTiiVWiLzaRKUcjVd7hFqvbfWNHEnGEs5OcldIdz+8p042cwYH2b2xh3PJ05PjKQzV3k2+U8m3A0o7uXfVR75cKmCcdchvmTqob3okV0gMc4h1OFORzE6dWNzMg+gg4E+7CIXafvPSmNY6fsNsil6TCmynlXksHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjecdJLG; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjecdJLG"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so704021a12.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790137234; cv=none;
        d=google.com; s=arc-20260327;
        b=eP2/ZEe3zmLXE7naGfuJNwVVwk+Ojn1nl4prLIwNeLjC66BiCzdO4vZbgKq1PKC/ro
         9DuJwyW2AZkUtdmKNnYOxiPlU8KYnY8dy9RUZt+IC1aBnZZQrDtdSmq9rvbN0OYFUd9u
         8DEAMi0A4ZKnwxwV0Za0Kp0QQVKdjuOck46l47/JCRyqCX9abwpORGKsCe4YRnSphNwh
         e8wNEHUXUB0INqn8XLXNLi5rcWb1forCRnixr+BNfHLT8dP3xgaV64KRSGKaifXUeqW+
         DZLE6k/51EbUmLEDdT/ni03DcLQtdAc4iOKigGxEcb++IuZHk0S3X4I5wQcg07e4rRgq
         rJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hxbmvmkdJ5bEpGwujnz7ixCTU04WOXkGt5rmGXxVVrk=;
        fh=ogRDVhc6joa8LZWlu4eoKiGS+DTBCsVwVGDlOc4myCA=;
        b=HfpiaE3bBRECoiXUwSdsJ1UM53fNzo/Awu5ZkMf5r2uc7SHGQyeyFPDREqfnyoLnew
         LdjiCCRFO+MJVyKQCkRu/LVghfx9RiYpUjJouIWUOlOmREYBfQaIGmlvwBoTAfHXMuUR
         bHasnHyIA51UHzMpe9/6f92Sa0qO2rMi5O7biTV77lZBvXgk6Q72kk6XwO8Cd82bdblE
         CJSEmbhNrJl6MNequac9yYx3ey/B3LSyJLgHJDziPf7xaeyMCxqCpqV6Ul6GWW7u9gLn
         /VDC9ulUslvGLYae6/O5dzhC45vvJWVXxoZYzaiARdFd4eopvGB4u/rLOceyGTkEfBXN
         Aqsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790137234; x=1790742034; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hxbmvmkdJ5bEpGwujnz7ixCTU04WOXkGt5rmGXxVVrk=;
        b=OjecdJLGniwn5ixF3L7m25rBu/x3lyzCN1jN7BNAas8lsSMvHxhhtk7vaeqIZsdibw
         yLyz2Lty3JGbGBCtgEW8Mkq91YrIrEw5+TzzKgixyUccV5cR70ds2HPgssnMc8Vh5F3G
         ltH0zR2n3iisQCLbJ5fxIC5TILhIbGokglBakR0Zzd4vH6A9Yc4xYPIJCdP5xv1ju/pC
         2Qq4S6Zv7FPXRJaSnS91b5tTGoUUWHeuSLhZkI70iXkoQYbaNfK5lAi/4nd74bSjWuoe
         HLMkXWVDbwginrskGF5mfAFcDTPlLhl1Eh2dfg+7fh+zjwPlqWpK7nkyv9uLHr5wbTCV
         9dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137234; x=1790742034;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hxbmvmkdJ5bEpGwujnz7ixCTU04WOXkGt5rmGXxVVrk=;
        b=kncVyBgboHq7d3exLhe5L+U6D2JJn5P16omAycUxAs5kKlNM1UJeWKwiOFACOra7vA
         68tq16uw342iAxG4ZTl0h7aYXjmgPFjAnKNTfsO/51OVAVwj1ftIevQp27wQXJ2rnnr9
         svLTciQuApB3Gl2Haq4qtiKJ66b2CJcushy+hznokasuGm4CibeNi4iTthQQMTQ4n1Dm
         I3lu9ZYmkywd4DnckD/OG9AfP1JUZgAG4e0Cu02k/7FFNHhScu6zxDHGKtTWldYzoWzm
         Wik+IO747my0jH36GZDSR/mzU4aaXPDwFo02R5Empkapmgp9ZMBSbGHNk6wO9fsuPYvj
         BRXg==
X-Forwarded-Encrypted: i=1; AKwUvByWLDxqRqaSznCGXSO8H30paL/tdfjxAohEi56aLhRtqYQBva51Hb65/X0XO0rB7S3QbiIPZag=@vger.kernel.org
X-Gm-Message-State: AFuF++nOWSBhS/LGJGvBguiukRzYGk2uwnIzui9KW8WK9iaB9TYIDB+l
	eJ2g+DwUS1uVhyzJrhqSKQdF7x7w/We/OD28riDZfTOvdRJMd0nIW3Q+bD4JiJ2zAEmWz4kmXIU
	u6UnLPDqo6z/RJFWQGwVRzFDL6XbsOkuItLuOfqc=
X-Gm-Gg: AYBFou2ic4sgiuhrODXODURwGvSONmzXUnT2/967HxjD7Aa8HkMZpZZH1gSy8AMRt8x
	lRvHg3mC9OlpU1HCixrtY8OJPDl7PUIT32y6FCCEghcOKulzZBcLdi1CCplshe9Y/Iub6PiAEbm
	piBnzdnHkQ+orqGObLcFCh83Dr7Fp7IJICPDXi2tmM5f9sbjw0eOWZ26X685C+qEZZJGEZFtIUE
	YgyNpxNhq1/0ZeK2lHQE2DWCm7Lcks4MfK/N2jTsZHIfCozh5i9izTQxrXtGDbamNhVz3CyuNoI
	Np3xBno0ViVWYi8CKL+AaKzLGFsrpijIckbh+WpdowhNfCK7yw0SB2sf
X-Received: by 2002:a05:6402:3222:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6aab3af7ef2mr1139431a12.1.1790137233714; Tue, 22 Sep 2026
 21:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subham Pal <subhampal789@gmail.com>
Date: Wed, 23 Sep 2026 09:50:22 +0530
X-Gm-Features: AcwNN1WXi-EB5cWWmSS8F_wi0QtWAsORHAgh7vtdg2rXyF8E9Vr6ZcKlLvthKgQ
Message-ID: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
Subject: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT bypass
 and ASN.1 decode
To: pablo@netfilter.org, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series resolves two separate issues in the Netfilter H.323 helper:

1. Overly restrictive tuple comparisons across expectation helpers
   (expect_h245, expect_rtp_rtcp, expect_t120, expect_callforwarding)
   that bypass NAT payload mangling under DNAT, hairpin routing, and
   reverse/reply traffic directions.
2. An ASN.1 PER decoding bug in decode_seq() where absent extension fields
   are processed before verifying their presence in the extension bitmap,
   leading to packet bitstream desynchronization or premature aborts.

Subham Pal (2):
  netfilter: nf_conntrack_h323: do not bypass NAT helpers when tuple
    source matches reply destination
  netfilter: nf_conntrack_h323: check extension bitmap before decoding
    components

 net/netfilter/nf_conntrack_h323_asn1.c |  6 +++---
 net/netfilter/nf_conntrack_h323_main.c | 24 ++++++------------------
 2 files changed, 9 insertions(+), 21 deletions(-)
