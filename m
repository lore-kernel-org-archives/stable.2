Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708130216D
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252337; cv=pass; b=e09vTOFIV/TA0nCS8whD/LfSFXdFw6A/zzSFpZvIGNIoRSMjOK/87mdQpdHA9PMoDVJAJJpuFxwX3wqBVKUc1Hb2wQikE88jTl8zBNw5EtVAyqyBh+i2/NJuZeonqZ3Swaf29EcJU2ECeoxhm0699/ApeZ4lgZknHkSq5+zmgws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252337; c=relaxed/simple;
	bh=bnjkPkEAdPmINg1RA9oDgANNlvYD2LriHvYJDibwokM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaFYr9G++kPGgJDdNDXUbHjYplSpsWu5kiESJI2LxtAlFYJKFV746TZrWCsWiJm9S7vKD8pnCp3T9twaEAEVkomv5OOZmBJFJecmbJoeZf46fbSUZiIy9wOL3pVUQUyPpwnR1Kq/3AI29h2l5d9aPKyMM2ZJsUHMS9gkZE96bu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcnGGOVi; arc=pass smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcnGGOVi"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-66fd0af9eb0so343181d50.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792252335; cv=none;
        d=google.com; s=arc-20260327;
        b=CYAYh5Fwyz+s4EOwUsA4iaB0TT/+yp8XoGco+/M2wJYSWN5cOyCfpJvPTXe5YKxNhi
         Wi/lxU4Jo1/RP9E73ze057ypRcQ/m13yhrTeGK2t9c0koesymjOgIqpncKtrW44WTlvo
         YfU6YSmfPWERZlgSwzTyv667R4981nRj7TbreKNXM6vOj1ZyPEc6jR8TJNh/CmXIaElW
         w4gR7ARpyFu8NgxQ5P7qAdzT76WSPWrkUh6dYmydNNl/K1LgwUNZWI8yGjoG6fKHuTSk
         mEU/bqdQpCRtjG63zhzFFhcLRb7VnZvOH3A480hUxNw5J8yudB2ABydobljii1g2NA7I
         bvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLXPXIfPNuS9IvRUvmHmUY/S7grY8emZfJl3BOr7iEQ=;
        fh=N9E427yyTx3PlokS1Hkl6O24/Y652Wl1Yj6I7SRjDUQ=;
        b=JJHRFryQeLdwTBMcB2K+TO54ciYRcNs9ZFIIAD5ZO4n22QCQzKyuebcCpYQhmJlBrs
         G9lK3CXuglBUkGJ2iVLbN9/EhIHaHJkgiIzovZ55gvtmG/LDouHd+91csw/iotCuvClV
         /bZGIpmgeJ0dL54ZddRu98A8WKxTqOucpCr4AGADiY0+k2H3CiDHMOKKtgQ4lCUjto4p
         JLZm9xPf5c3FaidM5Gv8aGkbctB6kc58tWjTRdNYRi/YD5vTbND7C3jfeDcYlczW29Ul
         nHNQb9lYi8V2eaR4HSv9bEnkhpgCr+08CKaBolpKKkdfFjcnX8lMHQmLpft+KDOs3Tcw
         heDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792252335; x=1792857135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLXPXIfPNuS9IvRUvmHmUY/S7grY8emZfJl3BOr7iEQ=;
        b=dcnGGOVi2qMPVzLdYHUiLAoMFDYdVZ09tbeOAxxtDl76xrsp1eKZ6E+AT8ZSGq24Wv
         XXy8HYbgaRiRLS9spqVU0mQJWDZgU8THa93DyqTLtg8BrwuWjktAuY0nLLsn2Agb0gSy
         BrN22SbRLT/pv76V0gWm/gUEPO3o4EfYPCpaRsNErREq/4a8S3DCRf+Cjd5W0NUYDQKq
         iQAOsh+1jsPQv0R5NEp7G/8zIZt2UGHT0nIZfSCVtfWklt5wguq7tHH33ajgniJBEpCv
         LMS4xrjr+ryVFvJmVCVagwm+BRKyGXeEtZFrd0fyCrDST3CmiIwizXjsEFldakr4NQRl
         K84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252335; x=1792857135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLXPXIfPNuS9IvRUvmHmUY/S7grY8emZfJl3BOr7iEQ=;
        b=qhhtPPknX2YSua51vAqfdUQrc20Pp1bB96PGyqqdGASVRqczsMNPxriV9QInLbDq9k
         K71NyXiSES61IL01Qw3nhUKZ04OVwjLj4xN65H4RpjV2mBckTs01UaFMubpCcETuWqW3
         l1qtO6xXwOsrFa49d+Ka2+RkBVUqWYThCGNMIFzDXHkk1whri5c3thefRwmAnGmuOe5I
         0FIEIbh+b3Ae3lF4g1cmqZNijstI0jFLXTV472g0Q+2MFA+MzFaGIOLpHRky2pJCYpot
         zJ7avydPRF0O/TUTiJnvo1I6eELadPKgWQpYd4eZWUmp0PjLqfSCvOQ5WK11pCprgWsd
         TilA==
