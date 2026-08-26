Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5F44CAC6
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759490; cv=pass; b=ZYAfaUOKC8GvKgm7+FpXQ3GX1e6kVyMvZJtcNJlGSLpm1eqYZVQaTBI2pyqXLhtNH6nihSIyJc1RUEpmt9RfoqDLpnFAdr2QE5VjZwJv28JVJE+NtEHCuuQMrHM1QIV616q1tKnNpaubsmw6oujMdL5yx+hK3e7So9wPszGFvTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759490; c=relaxed/simple;
	bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu/5eTirwI1fvoZ2nJAYmQkyKw0iDXgpEH5lo9cE3/G3YmoAfb5jR974N1UPE4N3nMM4GA/ef4pGOS4EFgGVZ468hbNan3B2EmBmAJP/jts5lYS7KZvaR+Z+20iEr57wSvQoB7Ke/RWrPPl0pTVDhMnQBAOEFRgofk3kjJpJtyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYHDUfNF; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYHDUfNF"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c8e2e39easo12108121cf.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759483; cv=none;
        d=google.com; s=arc-20260327;
        b=WNJs1p60umygJ65R5U6wdU2jge62vQktp97ZXASc3dn26QWXLfbpasJSoZvm+/ekoA
         eSJRFiQOB5DoUtSHNGwUR0xtzgoVLSUr4V8JpbWM94ZahMXJ1dMyotRLG/xKE28dHxQj
         MVU19mFrDEH/GiWgPHZPS7fJOoygFmNqWs9kL0rpVordub2vRY5uQS2rmMETURyT2fdx
         lIYCOK3pjYhuPhLsmihPqTRxg3vt7esnQqYZh7dfWVkuuyUoe/tYygj1AWvCw9BwuWf4
         V7UI9VpG1t5UMDhRc3OllKBNJn4ohWPA1OsWnSeomDjBIQsd2dRfgyFYlDiMpq15KBiM
         92Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
        fh=YeUD9veA4Z+RWa1hNZIaxdeIdWDAR33SysUoFdiaMEM=;
        b=qLInvFRzIKqJIzNmqQk1ADWxPRllZmdmC/0qAz/4rCU+RLv3IWOG2vaEvKhjOTtvh8
         M5NiarMTBAHoYdOMAYkuF66mz8OOZpL7Rwdsn9o2YolFZogIWrW5bu3YWuHcDNWFNYE+
         wv1tyqfJiiVceZ60o4nJQaUMXP10RoaDAYqnD/y827Y1lhLeQpetbWXKlKnAYTqT7hO+
         MlPzY5pUzxW1a2FvIAZQpC8GljTB1U0fk0DMy/5guxk8fU4eKKDafGLCm6EvkeH+GwNy
         do95gQH8+FUVxSW4upshPlC8WCt1kk7ybk+iF5AphJl0P9qzSOdc6oHwJ22mdCUWDJ0Q
         2uYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759483; x=1788364283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
        b=AYHDUfNFegDEmMNzE9qpyZLQfKBTi1s7pL2KWjAzzYywXTEwSMrXtkJrW+QC8uYCWE
         OLXm+b/HpIaYwDcFt/nu0NJegTqWCBCRb1NJGTYo25nQjwRrXQUplD80ExdEXjDythQa
         BD4TUB53FBbb9SIyjbSFD4PgEHbm383fWEP4u60woL8HVd3oFXnJIFgDeOF6cSq0B3V2
         VHQaNf4prW6nVy0xWVZOsniEDa0qqCRmRU90RNnFYV0yd3CzFeQmIK1atp+j/ccmbtE7
         2q3RD4cTuOoY76Pk7qc72IaRFs4ONOhnp2PAD6xJ//+ZqnVLgP9DXxkcn93ai7AFFpDF
         7TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759483; x=1788364283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/D9eHn0i6FJn8ZBJnf+FHDFfjwn2LjENkZX51FloUM=;
        b=Xvl0Jwjnahy3PIM/n1D0nEHgmCroYphbvXQf9onuL6lBcenhAebflk2eTw0mBf04fg
         eNqWiWk+ixK6gNdEP50sCczW87vvAWQVE/2G45g/dT5EeAmZLj1817xFLHCZcTD2B2Pt
         1e/YWo9no4kEKSDgM5Ek9aSiOwflqe6HDBoHFHRbbvAou9IEbqy0VD/+mSNoFqB8kOio
         3F+j79miSlqIz3zAZLx3nymm1CrmBJYd4DeRwGpJPzL+ssuxLPuBPTl2r9Go8mJuZP+D
         U9yJ3AyE7ONbF0nfPocpE3ZKQKWkpjdKgu8hq7AzZVDSp1mFdatMoV4E04pBvIYhVfJR
         vDsw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0fFdHtSDe1MhCtfgLbGabdUxijxA09OZpJRJ6not6fzFmPzutPz60tSsu6auc08zdTA1sll8=@vger.kernel.org
