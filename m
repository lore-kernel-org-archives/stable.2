Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6083A14;
	Sat,  1 Aug 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785588409; cv=none; b=NHw6IHfdJ/w8Q7NtIj99RRR9oYodAe9uND8mRcn31yEgeItH8wAUouYqQWzGV+dvo/Ajxp8SrsDRc2f8F3YhZQOPpCPLWbgwtr0y3x5eA/F2X1WvQHRce5KMukfC24uqTCpZ9/41goSHTUJ3JZ90bEjpjFRgVmSwOk3ZTQWVkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785588409; c=relaxed/simple;
	bh=JeqH21s6X1zGKWcl3GdyOsl+IFRIXtUcitYIILte0iM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LEO7yhs5yCF3nqUbOb0TJ5ZKZ/YVuJT9a3kVJ2at8nfth5yMrNpkQ0nhr4UwEbChcULQ/ybcX6UZEFwryr14HncPWi3Y0FgPn08ieRp87gbI0CDD8Q8fTPUX9k9RvBTQsvGkjHLOSsIs9vbxBcYl+ReyAHlOEnnhnk+cVG+P0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Jw3R2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Jw3R2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339FA1F00AC4;
	Sat,  1 Aug 2026 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785588407;
	bh=tf5IyffjllS+708odQigshftMMlYY8RnVsHPMtEIX2U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=e2Jw3R2WANz9QjEbAH4ycqZxQxqFOAuMaBJlLUYWtjOf5BlAjRMvv/XDLsZHp2w7E
	 EMpENVh+AWfCDSalkNTNjuLOAOZkJpzeAFbo4WouEhWCTdQse5QShSdrbHOgzelaCc
	 Q6SDdr4VUCwPNlB3TMphDZmGKVDowBGQNCeEK2Pn2O6Ehep3qq7XptTqib46otluua
	 Lq/WCbFQlwVIVw6RUJVOaTOa6rcMfA+gQlXae4XF+Lpa+Bb5QN+/mVeZ1nWQ+Ab/XM
	 FLHnoCeUDHgs19JalLXs9VrTE91eP9V1KkpCtm4jMMvieI3/2dPE89LceJ38SVrwqN
	 RuVmg2WoVnVJQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25ADDF40076;
	Sat,  1 Aug 2026 08:46:46 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Sat, 01 Aug 2026 08:46:46 -0400
X-ME-Sender: <xms:tuptajN77YWcQ1dxjvoS3jCgZ1LhypwCLgqmgwcIGGaLEUYKoJbCGw>
    <xme:tuptaowaYAtunAeejFyeRzx2yqIqQ5bIf_qJjHiWWNZUtxwDSzVnU91IyGwqPDxEQ
    9BYrG5Ac9XKVMoow7NHvwOB5dYqxES44qag1U-jJ533FhQaWtQWJugP>
X-ME-Proxy-Cause: dmFkZTGa6PLZcs1LpqN4L73CsbcZGDLLhKz/BVsXFGl9g6gfOidm/t37MBGvliBaIf5YQD
    UIRQh3AzdMy/0nj+IGAK8MZE2WO0R5tcQFg3zaTiJI1dlFkXWfUHAXzmQKe/7MllXKOgQV
    w/iie8PhImQcaMFd8v5Ogn9MZV3vgF1O0NoTHI+/hCP9/wahJFHyvvogqeJJ87RE/ASdyi
    nRyt78ZSwJqyoHCanLbq7Fzm2UmMydi1+Z0W1DyHPE0fUa9ibbI+nrdlWU1voRLDb8nlKx
    LEjDyrxBS1FQyu3L7b4gI6moaCnK2RSzC8YBxbMqGdLWOIrfftFwJTJ8gr00s0jzslLvQD
    7LaQVGYT9X+3Jp+dlzCZ2E9zcuDscOhPpB9lW77H6I0EbV/rMunu1tKTOa35db3nX8jwHT
    87bGGLzfzajXtd/qi6VSt5YGckbRP9BJCZpH5BJPjUA/gTu4ZVUoEPr4tvSR7ovS6iZ2ul
    4DIJdqa7rGUnIJ1ld/0ziKxzNGrkN+1/Z/TMnM9vzmvhzagnLFteg98Lf7N7esknqCTSaB
    /nFbS5f5FZArIJlKgnj25RNzO8Z8eo52+heqWD9xp94t93SF21WYC3+j8TRf9jWP8yY0Yg
    /12hawWiRdQr1jppjKmhIjHGmy/b8LjZ+GBbjGeRh/qpIbV2D+cChFwSGImA
