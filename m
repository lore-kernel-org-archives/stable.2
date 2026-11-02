Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627668;
	b=y2noghmK+e4XCJ+dLkWg98sbL/kZqbYy9W6OU4jP5FCHuXtKiqXdzisooNxH7VGjvNNY
	 Q6rujrAxmvFzCMRnDDw4WqZvJGmW4xcSjilUCejKW4gYyk5xZcGSxNWU7J4nSMKSESwPY
	 Nh5IcEM3hL8C4jQ73un660gTNvCNCJ71q3ITiASVJQVmuTHtyR2V0mhjIVYxsMz3YYIcR
	 +HaifBwrSBbqITvh7V9gx0jnrjuB16Fr9FhuPbcZqCGEhT1JJUHi0e6McZW/cRcHk6oyq
	 ULza2f/g5QhISxVysgTGW6NLBmotJfPDC+hIcYz9ovikpnhPMwhMAih26JtwU5NCLkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627668;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QS2A6RVporIMo1a+1YYRSQLz7OfV4Pf3A/A2Z7pJ3n8=;
	b=wZ8PaZJpI/9r0G9/KidCk17ZzeJ7Jf4iYp0ag40vWm2PNe+PQ6vFZPDP0uF4KGjiAfps
	 qS9F22vV2yFlfYeY/U/rFxt6XTCAhCk5EkdOe/xyNuzSuq2HYlzBsmU12RCscAMEvAvJa
	 QOZ7sRtMkH5JYogsesiPE/M3gw5nLps4EJMgzXzmrhk0OngSMVuOHruEfL89reniqYSKs
	 4ccyWC8j7K2eLnbYZOEjGxclWunnNXhlkAVdH0tIjvN+uHjdiGQ35riag5UXNMIyyoZnR
	 MRtxw1k4+UQIT5GFzpIbPrpoBY5BKDPAVWZjxCB+2BQlm+rgmeEVzQzW9/nyM9npVdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTmS8CX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E860A262A;
	Mon,  2 Nov 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTmS8CX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB511F00A1E;
	Mon,  2 Nov 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627667;
	bh=QS2A6RVporIMo1a+1YYRSQLz7OfV4Pf3A/A2Z7pJ3n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mTmS8CX3Yeh6gA5kL8Ne1AtPywEYlEVgndy2Aj3VtM91jOTJDC568QkcDwIzCmivD
	 2LYuSafTGVhqXilQrH7jf5VAnxujN5ZZVo6NNIgpP02KLyTJ1BIFfh3hX5l5pc003Z
	 IIc2dzGj6tqehwINNSUeFNimzIhdsQ00m1X3sZ7WyyaKB727AfH+ec317Abl4Fp+73
	 qZHTnZNDAQvrFl5cK/zB9+5/+a8voikVXiN2KwOAMdz+jFjlA7Q6g959u6nKrRhXBS
	 JKk0rfQP8Zm9eq4mqXmdfqzMs/IaAPM1ajPAgQO+GaqtAixFcfdFG5VImUJAY6SixU
	 iHUaYGM8DrZCw==
Message-ID: <e10d1eff-0b9d-4834-b1ed-77def7f716bf@kernel.org>
Date: Mon, 2 Nov 2026 14:54:20 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memory: mtk-smi: fail larb runtime resume until
 component bind
To: Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jian Hui Lee <jianhui.lee@canonical.com>,
 stable@vger.kernel.org, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/09/2026 21:24, Valentin Haudiquet wrote:
> 
> Publish the bind state with smp_store_release() and check it with
> smp_load_acquire() in mtk_smi_larb_resume(); that answers how the
> check synchronizes between CPUs.  Fail the resume with -EAGAIN: the
> larb stays RPM_SUSPENDED and retryable, the error is dropped by
> pm_runtime_get_suppliers() on the driver-core probe path, and the
> consumer's first runtime resume after the bind (at display enable,
> mtk_crtc_atomic_enable()) re-runs the callback, which configures the

Do not describe obvious patch contents. You wrote huge wall of text,
instead of keeping it concise and informative.


> larb ports then.  Failing rather than skipping keeps the larb
> suspended instead of marking it active with unconfigured MMU ports,
> which would only turn the crash into silent iommu faults.
> 
> A failed supplier resume does not break the consumer's probe.
> pm_runtime_get_suppliers() is void and drops the error, so a probe
> inside the window just proceeds.  The display components do not touch
> the larb in probe: mtk_disp_ovl_probe() and its siblings only call
> pm_runtime_enable(), and mdp3 only enables runtime PM for its
> DMA-capable components (mtk-mdp3-comp.c).  The first real runtime
> resume happens later, at display enable: mtk_crtc_atomic_enable()
> does pm_runtime_resume_and_get() and the device links resume the
> larb first.  By then the component master bind has completed, so the
> larb configures its ports and the resume succeeds.  There is no
> deadlock either: the bind only records the larb pointers, it does not
> resume the larb, so the window closes when the bind completes
> regardless of what consumers do.  -ENODEV is not an alternative;
> like -EPROBE_DEFER it is recorded in dev->power.runtime_error
> instead of being exempted.
> 
> The bind state is a separate flag rather than a NULL test on
> larb->mmu so that the publication explicitly covers both larb->mmu
> and larb->bank.  mtk_smi_larb_unbind() clears it again with
> WRITE_ONCE(), which is all the clear side needs since it publishes
> nothing, so an iommu removal or module unload can not leave a stale
> bound state pointing at the freed iommu data.  A resume in flight
> while the iommu goes away is a pre-existing teardown hazard (the
> data it reads belongs to the iommu device, whose removal breaks
> bound consumers anyway); clearing the flag makes every resume that
> starts after the clear fail safely instead.

All this looks LLM generated. Don't send LLM explanation to people. It's
only for you.

> 
> Tested on MT8183 (krane) with the full MTK stack built as modules:
> with this change applied the machine boots reliably, the iommu
> probes and binds all larbs, and the display stack comes up fully
> functional.
> 
> The Fixes: tag points at 4f0a1a1ae351, which moved the port
> configuration into the runtime resume.  The device links that open
> the race window are added on the mtk-iommu side, but the dereference
> guarded here is the one that commit introduced.


I do not see how is this relevant.

Best regards,
Krzysztof
