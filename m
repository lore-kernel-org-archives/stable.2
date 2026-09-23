Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D432773EC
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160444; cv=pass; b=dTGUbssfUyAdnPtIBlAFlZVtHcNfg1wfWRAvbpZlIskPNBQGjnM2khE+ChXNBJIC4j3nZfPQE57Fv34QSC32PFtLVjjLG2UMLXHEUJoGaD+DqvnzLVBUwsr5zz0zJ2LFnY3+G1ZpD4ep/PFu5Gt3z91RAdJJIImacVmFRNoLQCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160444; c=relaxed/simple;
	bh=msXNh2HdDF+Lcwkkg4QxTlZJD2r8Tk8OINy7Tsecn94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrfRr9SxkQGyXUaDEd5EIi7tU2u+K0CCCvo2Lp2GjytmSKh1N2+Wk4FoI0LeXTUrDE4y/7fF/WD+hUD+VwoksgwdSmTpRhnSZY+ch+QE5iSEFb8MTCK2GsBbah84fEFyTrO57OB8DwSkfgGCQoLNW4W6u3lk4Gab1HuU4T+bDas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQKdV6bs; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQKdV6bs"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so1075301a12.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790160420; cv=none;
        d=google.com; s=arc-20260327;
        b=o1xtZEZvMWxYMxh25qI9/bJ2KqdX4DeeN8Nh+HvX+Em45vOXcOs/+hQgZ8UpkHW6nM
         JJLjERZPoOFptdnT9VYuE9DJFsZ/crRX+HPCLV+4FQJTsdNQ2w8oofLog0swOoUyTJcJ
         tQp8Bhm2eyuTFSMXWaIL93OPPoqj6FVMDwYHGcy+x/BCO9vuATWoE5Ug0SZ2ttYLZuF/
         2JWCOmzodBlLOo35we/2fzXtCOxZJCouB7NdgYiTyR9LlTUsbK1auQ+jFJ2tyAr6pXSE
         ZqJ2o7SnQLfiwamZm6Ru7P/tkDdA4bqUReqMOgPSRUbU6L2DZRMr/lbCXmUkCRed/+7n
         85CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfsSpgY3gPhyjK/RNnQXArXZalYQBWjirqT5uOX4kmA=;
        fh=9UEppUldSL9ZdjXX9X1yDic6eU5utl1pKFM5gBbvMfQ=;
        b=PfTpF5BqJ0WY6mekvK7rKx2k2FdfhvlZTsK6vEKnViaG61u2nI4aORypKGOnFxD87D
         e9a0XyKClBlx76IS2ueU9eTZxlnKC0OfPPd08FdfPxRqhg0HcSGqWpH7y5Bc8MJ1hV9z
         QTEonoaIgCNw/mbzD94vQtN1RlksybzBSNHfFltkFeIo5z9GszHY3FKeR+60d2t57fH4
         XRxcx0ypXViWvzpgE25Bf+7yW7xT8kVJYZX7ajPihN4NClcmHwwlCFubK4oW+dv6LimN
         4a2X1R/u2LK0NQHXirA5b9rw7hw3yWYMcDQ/JEOFnBUv7svNtMwQMF4SBuGmHm2/4taB
         d2ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160420; x=1790765220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZfsSpgY3gPhyjK/RNnQXArXZalYQBWjirqT5uOX4kmA=;
        b=kQKdV6bsRTYStFuf/sb79Isub1vuCfwAelGS0hl94Ce6A6jL3anYn8jCqVDqsJTyaG
         md20uE13i4YlLkvs1OweYMianRl7M3phDYCZynSXENITpM8+xExagUWdU6qAOflCu96M
         KtrC+gwjKDUCopNNle1RfezPBXB4rUI1ZPUPjjQdSgnZl5Ubzdh/DuqeUbgF+riUnb+N
         8U3HWt+lmOm68wBTDaFsA28iwbgYNLyHYKar7rSgbjnMAzwC/bmkBlrH6jbT7s8wAHQM
         6+8kegr/+Lbvei+3BtFQDE+/+lbsOiCQMJciEdE97VjC1Pb+YN3rtTMIiYao6JvSpwFf
         2yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160420; x=1790765220;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfsSpgY3gPhyjK/RNnQXArXZalYQBWjirqT5uOX4kmA=;
        b=qd42sl+P/+7lGtmAipgnWLtkkTBnz2JmVklfbKyEfGcMBzL1iNwe6uPQZtwiY80KAP
         EVrVEE6NAYk791h8X1NBOmxr3k7ObVFPhG+H0cYmkCs0qnej2XGeSRztCx8HjPdPjKP2
         uZ1C2BbdwS+4WaZjZViEDnC7VLySmc7Ms3xn9/q5U8JhEcHhBJsYEeRBI1olpXRYO13E
         jW/vSRFDICxQVbFAkqoO9oj5fcJwa6rLflC61h0OM8ao1hSTeYCSb+XcCzTMUcKA/ZUs
         SjaZ7/M5SNZFd92FPgc+GrRjv4BQv/7LZTjMQ+gSLvjGIcaRsBr2sChPFNxdubDM5QxF
         dhzw==
