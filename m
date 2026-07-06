Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EC13E41A
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372647; cv=pass; b=Irc8SXFA7mNsQnzdLrFgByrCZzvxgoZKw/s8T1QSq7Gp8mH2p33kNyXVmUagTZS2S0BrwFn34QgdvimHvIlhWsldyR1Zw5kutrIiZZn+iHUmJR8pnAAPCQUqXSeASkWwRRrBjeGtzpk2YLMseSGodb2uQtr6PJ2IUCVMxATJFWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372647; c=relaxed/simple;
	bh=5hmxITQTxU5oqfvuwkA0D6iv8dprKNq4g9zC3xDtX5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHUtDiJX+gEYc+4Y37FbYXnvpM79nueAc8lWw8OawO/GnarriNw3iTvXPnK3mPX4lTG1AVAXKrC1CD8xnPwd0Lh+5pFR6s6+K6kFnnB3+KJAB/El2rjUdT1kH1c5sma81Vkv08J3eMHj+cEsmmktteBxAczIPlTPhrgMUFe+Z9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJ7LlAAc; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ7LlAAc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so1576144f8f.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783372644; cv=none;
        d=google.com; s=arc-20260327;
        b=gKM/DE4UgPeJlUDiOUxtwBAxbtf1b6ah+w5Seb+6S6udTCZnksGQuAHUouNSXJmI72
         A9IHnCigGqzfh4FatBe1rF7EldUbOH1wEyHPRc67ahmeWG5EYCJAzROUOYHFhbT7dcB4
         FNyfee8KZeHUhjo07Y2bsebkkE8pul4ADp2TdUZO2C6Q2wssG8OrnMci26vIPJLXM4Vb
         LnOKfXGbP3CDteDzdW9hT1hlYHVb4KWE/AHcTt6Qh750ETZRmM7xIGEcann4I05IcqzL
         +T5z1/Ym6k+M8/HBzPR9nbhatFIhxX9sICcR/nQgjeaXeWKYT3P/WFUvrwvRm7kRfugz
         8GFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1EH4HvAjzFqB9LAoWjiu/mf8HEDcPE/roQ9Lbcev0E=;
        fh=pgRan8mZPRp1uFYHxPoRKCQu/TiVxQqqUdCMMpy83NA=;
        b=R9MeIP8+uIRwUxwlWqC2ox8a/OBfYfRrfHxKLDbqnzZSyKlaMs5hsBM8v7nSZxsgjI
         8gynJZ2PKNKO7HpDB4q673J0BVPXz17aS4p2J/oIn2zokp3q/ajbjSIINu1pt1uh2Uar
         vzUQYTektmbK1ieV6c4L4Gk+gEWwUPN+I0ppex7bqsnne2vsZoTiBrULpnshUBWSoXae
         XlhY6dMhg+2yd2dawBFhENjlE7raQnJyAROVoHGTzY1PJkkCgp+Rtzj3ldoBwRlOhSkI
         1885ynlRXNHbL3fLrk0nX2JKBvQLr5eH+1+K0LEjViFI9GpYG/n1PPL/fitYQh31UUtU
         C36Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783372644; x=1783977444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N1EH4HvAjzFqB9LAoWjiu/mf8HEDcPE/roQ9Lbcev0E=;
        b=sJ7LlAAcBYnvnHENZ6OzXH/leC+3+mx0xMygzoFqYjbtSXbP+4TRvIgI2x3QwEMGiy
         71AS00Dm03VlcLcthfpFQrYz3g8nJGDuz1WP0s4kv+8QBP6VC12/+7gp4SaEc/E+Vvbr
         wALjGo6JpnUyIf9bMgCSUMIMfWEGesNFjGDSrHcQPTKh0kO0jvwCLf1yWO9xie+dDYMe
         MZcW95kFEpL1taHJuynJ/eJYyRkjH1TiAgMFgCn5TSerm2Wsw2QBcIxIVDLqTkk9cYEK
         7EtYHVG6axqxB9n18NPSCPhh2Uj7EhqKXdFLdcZpsp5iOeJ9t4udM03Ttn3Bk4MLV672
         7gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372644; x=1783977444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1EH4HvAjzFqB9LAoWjiu/mf8HEDcPE/roQ9Lbcev0E=;
        b=jG5vthQEvt6RmnYRc2w+sVx2yC8jjPlSlLuwPl3B5f1RjTIQpnsWiG7ccQ7wYeLMVH
         MCNOsTNrcREiyym2GINqyLD8W0WN4Mxdq9gcWA4L7GhH/DjFhDVQA40KlVbR9vcsAhNE
         ZgvB/pmTiOa4iJLCgIO1apR0pga6F5bKTH5PaPvXsAzLL2gz1ApVegQxqaTLP2vBrg/y
         rWYTI1Ygh/jbBTaGFjHITSa/B0+2qqJg/J/n/ZECPb62uO2UafV4XbG1pTDiyJWPkUOl
         J/4GeY2A0wPi0UQzhwgo5cjE9VuW+W6NiAGen6CZxr+aMXqyRYrrM+2t/dro/J07z2fa
         SuAw==
