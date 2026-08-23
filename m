Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1B3596E1
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787521335; cv=pass; b=VbWt5ih48+lOz5bbLy0hF//6JCm6Tp+oVNTa+h/B4UMa89RPr0Z3tY8dzHx50LDve88I4eow0b9gMhyH/LkztJVUjRf9Gcq7RL7zcM2AXnEdgi71qpXdMSYXL+KEt2O+lxmPmTFsoIqKo/cRq0RjjsVJoZyhavH73H2fnqoqztU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787521335; c=relaxed/simple;
	bh=UUVZ4QEhiifkU4/PdlgixLKGOpIioQqZ8H2mXpqOKwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDQ4HUyib9mbU761jt66xVMrKtRUvGeCuuHSzoV28HxUUcGr9VGVBb99EVMBX+JnjDjXgXH+Tkc6u7AqSDCv332SuaaBagQp+31Txo70XKpUgd3MSsnYcBqVvKdv/qLChl73W+PUHQ0IdPkgk1UnmOQGbGRbV4Ha2IrrzzFHooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzLDOo66; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzLDOo66"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84830c774a0so3107659b3a.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 14:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787521333; cv=none;
        d=google.com; s=arc-20260327;
        b=GSyEtdX48j2/vwozHwqh7aygESZzv4Td7v7GB+uuClKx/Kc+XoI7N8ITBQcf2Wccvl
         p5a3WsCV2Kq4q9JstiejC0vHZpVMUFsi8qvAWXmdcDgS4JgoUIL2ke669aSljFqOjRT4
         VP9p2KVWc39srYsTCH/cWtAmjHl6dMCiVLIhF4S8qouKcJ0l1WBFUE6bfr3pBJ/2ROLA
         dCBMEyGCtf6ekfjstPqsR7fnyNetSeRE7dxmX50lSJ9wQQdolUyPcg+cEE6iYdEonXF+
         Qf2OYiaQDjY1fonXy7+aBUadohxYNb6c32hz5fGoK+jV3Pbsx9i/eVSrwMmYQPtQ7K2X
         DA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MiBiSqEstYsBT9CowHcGMjwsGGy57PEcAXTCZ8mkb0o=;
        fh=7Q8eT/gZzmwpVn6HstBXz2RgdpAtdCJ0BvAQw5vrxVs=;
        b=joN8P6wmJ2ce4Mkc43RPlR/if4NrYTG6lUQfgzkjMy9KQulLjsiGbM/m4TmMaqkO/5
         s2lGoUYt8vOR0NiiZWW/avS8zsKKxNrL2Nrov001tFCl5Jq014yKmNI9kh7iQI7MqgMb
         CEGiYHDMSp3SbQ59y/db5w4ZOlp3TVBtqQsWwoZIWyi6e1e+22RnPA9LfyPNKwW5AzwR
         p6PUtf2Rd0WnfZi2FwNiat8TIPemIMt/8+zGjuVUoLwuFS6Tf9xHibhPqLOD0a5kZDRk
         qm4zCNNR17Gl+Cc6Vp70RWhyrqlJNwgx+1/J7FYosEo4OrJ/VJ9FRdZ+TNJkxvIpDf6D
         LlVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787521333; x=1788126133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MiBiSqEstYsBT9CowHcGMjwsGGy57PEcAXTCZ8mkb0o=;
        b=TzLDOo66deUWndxnkcuVLsI+dUfFk9AdQgkn3ZayVHlPH3qdWS1WKfextC0SYNn4KY
         jjQ+5b9Na+zcTqZCvfFKLYeBhXTvcn+LKds9FwI1sBpFifvVaOLLaYbqHdOFE0skB7E/
         sHGERnP9gHiMMGlXlQ+4jwtqFFalY7LR2Yr8iv2onnpkFFLxdlHWIqmlg4dIHnJXSI2S
         bYiAiZuKTCyNTxa+kc4ugeeTCB3wxItobDuT7KnUnS6bb/sGg/1RCwsbtx7wEMK2ZOnn
         RgvBgEXE0c83bw+BsH1ZgNYCdS9lWjxpY06nzT369htDVps3oZetrj3eYUtT3jwZRU92
         Bcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787521333; x=1788126133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MiBiSqEstYsBT9CowHcGMjwsGGy57PEcAXTCZ8mkb0o=;
        b=VDc1FpyxmyibSx+LXfgk6jFKH1LPX8RqKXuCsWCgDS+oV7kAn+XGwNalEjmECo8NqP
         35oSDwGueUaQGpsFTE2k0H3tHN1lQJPLzidWYc4mnpdsz5ZhPZ4WJki8zkIk6xxRpY2R
         JEeD1+Pe1O/Is8cWzH0nHQaFCoppd+USuTeInkSO2HNtcMo674/Cpq2c636ytAWVoHkX
         hB0GDjAgddcPpZ8ZxEe2jLmqvNYXpXs7TsvHKkLZVOcIp8FU4R7dNYC80fbjALS3OHoT
         YY/lGN8hqsKDq6tmPeeRMNkYUmLdBwVFbsSNZl8DMNeNycfSYm3D2TTZHIghygnpCu7+
         uVaw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1fXL0X0FJIjuK5Xch/2ESYXCW176yvKakZyPirV1f/o2gLOwJxAzmSrkYTBlVU1I8HbxZxQk=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Qu8uGvIAsFqzRU8+wRg1t5B1xEX2IHmaPU5tyvMH8OML95Si
	6vtxCIcD5EXLKP24Q+U0KGaQY/XASC+XOL0gIRWfxe+CZLNJaFv3exhYht4GflsPCbGHNttnmk0
	Le8XzJwh8E+tuGAxua6M+myBL647PqfE=