X-Forwarded-Encrypted: i=1; AKwUvBx752XieFfe5QcBkQXnEHZEzaE0jZeOqPqhVB0FuXDAfpQRXx+oIzmmsyCAKbTzAgndUYzw7Mw=@vger.kernel.org
X-Gm-Message-State: AFuF++nqGzlFzt14VqiFgCnTFTXo8MrFqwz92YmVrkUrciSwK+A1vwda
	CL4wNGCUiXunuaHTG2DHsXxQLkSqEXi2uSrfxdYVk4UXMvh84ikgIK3NMa3cOWZ91GiF1I2KVLB
	z7+NnQG+PUhYVNfSupCwm8dvNLB4OAfw=
X-Gm-Gg: AYBFou2H88KrcQZnmXflal40jBSe9n28qvYZ+kH7vgoZ96aAGyHL4qugfMaF5tB3dCk
	d2/LB9vQ+9FLz+9lcokbsIaLjClb9j0PjXB2U01zbo1ZqagsNk0QukCyMDsJ8SURv2zUvRB70M9
	cfptq0Y7Lgt2vkzl/vG9IvUiOo1N2KkVDs2uNkL00RUl3EFOVqa8Tcf0aPI+zVihr4LTBAD9EN3
	hDYSQjPbOKK5Edm1hW9iZZdv55ZFGeZGG2/GReL0lnF+05owimNJHFTON+Nm7P+i3zeH5HPwrAh
	5rEhphKHwDYRI4M62ULDlbyDVYT7NNBN+4NYDQv7Aw9dI7hYzFJpoOkUDx9I8e5FMV0=
X-Received: by 2002:a05:6402:1ecc:b0:6aa:734b:1a28 with SMTP id
 4fb4d7f45d1cf-6aab3b6db15mr2109299a12.34.1790160419876; Wed, 23 Sep 2026
 03:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
 <arORyXjxvZUoEAIw@chamomile>
In-Reply-To: <arORyXjxvZUoEAIw@chamomile>
From: Subham Pal <subhampal789@gmail.com>
Date: Wed, 23 Sep 2026 16:16:48 +0530
X-Gm-Features: AclHuK8mzFXFfzSoA9WshHACP17UijNZVLSKFGyP537HiCjWWOCf0JS5ZMRW6Fw
Message-ID: <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, kaber@trash.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:16=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
> I understand these are correctness fixes.
> Do you have a reproducer/PoC? Do you tests for this?

Hi Pablo,

Both issues were found while testing a netfilter based linux
firewall with communicating devices from multiple vendors
(Panasonic, PeopleLink, YeaLink and Plycom).

1. For patch 1 (NAT expectation bypass)
- Environment & Setup
  Linux firewall performing NAT between internal and external
  network segment with Panasonic, PeopleLink, YeaLink
  and Polycom endpoints.
- Observation
  Call setup failing due to missing conntrack expectation from
  initial Q.931.

2. For patch 2 (Failed ASN.1 parsing)
- Environment & Setup
  The same setup but this problem happened particularly with
  Panasonic endpoint.
- Observation
  Panasonic endpoint advertises sequence extension with missing
  optional fields during call setup. Due to misaligned check for presence
  of field, I was getting H323_ERROR_BOUND error in dmesg.
