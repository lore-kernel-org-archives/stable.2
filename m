Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A874DC550
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535592; cv=pass; b=YMX5/FYufKkyuKCB2+XhVYwVgMVNrZj08PbIaBXtZR2493mZVhBb1AdLByJROO7eHrZF8F0aQJAMkO+Uhfrw9gYCImvcMMVkjKihmdVmiIDlEuWekmwwA5pFcZJc7QgNmkEVtM7U5zogtIA8Brzyj0gbLpBnNXLUCfvOWrOOZco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535592; c=relaxed/simple;
	bh=6G4JBuygg29asOTmihM9IdEL+gseCWPThK62vKiAVwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujU21hbW9Bq+DgVRGhs3TwR8MC0zwis9iMrjhxQb/+1izhX/yOh/YroQLyebNqyZLoXYNtyJTfIqMQFDpUL5Mf2fVSxRr0x0xOetWdRZrKVnT+ezvbYlG1R5IBmFt43/n0gILPbSQApjessFO+/wCyg+uuA5hMtoKK42/Mu1ves=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N+oBY76B; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N+oBY76B"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4b2ff8ca537so909064b6e.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 08:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788535590; cv=none;
        d=google.com; s=arc-20260327;
        b=r11ehBVuJBchJIiGr8uhfYQxEB3NZBC2l73yz8VrNA6dpPmuXiul/JwCnS4/sEDDiy
         Yr9xdmr8NdlxcxvzTNCeMKRFy+/eMuPJKnS7TmnbhYem/vkxZdkfqMfu9UGr0tfBxz//
         Hu2V0HkQMMx47240v57vL9unUExSLJg5Sf7VrEQoMvZBSPoP3zRbOKvZ/qNlkSG5pkkD
         gJIr939MN1NXZ0ADKuCIyu4PjrE0X6JtEtwqbidrN8qzP48u4+/diQEGHBjNL5ZBP1ov
         OE6rjbSPCa80eLrhUr+E+UmFcxQmROCCwK0JgH/Bi3YxiJCGF3ISKv3xQbzF9nxctdHP
         x+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MEiW1c07BgdDj45KkxcTE5aG5zP0hUzSnvM2UrLubAw=;
        fh=6Ds8HTGOBElsBVXRS6nFxyb//vtbswjQ1r9XCiWSIeA=;
        b=E146FQXlJOc8ar//SMtZobwPjDWH5IgA/fOWvWpU374vCGSd/f8l8SpYPGt1QWQaW5
         u5fz3SCxb7UTUgvB/phHVAb7GjuCKPKNI6vziIJUFqdKVd7Ek6E65CGLG+BjqQsWPHue
         E5kMCTXedBJckimEEUQGhXp7vlv7qtL7uiv6FZ/xCz6QXQajNvpv1ccwZGZhc+JE3rto
         m90HoWNXXIMaVWFIhU+MGYhXZU4z0TVGwC7fWTI1eL3vWR9V6fKaf57bNJri5gTlFP78
         tlup2xgbj+BeJpeHJqaXP3d1R8JerMaPK86qD9PAestvm2WfsQv/KFM+pzyBK1/B8EAx
         YGKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788535590; x=1789140390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MEiW1c07BgdDj45KkxcTE5aG5zP0hUzSnvM2UrLubAw=;
        b=N+oBY76BO+SWjNyq+e6ZRNrY67RXdHnOv7I4LYvV17f0ZJKZ+lgqBcrvzMgrWjHwtJ
         AJLirZyITdhdVYBBnrsCUHQHl5NZKGbPVmUI6lC9rRMA+/AKA6PjQeKmfL8IXIIP4UT6
         snllu5jvVxMJhmGihUqWP2Hfo5ttAvr7auxDLPzGsXCI/qgx32QmlzYOBmdLfH7Jf2fy
         UmiW1C8KDAAE7H76oV/dny4o6v7dQ3G5o5KzNrQwR4qr4vPukkIpiquDpZyC0/vSugfE
         DExPg19zv3iEuYo8qUjLlisHBZ9pC76ja+UWhtIEuKORuy+m9BpWd1BIk6zlzL4HDWrT
         1lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535590; x=1789140390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEiW1c07BgdDj45KkxcTE5aG5zP0hUzSnvM2UrLubAw=;
        b=n3AljEzW8RDEsuS4FaFO6OC7szkRa2hWwXPFsA4THtKiej3hjxqLZC74R7oY5f2gWV
         l3avfB785KVZ+Qo7V1cv6kgxTkUDtcZZQLzwWF2dDCesLLgw34uHSR1OjrqgaChxf5SO
         xGFQtd5p9ClfxSxCbmS0BtKfDbhEWgkQa3UtfhC2bAiBN3/GJN6uQV4TVPvSAkg8FpqW
         OOCy5CV7rXGGu+OA3FQnJZBHrtUOQZMXRuwTf259K79xKwD6JNieX67e9PA9T9996JKC
         axhpc+nIH2MeM/p0CwP2lwE809FhwkiVlcBruzvn2n9Khjc4cktSVjIVyDA09iOPJ8CM
         lkLw==
