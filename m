Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614A175A86
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513746; cv=pass; b=N4vvK51pXXucZCVgoJuJ3Y8lUGw1vnlpd4hB8o+f+o8ZBEJVxIhbVqygciFp7NmnrVtF8lDQjGNksG28yI2TXCkFLU45dlPul89l5dbMYPM2X6RpxARi08NiiBKSTdT5FTbQJUwIwl6SHtT+Fq49gFj1Nb03mpLJBQZtdQ4MfJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513746; c=relaxed/simple;
	bh=KoIqLl9ia/cQ3vvTGufqzPvmoTqJlnriFaNn4bzxdYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrHbZHv1e3S937J4AisFB5mLoEcI8pjd6tw2Tw6AvUX6tZzmVRoLXT5BC154OS40KVtrIxcL+5FSW0C8i6gkVmE052+oJaI2yCpRgcAXgI8ReDOcFSU8Mz0KA6/yV07FRFW/lpbp4ZMRlvl0U0eM88rF6CtpHoT2b7Qt4IAwUhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNbtGWt4; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNbtGWt4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so2149a12.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 12:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780513743; cv=none;
        d=google.com; s=arc-20240605;
        b=NpyYHfRZ65Osf/TcB+f9EOzTsSIYSiOZWKO7XZY8ho6+rLM+Am1shajAT1XbpqPm2r
         PELJ2vpCM3D8EFtf+CSSTh0rzJyieGdT3oFJH7bGy5ej02Oap/F1zX8ENA4DauV1nXQH
         gF/73uU/xp9yz2FRgN4UDWNNJYOIX6PMfwY1FBpbrrA7Qcgj5pooU+4RGkRl9cN3S1iX
         JsyofbTr6NTZsWui/IHSEwAY1i9T5g3JIqeMv10pdx9PhLhPOgiTA/6TBp72tXI49QWB
         LEGSfYL5TkeaPE/eDsNW3cOT4RALhCybTfg12/WzT65iCltdBZeuRMMtG8YyhVJ1Eqs7
         wKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        fh=nvxtnlXNLncB/HOwLE3AJfRgHHZP42fSN8+8XOxK+ZE=;
        b=KqkfIBx2cGCEla2TGjChcQyDsI35rJNxkMvBdjljEkPdk9yH0ScBbdXlWcjVo7X9pP
         OZw2F1ruONV4p6e7DfyZq9Pr4owBEusLZDewyREafB64s3F5YibWNPB3ZZK0+iEa8+1A
         ctsk3d69C6Fb8JpLP0BbcHHCVDwRSftilHB978t4IO5r0ECwoaV+1mfLNCPBu+FkguZd
         fQKexJOw6ygAgQmvIInYDxSqYX/+Ln60YxGw9JxFC1KuGE2v7N91Ts7BADaNaUKlQ0nu
         Wvd4mken/2B1YKVor32LxaReby+yS6wPHwZzSYDXdcRgZ2V083LSbOp1TH3V28qATTZ8
         BwsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780513743; x=1781118543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        b=WNbtGWt4OPEP9Hw8nEQLxptZ0p9loW7dzXqUeN//FXJ69QfCltGjPdVAnnEcY2RM6s
         gmCPqHeQ5+rv+EXAkDZsYrSFLA9ugrKSFAltqSZ6wSiJ8lJDJPK33thmVRdKv80BIQdE
         hjYw5Cw3BmTV6rzFvBxDpEhwjr+3GO4jLnMtExTsn0B0KR1savlK+saNxl+u15co669F
         520HFKfcqWFzc96nBVhWTeDh+UYAvpmiCPll8V9mpFwvPWzTprgOJ1NpNJYEkLXG0CyJ
         oFG7oMBQkTd5QVZ4Q4sAVHSoEA3P3u/aEaeA2ma0VE8guZYr4fiUiW+w+Q8Hw5TCyqu+
         sVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513743; x=1781118543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BTBjbh7gzisLP+SJ/i8ZyWlLdf3Qeg+7FNqKvmHqeM=;
        b=aTEy8EnCewAt7Nc45GoSJknr0wjDjj7lUPqx1PY4h0hMmXnGTFEt4SH+CFPTIPOXDw
         ALS5MLppfFPe2dj1D+yTyZrpTwm+BeZmJ4SoDELWaXrVZzlNgMgZQMFU3iGC3Pw571jh
         hd4MZYXn6BOGpdx04/wtc+0jyrxqFpDQvokk3OxRVOmX1EuZh/cE/ZUa0xfZWb6gimqL
         0hcXyPDcI4SHm4okiyR1vtutQtNaEfzA9em7jk3H7wUhpjooCVFpG3MyiBPQ544HZY+T
         K1gMoPeN+d9TAidNpOGMjH6e8yGYcKfRP/p1/ySO1FRykcbYHUqK3CIRuMSI/feFg9sj
         tnQw==
