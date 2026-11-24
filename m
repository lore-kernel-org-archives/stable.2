Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538006;
	b=zH6mVVkxo/DvxCaRdyAoNset2MK6hwA+hmHZe+ysVRdD6kkZ1ggqYvQ6LcM5YCja+VE2
	 tNi3FITmZ1Wzx/uIsKXR7QkSbfIKPGdAo+VVKto3QI8K494Ea7/HVW5n/LxSIyzRTQ6rH
	 RfiIN21DF9+uuxUeXgOWKUo7vUoQR2S+hZbuxCAh2ZShYW0LY8l1INwSlfM3oZ8XyFU9E
	 /VEDW5X4Hpvrj/9vj+GdI56xnqm3pn6jR7ZQoiU6RLGRmW2ZmInnCoAbG/Tv5bl42/wXk
	 PLKnCI/V3cuXhr+6swm8b8J3/uFWkzGRvFXezeFsLWV9j1EipZHr4/Zbrm1J+3oAjmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RWL8USnmTy+KwJMsv1mm6fJtCLW5dOGP1PUWvK7nhKA=;
	b=NI91otnjH43mH7EzllD7TBDcQHcK9yuw49LnMvkrn05VjviQEGBBpyQBO/m05tCugDJg
	 trvv43Z1KGHS+mKBtQX5I148GooWaIUBaW/tcH6M0zF4/7i2Qum5ceDCIWAE8ae6F5IVm
	 aowZ1js0XDXyWgVmwdnOCe4UfpMkj1pD6K/IjRfEJDyvuaZDxgWINrZj+JtiSaW/0UiCD
	 jOVi9jT3Sbonyl0yubxnyOro0yj7LEdu/3L326TW90U/FMEmKTJ2WtyAV9dYDWVPgks/i
	 GQSEyOl4vAdOwjGuLfO/JDbvsU15bF2lGNg6g+Tu/mHeekjtyYxy0XcqFwUUMUyVPNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AC9tfPIg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1175606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1175606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AC9tfPIg
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0dba37a7fso38496277b3.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795538005; cv=none;
        d=google.com; s=arc-20260327;
        b=fm9Ekql5DH1HdB7TjRB5cexeBNW56y8EhV7pU3T/mmJ5txIitKldANIAs0CqfaIeYj
         /kYSzYtJV2560buAOJUwBOljBBkfnIwQtvgIbJI+JOFQS4F93J0JqVjUqg/x0MP5BbHS
         NEq7GJUmEOXsHaafLmSIk7EhBWsnz0E5dcWTEpKtctzhkbitJW7I55yXdbN79s1yHKO6
         mooq7KJKuTcAxSK92IQJA9NOEGAYwBdFnMG00QSzT9JwNS6S9sWvDR5iA7UpA2NPI0lA
         Q3OwOpMj0EzYLIpQOeTm/odxh8UEpDWLZ5wBjiGFTgSCMxmWodhdnw7lb1+IBOIojxcu
         9Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RWL8USnmTy+KwJMsv1mm6fJtCLW5dOGP1PUWvK7nhKA=;
        fh=XLQxvIK1NzBCTkjImLwTYS4FvolE2bW6GfFbiqe0vD0=;
        b=FBz8C8QV9036Rx1vpzlFh+Qb9xeOXdyXYbhjohhr9Oboqxnkqe6nDtnM/CzV3ZIcZ+
         TfqGzUUFw9f0dYo79UtEm7rE31diYWeWv+fr3VRbty1yRdL/pcLH3LEmRdnv0K5SZh+A
         CARLWZr4GalO0oc2J3RAHfA4bA6bgh2teMugmKQYC48810maGeT3H8ppiGUooCxE/AUi
         Pj1JHIYAGZXPNsvqt4QsAAyNKo+/a9ERvUS0xSUc99kFiqgqVz2flcPo9dyJUpm4iADc
         Rau99of4CU644LSiu2wiJiXAwjGfEFD+YsnOaB4ppONVNuEpFkNpwyDvvw2QMiW2adGW
         IFtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795538005; x=1796142805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RWL8USnmTy+KwJMsv1mm6fJtCLW5dOGP1PUWvK7nhKA=;
        b=AC9tfPIg7KPBstpG6dU6bq41mFEkF3AITSlk7e7VcDMnKx7o+njbxt8BBSqqTn6FNX
         t+BZ+6X+jXP7bF9KD7JKUu8R4e8PAAuDCmZg9YHFbHVJaQAgvMfD3gyJCAlo4Kmxci0o
         HjmOEBAuJo+dLXhwTMZQ4DoVmWAZURwQF1WYfqpk4yWuJ6V6d32cjiNzbOi0WKnEd85V
         ipaHnHwiXN22FVXl9t7mlLPh9tR2XrX7wL7BKhTM5aVLxXOD0VU/h27vtYXWmTDBDEZ9
         QornJ19o2ihLpH3c9HPbRnYf3xi6JTPfKqlPDLmLt8EOm/hkSNI/1cyy8YE0cKWCLGwj
         u/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538005; x=1796142805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RWL8USnmTy+KwJMsv1mm6fJtCLW5dOGP1PUWvK7nhKA=;
        b=pJIr6qAAK3uXPCVnf0DAwH393IlrlGHZ/POKZsvR1TJQsORR2UwJZfyQAV+wCc/PPh
         zX2r4bp/kFsK50d03NOo0fQlpoABf5CGmaE9tP8lr9zJdrxqWA/alU6PMRCxn6MQycX1
         KXs6oS9HA4n//PpeLbgfpbawviLDnn0CyCw+QnBA3MXmk9PiAzX4HECDRDXGWNNuLOLE
         z40nfKk7WncWusNxd5NCdJFMLoMVH2r3vsMNE0Gl6S3u0BJLciyG4ro3QN0FNG4wK0W+
         R8caKqpHXZbMd/23sKXpjo9BGFGUrk5+gQsdMlFXpgnAm9kMCaGpUW9mZkfBy6tnv/OV
         zdtQ==
