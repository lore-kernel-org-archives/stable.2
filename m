Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD4426427
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326106; cv=pass; b=b0yEiuuy/PqHo3iHQ0po5Ap3Iak/pkdsgFIq9Dh7m3ZB4ooY8JhTtJ1NL7Oyg6bMRHC/1FoKgIkQhHgQ0KL/4/CAawRZOJrCsMUZ8hBIcjnCHwrjztMJud6FpoS9NALE6xJ3k0SZ/rql8GzNU+m/deHPPfabPaRBwWTTEoB+kLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326106; c=relaxed/simple;
	bh=aO2N8q0Q35fQWhEOu/usLOdYao6zCWFoNMCa62VLzWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8nNs9jCAbVd0KRnojNnisXneAqwKD2eSGUwrWQpsGTBpGaec5KYk2AWWLpL+xs0j6v9qx6hjEYwn0YvS5vrpyHuZxiqw2WlM3acwwb/oq69OYmHeecCEjjoAXqgBa50Bm7C+qwLUTXsCUQYUPN32JINGjc7gJ/WVS/eLyZLxyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n246E7PT; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n246E7PT"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e0688b859so235076b3a.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 08:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787326101; cv=none;
        d=google.com; s=arc-20260327;
        b=RiVRs3WDJH9JVRUNw33n841j/vegCsNO/T4qgzVyg9t+w+/zvaQqwCvfteD1DJeNEG
         riMo+abYKOQgkNc1XUjX783vwvmPGLOgPyrPvVuOCL2UdJlVcpTp2NWe/JH8eRmTEpkB
         n3yExDHaWyqEtFdsf5xd334/t/kP7lHyG6K1SB9HvTys0/aybUWbCPhB+srDadvQBgDT
         w07056EOldORopogzfJHuIUXaR+IwFwXickpP74or3KH8GlMLK38PRL8uK3IKbUZIVrg
         oKTyUwPiBcAY4PwlyLniKWVbVNEbLSgF8xWIFu2XnkJHAtUQldpl4uenhTbU6ymdnOAi
         8rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7uiZrvZnYmQNQRmUHNAo1Fr+zNWc8uQD+Fv871H7h8=;
        fh=8jPY/+ha8yimuJ/7lVQm/Tg1Tf1Kqx7W77jdQEM2StI=;
        b=pHqCrxzkr9StTo5W/dnZ99gKUVZq7gqzojXbXr/Im5HtQiqR1QZXmOxIIha68fYtBS
         pEjwqwga6UV8FC1GdOfQFVheJcXYJV71jmGXIfAZEDS1MsSP46dVx/duZTFJbKLE3PHF
         Fs8kQJWquI1xRRFapuUYMbWmDbFbi1DCgio9ZgTGcgvG6AyV5DQHnG5eSQRT2CXKtqfu
         AOaFs4eMtvPMmaW2i4C498YEFQ9B9xfdWdz1KEx0WKwCXqVEiUdO5xvaEM2xW8ip/U4N
         OaYWZruaCbVxG3gdUysIH7VflbjMExt4KDvyNocuVRazZWQFOkxxiwv+Xughg9GFTSH3
         rq/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326101; x=1787930901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k7uiZrvZnYmQNQRmUHNAo1Fr+zNWc8uQD+Fv871H7h8=;
        b=n246E7PTM5z2mMKK6PWxcv1aqnC91L+ktcu3zcWAloiqX/7wRbhdE3+N8IFlgS+SpJ
         oYDPHBkpEULmZuuRV9bwmEUzaX26OEbgNdbdQYQRMqg0JL6obmAehhITRsSBXDKPX2F7
         2ads44Hpe5KQPbLPscp1fX9GANVU21E1of8oLr3R9j1ztbpEPNm9qYmyJCYYXwaMJVbX
         J0OewI34eb9hPOp17xaJZJUjmG3QD3bwElc0UZfooZh8DMEMm9YLhkHDaOgqfmPdzFpq
         VY/9IYFicLAl+sRUgbfLwzz8EBMhZ40imLwvorTiGppIz3t+dbhzbkD041VFA+WbkS1G
         ZyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326101; x=1787930901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7uiZrvZnYmQNQRmUHNAo1Fr+zNWc8uQD+Fv871H7h8=;
        b=HHjVc/UnlcIdY5dfxybBaMOiSOwHf4sRWBFmLU+6l0OthCAny4wDCAUuXeAeXvMN2P
         AXvMKslLrv8Q7dZk6hz5h3eMK3mBmt6J9tPUQS4hEJtv4Ycdg1eXVD++PAgSK1/tLmid
         Bo5v+wMJD9jVpSZJVp0n9DeRBin6JmUuuIPD3mEjeF4p2mS6XTtqumgYfQf6Uwq7LZJR
         J7ic5rkiooZWFUL0zgYKYMCvCRNdNHLlBPg4VN9mcaYTUYmnDKVeyD/n5qrmnIfWtlel
         kFdn+bC+MSWagft6hRtSoiCzxbcDJH6fxng2KYFLxuNImDlGMHlqSM3pMEyPystgvkLz
         xh9A==
