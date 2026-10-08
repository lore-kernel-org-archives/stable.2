Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235D3EC81F
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446504; cv=pass; b=QHDqzi/x6aA93U05WhkpD5SIKOVgML4AKcn2ZxvdEdZv3B75bsrFfmWk0wWYVhN9XwQcmgqYk4rm08DdYPppUMSsfvyUW00OkZMZRErt+yiE8OK//bYE8UDSsbpL2w0N/I8+x8eHjt5rV1amWl/y7Qztclisen68AQCpyEgI8CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446504; c=relaxed/simple;
	bh=R6nAreG5dHBsQuH2nuqKg9p2FY/GhdxubP7/yDE5muc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYdMDWH+F1yVt+OCZ2q5YWjKvIk+kTcWqhMXdyZ7KH7PwzmlJkdY4nGG4quWNPyI8hIWicpi02QDpvPpRfDPSoHdEtlxuVe1FDVUFIFWe1SijBl5j1NxjY/suNuqngewgIze1nbMeK0NgVcpAIx6TK1plXPPuwXOdJzEGVsCZro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M40mbaAU; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M40mbaAU"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2937c43f31so9849066b.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 01:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791446502; cv=none;
        d=google.com; s=arc-20260327;
        b=Nevq8TIFRAvuEpR5IODJAR76Je/3SrylcyC5ATRWGMJvYQhvTyb9UO9lgLsWG8zk9a
         XdDr6KklFcJJlAgaYed2Vbr2CyR3T1A3g35v4DmKBpz6xfNNa37bpDFXo6Ii7+eu174H
         qA07rA13b3mgTD9QyhfDpWOVPieT44H2Ueg2av41eVhp57GuFD4OB/enDm9Xf1LduTis
         7GIVw8svx8SteZP1o4e6vByGDQkSFZcwNtIrq1YUwuMke+TOji+87jbiyOVHeD4lgpot
         439ZKqVFFm/+GO6mYUszPG6RbyoZL/IqT5peVz1ac76f4ac+RVwxUdhRyityjC7zR4XA
         GgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPO3NQmYgI3jpB+3gN4RVKiWcaKRTUg4yVkiuK0YsXU=;
        fh=nN5zrHGeKqPj33GW0nass6t9NQ8qjlwI/xm/EPmztfs=;
        b=btewW2GCcsblvGOZFW4+4YYzaJGGWyw8eSNNqqovhophBqcRqzQRBewQg6H4Qf9Sqi
         M8Wn0O+Um+g/SlMH5HGsXbPRyBh3dC5yM4T09dBAZ62TnBoLIOgIh5hAailq1CKpp/+M
         nLRKpeefRmVwfhXDKamFMaX6xquKnTmg25QQ3bsPV8jE7lskeDpAntRL1ur/AdcYr+Pf
         lZ5EAibWPhyYp3GE+cfEI7rMXE+kwwBJ29gygWTj7f565NxLTrmbvYVNj+kKj5tVAT/x
         i/5D+mQvV9WxoAW5KL7NtyNNQNaV/cZfhJO2n8wXjC9NDtc12VkR9mTIF1ux3iv58J/W
         i9LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446501; x=1792051301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VPO3NQmYgI3jpB+3gN4RVKiWcaKRTUg4yVkiuK0YsXU=;
        b=M40mbaAU/Gn+59DUGIfGSOs6kK8wKryodWBOBOF/f8KPJhSaAjY09LNfziYU8I8qXh
         NExf/vKRwtFjUvZjw5bDJBfrxMNrSNdTQbZQ4my2vw0XSwvZTnXGQ9qq/Ckn+/RGHkMz
         KpRxdlh9mLyfjFCKlm7lj/9339N9oOt/reTLg5mfIz+puzdi7AgEDrluk4RB7ZRUlgK+
         5ryEosYPUsM2Ix92GzLdo63Ivnm6BinHA1GGL/Hx5Ao+TmP6J41+Vb0EVAozzhTPGWXn
         sidR26gpxGwwi5vJtq+4tLPL5JHy4ffg75dfEmOCueuODHg9t6uKytP6wDvjOU3CK28Z
         aGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446501; x=1792051301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPO3NQmYgI3jpB+3gN4RVKiWcaKRTUg4yVkiuK0YsXU=;
        b=F2vM/MYBUcYnjNV18HcA5d1Cky3H2NGndKjT2KSyIHYX4DDWPz1shg3ucGmeCxe2aI
         meLhCVdDK54EgnpgffD5tY9VPTnoFzDfqsS5tjD/Topd+tRJcjAElaGoXYs/oOGkevyF
         Dj01zLkiNnzwLhN7F1VuOcNdwJ5VmADciQJcVo3p7yPQClUbFtQDhsFo7MpPTLhQw4KZ
         Qn7hn2ddImmszWVfe3dyCnlQPzJ8aU99XREF//Jqapf8/gQVSIGME+XOfoyfPXLA+Y41
         zrKIJbxv5stlPAJ3RkRhl+Y9Y3+6aiUDmq0NpxkiHIRG5SS7zN1zBtbEt9UzuomsQWe7
         OhaA==