X-Forwarded-Encrypted: i=1; AKwUvBzxliMmPv/ix+3TB9gaJE1CIil20FME1w9WSd/t8nX1GKAMhELEHjRdY9tOp0sgZVxA4BuLlrE=@vger.kernel.org
X-Gm-Message-State: AFuF++mhMn+P2+wdCws92HBVve4zuftp+qAujwsoFGZ1icj3sk6vfglH
	K39HSp4YzqMawQBBgjZlBvoYP50XX0y/H2yHrpHhjhVWgbOIsZx9KmNd7KT3/EHDSn4GC4Tvrex
	dmfq4edKMRwGdb3LnGaF2yy+bnEBZIlnbKXLTWiT1
X-Gm-Gg: AYBFou2rQwU0VcmD/vLZXqI1xM+0FVj+HRuffyiQ/zZ78RLbAQb8c782NUjPjDoUkWK
	xvslPWDoNdflXojItZ3e/+kevlSKgcxNF0IpnkIrSbAv2whslUdAJx8QfXPdZbBpH5PP9mtCHcz
	x4F8jilNlWS1BIk68W6g17m7ZY0dplMa1mEmH98a7YDhme9/eVh9copv68zzbabsiySifA8L+3D
	XmwEEIwDcZzK2o4XnUKJ7hBsMgI5TG9l5u66+8A2sFipLe4mBro05AHoReTXCN7YxMSjWMtz0fs
	kpwdl4zcfDFdYSf3t4wiORlcx//jbDylwUDk2UVSmPoV
X-Received: by 2002:a05:6808:448c:b0:4b9:a829:f011 with SMTP id
 5614622812f47-4b9a829f9d4mr3198458b6e.29.1788535589785; Fri, 04 Sep 2026
 08:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830201157.2084730-1-tristmd@gmail.com> <5be8f666e660371dbc964c2348422a25@paul-moore.com>
 <CAEjxPJ7b4nd7ak7HJ+AdZKyuE-kwfV_hpyx0r8Umz7ECAYVVEQ@mail.gmail.com>
 <CAHC9VhTiBGMJWQ7JSn1yP97XcQQUvwjZG1LKAHjQRiQ+AG792Q@mail.gmail.com> <CAEjxPJ5Q7ABrw6Df0m7Ru+7M5t4duCG1X-ogGc3+eGOXcAiuqg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Q7ABrw6Df0m7Ru+7M5t4duCG1X-ogGc3+eGOXcAiuqg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Sep 2026 11:26:16 -0400
X-Gm-Features: AcwNN1VoKU-uhh0ttKBdjKCG7-gBwHzJQTC-yOcw92FxcFNF5yaUZ8e4ZLjBjpw
Message-ID: <CAHC9VhRXFaZUnDYjd1sdgxSy2ngjEghcv7vE64qXiWQNzOLBhg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Tristan Madani <tristmd@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:11=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 3, 2026 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Thu, Sep 3, 2026 at 8:32=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Are you sure that's the behavior you want?
> >
> > Think about how the socket/connect check works for local operations:
> > the task requesting the socket/connect operation is the subject and
> > the socket is the object.  In the currently proposed patch, when an
> > ASCONF socket/connect operation is requested, the subject is treated
> > completely differently as the socket is used to represent both the
> > subject and object.  Even if we consider the socket's label a proxy
> > for the creating task, using the socket's label as the subject of an
> > ASCONF permission check makes little sense as it is the remote
> > endpoint that triggers the ASCONF operation, not a local entity.
> >
> > > I don't think there is
> > > precedent for performing the socket layer checks with the peer SID as
> > > the subject rather than the local socket SID ...
> >
> > I think that is because all (?) of the other socket layer checks are
> > initiated by the local system.  The ASCONF operations are unique
> > because a remote node initiates them, which is why the network peer
> > label is used as the subject as that best represents the remote
> > endpoint.
> >
> > Please feel free to put forth your own reasoning on this, a discussion
> > would be good, but I think we do need to recognize that ASCONF
> > operations are different from local socket operations.
>
> That seems reasonable. Wondering if this change will then require
> updates to the selinux-testsuite (or if not, we ought to test this
> behavior too).

Yes, definitely.

--=20
paul-moore.com
