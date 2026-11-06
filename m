Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954264;
	b=ceaa9lyNK+l4AULfPGoc5Xr7lh2gqFbSf1a9mEHd+qRJdg6zNhfm9QAW5+rUTRR86y0Q
	 qfk06g9awqczB3hBBxzLB+f8tpJb4it40+34IeiNbTEoiaJK9esYXdzWpoNJjI2iy9TMl
	 s2f9wjkhyTxOD1FnxaIUycPeIIrea47q9sczFfNIjp/Tk2/lehnP9gHxGyl+Y0+nPosri
	 31XclnSkuMCOm+J10vLGcspyWWqNlsvtUuZLew9zMSijP97/rwC5F2BExUSPZKSwLNRHk
	 wmGiGOcjoW06MfTHkUkLvXgCVdukflfZWomZRZ92zm9I4Luu7CxmqAgW0rLfI1xt9Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954264;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:X-Mailer:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions;
	bh=KwLryq1ZCCKlJLNf/9dqR26odXYHbBAlEucmPgeuG6g=;
	b=4ZW2c6CrWdHP8vfzn4GIaQgWY3K5swk4KfRlTTwbmOv1g0SPv11QYoDel0SQgtlmDGJg
	 I9RiySFnLFp1tCDMf3Teu54CHV1cEHaadbw6OCJPgJmZefG5ixWrsy/9gBhcm41EWPJ6f
	 jVVy/nJkwiP3ZfR3j73uyqTFYErZxkt+9cCIL4JxUhm4nWPi1FnlBoGhpKu2/ng3QcboW
	 LTKZ1BkRViXaSG27DN07DH+r9+h+h2ngCyvVzbXtMBzIDb6TBpUqQzLuRTGMR5Layb7Hd
	 zH5brta/OT4R+cEi68NAoUP8PdF06EeFC5c/q6kVn8sGDh6qTVSEYdOIP/xwZj1XB9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4Gc7TgU;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sYkbW49q;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1E606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C1E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4Gc7TgU;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sYkbW49q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793954258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwLryq1ZCCKlJLNf/9dqR26odXYHbBAlEucmPgeuG6g=;
	b=P4Gc7TgUFDtSKkyVMWlVgk1RJWDmAmpht0QzeaZss8UAyQNY7tmO8rs8426UWiy/PMRo2W
	E62UpcthVbvLmFTAffFrCX4D0OovTrNXkjnJRQmfkrr5q4R4112Ekr4WybYmPTSJyeepz7
	x0SvVMEllTmD7tcDOIlZr3j+Y3FDyOs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Ldi7k1CPMQyWweHwumN3Vg-1; Fri, 06 Nov 2026 03:37:36 -0500
X-MC-Unique: Ldi7k1CPMQyWweHwumN3Vg-1
X-Mimecast-MFC-AGG-ID: Ldi7k1CPMQyWweHwumN3Vg_1793954255
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c49b95262a5so26886266b.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793954255; x=1794559055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KwLryq1ZCCKlJLNf/9dqR26odXYHbBAlEucmPgeuG6g=;
        b=sYkbW49qn8/BztC5KGMbridi7ZjaS7gThkpt9QMdcdxm7ErDO9IamcEzi9HjuuY32J
         jfMbGCg8hvz9Kh0w7dnfiAZ+RFtQhzqwxnnrng58Lb/00BE53JAskPWH0Fa/c3IVqrjI
         nqHqA1Op6lHFW5fM4DQZg23NxOFVuMurwPX89Hfc8MDaiKRsSuMQ4pPNwtavOrgsu8WA
         tBMKIl/GLjUQHOJXj84q32V0AR2t7MXRrowOrVpfLIBDZydwRP/IiqyPBmXjEBxBOM2L
         TwlC9Ukx3r8xTBd5RAU19nfF4SnXb6b1Y4ZfhzahOF9ewh6cHOS6cikga7NZMtjVuZDq
         kTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793954255; x=1794559055;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwLryq1ZCCKlJLNf/9dqR26odXYHbBAlEucmPgeuG6g=;
        b=Yc9ktoRGu6km6Sre1LmPX0gNmz9hJxiFRMIAK67Dr4aMztbLgiisndL+gvGun6D0/g
         Ht4KPtoAG+KSNkwMnzcpqMSaayEovwVTk2YIUfCma0pQzjyGHGN9oxKbZNogiSnqemIp
         RQPfEAKmJeOO2lioYrCrHQ5ZWyiVARpHqkMUHq6bIlvBe1j7gESi3XeKgqGf2nM2F+Ly
         H6oLWzsKHpH2yBQ+SGXdIG/hidWy/p2r2fqwP4xOMWManfINYZUN2C8qemJSaUFcZ63n
         5oJhKNOgaypa6HLXP/3FGejw32hqdQu60D/081SaHIakQIOJ4Wxse0xZCB2Du8QL9rGr
         ZsKw==
