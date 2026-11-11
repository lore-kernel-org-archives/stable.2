Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374512;
	b=dOhwSDgLKA55W56Bfk7KFHlFjINHu4pPJ9L8lhkvfbX5XZdOE8IsO6RnjK3h/S9lA3BC
	 DIEK8gZ/h+JvtiuJ+JcjRPi0u23xu82btB7eVrRxR14xmcAhF66abCgwpWlO6qfzwUZvs
	 VMPRg14tr0uGJOI4HY5joZ9eAxMx2uFTNWXH40VaCRLFt0BFTX1UCMFYmPxo+PDDXLFR7
	 0huM7piBXZGUYZeKuL+S4WnqHsPtMTe5kDg3PLj02uqEoVEl4/2qlRyTSkgMawWPDDcw1
	 3d0LFkUWdU6j68j/1lCFADC7vcSVPMlHEwEmjiUOzOktoJbowqEue6RrYBYo5Bt+sTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bxBhehEVB7GhBTyrxNNIZW3iu/okUMlI0I+39Z3+sLw=;
	b=Tt6plAwfUmJoRKXpuFgxEJWqxRBh6Gh4TtgidUMZuGVkRLCLX3AqrGuTIvTl0cvZDyAf
	 fE/k1v24EPOaDx5fc4ZkJl7qR7g/lN4Mja+lvZ9Qq1JIPnKxmClhB5e8hgW9DkjXVTRIF
	 KPrNwLh+y5dfUyoOUhkRXrieWBFUHrr4t85I1tqYR6Ikc5+7pX2mYMfAIjyxHT7ignBUK
	 8fw6r+8GoWdSl2RoVuxruzLSrdxYKXPcBLUu0I2enLD/a2md7+BbuC1kKAKR34ROdGGgR
	 ov6szGSNkSjRQr0O3J4KpJJBjyrk8LwiWzWpzo/VehN4tCpwgTJW97rrkxpa6uKArmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pJSV5dg+;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D0606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0D0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pJSV5dg+
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea71803effso28110855ad.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794374512; x=1794979312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxBhehEVB7GhBTyrxNNIZW3iu/okUMlI0I+39Z3+sLw=;
        b=pJSV5dg+mhaD50UdQfyywMAVAMQnMO1VJCg6UT42ganiTChwGMg2OKV3fXKN+oE8nd
         ZRlSOknDfevWqRUm8Byc7sESdXB4FhGqANthVSegZigbVRWaaNvdpXCnCFEjVSIy9u56
         AGaVtUGd9ifS0n6d8y9R9EB3nCTNdhM8EbUKxOtX4Z0voc1TM1sfkM3J4tTnyAAHgodF
         FuyjvRxBvj/0eOGRUyPyDMxHORSJr/KE3A9sZNNP3WKqhNYJL3DQltraYvEKaOPx2aHj
         M+golgNEpemm2Y+KzaN1VZl1wGc+Fjqq4aW8yPC91a5IUzMPp6eSCRsAqiO2a6hf5l/U
         ro6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374512; x=1794979312;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxBhehEVB7GhBTyrxNNIZW3iu/okUMlI0I+39Z3+sLw=;
        b=YctGamROhFNtH5/YXTc2Dl9+Fo6V16BL6PhVokfmVniP4Qq/6G62GlIflbTlNkia78
         amlBgawmBpiG5hbQnXBZxVLuxhFJVoCwf+9gguiU+2/+Kx5L1RcEaQHFOw6CcCp62Epx
         sZ3n14YP150FMN4CG5tut3peu09v3tSOQhMB1i0N5JB9lCfR7Q9H/YN+pG68E9ewJmUG
         ohjf04I/qnvUk5mJ/piF/aPagQJ3WOcA7UhauQK7U/qcK505Fz1t03fLZa/7l294GKfR
         5DwpKeHqFxhQmIliPrixafG0/O/ccz8Ha5beCjrDljXij/o6Ax1v02SQCg5fJHZx8qKQ
         2d1Q==
X-Gm-Message-State: APuU4Z+SBCl4O9cY96wOoXnTKfyYE4xczk7Wm+vNECz9yaUCGtkN4U4/
	S0Nb0MmGPvdlHF2/TVLJ1x5qBpoHMpfBToFo/fnp+Vu7xRhFgMFxqOly5/TLrgpy91DSoXjXvxF
	Af0ZTtw==
X-Received: from plrq9.prod.google.com ([2002:a17:902:b109:b0:2ed:b80d:bc91])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ecb:b0:2e3:1bb4:6121
 with SMTP id d9443c01a7336-2edd7bf156bmr15084625ad.49.1794374511503; Tue, 10
 Nov 2026 21:21:51 -0800 (PST)
Date: Wed, 11 Nov 2026 05:21:51 +0000
In-Reply-To: <2026-11-09-1-daily-reply-0039-af-unix-oob-5.15@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <179418529889.10436.12048717656065553331@auth.ink> <2026-11-09-1-daily-reply-0039-af-unix-oob-5.15@kernel.org>
Message-ID: <avP62mmu06rM5gaj@google.com>
Subject: Re: [PATCH v2 5.15.y] af_unix: Clear oob_skb in scan_inflight()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lee@kernel.org, netdev@vger.kernel.org, 
	rodrigo.zaiden@canonical.com, Tamir Awad <tamir@auth.ink>
Content-Type: text/plain; charset="us-ascii"

On Mon, 09 Nov 2026 10:53:21 -0500, Sasha Levin wrote:
> > af_unix: Clear oob_skb in scan_inflight()
> 
> This v2 applies cleanly to 5.15 and looks right to me, but it is a stable-only
> fix to the old GC with no mainline equivalent, so I would like an Acked-by
> before queueing it.
> 
> Kuniyuki, could you ack v2?

Code-wise, looks good.

Not sure why the changelog was not used as is and some useful
info was dropped.
