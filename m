Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795517815;
	b=kexiEkJWdJZvAsCpQqw9Ej8tQCVj0IN9PnmfVqck3OicOMFapAKVPQnR6b7Myc41acQ2
	 DQjhy+si5UAH6V+8WIPtGTcuRbfd5B1kzuP8l2sA7xG+6YvVgO+dFUo5zG6dzQyDV30iN
	 smZGSee5M+4DZXn+cv4ScxLkKt3aZUD+i3ndcKeBZ+JswfFP9Y2BZlm5aItuRU+iSvMst
	 O36z8V9tvV6345E7Wecrx+iz/s7cF6QBMM0JQsxhZdBJDPE8b3jx/DAH2uLeMJOBkEup9
	 wLdMkU5UuVaS+x/UnbnXpUF9OcrJXIQBK/WyPanC3asa9qZKtXuBysQW35L2sDvA4jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517815;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
	b=bzwBMDvNYuTTVbzVOP+h5owVQ5j5pQAIZz8/KoN3wC4k6rdxm8MnyLw/fJINUZ2PpzhQ
	 9VtbXqG+Vjh2NaoLVIwJH8ETj7xO0S6q4vvgbNl9mdnUkXkjLRdJ3ctFO1seKBdwxlYfA
	 7bDqKyerCxLPAzmt36xOrh/Xgq/2Gjlg2c1Fl8m8jWwWCJJsLa8lcryGCb/Nz57W4vV6N
	 BeHVz7/xGnYYKeJXqNchzQBP2WkH1M2lJrJ5uYLEmvr1tJpoJSY2bisYcmnxVj+JdlzhJ
	 zGcex2I2blttbnIyUqmQv6loKVMuGs2t9BDhRjmSZqK4NAxhUoh+5LEJWzJYfE9gQYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIz2efb7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=knxU58G9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547B606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2547B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIz2efb7;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=knxU58G9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795517814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
	b=jIz2efb7kfzn3tVsUYgofhmPVjMZK0z8tdr/Rm1ubVtaUqvAJZEF2KEMjuwZh4wDij5k6S
	uY63qfVpQIoaB760fHNmLKiDKC8Ehi8iFmCcR2RbsdyY1F1RhJ1sbgVK0iQimQa4c0PTSs
	dtbT8GoEDeIDQhvEQOw3Ra+eSwt9OGc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-R3Th46bDMxq0pOCx0IGMNA-1; Tue, 24 Nov 2026 10:56:52 +0000
X-MC-Unique: R3Th46bDMxq0pOCx0IGMNA-1
X-Mimecast-MFC-AGG-ID: R3Th46bDMxq0pOCx0IGMNA_1795517812
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92104826f9bso84707406d6.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:56:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795517812; cv=none;
        d=google.com; s=arc-20260327;
        b=Zvq/9iJbYTf8QD8SUWwgXv9/IIq0PTVtGZd98kOVW0anNLgkrBcDAhKmKz1jYXXRLh
         KsCs6s7K3Vr5DD6f50WIfLtfU4S1q51FD6Mymi30U828jp2u+Y8kZvV49doFt4O+jSWK
         zDiw96y8h7/AsSdBMcPEH+QBrBBCautQX3QoV9FI8RTFSDa5gip+j19tfslSbS4RMjUu
         fu/Jy6LbijPQNBNrZRslChtOvt6uJyFGsmFwe8jGGNt3O8g6xgqerBgCbR/sU5MLETLV
         IYG7uOVagPqxv95ZiZ01naVxkMBzkwCoGUpIgK/FXp0lDurvGK7/YCLOaIcqhqF6uZDp
         NKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
        fh=Pr6fG12U8SeiROOAui4IIeE9oVA0EwwH9FbqFTKM4gE=;
        b=TEOhFy3oP1Q6rTsvcwdKm5rQrP/M/er5i++eADL/8wLAtkfn9tW//GC6cCHz7VqKSv
         px0Rp31G7JB2qUYdR3Am9i/XKz3QwubSM3OM19OzU6nBm3BRITW5MsCVE1Jc4Ia/yadQ
         uHG0nzrx0hNQhpH8vAgQ82s6Z5X9fOga2DVGOJ8zlnXC3GVlV2+v+/K3q8D40XXyPN29
         SVVnZYwk8FSHH8G0rr+cOSf4hLN+X3+PvvMiscg7yeqI9ZwhTDE3jHu0/Dqezu23h5wc
         hSReWODZL/wpJ+WUxoWz0e7HkuSdEp0Gb3Q6VVOUc3JL7xMtKTR6C1jDOzUREe5CSMab
         Efxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795517812; x=1796122612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
        b=knxU58G9EnFyWV8foKIRdcTcfI1j40+BA3ji3gp4YV0S/wPJ97c3wwLK4+/1vBl4Pd
         CSIU/7IDC++5uJz/Vb9OMbnp92kbZTkyAz3Q2j5LyGM+l1dYTrXT6yxIvTrQmlCEiQ0W
         gPpf5hWvePJ4NZJMPeFlLslxxKVXQp/Y10FwMkHGIJgR5XZputLHML0ZUaqdhdhlKqQS
         XPbUh59gcL75DHgo5wYCOr+/J2sTNbPNR1g38rJd+QgaZJ8qqJ0FCrgVSSoJhBkTn06H
         ymTanPiYX1ub6jf88epclU+JkvL9kvgk55sQEOyoyPzbc4tUzmsibbQjiQDefpr0z6K0
         SqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517812; x=1796122612;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
        b=vcm4XhVla2Tggd6uU/fU1BdxZZ1FblVUqXUeCbiQWdt/RBMwS1dDBcm0tvptsqVBUL
         MuwWfRxrDRtdg49mH2QOFhyOdZhfdTCUr/ctmuP+YL6S8KENMkoUNh2z8K8+Q4lBqh28
         3smmSAferoT/W3lNj1CHbvxPvKnA2gPJ3p+nlLtFPFf0dMld24D5asNPPptChg+yxjwU
         iqWWlaPkQ8cCyZR7wrdlz4KreIxyYasG6wCMNptj5IW8kAxq+ZwL1aqK+y84w6b+q/BR
         br8lKxdGlKyD0kFNvUZZN3i4XwJJ7JSvKnTMOC6UrKKJI5f7Jmhu3PtWe4CJr2VjrQUp
         FCiw==
