Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831F257854
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757988; cv=none; b=RHOB15/IFl5OYY8hRI0EnHTB7qPI9I1U3UcmLGNv/el74RGM4shmykjkH0g7g0qBTWRfhNJCAf7TbmWaMFOCW4YENV6oVvwzwTOkMYw3/nr/3xwEVz4WvtF5aHlNM5LONN+iT6zqkv+6vvIwFX/TiW2RXn/lc4f3/kTz2RtL9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757988; c=relaxed/simple;
	bh=ip04cpuJ6gZcMJKZUo/58OpvKcONH5fc81aL2U5VDTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Geu6WxvN3VuTjtOut5fMPERoig8IHHQjpoImKnWgbD2gt3ANt/dlTTsKLHkQACxBR7Xa4pH8z5vr2Ea45n+n7Cz8i233Zdm5RUF6/OW8mRyvgdGlDbv0j5Pumeoh9xKdNbAkn1yknuvXQexRdnuHvCQ7ZnJLTDqRMwJShd2M5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv/1urIo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv/1urIo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac10e337so2518055e9.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781757986; x=1782362786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2406RcRfSwFwzqOnhnwujT4ewtnrCh+0Xd1gHWd5a4=;
        b=fv/1urIoRFzw1+c5+quRncujEA7ZIby/KMaL4roCUxUMtPUzfP56t4tmLZTmOvcZOj
         8/lM4Earcxaxm+LUAT0V0i3PaiZRrByZfneMVMgC3nOoHohCfhGA39nkY0hNLLHIUTks
         K7bSxhyVhBLQR1UnsFj1kYBq3XBJgQl9+9MpeUVo2CJCmK6ztAV637gP2lJTGjmMwzSb
         QL+ZVKmVfO7RDaNTmWp4bJIQTlBVz8rrHNzWzQmAG6NkD1Q6BGRGocyMPUlNO4U3hk8p
         4Y8c5MAhnEqz/hg5AKLGDq6Q/1kJqKuWWYliIYVS2mu0LFcyGhwQQHCmGjN3V1S6/JZV
         xDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781757986; x=1782362786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2406RcRfSwFwzqOnhnwujT4ewtnrCh+0Xd1gHWd5a4=;
        b=X97vtMNPW5EARgR2uY30+d6pFzq3nH+xba0Z6nXBzVNmXMLZNQyyjVekTwpXBSzTr+
         9d/60E8yK3zvmwvpNohNtgnUpL41ab8UPQcgZFQ3jwMbsrtsCcL9QJ4s3dC6wcmVeFw+
         fRbCDnsTM3wKh5ISO2PfGG+RDbqMXnsvnJe7eWFYlmn/PqtdqM5bYGiIB7LKbDT3swFS
         RqD9OzA3F6v4kI+A8dm0S+/x7lmmSrUZaBfoZhMHXl5KnISs+iRy6BSWXhJKi8CSeQ2Z
         D9JH9nGK6hoUR+vgLfYTAV9nn8e7O9FeNttWP+jp7EQ2C1jJKZBiRywCHR1IeLBdEz6N
         T2bw==
X-Forwarded-Encrypted: i=1; AFNElJ9cH4AamUa+xuG/pazou1Sk5O/1Cxfi2dlBwXYurnmRq00GMZ69FBjWJWKV1LtQczq7T2l8408=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qfWKKIYQUmnh/6wZbvQBHfRIOglMSEozfW9Cj3uQV8iqbcS6
	P4fHZn7efaCSuYp+F/ejJhqW7/aXcUXa8IpbuUuiAKkbGOObX95zjwre
X-Gm-Gg: Acq92OGzMdUoyy4c6J8XobuaN9Kcu96H12ZEMwibLE8agprNyFsdzE1ESzKo7E/By27
	CkB6dRyx6TmNjm298a4lHo0qWKEMFDvhGntMFXEDxnaR6IGvVn5qCZUWSXB5lk76lwA1gpcD3Xo
	QhRchDL38oasU4Dd8z9M+aeoSxDAJIvpHNg4XD/8lFzHa9+ffmBlLgNq/Z0tod2m+34IR5EM2S1
	rI1tI0kH62LeilKnJL0/BO2QcY0wgmjceiBI7+nfOhtwUBkMHRXGzT05BXGXbC1X8Bn7WIO/3m0
	asfpeCP28l8cZNSohAH5D0wkPzCfu6FziiY0456TVWlSm8rQXZX8Ubk/ANTzs1556bL2Oa6YZJr
	T3zHm3Bhubaz7TRv7plvkqeVmuIppa/cN+ixLJvnOli9IUYyyAB63PLJJTTDLH5MQ6Z020qZdW0
	DRsX9fPJWIojBzKoDpjMMq1w==
