Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794141151;
	b=s/z3cnkbjQHw9HMzLtyMxbm5/MkQJ31flRkTF4nB1uzHrMwV6680M4W+8RvxsL//a56M
	 u6nVtkKoelMpR4btnSX9Eu+RRqSqWkwbC430iKdkXhnF5OeTRi9zs4jVlnl/eX2dEe5uy
	 HpXWW1F1jDYEshW/kOlIxf7vvoyyVt885z8eVjP+fJjIp5QFv1iOgtXSDmupRPeewmQ7h
	 OzOH8lwjUS/PbdMiRH3i5w2SIqmrBjjc+bAYRbuon0fhBZGYERXsoWqXphPstk0jmKL6X
	 b8l2yDGZlUr1GM33sjBZRbNRaG0JAMYbE/Cdknfpok9NKQ/7ahmuTQrBtDRquHS4QmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
	b=EjGV6v2xCJqZeO66thXHq6UmWQC65y6jKJeNuV0mRmyx7TA2XhrogUdxJhnCAwJMM0wN
	 8XqV6eSwpAyT+lQsdm9u/ZjSnbKugjVti5dIakaPanJy1y5EfcdqYOG4D/zROI2QkVTpm
	 SvOdsC+5HKa2aByyK8NA4yRs4eYHcSXd8pr2bsVI6IkvLsDo7Bw7/vQiB89ed+g4Sguau
	 sz4HtArizBvJ5HO+/XrAuEkqOI1qutYfZiTa4CpLXCnGaWfiTxXv2XmbeJLPGg10CyXKb
	 AbOEEjp3FMk3cwOihTKz0kzXYa+uD2SqVAuyadtIfYKovmhe4U0UhLV34OgDh2RdyFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRwyiFCH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946D606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8946D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRwyiFCH
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36f6295304dso65183eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794141150; cv=none;
        d=google.com; s=arc-20260327;
        b=nywJLMGJKPKJJVM8b3ShOxsIkH25hoY0jbp9FkXDq7HGoqC1Twp/NSKL0ZNqNeJ+cw
         uxi2WuKqFtOzPnLc64Fr922VENnLEZsTvTJsGl4QDgM4oHTfB3qQKP3rhuOKy9R1rJG3
         63mPHicuyIG19N9/xMkdxrK5XMsY/EXNILV7+/x+rdu6+Rn1g6XWwAZEOYwDGszvGd5m
         ly5CBELZZFX05q9MXutdr0FUSeMC4Xdiz0fhWFooFHQLrZ08LcngiFwR4Ir8JzRC5jlz
         kXp2PSuqwNhr5w1fzwFmYK9BcF5/yGAkTnTLnz8M7MB0NyivsDYKFewO0/wQ35Rcj/k3
         HVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
        fh=Nli16DykjFS9MssyuQpUkklNpQVDDR0oBYeUP0EVG24=;
        b=HM2KAFFsNm0US9rcUqva2gtiIooyenUDfz7zfVvjwG8F0M7orqlKr5XVQ0Oct5EWNc
         ndQl3al1fIj8Zepxh1z//iZU5TjT8Gu3BhIIWk94MjIuG94EjyMDBB7BYi+Cx6xti7SX
         u3LF0yvLowvfEaLdyisTUMn6pbj74Y0b5uDNzLbnGpAT8lTfXN1YAuEtvxHEXT+6YlPF
         D8sOQHm+3dM1zKYn4VjtpSKyoEU2wCru8/cXFXN0luedi+KZU7R6tK65PS6a55VWC1jS
         UWr5xlQ+zPora2TwbvH4OcFIEgXT3XS2amtVDCZQnRznhJKb7I4M+RfREXK3Nn7PE7JO
         stcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141150; x=1794745950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
        b=VRwyiFCHsdY3Jpa0rIAYOhJl7wrp0P3/eYwNVbjsLivYJYE3+6CsRNAdl3rZAwftQw
         l5u5RvFU0L9kJpV7mJLpNPipOqYOlPZy9OGAwPTgFBLeRPct3RnmcYf2T5qREXEtRt53
         KqfGfsgZ0EYpyDNaQ0nA/Hg5HChetXfPD//KZ57e3HLLRlRXZCqecLY/NT8LxTR1+g1T
         dsJ7Q8O4LjHuPRrUj2b8iMSNN3z/TXAgAiS3KUqSTJ0DRjLEBZ8imi9fLzKDJqLxutQt
         8rPX75rYRvq4JgfVs79jcu8mz4NFugvxaBm50cBC35I5PpaSU7Lt72XAcae+nz6v4NNQ
         6XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141150; x=1794745950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWdpxBY5f9SrIiP9qlqTJHu1UmLoydUe6EBqvkilw3k=;
        b=S1k8QZ8JKm2NCCf3i5DMq+uw7viKl6TuQ3qUOXhhuc9zTPFT9HuwqNjxSmallDYw4s
         nB2gaYhx4D3p7jIXwT5YQ+OcL2BqXAdOIq2UVhE7jBgD7G8Ncj/GqKr9VZbNlwCHcm7g
         gFq9lxAH/EHAkUmp13VMNgqyugjD1WvsA2Xz/12UqCMx73ImBE/B2AUNyJGENF28Irxj
         ayOGTa23KrWe1EZuYM+5gKLGlDJprBdCLsQNjlBVNeLiSNb00qCpzx848oeVzd4Okzat
         KvtVigQwuEGFOfVvLKVsp7J+OTacGnlyE8kdJqyD7yXfg2l8tuHPqCpujI0QZd//5+E7
         PF1Q==
