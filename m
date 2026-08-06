Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98331305688
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021939; cv=pass; b=YZY93zL4yAiOSK8q5MyFS/lfH1HiXelXC7kCYEk2L7m5yvu0mTwz7gNINH4Hrf42waoGobor0GsGLB8kB0hHeC0pYGtHmBm4anR8DmKafoZT4XMpf5sswxtidBNw+ZRlmClqCxMuzYHS/v+MCVZX6TLWFjfFHF46Ego5iPcgAoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021939; c=relaxed/simple;
	bh=gTOx7EH1voNp8N7JYu+h59hbOKIzl4POlomWmUZTuaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbj+aOnA+i1PlfEk4W3NAC6GhSYaPxhg3WSXQG39iYjBDvXivfhbGec5mKURRaUnDODevD9OViuMvOa/xYnFv1vRoWdAS6q5NMfbv2QRW2LBGE10nsz/3s3x8K1Qz4M58mtqVPP/4ppTOVL2Qm+yK16aLOLVpYbQP6XWDmjRAao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mV4iDkzb; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mV4iDkzb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso105955ad.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786021934; cv=none;
        d=google.com; s=arc-20260327;
        b=rHjiSYIh+YN7adNlk9rI5xNY0Y5w6IWN0l+tp+u2LPkOgsrGKkiTQQKXC8W9OozdB9
         LRhsu5ascsEn4IItwAW2xe0nN12byQlTclUGAiJBVvpb0Z2DOezhTnhE/Xi93ra7az0Y
         TSOk7A1wHXHjg3hx+v/4zrT/Wn10PuzOi9CkFz/R3SQS2lcHYZjcMskLuinfxVfheD/h
         wkoonQMr87ZUensFy4HdS9KG9zS93dBr1Z7zupirUt2NcFiEva1i1dMU/SN+9rmbCLxk
         QKy2RCfPUmA1bauWmEOgr3ETpvoQp4UCcax/OdMf5okzk1QtpR9JeE31rwmFbQ/3IMkt
         IgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9/jShmwIMCeTZRK1H99Se78DZXEHSSBV12Fe1ATBL0=;
        fh=Zh+99yERGpx1DW162rC0KcpQBIk1jRgjSqBhZLz9ovo=;
        b=blOsHf2AIft0w5Eo48atganIRrNPY1Tu9TwnWwF3q08SjBE7wX5PWrWZv6BvelpSlj
         O7DVFgrmF9mNSobvqJYa/Zkfs+SA+gdCIZSXBTCILitWzw5uIGCSTnQRd0KjARdoiYzm
         wLz+7wEqxkFlXJ6+iLpUvO1ArGUir3D+VaClrsyndjMNrvhPbPFpXbLcfyeA065v8Y1U
         dXEY+LMgPT4ZnwlepNlNZ28qnqMj2xp1kjxbBuzGh6U66Z5maO2InSAeCfSv30LDaraB
         kafOKWfYS2je2/MZ6v9LC4BkEur1enXomImtbS4h2aqOJSF6K9hSVwH2ndHOPSPKpesM
         0EVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786021934; x=1786626734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P9/jShmwIMCeTZRK1H99Se78DZXEHSSBV12Fe1ATBL0=;
        b=mV4iDkzbg8jIFwoK2W7fjfRIKSpuVpyDrL4qrv2A2N+KVQyTcOzs4hyNMNR072rCdn
         I13UBVucdxyLx8KPc5stdwL3RQgykvahqjmr3tVLI+x809VOOgsRk0gmWpmKxXd5KiZw
         WXxT+7wwjtXrlojwu4zQ+NvjfFn6UQOEMt/a01XZFn4tekZaMAv6EEJs6c8Y/B05oIVW
         MwSHsWWep7jBYV03ZNxFo3cTDEJIX8Tj2JjKsLFTfobGLXUWUlHDa2idVyI0ZtU/1R4+
         wub/+vK1EMyz2m4O7E7iKZlOYNGVHZ2Ih8eW5lMpwmu23Rl+LVe994G7iTBFCgZ3Zrpt
         xvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021934; x=1786626734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9/jShmwIMCeTZRK1H99Se78DZXEHSSBV12Fe1ATBL0=;
        b=Y8ZPzyez9oN+HhvbLQJn7zLEsQGKUYkjrjBSvlnmQDwlG/ddVm/YRtJwULgp0n1Gdi
         Mg5GYyFMVnG5T/PeHEWNNYR7g48yfPcOLQFO53Sg5AFJzeVZaUpVDBAnYDXJWVzyPRPt
         hwQ+pDBIdashSlbf88f2DMO3eUIKxkPlpnzL59tQ0fsmq4LN4lccV2TNhGQppcF1eHOT
         a42tAinwB2kIMcOvHFvqnPzVn9cw3H2LvVbfucq9O4Q7y+k7jZkoZ9pFsmBjrnVatK6l
         v5spA0LpXLc4UELF9aAxdGevPE6QdjK1IyqfiawGZ6XmM7b51JopmrYDm8rWVMJ1n4y2
         UhNg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5udC7MITMBivpBr+YMRRXxcUtu2lIh6WGss5nTHT2LJpP7zthhFAV9vj+RDbwPmF4u/sQvFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0KFYMA0WCxNlIaNLEO516A3Ly88rxUkaeAFd4DAshDy2fNBl
	27zOeQPB5/S61OJQpnXvyPTSgzPTeO96Np9ohaeOSrAh4Iyi4sfHa3aRQU76qYVOoPr2rlVuTpe
	c0H9nwK7yWUev1+KhHwP976JHM2CUVD1LMTsYx4K5
