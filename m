Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8E47D94F
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157404; cv=pass; b=NJuIbrfvsT+Uy22TaZLPpg1k+xMgJboYLtxL+ZQ9DJhZUEgwDnmsE48s8HpkoPioHg3Ntpaddo4MiAvMSmKqohwcg956Gc/t9B+iaxiJPjNU61bnyU8rdrStG0cD7HD5J2cXvYuddMg6/MGWTaDqGU4gHoAJnYtHKeiMUT5G218=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157404; c=relaxed/simple;
	bh=gepP1A9ysh0N6NHB47FJTCQrzM4iGML9jXyRBN95fA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqJ+uFxRCJQPSFzLjF6uSCH34Z/N2eeX452NyJfVXqSedhz8U9NLU6ObhsFhfk3DKN+IvZwShT5fQIpZJKq+lU8+QDAuqKLeo8pQrqFMSYH1IH9HD9524JBZPWj1nzZzA+lQy0j5lOJMQqBJXa3EkGCKDeBhp63iBjd8VVWKyBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alkira.net; spf=pass smtp.mailfrom=alkira.net; dkim=pass (2048-bit key) header.d=alkira.net header.i=@alkira.net header.b=NPk+ydVG; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alkira.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alkira.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alkira.net header.i=@alkira.net header.b="NPk+ydVG"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87c90648f99so587634b3a.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790157402; cv=none;
        d=google.com; s=arc-20260327;
        b=CrZ6tW8RQfLXsO4WvpEUzHfAyjkDE3Iatow+cNxlaIAu2OqTWYOPZt99RLfqIX9yVM
         hr31hXg1QfQUwdw7zsYiPVTZTx0Ntg/vLzk6KB92S9y5AOlR+G/cuRkSpMRC6T11jXSl
         VdZRA9FD0PPDiq+RA4g0b0AUaJq2RPs+ezk0CqKZbLLUmZYLwfCv7Cv93l/kCsnZlKnT
         rWsmsMokdn3dRdu06vPu32vZ3zpKOTBfY6fWgbtESINcrA+jICV+PCd7fbWF3Ie565qx
         tpS7YmPmSQpw2cg1R8I4wCq8uOBu18zrkqY7Uba0TN0Y6bK7wA1iFDAYcNta8rYTz3da
         h04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cpgKIz/nl9xM6UgCUL7AH6mkw+l4ifqbDGv3fT/fFSE=;
        fh=IwR8SHcUmr2b6K7b7dyJBOf7lBUF3zaaNr9mQlJ5uBU=;
        b=ogAiCDWGHVIh6IUlzNzN8RwH65xZIAL8qO1cVT5vgK8B3ShK4OCEH0ZPsqK8Kssjny
         le6nb+aKJHR8e8QeW1MJ+Be29oEpJxG67JlgkjVzvKG0vZiz7+ep7kF5VlxqqZ+p+ude
         uNDM1GvQDcKCR2RsLUgxw+MgNWYDf1xXMNgYCihC9BVoa5OLjtguXH2vLA5BqsGnFvbp
         wmJJHuY5M6CPXPSxBCf5qGp7X62YLp6ZZfMdbibVigrXx+P4Vr2tNVbXlnt5J6l8JMDY
         pn0eXoalF1kVvi6Z0M+ESgB/IfWjBHzxyk4mfrIac2GsEKDVs07Fx7DiQddASAJ4uQmR
         Q1QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alkira.net; s=alkiranet; t=1790157402; x=1790762202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cpgKIz/nl9xM6UgCUL7AH6mkw+l4ifqbDGv3fT/fFSE=;
        b=NPk+ydVGBcqG37jr3+4H/Wbr5Ko3cBO6T6DsA7KQdjHHvJ57IYYwYY7g4FluV0I4LA
         lKJxUqUtOqakKD9KjFMSPrZ7ZI6OFLYqqUUKxOtxsppeOxKsT3BB9OyaCSV/erfYlsPm
         YSYBl+GnPdBmfRrbe8srYyhakmmKtha7IC6yoIT2WQMX9lE5K2WhPH5u1XvkdYASs0aT
         /OI0jrZUEdyMTRqkUhgZsF6/I4SiJVA8FRKarCJ2TE2oM3PWS+R4NiyPmP30AT9s3eY9
         qWeSnmvRz2pfQwAkzMFizI/bw9f2KizImUWuYXO7s+G/+jdwFkZdfmdJn2/Dhoa150Gj
         l5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157402; x=1790762202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpgKIz/nl9xM6UgCUL7AH6mkw+l4ifqbDGv3fT/fFSE=;
        b=y2NL89IoDP4kBN7bD82eUpFKOAKg7Hx2gI2U5MgF8sXGGmpgz6eSxbiOqTaQZBG8mC
         sX6p2kU2X2H28h+TICzHoshrX+zKn/QyYfvUVrIkNoVPKiqQHdpDMOCUJxqrUr4PTVfn
         8FoGTYK/gOk3Tnb+qKZDxXaI4jceenkdIkAlUWV/S1gJkrotz3Nxu4On8FtqMDrlLzjZ
         10cud3zBGWNcSxMbQWs6Be1QMCJ/JpGyl9+S0VXRCY59TrWwmXa+lSlN4LAjbbQqM++a
         +xHU4RIx7jrVwo4dlHkcgUy//u/MOnvcsd9lAEqZnTcjJC+9JS/GJBiGbxLW4CVyuqfB
         K0mg==
