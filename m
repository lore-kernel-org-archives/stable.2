Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A030D3F8
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269420; cv=pass; b=HhAluK2W23U6CSN3lJuW7t/6cxtgKoZHtVNO22dakV8fYvhgb5+Z3iPKhdeZJ0IipbQiyr5WPqV1z2U8CBhMez5LyaLKnZgLOR9QYZiDQvY2s8LYEsCtS0TnCkTK52HAiYiA7dka8aNvv49TWaXgkygWnoy7/WqTM0MygRsE9kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269420; c=relaxed/simple;
	bh=XJC8mnwuYM0KLaAKHJuhy0GpuAFopbEkJ/aam2wcfBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JndzP0A7JsrtpwETYoXCr7Hh7HeyWcrO2s6wj2xbnPdeiGWLTiVBo90Y3iEosoCndmS+8qnOpaoF0mTj55p+IcEuhQYf7lhb9iNoRhL/5lvNM0jKVoGxNU+5iLfbIe/dkkOlAF1JGXkYxRMXKS012R6lEmkMqVQTCoekBBDaqkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaeMH66A; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaeMH66A"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e8c710847so19994266b.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 23:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791269417; cv=none;
        d=google.com; s=arc-20260327;
        b=c9aGlLBrYRZgLGxEaaIZGTdR/2HKUYS75RGjB6o4J1vavf9+gT5dvjfaVNBOSy6kPu
         LtHLUPo04AsUW+ymckEiNA94jciPYJf4D9aKZODVvMsDHiuTAIpkvDGNVzZUTU+3+z+s
         x1ESA+0RbhdeU47qzDXJvyZdG2A8YNy5G+TVlf45NLzaAahsNXZCUjWRoZuGLYqKCTUK
         UfctnLsvrZowN/K2OxBuvY6AloDiyT8ST744bNATrEqSeK4ZUctP2kQbeFm2St04QXlC
         EEB7a+ss72jjGIROqlcL643Qz7BQu8JAzKEM13Zj+oQuVw9h+TpB0M+lfFzrAU0TWPft
         S7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tqsYm2RdTA8FFgoOM+5IDbbKZf3ev28pnZIlHkY/9I4=;
        fh=hStZks7tocrRlW6i976dIC6EqGVbBAtAvD0CnUFntR0=;
        b=RzNuPv7cgXS7QtKHlfxWmtU0PPvfY0QBqHESKK0QJZY68rlGxU9T+ei03oirQTaIiN
         jNqhTiZQ8aWN9GBytFWAA2m0OefCvviCZLxwr7o0TPdJUW6T2XcqQNgTX5tV2znuHwaw
         DUPgrS5pbaB4y95A6YUMMDgliwieWXLuFEazRoYm7kf9n/7YoBYgkPbc8HRFdlRoNmEF
         7qUru+cFmCI2V/GhJw603w7pOQjV1+xoHi5snLDNgZ5UZjF50ykhLznU1PtyzEnhM4ci
         V5257yqnQ7V6Cs8Sp7U5OroStHzacVH4ueXSOjtUhtXjELuiUk2KwYgyny4fKyk6Kjtt
         gz2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269417; x=1791874217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqsYm2RdTA8FFgoOM+5IDbbKZf3ev28pnZIlHkY/9I4=;
        b=KaeMH66AKwELWekBwEaCGSlQ2kIB2ySGAKVHaKUlw8wq319DLYUhxnVd7bKMEndGcu
         KYD2h1CxkmlO/YBkK72LkGFxWlt6hhzd+DXpHnjl6SpkuaGeuVgxa1SPU0A9RbTmwFBO
         nIxsGRANI+5cYbptMSI5DuCiNmd8hEWSZcRD9OzcP083O/Mkn4kvWBPMFhX3NeHQNs1I
         ekxkbH/s0x0cCsW55QvS6cH2ugsApTZo4eSI2DieRA2dP8hU65D9XiKUNKDLlCtbsHSb
         doSu4xVmOB3nTmONrhzmKMN1xpspH8/CQ5eJbDEtoPsKLZki6OPIfBZDs83JdS/6ZJu+
         2rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269417; x=1791874217;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tqsYm2RdTA8FFgoOM+5IDbbKZf3ev28pnZIlHkY/9I4=;
        b=MPZVy6W+6IVqroFF88R+vsYUIfGnniOhecsLEipgXF1lFbXh8dHMVP5KNr9kA8yAer
         HH01i4EUohFNpJe2B8OmZLqYRtOuBU252P9tI3bLd1zkZFljXiu9MDLVcfhHVkWUTIVa
         RJt/Dxfy2znIBnqBC00l3h0pzEUCjWf2+JFEZ0z4V1avZl3dqnqmFed7GqOf2qfKBSo6
         b/3lZjSF30pvkRsfS6Gkm1MCpA6JXhMZVEpHLLiq5YVhMy8y/ltNTvM/BZC/9Utvl9BN
         4J9REj06tkpCo/Z6zRXJHgccptE5ZWrTADgGbEXFWuLhbOyJRTXnQcQTAkm/eh3N/s8Y
         If4A==
