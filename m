Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0443C13EE
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786544; cv=pass; b=SYxR7drQCW2rJPdhxASb1zXx9c4WbQRFP6kzrIX4uIraNr9iuznqGIiIi4KNMaOpj2YRCVKkvFim/PC0WEnDv/zKWJSK9NgDAUpzv9Wnn03cFWX6T/1eOblGgxUZ1H+bZGZ5bU1l5qNs00S+O0XeoD1k3W4KO55wU5IE/pHosbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786544; c=relaxed/simple;
	bh=kSJIC+r7c/HNToAevJYByYV/xUrFNPPZFO8/z9EyAvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRl0ECB3xje4llI60plcTrZhoiTXJnYvUcayk6hEwceTEwc95PFRZceXhwmBSJMxDiG8EVg4ckoPG16ZYWri5Mfyp9Qll+sExNPKTPC3XnLXaha3hNSqisRq2Zq9wJ1iWrCcv4tt7mG6adnPi1/UQ+AyJi8AZFbcyHofb/BVMfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh1UdZHu; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh1UdZHu"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4896ae35be9so112745b6e.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784786541; cv=none;
        d=google.com; s=arc-20260327;
        b=kdzroE4oAQ3BTnjDPW3Ip8kKMSS/Fp4S0IE4946jlhleLMQ0lc1Yppkvz0/klSmNez
         LgJbiprAhjl30Xed6sW9mpb3C4cvc1OcmHZnNUE5Cc+rJB9NLSXSzx28EEBdE3JuOzWo
         4wWfuLimZ6CvPq7pfGj8lCQxRHVV6WcwOpUVW6Vfv6H4tm59ntR24vsAfa84PENGoR6/
         K1myj/ewhZfCcJuDAWBx02XUGQzI3fGJ9Jm8bCMzQJGUFtc58h/zj6lwkPr5BEPaIefu
         fvA33yLpZVTOdXIXgioqCRvKQPUmCUntgk2ViSW5unDzUvwkVoLZNvMznHPcKzr2lWRH
         aLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufxWwA+zsgVRG3OBUzq1MHpVFzAaHzP7LXBuqA0qU7w=;
        fh=Lnxt2FKUv8J+BkQGhYHXhMwWKs4KPwZ+8+xXn0OmW3M=;
        b=isINJmyGOXn7uCYpYSyb8ZTWg0ibMWOffx21kvxlq93mT4vOHYbXbyMg500+pNjtW/
         S45JTcxMcwNumGUnkmWVzMczbljdpN1bevooDsi01BxfrsN3U5jP7SWBHLSFL4bszUvI
         lGYN35Y615BJwkiVwuRTB2hFyMK2ZP52x6a54G31NPp5uS/6HN6jASQgMY6aW7sH5D1M
         A/+D1RdEGv5Tu1oLHE/Xvq6jQBzxyZEOz97rtZZYPiePdLYJjQMqm3ZRmElURHsn61UC
         NSsyn4Ahc/PnTa6xD09OkJAYzKOni8LZ1yMfY7vRcdIKwTLwYlscC4SPhqOWrGHrwVyk
         fW5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784786541; x=1785391341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufxWwA+zsgVRG3OBUzq1MHpVFzAaHzP7LXBuqA0qU7w=;
        b=gh1UdZHuDXpNFg5DyRGXDOfjLoi7Do9kdRlRceLBzvq4XPpcDLHDARFIjIVlWUoI0z
         x3w3RKRU+HMu37IBMdqOGC9Nqs+2ITaIGjqETVF8PBOy/obkoEiCJ8tmO9D6kC94+Qu2
         miq+Ft6VFv89SLyNFUt2JtRH5w5q0KKvlDBwk9MWrtF4nIJ0zN26+TEs7V6TH1uCvXPq
         g0SSCBami/Ffj5ucWlC0Qn3bnD8TGeH7kEGuBzDxuiYNDlYngY9nUc/CjOB37ztf5Tno
         ll9NOjJ97NiCoZJooh7g7TfVVsDOUOcs7ypgZ505djE1sucEQ9k3q1Rfd6IHebL9LOD6
         CWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786541; x=1785391341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufxWwA+zsgVRG3OBUzq1MHpVFzAaHzP7LXBuqA0qU7w=;
        b=O1j259M7YE9K8q9kLg1mcoW0+0WJXF+oeqvec4mVSyN6MCRXmlEqSOwcK6dmtw33uW
         a2InGf3EI05bYmhWHh3u1xb/ssfN/HU+Ls/YUbBnLaQIblKAtpSg05ZyYQallNTvlatd
         bz9t84CTtlsG9z2o5rtOnIXB5xZyGMUJMXZfLD2gQ4tf8bCY+UUUaln4Xn9y6ysm+HDn
         gt20miou2so85TOnMZE5R7ojPeM77WHZfd5y9Pfn456aQSCqPVn5EyyyfVxDA3ulaXdH
         aXZDj4ijFJ1P7CCjHNkeKLYLv+cIGdcTHOP4v3mt9QseFLzT0gWY6OkKYLjZSpmVF/vB
         HozQ==
