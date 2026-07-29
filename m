Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5D2931D5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295882; cv=pass; b=JFZz4qMsTxzEDuFu15LIU9lrEIYL3niP6T6hxQBhIhzwjdS+Rj/TmPwQ3oL1lRapYLCW+dWZbb7rbl8crmDSBF6RurFJv2kNvKbxCF/WXdfj5zYBPnA7Ux/9KHPZDvOkLlIBdIesx6xd7negryztCB8aBPzIDodG1XD87Ix1jJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295882; c=relaxed/simple;
	bh=vgpz1nsCtyukDVrnvJPzH6VKpEbs/rZH5gJoqD1DtJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2EZOlRqXs6RR4HksxkY2Lg1/V0wGGTCAhtqrMX1zp74vbe2fjUfc/oWrw3T7EWGAfykqauj4wTBbCjWFO94oY/3VUWF1msqJiR2nyRA16rvynF/3ECpthdXQrR1PleuflbfpnOYMfzS4kr1s8iqBZ5XqhDDW8i4z4b37K0LmoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mopaabzg; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mopaabzg"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c16ac21acso3598041cf.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785295880; cv=none;
        d=google.com; s=arc-20260327;
        b=eZ87nlehOpmzA8wi/Gv9hQnjRljFr7mZVYLk9p19zl99W4lopryVdwIV8knBV1j4UZ
         jEaJvw1CqNX8YulUBXY4/f948gWDHvHYzgAr98QehFC5bO5TKQmtGLSUJSkIwvLuJNlY
         Osd12lbWWCBfmIQxSExkgOdBqmJLxRv8kMSQcVfaXVQnAkDU6+g/g9nBzWOxdRYvsc0I
         TLv6BZDlKEYTA8HAWBt1aDmRQNKxVnTGUz6PBsWtrX/k65Bi4xfiUxGn8KHT2nKXFtMK
         vSxiVOQTwckFzwtcHe8I859579jMSy6IUsDG8ta/5HwTVMDuZf6beUBlS84yEwPUh8+5
         u4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vgpz1nsCtyukDVrnvJPzH6VKpEbs/rZH5gJoqD1DtJ8=;
        fh=oLnwcogb01AhigtcTYeCvRkPjtbbmf7bliaaatA/HxU=;
        b=WyzA0eqXzEGdS8MH+ZsMfBbCDUKE/Zt7TrwnueLMWvt8b4rn79tvLxxfPgcbhbjv9g
         0SvWfzmtVXK2j/RUXbzSoJVYqp0hVLlIQUXTYCW0rWsCPdty/HXZF5e3vfzyUnaBNOt8
         8zUe2y5aPaPiDBCMhdrsyTA2HIdEcLosYzi9IjLaoFi3/X+lbrJCHSoH7a7D+gWDshaP
         dpyK25mGYLk9ZHh2PTo6YCXQA/LFdQ6HlZa7+VOdsmTtu0F/tccQZ7jDEZoJE+xrTL4m
         a65UGKFYmRJlecLdwSMiAGiqgJM3VWDYPCsRasu6G/yblXP1UCCTL4Vj4JzgKyJGZGaz
         pjmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785295880; x=1785900680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vgpz1nsCtyukDVrnvJPzH6VKpEbs/rZH5gJoqD1DtJ8=;
        b=mopaabzgpuoHl4TDhbuvjeis9pIxotRD/2ODxp1ziUZM9aaMfk0JHyyPh8RGLo+x6h
         zHxbV8Eie3yJYJgc7xwYcBd+G+rrD5+TPBT7uoGqjssPfdIhaXGdJis3sgkV5Ah4PL5v
         yMMK/4Vgqh/yQjMxaIHrPokOtIWJp1UrP8CyybnoCrx4x8kvjPZytEMkkjNfU2N9jooR
         oOrn7YvqtvdThwy3Vtx0ReTK7/h9gUALLYPa3of8KHfWMg4wG6B0rmByogqsu6YHMjAj
         fdvR+SlzNQyPvfNCLOzDUdUJbFIQEzi0uJ9WUrxhxHmoGl8KierVswGKJAfjQtqsUqvV
         ey/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785295880; x=1785900680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vgpz1nsCtyukDVrnvJPzH6VKpEbs/rZH5gJoqD1DtJ8=;
        b=WwDiyxxwedfGMYHqtnbwNgPTka3RcgPnyitRRJhLeExH7BEGOIJcp0d5zGKQFbz+VX
         S+9xQQ0fbkCXh+ZzEPQTMYt29KsndY6UKTPIjiewyhp4c/6BBokQS1pMHlOOdb7cQ+fm
         0jaVMNuFp/FZ2fS8PH/t94JuTPGKkkJX58OiEc08XshVKIZaPx34SAfXQv2mlz4FkqKK
         q+SV++W+/2Kwiqb0/TNOBC+iMzqTO3QAd+BFWdrjCXDg52cyEf6/HHj3VOF8LJ7mbsHu
         p7NkJC6oqyC2UdlKD+knPDvhX+omARd5rXVNVZYxnylFHmd6TZXbz9gc2jtXnnXMNv6x
         j+cw==