X-Gm-Message-State: AFuF++kE6GP3jijb4J07f+WCSFuDSqs2Mr69otXXqT3OYSWQl6yYxdoy
	wu56UV3NidGcoxvJWryTsq1dPgpT9aVSzTMgTN8t3KxutKpbDhhQCTbYmvajHd65SfHPSv/nnnV
	apKk88LSfiVRLcOJF8DlD1NohnA3N61ZDJWvYZuQDSw==
X-Gm-Gg: AYBFou1UvbUiDxTCrHafXf8lSkgK53NkoJTcMUghDe1NvrO+s3ieX7IL+MihsZl7PBX
	BfUPod50bavdRb49e1g3wH7VzdCcQqChJR1WvjqQqmsUu6SOi9VZrhSEvT5SxkM9kGq7FG/1ec0
	tnOALVH+gCMt4xd7sQ6ONt1Zpd22uMUoPJ3UYoKn5u7FOogpV0EBLI+eQKhz2EjVWF1YlsIGfzt
	MDZ3v2KmtuCRb1Xwqe3FI1fQjtQ+6PaohEKk+07KZETy6bOxjRrTqZQ1QGb8WgM0qSE3xpi+9c0
	vRTCzOqvSaXjp3rXwtJaAyvOPXitFcsrGqrGS+7XyU1q01p/GsOBdAI4v7cKbB/ruQ==
X-Received: by 2002:a05:6a00:8005:b0:87c:d962:72cb with SMTP id
 d2e1a72fcca58-87d1d4b9b3fmr1845440b3a.40.1790157402155; Wed, 23 Sep 2026
 02:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com>
 <2026092316-mouse-scallion-6eb2@gregkh>
In-Reply-To: <2026092316-mouse-scallion-6eb2@gregkh>
From: Kusuma DS <kusuma.ds@alkira.net>
Date: Wed, 23 Sep 2026 15:26:31 +0530
X-Gm-Features: AclHuK8wU4Sksj2iVp3kwEncGRLBwmdao0VGz_A6m0crpM3c4XTeRAUiXv8rTnA
Message-ID: <CAMcJb7OPfN3jSmaqW14CqBESDv=m7Lc+CQ9hms6kVKMWoeHfCw@mail.gmail.com>
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev
 use-after-free in xfrm async resumption")
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Chakradhar Kar <chakradhar.kar@alkira.net>, Ramakanth Gunuganti <ramakanth@alkira.net>, 
	Sripathy Ramaswamy <sripathy@alkira.net>, steffen.klassert@secunet.com, sashal@kernel.org, 
	dongchenchen2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for replying.

You're right - I had not checked whether it applies cleanly, I only saw the
change was small. My mistake.

Is anything planned for bringing this into 6.12.y, or does it need a tested
backport first?

Thanks,
Kusuma D S
Alkira Networks



On Wed, Sep 23, 2026 at 3:02=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 23, 2026 at 01:23:01PM +0530, Kusuma DS wrote:
> > Hi,
> >
> > 6.12.y picked up a bug without its fix. Details below; the request is t=
o queue
> > 8045c0df98d4 for linux-6.12.y.
> >
> > The issue: on every packet whose ESP decrypt goes async, dev_hold() is =
taken on
> > the ingress device but dev_put() lands on the VTI, because vti_rcv_cb r=
eassigns
> > skb->dev without taking a reference. The VTI refcount is driven negativ=
e during
> > normal traffic, and a later `ip tunnel del` then hangs forever in
> > netdev_wait_allrefs_any(). The process is stuck in D state, unkillable,=
 and the
> > netdev is pinned for the rest of the boot.
> >
> > Introduced in 6.12.y by:
> >
> >     4236c30b437b ("xfrm: hold dev ref until after transport_finish NF_H=
OOK")
> >     =3D mainline 1c428b038400, backported 2026-06-19, first in v6.12.94=
,
> >     together with its dependency af4b8c5e9d6d
> >
> > Fixed upstream by:
> >
> >     8045c0df98d4 ("xfrm: Fix dev use-after-free in xfrm async resumptio=
n")
> >     Fixes: 1c428b038400
> >     mainline v7.2-rc1; in 7.1.y as 63a300151999
> >
> > The fix was not queued alongside the commit it fixes, and is still abse=
nt from
> > 6.12.y as of v6.12.111. So every 6.12.94+ kernel carries the bug.
> >
> > Confirmed on 6.12.96+deb13-cloud-amd64 with a strongSwan tunnel-mode IP=
sec VTI
> > under inbound load; kernels up to 6.12.93 do not contain the code and a=
re
> > unaffected.
> >
> > The fix touches only net/xfrm/xfrm_input.c, net/ipv4/xfrm4_input.c and
> > net/ipv6/xfrm6_input.c, against code 6.12.y already has, so it should a=
pply
> > cleanly. I can test a 6.12.y-rc against the reproducer if useful.
>
> It does not apply cleanly.  Please send a working and tested version if
> you wish to have this applied.
>
> thanks,
>
> greg k-h