X-Forwarded-Encrypted: i=1; AHgh+RphOwIT2SmjOy8KatyjNdrQbZlvNARDD2JxQBaph0B4M3KUqQsIdF+3Qd5Xip4JfBixtTuTfgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwwWmdShrchWmZxaPnABnNOp1h0mmQaZ/rUL2OZuffDX+BeJR
	6tCM1CSRv1kfRF28zUfwgWkB1XSLRca7gFlEqfw/GD8DqGqjhk5GNOdwVroZ3OD8xUIqGNmQiWs
	W1NbnvEg32vjFnqQzWAdcpd/+jpbFvgs=
X-Gm-Gg: AR+sD12lWyckZX8KVkS3wCXNOf7qLvv4BEnxPFZLWPG4mHF8ERTtsQjdV717tOjzCHL
	xi7aYMwGASPZA0GXvML88hS6vZmv+vp2i6pUcvooE0YYqN+cFGc7M4P/A0caYw3Ulobl6hF18ap
	Zq0Tg3tHYkexXbgxYAeAGPE+uowGMMB9s1nAwtSGW+YfVMDOT8isqLJ2YHGEk92Ftby8DBWuSqs
	YgEk1o6l8EI42KzLns0ydsSYr6ayrcnCImoAniaxGms9J96lyf4yHhG1ipZR6o=
X-Received: by 2002:a05:6808:1494:b0:498:37a8:cb69 with SMTP id
 5614622812f47-4ab354ded18mr908582b6e.29.1784786541359; Wed, 22 Jul 2026
 23:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722113919.7723-1-shlomojune6@gmail.com>
In-Reply-To: <20260722113919.7723-1-shlomojune6@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 23 Jul 2026 15:02:10 +0900
X-Gm-Features: AUfX_mx748SPJxDfKeHVwWagkaXlY_LdBHwNk_SRopeExJ0Qco4E3ZNap_FvX_I
Message-ID: <CAMArcTUp5caJjwzFye_iS6kD+34-eszN803wGkhWkueRYZOyOA@mail.gmail.com>
Subject: Re: [PATCH REPOST net] amt: fix use-after-free in AMT delayed works
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 8:39=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.com=
> wrote:
>

Hi Shihuang Liu,
Thanks a lot for your work!

> When an AMT device is removed, pending delayed works can still access
> the freed amt_dev structure, which may result in kernel crashes or
> memory corruption.
>
> amt_dev_stop() cancels req_wq and discovery_wq with
> cancel_delayed_work_sync(), but these works can be scheduled again
> from event_wq after the cancellation. This allows delayed works to
> access the freed amt_dev structure after the netdev has been released.
>
> The following is a simple race scenario:
>
> CPU0                         CPU1
>
> amt_dev_stop()
> cancel_delayed_work_sync()
>                              amt_event_work()
>                              mod_delayed_work(req_wq)
> free netdev
>                              req_wq accesses freed amt_dev
>
> Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
> discovery_wq from being queued again and wait for running work items
> to complete.
>
> The delayed works are disabled after initialization in
> amt_newlink() and enabled only when the device is successfully opened.
> This keeps the delayed work lifecycle synchronized with the lifetime
> of the AMT device.
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

Thanks a lot!
Taehee Yoo

> ---
> Repost:
>   - Explicitly target the net tree.
>   - Add Reviewed-by from Simon Horman.
>
> Previous submission:
>   https://lore.kernel.org/netdev/20260714072705.129262-1-shlomojune6@gmai=
l.com/
>
>  drivers/net/amt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 951dd10e192b..7eb871b9b7e1 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -2995,9 +2995,15 @@ static int amt_dev_open(struct net_device *dev)
>         amt->event_idx =3D 0;
>         amt->nr_events =3D 0;
>
> +       enable_delayed_work(&amt->discovery_wq);
> +       enable_delayed_work(&amt->req_wq);
> +
>         err =3D amt_socket_create(amt);
> -       if (err)
> +       if (err) {
> +               disable_delayed_work(&amt->req_wq);
> +               disable_delayed_work(&amt->discovery_wq);
>                 return err;
> +       }
>
>         amt->req_cnt =3D 0;
>         amt->remote_ip =3D 0;
> @@ -3023,8 +3029,8 @@ static int amt_dev_stop(struct net_device *dev)
>         struct sock *sk;
>         int i;
>
> -       cancel_delayed_work_sync(&amt->req_wq);
> -       cancel_delayed_work_sync(&amt->discovery_wq);
> +       disable_delayed_work_sync(&amt->req_wq);
> +       disable_delayed_work_sync(&amt->discovery_wq);
>         cancel_delayed_work_sync(&amt->secret_wq);
>
>         /* shutdown */
> @@ -3278,6 +3284,8 @@ static int amt_newlink(struct net_device *dev,
>         INIT_DELAYED_WORK(&amt->req_wq, amt_req_work);
>         INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
>         INIT_WORK(&amt->event_wq, amt_event_work);
> +       disable_delayed_work(&amt->req_wq);
> +       disable_delayed_work(&amt->discovery_wq);
>         INIT_LIST_HEAD(&amt->tunnel_list);
>         return 0;
>  err:
>
> base-commit: ba712ecfd942b68b21a4b0a5daaf72f6616cc66d
> --
> 2.43.0