X-Gm-Gg: AR+sD13U27a+bOKC+68rH5fUvTAKch9xunI9y/AgbPpDXpDsEVfOJhWsACim22iUleR
	G+M6eHegndTwlDBcs813D32M467gYn1rxfNyggMCEKTR/noRxlXYoBMeT2qpg2TfwEoeW3it4e3
	+6c6G/xI3NEBTqZUJAHb6F9n9nncocPf13vjUktw+htK/S4f7W4bVk+4gzUv2PVlWe7p07ZHpRX
	TpMalceU8BV6WWg27LI0npiXI6kBrQJ1XCKuvwVX2LQ1izli0rJxiLGzWf/eFuEso+0TyCzrpEV
	OL6DnsAR/St3Z3F24BwI0W39UDb/qpSTRXCLvrh2saI1aUMF7Fq+6XrdFfM9NbY0utk4gplpMVx
	hcKArIVWX8Fa+A0nHXVTRXX+nHT5gMHQ=
X-Received: by 2002:a17:902:ce90:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2d0f2a1ac97mr7375425ad.4.1786021933682; Thu, 06 Aug 2026
 06:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
 <20260806073244.GM49951@noisy.programming.kicks-ass.net> <00168bff-3d44-4701-9931-1e02105410ed@canonical.com>
In-Reply-To: <00168bff-3d44-4701-9931-1e02105410ed@canonical.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 6 Aug 2026 15:11:36 +0200
X-Gm-Features: AUfX_mwaMKvH8autja6WPUiF9yY0qYb3sB5ZSNxQ5smDHdnj5Wwh-lN0MJH4-ys
Message-ID: <CAG48ez25v6=GZzK2iNQepDeKpgAEWBPrkovJqzjSiJsOCLNSeQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix cred UAF caused by begin_current_label_crit_section()
To: John Johansen <john.johansen@canonical.com>, Peter Zijlstra <peterz@infradead.org>
Cc: John Johansen <john@apparmor.net>, Georgia Garcia <georgia.garcia@canonical.com>, 
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Morris <jmorris@namei.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:06=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/6/26 00:32, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2026 at 05:38:07PM +0200, Jann Horn wrote:
> >
> >> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> >> index 0646804860ff..ce19fc14060c 100644
> >> --- a/include/linux/task_work.h
> >> +++ b/include/linux/task_work.h
> >> @@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct =
task_struct *task,
> >>      bool (*match)(struct callback_head *, void *data), void *data);
> >>   struct callback_head *task_work_cancel_func(struct task_struct *, ta=
sk_work_func_t);
> >>   bool task_work_cancel(struct task_struct *task, struct callback_head=
 *cb);
> >> +bool task_work_has_func(struct task_struct *task, task_work_func_t fu=
nc);
> >>   void task_work_run(void);
> >>
> >>   static inline void exit_task_work(struct task_struct *task)
> >> diff --git a/kernel/task_work.c b/kernel/task_work.c
> >> index 0f7519f8e7c9..f83d1528e0bc 100644
> >> --- a/kernel/task_work.c
> >> +++ b/kernel/task_work.c
> >> @@ -189,6 +189,20 @@ bool task_work_cancel(struct task_struct *task, s=
truct callback_head *cb)
> >>      return ret =3D=3D cb;
> >>   }
> >>
> >> +bool task_work_has_func(struct task_struct *task, task_work_func_t fu=
nc)
> >> +{
> >> +    struct callback_head *work;
> >> +
> >> +    if (!task_work_pending(task))
> >> +            return false;
> >> +    guard(raw_spinlock_irqsave)(&task->pi_lock);
> >> +    for (work =3D READ_ONCE(task->task_works); work; work =3D READ_ON=
CE(work->next)) {
> >> +            if (work->func =3D=3D func)
> >> +                    return true;
> >> +    }
> >> +    return false;
> >> +}
> >> +
> >>   /**
> >>    * task_work_run - execute the works added by task_work_add()
> >>    *
> >
> > This thing is quite terrible. And AFAICT the only purpose is to
> > determine if said task already has said function enqueued. Why not add =
a
> > single bit to struct task_struct for this? I'm sure we have a spare bit
> > somewhere.
> >
>
> single bit wouldn't work generically to represent the different functions
> that could be enqueued but we could stick a flag in the apparmor task
> security blob, so we could just check if apparmor has enqueued its
> function.
>
> The trade-off is you don't get an admittedly ugly generic fn that someone
> else could use.

Yeah, makes sense, I'll rework this to not touch task_work.c and
instead do something with the apparmor task blob.
