Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216661;
	b=zjQUEEMGbwLsTsoyVMabPmFGk+4BlQvexKL7mXFiXw6ez5DzBfgf9TohNI2htrArtgMe
	 TmSpQjnnrTSIhpPRJAwE42fpOSd7jB4s2X2+cFCKxl6nW+L4ljANId5U65TmvszRqjXpH
	 hiok8BDfljq+b4J0xGetSYzgaLYf/Jsa4ObVIkRndmulXBqveHQYFkiM3m9y0Um7ZjhD8
	 5BtXM4EdRHgbQVo3MrAHtkLaTApKYopu+k1Kmon+xME0Ifp/Hxa0ZC8xyT7wygvtHYZ31
	 x0zuTFGtR8BPrdwhF6sqO6HlFGWJVvHu9SI9y/PbYKha2dC0Q6Zqms3oJBgb/qh6mSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
	b=z1n9AF5LfF4mp7osApxY/nKaNLx+5OysAIsknu5EOV2cXAMPQNP5q1Ud9NAps/FgkLBT
	 lt1eAzggkVcDb5bYxmKsuio+Urmz/Yow0m9CmYI9pTgD+m6vSmhuJ3SCqZ4z4k7g+PBr+
	 PHFi+rWQuEH8dWgVxIat3KOGfWEqYXNCl//OtAGxDBdfMOx93eTWdmmt0dBUZXpOaoqOI
	 /jKg8HmCbfErjLK4HHP/FXuRH2wSeRXDgjNiyYZzXPMoZjF9XDGNgNGoOccOuvi3iz7M9
	 p6gTprsA5pX9bTGg2lO+1Z6/dZbY/7CK2m7yXs39Md6CIvnubT7HHtOUZl59dTgTddA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oD80inq1;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FD606A693
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8FD606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oD80inq1
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso16148455e9.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795216660; x=1795821460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
        b=oD80inq1OCi7sES2mZDguKm7iyjfIQpmNo57rsodReJicMZiMJ6FTJg1dEvz8vLIze
         Iy7ugQ9nzgZFaYlcarFHnSoY6M1asQ05+hnWEjOVVAWuLGcA72nzo2Om76rkqGpmFxZ8
         7jU8oVXrWNa9gUvrdtwjG9aDYv7MEv1agucz/fVVZnyDF7DyyZeweEg9XEacOHHch7hu
         NYKudRf1jwDyP8HHjL824XRBWRJXj4iTPzSmVcj5WCQElNJXKXzHOvWhzU4wfIjn8xCi
         XwSu9OhPflwp2fqeB/NNKfXrDUD5VheszfxMeFQQYrBPKaAoV0EnZDIZM0LAGfqSL7Oq
         PxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795216660; x=1795821460;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=726kVL6F6TcMsPO3zHhLa7Egh+S7OR+DlorMBz5s0zc=;
        b=mUZr5zAr4/unPw7j4YcU4KGbRKriih+jrsElAx1iTNFWVGEarH/TKX+ODSqeeV74u+
         CSzyGtitq3KWz+3PqMriIZ/dOIJRA0qAd5UTAuSG+aBkuzl+wBH2RlXdqxyhJ4HPWJEH
         vNxjp4FcV7xWN680JLgM4F4ybnx/dk88iuiNexg/7GJF7fD3DwUVZfu2FhItS0hPDcgS
         HlTi/JhIrmzEA0svpUwunIpFb4/zsfsQsM0DsBEbDNyqNwOKbUxnFfUkTzy2BHhXN2LY
         ztyDNZtKyBP+uM5Mc2nA+bWop0Jh5wX4m8zOPFqqxjLAKVU2f58J1vyggKasOI6EYpqK
         o8vQ==
