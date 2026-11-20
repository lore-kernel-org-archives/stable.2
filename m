Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795195081;
	b=SiPs449QJirzbFPZdtGNybvOoAZ5QAbO5R+MRgKDwYvF7EvtVDHDqvkpOt7S9EOsv/bj
	 q878Qb+as+oufo8WJ9ksx1rnhXIEa0kjoS+T+EVjWFAVGbvjUgZPK+yfGfGjrXoD7T/RN
	 gRbHKM/sGfSah7lkMGyRl81Tsnz6ykNNBINIlqUNGJTMqXQ/9kzxf97vaj7iMU1hQx9Ls
	 ZaHC1akkj9FUbaEIuAsNyNPkjZbLkG13kaf0xEHJyUSel4wpfeQxh1cGXorl20GNhlCii
	 U170JQvyxc8I9MZ9mjVU1aKk/bzSk34MPn1OtK10ptMSxZ19wF5DdUio/T6yq3QyW1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195081;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=wjfu+1o0XY41QpFEK0UkLoGoO9C3f79CMyE3qI8pCWQ=;
	b=gvovbhmEdaDszPvE6V2eZgGsO7J67Z2RIpgD1CVuXFNQyh2w6bMXYT3yGs5xR+YfHxcS
	 Oq5Ki/1N6lrTSNqe+CJAHkZVBfMWzQTFgGzFWn951JkWZVO6GPq7JfKdCG18X43glmmZO
	 /Iar8k+IUQ0GWKJCdcS2j9wm9OHIr8ffeLJnFqc3VMKe4LhkYqGzZ4T9yV6tmF69LoaqW
	 pBMF9H4nK99JJ1e+5lfOqEw5H2Xwbc8vE5psbYIPk29+Yjbll2OLZpS3mgBhghOi9PjGb
	 YaIe+rdQGPWcLMfiXcWNPS1rhQ1Nh361221hPEADgEMp7p+rBfJtk6/B9rZjfx9z8LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=HvFsqWth;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0725606A33B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0725606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=HvFsqWth
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKH3jt62041472
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:17:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=wjfu+1o0XY4
	1QpFEK0UkLoGoO9C3f79CMyE3qI8pCWQ=; b=HvFsqWthOwr5IFXRc/Tsjs2JhU2
	waqs9ZKQnjldht7nZxu9zYt3XhDvdDhpIYEfiGJJJrEARGhYqP4wrclpQ6/0EBg3
	lRul39UgevRZgaQs0bGKuvsQi0xfHdWI42hfp2dMFO4+23ry2xekopDamDQ+QHRO
	mXXtwTWmKRWeGnr/fcfD6YmZLWD9v7sb3z+OTz4taeyADWFoc5O08MrAVa+2lhfG
	EBi8+Aae6qA7wuabHWw2J1neVqtl3Unw9VQ1tfsa9cHkvdngACKt/gZSf3Yp+tsQ
	oC4H3peNvc4jyK4lcsQdMFqAsEQWukxa8zbJe+Y9Ra7kS18gy32bPs7JW4w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2t9ar488-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:17:59 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb869327e7so1047001a12.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795195079; cv=none;
        d=google.com; s=arc-20260327;
        b=DnG28+gXj2scQJIcktwY3vhhcFbGPRtEa33XN2q7jg3kMoNq4Y+/pVxL0SvonuQXq+
         jQglhhzScGqIAKZDy4M9PjjKbus69Pk52pZkCYzdax/w5INsXOLf1OcYj6VY5wiDGT3n
         7g8X/mS2LRwZ0cQAujqO0IfX8s2gPjfyjnAe+4wMTHwnTA4lA4UaoaZmGY96LXbVcbeL
         kdgZ5qZPN1hcWBgkJJE7md33KRCnh7QG++ymaiEq4WF2xkRNyexsIDc7grXOoq64CIoV
         d0BmOo9Re7tDPumIJF1JyjV4LKByxTx7DzOQhk5EpSAeR9gYLoepPC88QR3L5Hx/Ad84
         r4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=wjfu+1o0XY41QpFEK0UkLoGoO9C3f79CMyE3qI8pCWQ=;
        fh=7wVuxgSmB9bbfPb5AaBRWwLsCID5zMZVzXlai+55QTg=;
        b=XoceMLb2Ni00zkW+6rlVKgaKIr6WLq0Tz63R2380jiizdK5gP9lYxAXMfONplzP5ul
         Pj4P/+SQTOYm4OnSDW4O6WnyyO0mF5nDgmiWkxZbOF81YS7eltZIczKSz+AgySyMX/TM
         adIXiHnjZkvxrMwWqVSorrlnaC7rYRCpSVzuK7m7nXNONjtOMkKVGyrzn5cYIO50oMdF
         QQFutdAQgL/HmYWI9KYu7iB0PPqp/3RZSkjozTH/E1L7EHFa/XadcC7PBzmEjLGCBrdV
         5MyqxZDDGLNfMNf3QF3+9bOlPaV/OsHIuXJHnWORAAgLej31D2niWmG29h0AnBth88dP
         3v0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795195079; x=1795799879;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wjfu+1o0XY41QpFEK0UkLoGoO9C3f79CMyE3qI8pCWQ=;
        b=u6/2u6qvD6IoJ4VqNCNVaDMGe8D7CpF0Y8msdtyedLHqtQ5ypMKYXX4gIqQb2SAPTx
         k9M4LD+aQRWuNkU+APARK5mwbgvoOI3A97qz1qNj4HTaPN7TaUgeVlvG0C/4ulamPUmO
         X+X+k1nSz+uTuLdGpivzkBMpSKxaj55QLSkT9UyoY1Uq4/4AQ5NUfunPxs0XRLDAc1jd
         z9i8dKQs1a/K8UvFp5C2/fmTpU5Q0jTBEQlfCHrfL6OIJ9z3t/jG8q7x7yikmtmunoAH
         QoiMf4Jpa6OmRQ2oRvAJwsMDRXPjJeWz1jpoRzA2CaTbi1vG42fxHt34hdtI2J4PVSVM
         GUNw==