X-Forwarded-Encrypted: i=1; AL+hErEwkU0qp4NKxQXxlBIfZgsTTwoVO71DmIoJT9le9SSJIjhShROdpmZa9zYCneTiRk0rJzLduZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b760u0RyIzccQuxcD06DoPucuVcsG+JfAtsUfxEcLhX6UmQt/
	EYZXHYyt+DWZG1mq3P3zAp7smNV6Sln92FpikBWivEmzIQptfG3CeKFnEE1pyzpdJKJRNnKKMYc
	AkmqPT3INaxwjLohnx6JprMbyt/tRRqk=
X-Gm-Gg: AYBFou2cK52gjXN6ZlgJmr/QUc7l8QOnCY+xhKF+rBA6uRa6m7OaNNxxWbYFBPdsgMb
	u7nDgEhHolvXh3SgfoX/je+6uHjUMgq36RfRYXHEQIUDAoH74Vonp0++GZKGgvbulLAUvBuLmtt
	Hd70b+2UjXjQiaO9xXjgJf84utnvDyFhCJKIL7bfjJU7SSCXMDhZjiIeC/lrglzgpWm2IVAUkWp
	N55vqXBl0SUu+ZIcweGL0bKrg22S7veWF4UEPiGPeEylOHRFsXFY4mM3MZ0IxGQCUpcifiX5n1M
	biDET4ELIGCWRaKbsrSmGolseTx2EtfI3lM2Sm8a3o/lR+CHx7HYmepEDYTqGb/rMf0mgh4qOoW
	n7/Sjf+/+2/hCV/47PMzZ1XYvYc7bH2eaKKhBm23s+2ByHcRvaGTP+YmVWwUwMspOEZKsmOoHmT
	kDU1u/XIAUKbnUYw==
X-Received: by 2002:a05:693c:62cd:b0:370:ff2:f78d with SMTP id
 5a478bee46e88-37256614c62mr2989725eec.8.1794141149593; Sun, 08 Nov 2026
 04:32:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108075848.257145-1-hj351016@gmail.com> <avBrPjvw_5EH_W5r@kernel.org>
