Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793054324;
	b=KSXqVlmyKYtsx9y5BBfPZKq+EffNeAz8ZRWmYGjUiUaJfhX5/w+Yke7gWogNZmMnOhxF
	 +y0PHv3iwYF/BGFhiNg13uzu+SGvg12YJS36m84B3UICZ1Z9ffyz6y0pA1j8yx2oFKzFK
	 6vxMhcmF5W0Uiym2C4cdddgy/I2kXG04PAYE3CmZeuvW0VcpAH2i1kwJolFOWhmFDS4ae
	 v+9DIRUAus+nuzZo5wadBuuuQNMHnQOFSG34kVu5jkvv4OzLZ4BkDdjiG/PX9/RSKeuRN
	 ce+99c3hdv2IEDJF8eq1TX3E9inAjBHZAtySfx4eGb/i/SCUm1QbMsSD1UYNBW7ZPbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
	b=imq57uX+UUbn4nPCj43+JJIfhxR7Bt+cDJWs7Dw5QflU43rFqSDO90JVqcpSGjX5t8Aq
	 ynalf0pgF3McQRpQ7sGBHZ8kSzmVIjodLr6apgHUgs8euUhk30VckqEzOYAr9G98UCY65
	 V7U1yuYTBL2a7zbV6cz55eVpivZ/i/hbqlO0JfMrvzh8IJ/AwghY+w3dC6mXtep4PKLrM
	 LMzU8/urXuamHNjhQTNh5oKl5NQqVWY/Wxjag143Mg2vx5mikuFi5mgnAU0BOJDeojnUt
	 15P4Be548TrFu3QPIe4ScCB+NKMPIcwuROj1NsrdI0HCcLKl9NFEh+LsqbGY6aj7Jmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AhkYbOgr;
	arc=fail smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C955606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C955606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AhkYbOgr
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so2444529b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054324; cv=none;
        d=google.com; s=arc-20260327;
        b=fWwQ6n+CY10hWc8LU4Hl7V6xZcYILk6RwPFmmiJsgpnlhjh+tV+sHzWPIQek4S6tv+
         RA9clrIYBvRv832jwFvNYoy/oXd5FTaFpuQIMVRjsuBwMjKHq9HR0d9GfjtHaWzwSOpC
         c9ofySZQ9wAsBFnRtumco4AZbytdUb6Qoz2xuc+EH7/9J1+uBlfzm2c8rjQEAfTbrUpO
         FQAu0vyosEp8uPbsM8YrqkuKsuIf0FQA7ZmHj+NaKKRFhYrtL28LCN0hyJKxcsxp8v3M
         +fwIy4uptSL/ywt7yaFV1MpsjMw15PQQTQtfM6r99jU4LwuH/g4cjvOXoM/e5QCiXOdV
         t2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
        fh=zz6B7C/vwb13Vhf8Rjf0XpdeZUex8UTmhpnrFYweP44=;
        b=NcFbfCP4TGLr7vYdzfHLRzZkOy3wf4wj5ZZgKR1MNnl3q0ydiBrAcwuygU6LAUaN3R
         Zb+kyNfj8wDMTTDYFsn93SRE9FofhkCn/bqeywgnQ4yIlyAKl71drWIo8AnvbbKJBsyC
         n48BnunyHCkJ6PWzo8EO8Ocu3t+VpYuPriNxyCre78zFJpyYJSEVRpP2tHUvDL8TU8Dn
         GqsEqwRTycULpxWfL3M2OQ3FOo6JVQ04iQwqXcOZ/pZ9ui7KSC4haDG7PwCcjW/SlSWv
         erIyaF/Zw6Km3RszjSXnOoW6PTZaZObHQHuoI8/CA5++Lvcne34B2p1Z7BvKtxBar3Yr
         ZU/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793054324; x=1793659124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
        b=AhkYbOgrlKuxl0cBRMaCcQFeQKH33/Zs4GV4wWsW1yxxo70qOYtYHPDypHnGOR1fDX
         BtzQd/zto+rNjL+a2+Wk224dfucP3x13AXdZmPGVt91cBlzxdjEUCqbwEbiTaSVR5BeO
         LmWy5gztB96pjlwKNPnojgLN7jldXRlZKFOhwRE6YrgphyQI5ncevlOxzOoMhh3ibibO
         UW5oia+Hdk1v3Dyn9yCAhszv0H2GhMkaSJ0yZ9vSekBPLQMPxcyhTwwv+AASdXSueHvE
         vsWXX/IKHKsItO3CnPAdjKcNM/XGb4hcFwbrlEkq5OGsYUjECtRhkJvJrQXY/k+uF8na
         fI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054324; x=1793659124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHXZbNTUg/Ax1p5zA4xqb/Pkz7l6MQaU/rT8lSK2nOM=;
        b=i92Ewn9I0CEA27Ryj030SKgHrAcQAeYviNprJ1pT64K3f+doIkiIB+iLwonOBcJRd/
         Bf8mX3xdLclWtE9BpebTZdoHEdP+4ksF7xrnttJZpel5CaKGfIrhCNO2ZUxxlE5vGzBK
         ur2PEamINgURv7TIoNeqi26O33NWbcvtdC+DWvC0t9bxa0lccbAptMGwKzdalvpFYHj+
         UiwoccuibMkFhLf4CCOKzV9PMq0TQvnM6b8X2B5Nu0jfa2XumxZwTNwYafTFddTqsfSG
         KVSeYdv8sGUtVYHvytM4ZYNrW3HxdS55+Xw8Y8OT63yo6DiXkarbqBprFNSKVXVAGC6i
         wrhA==
