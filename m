Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524468;
	b=vapfnt5+zevr+4Cg2wNvjDqO3Hz7xKjehsU8GSLOtnn505AM/P7BL6RvQuUhc7PfmSqS
	 91+sfWLUV7iE76UwKat8VgNGKJ4iFO5qH3pDum095cu32G/5ojZ13p6wRlK7Ra1gewDK3
	 LVz5uF3MRFkh+ieSecScsCkjhSNaYzpHK9SkZociAN+kSXg3MCHVM3sL45d1kramOUWpR
	 Idjt3L6W9X4WIP5SnOKT1PmQuE8PHH3tiV3Obr37zIv/DBKx+E8ADJha+ioDDtMKQQnF9
	 MNpdSwJjS2ftCA3Wy2z5K7Yy/vJQlfNOCImTXU7P10Q2pZHer6VP0s//il2XuMQPwPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
	b=cVF87WjsPwTfc3h8d1djdaf9ZoYqThYErrgMd4dwEVb4Cgd78nJ9PWPwba6XzAj4jJJG
	 qSpY0dNgHdT0A/It/9VluqL02oIWPikCvz5ybwPZse6Sa5Hj85whj8QwyFJQzrWHtfE2C
	 9O4tvh7nypGlyqSS6lxbBEsUu8EsEA7wUcPd53S4BzB5SHmkC+j2s7saM5agtWh1Iw2jL
	 Ofaac1y26miBpWKiEqyov/jkhP+Az//7G+wR8MxIoqvbK9O+C1vIQK5QWpNXkAkBHkSbC
	 vZHhRpURdHSszwA5s32znoLZziGP23AOouKpZYDiSloLXops2MZNfPftoNnLzjKT9ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORwCc0Rf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B0606A884
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 700B0606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORwCc0Rf
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so3974025e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524467; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHHBdiImxwUX+SlNHdzIZw6l9vY77KLOc2G7kn+DFDvuKuNCoCR7S4amxv5xIfTjku
         4hHgq0NvykXYOz4GkkBfjtnI2efJ86HTEclE5rJlHVMRMh0sYUmzTQJh3WvDL60NLm4G
         QiapxJ17HiPZyyd0bWTnws3IX/U2OUaC5kqz0GAPhDwFRE134nRtn+tpsz8NmQ2uWebE
         dY/a4+f6FXrzRIKGJbgAU+Kdbon2hjf8WTIHCsx0DcUrfteFeHeS6UPTWnD1N8bYtR0P
         qcYXwtOWxMiN4AFPiBFZSxzwSUptvoMmkxm1WzOlvKnEU33k10R+cAUYHR+2DgyLQdAn
         1K5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        fh=KrPGG6tc2JWtsYKnBXy0jjKc9nhhGznLZbl2fnemvo0=;
        b=bEdcIo/eenuYAe5g/+AKn4ym8XFjTrR7CaLzyXW9f6qA2AEsFp50fDMy/KfKzP0eCA
         Gg71HOVgZj5tBv+62HEDzqEiYXSgDokdnSFEJbqN/K+/6VF31CymT3S+ledS45srj1RY
         AuKXIys73y4j+yfJCqCFehIFRvlTwWVINQZW3G6J5n1OwOc6PY2gmJmol4W7dhQl6c9q
         hf7lh7p/MNK/kYLofvCX0MLA/PUfPRVEEGPq58Ky/Jrk1l+p0qKcpi0NQvfdyYg7orQL
         xNCMKekYxNYW5BX1UA5ETaj6RmYcCMuWgz/BWiTMgOIEVGPgf+M6Zi0n6+aZzUCiq1y9
         YH4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524467; x=1795129267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        b=ORwCc0RfO5g12dP7DXRFOapIjWsMZprR43pPYuTX5mzuufCJ+FSeXnwUhWLdW5uQcT
         pUhjEZ6JndcGeqBS2exd1A6EPEaFxGnzAxxa3p1FYRbJgY/kNs2HrPyjO5jEV0eVTrCU
         MpV6JvRAyTtMc63c2sWcGhIVMtn9or0kHHYQxmTnxGzXPJi4ugNlUDjHOnnvbxlv5WQy
         j6WOnF+fX1TKbps7pGcWObt5jUeVGoqMY4fduHB+irTQuU9h+MkFBPWFJ//1njBTIxYG
         FEqOW2CkK6tHrOgCL4gg3YFE7gHukHSnJrunAODa8JKo+sBjGY0Ntec7QRCPypPNNCF8
         nZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524467; x=1795129267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        b=D4k2o3LjAQmoKOYXEbH9qWoQfcCPVcujfLvBdZQo8K+gxUktQUgAUqzSun435xt+4U
         bQdMQGOlI7RRbziupNs9OANQvZaC3g+3WSFs6X4rh00455DOC3uAo5dNL2OA+j+JNU/i
         1J8OLg8hXJf1yUhxv1/BF7Y9csQo3WUuztKCON7+tTSnpy6WXAd6bRKRwXIbHBQ0wZ97
         c1emU1qPczvdAyA+up2GbPFEZns3NKed3dYwFvq2y0Cwd+ezirErIVtg/gCqa0vN0AkE
         BqFY/AQ0/7Wcrpz9AyNYX+zPReZaLDhJ/0A+6oVtUeU0HNYPPUYXje/RCFmiIC4qlMHh
         2EFg==
