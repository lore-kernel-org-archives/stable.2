Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528072;
	b=0/iEM06IU/oaLL+suKYHfAgwbNhwZ5Tk3cwRgkNqhmS2ErPp4elHhxvakMc2MHpUrS9g
	 /9KOHysbpFLTMIweuQwJxiEF5PzGSAH+XvNOKRd1puulL96WgWX7QdKNPifdpSgt+0eTD
	 OSl5aFt82t/OWTXYAxffnRiq7lJi0Sjbc5KHcMUwF1Ri2+SylHeFa/sNYSKjHBKHZwJZw
	 KVMwp9sG2916OYCOnr2VJw3SfdAFornOTDkudi3kvrJ5HLpRZiacyYP6ahJS1ehW5cbU/
	 +20rym6iL7lIl7GTxok9SGKN0urjBZKFqUza6yPJXskSyQsXe+mWzMhvNNa9zgO8VWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=j1azJ827J4napxY8pkAKVpOgDxEHSu+Tz2FVu6oeb9k=;
	b=Xon3uOTQJ1YgYB2Si6eN8yxnu9TItBQ3uLneKFJNNIx0mkNk9TYKNeyKtFHm+L2ZTt2L
	 t+pLIVmgiJfAIoHzH4A9W5NL0Enlb3WLDVV18NC2iZ2tmNhN0BRc1r2/nt2ssZAdmstri
	 nJU3Wdx5wBDfD3YrUD09daEqaa/NKnGlc2IE/bThIGrm4ouW/6tOZlaOAkFJT00XMIY5D
	 ao3nYBi1vH1bPSxYd2XYCutHtrURp9bu4GrPjOKgD8QPF1vBb6h5cZDdRyDmlFzTXBrHs
	 mhcD31Ny/l9oa1dodmpuU7hzbKkypMktFbCiRdQgU0c0P41FAeMaEEqVYETdLYR5Kxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=B1b7AuxV;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC85606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC85606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=B1b7AuxV
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53653e30353so791741cf.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792528071; x=1793132871; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1azJ827J4napxY8pkAKVpOgDxEHSu+Tz2FVu6oeb9k=;
        b=B1b7AuxVwOZ9otHwRxe150bvOC4s2T7c0Xx2cDRxW2SkBo7s9YLCe5WlFOKwczA4sP
         fvARxR5uiLfOFLHA6PeNc8I6D0TXye0f6rBcbgqTBWmY7AThtfA8p4uJgt/EL7iL6nJh
         ArFBs29ueub12pInvsVyeGCFHCYhPZhCP9OroLjzbVs8yJjIvHjEF/a5Swev1xSQP3mL
         MwRtb+Jc3+F3uwiQ2+nD0fZtmdriHTQjDsiI3CKZtcjRx1+lCb4MNCHOttOPl6QkF4LC
         VLjFNHzOdXdRx7eeghQvxg74iT7awWlYz/UUIV4U9S0B1CVibW0CDzn0clpjCht6q/q/
         BrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528071; x=1793132871;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1azJ827J4napxY8pkAKVpOgDxEHSu+Tz2FVu6oeb9k=;
        b=Ru6URExeW7YU1exOxvqSsQQszTH0IUR6x2a28VGYLHkOGiLgG/rUtqinXJDoGt2HI1
         OvHakaNvAtoUzbk2/UmgxHcVeQ/Hg9bCP93+GdCyyw3Efe5d9hIVpvAT1GSvER3Tt6z1
         4/T41zfng6+IeUHZCDvZMDRd5D3bb+qfX2YSJpvt5V3Jzo3T0ohZi51qodB/aa9TpKYm
         Tjx+jSiKJJ9OZya/kvtohoAMsa/e1NNn+5/azCoQ0EXpkf91aqkqXp+HPWgH4xLr0ZPe
         WEmMqasJ76Om2PaMBtYZFrCj9mf2qY4dbcGd5HQxfzTTZFcC5P2k1lEpGluz8kzoXUxB
         EOwQ==
X-Forwarded-Encrypted: i=1; AKwUvByLLlFbokX+QsnrwiuBU/sgnUGRgmuuk7YPl2G6NV58H+oLE7tYXhs5+JvaLZRrMHN1tujGzxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKepu4rPTXjGzlsmXEq15Xg4KofQnrWmU68TxMxtu7JABvr4Nkq
	lky80XoSA3SbdHk8aU3AG0W+2/ol9Jm6LyzWUaEH3jxJZFi/7mWK+19NNmEtFddrGuw=
X-Gm-Gg: AYBFou3zhKYrRx6GL5HP7hl3romxnut1mPDppeYAYFVUINk43vkCEr6LlyGXD5hmn2W
	rB1YjrxohhmwANggfYWQUwm/K6E53F9ybL+uwCEly00RjhOELbJrp6P14hXC3XOLPW5WsVkyTEQ
	D6zGoH7AxW9SRLOSx6FMLCodtt4c3h2Vp9/YxBufH4TXbeMNSTl86o+sB94P4DS7UAS88mBw+KH
	infZnKu8PYjjhs3HoTvTDBfQ3p0m+7nCmE2BMIWyxIZkfQLfdhPkZsQGe/lNqBkip036z/kmxrB
	VqAowiBhIua2ir9th6JXHg0aqlr55562ExbqzB4nTQRuR+WCaSxmDVcR9zHGk4r09678tQWgKuH
	2x1hhFyyPH9vLtBDTU+Jakqd9pwj4y8D65Iacnzwp/L6zUizVUBJDaj1MsUQTno3dqsZrqhACn5
	r0TikVrOlX9CdHXgU0+x/PaLc5zbC7ORu4HE2WOiW45Mhu+rp2luJpwQ3KktP4KqjcGfYWfeNQ9
	7F+QS1j1XgmCzNr9i4IBlz5YsdA3Uadq9G4cMhXUP/On8hN93InDasQYekoEVUNG9MFa4oMVKk+
	LC1ozuGaO4T+4R3BzVqSExr1ZjXsC3kp99Rk7Gc7icmt1vwE
X-Received: by 2002:ac8:5d0e:0:b0:530:8853:1be5 with SMTP id d75a77b69052e-53645c32ef4mr200533381cf.10.1792528071192;
        Tue, 20 Oct 2026 13:27:51 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698bb8234sm4300751cf.24.2026.10.20.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:27:50 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/5] mm/page_alloc: validate zonelist slots against
 concurrent rebuilds
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
 liam@infradead.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, 
 mgorman@techsingularity.net, jiang.liu@huawei.com, Bessel.Wang@huawei.com, 
 stable@vger.kernel.org
In-Reply-To: <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>
References: <20261019172346.3344005-1-gourry@gourry.net>
 <20261019172346.3344005-3-gourry@gourry.net>
 <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>
Date: Tue, 20 Oct 2026 16:27:47 -0400
Message-Id: <179252806771.851873.10455974025763071382.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-20 17:22 +0200, Vlastimil Babka (SUSE) wrote:
> On 10/19/26 19:23, Gregory Price (Meta) wrote:
> Furthermore, since we have the zonelist_update_seq anyway, wouldn't it be
> better to use it to avoid these kinds of races rather than the more tricky
> way of relying on what exact updates in what order can derail the allocator
> side and trying to protect against those specifically?
> 

Sorry also meant to note that from my reading, zonelist_update_seq
presently only gets checked on failure, but maybe we could re-use it on
success?  Let me see.

~Gregory

-- 
Gregory Price (Meta) <gourry@gourry.net>