X-Forwarded-Encrypted: i=1; AKwUvBwWm5a05H0Cbpu38XPMdWHTMit8nyF+wFkCU5DAhjSa2R4YfVl0bvgy/kBWeCsozmeh3NdhNiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2M1lClHtkFYLOdIcXtnlS7KkXB0pBeMF92ADIYuXAO+v75kUS
	KPGGm/fAbx1uBRHS0gGRKowQ9J0TMIxkqolcy3BRAxRZ0MCfmYC5FPeIy8DtXnfoc/sy5ThEoU7
	xTrkBk0EOpNMjeYCdWyDrXkEglqKZGAc=
X-Gm-Gg: AYBFou20FLa4MBFzkEMYhtc4/mJevml7MXrX7qfS49k1YehWRsEuJo5qCr4RpY9e5V5
	BBaVMdZk3VsZF+Fy05RQTJ5cCB9DECo1lObJLvrfSLMWJFKu66xc1wMPXHtiJTEF9510rq4KkPF
	nlCluWpvi4N4eCK2yflnP6vW6hzwuJnxiC6rhb159X3BcdH6zsg0SbFg3bfGk7C7YKaGjuCvRhf
	3ig+QP+lNvcd6FO5GVzJfmlVyBqRRPzd+P4H14Z0YbfKEwyrEaHO6DHdF3dBzPHmDCdkKW7+VhL
	ySaO8BlHieTlh3rt+cIuVudN27fGu0d8JbB6Z5d/3MqsjHi0h/2uKoW4OPVRo9XfM8F4Gmo9q8U
	tQoxKip5votVzgSCVJDGwPzkHVyaebuJKYT1jf+Mz0SNa6Y2Rp2GaeqWBBFthZ+D6AQvPdVHcni
	OIH9Qn02FEOm6PG8pJASrANNGVMoNjMnh9PA==
X-Received: by 2002:a05:6a00:800f:b0:881:a5b6:7954 with SMTP id
 d2e1a72fcca58-8a367a3e9c5mr6111889b3a.39.1793054323880; Mon, 26 Oct 2026
 15:38:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022163639.2566945-1-andrey.misyrov@gmail.com> <179303675173.3134.11217955296529787762@kernel.org>
