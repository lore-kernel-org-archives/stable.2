Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19287479882
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027637; cv=pass; b=R2LNYkL0gVcIdLkaqI3bHuikQNVc9fYvESmh6xphdoMrGJvKsxIOf4rnuHoAWQ38wZzVaDoE2jzkFJh8n+pmv94i7Cv7GuLcm+xakdL9xWgVgh/AzH7j0I53c7Zz726urTqpLB8PXfFVFDUmUDmZelAkLuw8e/89iHymw0Z2tjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027637; c=relaxed/simple;
	bh=1dqHMGe8skzctWZNpreBsPtlhwxRfPcF4GasJRrCAjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7bNPogCBeaSBFp5LAcGEo1yMXycxnF37CVcimauALUZGdgdSqXg32wCwwezDeoK+B/8uZcNxmAeuuUr7t040pTNxmay6hOEEaJO0y/Vk1xduvipvPTjypWF8FIwG4cO3fBRMJZbFbwfPGSV4n3LYsHVrTocmgWB2RbRCgDB0/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUuFjIPk; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUuFjIPk"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81eac8bf7dcso1655537b3.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786027635; cv=none;
        d=google.com; s=arc-20260327;
        b=X2Yjw/jTPSjeX1efU5YXpwfOv4ZdFfHt5QOVuEOTCCN+HmFs/YkETY+rPz0IUCnu+p
         24gW/D+3hAZ54/mwvYf3mtdJwWEYaQfrXUrEI6+wfxvnNgIYHl0q/ZlAamsqugoN9UwU
         vUi/wnzvaC7qkKadiIe4kduiGitXozVHo22iowPaqXHsY2qqVHK1xV5Kjzva1eeJwLrj
         sIC6XZNs7tu0UVmw77kf4q8L7j2uIbwZ3Uo/IWBEzkyr3k3ndL2X6yJErJaWvodyNzho
         chKGgSPzI7dB/e5c1hRR3R2zg932hXdK7qrfJE8i2rQyjH4ui7/GmJ1EdnhM2eUCY1MX
         DJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FF/8oV1W/m/5WJaUk3LsLXRDZbDYOlh5jzE/i8jDHT4=;
        fh=uT8pBJhCcgXxchxFzPVVDe82jqqTSSv1eiVNi2w+J2k=;
        b=agC1oI+IjG21dtMBBx0UBzPhJkYLToygF612RzvnWvo/d4AWKXR0dmnIdFn+qBMXpi
         KRcuZ1WQ4tEtKzFAHJwnRBQPnNu3gyDShXrshbRXQK975ORfIhNoa7ZHvJj9u3hgnlBz
         5b/cwOFNDzFVLOokuOV57ElIjP5mu0ySvmGSVSA0RuEKnQPfMXpogH9XSmnp2K6paO8i
         LvvFVW7xmiS5AqNprhVMfQlkxo2KAlIcas37RcXK0/130a2w2iMm1nGZ3zONw4D71X3y
         oE35o+sK6W7uIPNPBZd0daZ3bNpQ64QulfyCzigo+4whEX1m92KlMk2ahlr5SVd43YUS
         dkJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786027635; x=1786632435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FF/8oV1W/m/5WJaUk3LsLXRDZbDYOlh5jzE/i8jDHT4=;
        b=mUuFjIPk5w53Jqo75k70PEDHpJX2qUszyX+9fjj6Krqi6zQT11bjCNvNxDNdUC55hi
         R2i7JmZvyeQwCjmUsHBdUeWxE4dYeLT781M/X/85CWz2fML8WmZ3oSQx3vLNBjPsx1KC
         wwi7zJZ+g12RHnbF4DsDFDis3lOA9qcxfYOvAWKtLNmbCt9sbwOr2aJZ93mf1nZilrtC
         6WCrzzVKYSpoT+UNq+FZE9/NXGwkSaXgDma6wFlgvf+ACamjteIXPRgjhR3Ui/QgUXWm
         yGSNlGzR9tkKqm/DFF6ecqtCAd8sb3BrW0cxVpX1Q/Ljb45+sdTlWdHiJlvNNMujYjkO
         AlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027635; x=1786632435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FF/8oV1W/m/5WJaUk3LsLXRDZbDYOlh5jzE/i8jDHT4=;
        b=FgB2d0p5igvWv/uXiBQJ1t/8BPGulNdYUapBZjZMbBRkY8MjNIBnXUAieoYVA4u7T9
         Lp1t6Mug2z+wXbkDA/sIX59d1blOZy+qETvh0hDIbDwx8nPT19VAQFgrbLEkqeuW07ik
         Y24khuZ9aEGSGhulecUVOGBCI5NGhNS0Rv+pS+9Tf8/JJk1k2e1YlnsiOv3NIP0HPFkt
         7PXprPR+M0PtKQGGOAqhWQA67JRJK1dgHLq8c5ePolNCHWg0vTn4QNIK5sL9Zvq90dxT
         IsSTlQY15dXpuwfbYaey1TeVN+M97dh7AEeleWmzb7Hnk94T5ROi2+olBV8XTbM7rhUW
         ES9Q==
