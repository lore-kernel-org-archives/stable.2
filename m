Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793378151;
	b=pZ+c0S5Pyhc2IpGGMt62fPM8UEB1d+FY9gjA0r0Fj8QV0vzyePLaT7Z2gWLp5s2M0NNb
	 //yCHd1BHEDcL1Tz8Vhcpy8W9FxAYJnChulJp+y4O3/uUFOnIeOP+ragHPcAB8aHyxTh7
	 vEtNXi/fvu4O0Ycdq6ny+Anms292yUx17cpgzMymSL0WXbyteGSiy9ahpN1+7Ntu0dmK1
	 9ckd6i/CARN3362B9WT8YM7Y/trihMSdaoGvCO55HLoWb7yWv3k+YVoGGQF/ms0OzJS2F
	 8Ut25Qj9l6U6lkE0/x1x8Mo2HMv7JafCfSgqCR0n18tFNvo8U8SqhtwPS8cnVYdF0Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BMm2o25mhTZ/C2HIIR1IZKofC9feViQ2U4GTb8F8Udo=;
	b=k6Z9YxTnPbHPPshAIvTSfHPrFRjPkN0eG4XgDP73X0LjRHJoRGHaLFPcfqQD20o3O3A6
	 e34itPrU5I7mq0VKpEkC/UYle0z3b7QMaH+C2FqQuv0UYQCOFiVksjQiM9mev5CZDBrjF
	 qVHV4TKQwBBWD3qolj564Ha8EQ53krHogDpp9OnxSo5wupA5ffHSQvWDK02E4WchLV7qj
	 eh2de6mGPrDed0RfrjYrbk4P1SdYyC2PSmAW28rWzw9awNd40cTO5GKoQThny7jkzPQkX
	 igeDLiT3dNg7f4qOv/XRNzti+wx6wkWBc4dXFcRabC6HKdvpG7BfR91slPaWC7OyB1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSb0SO8d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E7606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSb0SO8d
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ec3561ad43so567013e0c.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793378149; cv=none;
        d=google.com; s=arc-20260327;
        b=G10/A6LnlxlVlE5ap6gBVyWctH1KkYvDaeyfe+8gqtGsm1ZY3g1xTmqx/Iylb48nj9
         2hpxa0BxwPfX4J/7DTIdAlPncppaya9U7lz/qINzm0KInzitCdcTRXmTDecmVCok3GpQ
         8VPZ3efEzf//8/W61oERRQW7JHUu31FOoocpNMHiDG0zcBxhPCO4s3vjcGuK+Q1Jj9HD
         pRsJKyrygEP3e8TDX2Bg8TTKsZzMa/fQZCjSZTTmNK16hVGLp9ZUmPyLHZs2IqpWqKqv
         NZLJQdnBM2oj3bWSX2OpjC/66GqXl598yGgCI8q0FTOJZjsiUJGJVoNNA79No9vh4uNw
         iVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BMm2o25mhTZ/C2HIIR1IZKofC9feViQ2U4GTb8F8Udo=;
        fh=POzenvpv2W/lTGIuRHOAxOly5LhPTzU1hpTYgaL1S2k=;
        b=YCwbCShO/IHHtKZzdn4lj77EHtlPVLoJ3Ff5IbxFiQ19kOtt/0gNaN3XEN1cNh8Dqz
         ZRryUnk09nFEQBjtJirDKklSzPbH4SVx1d3rGpXn9NCztAgnWy3XRekdh4e2+p+78TI7
         H4vnjBrtv+h2OYCMNoaP6Ob7L5D0oAn+Vvh1FAxCM+PfnD7samKwb9N4oTmWgqf8WAT5
         E+60pcdqRRQAPVh29Zv7+BlRD6jrYG3nO5Cf3MD1aAb0gvYovYwXqsee9TRd5nYxdw4U
         LLuk44jFiH4vgf74u8kr9e5TWzsp/ySzb2+1Ab6h61H78250hdYKvykJvwcdRaUWfuzk
         OH5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378149; x=1793982949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMm2o25mhTZ/C2HIIR1IZKofC9feViQ2U4GTb8F8Udo=;
        b=FSb0SO8dEzCjBzxj7XFmH/MJsHgEJiwSmwxWPyGw885/RWyW7qIx+3sO8H0mMTs3TL
         ietozhtYd/jmOxRok9faH7M/85JDhno+5t64t4hTHRQjs7+VK7hIJeNy1IIBpZoQ+Zl4
         X747RH8dvqIGlEM5E+h8kuwNapJnRPdE+UTh9zJ0C99drP+nxy6g4PCWZ4cSuMneLnPW
         e0WnuN6JMdjBpOCrSao+8e9g2FfZvwu7wnm8yV9TB5sZDQ9rRBcYvhZVB6n2uXqlSoYy
         J48Mci865JW2w+IFFOjhXVW4hpLirTiX4InI1rBIWwXCnA0Mj629v5nw6T1e+HlmLYET
         SdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378149; x=1793982949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMm2o25mhTZ/C2HIIR1IZKofC9feViQ2U4GTb8F8Udo=;
        b=LdPhE+rbZiMC8ArSRgbIJtnmTRAtg7GtmOvw2fwfUo5mqo814D52zj5QzVESNMtDvB
         2WMANr/RbrGbDIuPTgeNWrZJw83iU/QNfRHpqSMuWLyz3cYX5EEGxS4FKsMk7NmUlAhG
         fkezQzIohtn22wfb/yLQXVvoty1eyI7dJ6ddvFW1LLXjj+YvF6BG9xBp4y1040reCUa4
         TNGgjT7ajV7J6oV929QN+zPVm0ZAAx+vrYmfxumuRVD/0553/Ge32rVZjHKZ9vs+cfXN
         V6nODpo6YGGSoffoB0WTd6aPTQnRV4vhp81cTID73vW8c6EJzgRejfiAsxr8LZPIM926
         Hl/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxArkXUmBD31kB+16xhdB03oDtsTp++BuLdIU8+YCIIxmeaJMGUxbz3FQyOmaKXeXW55KyXV2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVHLiylGiBuLBnC+uwU0a7lvZbgEFL+eVfi0afc/CpUQjMgrTg
	/JRZfd87gGeE8NhkihgLmQV425mWwR5nW6OvzTnTJEz07n+Kax1k7GzLokoFzPoABl257F1f0eZ
	CQ8Kfwva09DpzI7TvSBLK7TeSBvAGPv0=