X-ME-Proxy: <xmx:tuptas74HbYmwrivJpbEZ3_0Lg90FEoxfQxDOvnTAm2S8j2Io3prWw>
    <xmx:tuptanNzIV71YaVLodrKHiafPehIuTW325jKDTFDiAJa5fIJKo34Vw>
    <xmx:tuptaitJcbBSSH11iwXDgzqsALq4ABAkU7i8ORrmP27OwrQPasNd0A>
    <xmx:tuptaibozDTa_SzfgIOqMvL4twatGW9F_cJM84CA3RhLZlGTANysfw>
    <xmx:tuptasxy4ZgSC-V9f6SCyb-EQTYL_e4zXS93x471gUXbMDwA_VSsb6r3>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D13A182007E; Sat,  1 Aug 2026 08:46:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Aug 2026 14:46:25 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <21e446ee-4082-4a0f-8e73-694e3a569c43@app.fastmail.com>
In-Reply-To: <20260718091600.92021-1-kmehltretter@gmail.com>
References: <20260718091600.92021-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] ARM: smp: set current pointer in assembly before jumping into C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Karl,

On Sat, 18 Jul 2026, at 11:16, Karl Mehltretter wrote:
> With CONFIG_KCOV_INSTRUMENT_ALL=y, secondary CPUs fail to come online
> on ARMv6K/ARMv7 SMP:
>
>   CPU1: failed to boot: -38
>
> The compiler inserts a call to __sanitizer_cov_trace_pc() at the entry
> of secondary_start_kernel(), before set_current(task). The KCOV hook
> dereferences current while TPIDRURO is still uninitialized, causing a
> data abort before cpu_init() has installed the exception stacks. The
> secondary CPU consequently never completes startup.
>
> Initialize current in the secondary assembly handoff, as
> __mmap_switched already does for the boot CPU.
>
> Fixes: 50596b7559bf ("ARM: smp: Store current pointer in TPIDRURO 
> register if available")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested on QEMU vexpress-a15 (mainline and v6.12) and
> realview-eb-mpcore with and without CONFIG_KCOV_INSTRUMENT_ALL.
>
> The head-nommu.S change is untested because no currently reachable
> Kconfig combination enables non-MMU SMP.
>
> The redundant set_current(task) is retained to keep the fix minimal.
>

Please drop the call and the entire function: no need to keep around
redundant code.


>  arch/arm/kernel/head-nommu.S | 1 +
>  arch/arm/kernel/head.S       | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index b9d6818f1ee1..f80bbfbd3a6f 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -116,6 +116,7 @@ ENTRY(secondary_startup)
>  	ldr	r7, __secondary_data		@ reload r7
>  	ldr	sp, [r7, #12]			@ set up the stack pointer
>  	ldr	r0, [r7, #16]			@ set up task pointer
> +	set_current r0, r1
>  	mov	fp, #0
>  	b	secondary_start_kernel
>  ENDPROC(secondary_startup)
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index f22c50d4bd41..a22403a629ef 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -442,6 +442,7 @@ ENTRY(__secondary_switched)
>  	adr_l	r7, secondary_data + 12		@ get secondary_data.stack
>  	ldr	sp, [r7]
>  	ldr	r0, [r7, #4]			@ get secondary_data.task
> +	set_current r0, r1
>  	mov	fp, #0
>  	b	secondary_start_kernel
>  ENDPROC(__secondary_switched)
> --
> 2.43.0
