Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D74E56A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951689; cv=pass; b=it8q5q2L7uiH1jB5nZSrgD7A7eRpjTo7f34972GfaBWzIG7dMYZgTIlJABJAa0SdcXBaM8gRdHiXf4OKAjx1Nu5NrEm0MGkkYzmnRvaRbx85zSbIcqKyWDGLKTgwvvgSPyBhJSKLEGN+xC/V4Bu9+jjKIAJvP7cR/zf433Ovy6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951689; c=relaxed/simple;
	bh=vqIlEswSbjH4NuGZq6lHoJhIaehD2d6A+4RCBsh341k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrLrXwPoQMvH+qHTttsGQiBYpwBFpADCfj2ylizK5XNNZJM3marENuPH22e5qfIFG3UckP72as99MO9TDNj8DjBT79+ktXYBFa2Zl1bvI5mhY9BBgTfHQa66KQXp4RTT0Gyhn0QcR0due9hrzWnZkwLINBIQXvdiaD37lERiotA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pS9y55re; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pS9y55re"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c01c79467so499361cf.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951687; cv=none;
        d=google.com; s=arc-20260327;
        b=YfmP1ALQNhZM28TJBFQiPJ3MtaZ8PNmez2eOMPrIbxzbq68Ir/yLBpTUe/QvZPKV7z
         Wi1SDezwb7C7Kt0e+yFxGbUw7xNQmdBG8SQEAvRNPapjAsDuwBTQfPPro/G4JZppiM4H
         AMq0o4x7hYX1nYBO2DefZuQ0abxBHmRybpCtNeD1pVlbW1sOVh+9tujxZJI2nbWNBRVy
         mCh4afPQMOgb2Nvh/rIbaNANmLuIk7Ci3Zw0oluWDQ/oYOwJZzCcpb8pHZtrRcK2DB8y
         ioNX6Y7408sw3gNrtFDydHg2PZ1kop/QzX37A6ZHgdEHipsfhLwmE1RUiQhhaHU0Mo1+
         F2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        fh=wWKc3wuoo0Fb9mr1A2LGj+43KS60CISDkGibL5xN9u4=;
        b=Zp+wjxeDjN8yQWPHQE4hZ+VOvt+PT0t72nS4EeN46qAh0LbiCyPQrlwDP/eslPp5Yw
         5apehXEWxojy7yN8ezT9306REPk84yhK1f9pSR+EAUMu8HpHvSDtMlVW0vX4ojs14j3i
         /goHQzSHmrb94UVZunhFbM1m4XjdENGNLolD+csIuiPJeUFBqPo0RvXt7MvvS7WnL5lE
         K/6KWPJ/W7Io4EsJQ6vOKZIgL6CAHMvMHiY4krJTjF+4tlRSdq2h1WiExQLmbIwCU9dq
         chIYi4NgxHp42HHQizHm+c10cGGDxWYPhSPJEEVwXdUnTOEj8GpQfr2tHWR58ETw3vzP
         b5Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783951687; x=1784556487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        b=pS9y55reWilK7flI1go7NlrWlU39RPZg9bFvJWoSZj0FMI+nLkhXrWIerGcrCMO40r
         DrwZa6m2vvOtaIacxmfFAt5Q4wmX/ZvOY9LtgOOuEaoEeb+LkG33TUoYXeGeYJgkOrOe
         DxL3XQi+Ax5MJP5RwXnYD5KpbOy1zHNEJf9h0/hnh5tAcB0PEkq/CEViW2L/zDgOLEbG
         Domgdv4gOVDIfX5TZ0chgk1Y09MQR919qtj8fxYbaKqhR1l58WHRoZncN49POGe/+FRV
         aEWKEtKEvHpEHdHl5Oo+vjAKkfxPOuRaOQ4lgCmuI2jmsrr4xMjAGvx3amWKUQOPY2mK
         9s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951687; x=1784556487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        b=NpW06qjpERz92VJnvLeWWOuoRnx7/pXMJQca2MD26czIJ8nQSi2WfQY2uHLRfsru3P
         sZPkRr75HTHDIcJ+nAcn5h1EHV4LG53UjwfhR4rhmrDU5GefhFfe+OPfViXbCAIKPIwE
         Rx6hi27uPlLjEJuH78oFf7+bKq31FCQro9Wc1rgdiWnykpNEU2CgTAPrzT0a97k6Es9W
         ffx7aYrMBJ5FFcTwNMkFbQXYNM4KslF7w4/Ma0g5XOJ/0sMW2gRgjUXx650Vmi7XDoDP
         BwBoxP5aBlfU5U+ttimWNg14fZSVLhttDqoyCiUl/KS9UGVlFhb6xOKuLMyZWcKYvB5S
         hOZw==
