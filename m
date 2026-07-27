Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472C3DDDC0
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141859; cv=pass; b=EW1t1f/ck+zyZf/v0wgeJHFEuZoLoWWJfHHx57AZQO5cwobiVpbYYqKcVyx5jUJTYwPf7jYChtJaeK7yfcacX6Gdt5S9JcjTbeo4W2wMTCPaHe9opfl+AQ14kl3RV7mN2SYwsgFCcC9QNHXUY7pp5N4nTCSssZsuGb5PFI4F0Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141859; c=relaxed/simple;
	bh=YFn+SG3jt0W8ClbW1A5ZvhnjFO3y0/T59yYvALkEpOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv2OFY4RknlRVs3kw+AuyczXzTRInpn58UVmDRRAR7bzpy4QVRB+YmHR0cFDDc8MVuqlge7zJr17XEEw65xEWjjhn2m12Yp0N3sLjzqSJr0ejDNsrhCbe/pvP4eQtncWLlka0tbZO43rCJaShS/lTKsqPjKdZvq+QdwaQ+UJ6u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZI9xoAZ; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZI9xoAZ"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c106c38e99so1351747e0c.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 01:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785141856; cv=none;
        d=google.com; s=arc-20260327;
        b=cN6ugF/XyyA7D4b+8V1yDlpQ3S5OIPN3O0F8QRWIw4OuU7khCbT0lcG9oCvbRLyXth
         TpsSByI8hz8DHdM6ZgkvYgep9HCraV1a0ufUQUua2u74Qq/7EpeFD/elPq9aKazRzik6
         kfkLs2gFFKHFrtJKy5Qp4fDoVzN8eAcbZAsCJ4p3Oo8GKs/aszr06g+tsY++J96tWKEo
         W2QwoBTivNDM19JCEpzDDibo+UHWcytW0esEmj67tuatHATwBTg4ZwvINxFGfgfw7e8f
         yc8GTyCmL7K9QYYon7udxOQv0TRVsxvREmtBT/NkJcaVElyw69ll4CYKg0+hPOFJpa3P
         mzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6ZJtMg2ZwUmSn3lFbPCBamJdEbDXw6UU/0/bZEAB3g=;
        fh=ajdfwz4qEEtgePxQuv+0tRLpuXDoV1PHXMBie004cXM=;
        b=GxEORcZNG0YZbtv1nOFPlLCAtdQcStvYIjCK3DqtEXbL+hhKqFnPjggvXPoh/DxVnw
         QYTY52Rv63qVxqrU3e+wbSJDSiwhBS+Fw3wHsQiFh8bEEzL7mEwuu9zUUc+qxFmGHza3
         HvGRYrjDxmJudZXVYh5NgN6mLuOm6OesR2I51mVyFcFElRzByfqHer+m4EXo3cYtL2Be
         ya+IsJGGM7nmbXP62m1EORSK5gk3A9GYEsNZhBM5T/IRhmh/TmYOuHUbKcRomfQ3Mp4I
         T8Jjnv0Mh4w0NqG8AkZmTH/w2upBz2Felw2cTgclvPUog9GF8NR1KPuG0sRx+Ivm3LT0
         XLvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785141856; x=1785746656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6ZJtMg2ZwUmSn3lFbPCBamJdEbDXw6UU/0/bZEAB3g=;
        b=EZI9xoAZbvODmBSux/cJ/a+6T1/UIO2yDCT7uFxWhmMDMcnk9XC0F1hGVBlIwVI9Fa
         JdJxPevAc6CST4aFSSv7r6X7zBkGUzM9Prb5FzWIxFuFKvbdc9bXVkjKljPctxk1kkMY
         Jz4XMK6/RHaC7f0TRdDVMTPH8m7zNbtfV8LyRXmDWqLvNZqtqc8IMzo12XqNakYwrTAS
         hG6Q4D9r2gmz2X6N072eP+uBdfaIp03RIDBR6Isg7Y4axnxLjcLVdMscHTuTUDnyPsCb
         Q4RejeHj6OVkBHshHlIQbpIBeqn025/wqyRfc8sBQWcCzcIa/po0WZvdIC/aBCOVO1Ha
         Jwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785141856; x=1785746656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6ZJtMg2ZwUmSn3lFbPCBamJdEbDXw6UU/0/bZEAB3g=;
        b=nim48zp/LbdZuR58Vg7+ZDp/ri1YGeruUCWbD7aOjFe0IX8n5lX4PF2hKEw4yYKi/I
         //fCMYmhnXlVjcAFA2e1flEuGMk7zrEiC5Fb5qHOcUk5zW9UcJR50rbNOTfLbkaj3b15
         pBnqT48rASTI76f1vsU2FX4kCEvoKrVUEzaJGgZRuieiDiXOjk8qyE1Uo35XNPwMqWJu
         JVANLu+TJzkgGaSrL3Mn6vIsLOi3A9l+cBcKyCeUnrkS+9sukpfNANUINw8Cse5O09cO
         70dFw6IGfzKQXWmgAL2zYPxmQnRCX9XOHm61bIhaAkdrWWUiflSqQ/yZUVrb9MAVaVZi
         vt/A==
