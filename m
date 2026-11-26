Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795686583;
	b=C/eJRBn+1E0AP6c3P8SP2DhSmz1gJj6yW0w3hAFItjTah7N4ZdLch27kfRKD7kdNzsR/
	 n4Bnh8HlJkK1M2vnlXZV+Fdza9e8BjQ1eH5derTnRV4CEiXMavoVa1d4icpD8gKBYpJf/
	 OHL8eb8LTjz85t/bPOQhx2BL74eH+9SHRBt6+kecMOk9yhGSUUJ2puEEnK0ed9R6iUes4
	 kYOkT9DrOwZf5xXsaKEUz8ibsZrrxPTm838hBNiC2tWFDKDbLJlK9EhgJ1cOtQN0iRREU
	 DQ1WvJtVTjAP92cZryjcwvmU1tPbTFe/uDSumshoFf/7zI0JXBtdtqHi63cXsmtikYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686583;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
	b=D/i+8fhXSXjMUwb1hGTVE3kzAzo57UX0DiESqKMlhaZhA5w7cYjgjfB/sUrnbb+kkm80
	 DndaGuk+GiwsJDIXybyEN6NPVFoSZ50eawN5o4NviE3U2vTcaZ71Ly9abFuji0s8/yey0
	 jrdQ4zv6Mhwt465S4KPomBBN9xHlr1Cnf7y12nEF/FyLmki9fp533+jIS0pmAPEputn0G
	 q0AbcCCsUxc00Wb94S6tp7PB77el2BzSebZvK/j0kRAmw4DlJQ1MsEbedRFVWvd+CdRUL
	 tSQ4Kgfawr+3D3HyRwc+NyJNawprYoK54i9PGrLOHa8z4vje+ifGMGyhopAWWq0EJdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZ2xBB7A;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nu0tiS4o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB8606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDB8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZ2xBB7A;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nu0tiS4o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795686581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
	b=hZ2xBB7Azv4omwSVIkM/Hh2GyVCm7IS8p21DXChB3JScwkpPULY/hAYd25WfljkqE/xyKB
	bNFRa2ViFr/gNwmnc8Hed958J0ZURHqHHo5S4CNIOm4og3TEplUt8+ix6+2HwjijxfmzqC
	2Wl+iQ0RQhw+Akja/GRnWNujqDmHsgs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Ekp0popONf-Uo7Ycoe_udA-1; Thu, 26 Nov 2026 09:49:39 +0000
X-MC-Unique: Ekp0popONf-Uo7Ycoe_udA-1
X-Mimecast-MFC-AGG-ID: Ekp0popONf-Uo7Ycoe_udA_1795686579
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0f1c06332so99398077b3.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795686579; cv=none;
        d=google.com; s=arc-20260327;
        b=hD8yVcTQ6oC89iuJTGpKh0vDUt/ByuyPIlXqyBcJru13hxDJBYoIiExsESF+iRRxJg
         6Dw2SrFx13186f+vCdHtl5tO50SUMgbL1O+oQcJMc7/LDWl2bhRbthD4gFUVUEeskCT+
         XLVeemjF5C8BmrBUHlTE7dOFftJuAb1JETwLY3F2U2RGEP/OSrAK3A1DtT95xVEzGTDC
         ZTQ9hjVIGD3xfRytsgQKCSOeiJS9iDziOii7wDjsaTchEcMQobT1SccquBWXTQWNcfK+
         7JUhUVQnz2DijZvrZhHc2Qj9quXNejb//yOtqccFRBPjs5wyNM/js/sofz1Sj2+rnuL+
         oQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
        fh=suXUzZO0afD9jarKBUHEUFCBeMJml5cU2uUvDfgia+k=;
        b=TJKlp8Y0Pp057Ao5LlVs+LIcqGPN+QzqYv171ElaGdGdWuHl3yMdZhT+a5pPbyFsMX
         0tFIn/Kl9+4KDB3mxNQnKTGyLEPfmElqE+ns1bKkze0UbUSFZEaP40WD3PLCe0bb/dzO
         4uyLbmlLE40o4DPN48G9d8Bu/EmpiZFE0tbJH60iBaQ7TiNfi8yzKTaLZ2VpeCZ+b6Dh
         qd0VlCEEBgfhCs5AFIPhPJlUHYeRmofhn53fhHJ62C2pp893mW/7xBR0d2x9izhPy3eQ
         eJMwKE/4E20w+kGox6oPBkrTiAD5grwL5rqfO54UmnLwFyqYwQ1F4Zzephk3NUDBjw9x
         m9Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795686579; x=1796291379; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
        b=nu0tiS4oYUqkmQThR783q8O0nB7tU1BqwBA+laChw1cNfjE8I5oC8ERK+0CINw7i79
         BnlKkX23iwZgD9Kk0NzlD1nc8Wg7mzlYTMe1FrUHL4WPj0hRHMU3zqVvhnL13HlouY6i
         0VcXq+GY1/p14knr+fQolSpjSr7YQPnZDtab8XBAjvxHNHjzM3t4Rs4SL8KUVw2hdEAe
         xP8QxkqueDucJ6W6wmd3Gcijzc22yfOKmy8ziw47thb7IYzRt4mcDzdKVsgnI3YzhNN4
         qnx9Gp6XjxhruR1fIetUhGsvCZqoFDfNeovJZVP8IMSKNMwP/In030GGiEvRgVZZAUs8
         +Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686579; x=1796291379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GNrgKTXTrOFzDhPgeYf03Ncje4wZ/Zh1NZKNX0O4g38=;
        b=TpTo8ngLwY7EDIaG6loytax5sB9qrPDDQfy6KrWG2dxkc342UlCzlURNX+ftSTx+mn
         343ICNLgR9qL2Fx6ccXqXmjHK1guxLXQSE4+7uhnqKWXbuvam3I0rUC6VGtXqQ02lYUZ
         xvv9hm/hfU6owBFLShxKlBkzNa3LNnCbfl2Q4yfVVrM59dxrrhisSjFSTu6tuvzhQbt+
         umVGkNbd17rIvwICgDYNN7SmHWz51gOtcL+hB6M1uihtJMjFI6BDz9/Aig1a0Df1UW2E
         FBZtTZVzdkAHH31em++htRn5peW5SGW1mz+giMQzL3MkSgUPDmivdbPKl+Lev5MhW7gp
         orXw==
