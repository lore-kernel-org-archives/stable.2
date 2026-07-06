Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B13FD95C
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373355; cv=pass; b=UL837/C1xljOx5tFTOVH4WeJPhY2dus9Uvn/kUcYusl9hFQIJK6aJeHI4ScS2m+O5nSCV5u58alW4xJ0mAZkF5xRNJ993OGyp7EVaFUodhHVLiqXv7z5p3XJmKWxmFzAMo6m5Jb/axgFW63zlQ2quD6kERCB7K7Uv5RQ2n6Exg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373355; c=relaxed/simple;
	bh=ejtDMaJdQXxJ/SvynymwK2ueeJspq+S9GvRCUAy+T8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYp32k3SZan3WKiZdQ4QCm9GkyrF/23aTJRGaYh1PQTXPhQDmWWSP/PZ3kkdb0yiXjduu7Wh7ExWimia/J82+fsXyX5xnJOEIwOt2F93xgMUHEvWZ3L0ry91WlplIwfcfOcuWB78j3TrwEUQM0ggPjwo4bIKNmXP9ShQb0BapMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvNe1Z/F; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvNe1Z/F"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-475417f010dso1921166f8f.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783373352; cv=none;
        d=google.com; s=arc-20260327;
        b=q2zvVMHDwE6g0I+QPtSnz8ekxCCw7jmwtvJV8PB2W2BH6H+V0Da7z0rr5dSo6wckgv
         HDpjdbjpO0HaTKrRSAB2hGZk2rykTtLFr4hn3QVblZNkha9/ESlgq3lUTzD35/3BZzmn
         v6cBq1wCAafxJyKqcl9DRk7pWP514lvmeeokcxvdHcHa61GNzFKpIYxl+liCa51rPN8S
         HLuYKSaqdWtaw6tF/5bXstKkqGmCa/+YsRD6da+xltaD4i9F+MtSM0ebfdjZBLu3ucIM
         i7A5gYZLBwjfiowq3+4xJEBGKcaqfjbKFyAGcUNfMKp2NvJBzkePybidjFSF8AV1Y9wI
         Nn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yV2xPTCF17xoiTfTi0rcuMy0VIBAYGpyV+M9+DsjCZI=;
        fh=9GMGu9EbqiCSh3DA7iOhbFN/tflvVoL7pXEcugNuGls=;
        b=AbyLa30h5zgke2GTNmPbgdK3yqvRXTEY4AaSRUsBLTGkB3VCRIz/Ao3OM6OYraZHJs
         OaxTEJE+tAKNBruFt160NjsZJjHtfPBZuwrzY6ifuv4/yhL8aTGQnN8gZNwdE8FcUIid
         ve5Ttp2rYcR6EqMzVxorXSxcF9IlyIDbtr3NkAlr7vGZCySOnYSfDhFBVoloSUy0qa4V
         f2kBynEEae/PaD4752xiVdJylPc550uaxPVdnc3QvPYEN/XlY4Awr2n7aRwGuu2mJHw7
         gEqAgcjZZr6hBH9pu4/iahse39JfHadlbBX14COHjoELL8eRRtg9BM7sUrqdyHGTF8BM
         5mFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783373352; x=1783978152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV2xPTCF17xoiTfTi0rcuMy0VIBAYGpyV+M9+DsjCZI=;
        b=BvNe1Z/F3ONFfxdTpIA0zE0Mx8tysybqjyNwqf9Qze83M9msFlMfzyLNoS+C58EQIU
         0a3taqt5luWH6NJfQPZoOjFySxCGXqyBJ04XOVV5FBy71wRecAWmTZ6yiC28z0HRPEz/
         XCDd08PizmHlVkKfljBRp0+npGwBBTgP3WZG6c6fWXf+QA1PdMndRxFhKIjNWcuWy56R
         gMyRW5gjnCDL0smQspu8qJ4YmKVK9nfOsmMRZslK9CDTs/H1w3UAeg/H7gx/gs4ALc3G
         +Fgad0UEIzuXMg9WMXNUtmyJH/J6obUv3LpjzthADRpWRNlEHgMJm8jS7dnIiaal4jJO
         D5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373352; x=1783978152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yV2xPTCF17xoiTfTi0rcuMy0VIBAYGpyV+M9+DsjCZI=;
        b=AGtDyPjs5Fu4YOU8Wboch5j8lOuDxe/0WiLMG9iR5EvGL1Y5IH14XLEEYGgGd9w1dX
         avcRu/j1cy6Ny3RUWU68XFlRe2DBCcUN6JDn/d3ALx84AG+jZIDfEu5ejRCm6Ks3rw86
         GCDLIg0+fw7v3WvZSpByRSPyLqzUsMkriM0Gk1GbHuRDJO+CG9Tr0m/oUvLvSIhDoBbU
         IqF3z8LxqADXDUcLPs695x8cdWllQnLyXuGl15AnWYiPEAysBQgWepYKi5EZW1BXuaEa
         eHex2tsAeT/J4Xay7OVnChCFGGFr9/Po0osGl7alP/bF7gFUIISHbDzHTby7cdInB+LJ
         parQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH7jx34rAhLUBYlZyoMIxGbgk+RXi5q+nZKkXQjTbmGhgAaAveTEN4JQlE6J8Sy3CWgQOmx6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmjwiImm7x45xt86OcG3e50uaYbgy7dtzZ+kH4zPTCalbBv4t
	zBsuE3ndwWXGbzjWPxKRfpBHk0dL6gH5YoVHPXi7UhNXRqPFcnngTY6+Cf479fezugYMQ6oOG+S
	Jtwr/F95Ow16WjZ4Bd7hz2i6VokdRukc=
