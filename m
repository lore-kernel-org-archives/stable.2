Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795176271;
	b=uu2meu8/6JKCueMcBwlbQSUWDvLu4fOT6S6Bgrx0h+xNzuAHGbfOH2A/6eClqA2rUM24
	 Vg76TfX7C/mKmUDIrTmt30MnTFFdAlTBygG+ExSRPuCEHDOIzBusvomOdrMpAkcwVMMry
	 9IAd7mHvfIBJmhCeD2yeOUbAqVpyU2P5Oh2EQf+/hGMz2HCir65yMG0fCv8o2t4LUtygF
	 Ly0uhzRvtzRvL4KRXuE0giVmlN8JPprTkQNGdrM1Z6b56Qa4UyXzx8z3R4GmjqR7W6W5h
	 uJy7Z7CjZ5BI646fCWJmSQSi8mQ7KdbfxQYidNaTWFKw6Igmiai30jYV8LbhV7KFhTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176271;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
	b=HYlK3XH0tBgMzC1dotZfBc5hFLrhUqcdt9uWxuUD8Kv/TukSprEDs69ObLP5OGDK/+FY
	 Unq+G7LnItl49r9Gm4Q6F2f8IU3ckVp8wf5CTQYNyJyWaOpYN6l9e5eHDQBT9aJo6DhKh
	 k3wj7YTICokt7UUMzhcBqY97CuDM4FYG9xW7LpGHdU8YVH6xepgX7whMiIhfrJDhsNOr2
	 omQcsWbLzbjPW2KAutrdvVjRiqmf4jEL7vvFfT3GE0M/rno0iy1ucRfYlt1jzW5+Kj9Vu
	 udkiZ7pXRkNx0kI2VUaOKgqhtZqCqJNYKX/dvl/2CqUlBaryEeHYIEuFguAM9BaC4NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3uQpmZf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nxZbC5YZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70A606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C70A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3uQpmZf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nxZbC5YZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795176269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
	b=M3uQpmZfqbVJjPN6Ut5ffQ1KdCKMRl+8gJz1myYwkFG1aq0X3VKJEUVBQLP3doPi+DUNx9
	2PX39Dt772bPI5TJ3ToksloECLyXG7+xp/tyBJmpkxe4MCgCA9C87PzUJ9F7cyp5D37Xl4
	2D5/e7fhqHGtwbEwFgIDC3pPnrYT0gk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232--pRh3KYmMQamkoaUg7eSsA-1; Fri, 20 Nov 2026 12:04:27 +0000