X-Received: by 2002:a05:600c:4fcf:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4923819e3f0mr31138725e9.0.1781757985830;
        Wed, 17 Jun 2026 21:46:25 -0700 (PDT)
Received: from foxbook (bfg19.neoplus.adsl.tpnet.pl. [83.28.44.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923a1d585esm19139325e9.2.2026.06.17.21.46.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 Jun 2026 21:46:25 -0700 (PDT)
Date: Thu, 18 Jun 2026 06:46:21 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, stable@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: Intel IOMMU bug: xHCI faults during crash kernel boot
Message-ID: <20260618064621.01217209.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260503071749.6abda137.michal.pecio@gmail.com>
	<CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
	<20260503213111.117db3a1.michal.pecio@gmail.com>
	<20260504093118.615ff480.michal.pecio@gmail.com>
	<20260518083339.507e24bd.michal.pecio@gmail.com>
	<CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
	<20260522110328.0d3eecd8.michal.pecio@gmail.com>
	<CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
	<20260523022944.59799d83.michal.pecio@gmail.com>
	<CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
	<20260523102815.5c05c70a.michal.pecio@gmail.com>
	<CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
	<20260527103221.7f8b15b0.michal.pecio@gmail.com>
	<CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
	<CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2026 21:57:02 -0300, Desnes Nunes wrote:
> Hello IOMMU mailing list,
>=20
> On Wed, Jun 10, 2026 at 12:32=E2=80=AFPM Desnes Nunes <desnesn@redhat.com=
> wrote:
> >
> > I have just found out the solution for the bug.
> > =20
> ...
> > In scalable mode, a PCI bus may populate only the upper root half
> > (UCTP) when all devices on that bus have devfn >=3D 0x80. On bus
> > 0x80, I have e1000e at 80:1f.6 (devfn 0xfe) and xHCI at 80:14.0
> > (devfn 0xa0), so the hardware root entry correctly has lo=3D0 and
> > hi=3DUCTP present.
> >
> > However, after copy_translation_tables(), I noticed that
> > root[128].hi was zeroed-out (Present bit cleared) and another
> > (expected) different value on root[128].lo.
> >
> > In short, the culprit here is having a zeroed LCTP, since at
> > copy_context_table() the allocation of new_ce for LCTP context
> > entries currently governs the pos variable; which is later used to
> > save new_ce entries for UCTP at tbl[tbl + pos].
> > On the first iteration idx will be zero, old_ce_phys will be empty,
> > thus this moves the loop straight to devfn=3D0x80. At devfn 0x80, idx
> > wraps to 0 again ( (devfn * 2) mod 256), but since no new_ce was
> > previouly allocated for LCTP context entries, pos will remain zero
> > while copying UCTP context entries.  After all upper context entries
> > are saved, tbl will receive new_ce from UCTP at tbl[tbl_idx + 0],
> > and not tbl[tbl_idx + 1]. These will be later written in
> > copy_translation_tables() to iommu->root_entry[bus].lo and
> > iommu->root_entry[bus].hi, which causes the bug.
> >
> > In summary, the hardware tables were correct, but the copy path
> > misplaced the UCTP table for bus 0x80 when dealing with a LCTP
> > zeroed-out during kdump.
> >
> > To fix this, I created a v3 patch that uses devfn to better track
> > which half we are copying, so UCTP-only buses (lo=3D0, hi=3DP) are
> > installed into the upper root half. =20
>=20
> 0001-iommu-vt-d-Fix-UCTP-context-table-slot-when-copying-.rfc.patch
>=20
> > I am doing some final tests now, but since this was a lot to digest,
> > comments at this stage will be most appreciated. =20
>=20
> FYI, all of my last tests looked OK.
>=20
> > To IOMMU maintainers: should I send this patch to the iommu mailing
> > list and move the discussion there? =20
>=20
> I meant as a new submission to IOMMU maling list, since this started
> in xHCI at the usb mailing list.
> Of course, that is if nobody has any comments or objections to the
> patch.

Looks like no one from IOMMU pays much attention in the first place.
Let's see if a subject change helps.

If you have a working patch which fixes this, just submit it following
usual rules in Documentation/process/submitting-patches.rst.

Regards,
Michal
