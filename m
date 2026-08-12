Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8838CFE8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564653; cv=pass; b=f8cKj4L6GdXtKnfjGnL6RInM+No2UXHl1B6tvHlip1bCBCg//eiFTYtfyp53vFG3/CRgyAyLCUMCi8P46h7tqZi8UknPsjpH0qPwBI3IhKJMac3INmufdu73TUwdewzixrx9/1KmUn7xQo+GoevtgVbrGepCfC67IoZHNFgElQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564653; c=relaxed/simple;
	bh=InB0UYCM2KDM4g4PRBtwGR91Ve9yekZrRHjDpPJaqF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjplFJa6yhz8JeOjtnHVXdjKvceAT79M3U6QIf6yWaciQ1IZdGp69SXRqnApNKvQwXuwwxfpBcWv98yRjJxCoKOSLtvX+AQs3t9QABK8DRJAhFFk1RaX/ky5ZmOwpilVrvENgxDAGJQdrIofI/Px3zizC7hzxF10cYseYB7VGJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXP6a69T; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXP6a69T"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-76b3036d2d4so657730137.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564650; cv=none;
        d=google.com; s=arc-20260327;
        b=bo74RnmC+YP6q4ica64tD64GPrJpOJ6a8+XYrfBM4aUGV/uAt0Gx8w4VfgDTBf5QvO
         3yVujgGqGiKZZZ9n8sKOgWGRbQ6jy+ZaqnlGl+ETymK7fIs8LC0iBCRv1LLmAUBP/DZr
         mcfl1164xiyxkB1U11TUSQiIUCCtdmLTT1bE4ddOyit9IxKbvRo91ms7usLcva+Qe9Cc
         GOyvgXsdRQBLkrL2NGCRMREAr+82fdAGTyTCdXVw+mhi6u9iy2DmdMA1Y1GFDo9N8K45
         nBr20BF2eoqQNLVwpCGMq0d2/Kz2mfQ/cZjMNwa6YxYECo800TDOJ0yGFytkcSvr9ef+
         2F4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qd1nK7r6I3PGybOeP4cxvy0VcaUriRACVPreKIcrr7g=;
        fh=jy9sTlX/aV0viqkk+55NjP3pxiEiQ3sIzzJUbNtkfhw=;
        b=pmUtUp3ESjGWcfzzukE7olclYCVvc0HU3mwWf53Hd/5VHfteoQVSAF0rRNqoBxkG8+
         kJTAT7Z/KbzypwjKeGHnMjFGqa37CGC4ulr35A5rAeVGVovdzYZJtadwxiS4umpb9Xbl
         vHYtTcZeY9USzcQpRYsRNjye6T54WvGnzjFMQTTYZwcdp3JzuKSzR6h/MriI+S7LTis4
         xNzNkiBK5sqU3YBfirVHejyfyVOZCJ31QYcRyDo4h15+2encxgvSbaos9pVNC+eS88az
         y53OWOWk5uUHbgXL4ZI0I8nXzoq2TgUqDTEpwF7MgY7H5WBNOAho/DYiZE1QJ9tEUEhZ
         jnWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564650; x=1787169450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qd1nK7r6I3PGybOeP4cxvy0VcaUriRACVPreKIcrr7g=;
        b=EXP6a69TtJDolOgiRrubUDGucwFHO/nu7qttvGCXhPYwLBs9vk4ssI0ByedQosfbGp
         UvROVEyFr9MxiRTTTz24EFVXAPQMqzAmNbkbBcsUpEQNjLa6bfcJaMLmnIIZPUA2qvz/
         0EpOKp5x6TJXkyekDATqpslFtbZYV0uJRVBV8xzoct6UfT68ZjtwGv4UXXcp6Mcw6s3n
         OL2pnTBgMlw0w/t2WCh3Irb1p8Q18ZsAx1ROXH6irVR+1CX0x5wbOxKG5EAw9AYlzlzP
         PJYbNd1TvxKLg6TV+Mw1OTCSWoMv9JUat5PBqPTSZepeB1GeO/E7XeG6QQFR+8ntBnto
         UD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564650; x=1787169450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qd1nK7r6I3PGybOeP4cxvy0VcaUriRACVPreKIcrr7g=;
        b=l+N9vyiLEOqiCLM2iKbJGN9qO9Edy2mVmag9TRKgbntyfFD/H+tuBiSp4DVeianvVy
         MsdUaVZyjadjcUX+LUC4dfFmjMxDWr5VOzwQRXgbwA9l+dN90y1IysHSDOQGoPdWrmhM
         Dyrl6fVz9Ut0mW2LpLoSv/kc4JoZgjSrL7d7IHDswGnoX1ENHDsELvF2amRte3iXN9+q
         RF6TIqGQjKYGZq/M8gIKSxS8n6IzZMZAak9LXmwlzLMN6syzDfLGZWPx3W9DdVYfjTnT
         IFytZ1G/P14U9QszsnCf0xsmgm5MZRzndhHe4VZXsfGJ3Tvb1dgUCaXgf3lLZjUms9oR
         s4rw==
