Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87500384CED
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201298; cv=none; b=qFqqcWFvGSI0K6Bi9zk016d99bv4h1RBSbFpANRQvwkFQl3NfqtkhBrjTcCQj9wfTBIkTgagHzxRlzS7OZD69gyFU8/R72QjcSllhIylMHw86d4pBFiTB4uv4l6gOcN1Qi2KXlYo2GGZyIznb2tILdwYEHJbdTrEDmqRPMqXIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201298; c=relaxed/simple;
	bh=e6X+D5c/Tv+Ez0yFoodFngWklvLeykaCU8B+V7wc9tg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o7UG3KLbKPwUWXgqrvW7F8wWV+d69EtxhqauJEOckSF2fTq6abVVDXIDc1zihtV6j7FblpHLlnuwuGA0RZWy0hp9sJgCG/qDnMVUpPwfmJmre+4MV0gnj3bPlcmx4NOXlRvZseACo2J+jRqwDICr6+x5f5/U7OQaI5FkhHvumVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsvPzqB2; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsvPzqB2"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e94a057d9eso340444e0c.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201295; x=1792806095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yKsSek1QBLZx4VbISQM48zQ9ZZju16PuBgR+zu138+g=;
        b=AsvPzqB2AMkAUnOgBySfx+Hw3l8yEXPYIW92JNpxIa+hu8PoWZZgLJd84RKbyoTOsX
         dXc57wYZN9LWkOiMpj3KutBOgcxjqzwVq1a3V5jMH0lrnqImMdl0Sfp772LYYEjcObGL
         ee5ZPCddT96Qnr7lVb1p98Qljv7TC1F9hDw+WyDhsYnAj0sGro10wFOCF4Br9+f1x++M
         mVmBCMy87nrXJQFgB6BUh66flTlUvm9y/kbaRWUG/XLqHRhZ8iaNYFlcGBUKGfTNNlSc
         OpIPntJ8baS7C5VtEPgkuUIcnYkDr/qTnOH9Qrrvvsrs0mgllEgvtVxNaVspwByeSELv
         e/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201295; x=1792806095;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKsSek1QBLZx4VbISQM48zQ9ZZju16PuBgR+zu138+g=;
        b=N8uQrEMXAiF/ybg5wwtxuO4JTd92FamSoOGX/uTmn/caUXc9Rm/FjU4bqI7H5sZqHt
         CW+GK4jT3vgE7XNZkfJS2LpEDvsF5hJMdDO5jqEOdLBI1iUW1hG4yT/7RRyzx2RJ1i8g
         JgKMtnhRTfbMqCbhSTG0RebYlXKAYvMxpREI2FWRCr4uxo4VJ41zOv4WUtUtdHG47/C/
         NwJcx0Hporrv/rDSpKu7ZQ/9SioiVbj8EIxmDOcmfv6oUdTJGIKImYrEt8LsKgkKYKW7
         r56nvffIy8awAddypUMtmjE/zCRQ9DZFhobNGHT+jEnlkMUMgC5/iE+kp9uWvwvbWPST
         iRLw==
X-Forwarded-Encrypted: i=1; AKwUvBwb6U5WjSvBK/l8Fs6YHLRVX7kpGeEeLptnJTahs+vHMAjR6A92HrrchR+OhLF3LKr5OuHS26o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8ods431jAWwySO1rie58s+CmPdtBuYF3LLOfUGCZev/jP+z76
	Zu/4AFYMklH73Z2MBOTDTCa90v38DcM6MWkM/WbtoxgRTpBqGexzc0P8
X-Gm-Gg: AYBFou0BnIfz89QWnn1wZsg01a6zAmPlh+QRIWsJeTCKVFZYk7UfvEwrs2vOnAdPxr5
	as71fI2sNF/CMh6W3/n/MnyZd/pO6+qQd0+lNBje1XuDhJGezDOGEekiKu/GQr1uYx/ALxqKykU
	n/Vuqt46U5j3rBWUGg0K2b3D9hFrA3rleCY10fGuPlqFhDEt6vD3DFhjgACMz6j03vciEsNdmwS
	oLc7C11wX/vC1U/Vt9QQ/gBC/6TfsV3uReDxq9B8Tv6HKbwCf2KK1yRi7Tgfu8R+/EoNRQ8aVC5
	xEy95c3ct5Xd1z8g5CII8sOtd2QH25/AFRpG+vEecl7CagNxSPt8cGopqDWH+fa9G/Gy7UFVXnX
	H4Pgo0yiGHZUIJso2NTjvJYIEayIDwqi2LjCpI1unaLIvHrKE7uqbCxgPxvMbo0V8Lu0Cda3HO4
	8PCCvBCM4boVVfdiLziK6n/bcICr13nYfzgPHXEaDoVBcMRSW3Q/olzGiQtX4O93AmHarhbJ+uo
	7i75WdXD5eigz7j6q6Je/nqPpqfRs0/+wfNqindzWVho27QOsUjFn4z+jpaenPqWkiB5xF/9JjE
	yUNu130q/WC5Zqu0rIFcNOMR6EG+vTg0N9lem5sTqB112eCB
