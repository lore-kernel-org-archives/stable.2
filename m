Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1364B2CD7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446225; cv=pass; b=fVklCPCOg4w7rFHt3q1qdpRq2JijOUGF/nZ+sSNlCnNJYUumb88lw8AlYzLFAC9lMNfLcmt5bie0JXWOF0gFeuXtqgiavL9R86Pn3U1mgim8CSATA8CsoxwCHc0YwUXPMSIPFavl6JHpxNCYTwcvmD46+eadUvixm6PpK0WUJjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446225; c=relaxed/simple;
	bh=vZbQXvmGyW1/UKrE0sFXKT2KNHALtKdLQAjyI+9b7Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT7ZfYVdYQMU3Kjf97+knDcUB+AUUoWb1rbVkyCDRUEGoI86NiSmBoLTWgciCaD5c6B0TENavM4cLS1+eIPGvEuh6WCdHO5dy7RWWW3jsjHcmqnoyapzGb0U/A0q3w9RFDhTVKhSC2szyRcaUFZij0xk7/QcIDe0cke2hPmv9Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpR/ajEN; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpR/ajEN"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52f1a320162so21743681cf.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446221; cv=none;
        d=google.com; s=arc-20260327;
        b=VrwKAGzSoETcuqGHe4rrotRV6vig4+BaLUQ3XUTMyEDDKhffVCZ2axiv46HPqVKCCB
         TXz/A1vR2zJYslRqGFlXp7euPMw7jS1GVYvX3rGda0ms8ZIqrk5JXP1OAhALVNnxOG4A
         a+15qXIC9FSZW3v27agpyjYBRHnyBGEy9EuxyCxvcBJ8MmPDAZX+7W8Xk4febsv+rfuJ
         OSGUlQeFbVQd/DUwD75qyFeKwwKV7LVdmwCiouiWEx8vmuLxHy/7zw/10gVOVWnQNllG
         XD3vS1T71/7Lh9aZDtsXcVKwa1CmuIRxqFNPdnOn91Z+X/qVIk+EtEOxv8U+I5xUzIoj
         ZB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=La57paUsnYX53CumeykdWBf/0oLfULFm4zC/h1xvH1E=;
        fh=R+2EjxrjsTfvumSZXsfqwqVSwUgsEyfG9erGEEdf0tU=;
        b=UKadBvGhjJR8f0QzfI3+pVpiKm6nsmhs5r0RGsQVae0+zfzkLTxqDyzVBcX4aB8czA
         Tb+86WCGlIbGXkAEp6zz5sDeHH0zEMprRoKffhkGIST62zZrlGfFpGCLHmobNMA8cQuu
         BvJ9w8K5fxvtm8mFlMoMvBH+S3DRk18Db3bPOaKU+GHbZjymF41aGYHi9djdAp7CK088
         1iem7Ws/AEpGrSHSwyHo1q7ZVAiMydntXUMQcqCp64qLs8gdxUoRyI/0gQ2lIpfrWGd/
         O/h+pJ5duoFPljq8UeLluW5ZQlEBgpEQDhiaOfmlXW4xelZ9xHwepW+ebg7qt0w1M88Q
         EYag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788446220; x=1789051020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=La57paUsnYX53CumeykdWBf/0oLfULFm4zC/h1xvH1E=;
        b=LpR/ajENLlQorezm6bGmW17rCiyMCFOR00SDaYQLOtJ67egMIBpb1DLC7EQHMvKQI0
         aNhJ7Z5m68YtRfIRGpgvPFSLHRobZxuQWyk4NRiSL9A4+h87uFdOxAsdF9d/BDjy3XAr
         WGdJN7Zsi05wZ+/zqmJUUsZRsqlgDuhBN9SKKZMPZp/E2g+qjxyXv4TzFBJTVsPJUZsp
         mcGihEsHywM8wPYZ/ZRrRBkhRcgiENah5+ZkP7TU+IdLbEcV1lXxaW9hqH1RsFRkmbrB
         H5wykIaJnLPUfiIGmQA1WJo7CS/JgiwzKreXSMNrwU8eJ9zVkHgftwIFOP7tkBhP23Mq
         elbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446221; x=1789051021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=La57paUsnYX53CumeykdWBf/0oLfULFm4zC/h1xvH1E=;
        b=KGcqlluq8lfnsRjkLGbKnyBS1qyvZdWmuBXtBrnPEIJPS2jp/AU0ITU/vppbXZQJJF
         cUAc146VgYZ6208DrSC8IOxeaIkHH09KrI7B+GOQJ5zLH7eL4rFpyaof47fCpkhQ8pBC
         FrkJ8ivzgwjfftqOj5+gxFqYytMxK1LsuCWH3ItC0K5+TS3q3uDN2wXD5gkxT5HlvoYw
         29inhAOKq/FqpxmBV9tws56yKVkqwwNrT7oa0KS+wQ4eA67GfvKgIl8g8fBOaFdiIiw2
         /jn80pw8SX17lDosih3zvxc5boc3paKaY490gBHiakuooqz8aqrzZ5hznWbOb2TltwQn
         Ybqw==