X-Forwarded-Encrypted: i=1; AHgh+RppEK8M/7ZVTcrVx3LDEqhTkouherl2Q3GME93otRyMPqRSZc9cvGfWXH98ftU1dgPb3ANoh+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkj/2EuTSwyv/E5SYL/4feE8jlMye/uJJz5iKyLxsnqjsn42AS
	gh/NydH9lzsuLs7HgfqhBHfgFdmdL9Xwvcg/EauoE74djMzjU1fFYV8uWcxQOScb3crWjr3Mydf
	6IYS6rf/rl0rqVthwzge3MP2e74bYxHY=
X-Gm-Gg: AR+sD10S3wIyhrx90ZzG8+AaJ3wbcePvHxRdKUxZEAGIHLTeFT/XwIFp1gIF9VXxJ4+
	+21KrAffxCsmWLKXF3R2XLcAIruZi79jYGN0akoVXwq4LkjsF/fMD3QtpzDfT3tgZuaYLvtykuV
	mmdOHBCqvHmCsRLy0dHUb97RhUxtpJDhzldM00vaesx4IXYxJZIoaGe3GhhB8XHr+EiN1tztGnR
	cI0tVVcigNaWfAmlf5ytlwWDJddYBopBt+GhzMqXf4jmhdAg/7B5ZYN0NPSyigLarJ7hKhtXBdm
	m2qVdNq0v+KsHh/5YGPfOIUEUcsgMyelRnpUDoDmJ57ffg==
X-Received: by 2002:a05:690c:6:b0:81e:78f2:bb76 with SMTP id
 00721157ae682-8201bc3b24dmr97117937b3.1.1786027634430; Thu, 06 Aug 2026
 07:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806142314.557312-1-shinnkka1@gmail.com> <2026080644-suffix-earthy-2f30@gregkh>
In-Reply-To: <2026080644-suffix-earthy-2f30@gregkh>
From: xk c <shinnkka1@gmail.com>
Date: Thu, 6 Aug 2026 22:47:02 +0800
X-Gm-Features: AUfX_mxLPNDZFgj5tvxRDqxdCWqAGuCyWAO7Q99pnaV0Qt9ZgA_nUbjfy9Zj6d8
Message-ID: <CAGeKw7JFxZ6QBg_p6ma2NjPMBe5utoZ715z3763d0qH=uLehYA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Fix memory leak in io_wq_create() on success path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=886=E6=
=97=A5=E5=91=A8=E5=9B=9B 22:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 06, 2026 at 10:23:14PM +0800, Chen Xiaokun wrote:
> > The commit 657ca82526d0 introduced a temporary allowed_mask cpumask in
> > io_wq_create(), which was freed only on the error path.  This caused a
> > memory leak of cpumask_size() bytes on every successful io_wq_create().
> >
> > Fixes: 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io wo=
rker")
> > Signed-off-by: Chen Xiaokun <shinnkka1@gmail.com>
> > ---
> >  io_uring/io-wq.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> > index 66fdd69fd6cb..34a1a9067cc2 100644
> > --- a/io_uring/io-wq.c
> > +++ b/io_uring/io-wq.c
> > @@ -1218,6 +1218,7 @@ struct io_wq *io_wq_create(unsigned bounded, stru=
ct io_wq_data *data)
> >       wq->task =3D get_task_struct(data->task);
> >       atomic_set(&wq->worker_refs, 1);
> >       init_completion(&wq->worker_done);
> > +     free_cpumask_var(allowed_mask);
> >       return wq;
> >  err:
> >       io_wq_put_hash(data->hash);
> > --
> > 2.55.0
> >
> >
>
> Why is this a stable-only patch?  Was the backport wrong?  Or is this
> also in Linus's tree?
>

Linus's tree has not this issue.

> thanks,
>
> greg k-h

thanks,
Chen