X-Forwarded-Encrypted: i=1; AHgh+RpTgL0+5hP3C8ayaSmf+IlJhvoyZZ56CoTRQQ8Di8bRNYm90KsUAjJqUIl33tIqs21w8LOoP+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJN9phYKnEQdjKlMONP6OAuH5L0jez2IiYMEnBhuIjfwKQ0uGx
	86uEvug7VvLvkNZsUgQZ2RmieWnCXLZXtUzRO1QIkJtoK81vqfh2Ysns5uix8Vkf/hFn32w9FkX
	31mwe9YmJMn94mUnaShBqWHAr7SndWZI=
X-Gm-Gg: AfdE7cnOhASeHXU1mB3zj54wAAIevQdx3iQdLiNTjZw5t+CqGwKujOpZJ5W10SHTtfw
	vb6JY38JNwGhGjA3yhTVm7oci7z8sX7TkVPNC+m+suSgNVb5BX6InDSE6s5LE2i/ubrjrg8aqGD
	XLCP0u7kr5kQ4ENNG0I87vSX1c2XjOZtJMXrQrE4dJjfZwRDPGYfpOv64KLODeKLoDfkGlc+jwQ
	yG2QjLNdQH4OsCv8DQRgIfGK8IoahlqUi+2CrCl7gh2TE/1kOTompBOQQyZA5FMgzhh8U+2z+BO
	Z5mmC221zvToLi4aXiFAh3eeuQ6ScUcYQ6pjpdFII0wzGJ688zI3
X-Received: by 2002:a05:6000:183:b0:46f:558:a42a with SMTP id
 ffacd0b85a97d-47de66bf0b7mr1654688f8f.34.1783372644027; Mon, 06 Jul 2026
 14:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706191309.2887515-1-xmei5@asu.edu>
In-Reply-To: <20260706191309.2887515-1-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Jul 2026 14:17:12 -0700
X-Gm-Features: AVVi8CeLl70LmbEJm89IYL8VaEOLF2oP3HGSFH4iEpvjLG2luGpZkc10MimFUpU
Message-ID: <CAJnrk1Z-6ezCKAEicOEoFVJfhg6Es6R+E=iH4HepmwrpBiETdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: copy request headers via a stack buffer for io-uring
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 12:13=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The fuse-io-uring transport copies req->in.h out to the ring in
> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> Both headers live inside the fuse_request slab object, whose cache
> (fuse_req_cachep) is created without a usercopy whitelist, so copying
> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> panics:
>
>   usercopy: Kernel memory exposure attempt detected from SLUB object
>   'fuse_request' (offset 56, size 40)!
>   kernel BUG at mm/usercopy.c:102!
>   RIP: 0010:usercopy_abort+0x6c/0x80
>   Call Trace:
>    __check_heap_object
>    __check_object_size
>    copy_header_to_ring          fs/fuse/dev_uring.c:618
>    fuse_uring_prepare_send
>    fuse_uring_send_in_task
>    ...
>    __do_sys_io_uring_enter
>    entry_SYSCALL_64_after_hwframe
>
> Bounce both headers through an on-stack copy so the usercopy touches
> stack memory, not the slab object.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

I think the cc stable@vger.kernel.org tag is missing here. I added
stable@ to the cc list on this email, but I'm not sure if they require
the tag being explicitly in the commit message to get it backported.

Thanks,
Joanne