X-Forwarded-Encrypted: i=1; AKwUvBwMYwsaSPFi6kZgkbsrTnnpvZaeURHJ6TwcEzFp+Ao21706dcnjM5MXvdWucrLZFqasvl1XihQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nGM+1SIn8V9wtH0vOX+1YHVCG3Hzt1I6KdOJ7XjOqrxIi/YkmS
	JIcuL1pC9cHmsHh/Z7tgCH7/Lf9KPqp+oLc4b2bsfYuXa+hmpV0lupzfDPq9NNyF0sCswyEp+3i
	GzWEEGj4ZXP6SUndVd+abGoH2UivomC/Zj458qviY
X-Gm-Gg: AYBFou2x0SyrSxfUddk9D0go5tW3Ldkcdyfi1Syj7IpaOxXXUnPukm9gvJReQgOU+34
	jfTaQvJVXHDwb3qhv0sg/J8BQFHc32R641AfbzQZGZoNRmxG81RKto6aPRIDuRn99HC3W+FnZdJ
	25c8AGIGZKpCJCKJYlxYbI1nGn+t2udpYWy7BapwQcX3NA0DCei0xKRqnsHbaZ4a6cNO0fFAX52
	lMmcQ6uPUU7KZrcLuJsXBDIGfbUHWed884ixYbfA6IncwzeNhzTCNSepVHdqbw9w7GvWwNKEAk2
	jDuwOL2N5VhYZCHdls8CGRCH7a3yDXoRuhC2XS0jwYOEx9bILCv+IPUpmWbadEiteD2z0DGRKJz
	UYGPtelvDwJF++u34xErcdKadCKqKQM7QuvtPyEBEP06tGN1AuAgtZZEQ4Q==
X-Received: by 2002:a05:622a:1391:b0:530:42e4:f281 with SMTP id
 d75a77b69052e-53042e4f99amr78832371cf.42.1788446219727; Thu, 03 Sep 2026
 07:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903141204.40934-1-yilinzhang@moonshot.ai>
In-Reply-To: <20260903141204.40934-1-yilinzhang@moonshot.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 16:36:48 +0200
X-Gm-Features: AcwNN1XeB6M7fHc8_CMFwS-rDmM8_s4w0a_8KKsMOJLsJdLcokW0Xwm7DJ_4Mfw
Message-ID: <CANn89i+8uLsaq91utS5d_W9ufUP-DC0-j=PRctwQFMTMZ_0FuQ@mail.gmail.com>
Subject: Re: [PATCH] inet: frags: invalidate queues before flushing them
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kimi Security Team <bug-report@moonshot.ai>, Weiming Shi <shiweiming@moonshot.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:12=E2=80=AFPM Yilin Zhang <yilinzhang@moonshot.ai>=
 wrote:
>
> fqdir_pre_exit() flushes the skbs from incomplete queues without
> changing their completion state. A fragment which found a queue before
> high_thresh was cleared can then acquire the queue lock and reuse stale
> reassembly metadata.
>
> For IPv6, this can make ip6_frag_reasm() use the old nhoffset with a
> new skb and access memory out of bounds. The resulting heap corruption
> can be leveraged for local privilege escalation when unprivileged
> network namespaces are available.
>
> Kill each queue before flushing it in fqdir_pre_exit(). This marks the
> queue complete and releases any timer reference removed by
> inet_frag_kill(), while leaving the hash reference for the asynchronous
> fqdir teardown. In-flight fragments consequently take the existing
> complete-queue drop path without changing the reusable-queue semantics
> of inet_frag_queue_flush().
>

> Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()=
")
> Cc: stable@vger.kernel.org
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Tested-by: Weiming Shi <shiweiming@moonshot.ai>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
>  net/ipv4/inet_fragment.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -235,15 +235,22 @@ void fqdir_pre_exit(struct fqdir *fqdir)
>         rhashtable_walk_start(&hti);
>
>         while ((fq =3D rhashtable_walk_next(&hti))) {
> +               int refs =3D 0;
> +
>                 if (IS_ERR(fq)) {
>                         if (PTR_ERR(fq) !=3D -EAGAIN)
>                                 break;
>                         continue;
>                 }
>                 spin_lock_bh(&fq->lock);
> -               if (!(fq->flags & INET_FRAG_COMPLETE))
> +               if (!(fq->flags & INET_FRAG_COMPLETE)) {
> +                       inet_frag_kill(fq, &refs);
> +               }

OK, but remove the braces as they are not needed per kernel coding style.

if (!(fq->flags & INET_FRAG_COMPLETE))
        inet_frag_kill(fq, &refs);

Reviewed-by: Eric Dumazet <edumazet@google.com>

Please wait ~24 hours before sending a new version, so that other
reviewers can chime in.

Thanks.
