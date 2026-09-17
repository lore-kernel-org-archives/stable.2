Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472D37EFFB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660048; cv=pass; b=RkkGRhn72jqMnGlLOqdEM2/AZ8HgE2hR9nswq2cTQYTdqespVHj4Me84Q87kd0aAMZja37lNEYnuUQuAlGkz0swI5a/+d/qjzr8EJv+2LxAguJqrvSH10loUE/0IBNUUwOogF4LjPmQNn1iOxZ/6w4cOkWUBGzTb5TA06X9tLpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660048; c=relaxed/simple;
	bh=HhKgh+AhoovE+nLXKxFmLwpFzc2TTxLCaPaNRYCrGXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+KOUS1AaN4dLl/j56WdeWNQsezFzwX1pUMnsmFO7S0YE++v+62Tv9PVI43kuXFEI76rWa8/cSopXJgzxvrqmj1hn2ZWabfOt6muzw3XddgmfEyDwFhJoN/Un8y/SQzFNyjN8sZ1lRa0l7GnLRQGCCwAUxuSsVJFxptBjqChXCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPH7Kn5G; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPH7Kn5G"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso1390305e87.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789660036; cv=none;
        d=google.com; s=arc-20260327;
        b=ExsbO0p2d9Ip7BB5NN/BjfB388H2X1X4ebf81hJz1HWCvuyAJCZJotTfnWcSJTP9NY
         UTkPCDegaPLbcPnfe2j5rT2xZoToOgnGBFMSc/46JvNb2m48LvtJANhuLHsfSBtk6Lkz
         FhakkfEj+FJuUZFnXmts0vQAca1OU5oExEie98BoEoHg17Why0TvZneqhXGjeFsYt2MT
         Fi7o5HuEiSsaeCsi5QHv08a69mnHPllZ33/2SuMxgZ3Dzcc6RpQgJsuwDvvfwLooc2G/
         qwvYlfq2YUdXZQsauGAzneQ8R67RaknApXJkXnrLZvlxDPDMJ+uNE21/uCHIjf3FaXFK
         npww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jzy+gQGDahxjRYzrMpnyvQ4GBuSr45Ef8jvJeyFAvyM=;
        fh=pnz0xcNfA+5uo5q4ig5+lQlD+NoZRmhQ/oAtzyrvrf8=;
        b=lJW/b5y/RPj270qDSphMoOKAcwwnfZ3mscPO/yFz/W7gHHWCzqSqVfvZHydgMxVKhp
         uhh5KlzYPgA7RoUueDLmqjdZ0cQxBPnikmcRJ5//PcjHjDOBTNLuKskzqZaLL4TYB1JY
         VPWEvEqbFIuPrek//kG8haiBt1ezIg41GodyxeTbBs7qXhFglzdS19h+pqJdOQQlgeGV
         MAyF0cHX11QRsc2VsduihiARhp0OUbB3uyKat+AGDqWGhiR6/PKAOQjhgvINrl0lY5hU
         BseDO2agkdb1HrUkQJNccihSdVypqWOPWh1r/488LOlNfoNz2bpaMWFq9hLxOMQrWuQ/
         Cj8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789660036; x=1790264836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jzy+gQGDahxjRYzrMpnyvQ4GBuSr45Ef8jvJeyFAvyM=;
        b=UPH7Kn5Gc2k5NVCrqN4WeOufJSlpZ0TE3hCzj/ldttsZGZq9jp1U0DQLBq6Mtsm+oa
         q93kPN4FQdFYjocqX9S+IMHHNEnVxrbkcQ8OqXrn2H7O/J77oZRbHjdI4Ae0WBusAqpp
         Hdlg9wkikrS3ZgmZPHx5jWzWbLBJJGxW6bhqWIWDdA7lY1DNlyX1waPlZzSqUC48kxE8
         qe3HwkoliuyoYNKDASyiwJi6UTc5X4Dur03+KAkVPxWEFP7C/YFdG2uDKfbgfFkcqjej
         rS7fR9SMTsIY9HUnjvNVvtJ4Aq7rsauHNksjf0LJciyzd1qY1Ri5JrPXiLlEHlNAON1o
         QmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789660036; x=1790264836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzy+gQGDahxjRYzrMpnyvQ4GBuSr45Ef8jvJeyFAvyM=;
        b=ilxWnYvBk06B/poFdLJfbstyWUL2n/P5s4eGWwbqh0dSQFh+wtYoo15dr4h57cS9Hl
         p94spyRV3PB67y7HJOLgkNdPjbZathYVOcZr+K7vxQEuU9Y5QvKcMhSuCeUJlv4hyTxh
         OPVLZVJGkfuXFTMgEUb/WxONhUAu4ES1w6PvMu3Z+r9oOvouSXVcpo6FE2QCa3NDRLTD
         5SeYvPnwpEcahu5YycIJ+SZFrXbdyKPRLyYNdVOXM8BfaGJJnB1Yn1ctuRaaiqnZto4b
         Y7XvI0+jRhOYAROcNi8kVn7oJYNWiX+vP/inboAGmqBDb8AZ3UneAzkqEzfu2c+2pgVq
         74CA==
