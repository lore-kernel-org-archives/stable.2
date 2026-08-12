Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996543552D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534341; cv=pass; b=HfUCkV/E8on/pMlRGkna01Qo2XWsX88nEQ9BJciAyt7hfB2fH/BXkrJYFhcr1WFRj3nmAWXogdTt8qmt6cBJlFxOLCK2674L/d0/WGU1wHBYNvmBzbPT4HkW3JcmyyDTqKk/+KEhvNaJPsOSAL8rs+aAAw2HM+9jRROUpxYvGC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534341; c=relaxed/simple;
	bh=i3fasR6deTxIk0Zf3pmhJBq+WV2nwYJeBvt7+ya3+JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOQal3Wou6xk0+hfZHJ+D/sl1/gq7dYV2X81KZ8BuAtS/i4JTuvTDvWgbW53vks8eredMpd/3mzDmlhE4lS2knUpoi8Zrz33Vo1SR8X6Ssd/ugSp9rgG0dz8weiz2cI5sRT5ndRnZuYZme2MvMcqQdjb3tMNVIKNqpHG8XeI/yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=YLJS4dul; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="YLJS4dul"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c52d920b8so112612666b.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786534336; cv=none;
        d=google.com; s=arc-20260327;
        b=BKv1EQlPbWTI0KCcQ8NTQxzEgKcjp5FGuEyjAuOhPdNEUAMtHlgIDzCtMxYCumJNyz
         e1tAEznIxsGttdLE174sqKv+sfFHsF16JSblBx4o9g5yqdXmlQb0rEZkaM0suAeKR6kk
         IghnlJL3peRUpUuUKSjY6/yLCkGPh281kthWm2quAdMvTBn++FjMxkXATbP2k0TkQTb/
         Ibk41nDNWR705e0dHV01pK2AH99VDnojER0MoQmwFL2zuhm5mnirybTnlWPqBCrpvMfC
         LOt3jyqAwWeBajz9Z+lBrMtIiWCUTzL/YYKCO2blELZEEE3kLamMHz+fNk3f/w1OkHDe
         DPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVXAUVrsaloJXqEm9a0tpYBwBB/k0h2yk4WhWvUDEBU=;
        fh=1vuVp2D/XFyvfclJdQth+R0AR3F3HjJo5SNA2b3Iof4=;
        b=Omu7xAcPS9gM+Q3IP9I+V+45R0FdRc3Qb/IftPVH4cViTONGC5xbH8Mb8sljKGTuu3
         hmwq3IyKsGDi8GCzKBf3yFwGEjkHYsDh6kfmdgyZRRAMrtQQtdMjyAIslWqYYqP+vKpk
         WWmKM/UTxAfXAfzweRm+ti8xL8L3pBpD4e6aqqPiuUlZh6z6NXczePd4v3pliThe9wPy
         n1oPHZXBrJv0Bv9ZvgIHXDsgZBoVfDNw1eNe1T9J0AZ78wD+PAtlApD8xdK5t2OkdybT
         oLzA4Awt22zH/DrQwGwy5gStBXQe9eOQnc5GeFOY85tHOO1R0vBacCaxlRnU6tpVXVi5
         mM8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786534336; x=1787139136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVXAUVrsaloJXqEm9a0tpYBwBB/k0h2yk4WhWvUDEBU=;
        b=YLJS4dulordBSF0gf9/fNwTd3c4K2YmqfqWXCkXc4FD5+NEkWffnfVg+iphTngBV/3
         AqHQmG0g5gPLQ5ZPtqazBa3ipPCuGUkwqUD7fiqSAwG4aVeQrq5Y9hABF2W10d2MsH3a
         Q7VnmaV2WkjUwLQilJ9PomsBYWgY8QBcrxMbB1xmwNMC9SuTaCXGXftwvsPmsd0M5jym
         C1tfJFwxKh0is3ic6LWvVBEIYYYrCrbP6XuOL2llO9znREytd1MX7xugqDKhO45fu0rD
         j9xVVeUJxQqmNMghZUmDq6nKf/CWFAe+D2qT08H9xgUTO/xRi1PKTTmCU7Z9SIUWe3Su
         VofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534336; x=1787139136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVXAUVrsaloJXqEm9a0tpYBwBB/k0h2yk4WhWvUDEBU=;
        b=GVOYdI8H/nT5GVqzW62icofZpEHF3EfJ/tkh/mnnK1CjTzvf1BUDki7Cuhi0jADlWc
         jO7b60wab1HIhNouTxtO/0fZl5T3KFc6pDk1F9r9O1HOzpDO4MNgOPh+H8RkoeY7BRWW
         MOL4PtST4DCQMg8XCkWnx1G/PHytvKAhshKpVUPlQv6RNDP6WouAhyVDpbJ393sdNQxQ
         rTUlGKYWKRfBtkXRalcY8qPG0ngXVRm33k19wq3i1C2P6dotMBr9oOzIxB7EHsk5Ek9m
         BLU3TyZYasv2pfNLF7raMtRuZZ+5yLtywlMdoX9tmKU5W5w/p8pvGY46+HkOnt0Y71vZ
         Zqlw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8xyfItmCMHJW6laeDxaCxlrj+WS7Qj/1sokvIEUMG7qyMPzKIcekANDPp2TQCFJ1zVNIn+6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tgGis6Mkc+P64ZEtA3PKwXWshUcOtrfrVtr4PixupZ7N+fgg
	A8j4O4iyEdQ4N6/BWatg/2QDw6lLq7oUpBgOT+MgzDx+PYEfYg3omiiKOAZ3qn8SZ1LAa5iRh04
	21AK54VNaFxxajJdn/m4LF13o52QEYZ/W4b0wxl94cg==
