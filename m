Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551230;
	b=KkU1kDon0vrDkxj4N32ruDbgFo/vUIHLT+n2BgUWtKKCqt5iUWtUFwBDpA0CgBBcQe2v
	 Q+wmhr5GIXG3ZXW5ZWLrCp2ly5+1hCCPhPwOoC1lFBlxCTDnoC2F4202e3VjEFWu7o9n9
	 mimW986sBJjoqkBkMrF9uaRR2Sajs0/6pOpGxWGNTFHf0IyoPMSWQCENABXIZX5LMaOQg
	 TWHWFFOhgHKq84qI4vBU3RoObBZGciQLidlzsTckLxNlFDeRPn5HMLZ5anwrInmzX3TUr
	 DtGB1yU/HS2f9YB5t3VpGJzo8UM0UKtZcUMBCv9wHGFLpP1dMa5METPniWR/dQ/0lQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551230;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=rlWIHX9NSm3ZvbB1YngE7yXcr1uevNuXKUdmXs9oPKQ=;
	b=lDG8fWDqC/cr6vMv0Sc8S02mKbgry2LtyK1HGnfUOt71elOGBX/Rkr4Rw0aAZxy7pb3A
	 N9iQpfeupWHXF5KzUBJe2BJuW6mUdOWLcV4pjx0bvzjQWdX0DhfS/MlHC6ZdrFUQfVgQ7
	 GCh0+ghRQJJKLQBupQOhrlIKQBsiw9iVGYqwsoNCo1H76pFNpwClxYDumh9jdcc0KKEim
	 Y4bx1y8yCEfgQ+uBdt9m98d4N5k9saknwy5qv6cEyDBxxAC3rXSV2BAfmTxX2GVOz5NuH
	 y2bXdwRrCgMgaJUYeeM5ummGdmCwA+HTK/he55CzOx36AE6JozRFivMVgsOsrOqzBsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="M7HGd/3T";
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B9606A69A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485B9606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=M7HGd/3T
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2f0458cc9easo38721045ad.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551230; x=1796156030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlWIHX9NSm3ZvbB1YngE7yXcr1uevNuXKUdmXs9oPKQ=;
        b=k8Zu+z8VTp9LfirA+4RXu5f99ClFIkdrHWO5Md7lxcUQr4KJt9Z9dErVr5k8JComJb
         jEF3BQ2W3xKp8AYGL3bLouUevfOyud1rEaUmOoK6vAPuQvYFNxSH6n9vwT1qEZcpDfBL
         evSVzV8SiQRhUgGoI/iTiuerE9TqOPrNhFZBqp+lUuJ6J/kdIvJAOncpGLzWlsUPDzNw
         rcx6wQ05224FjCSlX8wSH7vtIDnKRxkHb6y8sTSgKhSBt6fsrEAoaVG5DE9Tsz6RR9HX
         D5X0Wc6SsNJyhgWuQl6flW+Fx78pruMevzCpZJeyXcL2d44aSUYcanVDMNAK3YiU1zya
         71Aw==
X-Forwarded-Encrypted: i=1; AL+hErGcmp1PvuXOS5JGkK49qUw4GHmAnwVIcQDU4Qd2JgvOvFbvMQ1B78A1zfRjYtJJ0QWApjC4dJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pwmLZfHAWs32Ig/oYd/rCKNuHZzGMHbP9w6IIDoqfxb3W+ajb
	CubM/eo02Egl+E1BUyZmo5wOeP0J3yrJSQUgp5FmhlrA8hgVBTAByHuNfg+pbVTDhgQMp17PaCu
	JDRD0M40r95BgVgKAlUUj7xMNZO3cwhfWTy16tXOZCqBV55dYeUwHGsCZh5tLP3FoyMAngK+1d6
	EPufJ2Q4oNUSkrafC6FPPj+ofUpadOKBmbOvcHD+KUiFBR7AGSTiHGrmFFKZslUt5YsYgM619GC
	hAWcM3erJDqp2tOZQ==