X-MC-Unique: -pRh3KYmMQamkoaUg7eSsA-1
X-Mimecast-MFC-AGG-ID: -pRh3KYmMQamkoaUg7eSsA_1795176267
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0f1c06332so13598287b3.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795176267; cv=none;
        d=google.com; s=arc-20260327;
        b=R0rHiZUCMuJEPcs4b0+rssmF6gMiDrlv+Jv3usxtOVYWBHryGurL9xaTThh8cwjDcc
         ussziBDRicxLp3lbsurr2XYf/fEDUg1Ub4vN3j0nRo7tNwTWBOWobFxqnYKlWYRFhhd0
         dFfAcnZgvkBdHnYlGbQxWc+Ug2Fu6RR19CSi9NYqfmNRj5JV9N5KCRW8/DDPNY1gD8w9
         bqb2Zh/IZlEE3yseLm0scRWgJI+tKPsrBnLxRHjDSY3zOyIeRPMPEYl4s6zsGMPbCl1z
         mAHFRgWZuhTqzaSxaXVe6Nkufu+/e1sAX7FXtQQPgyGBffZY2Fgj+JfHiXnm3Ctg5S9N
         MbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        fh=zHIyXoPFAOYIW8fGx1xJoS0fVJxV5crDdtAtO7Y/BtA=;
        b=Go+Tu151NWSjDGXZ8CbEGtYqJ9tLrti2jhPj9IFZ5RNt6kXNFo4tjyAWn7H2zFCEUG
         M1CQiEIq9h6QI0UsOpFKhuTPY44WlP05vn7b5An+jMiHsCvSiAbXozAljGdfa1Oprpza
         B/eG/2T9uegpl2AbzOXnn4/hnAnTBHp5q9Ve2BtrkI5G9i4Z+zqxlleMvjpNyOeAhKjx
         sbEDaRfXi4iphxKqrhnNQhlyVc8H4+Sk5nkWWu+76dRflXQh5C8JTPAQ+C8TpBQHnQ/Q
         SW6j4XImNuV7OTzocQvUbFzPJzYTWr2kTjASbiubVMy95wKYds/Wk7llC7Zq27/QFLSF
         7rRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795176267; x=1795781067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        b=nxZbC5YZPCZegBCOvX5RXZwjKOHM2FpbX/qijsdCCMZcrhShfupgktsMIEG4L0klfF
         serIHzmSktODQUIH3r8fukMrSL0LHU0b6zXUR/MVjlMKgEwkfeOqkVS70vfM6FNK88nx
         ejBvkJTRPPtgHvGqo0giJuLDixu/zqKbUDE0eJ7TuYK5q5qo8e0laqgvCAMJF2s0bO20
         Ji1X4aWOm38bQSTrJuEX04mAr2p1CgU/oUw/5sIh45K1Qo0obp6PSHXwcxOr2WoqKpUD
         Y+YyYNi0sVkd2YB1fs4rMRlknFOP46imWMpVB98pmMl6J+oxotUsSMUgzYgVAC2F4HXR
         kxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176267; x=1795781067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        b=i4eS/PF+BXvT/v26Pu7zDXLFhEppGaadKHcb+0Gn6Ia5Sp7RbnqjrU0p6cavIdG5L7
         BSfuqbPO4oDQLoOyPd3Tv4qKd1fYGPkp+KAximVNrDXx/3WuUiKnNzTqUwh66C71KvLS
         9Ak63nj+zQX6yTJnyCL97BP9qaP9+4osjPRZNWXneyOe37Clhij8keGanohMj0W2LyU2
         P/bccMMd5jqf41EV5Kv4Gzsc89shs9akL+SjYN9bwLXWCKBdd9rC/+HFH+8RbhBI2SMd
         lQecYZLX+J4wQ7ri1HJaXD/wtg9kY0m9xKgpHJPjeC2t49uHbSmT/jDS/FaE/q97TOHt
         2f3A==
X-Forwarded-Encrypted: i=1; AL+hErERWJzX6fnF0kfi/jbE4+IsV3LRkLLEJ9UBqQimNj4PHtl1RYsRIyczZDlH3acBc1tjbU7285c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/w+6tcDbUgCKu7qoJzN4i2cAKWUhZ4Qngza+3oqHBU7YJIlUF4
	Cmjabg7nMiguEtnuB1hWdoEEZDcHyBrPyU4ItGoLu3TLSMLx/+bScaPTBj+UwXfSYKrFcrcB4Pe
	BgPgbjDffPROR5chRsIJgpEIXx9wtICBNYIKpRyPZdqhjTb4zf+f+qC2FZUAbgZpAR2CBqu/zaf
	6b7IHuMIwaxerm93x18lczReoHXLz31Py2
X-Gm-Gg: AZFdTZcWWwCiMbVGcdlSBrYWTpwaaYf6GgywXn3auOGdh4+xhkRpQnaVp8O1IVNzurd
	PjZqIWfjqIrQOcgKEL5soXi4g1hILMDI8aGSdg4e1ROtdS6T5QgjYqzq+O/6rgRMsMjjWlpNuyq
	qYS1njPjnnAF/yfeLTVgnpAawsDjoJYN2a8kMuVmuPoEMsUoL5uFrvoEBmUIQxsGB+RjiEMenom
	BvQzihDK0/l7cUSG1dbCpNb4j6BalbRITM0eRjVwheGFQOFBSLKBSMD6QQ=
