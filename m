Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B826ED37
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663287; cv=none; b=m6Y0IUz+2BX9H7AaQHRXmBn1JVsGuzbVXAJcUZ3hTPqiV8zJDBROn/kDgKhoqWuFPL6if85A9aDhxg7DJ5QRuZOwiJY1uvAgnOcqNmoh9AgE7p0aabBQt4S9/kiqg0DOrZ4J56kmC/i9zaKAhBmSL7r3pESXXUDrTXHRZEq+Sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663287; c=relaxed/simple;
	bh=/2MfOdg8MUiGmtobUHmlnGMUiWJBsuElE69Hctdfu/g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h22AGhn3Zl6R7l0hxwdTa7mMt6jeBF0RThZf72LdEwImHrWxUIyonKmIjASak/d+PE5IWz6Yq1jbH0C+gggfTHekmqObyvL7XlKD/DhbpGItS6jam7mxCn330La827d+CV/kItjSpJlus3BWb7osceYFpDelUyPLAu2l6UnId9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md9Xo8pZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md9Xo8pZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06A01F000E9;
	Sun,  2 Aug 2026 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785663286;
	bh=fnEoT67RUxb47jnstOPEwgw5zUykBPwRd5QDKsPq52Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=md9Xo8pZYhYycX+Cp91uNSzNGl4073oePacXOvWWCjnaTu8ZpNu7db9nO2rMRPkCM
	 QuvUfsbLIj6ol1jsMv67ocScT2N/jI7/bXzZ+T/IZy3NSuhO5TPlKBKfwZE0zsk322
	 fTvNvJ0XPRtZHXTh1bdC+j4ImARwjYwpwAw7FCxQuKwHpUhO6S1AM9fIQfwz8pzHxJ
	 Uz/So2SbCNg7YJfkosY1mRmOMjAejm15LmULb1QLfQFf2m5gb6TO+P89ME8lf/RrYv
	 3C+HdQ0xouKGzj0bzK5jGeLq8IU+NFPkOkPURGQI0FFtZR6AMSPbYTPk5D6btQvnxi
	 BHLWFgPPSVe5g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id EA803F40089;
	Sun,  2 Aug 2026 05:34:44 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Sun, 02 Aug 2026 05:34:44 -0400
X-ME-Sender: <xms:NA9vakiB-orzPGvVcY1LIV5-9s8WwjlMkpWoFBIZYIUz-abzWLi-aw>
    <xme:NA9van2Pvrb11eemBJhWV-KZLzHkGWEXbvqfgUDHRL45sAj1VwUE8wv-OfW-K-yWV
    P_96hHIbpOLdRBzQlhNk4j8vfgca4xgi-YPAPXyiA1LItb9bvKyX7k>
X-ME-Proxy-Cause: dmFkZTEmFJYMTQb2t66UfpflVE3iVIqgATyCpkJzcRNlXvdnxFbBpWQT3WHLkGEMEC/oz5
    7Ps9UCDzDI6IXFV+FLuZVRV9DRuajPoDErmkvgi29L1IV5IjeaJ2SRtOIKN+olWM57R+BW
    oqaYB72qqEdmNKjkZFevSjkXR+vwrRQBizRGs8Rm0mcYRit9tFvOB2UJrfXyviRMbwR4eX
    cUHS0ZQLQbqncxzWHOLc1hCQab9EZAxSEAJJKkTjoZ+mWV7ZktmBWOYREPsrd40/M5/wHC
    beKcGgGjvqBC/U6WObF3m67NEL7+eqciSm04xU+7J+HddgAY2NXyZ0o4YeI5u0Sv53YhfU
    UZtpaZ5zBW6ZX3yATkuvTBXoqy15u7xDcn1wBDd3o0QlWlTiZiQIthF94U0Fpm3OaQJ6aI
    Nx3dNxV3M4jkg5QYiVpFVi4XCITcp4YGviohJBVJjIR0/0gQTgrFOB4FS9YFpKp+MfRNfq
    Lqm9+3KjQ8Y6BxAEZTdxMnM9qkA+hhJacrFIajcb64Ar0svbX3Bq/DbBdhLQ/yUK8UaNTE
    bNBOSirNPSWm8TCMtAxrTlFtfhr1GMaV7AxbIx0jOpEFk1IJ2cj0C3SB9iMrXiz8miaoL0
    ALXyBVJzAfIWs42QC9C0MKyWmMiQl6ag+cI86AY6mj1TW/zIWXdQJTDcEcVQ
X-ME-Proxy: <xmx:NA9vagPLoMNs0oEsd3JvlTXK2QbjVKejvBO45EanfVKWjYNxeQK50Q>
    <xmx:NA9vagSSjGbKzPQSQxPSSDv3aXKLRi15dG-SbySm0FfU4Ec3zap8Fw>
    <xmx:NA9vauiSL28ZBFRj1ZtHxPxqXbUstqngTUK_IHxa24Ytt_PZfxAHqg>
    <xmx:NA9vap8bTkK7l9ZlfF4y6TZWh022-1E5iA7nuAfeT7Zx75cw4EqXhA>
    <xmx:NA9valETr84WanEpcYqliemhjiQhDF6tc0DRsewdZKIQ9LZi8a4e6P1Q>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE986182007E; Sun,  2 Aug 2026 05:34:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 02 Aug 2026 11:34:22 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <516872af-e52b-489a-9dcf-d36a70d50c76@app.fastmail.com>
In-Reply-To: <20260801163520.74751-1-kmehltretter@gmail.com>
References: <20260801163520.74751-1-kmehltretter@gmail.com>
Subject: Re: [PATCH v2] ARM: smp: set current pointer in assembly before jumping into C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, 1 Aug 2026, at 18:35, Karl Mehltretter wrote:
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
> With current set in assembly, the set_current() call in
> secondary_start_kernel() is redundant. Drop it together with the
> function and the task argument. The hotplug resuscitate path in
> arch_cpu_idle_dead() needs no hand-off either, as smp_ops.cpu_die()
> can only return if the CPU kept its register state, TPIDRURO included.
>
> Fixes: 50596b7559bf ("ARM: smp: Store current pointer in TPIDRURO 
> register if available")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
