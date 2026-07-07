Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFC3B19BF
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437422; cv=none; b=In80hsBMYEVxt4p6RNkLCEXgkXUkPeCZdSxXYmyXnaQ5Ubf72R8VRvG0TEyyL4gxDLbm7fmwj5VYV5K+l1iWWN+xPDmZBluKt5pi4sg+Sjgs3Z1E06UxCpmHdatJn6tIB3sZsKDCKBIIv47AJIfA17XSo9JuaWi2g/gAgzxgagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437422; c=relaxed/simple;
	bh=6n8aPA1vZTHKTUYfm4zIRDmO2S0R8XGdy/C7T/5N6B8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kLUvwYODSphZ0O/iPMt6sN0/iQDeBGMJvCYW8scJwSehYDNy22bdpE2E807f7kGsD8N2WWhiA6T5E0qiF8ZakuOOO4prXD7CVElTX7JX1e0xmNZ8b6xKIVETqO5fEfaaZgvkgBbI1nptXM2LS2tZmGqacPvBJ+AXGgsfM66i7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT1eA52S; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT1eA52S"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664d78637f8so6182570d50.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437420; x=1784042220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+LREjqj7QKR0h0vN+5yo9g4950/7tRNrphjJDSrz5U=;
        b=JT1eA52S45YPvo0hSEkMjiiqT0W+W9RP82S01f+y0gAyNgPEsBIGBvGQSC07LDdnHY
         xMxN+J2ri82mWrDe7EBp6OBYCbhk36zR9BjgxRXGhtpYc+4fFk8eu2nLhK4c6aWKE3y3
         bnxmm9uE+5wTqOjYtt4wT02LHEXGIxYdHDe8QMevsGVt7I0ag5CHFVfI2PtMGizAp35D
         3qdXChcBD89gpATafbkUgBxLVVGKfVtUri+Lezn5HnSFP/0CxLAlMb72fI9AgEZ9yBoT
         Prz1ibZjlQnt+kr+4pUIPzhtI4r21no5eEmgbdFl/RG5JqrbI9YXnf2C3EQOg9e7F+hO
         xkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437420; x=1784042220;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+LREjqj7QKR0h0vN+5yo9g4950/7tRNrphjJDSrz5U=;
        b=mnnC77T0R/09xlPkY8APkcBvuzEo0mXrpa1jFOs/R/wj79N0S9lXRncsvhKf+VmXqn
         /z98ALr08Q6Pf28tIUFp7ojEJsOA36NfX6zv5v2Sz7rjWRzYhuysS2yxgypcGm++cNGI
         4nGdk5GAkWVuDmKt0EF0JRRIgqAw2LTg8kXOqSeJtU/U9fPqClE3iyHAYYe2SMKfCHqF
         S/VG0MuHQnGN7Iu0dmGzDxxTWFfuszFgtWw2cTG06w6xzO0PiOf1Qh/e2Eux9Bw2eyRH
         ES6bCd0GxE22LK3TjpuRTrlXU/agCx2ygEl/DqBjCXKvR3yT2ivhPBNjN2vag4tiU8m5
         IwFg==
X-Gm-Message-State: AOJu0YzEQVMRrBFdQFzRDKC6GM+dXFHx4qWsdhEUUwKe4yE1S5r0iWYO
	G0C76HIm41L5G9xNoUkXx4TQeGVR8osF9NHoXokaySrDYyGNbjRN7YNy
X-Gm-Gg: AfdE7cmeKSS3Keirg5Itss4nXTmBTsCkjeq8g2HPv4WlEWRoYWWzM0i/XUkFV+/oLTp
	H0pki++NuUXgKz3sBphFqHFuQMuoNq0iVtMw7JjTtgQodGkbgutl0DXdLQbVJrIBBMt/415AteN
	6yklszncoyxxQaeOGw3Vxx+g2HTG9iYR8N4YGgtkWveHYsYFC/hi4fqY/DiGskmOYtRngrVuXib
	6md3kATuBSo6jOxSZAnYMM1F6NJ7E70rsSr/+tgMCnC+ec9tEq79ZryiJcE4WEyt0Smh9mKWZL5
	rjDtmKm+5imuCpU4FNSff7hNyrffWEynkvqY5tLJCHgn4nJl/mzrCEOH10DbuWAJ9QAw+qqluCp
	m0wcU27FUTw6h9iCM/FfwFvt61fcd6bjaKlg0Mr54TCIkp1hTzG+gyKB1MzSKSpuGAbM/U0CPjL
	7dWf7gMCLSMCHZqTAQNDu9PALLbwM1b9Ooq5PqdIrcw2ESWPBYEum4R2W+mfw+7jlNKw==
X-Received: by 2002:a05:690e:1189:b0:667:8dc9:2321 with SMTP id 956f58d0204a3-6678dc92498mr1718562d50.29.1783437419315;
        Tue, 07 Jul 2026 08:16:59 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b049939sm70583417b3.32.2026.07.07.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:16:58 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:16:57 -0400
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
Message-ID: <willemdebruijn.kernel.39a3b0237ed2@gmail.com>
In-Reply-To: <20260707021425.483-1-shiming.cheng@mediatek.com>
References: <20260707021425.483-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v6] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shiming Cheng wrote:
> The skb_gro_receive_list() function is missing a critical safety check
> that exists in the skb_gro_receive() implementation. Specifically, it
> does not validate NAPI_GRO_CB(skb)->flush before allowing packet
> aggregation, as of commit 0ab03f353d36 ("net-gro: Fix GRO flush
> when receiving a GSO packet.").

It does not check .. as of commit .. ?

No, skb_gro_receive checkos NAP_GRO_CB(skb)->flush as of that commit.
 
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
> ---
>  net/core/gro.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..b413f4a6462b 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -229,7 +229,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> -	if (unlikely(p->len + skb->len >= 65536))
> +	/* make sure to check flush flag and to not merge */
> +	if (unlikely(p->len + skb->len >= 65536 ||
> +		     NAPI_GRO_CB(skb)->flush))
>  		return -E2BIG;
>  
>  	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
> -- 
> 2.45.2
> 