X-Forwarded-Encrypted: i=1; AL+hErGUu2Wi+0U54tQODYS6YoTVhoK0HYEFkYTvmC66nvybHl40Zgp7ylQn+TIrPC4h68ismZfXvxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bsBB+2nIuilgobzmtFTM0sJWnjTGa0tIg62c+GpAYU6dikh8t
	LAGjYL6VBGML17nWjzq2yQ7EhK4W1CXikb9wKA/YfNTIcjsY0bjXlWrsC0/+88miDO/0flcFrsF
	T3qk31vBKz3s/RRHR5lf7snNS9iDAJ/PD1gb6+LVTtl6FeoBPn4MvKcdSHIpD/2R1W/L7G78uOZ
	EZpuDn6GkYCOirLybNzvykPzrLivxJZS0l
X-Gm-Gg: AZFdTZc934s5nZ19mQkkuq7X/9ORYPqSpDXCiCkPbHmIs8BpwrzM4PC+xT8SN4J0QNB
	Nf9cTz7/wYMEz9n/2VyqfvqkRpZdv47bWXRxWaxl3kUd+LAZ0BNGTKMMvPUzmlWJHzvFOvx0HcQ
	GtTElEk7Sr2QJgL9HGx771k9YhakxXhjlyfD8bCOk3liCbKUzfSLACZssYmoyODxcZ/UGEWvCyu
	t1FLU6lF06la4Saqtq+Elw5BobczoR+nslpm1oWEcLuXQ==
X-Received: by 2002:a05:690c:9986:b0:8b4:c71b:e4d6 with SMTP id 00721157ae682-8b5204b4e2dmr82175027b3.35.1795686579009;
        Thu, 26 Nov 2026 01:49:39 -0800 (PST)
X-Received: by 2002:a05:690c:9986:b0:8b4:c71b:e4d6 with SMTP id
 00721157ae682-8b5204b4e2dmr82174937b3.35.1795686578546; Thu, 26 Nov 2026
 01:49:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125175007.3659558-1-hengyul@cs.unc.edu> <20261125185332.2549812-1-agruenba@redhat.com>
 <20261126032826.4156477-1-hengyul@cs.unc.edu>
In-Reply-To: <20261126032826.4156477-1-hengyul@cs.unc.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 26 Nov 2026 10:49:26 +0100
X-Gm-Features: Aa3M54pOdvxu5XUY1DJw0M0cDCzeBZYAQTrBCHj1-4qHVGgpDIiPEkW5-yGupmc
Message-ID: <CAHc6FU7MnFrA8E6OyvOk8WwiiozCT4=QPjne7ftoLq_n7dOmYw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Nov 2026 at 04:28, Hengyu Liang <hengyul@cs.unc.edu> wrote:
> Hi Andreas,
>
> On Wed, 25 Nov 2026 at 19:53, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Why not make gfs2_glock_async_wait() non-interruptible instead?
> > Something like the below should work.
>
> That is better, thanks.
>
> There is one problem in the sketch:
>
> >                       prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
> >               if (!glocks_pending(num_gh, ghs))
> >                       break;
> > -             if (signal_pending(current)) {
> > +             ret = schedule_timeout_killable(ret);
>
> schedule_timeout_killable() sets the task state to TASK_KILLABLE again
> after glocks_pending() has been checked. If the last pending glock is
> granted between the check and that point, the wakeup sets the task to
> TASK_RUNNING and removes the wait entry, and then the state is
> overwritten. The task then sleeps until the timeout expires. It does
> not hang, but the rename waits for the rest of the timeout.
>
> I would pass TASK_KILLABLE to prepare_to_wait() and keep
> schedule_timeout():
>
>         for (;;) {
>                 for (i = 0; i < num_gh; i++)
>                         prepare_to_wait(waitq[i], wait + i, TASK_KILLABLE);
>                 if (!glocks_pending(num_gh, ghs))
>                         break;
>                 if (fatal_signal_pending(current)) {
>                         ret = -EINTR;
>                         break;
>                 }
>                 ret = schedule_timeout(ret);
>                 if (!glocks_pending(num_gh, ghs))
>                         break;
>                 if (!ret) {
>                         ret = -ESTALE; /* request timed out. */
>                         break;
>                 }
>         }
>
> The back-off sleep would be schedule_timeout_killable() followed by
> fatal_signal_pending(), as in your sketch.
>
> I tested this version on gfs2 for-next with lock_nolock, KASAN and
> lockdep. The mv reproducer from the patch moves all 12000 files, and no
> rename fails with EINTR under SA_RESTART handlers, handlers without
> SA_RESTART, or stop / continue. SIGKILL and SIGTERM still end a rename,
> and fsck.gfs2 is clean afterwards.
>
> If that is fine with you, I will send a v2 like this with your
> Suggested-by.

Yes, that sounds good.

Thanks,
Andreas

