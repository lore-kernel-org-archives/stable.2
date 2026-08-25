Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9B33D6D5
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674100; cv=pass; b=kY8OM4z1CP32LLShRZEKpYhphtbEtAUREWmOCjNYs1K9wntYH/5R5JPpwPwh/a0r/iN+ox/NcHeTTbDaiqUjy2Bxzs4ZdpBCxuM/Wmxbdj8HzMkiW/shxMokGEiCNzd5RdTl5eBK47HgsUuoz+KKHFEXEFWaz7W60GZ7Wk3AyCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674100; c=relaxed/simple;
	bh=dGqiAelMi3j+OBeMLnEKDn93G/jB0JDZpRAJXM72wUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9obqn003ify3E6BTy/js8JSWBwC6QAgl9ZmqLWY31yIlG68T7EZWtRQANeLS7R69E5eDtR6naRDY5MM8M9TI/kOErvd5dsFCMxHTCWqiVnevQkbSYVosN3NauR+7WtrpDCVCO8+nsgcd88vbB0hXCw7msrUsSxpIv6ZSmNmvgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=UFhY6V2Y; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="UFhY6V2Y"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso4317b3a.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787674096; cv=none;
        d=google.com; s=arc-20260327;
        b=k/SlNVJzZLuJdNyrmrMEjMxPU/iwXuopd/GHt6bADhHJpAblVkHrsjiIeCCYmqXUro
         gRgKJSozDzfiEXgCFW/SGZNJ5au7S2orYPw+L0E07j3JMFVbLBfu+9eOxRu+Km6Nu+2p
         +qMO36kf1eBddWYSU4KaJkdHy/8F0C6yaqTveHZu086iEHRX7TOIe4yW3OzEaV7oq0kV
         hBPgI3/AELkkII/vfjB3HJOdTVwYV65iO0ijCA9ecGdPwnloL3uq0d/60AC40gzYEe+Q
         pSRQcrfj9ph+6zipylMq9p2TI1Lg/h7te2wPXg3NoS33sA3YcDqIHlbBjGpw19Z1PVAV
         b1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ZLowbj6pZcMppFHbOVdGIJyzEqMnEa6iqrdQcAQ/VY=;
        fh=Xt7GeQ1Y2fn5up48TK7zUrCYkp3U7FFuiIWvyQsd0HQ=;
        b=Bqg7x+UG6THyH6uQq7Rb304eBjSLkCm9miRsRgw3LfnvtDLzBj9dDpNxlD7KvPMXOy
         dlBA63slcU6zOdYiY9srG8vxNK829/i0QHGfApX99TeETOWyF26zKKbTeLnG0ydOG8SN
         3/qmtr1yU9J1CzEsQksFGWNHbsHcyiGd8YTT/kZmKBCEE1Hijun73aj7u2Mch9MoMWEl
         NWEX/G2Za/yx6oqPM2KUsK8kALb+XBo8It8Bol9qlLHwl7In6si1iHEg79VfKf+6MNWW
         +5u4x1hp2EHtQb89JrTbCWdk5FDFHxugYwQu37twUyY/RghVGyrjTq7aO5Mza43bap2i
         mciQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787674096; x=1788278896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ZLowbj6pZcMppFHbOVdGIJyzEqMnEa6iqrdQcAQ/VY=;
        b=UFhY6V2YaSXTehNNJjFn4l41ePBoR8UlPOKHj5w3M4/MatP3KAXsNNLcE4pOvcexw+
         Lq+uvtutLQbsp5ReMkA+XgMaiqfLKS8y1hzemu7kvGkVlusLkbwQzSzlFKLktY3CIEMC
         SD8if/k1ClDUcb5ekJ2FiIZVfeX9KMP0zc2xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674096; x=1788278896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZLowbj6pZcMppFHbOVdGIJyzEqMnEa6iqrdQcAQ/VY=;
        b=ichRQe//HbHkxFltazn5gah5OSQoa0FwUOIevpMBDRzZIMDZdvOBrC8wKbTczzvL3C
         4KWhDW9vDXPoxgU6Mz4+7GvYXRh4kfWLjUn0HiavRCEPJyr15YM8ODm3NKVDdOuZiVcu
         +wJGTt0uen9DIWF3dS5LIWCry4omxYCJtQ/X/nxIbJjfFcXC3PFmJHMjR8DMg6Qm46Vk
         VVXXb9y7cgQb3h3PFXa3XRwvFNmrpT+C/KH8a6qGmRUX7XcAaJ8/voLNOOYWz+6yjB6d
         6dnDcUHe4bmxtM1DCyraQlOUx0MEQGwk5s6Ud61INNPSzGh/M3LTrbaZkaJbsjOzyVmv
         fwsw==
