Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4630F7FF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562841; cv=none; b=kDggt85lKCUwhhjJ2KOaCkbToFqILCUrOa0woa7vglIBzTkTYSlceEGVq0fqJbRe9W43WcH/JSORAUlaCKacX6+FBNiatnzhBrzEDy7OnfaGViVUhpj+dqC5j4mYG0GNFjP56A1tYx93WfvhbbfmDU+hNmd9x74qpDDANtmu9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562841; c=relaxed/simple;
	bh=PoPEUr6KS0Je/aVdiGP+sFxqtUXWh++lbWgpLTbivR8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XD3JvOlbLzPayRTAsTclziYyF4eVB7W79GQOeUrsuomXSEW9tRTrFo5r+KJyFRF/K2AIRWu7iMLJ/okNiGqMcW+1gA8U5sxQkiYixBUv6Rp6LGd72rYQ9vhYhUq9TAEoL3lTXvQXK5cV32GfsxS4g0KgegNLKYArQAM7LocAdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma4wp730; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma4wp730"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80cbb0688c8so21107497b3.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783562839; x=1784167639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DiPeyVYQaEiVqx7WKQEaIVABISxwCwD67P0r37Z1zdw=;
        b=Ma4wp730Sv4nNZnOHmCCC5/vyV55tWljs0zgQoSeoykBlsnAflLTdnjsTTDuGU2Wnf
         CQs0kQSNDkM042f9UhB3aPhz+i9u6QV5+Zxfm4hWJAfwhNpr2wjbWo2C/jlW9OeQ+VBx
         7pzOfEYDvgpN3PJ3vPPK6j2yXNx8JiD1io3b18sTdsoAr0w0IJegiKmPXdNSOOyfnw95
         Ck+wyXHkH8jP7lP9CaDWkwH7xU6T0Ss6CmlHXzDKvgYtyLs0imYvY/BKEsHdzQgsDXT4
         O8GnH1tn/cnijR8c9ypE/5pHaq6badb5OxaW5oR8dZsaQECB3zGSjJ+n/F5cI9FVunJe
         osmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783562839; x=1784167639;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiPeyVYQaEiVqx7WKQEaIVABISxwCwD67P0r37Z1zdw=;
        b=phJCcd8Y44DnK3BzQoYFVp9aTIgcJOQtYx93v78E0bC6iTkAsNkaxd6Ctx58eIkeo6
         XFqQ4bjHVbeQdEPg9zg07gvhTE58YkAlmyRGvulUrZY6yzUxWa/iFPSPg1teUk45F2fy
         nI9plLfkHycCGTFVMdudqFWgvvqYuTfa6dvUGFCtU455W5Lau3pBLpeZuFCkPe+0ttEa
         S86M+/9JVJu/AHEMEe1KVigNXka3rYxQEQcmYWnQhsf7hnS2jpXlHadQ3PhzKGfwXODL
         v2//lC3ndhDqGgY+nrq8hi9769M6kXoTmOSKhJVjx4/KiDpTuXzjgN55d99onM1U1H+N
         oREQ==
X-Gm-Message-State: AOJu0Yx1eRhZmErGRiwJ3uo+Ryl/JkeK7Vt3fag6bN4r/JP5zB+JAjMF
	47CsCk8tfoxhwDoyJRLmFBSuiElnNkJbJxvf7N0KakRNVZneVIrRUDUv
X-Gm-Gg: AfdE7clW3MLRp+aDvW5vVFj1pwXwwwFhM9ipJ8ikqTYFU/f3HVW73URjm2ui8akxNP4
	zLSO8dNC8nGnjW336jSTKNTYIs1JxEVqDNYakbarNjHXoLmjyuOj26bKJNHoIoV8ADRompb5Uia
	UX+YIqh7fQGPyxWDGEoFuFTbMTD/jiAbZSGoTyq1ONVDoHF2fd1pWC4+abwRGr7uEZtk8rUDpLe
	LB0GgffuucKZvvqOtHb7Oz7u8GlPXYsyPEMqCaczwQZLjM74jNeqs3BwKYgA+guIhmUt7R/MIVo
	hOsQyOyQFRG/st6H6SB7YF26AmPvJlY2lsejYttlP1SMyGU+Cg7Af1aAAbMGIOSBZLSJ+kMQFbT
	2Xj8VKN/WFyCW8vBlNig3x2EQdJ97VHR5wvkanbUAJ1tgBeuqDDO9D1GDYMaslWHpmHwR4UDOLO
	sAYoeSsiQRB6xiBVt1VHSIrvtbBWjwhSkqiRMobng4ZBkKikyCwZSUA+/2K295PWDU0Q==
X-Received: by 2002:a05:690c:4b90:b0:814:608a:acb4 with SMTP id 00721157ae682-81dbeb5f73emr38829227b3.27.1783562838726;
        Wed, 08 Jul 2026 19:07:18 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be904a4sm6869687b3.7.2026.07.08.19.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:07:18 -0700 (PDT)
Date: Wed, 08 Jul 2026 22:07:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.2801a1401793d@gmail.com>
In-Reply-To: <20260709014704.3625-1-shiming.cheng@mediatek.com>
References: <20260709014704.3625-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v7] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Reminder to mark patches [PATCH net v7]

(or PATCH net-next when targeting that tree)

Shiming Cheng wrote:
> Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
> packet.") added a flush check to skb_gro_receive(), but
> skb_gro_receive_list() lacks the same validation.
> 
> As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
> re-aggregated.
> 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
