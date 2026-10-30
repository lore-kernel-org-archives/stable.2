Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369975;
	b=A+6nUkyIlgolavO0sSwoDk8q8biNAB07+b0W4bNfa2QHl2MUM9UWl+pWsOhVQz5rueag
	 OuG8aGxzDDQIVoz9saPSZ36ZCAwZXsuXLBKB8KsQqxG04rZwkeCNjFMX/1vwmOZFW9s6O
	 3fGgTxKuYjXP5zMkw9JnD+nUDrZG033rDeVqE/nh/X+622jN8JPxUHOPalWSiZkfzxTns
	 YNQ8cMfVkfEccgDvug4rNLAVQyxZkngBfILLLegYCPBIbQ/VKFku95FXhMjgnqkPVALGl
	 Qy9lDaRrVBt6EMtpbNsPvjbLuwefDS2JJFjyCWTzOBimAgahKrbsMLBlRqg1APTflHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
	b=HXro9Lb5MbosqSe2G/tRfvXOVWamHcDfa9mPJ1tB7V5sXYLS+qnrp+8lncL4NmGTFtnr
	 4Lfq+XeYxomSzxQhTSLkDAICAF3iVM5wNjht2KVJM1SAHi+KhLoqXnikQzlIpGmO9mQc8
	 5gC1dAeusY+q7CofJA6yxJooA/iao+3w/zOJAMI+hMh1DaOnvZ/VR94dq1czpCIcxzdws
	 DpeRzjZGwYkELnFLA3G1FJWLglgTuIjZ0OS7QjYs9AezLd5VRn2LCooHV7Cfhm4YhAs+q
	 Sv3QoUsMiE+b1wQeJ4SiLU0UrRv1BfHPrnD2VDoefUwwiZ2mwmv7mCCzx3sv3o1FvBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Esi1kjmC;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016F606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4016F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Esi1kjmC
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1947498bso1978468eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793369974; x=1793974774; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
        b=Esi1kjmCu/mPRLNW6Cph+bFN0jarTDCCCrwoQ2TSZDwxIXb2wtL6LXW4OPt/ipy3t0
         /I2GAN+Bf3sPY0A2kspEkj/14Qc6h7BDjO4TvvKFPnXS80vbdfNlq0YcrffLZwXt3g8b
         toSERLnJ7zIqd9r8fNei1Jxy7U4LiXPRmfgqGFVd3C5wkH4Sugzvh4iPL+fS8qtcLsYl
         hIwWcdAvIXxVuSiQCNyvRGSseiNtUQNY1wQYB/vYC9cEEASCo5auPpCTsFsyrMVa8xlx
         R9YFYiIUne+OZP1PbyvBbJjt+sZhTT8L+9jwnBfTb01pm52RfnzoYV+vE4ZKepsLJ7ep
         Zszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369974; x=1793974774;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
        b=DNNiPUrpFTpT2Awu9itNtUr8Q/WNs5SEC81OVly3Zpli0Y0YkDPyH9McnE5Q5THEId
         HDsdF4zgJlmffTji26WjzB52OMFa6CeW4190L2Vxh6Z7eCDWiyiprfZfQZDnTr09lHxI
         vvy+TiUZ4ZPAV8TwnLVH34B3MVcPn421Q4ESpLiGNERfeCX73/umL29vw/Gr0AyqBjTk
         Q7xPP53lWdcMRtvCHHeonTScM8MDZ9pwUrT9q8ZMENOI+2hhY/3F6hW+d/UGilPK/C4X
         FGSw4RBStoPDg8unJUItElyEFeUuBaS529yvLkSq74llbsECB4bJptJhYLa6siLSKdhO
         wa4A==