X-Forwarded-Encrypted: i=1; AFNElJ9lHAoPSoTMCIRHQHMeisLyAEj+mZdBv4ODcrFLvhx6sumr1zxuYl6hNF2DodyrnMuKk1FCs5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvZT8Sh53hJwpHRQfsJkyw2ZXPc/YoH2b7AoFMLM8MYEcq9SW
	mc+Nd1QGRpacy/hBsC8x8udVO9tIqYx+kPfaWgbtLo4vSJmVacCiFBfH5f+CZnm14wrvI9XX8Eg
	GY7hWtiwgmmgNj6688ptxnjMf778G2ij87/J99gRd
X-Gm-Gg: Acq92OHvQn2cddIuJwVcgk8tujvshjCmsPoLrwt9xLvUWep4KDuPxb2LtnV9cjWRyOt
	aCAIMgHtDFpkFFAOX3ZpuBsh7TasYccUDEpGEPfhhn8lE4SVfagz1puGOhkjlS0w8R85tHzTv7z
	w6hsqspvhTVPtdxtptWJ0QPZYvVrC/a9lU6hZ1LRLpQ8fLjA6BidXawrYhtiglDuTMjuHPL2UvJ
	1UbTHKVBofd+Bg6d/oRXubRR2bCFNkxxytQyHJ4NY6XArHVMzz1clPWZmIIxmK33S9xI3hwqwJq
	FjyZMMnxR7lymlDrXsoe2N2jY5NH6s50VmGKmNMOfmTb4lLp
X-Received: by 2002:aa7:d294:0:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-68f12dc72c7mr5570a12.7.1780513743150; Wed, 03 Jun 2026 12:09:03
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
 <20260603185324.GA2636677@ZenIV> <20260603190225.GB2636677@ZenIV>
In-Reply-To: <20260603190225.GB2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:08:26 +0200
X-Gm-Features: AVHnY4IxxlNTB4Lk88aYUMiy55vdsorSgUlDA_6cJFrKOhsQwOKgMzOyo629T00
Message-ID: <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 9:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:53:24PM +0100, Al Viro wrote:
> > On Wed, Jun 03, 2026 at 08:46:07PM +0200, Jann Horn wrote:
> > > On Wed, Jun 3, 2026 at 8:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > > > On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > > > > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> > > > >
> > > > > > Fix it by taking rcu_read_lock() around the mount::mnt_ns acces=
s, like
> > > > > > in __prepend_path().
> > > > >
> > > > > > +   /*
> > > > > > +    * Containing namespace.
> > > > > > +    * Normally protected by namespace_sem, but there are also =
lockless
> > > > > > +    * readers (which must use RCU to guard against the namespa=
ce being
> > > > > > +    * freed).
> > > > > > +    */
> > > > > > +   struct mnt_namespace *mnt_ns;
> > > > >
> > > > > Umm...  It's somewhat subtle - at the very least you need to expl=
ain why
> > > > > there will be an RCU delay between umount_tree() clearing that an=
d
> > > > > having the sucker freed.
> > > >
> > > > Something along the lines of "removals from namespace are serialize=
d on
> > > > namespace_sem and guaranteed to happen no later than the active
> > > > refcount on namespace reaches zero; freeing of namespace happens on=
ly
> > > > after the passive refcount hitting zero and there's an RCU delay be=
tween
> > > > dropping the last active ref and dropping the passive one that had =
been
> > > > implicitly held by the fact of having actives", perhaps?  Only in
> > > > more readable form than that, please...
> > >
> > > Hm, like this?
> > >
> > > Containing namespace (active).
> >
> > Umm...  That's actually "active or has _just_ dropped the last active
> > reference and didn't get around to scheduling decrement of passive refc=
ount
> > yet", unfortunately.

Ah, right, I see, because the mounts of non-anonymous namespaces are
only cleared in put_mnt_ns() after the active reference drop.

> > Hell knows - "active or deactivating", perhaps?
>
> Note that "active" in such context is easy to mistake for "active referen=
ce",
> which it definitely isn't - it does not contribute to active refcount.
> Mounts within a namespace do not pin it - it's the other way round; they
> are guaranteed to stay live until they leave the sucker.  Anything that
> hasn't left by the time the active refcount of namespace drops to zero
> will get pushed out (and killed off unless there are other references to
> any such mounts)

(And there's also that weird detail of how, for anonymous namespaces,
the active refcount isn't used and AFAICS never actually drops to
zero...)

So I guess I'll write "Containing namespace (active or deactivating,
non-refcounted)."?