X-Forwarded-Encrypted: i=1; AHgh+RpTQ0tvl5ujhe1b9R0mOJHCJCj/A7pu458JZ94ODmgvIHicyukSapQL+Dwq7+KtrM/8CZAR6Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkxFsujO6wUOY7Dzw0A9oX5nEaqTuwKkVSWTGx6dRzz/Cwewn
	Knuy3ATYUh9dnh5HpDhNTXD1E3+WkfBuiAVAKSuJAT7TB47bwndtQ0X5OHifxWSqpIOYAAPeWg4
	Lj2qN6B5kN5fzDspEic7737pdiJ6y9rA=
X-Gm-Gg: AR+sD10IYBHzF9FkCsHdFIs5GAOPWiQcx+/pfTLBNejgLEkm8t1BUpSWSiGMZlc1059
	e4GnqhneUrSJcMyDREqneWU6tX/2nFVkmGzs4n8GYK/+n5uZmyRG5uGckt1TOwoutRXz31UCatD
	qf0nAuUieMis2Bo/gqUApFwT7oX7W5YD1JLRPdG3PsCqNM6BHcpadcUKRw3HOevhC5cb122AbIL
	+wOn1c5AbKY3VHF7NQr3pDmGOeqd3glEFd3bshrPIAsm9ngK8VRK3Cixorstqftamo0hU/2q21g
	MNKmSo4tXojtmtk19xI=
X-Received: by 2002:a05:6102:80aa:b0:736:e4c0:cddf with SMTP id
 ada2fe7eead31-7503e05c0e3mr4177154137.6.1785141856027; Mon, 27 Jul 2026
 01:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104920.6493-1-zhuyiming@kuaishou.com> <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
 <103949f23bb3169381422344cd924d6897171e71.camel@dubeyko.com>
In-Reply-To: <103949f23bb3169381422344cd924d6897171e71.camel@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 27 Jul 2026 10:44:04 +0200
X-Gm-Features: AUfX_mwPft2RaWQR3lusQ0AdXwEBit482lAfq2XN61nxaMw3mFMqLwj4V9u202s
Message-ID: <CAOi1vP9D1RbVkKLg1P+4ia1T+0QiwXp2hxOgnN6u=S7EVU5J3g@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix mds random selection readiness predicate
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: =?UTF-8?B?5pyx5LiA6bij?= <zhuyiming@kuaishou.com>, 
	"xiubli@redhat.com" <xiubli@redhat.com>, "amarkuze@redhat.com" <amarkuze@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 7:59=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Fri, 2026-07-24 at 11:40 +0000, =E6=9C=B1=E4=B8=80=E9=B8=A3 wrote:
> > Adding the current Ceph client maintainer list
> >
> > > On Jul 24, 2026, at 18:49, =E6=9C=B1=E4=B8=80=E9=B8=A3 <zhuyiming@kua=
ishou.com> wrote:
> > >
> > > CEPH_MDS_IS_READY() is parsed so that the ternary expression can
> > > return true for an MDS entry with state 0 when it is not laggy.
> > > This
> > > allows the random selector to choose a down/DNE rank.
> > >
> > > Group the ternary expression under the state check so zero-state
> > > ranks
> > > are not treated as ready.
> > >
> > > Fixes: b38c9eb4757d ("ceph: allow choose random mds")
> > > Cc: stable@vger.kernel.org
> > > Link: https://tracker.ceph.com/issues/78648
> > > Signed-off-by: Yiming Zhu <zhuyiming@kuaishou.com>
> > > ---
> > > fs/ceph/mdsmap.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > > index d8e46eb7e5eb..450a4dc9662e 100644
> > > --- a/fs/ceph/mdsmap.c
> > > +++ b/fs/ceph/mdsmap.c
> > > @@ -15,7 +15,7 @@
> > > #include "super.h"
> > >
> > > #define CEPH_MDS_IS_READY(i, ignore_laggy) \
> > > -   (m->m_info[i].state > 0 && ignore_laggy ? true : !m-
> > > >m_info[i].laggy)
> > > +   (m->m_info[i].state > 0 && (ignore_laggy ? true : !m-
> > > >m_info[i].laggy))
> > >
> > > static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool
> > > ignore_laggy)
> > > {
> > >
> > > base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
> > > --
> > > 2.55.0
> > >
>
> Good catch.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Applied.

Thanks,

                Ilya