X-Gm-Gg: AR+sD11LUL5oOjdOBrL5YjLO39tAPM3tPuHlpotPd64KrUXgIIZ7V7UtcAF7RcQ5Lh7
	lYxJJ+N/NxWqT7KavzvJDH1IrNxEeb+2f+/WiDOlbg5U4hptxNGwoeHSzUzq7Yx5yaYFLvlzk5f
	U79KMLClo4x1vaJESU5zOGMHKBxJgCS1k7md2/I6w3xf2obo2XsmiF2TpX8rwId9WDxPmVHRTWr
	jrFgwipUMIdEjO+2Uv7ZulkoXU+jGmZGxIbaWOTLI6k6iAqKVkjDDXRq8yD+zy/La+Q5z/QW0tV
	9lPv1UyENpIzDsGEs6SEiYFrS7zByq4SOyr+UeNKpjpuaw==
X-Received: by 2002:a17:907:1b21:b0:c15:deea:a178 with SMTP id
 a640c23a62f3a-c20f300fd34mr193811466b.25.1786534336286; Wed, 12 Aug 2026
 04:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
 <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
 <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com> <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com>
In-Reply-To: <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 19:32:04 +0800
X-Gm-Features: AUfX_mxsl7ht9RvBRitjRFRj3rwaJuBRtFsXu0-en7gJ-F1HP6iU4Xprt3t2AE4
Message-ID: <CAOJNxRK7F5vij-tw32+UjPztbzLX3zdhhD+Br9voD5wwQSANdQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

I'm not sure why I couldn't find the original email of this. I checked
the changes on lore.kernel.org.

The fix looks correct to me.

On an idmapped mount, using &nop_mnt_idmap compares the caller's fsuid
against the unmapped on-disk uid directly, which would wrongly deny
the actual mapped owner and potentially allow an unrelated caller.
Both functions already have the struct file, so switching to
file_mnt_idmap(file) is the right thing to do.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
Xiubo Li

On Sun, 9 Aug 2026 at 10:33, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Sat, Aug 8, 2026 at 8:31=E2=80=AFAM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> >
> > On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.co=
m> wrote:
> > > Was there any specific reason you used nop_mnt_idmap for these checks=
?
> >
> > No, I copied that check from another filesystem, probably ext2. I had
> > no idea what this parameter means (and I have never used idmappings).
> > I guess the amended parameter in this patch is correct.
>
> Hi Xiubo,
>
> You reviewed Max's "ceph: add owner/capability checks for
> CEPH_IOC_SET_LAYOUT*" patch.  Would you be able to review this fixup as
> well?
>
> Thanks,
>
>                 Ilya
