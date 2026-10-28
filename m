Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205833;
	b=OZVhFVHtaCTV1EYmRH23y20C8K+LayWERcdkSI3QQZwYH+hbIGIQFYp7kICVL+IPPdro
	 IaqLUo946Ze7nHPQx+oE3XBLKsVUNUau0HJ+go/YcpCuuOPBtv00XZWLxmry7UM1Abc9d
	 /8ON+fCyNh24fEGimDQ/dFUOrLfRoB8NwIThVQQudoWaafexZn0BVSiaUXjR2kunIEOol
	 yoZZFWP+T2pttHqCLpNtO14P2uVHAaO3XC320LYhxFN6WkbpsutvBDSrEZXHYkSaDJVnx
	 3vfJbYUzqcnCooofo7XBDRfroQlRzRQkMl9pVjTFNaiZcK0iz0TYqEk6w3whItsfAlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=H4FXbOMrQwHPjSXYjhPmjTipUGSadJjyvVYbeZGAZ4E=;
	b=IK35BOWmpUH9kyMCrQYbTBzS2DPe4/9jVXgRqSgM89OKhg+AcgwpmV3W2+ClKVUv0ulp
	 oyJpODwdA8szUmVckYXhz0tVl9VyMDolsr86sY7z2fMwKu6fyrPYv9WboEr0waKM8/4/5
	 qiBulnkQVEF0jOY43E8PskHReqtEoKpOJhzU9Tcq8n17bFq5s2ku4VXb8dhyC9Ch0WiFH
	 UHal98mvkGj/u8GsN0aRjiendOnBndoqK60Fs0zQrKZHzEzRhX5sf6g9GX0e8hUqwttf2
	 dR30Qg3wBM+36XQIjy/64ja5pMipumQ25QUhvdNmn0G4uR8UEwSMkAwGv3USJIKqk8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DV4VmOtp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F3606A31A;
	Wed, 28 Oct 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DV4VmOtp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF391F01825;
	Wed, 28 Oct 2026 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205833;
	bh=H4FXbOMrQwHPjSXYjhPmjTipUGSadJjyvVYbeZGAZ4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DV4VmOtp2WEjv8Z56nlf0ndwa1HDvr7MZUAdl25hNyGS5VLcbQWV++OyI/rKBbEeU
	 4nqBo7fbZSoeiA4Vq1/efQN/Sy7WzO7za4+iysDk/I3635Z8ZaN0h6zWo6L5O9KmJB
	 n20/MlfJ5O0jN5CyFk2PRzLQhX+PZNjDRJ2t1JSQz8pSLirtgAeRlg/yJcnR0TqvUG
	 6ojgVs+G7cwGih5wTjDjZH7Gd1vUk4ztEPgAj68nMYH9TOuD64gR/dPPNlxO/+eEw7
	 zYbE51rUJz5PSNiz7VZOFCLRZgE89Qr2AySk0CV0jikT2/9+i9/tpCHdsYD95UlKKI
	 j8r5usN0Ud6lQ==
Date: Wed, 28 Oct 2026 16:43:49 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: shubham@octane.security, netdev@vger.kernel.org, david@ixit.cz,
	oe-linux-nfc@lists.linux.dev, gio@octane.security,
	stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net v6 3/6] nfc: nci: uart: quiesce callbacks during
 teardown
Message-ID: <20261028164349.GA257209@horms.kernel.org>
References: <20261021032443.44412-4-shubham@octane.security>
 <179290103732.3134.18298634182061634234@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179290103732.3134.18298634182061634234@kernel.org>

On Sun, Oct 25, 2026 at 04:03:57AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (3) · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

Hi Shubham,

The text above requests a response to this email, and similar ones sent
for other patches of this patch-set. And I would appreciate it if you could
provide such responses.

FWIIW, the Medium issue immediately below is of most concern to me.

> 
> - [Medium] When nci_uart_tty_close() tears down an NCI UART whose NCI
>   device is up, the NFC controller (NFCC) is left running in whatever RF…
> - [Medium] Baseline decision: fixed later in the series.
> - [Low] Baseline decision: not a bug in practice.
> 
> Pre-existing issues:
> - [High] Pre-existing problem, not introduced by this patch: during a
>   Marvell firmware download, the UART peer (NFCC) controls a 16-bit…
> - [High] Pre-existing problem, not introduced by this patch: the Marvell
>   firmware download copies from the firmware image at a peer-advanced…
> - [High] Baseline decision: pre-existing and fixed later in the series.
> 
> --

...
