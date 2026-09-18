Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8E4973AC
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759007; cv=pass; b=LvL38CDM6uaUHGV5oGV0+zWwhX/g083gWaPad6N3DwaXLNUTA9Opby/jZHvsd5Lm1Tl+f+nDYbfiZFFWEnAZcFeBxBVJZXaq/cHwE+McuL4QFU4PZUcRWQxZ7tyanW7i/3heZWeOXM1PPVi4lrj6LVv7fbqsMY5bTM8dbs0rHEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759007; c=relaxed/simple;
	bh=+kE6pypIWaqxLT8QpMKE9tCP/YFqBTg1ofu50nK/3P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA/WsHO4CBqNUCwVpTthRYHEu6pZ7tZ5V8on7ckGgPevW2W2cTH3rKt+D1uD0sHavX8s5ujE3KTbzG0MJ9glWmONgtWBFSYu0HKBvpAPAUvWSBh91eniboL9bbxHn4VaL3iwIQCrCJfngSQNmtGfEPC/p7tA4puGcWiBMKozK+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erf9Ykr5; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erf9Ykr5"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-868b2e5be4eso640007b3a.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 12:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789759001; cv=none;
        d=google.com; s=arc-20260327;
        b=ghw+UxhZ82FuN6Bb2x187FVxLCOA6Vx5qO4gqmH+A36viqCaSFMPVe1gzHpQQhi3sh
         4jiW4bMFEuilq9V6OmC/i2eLWdAsisf15WQRaACIAaSa/HnJR8wCMDcqWT5XqBovjXq8
         0MGo8PUzqMkkqU9V6h51J8bMftIhydSmFbZ+ulFQ5WOh1PMIjPB+5bJY2OVZ5+/UGD5Y
         C+mQ+6gXAykCZ2Red+XwLdir5blp23pfUcoDIdAcSpxOXUuV1JD1cIeblgtowqKhqxfa
         fBtWbxeefF2kQfU2fURoN7c19rO2WqStoKrho6NokAOA50wiwblpxytvYXee3KfxVyxV
         7FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJwwvlLAahzc9A5+UQqMnavkFy6oQ6Danu/5kn4VbWM=;
        fh=Os3973X8cot2ucdIFvOwFvLZdTK+/xIRZFQQTsO3m+8=;
        b=ZoKwtLwXWRsATiawlXr3kmNQfxU0caO/WjIvA1TlU0Ktd0BsYiptbxGdolEU/+EEv1
         S7x5ZKG4GhUwlSyKjQE25/u0tapFSug0F1qbL5u2ttVFl2ssNI6QsoXzVvbK+g8aBj+a
         qgPmUKpDvR7mPpWZnGt9ZSWQi8rgNMdBPZL1Cu3Pb2qoAyBlTucXwMQ6QevhMpyW0Bqr
         pXhl4vU3/+wPbjhgFEdtRsXURWgqOLGEGfKofOG2ErPxa1q3vPAf2EHY1aqBMr9hc8xF
         4t344Q8q7Q5/D56NtbQySM23/ZW3EgsSLRDxB3Kqi3cU5pBUeKLwmIH8LzPjwH0xzDhL
         +q9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789759001; x=1790363801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJwwvlLAahzc9A5+UQqMnavkFy6oQ6Danu/5kn4VbWM=;
        b=Erf9Ykr52vavvtDfAakUcqixfTvtOpyvQGK9cr/dhywTqihcIlnzOxpBa+WJ2Jn3J4
         cf4IvkwWgJHIsn0IrsCPvwB478Bcg1xvJ1C27Z8Jf8E9R7Fse4OfWCgbLgahclmfjugq
         R+HlCrlzZfO8eDuT3BZYD3Q3Hj41TsVBuHVM4UZDjp45ui7VRGeaHiSxWAeYZ5TFd7UZ
         iCvs6kjUcGYDcd5nBrMXBCc7fpcUq6BJ8u96ZF0jX0NGjEHzM3zoXpEEeKXprH8KWr4g
         8gqriqQy1kM86QQn3vMxrJSznXq9RGKflNZu8YfHRpM9nbE5CgO5tVsX2H3AS7oaJvsz
         5ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789759001; x=1790363801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJwwvlLAahzc9A5+UQqMnavkFy6oQ6Danu/5kn4VbWM=;
        b=1E6E6b7q3qp7M0m8i93rZqkxl2N/9QL3driCiXFM/n2zK3/1f8AXNL6jufa9vBCPzF
         xeai39ru8KdX+RDzoeIoNIW7/B0MHzAT6cjH8/2fyuIVO32WUhp4vQ+1QM+mwcY3FFDI
         DXHn6W4N9yKFtywwQBts6RwefAovLAnZJibXBbtRhsf360xVgA+PN6KtCZa8ewlLwExK
         lCzQoH/QvFiEUR7SwfvJyTWKMTRm3NrQ37RMG/T5XCH3a3BMg/kCj4ogFFrPn7zJAlnk
         IWeBImBLE3eHFPmne6dXcx3VAnUuCx0xQPLkRkfpuMlH5wIkBWtSK4HRMyZM8pfdcfP4
         tsBA==