X-Forwarded-Encrypted: i=1; AKwUvByg9nGsZHtn+x8xT0CR7zSKj5JlsA+sPlsntncZ/OuU/2mJ2wx7ZHkznWrBVgLjt0ZX5hTKNFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4rAM/peZlG0Ql2bMvVrsaQOAjc3YSnGJJV3JvIGkRftbNQZ3+
	Q2/bFb16zTOSjL7m07apnFFnDNyuFR7eRBsFMJHX2U/GSvFG9amm3x+oD6Utijs4QAlRg58dqVU
	cXiTe91b1ETduFLkmC03AYCqJEJvOKSc=
X-Gm-Gg: AYBFou0J48UA0yGiU3L8bsJix7C4nwZO1wv3gUHGYk0PRPWW9rzeuUFem08bq9Bj1pf
	3t0715KBUvP76mI+kIDJEC1bYapgmj1dZYpSFLd0h55h98fD2s5Cx+g73U8Tj3LeQ4DRH2+tQF8
	Nfdk0Us4tm6ajz7tDeUsnOhRUcHEBdQd4O3/6WpgwtCOvJQU8Vji6Bc6/58r9PiqsMj0CBNq2/M
	EU2g4xqQBd2nsWe82FmZOg2haXidwWfdxrp6FaJ9SqVLjO5ZI/xn5yTl+srP5I4YG9BUNOka1gm
	rEQGY+/Gj/ExWrDyZpS6yUI7IUDSkgd3a30N12L9jEuIgyKTC0HU8hrPEs82XxuOPSjqJ11j9NH
	9ZPa5VWpCiI/FllFo0h2kJsFo8AqeBHWHbSE=
X-Received: by 2002:a53:bf0e:0:b0:677:afa4:a210 with SMTP id
 956f58d0204a3-679ca8c84e6mr690917d50.95.1792252334855; Sat, 17 Oct 2026
 08:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015143426.17620-1-jianyungao89@gmail.com> <atF8f0Jdb8OMcE9I@aschofie-mobl2.lan>
In-Reply-To: <atF8f0Jdb8OMcE9I@aschofie-mobl2.lan>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Sat, 17 Oct 2026 23:52:03 +0800
X-Gm-Features: AclHuK9hDBQvGLcT3mNvFowJYZJuyWyo9WXLFqaeSLdb5QJcwrs-segceXyoX-g
Message-ID: <CAHP3+4CM=ZjuP+S10T9wxcBOBt3tXH0ObY42fcDUm2pGE1gr6Q@mail.gmail.com>
Subject: Re: [PATCH v3] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, 
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alison,

Thanks for the heads-up. The Sashiko complaint in v3 is about a
pre-existing bug in dax_range_compare_iter() =E2=80=94 the size parameter
passed to dax_iomap_direct_access() is an absolute file offset
(ALIGN(pos1 + len, PAGE_SIZE)) rather than a relative length.

This is indeed a real bug, but it is a separate issue from what
this patch fixes (wrong error code propagation). I have already
addressed it in a separate patch:

  "dax: fix dax_range_compare_iter() to use correct size and address offset=
"

That patch fixes both the size parameter and the memcmp() addresses
(missing offset_in_page()). The two patches fix independent bugs and
can be applied separately.

I've also replied to Sashiko.

Thanks,
Jianyun

On Fri, Oct 16, 2026 at 9:23=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Thu, Oct 15, 2026 at 10:34:25PM +0800, jianyungao89@gmail.com wrote:
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > When dax_range_compare_iter() returns a negative error code (e.g. -EIO)=
,
> > dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds t=
he
> > positive return value from iomap_iter() indicating more iterations rema=
in.
> > This positive value leaks to the caller, where vfs_dedupe_file_range()
> > interprets it as success (bytes_deduped =3D len), causing userspace to
> > incorrectly believe deduplication completed.
> >
> > Return 'status' instead to propagate the actual error code.
>
> Hi Jianyun,
>
> I looked at merging this today but the Sashiko response stopped me.
>
> I do see you addressed Sashiko in v1, ignored Sashiko in v2.
> If this v3 Sashiko complaint is one you've already addressed, please
> reply saying so. Thanks!
>
> -- Alison
>
> >
> > Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> > Changes in v3:
> > - Fix the Fixes tag to point to the commit that actually introduced
> >   the bug (0e79e3736d54), not the one that renamed the variable
> > - Add Reviewed-by from Darrick J. Wong
> >
> > Link: https://lore.kernel.org/lkml/20261012144925.6728-1-jianyungao89@g=
mail.com/ # v2
> >  fs/dax.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 6ba50142eeb2..1f6a4fbb97bd 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -2261,7 +2261,7 @@ int dax_dedupe_file_range_compare(struct inode *s=
rc, loff_t srcoff,
> >               status =3D dax_range_compare_iter(&src_iter, &dst_iter,
> >                               min(src_iter.len, dst_iter.len), same);
> >               if (status < 0)
> > -                     return ret;
> > +                     return status;
> >               src_iter.status =3D dst_iter.status =3D status;
> >       }
> >       return ret;
> > --
> > 2.34.1
> >
> >