X-Gm-Message-State: AFuF++nmgZ7rYnvH8yQVDXVLkoMtVRMPQN41XQhYhHUNSZ2It6TlwJ5H
	Ra0WzqkbHJ6/uZwCtDkK50zyNhMfKG5r0ctX6oOjwokRXxMtgal5F1aQwPPC8gxD2Ct+rBoCIvA
	2kC+MK9OZ2U5YL0PtgI+Z4aAVaxO3mxtmssrsG6Pq
X-Gm-Gg: AR+sD100w60J2RQOHoIIop75o+xepxb5XaOhQVvGG4vA99ow6XvDaaxRAsmdXb8/8iS
	BKYNN2LMiHIzwUaNBrKYAOM/K+itJi9wBT6Kykpu1sUSeWIkVQ2JN3kFcDNOV1wMoyZWdoZ5HVk
	ZORZLAw8WbafKzosvjOoQHzfWg2IexSQUCme6tXpNCrSHiqvDhuUfI5XGg/W/Rsyu5ZZRWDUuG3
	j/BR4m9KiOS9hrOYsH3gehB2bo7qRaXdmqU6hgcVKO9vs7TAWWgjazV4Gz3V08S0XA6EdoMyGSh
	Eb2KQ5OGZVXEwEezQrp+s+5hWn66wcxDuTKJ2O4MAHqhKqrPYcflGnTzCvEZu1CMlJQ3t9a9Spw
	iQHWd+4AspA/1cnVnyl3RB8qK5wt1CEOniBGgNZiK8nNkjeTFnzFwVf35BIg=
X-Received: by 2002:a05:622a:e109:20b0:517:875a:d634 with SMTP id
 d75a77b69052e-52e422daf0amr54023891cf.2.1787759482234; Wed, 26 Aug 2026
 08:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826143735.1819315-1-idosch@nvidia.com> <20260826143735.1819315-4-idosch@nvidia.com>
In-Reply-To: <20260826143735.1819315-4-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:51:10 +0200
X-Gm-Features: AcwNN1WtL_35bV2gm4CNNp-SeVW9846oHPeCQvxx9DnsMwAuCL8obm53SfRbHRw
Message-ID: <CANn89iKDuub6PozapwA9hkjYKjYQOOccVxKzkj2N=MnUaq_H9g@mail.gmail.com>
Subject: Re: [PATCH net 3/4] ipv6: udp: Create exceptions when socket matching failed
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com, 
	noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Currently, when ICMPv6 Packet Too Big and Redirect Message packets are
> locally delivered and quote a UDP packet, an exception is created in the
> IPv6 exception cache only if the kernel can match the UDP packet to an
> existing socket.
>
> This behavior allows off-path attackers to conduct a side-channel attack
> on the exception cache in order to discover the ephemeral port used by a
> connected UDP socket.
>
> Commit 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()") and
> commit a00df2caffed ("ipv6: make exception cache less predictible") tried
> to mitigate such attacks by making it harder for attackers to discover
> hash collisions in the exception cache and by randomizing the number of
> exceptions a hash bucket can hold, respectively. Unfortunately, both of
> the mitigations can be bypassed.
>
> Instead, mitigate such attacks by always creating an exception, even if
> socket matching failed. Do that by calling ip6_update_pmtu() and
> ip6_redirect(), the helpers used when the quoted packet did not
> originate from a socket. The resulting exception is indistinguishable
> from the one created when socket matching succeeded, both in terms of
> cache occupancy and in terms of its contents.
>
> Pass the ifindex of the ingress device and the default uid, in a similar
> fashion to icmpv6_err(). Unlike IPv4, an oif of 0 would not match any
> nexthop in ip6_redirect_nh_match() and no exception would be created in
> response to a Redirect Message.
>
> Note that this does not allow attackers to create exceptions that they
> could not create before, as both helpers can already be reached with
> little to no validation. For example, by sending an ICMPv6 error that
> quotes an ICMPv6 Echo Reply or one that quotes a UDP source port that
> matches a wildcard socket.
>
> Also create an exception when a socket does not wish to accept PMTU
> updates (e.g., by setting 'IPV6_PMTUDISC_OMIT'). Otherwise, the fact
> that an exception was not created can indicate to an off-path attacker
> that a socket exists. Unlike IPv4, the check is performed in udpv6_err()
> and not in ip6_sk_update_pmtu(), as its only other caller, rawv6_err(),
> does not consult ip6_sk_accept_pmtu() and therefore already creates an
> exception unconditionally.
>
> Fixes: 2b760fcf5cfb ("ipv6: hook up exception table to store dst cache")
> Cc: stable@vger.kernel.org
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Reported-by: Noam Caspi <noam.caspi@mail.huji.ac.il>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