X-Forwarded-Encrypted: i=1; AL+hErFPN3758/7w92QkLpwpo5KO817l+kDm+KeIuXhjuqC5clSCUyMJHanpnAwEBFeyoIocG96gwzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Hlva6dRtli+oIVzWMa43/CzJBLLwbm/JoLO4kU2mQo8q1XemO
	x2x5qvQ+OBwW93NUnaVwQrlDBEywzy70bgVgXDwQU2VSMsp+DZhJ4wR3/rqhba3RGSPIhAsXD/x
	kkFG9hjgMEYnuDtpWLRYkb1ECUf0jsHCRbXjzFgEhuRgi4vdqImvge/vevlnuulm2w5Jif7MdvH
	CHjqPIK42NxKY+h1jxgQ8Jg7uT++aND1Y=
X-Gm-Gg: AYBFou3+0AalR2uLKJ+jLsT0dPHfJQUV7m6+0OtX7wyUfP9AXFrLT2fPcLiuHPGu2im
	p1Y8Mcrbne14iFovgiBPtaeG4rimfA3WqpDFQojoH8FpKbM9ATrwcYZWdft4B2hNSVlK17kVy35
	K8SXtKp91UarUI/a4F8PT4FxGmnuavWsMr5vJUwOS5AJcgEJtd5nizZMks26pF+yBvML1gPuUov
	oL2qKpcZzt2gh6JAOLRw2h4VseLXUqx
X-Received: by 2002:a05:6a20:9f86:b0:3eb:39fd:bacc with SMTP id adf61e73a8af0-4014d360ed8mr3745382637.50.1795195078614;
        Fri, 20 Nov 2026 09:17:58 -0800 (PST)
X-Received: by 2002:a05:6a20:9f86:b0:3eb:39fd:bacc with SMTP id
 adf61e73a8af0-4014d360ed8mr3745344637.50.1795195078192; Fri, 20 Nov 2026
 09:17:58 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117203137.804424-1-toddfreed@meta.com> <20261117203137.804424-9-toddfreed@meta.com>
 <906302b6-facd-43c4-872f-ae40bc59714a@nvidia.com>
In-Reply-To: <906302b6-facd-43c4-872f-ae40bc59714a@nvidia.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Fri, 20 Nov 2026 09:17:47 -0800
X-Gm-Features: AclHuK-LgS6otYIsEJ3X0_WptWHRTeRKrRZOhEbdUdT3ro_BhN8Q7OlgsXmfnZs
Message-ID: <CADh2yMzLDMEOupGJwS8=3JbN-g4LR3ZapyBNaJx3chNT4_6pDw@mail.gmail.com>
Subject: Re: [PATCH net v6 8/8] net/mlx5e: psp: tso: replace only the length
 in checksum seed
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Boris Pismenny <borisp@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
        Raed Salem <raeds@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=XopvqlF9 c=1 sm=1 tr=0 ts=6b0080c7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=OFRVtpLxHUNKrmO6MooA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: eUYOHnzybj2G6xBS7NsPQijroZGedjdX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2NyBTYWx0ZWRfX80f+LaB5Ak2E
 aWBqnNV2mDIg9c7Vt9vHg1egWRxrHzgDtmwfuPtQob7rnePFeY15bQ3P0T3LTpAbBgjrEaRMPjz
 /NmAl1F/hO7JG+8QybBG3/O3f5oOAQXlgLKg7TSyurHGoHHehMkYcPyr6GijU9oGNAZ/35dIGRx
 CeWBn8RkBNEYQiN8Hc7vSmUcSajHH2qWJrhfxtek48yhAoYBVZ96oYJqYVhS8QCvkzKufiAQWkb
 BvIF8xGhK2/QrocwLgOReO6F8/N+Kmlcvh/rRjSIm+lomMNrvGQYHrbiRBCxY82qlRzhjHJlAR+
 eW6xG+tXVtcXwPLdVCz38hTonQAd9OnyPVUtchU4NHWS/jMgtdefjOMBMmRGWRoJ+dXrRDa/cEm
 PvvN/7IjY+J/HCFpUw3Y+O0OyB4SFgbsDTZsdXKZMYOhJz/YPScGcmsaWfsTs9XmY/BzLTPCY6x
 uW+uvDRbia4/8gmFw0w==
X-Proofpoint-ORIG-GUID: eUYOHnzybj2G6xBS7NsPQijroZGedjdX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2NyBTYWx0ZWRfX7SSDzD8OFvxT
 ub36Ko8gvDMXCdWbgUIHaA5KvBYBMDyrrObDXwmqNH0oCn4EwMqWgjfO4EIup4kl+RLRvpIPLsr
 6zlsFZ43OWToCgXw7u2eqB453Wk3zv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

> > in these cases every segment of the tso packet to go out with a bad tcp
> > checksum
> What did you mean with "to go out" here? Goes out? Or is a verb missing?

Sorry about that. Here is the updated phrasing.

    In these cases every segment of the TSO packet goes out with a bad TCP
    checksum.

I'm not sure whether I should re-post if the only changes are grammar
improvements in the commit message. But, if it does get reposted, that is
how it will be worded.

-Todd
