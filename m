Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063603F412C;
	Tue, 28 Jul 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232204; cv=none; b=W6op5DAcu0S+FsPjs+N9YX6GAwb971Q7SZ1DDzmhX1u+SEug0sg9WqnEWuK2xe7WIEG/G/n6dbDeOLioWDOQAOCQ9jK06wjR4IDFJc2h+IPDvoJ6UngRcBd5Wj6MbCccl3F9MEBFEACFg7xr0BjOMr/Dr+Wjkxj6ga3N+joTxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232204; c=relaxed/simple;
	bh=Fic8x1uknx06j7H/4MA2ytYdgihlpXmIwtwCzIbhMSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBOpZ2vcovh6ERutqLU5pRaMQMxOVz9SGAqpYE3GPWfG32iE/zlNqTXZWhYe5ZgvGt+cJ1X67KOSmHpYg3FkYIej8DfsOgTu5MkyTxmHVopEJZ2Mie5IBhfu5IEUkxUAYJ17f2H4ii8q9hntl8nIVk+/oucvXJe38A1bx53ggck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCVb6vZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCVb6vZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E62C1F000E9;
	Tue, 28 Jul 2026 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785232202;
	bh=oLWjXuqnJhPZUydlgvzC/ZmJPhlhWN5Zieclb+yQNMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCVb6vZy4wNmvPHoV/sE6e6bePoiGSeNP0MDACp6Zl/nTxbBH4vxscKSgF7qzpjbd
	 oCOKjdiYYizSwRviiNOAQ9V40f1oEyQdfq6K8ewIb8KWjX3lH5obnWL4p6wyXd1c9u
	 Vi4TnKCBiUzIdFSGQk8Gao2PsRB2XEGuTCquYjH8AvfRjqFHGynBhN9RkHd0jpV1pt
	 H0aJu5vP9qwaFCTigalaYYFQiXc+SHygpnq90Rly7ZPOR8M2PM0WCqVm6aP++r1oo+
	 Ou7AUAOEkEVQkXKUrv7HA2ciun3rJ/4d8I4bUAAS1IR6KNHO+/1a/JFGpYkqJxBodM
	 UCIIrrnDr1GMg==
Date: Tue, 28 Jul 2026 10:49:58 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>, Oza Pawandeep <quic_poza@quicinc.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv: acpi: Handle LPI architectural context loss flags
Message-ID: <20260728-wolverine-of-classic-penetration-2f6cc4@sudeepholla>
References: <20260728-riscv-acpi-lpi-timer-v1-1-c722bce01e48@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-riscv-acpi-lpi-timer-v1-1-c722bce01e48@linux.spacemit.com>

On Tue, Jul 28, 2026 at 05:36:12PM +0800, Peixin Xie wrote:
> Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> broadcast timer") replaced the generic nonzero check for LPI
> architectural context loss flags with arch_get_idle_state_flags().
> RISC-V does not implement the helper, so it falls back to the stub
> that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> an LPI state loses the hart timer context, preventing cpuidle from
> using a broadcast timer for that state.
> 
> Implement the RISC-V helper and map the hart timer context loss flag
> to CPUIDLE_FLAG_TIMER_STOP.
> 

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