X-Forwarded-Encrypted: i=1; AHgh+Rqb4StE4+dtSug7jZqysN/y+vOguiFcbqyX+aoaf52F1hxKRLMFMDXDHSAPmYw+dqK9IfM+y7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nLSTzk2+yfynUErqM8XbT5qgJSY3TdkX1oMyxK5flExiRuIv
	iROhLXC+9hVGsd/eVUuzBSRnvLroqPJyzOYx1JN68AJ3BCYrU60gA43UWg27XXNklcSgaok+Kfa
	RkwOEsDk8hBOg8Lt3IjDqgZj/nY4e+SZVmc6GDjSP
X-Gm-Gg: AfdE7ckvhzeeNzKnLZNBOkDrpJZ2Y/fAz3AIXgw/zSVunFssxq57vxS3X1cf0Ptg9aH
	iFiM1DnF72gyKkT3x56RJLKmF8rPS6knPQLt/Hzp79zutvXfAfYQ1B2OBaPodjMJbHZ9YaQeBC5
	heAtCAMjTybBjNjCxJyXsCbpBLrPZcc0OL3hi7/a2UJ2xGrXuYGqtHcCxK03XPLMMc+Ozt3Tnnj
	5PsHcB3ESqLQHaPpDDmYDzAE7QuCAvN3nHmT42zfEbCrinF1hTXbAZlpvBbYf+YW4eMI6LOJ6YS
	lIJAGw==
X-Received: by 2002:ac8:7d03:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-51d71546a1cmr3059641cf.2.1783951686232; Mon, 13 Jul 2026
 07:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-3-tj@kernel.org>
 <20260713105655.GC276793@cmpxchg.org>
In-Reply-To: <20260713105655.GC276793@cmpxchg.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 07:07:55 -0700
X-Gm-Features: AUfX_mySUXx60Yrl5QJFzFOTYBVkvBAoiyE97eRZFZR4z-qTHxpoqiaNZ1I-MdA
Message-ID: <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Matt Fleming <matt@readmodwrite.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com, Sashiko AI <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 3:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> > psi_schedule_rtpoll_work() is called locklessly from the scheduler hotp=
ath
> > and can race psi_trigger_destroy() taking down the last rtpoll trigger =
under
> > rtpoll_trigger_lock:
> >
> >   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> >
> >   rcu_read_lock();
> >   task =3D rcu_dereference(rtpoll_task);
> >                                     rcu_assign_pointer(rtpoll_task, NUL=
L);
> >                                     timer_delete(&rtpoll_timer);
> >   mod_timer(&rtpoll_timer, ...);
> >   rcu_read_unlock();
> >                                     synchronize_rcu();
> >                                     kthread_stop(task_to_destroy);
> >
> > The group can then be freed with the re-armed timer still pending, and
> > poll_timer_fn() runs on freed memory.
> >
> > 461daba06bdc ("psi: eliminate kthread_worker from psi trigger schedulin=
g
> > mechanism") deleted the timer synchronously after the synchronize_rcu()=
,
> > which prevented this but raced trigger creation instead: the deletion c=
ould
> > cancel the timer that a new trigger set armed during the grace period a=
nd,
> > as creation also reinitialized the timer at the time, corrupt it.
> > 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") moved=
 the
> > initialization into group_init() and the deletion into the locked secti=
on,
> > trading the creation races for the window above.
> >
> > Neither placement in the destruction path works. A pending timer firing
> > while the group is alive is harmless though. poll_timer_fn() just wakes=
 the
> > rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the group=
's
> > lifetime instead and shut it down in psi_cgroup_free(). Nothing can arm=
 it
> > by then. timer_shutdown_sync() because the timer is never armed again.
> >
> > Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy"=
)
> > Cc: stable@vger.kernel.org # v5.10+
> > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.ke=
rnel.org/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Both these patches look good to me, but Suren can you please also take
> a look?

Yes, I'm on it. Need some time to remind myself of all the details of
the implementation.