X-Forwarded-Encrypted: i=1; AHgh+Rpqip+GumUmXWH4SS+kYZNFL0VEQyplcYy46EdfKAOhPd7b4KqrKM/5SBEuTqpT2OHGORSB0xw=@vger.kernel.org
X-Gm-Message-State: AFuF++l02p2eJdgo1e8W/DoT24Fxy58W7II7noYrEgGSE2fDK+2oSqpM
	9whAV0tCedDUdOum93pkOpEXR6VcV5UVnkEktGHv1nQdGHsq7lNXMxth5KEWCUzAT9yyNcakmir
	2onH2KuvUSeDoZ1jOsUFHqdxkj+4if5Q=
X-Gm-Gg: AR+sD12n1RdTZJjPH6+ZyGVM6m6KVIk3Ezma9DDwEDjtV4hbLRReW0zgCY1AnQ0cxjq
	qqnAsc06RlrYZuIM/YqicadC4SCb7AaIzEU1R7clS0gvLtjnovabV3LzvAvrTEBIatmzFkZ9sql
	3vAXg7HNBxMe/HAYVaRTJr57oLLiNxgfaYGp8NsJVXX+XKoH1K2eYZ8TxBDLuixdPplvrxRlNoi
	AWVCpYKCBlTeT6OAJmrFzL0AlKO4aV7e7AZ6s2XK6jAOiB5u87ijJS07P0NVPtQFbQ4ACp99HIZ
	eoYm0ZngJ2T0ivx4rIYFeKFsPLfdwXPPHkl0YF1EmzyKpSRXcOMuWAI4o+WPeBWdIXyqG1M7aO4
	Mbg0UwAOeWm+upkHqSw3b7DB9HyqgI1Z67Bdj+oMyossvH9ZDllYQM4MtjgbVM7ITzmhoMW+h9i
	ha
X-Received: by 2002:a05:6a00:2e19:b0:84c:4b58:2cec with SMTP id
 d2e1a72fcca58-851fa071eccmr11065029b3a.15.1787326100663; Fri, 21 Aug 2026
 08:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820162235.2668698-2-bestswngs@gmail.com>