X-Received: by 2002:a05:6102:1612:b0:7a6:b18e:6d24 with SMTP id ada2fe7eead31-7cc36a38330mr415620137.23.1792201295404;
        Fri, 16 Oct 2026 18:41:35 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990836389b0sm2847007241.11.2026.10.16.18.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:41:34 -0700 (PDT)
Date: Fri, 16 Oct 2026 21:41:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Boyan Liu <yymhvert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 co+98d7de09cd94fec5@bugs.sh, 
 andrea.mayer@uniroma2.it, 
 dsahern@kernel.org
Message-ID: <willemdebruijn.kernel.ddaa3b8e2bca@gmail.com>
In-Reply-To: <20261016090526.2497-1-yymhvert@gmail.com>
References: <willemdebruijn.kernel.2a345d6bd54c5@gmail.com>
 <20261016090526.2497-1-yymhvert@gmail.com>
Subject: Re: [PATCH net] udp: Fix out-of-bounds read with unset mac header in
 unexpected GSO path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Boyan Liu wrote:
> Hi Willem,
> 
> On Thu, Oct 15, 2026 at 10:49 AM, Willem de Bruijn wrote:
> > I wonder if the right fix here is to not call skb_unset_mac_header in
> > the first place.
> >
> > There are plenty of L3 device type with no L2 header. They still have
> > a valid skb_mac_header.
> >
> > This fix may be papering over a tunnel doing something non-standard.
> 
> You're right, and after digging into it I agree the seg6local side is
> the real offender.
> 
> I checked every skb_unset_mac_header() call site in the tree. There
> are exactly two: net/ipv6/seg6_local.c (end_dt_vrf_rcv) and
> net/core/filter.c (BPF egress, unrelated to the rx path). Every other
> receive path delivers packets with a valid mac header: NIC drivers set
> it in eth_type_trans(), and L3 tunnels without an L2 header (ipip,
> sit, gre, tun, loopback) reset it to the network header after
> decapsulation. seg6local is the only producer that lets a packet
> continue up the stack with mac_header unset, which is also the state
> skb_mac_header() warns about with DEBUG_NET_WARN_ON_ONCE().
> 
> One complication: the unset in end_dt_vrf_rcv() is not gratuitous.
> vrf_l3_rcv() -> vrf_add_mac_header_if_unset() relies on it to
> synthesize a fake Ethernet header when a sniffer (e.g. tcpdump) is
> attached to the VRF device. Dropping the unset entirely would change
> what sniffers see on VRF devices.
> 
> So instead of removing it, I restore a valid mac header once the VRF
> rx handler returns:
> 
>         if (!skb_mac_header_was_set(skb))
>                 skb_reset_mac_header(skb);
> 
> The sniffer rebuild happens inside the handler while the header is
> still unset, so tap behavior is unchanged; when no rebuild happened,
> the packet now carries the same mac header state as any packet
> received on an L3 device.
> 
> Tested under QEMU with the original reproducer:
> - unpatched kernel: KASAN slab-out-of-bounds in inet_gso_segment,
>   same stack as the original report;
> - patched kernel: no crash, the re-segmented datagrams are delivered
>   intact, and the unexpected GSO path is confirmed taken;
> - with a sniffer attached to the VRF device, the fake Ethernet header
>   presented to the tap is identical before and after the patch.
> 
> I'll send this as v2 with the fix moved to seg6_local.c. If you'd
> rather drop the skb_unset_mac_header() altogether and accept the
> sniffer behavior change, I'm happy to do that instead.

Thanks Boyan. This sounds good to me too.