X-Forwarded-Encrypted: i=1; AHgh+RqNxWYjIcbN0etufcEQmt+kAWO2U4C8xs7bb0kJl0obS9jn1XfZGtihuxbKsyn2tx5jlLb9Xjw=@vger.kernel.org
X-Gm-Message-State: AFuF++m2OxMAni2HzutwLRCy5UG9+Sod2ESE3eq8yRoxhKV9uZF+p2z2
	xkW8oQmPEcAdnNnw5FVuvgMJkfBo0giyyg+htdJNXGp/ea5otMWF7nD/Inu88qv3tPM6UXyW96V
	Bcuyg7NrD/gZEL0e6OrLfjfLc1XhOkcmMC34nJJ9a
X-Gm-Gg: AR+sD13d1cW/FlT1n19EUQIoNSk/k/GrM0Er6P45Bsy49Z/+SAR1CUQldhR/orO8+p9
	stp0Dl8PHYQz/Nakqu1Aaz6St5miE5jK3zbLHVkfp+gxPpEyUVJ59j4I5rvQmcsnmKg2LiihvtJ
	OpjVf+lnFgDqcS9PLK9rPYvLm/5c3KJu8NYUQBfgtqnmjLYwCiecWIxbM+jNnx/Y/5fxHnD40Yk
	6jf75Uy2NzJT4Kf8EGOd/jGLznyteMTehJ9d3Z+WDx6p7w1koomw9ILfC2Fd7gMVBt3hI/bogtL
	VUCVFD40LqqQ+HK3vQkmhcJr+j2slaJyeAAoEMH+Mb/RmN5Wj02G
X-Received: by 2002:a05:6a00:858f:b0:853:5152:a3e9 with SMTP id
 d2e1a72fcca58-8535152ac57mr1163052b3a.11.1787674095878; Tue, 25 Aug 2026
 09:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095742.68511-1-jhs@mojatatu.com> <20260822134401.6545e4eb@kernel.org>
 <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com>
 <20260822160234.7115ccdc@kernel.org> <CAM0EoMm0orPkSuMLrpGMNkUATjmBPCvqWmKMEPQoYuYAEvCAQg@mail.gmail.com>
In-Reply-To: <CAM0EoMm0orPkSuMLrpGMNkUATjmBPCvqWmKMEPQoYuYAEvCAQg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 12:08:02 -0400
X-Gm-Features: AcwNN1UfZeiVD0YzBqdqd_6Ugr5w6_aaDqOKIPnHzTlvPeR1fBSFdGBvHs3fFDo
Message-ID: <CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEevLu=i=b+xKg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account
 to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 8:37=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Aug 22, 2026 at 7:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sat, 22 Aug 2026 18:14:49 -0400 Jamal Hadi Salim wrote:
> > > > On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> > > > > +     if (qlen > 65535) {
> > > > > +             pr_warn_ratelimited("pfifo_fast: capping ring size =
%u to 65535 for dev %s\n",
> > > > > +                                 qlen, qdisc_dev(qdisc)->name);
> > > > > +             qlen =3D 65535;
> > > > > +     }
> > > >
> > > > Why not a hard cap?
> > >
> > > sorry, where to put the hard cap and what would it be?
> > > Or maybe you misspoke and intended to say "why put a hardcap"?
> > >
> > > Or maybe in this case probably safer to just reject the change if > h=
ard cap?
> >
> > The latter, I'm asking why not:
> >
> > if (qlen > 64k)
> >         return -EINVAL;
> >
> > To be clear I didn't dig into the code, just read the commit msg, so
> > maybe you have a reason. But the "normal behavior" for out of range
> > params should be to return an error rather than silently clamp() into
> > the allowed range?
>
> No real concreate reason other than the thought that it's a device
> param as opposed to a pfifo one.
>
> I am going to send a v2. Will switch to similar to what virtio does:
>
>   if (qlen > S16) {
>       //extack here
>       return -E2BIG;
>   }
>
> The followup as identified by sashikos is on tun/tap - i have a rough
> patch, untested but there are others ahead of that i need to send out
> first.

Although i have submitted v2 - i may have a small change of heart.
I was trying to document sashiko's famous "pre-existing issue" rant
for this bug so we can followup later; sashiko correctly pointed out
that tun, tap/macvtap have the same issue and i was going to do those
as followups.
Although i had this approach below as an option earlier - i didnt want
to go with it because the goal was to isolate the pfifo changes to
net/sched. The option was to make this change:

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..ab6b44b67be2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9985,6 +9985,9 @@ int netif_change_tx_queue_len(struct net_device
*dev, unsigned long new_len)
        if (new_len !=3D (unsigned int)new_len)
                return -ERANGE;

+       if (new_len > S16_MAX)
+               return -ERANGE;
+
        if (new_len !=3D orig_len) {
                WRITE_ONCE(dev->tx_queue_len, new_len);
                res =3D call_netdevice_notifiers(NETDEV_CHANGE_TX_QUEUE_LEN=
, dev);


This is a bit controversial with S16_MAX as the upper bound, although
no device i could find had anything that caps other than virtio (u16
max: 32768).
I have tested this with all 3 issues(pfifo, tun and tap) and it fixes all 3=
.

If this is acceptable as a fix i am going to withdraw v2
(I dont see much of a downside even for buffer bloat needy folks like
satellite links and given virtio there is precedence)

cheers,
jamal