X-Forwarded-Encrypted: i=1; AKwUvByNYCx4jV9cqmkPpPfnsJWbc9KRdxUm57AqxVBGW/6v4pgUDaIaiEzK/pIZoGNl4EyW9Uif0xs=@vger.kernel.org
X-Gm-Message-State: AFuF++l569VE31AWlPmlZ9dBzBPxmwQaJX5V2XJ21LsDQmT9q1FLS3M7
	vMwgqPlz9NOTA1OvibtqPOOdEWvRvYRBofdE93DA+/FTxjwxCuQ4PEtFN0VASRuR4JSuDGnkhIX
	CWL//k1KdNfC0BErW4lZ8g4gydQVzbJb7WkhUscQ=
X-Gm-Gg: AYBFou2Qb08bi+knmkigvmPaZBw47ygiH+FxuqeHaBoOgG/6Ahg3DjtQz70R/OfFY00
	M6WK3qpTw6lTJCJaL6kYcyQAr6Q6HWAPLjphWwzWatrktinkljEBFL7l8MmoUVCZg1vsSvJ2RJo
	a7DALU1iHW1+AmY0p5iqGLiLM5KRQdi4ZJHwU49HmX+BlkI+z/l9e6hGU3pHW9mP39HFozAk5jI
	DFSzSX8TOT9MMWGmAo445oPSOOaNcJqwp1NtGT5yJMp9DNC/dExjjVg+YZ3ipCRD8C0WvXsDG+Q
	6cmWgmMquYfe9vPGiA1ZxJE/vStprXaJybhsaVJsaAOpRdEpHScL2AagOZgq0EzO2lCgvGZOyzF
	ITR0Q6ZtXeWDllRVnaoIRVvhuG4Mx70V51apkHujeNBBCc7cB0R3f3IXM
X-Received: by 2002:a05:6a00:4309:b0:874:708d:b636 with SMTP id
 d2e1a72fcca58-874df60bf54mr7154912b3a.34.1789759000656; Fri, 18 Sep 2026
 12:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916080955.1019050-1-ljp1205831794@gmail.com> <178968660727.22033.2420657272100663531@kernel.org>
In-Reply-To: <178968660727.22033.2420657272100663531@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 18 Sep 2026 15:16:29 -0400
X-Gm-Features: AcwNN1XDv7Km9mboXfGTYLkpsRcDPj4Flu2sSn8LplciIDY6w4j_L8AObWcQMWE
Message-ID: <CADvbK_eQjfg_-HLT3zJ5Bt5LWbUTx_+fLG5ggLPNY1Ah+sF9GA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: don't re-register a removed transport as last_data_from
To: netdev-bot+sashiko@kernel.org
Cc: ljp1205831794@gmail.com, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, imv4bel@gmail.com, 
	henrymei@tencent.com, corvus@tencent.com, stable@vger.kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:10=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [High] Incomplete fix: the patch only sanitizes the two