X-Forwarded-Encrypted: i=1; AHgh+RqpDAcSBQCE/ALj0q7G3joWJiwHUJZBRj31iGh1OQvazWtFGu1Z/yJTfpUVnfq4O4KkzOI3fGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uAkd07V3xsgqOYiE8nD44/w19yWSqsE4tWohYEPyS1/peBMZ
	SPU4pS5EWRWpIoo12gAfMcvFBrU8sRzAcnjPcr/vgZGcc0E6K8BXc5ysp1axKbpPRMmLx2UCC4Q
	6B/CXdjhoVm1moSS47rad3Wvxcrgs6A8=
X-Gm-Gg: AR+sD11x2R08yLe6yzwSNpCLpwx9KTgX7FUVByrEgZ5W0eNSzrUWnbKAuXkv7zMZdm4
	+G8ICmf0jGXF9sNc4ynlHDRgzWKiywjJQSt1wiARO3r793GpfmE4H/IsnYYfgyf147AnJ1LS0So
	XDi+U9nrHyfftYbTDAPwTNIjQsihifKsMsqT4neWz5oR3igJHhEjrvA1pNWikaFH0EedJmBceKy
	CymLZ1nLUMFVvpmeZop0jI4tnESuXvhRlitpMSbKYk0G0t8l7RCy1qWA/IGEUnZW4vGRhj4FTtv
	S7Nt/eUKTw4oUG7UWahxSnoQLaiV1dhvCQOmVr0pa47qfG/XXRog+YuAG3aOAPwe+ueDbKymkaE
	NL+xNdVL69bNy4J21pthUwDGt
X-Received: by 2002:a05:622a:558b:b0:516:e74e:cc51 with SMTP id
 d75a77b69052e-529d71ea13amr47035521cf.51.1785295880018; Tue, 28 Jul 2026
 20:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727104103.28916-1-liujiazi@amazon.com> <cxw7n2vs.ritesh.list@gmail.com>
In-Reply-To: <cxw7n2vs.ritesh.list@gmail.com>
From: Liu Jiazi <jiazi.liu1984@gmail.com>
Date: Wed, 29 Jul 2026 11:31:08 +0800
X-Gm-Features: AUfX_mzqAch4dOTholIbYOxYhhZ4qOB_cjYnwNTLQcvEl2FTMWVofOmkWqsZ6Z0
Message-ID: <CAAcjFgh8Nr5FvLXKAJ+zb-2yKWQxf-BitrZBOEOMkzVEAFaHNg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix incorrect function call when initializing s_resgid
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jiazi Liu <liujiazi@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

This was actually caught in our product. We use gid as the reserve
size id, and we hit this issue there.

Brs
Jiazi

Ritesh Harjani <ritesh.list@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C 12:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiazi Liu <jiazi.liu1984@gmail.com> writes:
>
> > In __ext4_fill_super(), s_resgid is initialized by calling
> > ext4_get_resuid() instead of ext4_get_resgid(), resulting in the
> > reserved GID being set to the same value as the reserved UID rather
> > than the value stored in the superblock.
> >
> > Fixes: 12c84dd4d308 ("ext4: add support for 32-bit default reserved uid=
 and gid values")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiazi Liu <liujiazi@amazon.com>
>
> yup, that clearly looks like a simple miss.
>
> Nice catch! Wondering whether this was caught by code review or did you
> hit an issue due to this?
>
> Looks good to me. Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