X-Received: by 2002:a05:690e:4090:b0:67c:69f:b1db with SMTP id 956f58d0204a3-67df43cf48fmr1438611d50.18.1795176266590;
        Fri, 20 Nov 2026 04:04:26 -0800 (PST)
X-Received: by 2002:a05:690e:4090:b0:67c:69f:b1db with SMTP id
 956f58d0204a3-67df43cf48fmr1438589d50.18.1795176265935; Fri, 20 Nov 2026
 04:04:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
In-Reply-To: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 20 Nov 2026 13:03:49 +0100
X-Gm-Features: AclHuK-i5EtKvbqYrIjTizPF6lX03AG63KfWC612II-z105w9vnQhBI_r_r_XiY
Message-ID: <CAJaqyWfpkenRAYdkeG2+XEWRhJbmV4ARZ+eMm=EibcA6i0z-5g@mail.gmail.com>
Subject: Re: [PATCH net v2] vhost/net: Fix receive queue test in busy poll
To: raoxu <raoxu@uniontech.com>
Cc: mst@redhat.com, jasowangio@gmail.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:39=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> sock_has_rx_data() returns a positive value when receive data is
> available. For sockets without a peek_len() callback, however, its
> fallback returns skb_queue_empty(), which has the opposite meaning.
>
> An AF_PACKET SOCK_RAW socket is accepted by get_raw_socket() as a
> vhost-net backend, and its socket operations do not provide peek_len().
> With busy polling enabled for this backend, an empty receive queue is
> treated as ready and a nonempty queue as not ready. This can make
> vhost_net_busy_poll() stop polling prematurely or fail to stop for
> queued receive data, and invert its receive-side scheduling decision.
> TUN and TAP backends provide peek_len() and are unaffected.
>
> Negate skb_queue_empty() so the fallback matches the callback and the
> readiness checks in vhost_net_busy_poll().
>
> The issue was found during AI-assisted code review. The helper's
> incorrect result was confirmed on x86_64 running 6.6.0-amd64-desktop
> using a temporary diagnostic module containing the original and fixed
> helpers. An AF_PACKET SOCK_RAW socket, without PACKET_RX_RING, was
> bound to loopback in a private network namespace. Across three cycles
> of sending and receiving a 60-byte frame, the original helper returned
> 1 for an empty queue and 0 for a queued frame. The fixed helper returned
> 0 and 1 respectively, matching socket readability in all nine checks.
> This tests helper copies on real sockets, not the running vhost-net
> busy-poll path; the vhost-net module was not replaced.
>
> The patched drivers/vhost/net.o was also build-tested on the net tree
> with x86_64 GCC 12.3 and W=3D1 under allmodconfig and allyesconfig.
> No end-to-end vhost tests or kernel selftests were run.
>
> Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
> Cc: stable@vger.kernel.org

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> Changes in v2:
>   - Target net and add the introducing commit's Fixes tag.
>   - Explain the raw packet socket backend and busy-poll decisions.
>   - State the AI-assisted discovery method and document the diagnostic
>     module test, its results and its helper-level coverage.
>   - Document the targeted build tests.
>   - Keep the code change unchanged from v1.
>
> v1: https://lore.kernel.org/virtualization/20261110051642.249640-1-raoxu@=
uniontech.com/
>
> AI assistance: OpenCode was used to inspect the history, prepare and run
> the diagnostic module test, run build checks, and revise this message.
> The code change is unchanged from v1. The discovery method was confirmed
> by the author.
>
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..10ed2d55ff07 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
>         if (sock->ops->peek_len)
>                 return sock->ops->peek_len(sock);
>
> -       return skb_queue_empty(&sock->sk->sk_receive_queue);
> +       return !skb_queue_empty(&sock->sk->sk_receive_queue);
>  }
>
>  static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
>
> base-commit: 435cbdaf9b03687498dc16fe4af8d16a977e21d0
> --
> 2.50.1
>