>   `asoc->peer.last_data_from` re-registration sites, but leaves the=E2=80=
=A6
> - [Medium] The new use-after-free guard reads `transport->dead`, which is
>   bit 0 of an unlocked, non-atomically updated `__u32` bitfield in=E2=80=
=A6
>
> --
>
> sctp: don't re-register a removed transport as last_data_from
>
> This patch stops sctp_assoc_bh_rcv() and sctp_endpoint_bh_rcv() from stor=
ing
> a transport into asoc->peer.last_data_from when that transport has alread=
y
> been marked dead, which happens when an earlier chunk of the same packet
> removes the transport the packet arrived on. The intent is to preserve th=
e
> redirection that sctp_assoc_rm_peer() performed, so last_data_from is not
> left pointing at a transport that gets RCU-freed at the end of sctp_rcv()=
.
>
> A couple of questions below.
>
> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index c0512c827d0f5..e14fd88e69d6b 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -1030,11 +1030,19 @@ static void sctp_assoc_bh_rcv(struct work_struc=
t *work)
> >                       continue;
> >
> >               /* Remember where the last DATA chunk came from so we
> > -              * know where to send the SACK.
> > +              * know where to send the SACK.  chunk->transport may hav=
e
> > +              * been removed while processing an earlier chunk of this
> > +              * same packet (e.g. a stale-cookie ERROR chunk queues
> > +              * SCTP_CMD_DEL_NON_PRIMARY, which removes the non-primar=
y
> > +              * transport this packet arrived on), so never register a
> > +              * dead transport; otherwise last_data_from would be left
> > +              * dangling once the receive reference is dropped and the
> > +              * transport is freed.
> >                */
> > -             if (sctp_chunk_is_data(chunk))
> > -                     asoc->peer.last_data_from =3D chunk->transport;
> > -             else {
> > +             if (sctp_chunk_is_data(chunk)) {
> > +                     if (!chunk->transport || !chunk->transport->dead)
> > +                             asoc->peer.last_data_from =3D chunk->tran=
sport;
> > +             } else {
>
> [Severity: High]
>
> Is guarding only the last_data_from store enough here?  After the earlier
> chunk removed the arrival transport, the rest of this same loop iteration=
 in
> sctp_assoc_bh_rcv() still uses the dead transport:
>
>         if (chunk->transport)
>                 chunk->transport->last_time_heard =3D ktime_get();
>
>         error =3D sctp_do_sm(net, SCTP_EVENT_T_CHUNK, subtype,
>                            state, ep, asoc, chunk, GFP_ATOMIC);
>
> so chunk->transport is handed to the state machine for every remaining ch=
unk
> of the packet, and other sinks copy it into association-lifetime state.
>
> The redirection in sctp_assoc_rm_peer() looks like a one-shot snapshot:
>
>         if (asoc->peer.last_data_from =3D=3D peer)
>                 asoc->peer.last_data_from =3D transport;
>         ...
>         list_for_each_entry(ch, &asoc->outqueue.control_chunk_list, list)
>                 if (ch->transport =3D=3D peer)
>                         ch->transport =3D NULL;
>
> Only references that already exist at removal time are rewritten, so any
> reference created by a later chunk of the same packet is never cleaned,
> because the transport is already unhashed and off the transport list.
>
> One such later reference is in sctp_cmd_setup_t2(), which has no dead tes=
t:
>
>         if (chunk->transport)
>                 t =3D chunk->transport;
>         ...
>         asoc->shutdown_last_sent_to =3D t;
>         asoc->timeouts[SCTP_EVENT_TIMEOUT_T2_SHUTDOWN] =3D t->rto;
>
> sctp_sf_t2_timer_expire() later does SCTP_CMD_STRIKE on
> asoc->shutdown_last_sent_to, and sctp_do_8_2_transport_strike() reads and
> writes the transport from timer context, after the receive reference is g=
one.
>
> Is that path reachable mid-packet?  sctp_assoc_rm_peer() is also called f=
rom
> sctp_assoc_update() on the COOKIE-ECHO restart path, and that leaves the
> association ESTABLISHED for the following bundled chunks, so a bundled
> [COOKIE ECHO][SHUTDOWN] appears to reach sctp_sf_do_9_2_shutdown() and th=
en
> SCTP_CMD_SETUP_T2 with the removed transport.
>
> A second sink is the reply chunks, for example sctp_make_heartbeat_ack():
>
>         if (chunk)
>                 retval->transport =3D chunk->transport;
>
> The same assignment exists in sctp_make_op_error(), sctp_make_abort*(),
> sctp_make_shutdown*(), sctp_make_cookie_echo() and sctp_make_cwr().  Such=
 a
> chunk is queued on asoc->outqueue.control_chunk_list after
> sctp_assoc_rm_peer() already sanitized that list, so it is not covered by=
 the
> redirection.
>
> Can that chunk outlive the packet?  In sctp_outq_flush_ctrl() a one_packe=
t
> control chunk that returns SCTP_XMIT_PMTU_FULL is put back:
>
>                         if (status !=3D SCTP_XMIT_OK) {
>                                 /* put the chunk back */
>                                 list_add(&chunk->list, &ctx->q->control_c=
hunk_list);
>
> and the src_out_of_asoc_ok branch skips non-ASCONF chunks:
>
>                 if (ctx->asoc->src_out_of_asoc_ok && chunk->chunk_hdr->ty=
pe !=3D SCTP_CID_ASCONF)
>                         continue;
>
> sctp_packet_will_fit() returns PMTU_FULL for an oversized control chunk o=
nce
> the packet is non-empty, and the peer controls the HEARTBEAT payload size=
.
> On the next flush, sctp_outq_select_transport() reads new_transport->stat=
e
> with no dead check, keeps the transport for HEARTBEAT/HEARTBEAT_ACK/
> ASCONF_ACK, then writes into it and links it into the live list:
>
>                 if (list_empty(&ctx->transport->send_ready))
>                         list_add_tail(&ctx->transport->send_ready, &ctx->=
transport_list);
>                 sctp_packet_config(ctx->packet, ...);
>                 sctp_transport_burst_limited(ctx->transport);
>
> That is the same read/write plus live-list linking the commit message
> describes for the reported case.
>
> This also seems to go against the policy the commit message cites from co=
mmit
> 03a9d10ecf71, where sctp_inq_push() frees such a chunk outright:
>
>         if (chunk->rcvr->dead ||
>             (chunk->transport && chunk->transport->dead)) {
>                 sctp_chunk_free(chunk);
>                 return;
>         }
>
> Would discarding the remaining chunks of the packet, or clearing
> chunk->transport when the arrival transport is removed mid-packet, be mor=
e
> consistent with that and cover the other sinks too?  Note that the ASCONF
> DEL-IP path already refuses to remove the arrival transport at all:
>
>         if (peer =3D=3D asconf->transport)
>                 return SCTP_ERROR_REQ_REFUSED;
>
> Related to that, the commit message says the fix works because "both
> re-registration sites (the association and the endpoint backlog paths) ca=
n
> simply skip it, keeping the redirection done by sctp_assoc_rm_peer() in
> effect".  Is that accurate for anything other than last_data_from?  The
> sctp_cmd_setup_t2() and reply-chunk references above are created after
> sctp_assoc_rm_peer() has run and are not redirected by it.
>
> > diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
> > index a15b599b20b76..f1e2acf8d9bcb 100644
> > --- a/net/sctp/endpointola.c
> > +++ b/net/sctp/endpointola.c
> > @@ -396,11 +396,13 @@ static void sctp_endpoint_bh_rcv(struct work_stru=
ct *work)
> >                       continue;
> >
> >               /* Remember where the last DATA chunk came from so we
> > -              * know where to send the SACK.
> > +              * know where to send the SACK.  As in sctp_assoc_bh_rcv(=
),
> > +              * never register a dead (already removed) transport.
> >                */
> > -             if (asoc && sctp_chunk_is_data(chunk))
> > -                     asoc->peer.last_data_from =3D chunk->transport;
> > -             else {
> > +             if (asoc && sctp_chunk_is_data(chunk)) {
> > +                     if (!chunk->transport || !chunk->transport->dead)
> > +                             asoc->peer.last_data_from =3D chunk->tran=
sport;
> > +             } else {
>
> [Severity: Medium]
>
> Can the dead bit read by this new guard, in both sctp_endpoint_bh_rcv() a=
nd
> sctp_assoc_bh_rcv(), be lost to a concurrent bitfield update?  In
> struct sctp_transport the flag shares one storage unit with the others:
>
>         __u32   dead:1,
>                 rto_pending:1,
>                 hb_sent:1,
>                 pmtu_pending:1,
>                 dst_pending_confirm:1,
>                 sack_generation:1;
>
> The two writers of that word do not share a lock.  sctp_transport_free()
> does transport->dead =3D 1, reached in the scenario of this commit from
> sctp_assoc_bh_rcv() -> sctp_do_sm() -> sctp_cmd_del_non_primary() ->
> sctp_assoc_rm_peer().  When that runs from backlog processing,
> __release_sock() has already dropped sk->sk_lock.slock before calling
> sk_backlog_rcv(), so only the owned flag is held.
>
> Meanwhile sctp_icmp_frag_needed(), from sctp_v4_err()/sctp_v6_err() in
> softirq, holds only bh_lock_sock() and writes another bit of the same wor=
d,
> in exactly the branch taken when a process-context owner is running:
>
>         if (sock_owned_by_user(sk)) {
>                 atomic_set(&t->mtu_info, pmtu);
>                 asoc->pmtu_pending =3D 1;
>                 t->pmtu_pending =3D 1;
>                 return;
>         }
>
> sctp_err_lookup() holds a transport reference from
> __sctp_lookup_association(), so both CPUs can legitimately be touching th=
e
> same object.  A single-bit assignment compiles to a non-atomic
> read-modify-write of the containing byte or word, so the softirq store ca=
n
> write back a copy loaded before dead =3D 1 became visible.
>
> If dead is reset that way, this guard evaluates to true, the removed
> transport is re-registered in asoc->peer.last_data_from, and the
> use-after-free is back; the existing sctp_inq_push() drop on the same fla=
g
> would be defeated the same way.  The neighbouring atomic_set() on t->mtu_=
info
> suggests this field is already known to be touched cross-context.
>
> Would putting dead in its own word with WRITE_ONCE()/READ_ONCE(), or a fi=
x
> that does not read the flag at all (clearing chunk->transport when the
> arrival transport is removed mid-packet), avoid depending on this?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260916080955.1019050-1-ljp1205831794%40gmail.com

Can you try to fix this issue by discarding the packet in
sctp_sf_do_5_2_6_stale() instead? like:

@@ -2653,6 +2653,7 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
                        SCTP_TO(SCTP_EVENT_TIMEOUT_T1_INIT));

        sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(reply));
+       sctp_add_cmd_sf(commands, SCTP_CMD_DISCARD_PACKET, SCTP_NULL());

        return SCTP_DISPOSITION_CONSUME;

Please also share the PoC with the maintainers if there's one.

Thanks.