X-Forwarded-Encrypted: i=1; AKwUvBzsnDFULp2W8be8Lgd4Jq6CkpAlmdRfBy0fzE8KT9X7Sv42UpcQ84UpZBahPXJ1M+47zbGBfIo=@vger.kernel.org
X-Gm-Message-State: AFuF++kySZxLEVU9U+SidsHzUV9ZVF1SgAQXZVVPeOZ4AH6N0BXmhir9
	mKD6sGqM/YApoonSy5xv79MV1j2W8uO1R+13nBLmfC8nYKbh91Hc0hE0e2whFgHS7hG0Ig4SHOV
	f2TEc0K6LTufZSBG7MpMap0GUc1jKJLA=
X-Gm-Gg: AYBFou1QlB+uXXYdapcDzhL+8odPIDglvDX9U7U/+qjLE7nH6VjugdaCm38m0kD2pK7
	N0mxVakgFZzCF32Jf3Pk0m7uDmECrGpxeyPeKP5Rf7dboz6GmbnC2kFASU7ZlpdjGPoK91JSlvM
	8k6JjTWOCZf/G6uHkPShr1UdaUqL6VJ32g1s1eKKnejeWJFga/kL0ZEcbDZ0ied+DPFxYQiTyoa
	ajhvfbKGtnp/kKsYtbRxcYqIiZQFIHZmhoY7e/wIJsNZTZzHreErmiLA+4sYXAB8fmZYqeHriuH
	BbP8ZztK/W1JJTid4o7H52W1z3DznPREUE/xq4rwCvoG95LSg08mIGBTrXU+yKt3cejLi54ExO/
	KV47ckHNNWPPRVPGH0Y53Zw==
X-Received: by 2002:a17:907:2da4:b0:c2a:f931:3fbb with SMTP id
 a640c23a62f3a-c3190c21de7mr152857966b.2.1791446501129; Thu, 08 Oct 2026
 01:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927064434.3692113-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927064434.3692113-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 8 Oct 2026 16:01:29 +0800
X-Gm-Features: AclHuK_Lktj7p5BchFdW-xuICfCC3cq_YAKfmoW2RSWguLyK9_uNfG9-zdSUFUk
Message-ID: <CAAo+4rVktdBnFKfgJ5PjEQsXqHAJ=NuOXNyhJHQLkej+vGKVwg@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Prevent reusing service connections marked for reaping
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 2:45=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> The service connection reaper changes conn->active from 0 to -1 before
> unpublishing an idle connection. The I/O thread can have already found
> that connection and acquired an input reference. If it then allocates a
> new call, rxrpc_alloc_incoming_call() unconditionally increments
> conn->active, changing -1 back to 0. This violates the reaper's final
> assertion and can panic the kernel:
>
>   I/O thread                           Reaper
>   Look up conn and take input ref
>                                        Set active from 0 to -1
>   Allocate an incoming call
>     Increment active from -1 to 0
>                                        Assert active =3D=3D -1
>
> The kernel reported:
>
>   kernel BUG at net/rxrpc/conn_object.c:465!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Workqueue: krxrpcd rxrpc_service_connection_reaper
>   RIP: 0010:rxrpc_service_connection_reaper+0x768/0xbc0
>   Call Trace:
>    process_one_work+0x5f2/0xf20
>    worker_thread+0x46e/0xda0
>    kthread+0x2b2/0x390
>    ret_from_fork+0x36e/0x5a0
>
> Use atomic_inc_unless_negative() before taking the call's connection
> reference. If reaping won the race, leave the activity count untouched
> and return through the existing BUSY rejection path without consuming a
> preallocated call. The caller's input reference keeps the connection
> live during this check. If call allocation wins, the positive activity
> count prevents the reaper from claiming the connection.
>
> Fixes: 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/rxrpc/call_accept.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
> index 47824120f1da..87bc3af2208b 100644
> --- a/net/rxrpc/call_accept.c
> +++ b/net/rxrpc/call_accept.c
> @@ -299,8 +299,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(s=
truct rxrpc_sock *rx,
>                 rxrpc_see_connection(conn, rxrpc_conn_see_new_service_con=
n);
>                 rxrpc_new_incoming_connection(rx, conn, sec, skb);
>         } else {
> +               if (!atomic_inc_unless_negative(&conn->active))
> +                       return NULL;
>                 rxrpc_get_connection(conn, rxrpc_conn_get_service_conn);
> -               atomic_inc(&conn->active);
>         }
>
>         /* And now we can allocate and set up a new call */
> --
> 2.43.0
>

Gentle ping on this patch. Any feedback would be appreciated.

Best regards,
Chengfeng