X-Forwarded-Encrypted: i=1; AKwUvBwvD4f//NOeV0zb6mK1Y6LNlevTZicuCC807GCHiR+sJbOgLXfTdmB0EMObBR40yY/XguvknaE=@vger.kernel.org
X-Gm-Message-State: APuU4Z80ZieS+Hi+UWKF/ZC07YBfLonyEEsuLeoKJtNg07u3f3CcqlTP
	wIXt+k3fPolO9ZYkrPEyrSwTSfVcW6uJZaYfZJVdt1O/8xZ9fO1AMbCQEInfUP+IJyB5yBlPZku
	U2tkoPtEqFp1/wzPR74gcdNfv4INNUPQoMvekWgBPRhP5D4IeTM33awrLng==
X-Gm-Gg: AYBFou0kipH5jZIG7Iwt9JdDWK1GBr21VyyaQ18jFrvLmiVDC4tgyGm+gYW9Vqjev+Y
	F5DtfTMMG5lrEZx+9x22JozgL7SWTG4SfBB04hpU051Iw4KIwWCUoDptMYCVk0L5p1kMrfhg+W1
	tc/iBrKpdxdJnskjwQUeqTTxzvGj45wJx5PSIWztL4wNjyupdeVw9NX8yGZauP4cxhlkaKZxOv2
	q+tA30g6OW6PrN4M4OZ4ZtM6WpO5uGoNgrGf48hhzfOchBN0GASjbrOy5dLttZ8sRNJmDJrSbJx
	ni9dn1EDwLcAyRdg1PKhnFYc7484vJc2unQaPaxEUXST3oDEaYQlKwN0D441+DKneXCymBmfyzP
	2PPp9jLNVTAzF6H0++lfcs9m0+IQLNe1oNHny0GyA6yXnnQ9T1yx+42OGFNf24+XKAYqp/A5nEx
	Iz7WrCoXPfGtTxqgt9WiRv
X-Received: by 2002:a17:907:160e:b0:c46:d837:b358 with SMTP id a640c23a62f3a-c4d344a26cemr162751966b.3.1793954255379;
        Fri, 06 Nov 2026 00:37:35 -0800 (PST)
X-Received: by 2002:a17:907:160e:b0:c46:d837:b358 with SMTP id a640c23a62f3a-c4d344a26cemr162749466b.3.1793954254936;
        Fri, 06 Nov 2026 00:37:34 -0800 (PST)
Received: from [172.16.2.47] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac21dsm60206166b.12.2026.11.06.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:37:34 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
Date: Fri, 06 Nov 2026 09:37:33 +0100
X-Mailer: MailMate (3.0r7038)
Message-ID: <69789AC4-A3E6-4DC2-ACAB-EFC10F14EBA7@redhat.com>
In-Reply-To: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
References: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow



On 2 Nov 2026, at 2:45, Joas Antonio dos Santos via B4 Relay wrote:

> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
>
> get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
> key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
> whatever the current header is.  That is only right for Hop-by-Hop,
> Destination Options and Routing headers:
>
>  - an Authentication Header is ((hdrlen + 2) << 2) bytes long
>    (ipv6_authlen()), so with hdrlen =3D 4 the walk skips 40 bytes inste=
ad
>    of 24 and reads the next "header" from the ICV and payload;
>
>  - a Fragment header is always 8 bytes, and the byte read as hdrlen is
>    its Reserved field, which the sender controls and receivers ignore,
>    so a non-zero value makes the walk skip up to 2048 bytes and miss
>    the headers that follow;
>
>  - in a non-first fragment nothing after the Fragment header is a
>    header at all, it is the middle of the fragmentable part, yet the
>    walk keeps parsing it as an extension header chain.
>
> In all cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
> bytes chosen by the sender rather than on the headers that are actually=

> present: payload bytes that look like another AH or a Hop-by-Hop header=

> add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
> header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDR=
S
> then classify such packets wrongly.  There is no memory safety issue,
> skb_header_pointer() bounds every read.
>
> Advance by sizeof(struct frag_hdr) for Fragment headers and by
> ipv6_authlen() for AH, and stop at the Fragment header if its offset is=

> non-zero, as ipv6_find_hdr() does.
>
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header=
 support")
> Link: https://lore.kernel.org/all/178905555085.219967.66176117834372280=
45@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Thanks the patch looks good to me.

Reviewed-by:  Eelco Chaudron <echaudron@ovn.org>

