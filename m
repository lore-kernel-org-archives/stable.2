Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AE439351;
	Wed,  8 Jul 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536805; cv=none; b=tjDv+tLB99+3H4Rrx+BiUeDzaIluvqQoGP+9XgZDoUiE8MCASDzXCPNhzYgIvgy4cpTcDJd5Fcb90cyMFXuRLMqLYczsj5J6I25obna9ZLRMR18f5Mheq42HHGBfsAxw/ov/rPtsKIOQ7reuTd73AOhVNchPonr9+Ik5UoUeGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536805; c=relaxed/simple;
	bh=852vaumGujeXMBdyMYkpH+y6wYvFeDWg6dRIGPKPmGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG3uhTLR2n+8BKRqq+eyiD9iPm7+ZLJa/OuGBYSyS84pidxGXWjVtAmcmUTavX1hLd8QZpbboMydZLRqEN+FEEVxN4ogDDujOt1FaFaeHzCc6yLGzbtJomkcVVSXnB6zquLW1UT9qBrcf3wrMdj4KTxNEvv3ApEhUckqG3e5Ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z32NlhOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z32NlhOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4141F000E9;
	Wed,  8 Jul 2026 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536804;
	bh=J2f0Ew4VnwGv7uuzAnw1sPE6xUF9+xquBOKAYfUD5tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z32NlhOLrT5aCPv93AAtFzGkVadz/SEFmDI4iV8BqBQjy8effTW4de966W2kC4yzx
	 Uep+PheJKmzD/bul7pU8Vqt9veub1TD+js1gcMqJ+FF4IG1iHpy4F5WKInWn4qNEyr
	 Sa2Qwee0m/Ddc9qogC/QK9gsmPvuADiqQVB/HgG0DWYqgzM0pE21QvRJw1tYQWbg7E
	 9kFJx6JRkX7NVOERsvFpE/EESMRDlRIG+gxa5syrFgaE5YeZkIyBwzJCD4OOliRGuY
	 iKcA4hV/W6Ut9+med7H4wOzoZzV8a1Cke74dsS/H39kX36asUxmEkKFZR2A6sLhxKV
	 DySpJgJZH0n1g==
Date: Wed, 8 Jul 2026 11:53:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	slipher <slipher@protonmail.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: breakpoint: CFI breakpoints only on demand
Message-ID: <20260708185318.GA2718700@ax162>
References: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>

On Fri, Jul 03, 2026 at 02:25:27PM +0200, Linus Walleij wrote:
> This removes the stub hw_breakpoint_cfi_handler() from ARM, making
> it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
> CFI is actively used in the kernel.
> 
> When not instrumenting with CFI, or when a breakpoint is issued in
> userspace, we fall through to return 1 from hw_breakpoint_pending()
> "unhandled fault" so userspace can make use of this breakpoint.
> 
> Tested with LKDTM and this command line:
> echo CFI_FORWARD_PROTO > /sys/kernel/debug/provoke-crash/DIRECT
> still works as expected.
> 
> Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints")
> Reported-by: slipher <slipher@protonmail.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan
