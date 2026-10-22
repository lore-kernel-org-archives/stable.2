Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792696751;
	b=0u3aKkQuG3QtAllPgqWAcppX2aeUjY9k40SSGkqmbTAvvcw0IWhshndd3tufpYTLL3cO
	 fTI8T6MGKUPNRtbhqrJ1LOLJ97TaSwV/FjgQC/55POeCRW1N6qtMlhtIcxmIO6ZtxrPXT
	 JTrraGMNVdrOo5OLCl09CV8B8ShnuUu8fXXvnl6TSoolGTpwvJIYHtlpQFQCT5DgLKdtQ
	 6YJUepkHrXOSEBTs5GnkNE104Ralz3dyemP1UKx71ZoyNrnPtD5RNQjaYAnHyHoNNOhsh
	 LaKTv1LnZ7a3nSP2UyrMRloUCV4N3XtgDVGiHV57bEMTBCt0/htxC38uGZx/h35uN1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HFbV3ZmoQh8VWrTxWa/9IJZkIiSATHZIo9x6Qfdhxic=;
	b=rdE5LfOX1nX7YYG1g8HxBCJWwVikrkhqWPVx1bWdX9DC6uQrdE1G0osOOZ9cayNmQQcK
	 IWjJ+Ef6xTXm0B8+P0EYxBgpYFhtZ81mcSqVRW28X7N1U02g02rPcoy2Wub99/CUGTr4P
	 LDZynKA8VsBQozS1Ku7GagkdLHWwR/4FHGtlcpMrziR9wA75m4H9ahTfcAlvGpi/9Dqpo
	 rtfcq14u1/ASoKM6fLuPcQJqTkxsr1GvRH0LNCx5YzPPGxqL3o5FtUKzE1G4i+rimjqRi
	 l0L6wdV37dITk9J2UmCKk13haXGzvLB4fBswR6GY9UVkuTjLYuT454LHBMUrp02eSAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HUHYJWNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431B606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7431B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HUHYJWNV
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so472975ad.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792696751; cv=none;
        d=google.com; s=arc-20260327;
        b=k7i+Rra4R0oLjbKrid8IlRkY4+fg+Gf4rSODfIsIV6el1lMLBsRgdXvir5JzX4jVxU
         6tGxY4k/ACmMb3CjhtGCkoniUpC3AqdT0E8x/6BGGDP55BX63MyaCzUUaVKueu1VS0cd
         hCigJgc9DJU0riQ29Fuc4W7iUfoZhaKDvKxx+lUmm5dKa+sb0ZogENgjocQDML8OrZuJ
         6iJ4NjK1l4saxd61ySPK4+LwP6NMGswNotY+mJMrnPyHhLmlXP4i0+PSD17XjoBUr8UL
         H0SYLrXHSDgT29ND8+cJg2r7fac0cqeK6ahiN+uUpToIh0Um0FNsdlJHkEgVVnyYzPp8
         i/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HFbV3ZmoQh8VWrTxWa/9IJZkIiSATHZIo9x6Qfdhxic=;
        fh=O26akHyMjdSPY7JgXlP+cUimrULs1I9pFuGkNzV14x0=;
        b=PzhJRyiOTvwv4jEyVLV3Hm0sPAxik/ihsbJihdDbwEPkLo78lEZksVRQpQIxq2oKEs
         5RIiga56TeWWhxOflxHg/vLhnShdT70wLtA28/Oa3GiRtwUqzoQ8y6fBEWZAHIRFU/ru
         bYWP73cebf1hRp8NMA8wRBKqbZWV6G9SGGwdyo+tQSPtn7vfBu3iEmlZTU9qIbu2z0su
         q6RZr+UmjR1a8fFtx6q1dOESWRY2cjB9GFFwHxJEfnpuR72/8bF3sg6mLOUkG5Qn1VAj
         fO502wQ2JVJve3oOo1xhKiTw8+OWT82xRfXl/t8QxpJIgjK9ungxmkXK2LpzpiFblwnO
         nXVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792696751; x=1793301551; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HFbV3ZmoQh8VWrTxWa/9IJZkIiSATHZIo9x6Qfdhxic=;
        b=HUHYJWNVBBzzw12TGgb1Gjx1LAdBaTPU5PR4UvWHnwn1TznHA3EosZX1jitM48WqZ7
         wwJus2/16oth39VfzNYF2xCx/BtrIyn9ZURdxQ9T7PfExDF+Q/4X3EbYKeeh3C//ALQz
         XJcmhDow6n5WPE8ykvpnLfupl3qWNpse+5MdIs+j2Rg4E4MMcXyCzm7Ek9jRHj5Y4f9E
         xhgsC14or7ceXSUD0OFXAWiO1RhZbYZPqcf/+26wf6rG4/jPlzTkBzGNnZyPj7Ia230p
         6RRUYsLx09iDCd7kl3BwAluqhhvbG0jJcvU4Sn4LSUOrwmpnDMIxGYu6CiBJV3T31X1+
         IKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792696751; x=1793301551;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HFbV3ZmoQh8VWrTxWa/9IJZkIiSATHZIo9x6Qfdhxic=;
        b=y9Kmsa8H0vftxj979WloGQhmb5/8BbUTE0kOGSuiewCrhNrfWG0erQNZJG5U+F+jSe
         UWQYA0tzieYWtLwAd1xJB8pYybo/CQmSWd3cEhYRi8PMXVKoos5foGQL4k6CuU2BHkEI
         lofcC7QqJOVIMiL7q//ET8gvlU6rbBXQUcXFqjhq+iEoQ6YCP75+2g6AawA8chGLskVQ
         yGdi3a6lrtBbf18ING8fj7bd+UANyEq/YPj/9N6HWDtPxFt/L/5sX0fjG47kq3238ySp
         Kh2vb7/ooMjjlkjfeL32qC5hQBqtY97qiAHx+s1I1XfFFNuSPOG+PGuF8ZK8PIpbvIIJ
         5p9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwOgPe1UJmQ8SmZSs2WbjibQxip/meJ+IdJJuWBjGI/uev68o2f+J2aPjvkg9ssBRiW757Pyc0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvKzxU2U7mLfQTgPPLNDgSsvlhktihhl0RRNwnJEW6AFBXx/XB
	RRqY79iWqJssoV7PN3An5UdoUGDSocsQx1s7/d6mYTA3cyOkM0mNm0uaW386KFqQ2UW0exR0Wfm
	NpVLRs3frxKeeztxYPqoO5QUmY3YLOC0=