X-Gm-Gg: AR+sD10+vo4hDI2+1fWV/GJMahZsqgS0oPB6jv30ZxPE4r3dNKUXBN/M2HeXSN9VOEL
	OgP0BoRpi5Lxun30n0+W53SxIU8fb9tr+2YC0o98S6p5QxZV+HaMaMTzjwQrg0IJPIsonyUouiI
	qH7i/gbhr72v2bN7M3EyOll3IgUqniSO7T9ATB5MVS/8ZlE6xITOoKUTbXFW7MEZraXaQAUevfR
	T7UH9DcqAWamAPE4tAKsP8nvcaVoqHHHbvPURq7PqyrpGxFSayFJApLPQyUIdNEp7pXFmfncuWq
	hDvht3MtztqqaDu3EaJ89kEx5bWv85tFNNeOKQdjVjHepdvy+txKcVNV8oFvbZofVZ4pTzBAnZV
	kECYQUqVfV4R901qKVKLtBT3ZhWpssMoWVhe/71aVVO8=
X-Received: by 2002:a05:6a00:39a1:b0:847:93f3:a4b6 with SMTP id
 d2e1a72fcca58-851fa0667d8mr33292027b3a.17.1787521333426; Sun, 23 Aug 2026
 14:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823172857.896146-2-bestswngs@gmail.com>
In-Reply-To: <20260823172857.896146-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 23 Aug 2026 17:42:01 -0400
X-Gm-Features: AcwNN1XZvnlzQT-i245u9UsXUJjCTtcPxPiiTlaJcAj7ZTFwxNFgd5I0mNBreL8
Message-ID: <CADvbK_c6rqUdxyMSC=XF7ShHbjHSY1d2wEUmYpr0RGO+E0i_Kg@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix NULL deref on untransmitted RECONF completion
To: Weiming Shi <bestswngs@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 1:29=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
> sctp_process_strreset_resp() complete a pending stream reconfiguration
> request by stopping the reconf timer on the transport it was sent on:
>
>         t =3D asoc->strreset_chunk->transport;
>         if (timer_delete(&t->reconf_timer))
>                 sctp_transport_put(t);
>
> chunk->transport is assigned by __sctp_packet_append_chunk() when the
> chunk is appended to an outbound packet, and sctp_outq_flush_ctrl() arms
> the reconf timer at that same point. A request already published in
> asoc->strreset_chunk but not yet transmitted has neither, so completing
> it dereferences NULL.
>
> Two ways to get there. sctp_send_asconf_del_ip() sets
> asoc->src_out_of_asoc_ok without sending anything when the address being
> removed is the association's last one, and sctp_outq_flush_ctrl() then
> leaves every non-ASCONF control chunk queued; as only
> sctp_process_asconf_ack() clears that flag, it persists. An unprivileged
> process that removes such an address and then asks for a stream reset
> panics the kernel from softirq. A peer needs neither ASCONF nor local
> help: sctp_cmd_interpreter() uncorks the outqueue only once the whole
> packet has been processed, so a reply built while walking a RECONF chunk
> stays untransmitted for the rest of that walk, and one RECONF chunk
> carrying [Incoming SSN Reset Request, Outgoing SSN Reset Request,
> Response] -- or two RECONF chunks in one packet -- reaches the same
> dereference.
>
>   KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
>   RIP: 0010:timer_delete+0x67/0x110
>   Call Trace:
>    <IRQ>
>    sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
>    sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
>    sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
>    sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
>    sctp_rcv (net/sctp/input.c:243)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    process_backlog (net/core/dev.c:6680)
>    </IRQ>
>
> A response can only acknowledge a request that was actually sent, so do
> not match asoc->strreset_chunk while chunk->transport is NULL. Guarding
> the lookup covers all three completion sites.
>
> Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Ou=
tgoing SSN Reset Request Parameter")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>
> v3:
> - No code change; v2's changelog linked the wrong v1 posting.
>
> v2: https://lore.kernel.org/linux-sctp/20260822172352.63025-3-bestswngs@g=
mail.com/
> v1: https://lore.kernel.org/linux-sctp/20260820162235.2668698-2-bestswngs=
@gmail.com/
>  net/sctp/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 34ffe6c945a4..2012f61e250e 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -488,7 +488,7 @@ static struct sctp_paramhdr *sctp_chunk_lookup_strres=
et_param(
>         struct sctp_reconf_chunk *hdr;
>         union sctp_params param;
>
> -       if (!chunk)
> +       if (!chunk || !chunk->transport)
>                 return NULL;
>
>         hdr =3D (struct sctp_reconf_chunk *)chunk->chunk_hdr;
> --
> 2.55.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>