X-Forwarded-Encrypted: i=1; AL+hErHRN6j43wYD4mHFAm2pDCoYVnACY4YnwT2//8FP5ihdeb2yNl7OsVuqKpLq4dtHrebqalVXQis=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cCiqomiXrWMRX+Ihzi40fAMYpV0ud9PknRxXkkpmCJrGYUb1J
	t+jycnrj5pkh8Qg0JDnHeicPdvVd7yOzAViGD3AhRia5ep+cfy9L3aKY2nCvvhEH9FZxloEUpEn
	EuWn3j4QqYxhZCaP1ah8fIY1Jr+mNsu0=
X-Gm-Gg: AZFdTZdd2/+/0cfQgATWGv9m8rNCtEnsKbAt0tu0+mgMjCghlM+YCMFefQW/V05mf9k
	TKLoJM3RjJ3HIFoqs01TXojDfmUEKTT5MbXa05hlgkg3RVqd8coTXa6d1zUacYy2ByQjmKVrc4X
	z/oVBOyqDmTpNqWEMQQGUPeyT3/QdT8/Lz75f4y2gBUXw+hOyWB8dwAjmBIA7H314txRr4FARen
	KV0UagCddL9g95ZJTSNCrr303ZbnVKZ8Qn54vUqy6Pz6iDjtgXgZ/b3e3ZK85uRHiedwsatIe07
	2T0roxM7rmmqqRh0BE6ESIa1Cpi+Z/7N7RKgrkX+ayubVcb+V0Esb5O2VC3XlF7A4AiDW+3Javy
	ixf4GG+1LgJhIxwDWd3O6WBxCsB6KbYwQVpQp+p/9FMtLnIiyEC2QsDhn7F1XFO/p0HWgrrhSym
	f3Qo7IT0fp+V4=
X-Received: by 2002:a05:690c:9a8f:b0:8b4:dc8e:2e6f with SMTP id
 00721157ae682-8b520514f25mr53029687b3.63.1795538004573; Tue, 24 Nov 2026
 08:33:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120150008.1144420-1-ekffu200098@gmail.com>
 <20261120150008.1144420-2-ekffu200098@gmail.com> <874id6cuvh.fsf@igalia.com>
 <CABFDxMGGtxxm5OyLiihbVLBJKihoTxtV2g-FG6rURdPWnQdwPw@mail.gmail.com> <87mrqyb3lc.fsf@igalia.com>