X-Gm-Gg: AYBFou0h0QUaH2B0N45cq5SsmcLVnBXrtZxL8gtJ8DHYRaiSFYqy/bhqxG0NIIZYEpk
	VKfhy68WB7trF3QZ5LwFlGCrSu2le1zezF++B211QVtN4+eK92Bj/BKbg6cTmCXCBrU4xxLa6M5
	4Ol3MQXlZSW6ZLyC+EOCG1R78/JaNErUi0vFlAipsS8Yp2p9bOJ0cTQVIzep6o6oG8k21opgwrp
	dEtMit0hu9zirO92DpDZlrDbe76WPlX2b6rwqpdwzW129JbnifY+ewcnNxODMPrV4rjCxVvrSvl
	7w0pQr8LqCCytitK4jiAbC4uyRuU7wY7jblWto5zYMB1i1WCEifK6j9SJoQuvRIcjISudsw0yWt
	XwzuErhIdbT4Y1eT1QXeKxrP2XiSVh3ax0t3q5w==
X-Received: by 2002:a17:902:d50a:b0:2e3:643:279b with SMTP id
 d9443c01a7336-2ea7c2fb41cmr2298195ad.31.1792696750798; Thu, 22 Oct 2026
 12:19:10 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001184529.502048-1-hoopyfrood42@gmail.com>
In-Reply-To: <20261001184529.502048-1-hoopyfrood42@gmail.com>
From: Chris <hoopyfrood42@gmail.com>
Date: Thu, 22 Oct 2026 15:18:53 -0400
X-Gm-Features: AclHuK_JdEOtm1oQQ0eGO--vDE49kxltYgJazkvOFHQacXc2cYGPhuXJcpgeJrA
Message-ID: <CAHaeJsTsCP9SEejH=RT=9vu59vqq+iFXaOUYAo75UXpb0U6qTw@mail.gmail.com>
Subject: Re: [PATCH wireless] wifi: mt76: connac3: check headroom before
 pushing EHT radiotap TLVs
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, deren.wu@mediatek.com, 
	mingyen.hsieh@mediatek.com, lucid_duck@justthetip.ca, stable@vger.kernel.org, 
	greearb@candelatech.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 1, 2026 at 2:45 PM Chris Kelly <hoopyfrood42@gmail.com> wrote:
>
> mt76_connac3_mac_decode_eht_radiotap() pushes the EHT and U-SIG radiotap
> TLVs, 64 bytes, in front of the frame without checking that the skb has
> room for them.
> [...]

Gentle ping on this one. Felix, is anything needed from my side?

It fixes an skb_under_panic in monitor mode on mt7925u (and on PCIe,
per Devin's check). Devin's Tested-by is on the patch, and Ben agreed
it is sufficient as the minimal fix for stable.

Thanks,
Chris