In-Reply-To: <179303675173.3134.11217955296529787762@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 26 Oct 2026 18:38:32 -0400
X-Gm-Features: AclHuK__RAb9glund1hU_JAR20mlu30KhixzS1u2vtH0FD81M4p2c0D4Z7kbBXM
Message-ID: <CADvbK_dTUCUFn+sLY+zuN5_9+YC-axzM9FVr-yBKJ4jxwebkkg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix ASCONF address change on single-homed hosts
To: netdev-bot+sashiko@kernel.org
Cc: andrey.misyrov@gmail.com, marcelo.leitner@gmail.com, junvyyang@tencent.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 1:45=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] The patch rewrites the wildcard DEL-IP (0.0.0.0) branch of
>   sctp_process_asconf_param() (net/sctp/sm_make_chunk.c:3153-3159) to=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] The wildcard SET_PRIMARY branch of sctp_process_asconf_param()
>   (net/sctp/sm_make_chunk.c:3182) takes the packet source address from=E2=
=80=A6
>
> --
>
> sctp: fix ASCONF address change on single-homed hosts
>
> This patch drops the refusal of a plain DEL-IP of asconf->transport that
> commit 9b2854f86f0b added, so the RFC 5061 5.3.2 single-homed address
> change works again. The wildcard DEL-IP branch now looks up the
> transport of the packet source instead of reusing asconf->transport. The
> plain DEL-IP branch now clears asconf->transport when it removes that
> peer.
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index ddc31a5dbad32..2b76e451d5cb0 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
> > @@ -3151,9 +3151,11 @@ static __be16 sctp_process_asconf_param(struct s=
ctp_association *asoc,
> >                * packet MUST be deleted.
> >                */
> >               if (af->is_any(&addr)) {
> > -                     sctp_assoc_set_primary(asoc, asconf->transport);
> > -                     sctp_assoc_del_nonprimary_peers(asoc,
> > -                                                     asconf->transport=
);
> > +                     peer =3D sctp_assoc_lookup_paddr(asoc, &asconf->s=
ource);
> > +                     if (!peer)
> > +                             return SCTP_ERROR_REQ_REFUSED;
> > +                     sctp_assoc_set_primary(asoc, peer);
> > +                     sctp_assoc_del_nonprimary_peers(asoc, peer);
> >                       return SCTP_ERROR_NO_ERROR;
> >               }
>
> [Severity: Critical]
>
> Can this leave asconf->transport pointing at a freed transport?
>
> Suppose __sctp_rcv_asconf_lookup() found the association through the
> ASCONF Address Parameter L. Then asconf->transport is T(L), while
> asconf->source is the packet source S. Take a packet from a new source S
> like this:
>
>   [AUTH][ASCONF: AddrParam L, ADD-IP S (or ADD-IP 0.0.0.0), DEL-IP 0.0.0.=
0][DATA]
>
> ADD-IP S creates T(S). The wildcard DEL-IP then keeps T(S) and removes
> everything else, including T(L):
>
> sctp_assoc_del_nonprimary_peers(asoc, T(S))
>   sctp_assoc_rm_peer(asoc, T(L))
>     sctp_transport_free(T(L))
>
> Nothing in this branch clears or retargets asconf->transport. Only the
> plain DEL-IP branch below does that.
>
> sctp_inq_pop() reuses the same chunk struct for the bundled DATA chunk.
> sctp_assoc_bh_rcv() then runs:
>
>         if (sctp_chunk_is_data(chunk))
>                 asoc->peer.last_data_from =3D chunk->transport;
>
> This stores the removed T(L). The last_data_from fixup in
> sctp_assoc_rm_peer() has already run, so it does not catch this.
> sctp_rcv() then drops its lookup reference, and T(L) is freed after the
> RCU grace period.
>
> When the delayed SACK timer fires:
>
> sctp_gen_sack()
>   trans =3D asoc->peer.last_data_from
>   sctp_make_sack()
>     retval->transport =3D asoc->peer.last_data_from;
>   ...
>   sctp_outq_select_transport()
>     reads new_transport->state
>     list_add_tail(&ctx->transport->send_ready, &ctx->transport_list)
>
> Is that a use-after-free read and write of the transport?
>
> Before this patch, the wildcard branch always kept asconf->transport, and
> 9b2854f86f0b refused a plain DEL-IP of it. So asconf->transport could not
> be freed during ASCONF processing.
>
> Any peer of an association with ASCONF enabled appears able to reach
> this, including a well-behaved peer following the RFC 5061 wildcard
> procedure.
>
> Would it close this to set asconf->transport =3D peer after
> sctp_assoc_del_nonprimary_peers(), or to clear it whenever it is not the
> surviving transport?
>
This looks like a legit issue. Either way above works for me.

Thanks.

> > @@ -3166,13 +3168,9 @@ static __be16 sctp_process_asconf_param(struct s=
ctp_association *asoc,
> >               if (!peer)
> >                       return SCTP_ERROR_DNS_FAILED;
> >
> > -             /* Don't free asconf->transport; a later wildcard DEL-IP
> > -              * parameter reuses it.
> > -              */
> > -             if (peer =3D=3D asconf->transport)
> > -                     return SCTP_ERROR_REQ_REFUSED;
> > -
> >               sctp_assoc_rm_peer(asoc, peer);
> > +             if (asconf->transport =3D=3D peer)
> > +                     asconf->transport =3D NULL;
> >               break;
> >       case SCTP_PARAM_SET_PRIMARY:
> >               /* ADDIP Section 4.2.4
>
> [Severity: Low]
>
> This is a pre-existing issue and was not introduced by this patch. The
> wildcard SET_PRIMARY handling in sctp_process_asconf_param() uses
> sctp_source() instead of &asconf->source:
>
>         if (af->is_any(&addr))
>                 memcpy(&addr, sctp_source(asconf), sizeof(addr));
>
> sctp_source() returns &chunk->transport->ipaddr whenever chunk->transport
> is set. When the association was located via the Address Parameter
> (transport T(L), source S), SET_PRIMARY 0.0.0.0 makes L primary instead
> of the packet source S. That doesn't match the comment. The ADD-IP and
> DEL-IP wildcard branches both use &asconf->source.
>
> With this patch the result also depends on parameter order:
>
> - After a plain DEL-IP L clears asconf->transport, sctp_source() returns
>   S.
> - After a wildcard DEL-IP, it returns the ipaddr of the removed T(L), the
>   dangling pointer described above. The lookup then fails and the
>   parameter gets SCTP_ERROR_DNS_FAILED.
>
> Should this branch use &asconf->source like the other two?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261022163639.2566945-1-andrey.misyrov%40gmail.com