X-Forwarded-Encrypted: i=1; AHgh+RoiZGJ0B0Ayk60L3dpNw8tztEP2wmGZkQY1e49nwXrFFG9DKIWa5JCTEthHJJXKF/4YyyIlWQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxEnsUL7WKq8fj9ljzAPVNg9BCLQPZzdtEPFBKVf3wxoLVxWO
	hTE0rUBqjx/YPOYwkLuEVB8oV+KLrNlFdW6XhxQfaUI9iIjn9fkwnXFpJbfYIi18F9xJ8KCRo0O
	JbeWKMJk2+vj+ItTEB4Xsyg0H5vEGMM4=
X-Gm-Gg: AR+sD11n7Fa8gsBbjjXYmljrK19S1pk5G5U0q4seUwSobtUM4S+75WLWgf95ULZ8Ccl
	JVLf8s7vZkOJYhZhclRzC8mXoOpDDBEZzfz9oXw3EP9hFCnBLNL+BFuPWSVhZInv5Ke02I7VuxH
	MY6OMKPu8Pr/sr3LvG3R4OQrENxD9Pi0YTfR8EqmJYQbLeeBVN8lJSPBCkv3RmPV8JYFTI+4GLT
	fhHvo9wK1UD0tzUR+nz651nIbFoCQdpeuktS8lP8IftjoeM5gpGKno5XhBpOJC/KubaAegFmAAn
	jav/dzcn1jM3hmXdymQeTCVfxkj1DhZJgf2N17p5cFflOpQo+XH8OqPQjhA1tUOY+guvzCGmx0P
	nXA==
X-Received: by 2002:a05:6102:2b89:b0:745:1c72:cf72 with SMTP id
 ada2fe7eead31-76db7e94346mr273467137.13.1786564650214; Wed, 12 Aug 2026
 12:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
 <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
 <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
 <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com> <CAOJNxRK7F5vij-tw32+UjPztbzLX3zdhhD+Br9voD5wwQSANdQ@mail.gmail.com>
In-Reply-To: <CAOJNxRK7F5vij-tw32+UjPztbzLX3zdhhD+Br9voD5wwQSANdQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:57:17 +0200
X-Gm-Features: AUfX_mz78KT2Pxu-FZVbg-W3PDMj5g_4TwUllzYisPa0Uv1biboX1e1ncUZkZx8
Message-ID: <CAOi1vP-xdpg8KFiW93bhwtP6+8f5DB961afu42bebii5SQ3cNQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:32=E2=80=AFPM Xiubo Li <xiubo.li@clyso.com> wrote=
:
>
> Hi Ilya,
>
> I'm not sure why I couldn't find the original email of this. I checked
> the changes on lore.kernel.org.
>
> The fix looks correct to me.
>
> On an idmapped mount, using &nop_mnt_idmap compares the caller's fsuid
> against the unmapped on-disk uid directly, which would wrongly deny
> the actual mapped owner and potentially allow an unrelated caller.
> Both functions already have the struct file, so switching to
> file_mnt_idmap(file) is the right thing to do.
>
> Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Applied.

Thanks,

                Ilya

>
> Thanks
> Xiubo Li
>
> On Sun, 9 Aug 2026 at 10:33, Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > On Sat, Aug 8, 2026 at 8:31=E2=80=AFAM Max Kellermann <max.kellermann@i=
onos.com> wrote:
> > >
> > > On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.=
com> wrote:
> > > > Was there any specific reason you used nop_mnt_idmap for these chec=
ks?
> > >
> > > No, I copied that check from another filesystem, probably ext2. I had
> > > no idea what this parameter means (and I have never used idmappings).
> > > I guess the amended parameter in this patch is correct.
> >
> > Hi Xiubo,
> >
> > You reviewed Max's "ceph: add owner/capability checks for
> > CEPH_IOC_SET_LAYOUT*" patch.  Would you be able to review this fixup as
> > well?
> >
> > Thanks,
> >
> >                 Ilya
