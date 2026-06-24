Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B820389E05
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284395; cv=pass; b=XJAi0jAv87dMcadc1GrKPwyHmDWV5cDPhchR0p+f0DWvhPf/gF4nkhL+TI+Z5MCSNqKHvMNgsYHUfTvpRLfGluPwvr7iX8Z98p9neMCybTmQiApG0SoFEaSJWp5QepRMvx5m6lPcyyNjnt7nqIr4233hQSDorfj+2LCmaxAtfgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284395; c=relaxed/simple;
	bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dtjvymgxE0tyJY3ox3MXfuqTU323XaPAb6csSvNJoa6fq/oKkF+inFqIKPoG/7xh+exNDZsHEDL0yL6ahfesnv1Xpokv5TwBRBH6u67NqjQKGf627mWDRwCI3CccP8MWg37VoFRu5ZjedLFNPtA1TKPTRuqKY6hcsbI+/fVS/Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWkzwMjf; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWkzwMjf"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697df404e32so1100604a12.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 23:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284392; cv=none;
        d=google.com; s=arc-20240605;
        b=Ykwn1u2x84wQkJ/2UHKmCWi+p51x91q5A5Pb4JCuDB89HBDldbbn0wtwqHh47q6yys
         yDcaIODzZYHvB/wk1UU6+VQU24N3lKgtzkQFrCw1MTzo+re2nzMUgjOEMcl6kEhKg89o
         aBXYOwGmVga+rjVAFUvUsXfIK78/6SORwSPq7TOjw/mzYzkPHUmXfZEauWNtV8lOkbH5
         aIvuVxphmj2dP5RSZ0eNLAnmkC1IknikbiVfNU/jH7snNsOyQZSJYazPNu/kaSPMxqRb
         PkCTZlkilt7egYlZe4gSF3F2Q+2D5XMSEAlZAK5flvGKxce3Juc5sCtLFvVrvw3u1KRK
         GKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        fh=V5C2UCEqKMRT/N/5IMFcPwLD9KwfxtxJ9iZ04+pscCc=;
        b=b3Q0jINjtWEzFJL9GmonnB/lbAtnmp9pAJfTXSQKfYNQ7M48kcSuYQv/dp3Cw697xX
         Y0ZNP1GOXiNNGDqZ3tG97axa9Tr4mKWId/hTETFhZ0TIwQ1xpBheul3Rb7zYxYIU/gqH
         xDpBs/1PdD5j3uf8A7K+7IEWW2epO96koqcqAldoSHbxb9pGKt5bB0FkCvMgFVVuzRWe
         SUYAhz6T5jl2UQj6+VPz9e9nfp0Y1sOayvwe2ya8I1GrRC4KPkUg9BCFMjUzfo35mk2e
         Mym+cMxvs+eVdWoINI4D9c9lemwI0DTQFf0m8YBNU9GH1wJGTCJTtlgQvX2FbQ+nbOkw
         EYtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284392; x=1782889192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        b=RWkzwMjfSbspuGMitpVnC20hjUGIfGntEprkZdgd3gHDn7maXw5PsQ1Ipd4GBmTZaQ
         /pFbvKA7j6KDUm69QpvhQUgw5ldVOrifq4dZu4/F9+DFo+DbFW8ido/7Wu6pEOVvyOqP
         QdZ2ehXh4sJmNq8uLNTvOEvhHtqhFjU7dGYKQcrlvskthhX+SaoLtrXJpK8MOO2LTIHX
         7RVV8I4pG3e7Orm6h8SlU+CW0o6GdqHDt73boWVk1Thrr5Nt2Dd/gevyqIGj3Z+dYLak
         Mo/7l0QXamYBuwWEU4UKuQqX9EIQijapP/XVr5p0jGcjwl2FQEgOV1uZC2j3SkXjoiR5
         k57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284392; x=1782889192;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        b=XAZha2pP1JunZ0n3Sr8sko/WQxGWZIOX+VaOIEDu9G3UmfJhqQSXe0gVy39ZxktKZF
         nXE6LqpM7Ge0o8DsA1jfEt+ZfOCc89tMWAYuX8HISlAxU1bOHhari96/qtDw0Ok/fGFa
         +SEemk17X15Ehh93HlASdbpZYxhL2dyVRujNhDtuK2UWSmEHksaHqZ5Zus11i3YmDm8T
         056wrDQwk0fmVo8ms1pTik8ZW/lDmpF9bFtVAHH5oc+IUZj2OyKrTYqKcSiqDlOQ22Zz
         NgJ1ZcOOktYV8/vel78dLHRc4vscTppA6AuCFzs5WKubYXSdKDH1bK2mw2b+XIW9FkIL
         KZ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/cWZAi4dMDCzt7N5YkBvQJMdmkO3YUMXFbKFGwIVOAYZwwguAuCoaim0SCbVnL8Oh9DuJ6F+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2OlditTcSd7wQxp47rXhStoCAjlgmMqOOc6Zk1kia1MwZJ6J
	sJ3OFrHGGz0biOicyqr5SzY19c36RBjIq6V2rN2p+kbt9Gf7ZPSRlE+Z6cP9K8OnGt1q+FbFHiZ
	z580TTJmDmN/46DPjygY+Xi8L1Hd+bis=
X-Gm-Gg: AfdE7clZdXs088v4S2ZteyyFlfD2nnm3jt86J1j8tQEK03bww9heD7cD23DgMvIdGy9
	YuPJir/0hFsAKE197iVAKw2vh40xiyO3v6ppU176nY0XTpvRY7VASkGkngWGyjEZ4CMAShUygIM
	94H449nni1KvmK4Es8qVRgxCuvAYlTodVJICkb9pghQU14qP6vinrL96H7Lp1DdF2FRuzv2bAXt
	Tlz6bEP6bC/FrJZ5bDths8u6yAgRrMb8mwudd/mcBLRi+eDOibNXNDQgKGrD9rXL60QY9+vQmLA
	8tpvUdrO
X-Received: by 2002:a17:907:a807:b0:bea:f5ec:e70d with SMTP id
 a640c23a62f3a-c119cc73499mr81252166b.10.1782284392161; Tue, 23 Jun 2026
 23:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 24 Jun 2026 12:29:36 +0530
X-Gm-Features: AVVi8CcjqT2HGCtdY0b3TsVb5_1CyqP5ethEgfbUu0VypPx0SY_tnqJhPcFQITk
Message-ID: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
Subject: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	Kernel <netdev@vger.kernel.org>, Kernel <linux-kernel@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Please consider backporting the following bridge multicast fix series
to all applicable stable kernels:

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify
calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

History: The multicast stack currently supports decoding of IGMPv3 and
MLDv2 exponential timer field encodings, but lacks the corresponding
encoding logic when generating multicast query packets. As a result,
query intervals and response codes exceeding the linear encoding range
can be transmitted incorrectly. This can cause multicast queriers and
listeners to interpret different timing values, resulting in protocol
interoperability issues, membership timeouts, and premature multicast
group expiration.

Testing: The series adds the missing encoding support for both IGMPv3
and MLDv2 and includes selftests that validate the behavior.
I backported the series to v6.6.123.2 and verified the accompanying
selftests. The selftests fail on the unpatched kernel and pass after
applying the series, demonstrating both the bug and the effectiveness
of the fix.

Given that this is a protocol correctness issue affecting multicast
query generation, please consider backporting the complete series to
all applicable stable kernels.

Thanks,
Ujjal
