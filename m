Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BBC51A72F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863981; cv=pass; b=gb2ZHxLeJ4/FLGadiZc6r96zTcVpneX+x3hJsjauqMs/1ci8WrfAMOytJP9HYljf2WfjdTpf05G1UZp/KAFE5xMXwuNa2x9iKvGqkAsmaWAhs84B+a9IC3eD10+LcQW4xYpwxd1lfYbzuPqasCuBVNWdZGw9/1qdf71zTJN55ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863981; c=relaxed/simple;
	bh=tt+pGvMYz1FVN4+bRmcox4/aVEQq4bCQPvkvBGNFnW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRmVYiCJe+Ghm/a/kOE0D/JOzi9jcL5oPQdMqBwRND+3IGNofOKoBvNNYGMq3P4MheVxZPEeqF4H53UJ79ZKfUc68nTHhyKtN06OVnmFjlgE5+h8y7RRuAio9Ed3Ze/flNzxLgyl+0MpMJKpo1SfZRc2bEB/pEZ6+KVgvrh+SqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaeuMiFe; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaeuMiFe"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e27035206so4073836b3a.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 03:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788863979; cv=none;
        d=google.com; s=arc-20260327;
        b=MzFeXLvD8bvQy988Zq9FdIC2Tq9ogzg4hE6wdZdvz8W+mf+kmXYjQDZ/aIB7TEPSd0
         z6vWjd9KzQarLxLX7lf6NsCNuCJcD5L5prEiu1xmP6w5YyJA7YYPv9n466kTJrA0Op09
         YTIJ5V68k4sWGTN/nH2vSCVT+TwDZUi94Ozc578lSn8BmKDQGVlIV25bCTRJOm2ajzf5
         k/Jv1MqzeRxAi7iJE5YFI3JV3BPpRLxs01R3LeLUzJbv9ireIvYzt+NYBd51ZdnzzTcG
         /bKXWOfEzHcEGfeET5ePtdz478S+Eg1hyxOosCIrpVLls1kVyvSTIarK/vdQt6WjRI0/
         TV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jl3T9yA5icn0kDud2YKhOUFI5zpsByTY26KMtyiXHpU=;
        fh=+SU5J00lZQHhBwdgH5q2yzUqIKUg/w8wsB8vHah+Klw=;
        b=nZnuuTr2XNGaL+XhOXzNOumJpjxrJZE9Feiq8qmlH9rtCMyrfWA5LK8qmFW36KhoPz
         0t1GFQoS2PSij6+4RY6IlffZFqKvdr6ZV5SY2ei46cuD5vu2CGFCPqnX3W5tgXBgxPwO
         WyYQvFYGbBneLneeAXR8LqWRXGc9Wbj1MdQIoA79SpkWRFlC0ofBAwXCiHUrmKuIBZJF
         CGQVFFrgEqPdWocC74GJFSnJHqjiUtY4aSIL9Z5jNkyABUn/Qj0Q82rWWRHSeXwiVTRe
         XdRb6suBbhl5Tm8B7p/7ZAhVwVMpAcJPwNCINGDkbVeua6oMVzNXWWG5sN6vIQRWV3zy
         dpiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863979; x=1789468779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jl3T9yA5icn0kDud2YKhOUFI5zpsByTY26KMtyiXHpU=;
        b=qaeuMiFeZ6gorAS/l9kOotuRrGXyP1K30N0J9ziMvCVKvHiYBt5am2ORgPTzOFC7UD
         nGXcdkQkfobSIhW0z9zy42lDFW240VrasF71CW+rkMKJ+bsQkkFOXF0SzwTwC3CAdov1
         PAbh3QzvMQ/fdzoTVxLdSrSPU5EnYb58drW/eonBT/fS6ctvdG6qHho03fl1xRhQRwRf
         Qji4NrdVhuJOpPA9L8gxxlsmfn5WksC5thP+3vdtPih9Xs8hMANlmDIdVCaqbKAM0iWW
         2G0em4gDehh+wi6IgTsT55egea4iVrOXU+Stcs8WHz05vM5S160AadyW0bqAyMf3J1gl
         /8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863979; x=1789468779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jl3T9yA5icn0kDud2YKhOUFI5zpsByTY26KMtyiXHpU=;
        b=N92USp2QEs/bO4amYbbE3ZYYFAAvNPwxoGp6bCLISrQ7Ptq4kp6NjUd3bcNrJRyveo
         X8E53t7+9KMXE2ktkUuOjex3J78bhIAkElE3njcNt2QuLMRCmjGFklqtpg2zLcxLBZgm
         zxJKn45NZtkaVGePK0SwVgvsynG0itHSkOryPhnnEV3oPOjmdbN8BCnkBClWUiKa86te
         jfNR16dqP9B1J6jVVb9cTG/9XgqbWeql0Vzqh1TKvGJ+erHVU/OXGqoHX0I9EEtdrBA1
         LAtDbc+i3aovHr+1JGkusFja3pN9tf6fPmU+65wIxeMHb9rbZNtolSTicM+lNQ9XbMce
         uG/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLR3rtaC8cOWO0e/oclOkQbl5m7XERy4adViFY7zltOhBYZm/FUhpZ+S3n8Z8IUQBvUgtYjK4=@vger.kernel.org
