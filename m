Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A27551996
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082808; cv=pass; b=Qw691vd7275hdXvPEev+vs6yrV94CgXZRML/YMFEnN5I7HPzQUQWtEuAt/LrvO1cEJ2ginBgYnAYAHuSYhtpLgmfOF2UpC8xKppftdtqXyvX73IVngfw7rmCSDlRVWIrYDin2R/xFmUjW1y0BmLoSlNz2xzpIf2dCvrV6Aiy+es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082808; c=relaxed/simple;
	bh=inGt7PUIBCSA5jlLsHiRgO+zeea4owkWaXIEd1vTJRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC9FghVbnFoAkAJcHiP4f/RAxwEc9Q3WMRqSTIGIAS+czfVWnWKM3MvIPus+jfknsj2wWgenV977J95U9xHdCDDlUMwdXRh1lQDZLcNwsrEd65Hj8976jN9QQStW+NIqgejn2XoGPXbE1GvDqhFQO94teeynnYwukcZPKz2GMeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMiZEXmn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCaFalCC; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMiZEXmn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCaFalCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790082802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
	b=AMiZEXmnwjXyZXwViYJvzc9Y0VBL0FuidDU3zGJrZUGXFESP3MreKlWmGrm0X241dLCrhM
	vrclW6ayX2uTWfvXStGNXFe3ZTGUfjgFaHhCnk4J1906YP5QTwc+/y1Ll98YBKGdS5pmK1
	jOajCwQTpB3jaqpsBEXvPmfm87GDuK8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-VJk51XDHM9W-y9Lexdeabg-1; Tue, 22 Sep 2026 09:13:20 -0400
X-MC-Unique: VJk51XDHM9W-y9Lexdeabg-1
X-Mimecast-MFC-AGG-ID: VJk51XDHM9W-y9Lexdeabg_1790082798
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a46d5e30bbso20222511fa.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790082798; cv=none;
        d=google.com; s=arc-20260327;
        b=HGD0GK3kmBz58tvjlDIZqqgZdnYi4fCnamT1HfqQsX9m6aDh2BjW6Gz2aXQ+Hjdpg5
         hsY0NrnARhhwtLqJ0uQlsONFHEAGi/hKfA30zIOQSFhu7YJ5Kou5ZgpzlkWNFzQGEbAq
         gNZGyqnVcTjLYjgFcJtEQc6idYx8NSrgo0KTh8EeYo/KemqYM2OQj3Y8KJksRMP81GRU
         t7EBVPoCKzkUefcT1XJzSf89ZuqvI/nUF3mV0pkCvns1mNxM+tOD7RokLaJXR6C4Arhs
         yzZEqjBxIxrMRAYdlNXG+ZmW2E2q4jVhPdj20doZ/KGDyQi1RQGZz31pj4i30uh8IMvm
         FDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
        fh=OBTt+UeTCrLsoBw6Tzu+LN8NyfdNfeij5IjN7QQc0pM=;
        b=UxtO6ufX8oQS858ed/74Fqds0evSxY6lQuc1pvXKsAvyvmwh3zVj+wR3Vll1jHvi3S
         tlk1XHlke2UIm3oy41XvZDMj467mt+g+xxvPfhuyDFNIQ6uqjDG91liRkA2StAP7vogS
         VMmy5eRDQfRqey5CSBOC20Fufl3DIgFQHLM+Fesn1G93mC7K4YibDHfkBjskYrFTkZCb
         AHSr8J1A/JynYmYKrLoWnx83FO9/XOpQq8sNq0eDeYrnEyURQFNhpBvid88V5CePkFSQ
         I/smMpSXDkYJJk871XUxIa7yKGiNWYS3Bs5KLHBb2Gy7DkTwVudTdvgeKW0mNjdi4U42
         O89Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790082798; x=1790687598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
        b=gCaFalCC6D+kKmSVp4Ec7tQUA29hXN3qQi2UVbi97fOrLvf251rMOwvTMWsex48dTl
         /vrHNjLifiNwqPh9gprW+D6UFIjn4J3UvNsb/T5iycHHovnIad/0c9JikI9QuJPUgaCS
         rIkm+six2JGKBuGGe2RzIqwfaLSImSHQ7owFbJN9Rqh3l9YjH38LV3Oxgd2zePX06Nbe
         i1gfwNe7mLYfeoXtqaZWeOB+Zcm1TMElKti0iCbbSw/vjzL/TolR9xbmawqys1pZDZYS
         8iwJ2BEDzjmHuCivcYug+jleZK/4HNxn7RHIFiC4ViswjHrG1OljWxHjNZJUFFBJG2YC
         4H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082798; x=1790687598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9I33pkuDN4IfZkeNMg1Yvv3ErOrI5+WYWqPcorUJCE=;
        b=FjQx/53F7/t/5PeglL0hDCX4hDljuzs9fkfzBqT/VE4cj74AA2c99rWOP+kGDWr4+n
         tTzNt9DRIZBm79lysmKnYE3J6h9xiNyUhKQ0GSmk2vdCNSQGc33MDBRLW4Mfz1Lw9dHg
         b0TYstEuIonFj3ksvhWihTDhTnIJ2Wbf3HTJJRp3oFQPZ1G7gR/hU7sRNm8IdrPKLL/F
         WUpPHXo3flZs8qz3t0VPKRyim8VJbpTCCpk0n/WteV2IDgRDhyKAVCRQ8wUvfVy9E2lD
         hVzl9VWbTXyeHqu8TK8cb12ycf1tJhqM5PuRI981MD5RGnVX28sMHTchmzD56/odUgXl
         WjEQ==