X-Forwarded-Encrypted: i=1; AKwUvBxTWhNHbSFXLXWo68rZC3Ef3urL2FGVw0e5zyUlioB6aD5v3ZTM3xVjfyDRr2DgiQdTCr5FnIw=@vger.kernel.org
X-Gm-Message-State: AFuF++kbj+02El2afIuaskROv+2ikEPZDIcvGrM+b4oVO/vyeiXXADTF
	8hRaU9zflfyFChdPJEHVQC8QmYCFeFNzmU8KHOuVWP8ZR6FkwNxXb4EtPCSX1nuvWNyX+aOBGCg
	24/eMdy+qjcudTLqQTTXPFGlTrJveVa3vEL6F2eQ=
X-Gm-Gg: AYBFou05DRzxWWDW6oSphgR4Ii7lwO7KFxlrJPjLXpHZp0nLIgqBqXG1OVKWPudsaXM
	ZpriY/fr2A3ArkvlF7Oh7cmdYrCZZGEa7hd/qp0PDTb6jh++B2SAUJ+zMIfn/4ePPqBTxhSRMol
	6eYXKh2ePHqeQKMzIgOL1MUsqwOFz8znxPTSPmo7zOwz2jTSwY8Lloo5yzJrgoajZXsK3n8lE1/
	5tgcGYi+Jk/JkvrAXwWn+NZcQGVONHqHlqAiZ+Tv21HeMQYQhBQ6cvgB1/P7q2RzBtwXhQuipxp
	Z6MwNTJ89wUASLOCAm9gqDxu79bpRtM558fleEfoMlT53AO6CH541Rdt
X-Received: by 2002:a05:6512:3ba8:b0:5b6:183c:5c94 with SMTP id
 2adb3069b0e04-5b8b66525c1mr2236156e87.50.1789660036136; Thu, 17 Sep 2026
 08:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915195223.3331909-1-qwe.aldo@gmail.com> <8eef80c6c8d21e863c5a3721b1ae681fc4ccf54f.camel@dubeyko.com>
In-Reply-To: <8eef80c6c8d21e863c5a3721b1ae681fc4ccf54f.camel@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 18 Sep 2026 00:46:59 +0900
X-Gm-Features: AcwNN1W8Hxz9umrd0xiz0nxXV4xs0ZDavlInPR_CBX7SqfB6dwEpospt6ft_-2s
Message-ID: <CAKFNMok804k_g2CHXfrn0LaOY38r8FtMnAk1kRc3YeZ=omCoag@mail.gmail.com>
Subject: Re: [PATCH v2] nilfs2: validate segment number in nilfs_sufile_get_suinfo()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 4:06=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Tue, 2026-09-15 at 16:52 -0300, Aldo Ariel Panzardo wrote:
> > nilfs_sufile_get_suinfo() subtracts the caller-provided segment
> > number
> > from the total number of segments without first checking its range.
> > If
> > the requested number is greater than the total, the unsigned
> > subtraction
> > wraps and the function may process segment numbers outside the
> > filesystem.
> >
> > Cache the total while holding the metadata semaphore and return no
> > entries
> > when the starting segment number is at or beyond the end.
> >
> > Fixes: 6c98cd4ecb0a ("nilfs2: segment usage file")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> > ---
> >  fs/nilfs2/sufile.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> > index eceedca026..573646c5f7 100644
> > --- a/fs/nilfs2/sufile.c
> > +++ b/fs/nilfs2/sufile.c
> > @@ -870,10 +870,14 @@ ssize_t nilfs_sufile_get_suinfo(struct inode
> > *sufile, __u64 segnum, void *buf,
> >
> >       down_read(&NILFS_MDT(sufile)->mi_sem);
> >
> > +     nsegs =3D nilfs_sufile_get_nsegments(sufile);
> > +     if (segnum >=3D nsegs) {
> > +             ret =3D 0;
> > +             goto out;
> > +     }
> > +
> >       segusages_per_block =3D
> > nilfs_sufile_segment_usages_per_block(sufile);
> > -     nsegs =3D min_t(unsigned long,
> > -                   nilfs_sufile_get_nsegments(sufile) - segnum,
> > -                   nsi);
> > +     nsegs =3D min_t(unsigned long, nsegs - segnum, nsi);
> >       for (i =3D 0; i < nsegs; i +=3D n, segnum +=3D n) {
> >               n =3D min_t(unsigned long,
> >                         segusages_per_block -
>
> Looks good to me.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Hi Viacheslav,

Please take this directly.

I also agree that this change makes sense, and my local test results
are as expected.

However, please drop the 'Cc: stable' tag since it does not cause any
fatal issues at the moment.
If a real-world problem is found or reported, I think it would be fine
to request a manual backport then.

While acquiring information on out-of-range segments due to
wrap-around is indeed possible, sufile is also a metadata management
file.
When accessing out-of-range areas, it simply hits as a hole block and
returns empty data.

Neither memory overrun in user space or kernel space, nor
out-of-bounds block device access or information leaks will occur.

Well-behaved userland tools read segment information based on the
statistics obtained via nilfs_get_sustat(), so no problem will occur
(the difference in behavior was visually indistinguishable).

Therefore, I modified the nilfs-utils to perform ill-behaved calls and
tested it.
Although out-of-range non-existent segments were displayed as empty
data, no critical issue that compromises kernel stability occurred.

At present, it does not appear to meet the basic criteria for stable
backporting, so when backporting, we need to be able to organize and
demonstrate the reasoning why it is necessary.

Thanks,
Ryusuke Konishi
