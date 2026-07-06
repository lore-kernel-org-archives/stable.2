Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62639AD51
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349215; cv=pass; b=SdUUYzjU1Jl63a4O5vqP/cnzwW1JHLc+F2ybewoR6ake+kDlcFagH9DTJ6nYhMfogX8h+3RenqFncbzErLFg4E6eTDyfa0oF0/o+fngNP39Cyzdjh4Aw6b6kg9P3/XhNxXWUMqC1YjcJuoFX+4q+LvQaFkXXJIUEHOiO7MpZ+18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349215; c=relaxed/simple;
	bh=XIt9g8EG67F9cgRee/glyq8tUMfvAYEbWJBaUWy6Nb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZ9fQji6hQb+LwVnvWTrzX9kUUZVxMKyf0s26R62TP8dlLO0kLNrf7yIHxF8DXIu5803AoSp8IlgSfJlUZonEmazcgHLivbr+huny/d/WC+DZYwzewvAtGczw7d2E/HHP6FrY6MQv8onqbjUzCFe22e2Btc1ry6iKBQeBRyJOak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCQVfpHt; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCQVfpHt"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so5443483a12.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 07:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783349212; cv=none;
        d=google.com; s=arc-20260327;
        b=L7g3JdEvfu+sujtx5rJIQNmmqPXLiGkvteOJ/HdSqtAGoBfLnhDfCHKM/lk/zUWiu5
         GaMGMrXpGH3+oiS8eKx499LQOkh/m+BF73PGUBfQ6tCPWp+jrkfV12epE4AoiYKb3lqR
         zHc97PgYFZUZ90E/7FNYGxqAmda93R5qxS75h9IAA4YSgIkgM8qKLn/RjkDpWofqHhZv
         z6D8WfQ7YSspCNo2ql4AEzoNPvBiwFeJVdNw648pRiJaC2OqsYphSNNFULawH9/mNh9k
         Rs0CbEjKENE2KoWmv3Ia3ClqlebD4EA9mNIHPCqAf5CysFXAaQptsgdQpdpbCTDk9ayP
         kc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FORy38h/raNHh5CiZOJtyCT7bYZdVLlFNLJYBpR1kIQ=;
        fh=wOHPHCXpzcR0MBsluzyNGwtGBEezY05glpvhNrrRaoE=;
        b=kjnRf3VpdO/ywiOnQVf4+H7KG/lA2gjDH13zSVM48KGfFtzd0kztmtNhz9eM2snUQM
         pyTWsWG8qySM881o0j7ISFxlckmFeT3uazYNTOdZnDM993tWmItSa/Bc3rLmKkQmZrPM
         m8bQwn1Pr34SW0lQXbLeimh9tv7eskZEv3JbHLoYSqIvNeSVrveip92sFY/azNhUzTUf
         BPuEKE68ApQyRJx/S69knL0PQ7fG1+Fmi6W5A7gw6q9f7bAH7LmB12Lj3W9WU12fzd0k
         zRWjVm8TqKsl2dflzYA+cpT7cm9WH2FIrtZ+74Lizi75uYLrCEKlMJewPGR9d6aE4/lz
         EsEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349212; x=1783954012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FORy38h/raNHh5CiZOJtyCT7bYZdVLlFNLJYBpR1kIQ=;
        b=OCQVfpHtTZgsrQ/QlAMqINsuwa1Bo48ySGgc77RDPte0azTcSNSaOIs51lfFkHt9f2
         UYIBgHzvoJILe6a695tJl11bk0T83K+QHp/fUuKqWoWVY5cCBXVbxbH/PGymR3qHYzx8
         ufFNtfPmojWakMg06hSWxrqFl/aP3sqGpDLdDrgQ+VNF2W0zc39VoCuHbbnXFslAqBC6
         O4juZEXvHMf/AlgZ+hR0s5OjNG0vNORg7e3u5nIrzTWlLLJnDj6Kz9fXiPlXc9OTY7MT
         Dc/kzbOiHFeA78tKa+aBWtkeY6Aa+wVFbH7T47JQ4jser80PvG7LCEzhtp1Jy2QjXG3Y
         hrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349212; x=1783954012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FORy38h/raNHh5CiZOJtyCT7bYZdVLlFNLJYBpR1kIQ=;
        b=YsBCFel/KI3LQl9wkQZKkm8UF604qX9YWfend0YRFtEfbZv6+D/XOv76KhxLECpj+I
         g0gOzOr/a24CnEVyQImq6vpcHXLfUaMcQ5O+ARJYUUIbWE0dwNOYq7kMQQb0+T+7zOkl
         LZsx2GnXnYAnfBziuQvaWmqBSGDuxKXWI1i/C6XLjhNbO8PSUpHWFsQNl5PTACbp6ZaD
         zZgObRRl5XJHPDfFW5IpJRtgHyt0XdvvjIUFiircSrvvJ1yNrovQX9K3b+JwSuLXQFJO
         hPOyapjw8tnFv7WEna+OSsvfx7I50OrihWEpDGNxkeZssL8G7ERwwoja96kOo/nu+RXH
         9O2g==