In-Reply-To: <87mrqyb3lc.fsf@igalia.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 25 Nov 2026 01:33:12 +0900
X-Gm-Features: Aa3M54pPy5MGws7-VwziFvwz9vT5ifSxWMpohqSuXzhnuGyopXjPnX2IMBf0Wcg
Message-ID: <CABFDxMGfVFFwcUYwHM1bmo53E+ZrvPvjPF_gnoxU0Oo7ZzkqFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 11=EC=9B=94 25=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:23, =
Luis Henriques <luis@igalia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Nov 25 2026, Sang-Heon Jeon wrote:
>
> > Hi, Luis
> >
> > 2026=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:=
49, Luis Henriques <luis@igalia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On Sat, Nov 21 2026, Sang-Heon Jeon wrote:
> >>
> >> > inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
> >> >
> >> > But inval_wq_set() can be called at boot or module load before
> >> > fuse_dentry_tree_init() initializes the work, so __queue_delayed_wor=
k()
> >> > warns and the work never starts.
> >> >
> >> > So defer scheduling the work until fuse_dentry_tree_init() sets it u=
p.
> >> > Also hold kernel_param_lock() in fuse_dentry_tree_init(), because a
> >> > sysfs write can call inval_wq_set() at the same time.
> >> >
> >> > Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidat=
e expired dentries")
> >> > Cc: stable@vger.kernel.org
> >> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> >> > ---
> >> >  fs/fuse/dir.c | 13 +++++++++++++
> >> >  1 file changed, 13 insertions(+)
> >> >
> >> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> >> > index da23ccd8685c..0d5d04df477b 100644
> >> > --- a/fs/fuse/dir.c
> >> > +++ b/fs/fuse/dir.c
> >> > @@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
> >> >  /* Minimum invalidation work queue frequency */
> >> >  #define FUSE_DENTRY_INVAL_FREQ_MIN 5
> >> >
> >> > +static bool inval_wq_ready;
> >> >  unsigned __read_mostly inval_wq;
> >> >  static int inval_wq_set(const char *val, const struct kernel_param =
*kp)
> >> >  {
> >> > @@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const st=
ruct kernel_param *kp)
> >> >
> >> >       *((unsigned int *)kp->arg) =3D num;
> >> >
> >> > +     /* Defer the work until fuse_dentry_tree_init() sets it up. */
> >> > +     if (!inval_wq_ready)
> >> > +             return 0;
> >> > +
> >> >       if (num && !old)
> >> >               schedule_delayed_work(&dentry_tree_work,
> >> >                                     secs_to_jiffies(num));
> >> > @@ -224,6 +229,14 @@ void fuse_dentry_tree_init(void)
> >> >               dentry_hash[i].tree =3D RB_ROOT;
> >> >       }
> >> >       INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
> >> > +
> >> > +     kernel_param_lock(THIS_MODULE);
> >>
> >> I wonder if this is the right solution.  The solution I had in my loca=
l
> >> tree was to simply declare a spinlock with DEFINE_SPINLOCK() and use i=
t to
> >> synchronise access in fuse_dentry_tree_work(), fuse_dentry_tree_cleanu=
p()
> >> and inval_wq_set().
> >>
> >> Do you have a reason for using this kernel_param_lock() instead?  (Hon=
est
> >> question! I've never used that before :-) )
> >
> > AFAIU, parse_args() (boot, module load) and param_attr_store() (sysfs)
> > already hold kernel_param_lock() when they call inval_wq_set(). So we
> > don't need to declare another lock if we hold kernel_param_lock during
> > init and cleanup. Let me know if I miss or misunderstand something.
> >
> > But using a spinlock should be okay as well. So if you prefer using a
> > spinlock instead of kernel_param_lock, just let me know and I'll
> > switch in v3.
>
> Well, I think your solution is correct and it should be OK.  My question
> was mostly a bike-shedding question: we're using a lock that is defined
> outside of FUSE, and that doesn't seem to be used a lot elsewhere.  On th=
e
> other hand, this kernel_param_lock() was likely created for solving
> problems like this one so... yeah.
>
> Let's just leave it to the maintainers :-)
>
> And sorry for the noise.

No problem! Thanks for looking into this.

> Cheers,
> --
> Lu=C3=ADs

Best regards,
Sang-Heon Jeon