X-Gm-Message-State: AFuF++l45k+61z9MGpraV/QJjLSJ5zIykAw7FplViHH5Gc/vPP2mLfTD
	K6McqWMFP9BIirQA43Q//XKHLtUKAAciHj2sXLxIpWcEpOXOv8bv6pOJlqF4PmNQW95WzpgUvfG
	MRQ42PKhVQtI5/cfDYuyfs9jIXI6xeoI=
X-Gm-Gg: AYBFou1wvTQ/8TiEJ9ySldRIP12tGIMBJhRVIfMr5Z9xtsCcdmfhm5p9wPpG2NCyv5L
	XK8CJOne5/SsQrsIcdJoBUBdAOTeeFIAKZI8nM2IiCj+rnZMjuW51DDiqI0AjP1nnDH8pEpvreC
	d0uKBiyNHphVqYXpzpfK0l+b8E2ao7NMK+qiZcRltoUOdGH+kjVcuwWVwBEZaciYzslTh74PhdD
	9Wdm2/5mQudRlQi9YcrApMrYIfaZATYuk1HJqYda94dn8pzY5Zqf6FKV57HuxmifE1xRfgrX3zo
	5bInT+Nz/6/PlCkv03BuoLgDcbbTM1vUcsumN76lfEFmSPt91yo5J9REoM70CiYs0yl6R2bi0oJ
	xCwpnKNsFkKUpop200kNDIl56v+gcoTurAp4EFlU8Dq09jFTolPuIV7N5
X-Received: by 2002:a05:6a00:c1c6:10b0:847:8449:2ba6 with SMTP id
 d2e1a72fcca58-866b2eace9bmr6165210b3a.8.1788863978907; Tue, 08 Sep 2026
 03:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
 <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc> <CAABR9nG49YgFejWRAkJrCcXF8p03A=HwWhbetmoHSjk_L3h9Gg@mail.gmail.com>
In-Reply-To: <CAABR9nG49YgFejWRAkJrCcXF8p03A=HwWhbetmoHSjk_L3h9Gg@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 17:39:27 +0700
X-Gm-Features: AcwNN1UgTF6tGEUV4riCUxY5ZHDu-I4a8KfbZKcCu4UtgQm8VpsUF5cE-CTt_a8
Message-ID: <CAABR9nFg-V9XoNTt=dKCeAmXLECrZT0hPdxwEB4ONKV3kB1BHA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Simon Horman <horms@kernel.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I got this wrong.
Please disregard my previous comment.

On Tue, Sep 8, 2026 at 5:13=E2=80=AFPM Bui Duc Phuc <phucduc.bui@gmail.com>=
 wrote:
>
> > @@ -861,6 +865,12 @@ void fec_ptp_stop(struct platform_device *pdev)
> >
> >         cancel_delayed_work_sync(&fep->time_keep);
> >         hrtimer_cancel(&fep->perout_timer);
> > +
> > +       if (fep->pps_irq >=3D 0) {
> > +               devm_free_irq(&pdev->dev, fep->pps_irq, ndev);
> > +               fep->pps_irq =3D -1;
> > +       }
> > +
>
> I noticed that fec_ptp_stop(pdev) is called only from the failed_init
> error path in fec_probe():
>
> failed_init:
> fec_ptp_stop(pdev);
> failed_reset:
> ...
> failed_ioremap:
> free_netdev(ndev);
>
> There are several other error paths below failed_init that eventually
> reach free_netdev(ndev) without calling fec_ptp_stop().
>
> Since fec_ptp_stop() is currently responsible for calling
> devm_free_irq(&pdev->dev, fep->pps_irq, ndev),
> could this result in a use-after-free if the PPS IRQ has already been
> registered and one of these lower error paths is taken?
>
> Would it make more sense to handle the PPS IRQ cleanup separately on
> these error paths, or,
> use a devm-based approach so that the IRQ lifetime is managed automatical=
ly?