X-Forwarded-Encrypted: i=1; AFNElJ+kOkSbQBtyasDG5H5Dv0PI621stc8ExZhweJ82PQwsWQueiTbCcZqDJoMODpMlhv+cCTdffiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0syvlXuI7el47gen0dqx4JDYgKnD5VwUTotHxRFrD/9lxun1
	0eJY7JKy9RhXf6suNkZ1eOKWwMuYp0AYUKz3fZhgenVEKRdJN27uj0ZeKeEzob4BbM+Q+vkCE/5
	UEcJRhSkqGVO7ERaMFtr0/i+SP2glPf8=
X-Gm-Gg: AfdE7cnNN9P40bEOIFvEFZxrtgIgfHzbDWtKj3lS41hBtu7OkeXXXeO83EB6v6Q+EvW
	9qYWjHButPHnFd4tk3LLGpjwZpZzLtE5mwT+oL78m2PCLaew934cBjEh/FLfueO3wwLTORaGKZW
	W+h9Cy3jxDfwOSHeMXOm5TtoCW6bgZRGV5U91TKLq6eFsolUYqBvGz6/uf1a1d+oO2709ODUFBu
	qr27K/r5kzl5iUXzeIhPgo6n0Uym6s4RW1M6c6kZbn/0aJefoE1SvWLoMaXb5uEOyequqTh0baB
	PvtMaP1SOuDnD7IJOqB6zc/0UdEs1FeJKevbuG0gd5DLgQ9URUCz13HO2xA=
X-Received: by 2002:a17:907:c785:b0:c12:2acc:c9d7 with SMTP id
 a640c23a62f3a-c15a67f7e94mr49868766b.15.1783349211791; Mon, 06 Jul 2026
 07:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <20260628231634.6752f74d.michal.pecio@gmail.com> <CAFgddh+AUNH9Ji-Qd=BKEDZWJrzPMWN20-g-htQDPSdSehZStQ@mail.gmail.com>
 <e7d49127-0215-4b29-9a2a-e1dc0d889b70@rowland.harvard.edu> <CAFgddhLeQ1cJv-E4mYWR8cs7T2USkrEd5i=uxqkNCH2UWaQ5=g@mail.gmail.com>
In-Reply-To: <CAFgddhLeQ1cJv-E4mYWR8cs7T2USkrEd5i=uxqkNCH2UWaQ5=g@mail.gmail.com>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Mon, 6 Jul 2026 20:16:37 +0530
X-Gm-Features: AVVi8Cc6S4gmNZiqXPN-q3CLCjzsrywYMCqte4aKKTPMu6Gbk__YM43TBXfYweM
Message-ID: <CAFgddhL__55iy5FyekW+-dWD6j913DuEV-_505gKRTT4pe6YPQ@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Michal Pecio <michal.pecio@gmail.com>, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 at 22:40, Nikhil Solanke <nikhilsolanke5@gmail.com> wrote:
>
> > There's nothing wrong with trusting the caller to do the right thing.
> > Besides, if a segfault does occur then it will be pretty obvious that
> > the caller needs to be fixed.
> >
> > What would you do if buf is NULL?  Return an error code?  That won't
> > help anyone locate the bug.  Put an error message in the log?  Segfaults
> > are much more visible.
>
> Understood. I guess my coding style is a little "too paranoid" and
> "check everything and report errors". I understood now why this may
> not always be the best approach in low level programming like kernel
> development.
>
> Anyways, I have done all the requested changes. Here's a short summary:
> - put strings in a single line
> - copy bytes from desc to bigbuffer instead of pointer aliasing. (so
> no krealloc too)
> - change tabs to spaces in documentation
> - reworded some comments
> - drop USB_CONFIG_WINDOWS_REQ_SIZE macro
> - revert USB_DELAY_INIT to original behavior. no delay before 1st request.
>
> Let me know if I missed any changes mentioned in previous discussions
> (or misunderstood and made unnecessary changes :') ).
>
> > I wonder if it wouldn't make sense to split announce_device() so that
> > the first line is printed as soon as usb_new_device() starts, before
> > enumeration is attempted and possibly fails.
>
> The current patch still logs device ids upon failure in
> usb_enumerate_device(). Do you want me to implement that suggestion?
>
> Thanks,
> Nikhil Solanke

Just following up on my previous email regarding the requested changes
to the patch. Any comments on this?

Thanks,
Nikhil Solanke