In-Reply-To: <avBrPjvw_5EH_W5r@kernel.org>
From: khj <hj351016@gmail.com>
Date: Sun, 8 Nov 2026 21:32:18 +0900
X-Gm-Features: AclHuK-wkJTST75ujvma9IGtuUWYkl4oaDisXKEz5d6-YrVvIkqMRKq-RLJUzHw
Message-ID: <CAGr5VtNphPZtGC9MSLQcMCUWBKUYPC_ufqpb1YZ=WBPm=oZb1w@mail.gmail.com>
Subject: Re: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid deadlock
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, renamed to 'flush' in v2.

2026=EB=85=84 11=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:29, J=
arkko Sakkinen <jarkko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sun, Nov 08, 2026 at 04:58:48PM +0900, hyunjungg wrote:
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > tpm_common_read() flushes priv->timeout_work while holding
> > priv->buffer_mutex:
> >
> >       mutex_lock(&priv->buffer_mutex);
> >       ...
> >       if (!priv->response_length) {
> >               *off =3D 0;
> >               timer_delete_sync(&priv->user_read_timer);
> >               flush_work(&priv->timeout_work);
> >       }
> >       mutex_unlock(&priv->buffer_mutex);
> >
> > The flushed handler, tpm_timeout_work(), takes the same buffer_mutex at
> > its start. user_reader_timeout() schedules timeout_work from the
> > user_read_timer, which is armed while a response is pending. If that
> > timer fires and timeout_work starts running while a reader holds
> > buffer_mutex, flush_work() waits for timeout_work to finish while the
> > reader holds the mutex, and timeout_work blocks acquiring that same
> > mutex -> deadlock. lockdep would report this as a circular locking
> > dependency between buffer_mutex and the work.
> >
> > Before commit 9488585b21be ("tpm: add support for partial reads") the
> > timer deletion and the work flush ran before buffer_mutex was taken;
> > that commit moved them into the mutex-held section, introducing the
> > flush-under-lock cycle.
> >
> > Flush timeout_work after dropping buffer_mutex. The timer is still
> > deleted under the lock, so no new timeout work can be queued once the
> > mutex is released, and the flush no longer runs under the lock the work
> > needs.
> >
> > Found by static analysis (a checker for cancel/flush-sync of a work
> > performed under a lock that the work's handler also takes) and confirme=
d
> > by code inspection. Not reproduced at runtime: it requires the
> > deprecated user-space read timeout to fire while a read holds
> > buffer_mutex, so the deadlock is established by inspection rather than =
an
> > observed lockdep splat.
> >
> > Fixes: 9488585b21be ("tpm: add support for partial reads")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> > ---
> >  drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-d=
ev-common.c
> > index 6569212..f9b18ef 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __u=
ser *buf,
> >  {
> >       struct file_priv *priv =3D file->private_data;
> >       ssize_t ret_size =3D 0;
> > +     bool flush_timeout =3D false;
>
> Rename this as flush.
>
> >       int rc;
> >
> >       if (!size)
> > @@ -164,9 +165,19 @@ out:
> >       if (!priv->response_length) {
> >               *off =3D 0;
> >               timer_delete_sync(&priv->user_read_timer);
> > -             flush_work(&priv->timeout_work);
> > +             flush_timeout =3D true;
> >       }
> >       mutex_unlock(&priv->buffer_mutex);
> > +
> > +     /*
> > +      * tpm_timeout_work() acquires buffer_mutex, so flushing it while=
 that
> > +      * mutex is held deadlocks if the timeout work is already running=
 and
> > +      * waiting for the lock. Flush after dropping the mutex; the time=
r is
> > +      * deleted above under the lock, so no new timeout work can be qu=
eued.
> > +      */
> > +     if (flush_timeout)
> > +             flush_work(&priv->timeout_work);
> > +
> >       return ret_size;
> >  }
> >
> > --
> > 2.43.0
> >
>
> Br, Jarkko