In-Reply-To: <20260820162235.2668698-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 21 Aug 2026 11:28:08 -0400
X-Gm-Features: AcwNN1UHjVHC0nrat9gCj5-HdAaF9SV-qu5rB8IwX-X2vzEVe-Gsi4pJ6NsHqH4
Message-ID: <CADvbK_cC8A3vjV0mweyBX_RyHFk_-ruyQ-Wp6UDmWpeAvNMvTQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix NULL deref on untransmitted RECONF completion
To: bestswngs@gmail.com
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, horms@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, xmei5@asu.edu, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:23=E2=80=AFPM <bestswngs@gmail.com> wrote:
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
> sctp_process_strreset_resp() finish a pending stream reconfiguration
> request by stopping the reconf timer on the transport the request was
> sent on:
>
>         t =3D asoc->strreset_chunk->transport;
>         if (timer_delete(&t->reconf_timer))
>                 sctp_transport_put(t);
>
> On the transmit path chunk->transport is assigned by
> __sctp_packet_append_chunk(), that is, when the chunk is actually
> appended to an outbound packet. A RECONF chunk that was queued but never
> transmitted keeps transport =3D=3D NULL, and its reconf timer is never ar=
med
> either, since that too only happens once the chunk has been appended.
>
> sctp_outq_flush_ctrl() skips every non-ASCONF control chunk while
> asoc->src_out_of_asoc_ok is set and leaves it on control_chunk_list, so
> in that state a RECONF is never put on the wire. The sender side has
> already published the chunk in asoc->strreset_chunk and armed
> asoc->strreset_outstanding, so an incoming RECONF that drives
> strreset_outstanding down to 0 dereferences the NULL transport.
>
> sctp_send_asconf_del_ip() reaches that state without any peer
> interaction: when the address being removed is the association's last
> one it stashes the address in asoc->asconf_addr_del_pending, sets
> src_out_of_asoc_ok and skips chunk creation and transmission
> ("stored =3D 1; goto skip_mkasconf"). As only sctp_process_asconf_ack()
> clears the flag, it stays set until a later bindx() ADD picks the pending
> delete up. An unprivileged process that removes the last address of an
> ASCONF-enabled association and then asks for a stream reset panics the
> kernel from softirq:
>
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc000000003d: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
>   RIP: 0010:timer_delete+0x67/0x110
>   Call Trace:
>    <IRQ>
>    sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
>    sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
>    sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
>    sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
>    sctp_rcv (net/sctp/input.c:243)
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    ip_rcv (net/ipv4/ip_input.c:612)
>    process_backlog (net/core/dev.c:6680)
>    net_rx_action (net/core/dev.c:7959)
>    handle_softirqs (kernel/softirq.c:622)
>    </IRQ>
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Skip the timer deletion when the RECONF chunk never reached a packet:
> there is no armed reconf timer and no transport reference to drop.
>
> Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Ou=
tgoing SSN Reset Request Parameter")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Note to reviewers: this only stops the crash, and I want to be upfront th=
at it
> does not remove the state that produces it.
>
> That state has exactly one producer. sctp_send_asconf_del_ip() latches
> src_out_of_asoc_ok on the branch that stashes the association's last addr=
ess
> without building or sending an ASCONF, and sctp_process_asconf_ack() is t=
he
> only place that clears it -- so the flag survives until the application i=
ssues
> the follow-up bindx() ADD that sctp_make_asconf_update_ip()'s del_pickup =
needs.
> 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host") desc=
ribes
> this as a transient state ("the other chunks cannot be transmitted in thi=
s
> state"), but nothing bounds how long it lasts: an application that never =
adds a
> replacement address leaves the association unable to send any DATA or
> non-ASCONF control chunk for the rest of its life, with the RECONF sittin=
g on
> control_chunk_list and strreset_outstanding armed.
>
> I kept this patch to the dereference because it is what the rest of net/s=
ctp
> already does -- every other chunk->transport dereference is NULL-checked =
-- and
> because it backports cleanly. But would you prefer the latch itself to be
> addressed, or the reconf request to be abandoned here rather than complet=
ed
> against a chunk that never went out? Happy to follow up with either for
> net-next. net/sctp/stream.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 34ffe6c945a4..1cb30def2eb9 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -577,7 +577,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
>                         struct sctp_transport *t;
>
>                         t =3D asoc->strreset_chunk->transport;
> -                       if (timer_delete(&t->reconf_timer))
> +                       if (t && timer_delete(&t->reconf_timer))
>                                 sctp_transport_put(t);
>
>                         sctp_chunk_put(asoc->strreset_chunk);
> @@ -829,7 +829,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
>                         struct sctp_transport *t;
>
>                         t =3D asoc->strreset_chunk->transport;
> -                       if (timer_delete(&t->reconf_timer))
> +                       if (t && timer_delete(&t->reconf_timer))
>                                 sctp_transport_put(t);
>
>                         sctp_chunk_put(asoc->strreset_chunk);
> @@ -1084,7 +1084,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
>         /* remove everything for this reconf request */
>         if (!asoc->strreset_outstanding) {
>                 t =3D asoc->strreset_chunk->transport;
> -               if (timer_delete(&t->reconf_timer))
> +               if (t && timer_delete(&t->reconf_timer))
>                         sctp_transport_put(t);
>
>                 sctp_chunk_put(asoc->strreset_chunk);
> --
> 2.55.0
>
If the STRRESET chunk has never been sent, we should NOT allow an incoming
chunk to =E2=80=9CACK=E2=80=9D it.

Could you try fixing this by returning NULL from
sctp_chunk_lookup_strreset_param() if the STRRESET chunk has not been
transmitted yet? like:

@@ -488,7 +488,7 @@ static struct sctp_paramhdr
*sctp_chunk_lookup_strreset_param(
        struct sctp_reconf_chunk *hdr;
        union sctp_params param;

-       if (!chunk)
+       if (!chunk || !chunk->transport)
                return NULL;

Please also share the PoC with the maintainers, if there is one.

Thanks.
