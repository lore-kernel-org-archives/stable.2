Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AF3C13EE
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160963; cv=pass; b=TjvJowN6VV8BhrikVxV3a3Z+CflbF75m15G1F/YcSkjV9RDW1hlIIIM+HoYn4t73LOpiK0D9yshzLVh9zn6WLe5YSs9oV7Ips0hHJFQfLjebUd3NMCr7+j74KjH1qY92DaUJ2lucwrQGFHahK1f2KdLcJHaEf8v8Byj9tR8rsbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160963; c=relaxed/simple;
	bh=eR7Ar5hzbRB02j4/+nLnQvdvDXrSRzVYcDag94nm+Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WA31RwNKtVkayFfwNMfTU0rZPsSpgJ7/s84ZtTLsQI6No12C1UraT7rlxbKoZUf3k15erViFjEVHy4XCKY0K4izW3ru3aPjkJiV9doSGQxXWMTOhPsUn3myfPOzXIhmDrIUssy5K9xQgz77HnqKT/ZTMMFT4/JKm2FVhJpNW/WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=mgeXdJXq; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="mgeXdJXq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1600d040e4so518097866b.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788160958; cv=none;
        d=google.com; s=arc-20260327;
        b=h13f0L7wEBlFptpn3zPTeSlYAqZm9PrNZh9beFotvAmDbsJ96QjVz9apqQBg1ELwdV
         zxvzLun/E3u0UdbDtOyF+HEAtkyBFdPuZtHLNoBRKooBhUfFrt+8Inre8AhMgDqwAZFw
         WntUCo97HywPt9Xe75vRLj3mvPl2ixSGMAeIWKkKvSL8oL0oESWpYyxCxmmWqQo+OasB
         E+b5LclNjCbQWgxrWDbdtYRtAGsm5Q92DfebEmADna4+dM62t8srySUMNv0OsJW9y4w2
         9TVUZCXGZ5zX7PE3fCuJmI/6eCe+iLpB/dTdIDIpFqT/OZ35WWx1pLk5BZ/qVwo616hP
         Edvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PzTSfpqlwmbxqkM9lhhcvAoRE+Fd2+/qhN1A6SnUrnU=;
        fh=FcjwUTHoRzXX3b85A2ml5RGl8GRYrytXk0BpApuqopg=;
        b=Nwb0uvr/NCUrYCPwmDKaoIt6xNoTqlHt+zGnrM+ML88K8WDCCbUrB7+w9i1JWSGgTo
         Bs86kuAKPwIYLsLWmOZ0q7UuicS/nAC/9oly8HLw7DG2afUrlEz0RYi+EK+QqeX47HR6
         Zacn4FdFnPi5N5tGnjM6+eb4Kj1n0FNeugsn/+rjvBf8tfvjL9ceolvugh9GqCaGfV4I
         sbReWQ2gf2fTXdI5mwf4dLVdopyYAo5S4Kv37bqBqozlPegzHPg0yILv3QOT9/RiBbel
         +ouYaodvvrqVnhqCXwc3eQ8KQnBhg71V0UUhI4Bpw1oTI8Zb8pEFbG6ZADvgvfkzP2rV
         DkqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788160958; x=1788765758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzTSfpqlwmbxqkM9lhhcvAoRE+Fd2+/qhN1A6SnUrnU=;
        b=mgeXdJXqhvdzYYSjtrSnsYivYf/qolDP+rHR5CbGq8Joik4Cil2J/hW/0cu4EXqOUW
         PTab44Q/e3AtAvQXpol0fcC+ltYnfDItRYjpZyKvjM1/myo7cLp6sHILwor8AV8XVi5a
         5FUImqK6I+UBs5QLrmCx7S1mBZ7rXDeiQcrDMMRmG9JMWLgbGO6mAvcynVQfCuaw52o1
         QBt2CgAvezMwHXPhnuiGEpHlHDNsWS8A8F1J6JVCHmRWJZvHEncOlzc3PwViCFpnolo9
         5ber2Sqhjfy8Epse2jzseuEzahYvu1r3q8FgpnyosmOlY2NpcgCc/pxVY3z4xbeGDC6x
         ulpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788160958; x=1788765758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PzTSfpqlwmbxqkM9lhhcvAoRE+Fd2+/qhN1A6SnUrnU=;
        b=aRMw00diqPwri4OuM26bjBO+OMCTJyL8UkmaWiwt+Rp7Pu630zLnJ4/l6R/hHC7IXl
         HD39jlBVWrhhDByR0wblFhBFZK3R9F9NBIu2A5uXAjgFAvMl27ZKn0yHMekjHDCkw/54
         BnLQNjlc3OSrcQPuHAl6FoJD7sIlGRWoJ6RIUVvFGGxKPjzAQ9sGpNKekdh9qBvcodGJ
         tXEu0/vVnK7KAWyuWnU/dgxpVFCbWR/PobYquR6YL2YJ9wXqK+U4UPTgd5r7kGjOMuD0
         5YzKxwXWscx8VfXwhdbe3gfauLBCaQSaEVAaUUhG+At9I1C5wZvnVJt2CnWUrHjf9Ssx
         rFww==
