Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758D361DA7
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129802; cv=none; b=KliynzoaFEVakz70Aevp69PR2B7WIZFJY54ayET7Msj1Ip0W+pZzE/BOgcP6Wvk9kZJLqPQmOvW/R8xjCdTO46FU3U6Pb4gDXbimrJcc4yHhxhkG5T5D257/uToUTIWhbig6BmF7e1WVrZO38oknr/wga9EeAQcIj/cj1Y1CvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129802; c=relaxed/simple;
	bh=IZhPed1q7L2TyBW5i0KD0pzxC32rkwkAl8KJQklJJ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/bYTNwuByEWkS5ak442211vll8qfd182Vv7Giuqr2C01NjKE38XLTpoyzWM5iqbuagzQ/Ti0vuQjeLpw6btXStLU/DTd7oWoj3FU3mIsIRO1T6QBk9fksAPlzdrSRLXEgFy9iotYX4S9JXVLWjwFNzZtv/cQl6EbLpbKJhWnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC/D3cJH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC/D3cJH"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad861b1so62416a91.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790129800; x=1790734600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuCyJ6IFEOSdv2FxshupIdK+MabP7+2VqvPHZvAqqKw=;
        b=hC/D3cJHwNt15RYIPEzh4LMM1DrcPIZCcK2D3HsL9H54Cl95/8kSgXjcQ1MHD/9rp2
         56PWWnM1LEGlluit/IzhsAf7lvEXZt11yiGaozTFF3mtxaofjtz1QvwnDCjKs0bCAcba
         IAP7DSNy3B3OMpwI7bdgNFAtdHceDoumQ9c2tYJnewAMt7BeNv3VGEFchjbgFZyGewlI
         Wc2IlClojlhtW5ZVR3mV/UKpEnPtzYw+oLrt2FwbfLZreQo907VRW19vZtdmFPJj87Td
         BRAt58XM/Umpr2l8ppa9aiFZGdlIxf0pkpr2W08SlFgMwiEO8qGXQ1GwwObc6tWriEjh
         EGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790129800; x=1790734600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuCyJ6IFEOSdv2FxshupIdK+MabP7+2VqvPHZvAqqKw=;
        b=qS6RvBQvljedi1RWJv2o6i07+vL8Ct6UE2ypd5uhGetMpjvnuZIn6RHHdgtOklr89Q
         vgMARzhMN/5XgmlKT/HnBcqciXr7hY81pC+wDMrwH0gNtzvpiR7ElzWx7z69PYbm8U0G
         snDEqQvEgpx6s8LIiGR05rj0TqnQOk9okJ3gdKV/atbLu6WOff0gQ3iSLPvB64HXG/VF
         wQnO9A4E5AaK3dx6u+DSNCQfFu8+RpwHTyq3+ZrXOWZIJC0XDRd2IO4Wt7IpOrX/Ws9v
         oFOUjdb6D+FaZ1yVQEW1pgqjg7jrxm3SadVFVRpIQUXhnvdP5FrjuvbI3WiUhLB3eKCt
         i4Zw==
X-Forwarded-Encrypted: i=1; AKwUvBzXA3BnednrF+HY9y8VHjc40lnsd/uKJIrHQ65z7fOIU6d9t3ic+CFxmgz82aB805BcDsmSnPw=@vger.kernel.org
X-Gm-Message-State: AFuF++mpZj2z/gq++XRLWJOONhuRYTcSeNcfXo47aJYOOVDccxtOSHrJ
	qzaaQRYJJ29pNuC6OmgUGVn2hDovHqFpBSpPkK9JQOlYFuUCO4RbQd5l
X-Gm-Gg: AYBFou1PLceLqFEDW0NoLj7WRbpDgGXvgF7MtmhaX5N/qYbrilbZaiS3CTvmCcemSiz
	U6m1LLXz34lJEyW8HmLMYRZMU/v0RS6EEi2FnwJZ59SA+1aPV/gW2Fla0fBX4WqcqPdDyC0KI5d
	TUdZMrrwWW6hG+tQ1b9iCKbPahoHQGsdKw/uZV7u8b4O2NspbdAwWY59H+2PZMO9jXhIafDJ/Qn
	+lQfguaMxD1CqTpCbu4G0D+BYTfRsZHdoVQ9kZaGOFmBgUyvpMuoI4HsGwfyQlK1djhWGw9tR09
	/cmdMat9ouAz9XDGm8yQohbVkKs+X46QqqDuylLWdQErRzBuMqgB7ZZaF105u0hiXrsAYZgRG8j
	Z8OWgatENvwObl0oZM7wXPvrDrZwWO5NiVvm9SQj82TDTYxgHi855jJJsNECsZaqLcXI/3JjipZ
	iya7Y7l1isVqnf1Fu5LIHgzqbwCxocoMYz1NRC2FfzMWfYAeDLuEdql8Myo6ExAXeaLMNyq0mjO
	UNFWFSnf1CRFaagUWQvUDudSxao8PN7NgReERERJ2+tm5Zdg0rDTqVO43bzvrE5Uig/i+Yw+g==
X-Received: by 2002:a17:90b:2e0d:b0:3a0:242e:7397 with SMTP id 98e67ed59e1d1-3a07e6b6766mr1767943a91.4.1790129800347;
        Tue, 22 Sep 2026 19:16:40 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3b7240sm311865a12.7.2026.09.22.19.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 19:16:40 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH] xfrm: validate ihl in xfrm4_transport_output()
Date: Wed, 23 Sep 2026 10:16:35 +0800
Message-ID: <20260923021635.38837-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <178997713210.2160803.14018605703606783403@kernel.org>
References: <20260917072226.80788-1-q.h.hack.winter@gmail.com> <178997713210.2160803.14018605703606783403@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sashiko,

Thanks for the review.  Both points are valid; I will send a v2.

[High] pskb_may_pull() instead of skb->len

You are right that skb->len is too loose.  __skb_pull() only needs the
header to be in the linear area: it BUG()s when the pull drives skb->len
below skb->data_len, i.e. when ihl > skb_headlen(skb).  skb->len counts
the paged fragments too, so an AF_PACKET packet with a virtio net header
and hdr_len = 1 leaves skb_headlen() == 1 while skb->len can be large;
ihl values up to skb->len then pass the ihl > skb->len check and still
reach the BUG() (and the memmove() source runs past skb->tail).  v2 uses
pskb_may_pull(skb, ihl): it linearizes the header, which both satisfies
__skb_pull()'s precondition and keeps the memmove() source in bounds,
and it rejects ihl > skb->len.  ip_hdr() is re-read afterwards because
pskb_may_pull() may reallocate the skb head.

[Medium] lower bound on ihl

Agreed, thanks.  v2 also rejects ihl < 5, matching ip_rcv_core() and the
implicit assumption in xfrm4_extract_header() and the IPv4 BEET paths.
This keeps the mac_header protocol byte initialized before esp_output()
reads it, so the uninitialized-headroom path you described is closed as
well.

The check is now:

	if (iph->ihl < 5 || !pskb_may_pull(skb, ihl))
		return -EINVAL;

	iph = ip_hdr(skb);

v2 sent separately as [PATCH v2].

pw-bot: cr