X-Gm-Gg: AZFdTZeAzVVUG0RHA0C7sjk7NgwbP0U5pOeyFjNzChyP+jrwQ32U5N2cq8kml4d0yHv
	0jQn8rLvIaB6l7nWXV0gow7xGtm006iGWVN5l2uTQhqbr1oLuOP1wNjpDHLymxa63tGkdmC8rrn
	4xo1yIC0JB8qG7LMiRPiUMO6IW5jBjuJT626v6mh2L0gN8VltFUpkn2FEj2apSEIqZFR/+x5qYb
	byEhTc2NdRte8poI+OG3h1uQ92WEhgs+zYNzjLfMaiCGCenEo+2yIG4HjEPYEeaQunCchtEGU3i
	pjlMkVnO7mUUurKiZLAW9sFoeZm9uFgwlWTpvRls378FeJaFVPHZ+qd4ue5pKBgpSRidvIKwPI8
	lhKdAJO4ehpmGWohInwTiIZt9NqSltiGKZgZS76OztAoV4WKk5RL4VSvUj1eM9yiv/dWfOIHQaf
	YpbKWoeH8+fS1vTcE2BPK+QwuZgOjcUC5UAilQLT3CWA==
X-Received: by 2002:a17:903:2984:b0:2ef:f656:2db8 with SMTP id d9443c01a7336-2f03f1a49ccmr153680975ad.30.1795551229633;
        Tue, 24 Nov 2026 12:13:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2f09ca54a98sm1041015ad.7.2026.11.24.12.13.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:13:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc4149b885so3505185137.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795551228; x=1796156028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlWIHX9NSm3ZvbB1YngE7yXcr1uevNuXKUdmXs9oPKQ=;
        b=M7HGd/3TpBUGPZ1clDzQQjzBjwjIe6K59CWkQ19W7DcpRKGoYxib6Nw4UvURpwY46W
         P7RQLVK3DQThTzGVosGY8a2qKmfAgLpYza7ErvdKnxU6jZNGbqNoS7QddvvuVhky7fYq
         VtV3S41abudzT03vJbRYSr3XM9eemBqp2m7Qk=
X-Forwarded-Encrypted: i=1; AL+hErFUdAthB56X+6K7TPvBnDunFIEOVuQKfmjK3pKJ2EP0RNWKkO6m0+JGzIpuncAH8TGbYujWFY0=@vger.kernel.org
X-Received: by 2002:a05:6102:f97:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d7396157a3mr7708537137.36.1795551228584;
        Tue, 24 Nov 2026 12:13:48 -0800 (PST)
X-Received: by 2002:a05:6102:f97:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d7396157a3mr7708490137.36.1795551228151;
        Tue, 24 Nov 2026 12:13:48 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm140905426d6.1.2026.11.24.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:13:47 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: brcmfmac: fwsignal: bound the AMPDU reorder indices
Date: Tue, 24 Nov 2026 21:13:43 +0100
Message-ID: <20261124201344.3494326-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115185843.64633-2-maoyixie.tju@gmail.com>
References: <20261115185843.64633-2-maoyixie.tju@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, 16 Nov 2026 02:58:42 +0800, Maoyi Xie <maoyixie.tju@gmail.com> wrote:
> brcmf_fws_rxreorder() allocates max_idx + 1 slots when a reorder flow
> starts. It then uses the indices of each frame without a check.
>
> 	rfi->pktslots[rfi->cur_idx] = pkt;
>
> A cur_idx above the allocated maximum makes the driver write and read
> past pktslots[]. An exp_idx above max_idx makes
> brcmf_rxreorder_get_skb_list() read past the array or loop forever.
>
> Store the allocated maximum in the flow. Bound max_idx by it and the
> other indices by max_idx. Deliver a frame that fails the check without
> reordering.
>
> This was found with a static analysis tool that we develop. A userspace
> harness that compiles the fwsignal.c functions unchanged runs under
> AddressSanitizer. It shows the out-of-bounds accesses and the endless
> loop before this patch, but not after it. No hardware was available for
> testing.
>
> Fixes: 87edd8916ee2 ("brcmfmac: add AMPDU reordering functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/core.h        |  2 ++
>  .../broadcom/brcm80211/brcmfmac/fwsignal.c    | 24 ++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