X-Forwarded-Encrypted: i=1; AHgh+RoJ5lmK3UZXYLt02X/keHyebYap8zeDChlk67zKwxk6osuH5r2zwo1chOR9LC9tfrAAP5Q3l8I=@vger.kernel.org
X-Gm-Message-State: AFuF++liCOXPjWeWaDAQxq3lA/IgakE3FxJEaLh/kEIjm1DWzImlT3vU
	C7cX1TKJMw5ZYrl6/k2U9aDUBB/SZYylJJGpM21hC9gizN0Y7t2SjcnbFvXhXEKrNThDGOghHg6
	ehND3fEnPkJn3WooxGZDdQVOwPPRvs2MNBTAv9jNf5A==
X-Gm-Gg: AR+sD13VNOVb4NW5urvCVeouJeLlplb+5nN3uHClk18COoj5uZbUSKLK5RMuLQHcQLn
	LlA257YFOK5KJigEzB+9loO9jjaPZ1j34f3aKOTuQyjq9eAhzVNrv0MRfO8TCMGqmYRMc4NUzIX
	PsuU1G9jN0ER0fVxf20s5BD02abIt3eI7sUu0otAPKu/V6q0wOtwZxsNc0MRqwisbnGU/GN5nE8
	gjq9wZFM9txGmnFy+044rFOCgP58Z3qFp2IQCAk7v4Vp8yfIy8PRo0BvaCbI6Y7HWYNUhS5+MVl
	UQr3hatSirqfKc9IymD7xYBLywOintZh5nHP8fLy+PHNNw==
X-Received: by 2002:a17:907:c499:b0:c25:32b0:e56d with SMTP id
 a640c23a62f3a-c2596859df5mr342549166b.7.1788160958525; Mon, 31 Aug 2026
 00:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151621.2758276-1-amarkuze@redhat.com>
In-Reply-To: <20260827151621.2758276-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 31 Aug 2026 00:22:25 -0700
X-Gm-Features: AcwNN1XqmIyq_xmYnB4MNo9LpZ4LoEEVwEA2rI_PZl3k-39auBPXFGRh_3Gsvyw
Message-ID: <CAOJNxRJ3Q7nM27k7pCnWN9Ucb9DW4+d6pLoi5evzOxL=uED67Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: apply nearfull_sync on remount
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

The fix looks correct to me.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Thu, 27 Aug 2026 at 08:16, Alex Markuze <amarkuze@redhat.com> wrote:
>
> ceph_parse_mount_param() stores nearfull_sync / nonearfull_sync on the
> temporary fs_context options, but ceph_reconfigure_fc() never copied
> CEPH_MOUNT_OPT_NEARFULL_SYNC onto the live mount. Remount therefore
> succeeded while writes and /proc/mounts kept the original-mount flag.
>
> Apply the flag the same way as ASYNC_DIROPS and SPARSEREAD so remount
> can enable or disable NEARFULL IOCB_DSYNC promotion.
>
> Fixes: c7a12c20bfba ("ceph: make nearfull sync writes opt-in")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 6c6e9a1100db..d8ae49495c39 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1423,6 +1423,11 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
>         else
>                 ceph_clear_mount_opt(fsc, SPARSEREAD);
>
> +       if (fsopt->flags & CEPH_MOUNT_OPT_NEARFULL_SYNC)
> +               ceph_set_mount_opt(fsc, NEARFULL_SYNC);
> +       else
> +               ceph_clear_mount_opt(fsc, NEARFULL_SYNC);
> +
>         if (strcmp_null(fsc->mount_options->mon_addr, fsopt->mon_addr)) {
>                 kfree(fsc->mount_options->mon_addr);
>                 fsc->mount_options->mon_addr = fsopt->mon_addr;
> --
> 2.34.1
>