X-Gm-Gg: AYBFou20SNkvA204EsSfAquKicVheDu10CIbHEcKX0tk1nnYmrDbUxDrpAkN91lcrPB
	sIWdRiVYPbuxGd5MMVQcZVHXtKLAd1H5PqzDsMq/NJENidheKpUxT5Tr2imGPeZL25b0k7zEjIR
	Bg8bl1V3nomm6BktYBolRpX05zzpoAug8qX4NMWoMQHspoPDW5i+hN7ksQCI57xHlvsDo6RNOyE
	mtfGsM/bevxiZUCq12QoaFCWOY79rLrXHCckPwtQ4YIk4u8ABa92YwnToV7wOlXDOvef/pjjS7v
	Zb8oVxBX6HumczCxBJJnJ3X3HmhPFrszp6UkIkLP4NVqfLfp5ZHdXOefm9K88eS16AzqQAn4lV5
	MsuQV3Q/meJTWGsG25B9dp68IQR/P/swmI5LZyTRi/TJwF+QdhiHWQAcPWPPnI6uqYYeIN/LEBn
	Ej6yeBidql
X-Received: by 2002:a05:6122:1822:b0:5ea:9843:fc3e with SMTP id
 71dfb90a1353d-5ec68978ff7mr1643923e0c.19.1793378149125; Fri, 30 Oct 2026
 09:35:49 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030161234.1505367-1-gourry@gourry.net>
In-Reply-To: <20261030161234.1505367-1-gourry@gourry.net>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 30 Oct 2026 12:35:38 -0400
X-Gm-Features: AclHuK9W6RlBHbspzEKRUiw6R1UQQGsojPWuAYuMETiBtEJzcKWSFyDZ9UWEpL0
Message-ID: <CAN+CAwN+OPMPpVdBA+XtQvFpDy+EOY2TAiusxMjYR+r0F+MPhw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mempolicy: recompute automatic interleave weights
 on memory hotplug
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, harry@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 12:12=E2=80=AFPM Gregory Price (Meta) <gourry@gourr=
y.net> wrote:
>
> In auto mode, weighted interleave derives each node's weight from its
> bandwidth, reduced over the nodes in N_MEMORY. HMAT and CXL report a
> node's bandwidth once, when the node first gains memory, and nothing
> else on the hotplug path recomputes the weights.
>
> This can result in a major skew in distribution and overload tiers
> with more data than their respective bandwidth can support, resulting
> in a performance regression.
>
> With HMAT bandwidths of 100G for nodes 0-3, and 50G and 25G for kmem
> nodes 4 and 5, weighted_interleave/nodeN reads:
>
>   event             node 0-3   node 4   node 5
>   node 4 online         7         3        -
>   node 4 removed        7         -        -
>   node 5 online         7         -        1
>   node 4 back           7         1        1
>   Expected:             6         3        1
>
> Toggling auto off and on generates the correct result, but we should
> detect this and fix it during hotplug. Recompute the weights from the
> recorded bandwidth whenever a node gains/loses its first/last memory.
>
> The notifier cannot fail the hotplug, which has already happened, so
> warn once if the new weights cannot be allocated. The next recompute
> starts from the full bandwidth table and corrects them.
>
> mempolicy_set_node_perf() now only records the bandwidth and calls the
> same helper, so the bandwidth is kept even if allocating the new weights
> fails. wi_state_lock is dropped between the two steps, which should be
> safe because racing writer simply causes it to run with newer state.
>
> Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Hello Gregory,

I think you may have dropped my review tag from the previous
version!!! I believe the only thing that changes is the warn, so
please feel free to add:
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
