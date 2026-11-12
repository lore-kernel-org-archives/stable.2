Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493159;
	b=ut3GVgUEaDL/hn3cl+Vr0yc/kQCNEE5Sq8mgLnE926+viYK7GEfCDZMYcV5IeeLiaP1f
	 BQyyYDZEsdt+uIagAHJ40so80x2TlEKkakHvc36m/0Dtgk4Hv123XsALy/46AAwG6QE1i
	 JDH5y7S8rB0JfKjK9CAmv2C6oYmNlPaQUMHM3AzH3Kic4rdCp5rFH/D+ti0QKlhRhY5h1
	 XwnWT6oXB94pkNdiec6lf4nCaVyQcboeXwXa5ikeoQ/Gqx9aDv6cLNOYB/2hR2ci1VjFD
	 vufMAVnBKHpjvEgxKfGsLtBh0otJJ+RvlUzk/ry9S2DGYozqRIG+bIs9n4TAuHWuKQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
	b=HS23g966mraNki5wg/+YRHWdApBegGkxEbBoT2CNEUjFhs9qbMwX1OAJcLUBYyZgaF0z
	 Pkx67I+qrvVPoqGHHXU9d5/2PvKHUsho3o6sQwicKCgvoE6vV6MokV5qPq2yuevfg/Pva
	 Zf4x4JQ7yNYTjJOLx78ovoywnutO9XUjoWsPmwH4vnaIJVNy0ahtOaL6v3/dU8Rta2fH8
	 THvQuwb92+fVL1CshXuC0pU+rjRQuO8m2VV4Fm5Ns+19we+BdzPIDa2qa2rTHy+ScpIi7
	 8scVBnRzGEjsVuE7DnMPYqo4QptFET0Lg17gP+sOHDQjA0ktDqCoXeeKLiR465r9Y6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n740z2IW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6B606F906
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BF6B606F906
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n740z2IW
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-486f013db83so1532412fac.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:19:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794493158; cv=none;
        d=google.com; s=arc-20260327;
        b=js8bANyYywk+GVrjI30H2x9CJoWEvVffMMGL6PRmCtc6JUYl0okRVU1g9NaNPOMDVy
         vf9sNvHuPyU+f4PTSanGD45vKOD8vF/w8JNeHH6neJ9s18jmICA4Mi4cgaWV8zHvfOzG
         HBhq09zrOBhOEpBNXZ1may53xyyNq6E7llOzsDgSallfes2Ilylw46Znl+4ehvNpYuS1
         4e88MPEUUhscXmnLQ0nF7ttnj0GtvvsFgSmdiO8rRJQFHqZWvLx4jakRuhI5N3I0vvbH
         oLh0IAYzhaLxCFqO6x0V6kRzv43HtR+vzkzU7CqkSBRfq1g4wTmWhZYjmK04+KiosprR
         IMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        fh=OAeyGyC9sUXXLnLFC1/fgzv/esjIHhWwgJB7rtl/LzA=;
        b=UYcqJczD5n+i+sz/YJCGZyOFRUxzVPguoUe/eGB3Ly79on6tRZYSO1T4dKzs2YvP2w
         oGFjDgbCQqPuAM/QSlfVYRFiuZ/dViR9r7zyDp68rS7rdTF9dJaQJBrXCTiQyMv1GiKv
         m5aBvCPV3+xDXMFW1XuzUg+hfLLxl2TyaqrdSfLaIqE/KFGTh89wy0ul2RPD7yYMUHv+
         XNSLOeUSpplmj9F05OAjJCVpICgKXO9LoPAtMyrJJIXd0lzg7R1aeKgT1WTEiER8eiyu
         fmziI7MN2W1Dc4PgBvth0PYdxxSyQd03fr18K1Ztw/I6IAxWaBbzRSFfqs27mQnblGT8
         ZSQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493158; x=1795097958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        b=n740z2IWYCmLBpYIgW448OkK5o3ft2gBxMpiTJ48LxTVxlMv+7UQabzWl8F6WGKYQa
         XOfd8zRj83llakPGeaGvKqWA1+fkHDUv6vc50OyrXLWCPWh6/t8U6bdPN9+S3G1DjowB
         lj02JtRwQz4UnVKEsAv+Apof0XrKarU3AkD0puPyB+s2T18f7BeAZe/GWMdgaSvY4NLa
         mpjbtSeIuZPbTZJz+aluoECSmzpKAziUUS83YuZBggqNkBcaBQ9Ob+mKPtJP5/y3xtWK
         Yboa6/x23UgnFTTfsxFTFIRiSHJ3qlAt+HzWqjptrbJHXV601r5hfhzHbCGQR7h3YTJ6
         L2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493158; x=1795097958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        b=W/2gRdtFJlPsLEgKxqgi0OT4rdJuyOk1KWEHlHMe3mUXcnWCtTHExbALY0sOIl1weX
         EmGycvHDCM1ixd7Qd2/wOrR/fiqRfqtXqrFMYC3fOttmyRvUTqvwLkPj2u5IlLBWYm0G
         vvxbO6mcTHF/JxXFJw69rD/dpmbMDBRm7mVTu0lDhESpg4OEC/2umouoPIzY7wQKoeGp
         x5CgkkrHYOtHkAetDNlBM51g7hu4a92Qt6IYYubuttkKI/FzjFXoMC43tg13/upuny3C
         GVPMi1k5l5xe7FrocKWFZIrVJdEvdacRi9bNu7MLJdMMhNe3f/LAndFTySu6rXJOzatf
         lCOA==