X-Gm-Gg: AfdE7cltXY8EFiRSera0xVaHCbQv+pBLOrx5sp7pdKkRyCH12nZLfP/WbXJm5cMwvth
	E0Ya7bDgz9uX0KcgS5VsDeeUsR3du6eKOKS3WskZrqTpVNUaT1b2MBMkSlESVGTezpOyZavcoM6
	q2Pwd07PKJ1+NEfGXDULJUHNdzfMK7t1u/Kly7hodEPOgWb0rUYmtJnFU8i90xqDzxG7W7/kNBb
	UK9tBqiHsxIY0Z6dhH1ubhv14WW424VHhT9tusqXjZ7E8uYI9DOtaIAyuo8+gqDmRRzqc2XSlMQ
	xiw4ij+5eV0R1no6jnKElBnjQ7DrJ0DG+nPzGVojhBnr+B9bLBMM
X-Received: by 2002:a05:6000:461e:b0:470:258b:b20a with SMTP id
 ffacd0b85a97d-47de666aef2mr2350243f8f.10.1783373352362; Mon, 06 Jul 2026
 14:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706191309.2887515-1-xmei5@asu.edu> <20260706191309.2887515-2-xmei5@asu.edu>
In-Reply-To: <20260706191309.2887515-2-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Jul 2026 14:28:59 -0700
X-Gm-Features: AVVi8Cctz9S3C3og57xfHMRSwiAL9HNQVcXwAkJBNWzNm0RaRb4KC_PHR3BqWaI
Message-ID: <CAJnrk1Z8uS=ZR9HPeuuUiHUcydE6OW9WkmnonqSchTnfmwhk+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: reject oversized payload_sz in fuse_uring_copy_from_ring()
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 12:13=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_uring_copy_from_ring() imports the payload buffer with length
> ring->max_payload_sz but passes the server-controlled payload_sz to
> fuse_copy_out_args() unchecked.  A larger payload_sz drains the iterator
> to exhaustion and fuse_copy_fill() hits BUG_ON(!err), panicking the
> kernel.  Reject replies whose payload_sz exceeds the imported buffer.
>
>   kernel BUG at fs/fuse/dev.c:1053!
>   RIP: 0010:fuse_copy_fill+0x6c6/0x7e0
>   Call Trace:
>    fuse_copy_args
>    fuse_uring_copy_from_ring     fs/fuse/dev_uring.c:686
>    fuse_uring_cmd
>    io_uring_cmd
>    __io_issue_sqe
>    io_submit_sqes
>    __do_sys_io_uring_enter
>    entry_SYSCALL_64_after_hwframe
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  fs/fuse/dev_uring.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 0814681eb04b..f6127c230dd9 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring=
 *ring,
>         if (err)
>                 return err;
>
> +       if (ring_in_out.payload_sz > ring->max_payload_sz)
> +               return -EINVAL;
> +
>         err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &=
iter);
>         if (err)
>                 return err;
> --
> 2.43.0
>

Makes sense to me. Thanks for including the stack trace in the commit messa=
ge.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Same comment about stable@ as in the other patch - not sure if the
commit message has to explicitly include the tag.

Thanks,
Joanne