X-Forwarded-Encrypted: i=1; AL+hErHM5N+tNvMIlrifKkSiYsG/QxAB0bz40OjXtIApB5F5UK0yrDqlpHsKYCo1VDY3MGfFQShCXx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e/gkWwaSSE+MLSBF+IUG1XM/tu/YpANJ0VyA53u8b+CTx2op4
	MhF31bVUi14JFzi8CKT00H9UCSu9FkgFbcZiqb/Ldu7idmcpkU2QDYQIPTV5cc1BUXXszmCsg9r
	E+CvNlBU5NKnpy/J3pRB/8qBKAkrYt5VnpGvLC0+lixojN2VAjo5rnJyP4rsdvq3BzxkwZFrRyo
	J4kJ7VAHpNmG7piAN0YDGp1EFLGqHSIlfx
X-Gm-Gg: AZFdTZdeDdejFPgJg1oT5wussig5ylU75wgySQRJULWSYu972Q82kGAceQ+AqBpzspj
	EmPmjSye569lY0qfKSVUHqHB0slxEqOoCIwKzkL2/sgrrV57rkouzgbpjih5yJ51JIGyv8xd01m
	1138naoglmXjBJa2vz+XyMK3+KGiMXyjB3WDJYDisXywX5DqHqHMSSL2A=
X-Received: by 2002:a05:6214:226d:b0:921:37ed:5d0 with SMTP id 6a1803df08f44-92137ed0715mr242412836d6.48.1795517811504;
        Tue, 24 Nov 2026 02:56:51 -0800 (PST)
X-Received: by 2002:a05:6214:226d:b0:921:37ed:5d0 with SMTP id
 6a1803df08f44-92137ed0715mr242412426d6.48.1795517811018; Tue, 24 Nov 2026
 02:56:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 04:56:49 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261120174540.37d152de@kernel.org>
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com> <20261120174540.37d152de@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 04:56:49 -0600
X-Gm-Features: Aa3M54oXKMFlMM1Oml5R3p9TM3DnPWFPNqxfUYAgRUMjL9U7VfA3l26fuKvgEVA
Message-ID: <CAAiTLFVC-oxH-7N=FOCdVNcJEEVMU7WFV_k5t+g51Ce3ZdrO-Q@mail.gmail.com>
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network namespaces
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 17 Nov 2026 20:01:52 +0100 Sergio Lopez wrote:
>> VMCI already rejects datagram sends from local network namespaces, but a
>> datagram bind still creates a receive handle in VMCI's global port space.
>> A VMCI sender outside the namespace can therefore deliver to the local
>> socket. Its handle also prevents a global-namespace socket from binding
>> the same port.
>
> Looks like someone (silently) applied v1 :(
> 00f445721c7f ("vsock/vmci: reject datagram binds in local network namespaces")
> Could you send an incremental fix?

Is it worth it? The change between v1 and v2 is merely aesthetic.

Thanks,
Sergio.