X-Forwarded-Encrypted: i=1; AKwUvBwdkw2Zz6sHjJhjVsytp/LqtHg+WHVvICZ21q4ujQMkJX1dsn2rNcBTumNJtOVMIuZMdxZ1kRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ+UbO5tHienSb5CbggFDWVI6vA3+5nwlsY25I/Sr7NL1hwuq1
	u3z7aQPH0zA4YgrzdzCAezulyK7gkmF1qsX1flb/Qy/WQLInVQF27o49nhHQVQ==
X-Gm-Gg: AYBFou2p4Xn+0lK/jbTTmVwQ46StIV3hQuqHBiMpSYD/tSHD8PlOQDFXRmYMi/hBOv3
	f/0qzwhPeptRKU54IZ7jLt3xuTfu0AQBdZK9wV39vS38NaJXusEFQMTiPNhudSHMoIbuvvr75X5
	EnJAVO7lztavjftGio5x2zhE8R3PC+7nfeD/hAYUatOJpXQLDZPOvEBCPdO+KGKj1tVPTPbwUxX
	Tasdg2NQfmSt08l25KpxA7pcOiyH/JD2ZBS012+YGHum9w/zzTanSP50qPKHpZgQkJ/uztK+JSU
	Q77LPYVJmz+3/VSiPMQ/Lx1IXTrjF0yVTD/my70+VC2Ugzd39ZOgwVLfOGn1zS4CC37oCCTcTkY
	9czCCiq3oSqBv/hhrgy8dLNJ0vszX4BnJ3cpgLpdjDgPl2flc+bPr8CdeXkH6NlbI6j12dBTqh2
	wUsqmSChSh0s0LDN+QTWFD53uGHTETzm0Az4f/oQdA8Xb1T4bRNlMVMR5ZPkF9aCQHxYC/A647I
	MbGlDV5Vz61GFXjyN/LKhb9zLX8uzn0j0CX6r34GsjY+k/Ys1GsPJPOoHWLX6yIlQ/7zIyn20bG
	JJj7K17LWn6mTKhnVzxNNiH6Fdc=
X-Received: by 2002:a05:7301:2511:b0:36a:1872:4b35 with SMTP id 5a478bee46e88-36a42203e6fmr3338125eec.2.1793369974284;
        Fri, 30 Oct 2026 07:19:34 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm10406146eec.1.2026.10.30.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:19:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU
In-Reply-To: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
Date: Fri, 30 Oct 2026 19:32:20 +0530
Message-ID: <5wyjwakz.ritesh.list@gmail.com>
References: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list


Hi Narayana,

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode
> handlers") moved the TCE hcalls from real mode to preemptible virtual
> mode.
>
> The stt->iommu_tables list is RCU managed. Entries are added with
> list_add_rcu(), removed with list_del_rcu(), and released after an RCU
> grace period with call_rcu().
>
> However, kvmppc_h_put_tce(), kvmppc_h_put_tce_indirect(), and
> kvmppc_h_stuff_tce() traverse iommu_tables using
> list_for_each_entry_lockless() without an RCU read-side critical
> section.
>
> A concurrent IOMMU table detach can therefore remove an entry while a
> TCE hcall is traversing or using it, without the traversal preventing
> the entry from being reclaimed.
>
> Use list_for_each_entry_rcu() under rcu_read_lock() for these walks so
> that an entry removed concurrently is not reclaimed until the reader
> has completed.
>
> Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode handlers")

I am not sure if this is the right fix. On doing git blame, I see the
following patch introduced this:

121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO") - Alexey Kardashevskiy


> Cc: stable@vger.kernel.org
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)


Sashiko pointed out few more bugs around this path:

Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
- [High] kvm: ppc: UAF of spapr_tce_table due to missing rcu_read_lock()
- [High] kvmppc_clear_tce: pinned memory leak on partial IOMMU map failure

So, even though these looks to be pre-existing bugs - do you think we
can address them in a single patch series itself? This will reduce your
testing/validation as well?
Also since we are anyway fixing RCU specific bugs in patch-1, so I think
we can also fix rcu handling for stt as well?

Do you mind working on v2 and addressing Sashiko review comments please?

-ritesh


