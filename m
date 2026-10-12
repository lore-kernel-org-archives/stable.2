Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98D282F17
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768936; cv=pass; b=WytoDxyeYqpsUEINccxMvQLDwqMuGHHx9H3B3MLHoTV99HLyf3XHpuqNvI/UaYE4TkOeB1MvWzlG1BWyQNpI4A9yOmsSSZ9zXHPHogcgxfazZl6Wq977DUU1ToFRPpabza+epUsXkkhMTYxhvfXP9mfpjWliyZ1H8M/A+NN0ssE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768936; c=relaxed/simple;
	bh=MWjvWkkPwyfWYHHELX/PMM9+30Kt6P7OKSDvO5cu+9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVnSExGBfBoXPXeoUGzmoxV93gubi+rhsKwig9JgWSdxWqwB0pCr1kXUOlLmHjlt88XEZ7K/RPYl0H+BlzraVrsxGNeZZ7pGp4FTAcbGMBfuP/Y8bikE/D/KRzFgkJ/Hah+rbeoFh8KWZ+1m02K2TzDc3kdnNQo9czSr0cjQKZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHusvovj; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHusvovj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa29e06bso950568a12.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 18:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791768932; cv=none;
        d=google.com; s=arc-20260327;
        b=gSojhlTJQKEqGBhjlRA0h958ioaWQuk7GwrIH/ETl8ToE8NmCDE2889r1gQ97Y5hyr
         dsYnqGOgpi9NV9oz/uMLD5bB4aA/D6jftD6gu18opKkP/wm94LJ1iUwXNA/C3hZ427ZK
         xBZ+kM28q4EtZFCB62WqhGx3LMO5zOgrSfjkv136yR82uSotNlgISE8Xmrsm3KWJbWgp
         yFyw39lYwQMvXi/EDWAadZBtG2MBBCQT4psWD314CBfti+PQ1gyfDLawjOMqNg/3xW+D
         rMSzuvB514voqlBkm3SCjGJ7NiVyqw3ck8Oxo3H8YFoQZqqzkbioiD1hXsJZXCC3eeFn
         f6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoR9NEoIErL+2TbnevvINQDuo7n5mgemEQNQFCIh1Ks=;
        fh=Ja7eA+8jKUcMjrIVMr4b+QuIwgyjhwThsxRCvQWda9M=;
        b=DQN0AxnjTSBZry5Rxeis4EFT/0QCtyNconxZcP7M7iQpI88K3ENsiG7An3x3O/QLLC
         Bc+TZQHvmp6TVl6Ofbt2T03SyQyiNHvChFSpObfJCWWDtutgQrhA/klepYm2KzDVIl8l
         /+ZGO8MbIjsLtYiYBh6mx1fsWTUdYmROq+iUH4ndNIu4jtlos2jpCmLIi4VEiGOIrH4v
         1rBvY16LMO70EAGTYnI5Mh9z3VaFupz8c+bFwYxYH3Eq1k5QDvZIVzLilXlW25jT2wwD
         2bbgAfqQbGLqeLp4jemFanWuVt3zuOGilvkMIh/nqhgzG/0NucljRMJtuXey3Vo5FQbg
         5aBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791768932; x=1792373732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yoR9NEoIErL+2TbnevvINQDuo7n5mgemEQNQFCIh1Ks=;
        b=jHusvovjX4HaG4nJ5fy8Ph7aZhy1chd3UV+GpLg/A9oSuFGu6/j+tZ+wsmV76kK65C
         +cWLrYXkkgKiYFYlPIH60r9V6hXvWQrGXQX5wyvn7nQUEzAXAPYv+vQzXJbJHTjN+z0X
         UJIJ1ad0jMfY2XUUdtr0LKlwPW2Ed51soNm+52AAjP0erwPWR8lqBxCPJgBfYFjApQ9G
         4VWBrPax4oSCaMFEGCQGDVWBjjdwWm3SrSVSKKRdtUXjxIXZaU0GtLRCtD0/lI2SwxXv
         MHoDFankfVDyPuEgChg+T3cZHRhqijRQ3EgpfxC4QxXj85scxau//aSJkFwQsiUoA4vG
         QJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768932; x=1792373732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoR9NEoIErL+2TbnevvINQDuo7n5mgemEQNQFCIh1Ks=;
        b=AIiLn8Hi4hiKbHtP2qQcth5p4eZdRx2yXKPKcMwDH+QqHekYyaGl/ETYt0BsvflNgV
         4/Wwu0QS+JHon2MemPfODPEHU8wXXEFftUIbWPOpAc4Crfw3tpI7mOJsw+k7w9rWFmyz
         h65oKwiG1Q9ZLxjGSxCfcp0cnjFFMYiPbNxrDPO0GAUgsFAaHd/R/iiWB4u1PtXRSHLM
         JxKsDoSIegDX6zQ257pFpJqP2LhDhGJzEZb1yFsZxIDCO1y3lLHZI+hTC4ivo/D3nag1
         iYxp5T2R60GehAwFSmT9+s7CBDncnQNmizOs7AfsiBiDitEzcmPxfi7K4WhWAb/tXnHm
         3o2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzOV3r/JPIafJuLQ/YRubpvC1/aNdjJDWiLYYg7SlOpozsmYmUuqIMtlm13F6SPkK2/RZcmrdM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyMzFIqS0LOg/fQ3XUtRqefEDS73lopclQOFaP5SQWsD4tppIh
	G1jjfKzjRUPIqs137g32P5LdNQ4aifCwz5QyJrE2CcCFSBZFXM2e4RsnGOfqnnicOHs0lWndghj
	rjhQoxGW5MrYlgEudAyRcappQWYduCao=