X-Forwarded-Encrypted: i=1; AL+hErHoaN7huShGwNINtOzcWU4hwnPKIWB/TtGfUc/8Y2OXw+3g5+9IKnvKQyzwARQsXTz8goVAneY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vBECcbZY1bJ0vT443a7WcIee/3eFwyBcj0Bo79GQt1xYSUbwr
	AuZ/btA9w0I3d/WIlZoUumgP9+xFFNAcSRh685YuFfEWl64F4Q/QJt8L
X-Gm-Gg: AYBFou1zrwuh+X2de6q8cVzjpcY3YckWMRKnfENmk2ri20WafKwWVch3ca4z8GLESVK
	Atav1pITABBn4Ez5tGunVH0vPmFBmBymyu3jZ2BcnDdmMAQxi+dZ7aP+dzITlw4ahoPwSc/QkK3
	yqOKNiH35haNaQlB2fbLDvj6J0sq7f0MjCSwZ672mCbyVX4001nUOd2K5JJUiFuSRkx31rjLw7b
	ugJb0jPpjt+vTqE12E885K3qtm4AnBH9CNnWLdjiRYZW1PRHSlB14fYE6vt/FmOwMFZkDhF+c/l
	a5D/xRdJbvbuSrrunUe2PSe8HZMu2VxQMDhPXH3vSRqQcQfE1d5FP7h3Xy/GXbSuXUhu4Rb4KO+
	xzgvoikKWlAUZfC1VMB+2Jy0xhvosYZZfEAQuVLqMH70iQarUT7BZoZ/UsmqgPJ02JTkFEp1pBr
	TAyoSUS4hOmkNoZTyPVZAu6j3NzgLYnACKoB+1mJp5VhVwxze0qdW6lA8FCKcvF+ux/ACs8Df6K
	cTB3t25xiE9zJex6X0w/T4GTu4QvHKHsldF6mZfC7yr+HJlNy8ivKS+OgXoG2ryrrC3rmCHAlTy
	viva4/QZfYz7RV/UTMJEaU9Ggp2ZTondq9rddzyEkrBpFkrPA1cOrgdsMCyxCf8VsitLLpFu1rI
	Sdo94wgmrQxMiptdNRBJIv4JgfKNoPnENXnU=
X-Received: by 2002:a05:600c:820c:b0:4bb:6f6a:1976 with SMTP id 5b1f17b1804b1-4bb887c2923mr101689825e9.2.1795216659651;
        Fri, 20 Nov 2026 15:17:39 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm151650265e9.15.2026.11.20.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:17:37 -0800 (PST)
Date: Sat, 21 Nov 2026 01:17:35 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
Message-ID: <xupy6jbpnziq2qji54zjbvm7neggrwkxg3sfrhlolmrd6ysifl@zptk6ynkbu5f>
References: <20261120210134.133238-1-antonio@mandelbit.com>
 <20261120210134.133238-2-antonio@mandelbit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261120210134.133238-2-antonio@mandelbit.com>

On 20 Nov 22:01, Antonio Quartulli wrote:
>xsk_get_pool_from_qid() checks the queue id against the stack's real
>queue counts, which can be higher than the number of rings the device
>has: on 82576, enabling VFs leaves a single Tx queue while keeping two
>Rx queues, and igb can fall back from MSI-X to MSI with a single queue
>on resume. Disabling the pool of such a queue, e.g. one bound to queue 1
>before enabling VFs, then passes a NULL Tx ring to
>igb_txrx_ring_disable().
>
>Only disable and re-enable the rings the device has: skip the queue if
>it has no Rx ring, and only the Tx part if it has no Tx ring, so that
>an Rx ring using the pool still stops using it.
>

What happens if a pool is bound to, say, queue 1 and the socket stays 
open across a runtime resume that falls back from MSI-X to MSI 
(queue 1 becomes invalid)?

If the socket is closed after igb_rtnl_resume_task() has reduced both
real queue counts to one, xsk_get_pool_from_qid() will return NULL for
queue 1. As I read it, igb_xsk_pool_disable() then returns -EINVAL
before doing the cleanup and resources get leaked.

I may be mistaken here, if so, please let me know :)

Best regards,
Janis