X-Forwarded-Encrypted: i=1; AKwUvBw7bEIJpMBMlr4249KsJFy/r+QafJvWqNZ0NM6xZVuoF+MNzvOccxWgJbi98xJmZ6Zc5J1t0i4=@vger.kernel.org
X-Gm-Message-State: AFuF++miCUyJ2BOxUj8X+diSvyaW0hmO85Qq/hAKPpkTzwhrKQFQXOu8
	94EO8XgJ/rkrFcIt+pmuVf6AdZUQO44kzMRh9/tzRczjmI/91mKnIoOAtBIkfyZlpq5ILwpHmlG
	jc9gQ/Wm1+bwPVN91kK67LK8/pVAsNYY=
X-Gm-Gg: AYBFou2OJf4MbUudjdRaXICYqSKdLTU4ui9ERfl+qxDELO9aqAkYaXcTiY/5i8cfa/K
	t2bxZpXDRCDWzH6MEX6zkICmzsBte1CXyFeKRV6C2rCrtYAdP6KptPqGxcX2Axm6D8dXnArXKFD
	T53S2CDaTFRz+KJjENQKdcsCzxnJxqSRaqF3Nib/LIcItB6FNAA3/VU3t1LBjQt8GCIIm7pPKMz
	xkl6dGgyLBoNq7GTsl8PXevwkmc0GLzVm2PGZ4TNgKBPCtnk8CrH274PZU9V+RSmPT2H5kn9kGi
	r3X1uNhAhi74aKO+Jg8MKmrntDnfYer/3ir7Rruqwv7nSt4w9cQsrBAY
X-Received: by 2002:a17:907:868b:b0:c2d:ca8d:435a with SMTP id
 a640c23a62f3a-c316a03a07cmr48107466b.38.1791269417167; Mon, 05 Oct 2026
 23:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subham Pal <subhampal789@gmail.com>
Date: Tue, 6 Oct 2026 12:20:05 +0530
X-Gm-Features: AclHuK80foSKJUG9aXGi4lMnHGQEDESfSk-FDQU10Eg1rsE8o1J9c3o2lczDRbc
Message-ID: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
Subject: [PATCH nf-next v2 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Subham Pal <subhampal789@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This series resolves two separate issues in the Netfilter H.323 helper:

1. Overly restrictive tuple comparisons across expectation helpers
   (expect_h245, expect_rtp_rtcp, expect_t120, expect_callforwarding)
   that bypass NAT payload mangling under DNAT, hairpin routing, and
   reverse/reply traffic directions.
2. An ASN.1 PER decoding bug in decode_seq() where absent extension fields
   are processed before verifying their presence in the extension bitmap,
   leading to packet bitstream desynchronization or premature aborts.

v1 -> v2:
  - Retargeted series from net/nf to nf-next per maintainer feedback.
  - No functional changes to the code.

Subham Pal (2):
  netfilter: nf_conntrack_h323: do not bypass NAT helpers when tuple
    source matches reply destination
  netfilter: nf_conntrack_h323: check extension bitmap before decoding
    components

 net/netfilter/nf_conntrack_h323_asn1.c |  6 +++---
 net/netfilter/nf_conntrack_h323_main.c | 24 ++++++------------------
 2 files changed, 9 insertions(+), 21 deletions(-)