X-Forwarded-Encrypted: i=1; AL+hErH9QpG5Yh3zC1I+5UP9mRUaYM6oRUvpTTyek8mI66vlyTMlekmU6upNZ7Y9qVZZyV1K+tLT0O4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EJRMo0je/B4Dqaxgf2vCuzlK1xDeVmP1cx9K0DVHxldEoBonL
	Xj31V7+cSlvuN31RqdPbb2aGAsg8Iw17+uDVlJ0Tk9xwR6m0cyj8YIKMzR4jz1/8Q4BmicSpIJo
	0aVlKVPwtR7ixxGtO3HFWrMBzIj1bZpcf1kM5
X-Gm-Gg: AYBFou2LwVSmAh56JsoGQdLqh39tQY/MxoYQOWnX8UpIjqAFhBW+fnoHTO2+tgRZny3
	kTgHIOq/DP+s80kDSIPf58/KP6xnTm6BX+zTqpaVYON4jXQRYHvr9U50g0vYr17fYIm7/xFb74O
	+GyiTFesB3s1Gz5sec+DMWqX7OQTkrgDlSW1ZYmxe50fmCBCWM6fCT0hrCm5H77gOs/UOwej67V
	FbZMJYu/NOpuoUHSYhwFzABugchjX2GMdJwQFLxck+J1Ulf6B22Cs4h1+LQI3GrQspmJ/L3ozZJ
	ouOaq6pUFTGVYSQA5o6OgqtIh6AnK4IIh+GyvAlx9HkJ0emZSuGgQ1NO0D2S+32pymy0XVzKBVQ
	QjigIwuio72F6quo2ALEWp/I3hSXLoAdFj5mZVrQQqwTz/ujVGS1jAisgBTCacYMJi7TJQIyIW/
	rycZ2HRlHs6m/Y1uQJ6fcqj08ScxLfZLhZuA==
X-Received: by 2002:a05:600c:840c:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb5599bda8mr15428035e9.0.1794524466778; Thu, 12 Nov 2026
 15:01:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com>
 <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
In-Reply-To: <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Nov 2026 15:00:55 -0800
X-Gm-Features: AclHuK9-JNkpmr-iGpGEl47XwzmIYWiDVtXbPH3fGOAQAo_1XzuYJoGM1mVSO4A
Message-ID: <CAEf4BzbdC_+KSCN8C=+E+3n4H70p9c+xbFvEOQC-RXADWbGB5Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: check cpu_possible() in per-cpu helpers
To: bo cao <treebacker@foxmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:41=E2=80=AFPM bo cao <treebacker@foxmail.com> wrot=
e:
>
>
> > please trim the commit message down, it's way too verbose
>
> Will do -- a trimmed version follows as v4.
>
> > not sure this is right, bpf_per_cpu_ptr_proto specifies
> >
> >  .ret_type      =3D RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDO=
NLY,
> >
> > it already is marked as maybe_null
>
> The proto is marked, but check_helper_call() drops the flag on the
> path this hunk touches.  For BPF_FUNC_per_cpu_ptr with a percpu obj
> argument (R1 tagged MEM_RCU), returns_cpu_specific_alloc_ptr is set,
> and the return type is then assigned as:
>
>         if (returns_cpu_specific_alloc_ptr) {
>                 regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC | MEM_=
RCU;
>         } else {
>                 /* MEM_RDONLY may be carried from ret_flag, but it
>                  * doesn't apply on PTR_TO_BTF_ID.  Fold it, otherwise ..=
.
>                  */
>                 ret_flag &=3D ~MEM_RDONLY;
>                 regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | ret_flag;
>         }
>
> The cpu-specific branch does not carry ret_flag at all, so
> PTR_MAYBE_NULL never reaches R0 there -- only the ksym path (the
> else branch) keeps it.  Nothing after the switch re-adds the flag
> for this case either: the code below only assigns an id when the
> register type is already maybe-null, and clears the flag for
> ptr-cast functions.
>
> Since bpf_per_cpu_ptr() does return NULL for cpu >=3D nr_cpu_ids
> (since 01cc55af9388), a program that calls it on a percpu obj and
> writes through the result without the NULL test passes verification
> and oopses on NULL + offset at run time.  The hunk carries
> (ret_flag & PTR_MAYBE_NULL) into that branch, which only restores
> what the proto already declares.

makes sense, thanks for elaborating!

>
> Thanks,
> Bo Cao
>