X-Forwarded-Encrypted: i=1; AL+hErGjwlLw/ujMZZP2tW3T7nUgTcTxIghSTRjfLHEKNQdmPs7lGUiyKy7dZI4rzBY3ZoFubOJ5S8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zi99EmbmLhHYR8epDMJBM8rm9nRMa7X7ojacK3ydbq/XfX/sh
	ZQOSK65BrheIpCxM2p0hbQSnDiLNdZAETPqjfdLjb6Cztkj7sMKZickkDY7K8atrXMh6VIA7ipn
	Wd8owZP/WNVrGIdTRd4baA29ZPWdN8ps=
X-Gm-Gg: AYBFou01h6Linah+uhFpJxu4+icGYlVOcFBeQyswvDiNfXLsiVnHj9OUNX26IRMAgmp
	+E4QBuExRdpkWW9/WBR/7LT7YRMc6pjkhBudQVcLYLggF30VA5l7Myvyme96QSK5+3TF0py8Hmk
	tttzK1O5TKnyQPTjq0IKMc04yE9fgsm8KF1B524Cfio/Fa03rLJYbrOERzfnneknoIDWFwCpB6p
	qjWMVmW1/LO/X3bMkfgnTDKSEXtWU3SvCyXYVFcraCIht/6b9iBuinHSHWlpSZtG0lhK5JZber5
	9hIP0l3aV/NqxMjJlNflyJ7NcQQuTWKFKZJyfo4IZFoFvm/RGa3IZQ/+GR6oaP9idSCembDqZ+h
	flXAtUlXtwi3kHODbmSDncxMZYUy39XBnTvAEL4bD3jk6H5InxBqcJjVaF+rzuYTergvj
X-Received: by 2002:a05:6870:8186:b0:4ad:8800:b277 with SMTP id
 586e51a60fabf-4ae46b9f2famr4644533fac.24.1794493157905; Thu, 12 Nov 2026
 06:19:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112091451.22969-1-amaan.cheval@gmail.com> <179447532371.2168702.1261444176228225499@kernel.org>
In-Reply-To: <179447532371.2168702.1261444176228225499@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Thu, 12 Nov 2026 19:49:06 +0530
X-Gm-Features: AclHuK-8r8_CUyAx0z3-RpELzn7MRNMdR_7wvQomD_xLmxRhfmXb6fT2JGFsk1A
Message-ID: <CAG+wEg0k_VuhZ5Y4zPyUvaTmK-erV6=A6TDmFS5E9Ycu5B1Rcw@mail.gmail.com>
Subject: Re: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the
 pagecnt bias
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com, 
	przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:52=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>

Patch 2's bug was triggered at runtime; patch 1's was not.

Patch 2 (the refcount overflow) was reproduced on gVNIC with the splice(2)
relay proxy described in its commit message, on GQI-QPL (n2-standard-8,
6.12.113 and v7.3 mainline) and on DQO-RDA (c3-standard-4, 6.12.113,
where DQO-RDA still used the bias). On the stock driver ~78 of 100
downloads through the proxy failed with EIO on GQI-QPL and ~39 of 100
on DQO-RDA, and tee() of the pipe failed with EFAULT; with the patch 100
of 100 completed. Harshitha also ran the reproducer on an N4 VM in
DQO-QPL mode, the one format I could not test myself, and gave a
Tested-by on v2:
https://lore.kernel.org/netdev/CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYECt=
s7jiNhA@mail.gmail.com/

Kernel messages on the stock driver:

  WARNING: CPU: 5 PID: 1198138 at net/core/skbuff.c:7324
skb_splice_from_iter+0x118/0x300
  RDX: 0000000080000000 RSI: ff34c0bcc1881c00 RDI: ff89153145163c60

RDX is the page's refcount at the sendpage_ok() check: INT_MAX + 1.
With tee():

  WARNING: CPU: 7 PID: 3008617 at include/linux/mm.h:1456
generic_pipe_buf_get+0x51/0x60

And on GQI, once the pinned page comes back around the ring:

  Pagecount should never be less than the bias.
  WARNING: CPU: 0 ... gve_rx.c:507 gve_rx_can_recycle_buffer+0x58/0x70 [gve=
]
   gve_rx_poll ... gve_napi_poll ... __napi_poll ... net_rx_action
  gve 0000:00:04.0: Performing reset

The reset recovered on its own within 1-10 s each time and recurred for
as long as the pinning workload ran. The reproducer, full traces and the
kprobe measurements of the refcounts are at the Link in patch 2:
https://github.com/AmaanC/kernel-bias

Patch 1 (refuse XDP on DQO-QPL and GQI-RDA) is from code reading, not
from a crash. The DQO-QPL use-after-free on an XDP_REDIRECT to a copy-mode
AF_XDP socket was raised by Sashiko on an earlier version and I confirmed
the path through gve_xdp_done_dqo(), xdp_do_redirect() and xsk_rcv(); the
GQI-RDA NULL write came from Sashiko's review of v5 and the FIFO
allocation in gve_tx_alloc_ring_gqi(). I have not run XDP traffic on
either format and have not reproduced either crash. Patch 1 is in the
series because patch 2 makes that path matter: with the bias at
USHRT_MAX the driver hands its last reference to the consumer once every
65535 handoffs instead of once every INT_MAX, so a copy-mode AF_XDP
redirect on DQO-QPL would free a page still mapped in the QPL within
seconds rather than, in practice, never.

What I did confirm is the attach itself: on an n4-standard-4 whose gVNIC
runs in DQO-QPL (queue format 4), Debian's 7.2.11 kernel accepts a
native XDP attach once HW-GRO is off, Rx buffers are 2048 bytes and the
queues are 2/2 to get past the driver's other checks, which is what
patch 1 closes.

Thanks,
Amaan

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