X-Forwarded-Encrypted: i=1; AKwUvByRraXgV825pgu5X+vKjeUPT5vfXjgUxbfrhe4qOhFQxlvvEd3Au4iQViopBXzKublc/NzqLUk=@vger.kernel.org
X-Gm-Message-State: AFuF++lRg4dhm98LyvMQVUjKYO53OmfVtr9bXjOirjYDdhuWMQ5uWtA/
	r50Fnp+Bj6mrFdD/RE0y33RQwl9AiTFE0+Qlt3xtD3jNr4IfIPCCN86t2CGSwChncgspKkehsXb
	3eaBaxhvjgQ9vAAGHQPmCSnkqQjKnBtbw2fa/gpTi7CcjqEunc4Fcx3w5wtFf4zE+1jWyhC23cR
	Jdo/JFrR14/fSR/lKKnXdwnt4+CCMMSm2H
X-Gm-Gg: AYBFou3cKSm4Gk8cqOvRv0ARRJs5RmV36ROv0LT0468JCm2f2E7qXzpywQUAB6lRSIn
	9FnR2DtsuVzDjXDIZ/dHjw1h9+F9JktTSCIVu63F2z0TJOWjL1rexdycqnQEl6ll6Pzuc5XraTN
	xPe5ijmIxFqB4s4B2uEBRgdbBCJOjNwWP+y0Ds/oD/GfIw/VOcG0W+bCAG
X-Received: by 2002:a05:651c:1544:b0:3a3:74b7:fc03 with SMTP id 38308e7fff4ca-3a5fbf8a256mr32602491fa.15.1790082798408;
        Tue, 22 Sep 2026 06:13:18 -0700 (PDT)
X-Received: by 2002:a05:651c:1544:b0:3a3:74b7:fc03 with SMTP id
 38308e7fff4ca-3a5fbf8a256mr32602451fa.15.1790082798009; Tue, 22 Sep 2026
 06:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-2-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-2-edumazet@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 22 Sep 2026 09:13:06 -0400
X-Gm-Features: AcwNN1XoYqAwm8srY56UmfIOpo6hB-1PvtnqRUeFXnGwYarvIsoKH-_lnD-tgYs
Message-ID: <CAK-6q+isdiPsQFr0JbRvAHDf32kcYwad4t4Q-C24+WnHvCVTRA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] dlm: fix send buffer backpressure handling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	stable@vger.kernel.org, David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2026 at 8:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> lowcomms.c tests and clears SOCKWQ_ASYNC_NOSPACE in con->sock->flags,
> but this bit has not been stored there for ten years.
>
> Commit 9cd3e072b0be ("net: rename SOCK_ASYNC_NOSPACE and
> SOCK_ASYNC_WAITDATA") mechanically renamed the two dlm users, then
> commit ceb5d58b2170 ("net: fix sock_wake_async() rcu protection") moved
> the bit from socket->flags to the RCU protected socket_wq->flags, where
> it is reachable only through sk_set_bit() and sk_clear_bit(), and is
> only maintained for sockets having SOCK_FASYNC set.  dlm uses kernel
> sockets, which never have SOCK_FASYNC set, and never sets the bit
> itself, so the test in send_to_sock() has been false ever since.
>
> The consequence is that when sock_sendmsg() returns -EAGAIN because the
> socket send buffer is full, dlm no longer sets CF_APP_LIMITED, does not
> increment sk_write_pending, and does not return DLM_IO_END to wait for
> lowcomms_write_space().  It returns DLM_IO_RESCHED instead, and
> process_send_sockets() immediately requeues the send work.  A connection
> to a peer that is slow to drain thus keeps cycling through
> sock_sendmsg() and -EAGAIN, burning CPU, instead of sleeping until TCP
> reports that space is available again.
>
> Test SOCK_NOSPACE instead.  This is the bit that lives in socket->flags,
> that TCP sets whenever sendmsg() returns -EAGAIN for lack of send buffer
> space (tcp_sendmsg_locked() and sk_stream_wait_memory()), and that
> lowcomms_write_space() already clears.  This restores the semantics dlm
> had before the bit moved.
>
> Also remove the clear_bit() of SOCKWQ_ASYNC_NOSPACE from
> lowcomms_write_space(), for the same reason.
>
> SCTP connections are deliberately left as they are.  SCTP does not set
> SOCK_NOSPACE, and it never calls sk->sk_write_space(): sctp_wfree() ends
> up in sctp_wake_up_waiters(), which calls sctp_write_space() directly.
> lowcomms_write_space() is thus never invoked for an SCTP connection, and
> the test added here stays false, so send_to_sock() keeps returning
> DLM_IO_RESCHED as it does today.  This is the only safe behavior, as
> returning DLM_IO_END would wait for a callback that never comes.
>
> Fixes: ceb5d58b2170 ("net: fix sock_wake_async() rcu protection")
> Cc: stable@vger.kernel.org
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>


Acked-by: Alexander Aring <aahringo@redhat.com>

thanks for looking into that!

- Alex