X-Gm-Gg: AYBFou2KTbgaumQxcWr2pxIS/A+zG0vUY3dvAUr7ZkicyHC2uPc0z/IteQCxVQ/BMBg
	qUstjOtGLeAmGHKmKjLgCBwKAE4CM5XpqW2tNEyNbAjmObVgu3w3xJNl+fRISQ3Dv0rK6CmKOlZ
	Uik5Z/9Bh4HAzya/sBCZ5RaEu/gpVqYrlYJjxTh0r+6F1KpmqxaZohViwSkaHVV7/Zd45BeQ/WM
	fs+SQYW6qsvFl3ML2PpJNfzRuQn82vviaZ4A83NCjCCCOnMoLaw5bFaI0zPB39coznwzL5GLzig
	xEfG12sUWmMvc4+h3hQsviNQOT4bzLFAUCmltVFSX0SPO7/wq3Z2wbc=
X-Received: by 2002:a05:6402:2b95:b0:6b1:d313:d56e with SMTP id
 4fb4d7f45d1cf-6b1d313db6bmr88532a12.20.1791768932313; Sun, 11 Oct 2026
 18:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904061939.4039320-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260904061939.4039320-1-runyu.xiao@seu.edu.cn>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 11 Oct 2026 20:35:18 -0500
X-Gm-Features: AclHuK-WVZj6lLru9SXw9PdtwdjgOvOcHc_I6ucLMItGFN5juVc-ly692F7grV8
Message-ID: <CABb+yY3pLJ5nYnbFkZc0Dum7sQ+dztUKBc8UgDaEtnq07syHbA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: altera: shut down RX polling timer on channel teardown
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tien Sung Ang <tiensung.ang@altera.com>, Ley Foon Tan <lftan@altera.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:19=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> w=
rote:
>
> The RX polling callback unconditionally rearms the timer after it
> processes mailbox data.  altera_mbox_shutdown() uses
> timer_delete_sync(), which waits for a running callback but does not
> prevent that callback from rearming the timer after the deletion.
>
> Use timer_shutdown_sync() for the final polling teardown so the timer
> cannot be queued again while the mailbox channel is being released.
> The timer is reinitialized with timer_setup() on a later channel startup,
> so polling mode remains reusable.
>
> Fixes: f62092f6d77d ("mailbox: Add Altera mailbox driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
>
> diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-a=
ltera.c
> index 17278c257..7cb91413e 100644
> --- a/drivers/mailbox/mailbox-altera.c
> +++ b/drivers/mailbox/mailbox-altera.c
> @@ -270,7 +270,7 @@ static void altera_mbox_shutdown(struct mbox_chan *ch=
an)
>                 writel_relaxed(~0, mbox->mbox_base + MAILBOX_INTMASK_REG)=
;
>                 free_irq(mbox->irq, chan);
>         } else if (!mbox->is_sender) {
> -               timer_delete_sync(&mbox->rxpoll_timer);
> +               timer_shutdown_sync(&mbox->rxpoll_timer);
>         }
>  }
>
> --
> 2.34.1
>
Applied to mailbox/for-next

Thanks
Jassi
