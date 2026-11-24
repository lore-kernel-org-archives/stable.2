Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512658;
	b=jDBY4aHwOoNbAQ47hM9GrARoIQYfL548hBv67HLF8LLfh+Bi/jnbk0SHS60yygT/XCPv
	 g0FASwRynngt5CzpIYnTN72r6U31lQ5TB9EdPv6xRfLYsnCbjY4NYVcttcZluEQWsQ9b3
	 lfV/+yo6E1iUpxrtEF1jrTRtJGTVv9MvIkQFTHCjZYUUJ4VLdIYXqaAOEQ4xPQscqYaCi
	 hxMAn7CBnKWlZLlf3SC0Vm/3EImakDmv/wNPqCb6hjXT09kY6xylV0O6G1opnxL700XjD
	 elVzNUU/GvvQgRlOba4MvPfW41iwgskIPb+G9teIXmNPPk8hMc6YgoucgcLG7kfx70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512658;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iTs39YH9PNBDOek8s4iU8xJg1bbhYqQXgN9zsraxmvU=;
	b=QdDL2E85bhf92gAVgFLaEdSPmHGt7OH4xqrlWaMP8m5t1Kh4MZ1FGwi/X5tejCwJE4J3
	 pFA7L5TkVLkBT8F1FuVOQqzOBv+I4N+aI3mhb8Eqxe2aguVXcbYgVGeFQGArDleSbdtyj
	 P8S77Gvd3V5wAYLhd2pxfIEhtlijwC2uPsiWX8URxZ5zIuVMgYV820Ln5GNAgpPX0Qe9+
	 /4Jdmj7bnyzHl4p8OvM3oWBif6GAzq42PLfpf8Hj8eYkzr3ftDrN2TrCF7sft3GjnSA7Y
	 n9K3LkCsI1ri6pG3rzQPyGliAWNjpVkmqHmaqa7mTn34ZNNH8PaZO2G0CX0WcfskRnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEb3Gwg9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47E606A683;
	Tue, 24 Nov 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEb3Gwg9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A681F000EE;
	Tue, 24 Nov 2026 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512657;
	bh=iTs39YH9PNBDOek8s4iU8xJg1bbhYqQXgN9zsraxmvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GEb3Gwg9BrZ4w+QwD0bE3ju0zj1SdBOjSWHzH00TeY96P/UTlgxhYi49KGBMJ5+3Q
	 5lfsAe1Apw8bmbY2kvHp2A57LscdTZfVPwhb7DkF6Gul/uzAOes9wRaYQbcoLYE8pR
	 USDctOrnn2/W+qYLp3Xwld1YgC23Kf4PjahbIrGJwPbkcwORNBrn4fQoEbZv8Ul6uC
	 dapVMYBd9LMUWwBcioVuODv7vHq/MKBFJ9wqMNwiR7gnD9+tEBPfTjSJBXAVb0jhZ4
	 pUOcsp12+iuj0l/0D8K63Ls/PFEX6kTOO1+tzmjmSRLADBSzryj2AeMBB2TlUR7bPF
	 kcIhNENhPh0MA==
Subject: Re: [PATCH can-next v10 05/14] can: gs_usb: fix hardware timestamp
 state for mixed channels
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 09:30:56 +0000
Message-ID: <179551265661.3131.9121195539625576936@kernel.org>
In-Reply-To: <20261122-gs_usb-fixes-v10-5-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-5-7c165c35d04a@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not say what actually goes wrong before
  this fix.

--

can: gs_usb: fix hardware timestamp state for mixed channels

This patch moves the HW timestamp setup (cyclecounter and delayed work
init) into gs_usb_probe(). The setup now runs if any channel advertises
GS_CAN_FEATURE_HW_TIMESTAMP. Start and stop are keyed on a new
parent->flags bit rather than on the feature flags of the first channel
opened or the last channel closed.

Closes: https://sashiko.dev/#/bug/linux-b39360f9-6cd8-4f47-83bb-f0f78331f308
Closes: https://sashiko.dev/#/bug/linux-5f8ecd4e-344e-4ceb-9b46-886f4942a5f6

> Currently both the initialization and shutdown of the HW timestamping
> infrastructure is tied to the flags of the first channel opened
> respectively last channel closed. This leads to problems if the first
> channel opened doesn't have the timestamping feature, but the second
> channel has. In this case the timestamping is never properly initialized.

[Severity: Low]
This isn't a bug, but could the commit message say what actually goes
wrong before this fix? "Leads to problems" and "never properly
initialized" don't tell a stable reader how serious the fixed bugs are.

Both orderings look like memory-safety bugs in the old code.

In the first case, a channel without HW timestamps opens first and a
channel with HW timestamps opens second. gs_usb_timestamp_init() never
runs, so parent->tc.cc stays NULL and tc_lock is never initialized. An
RX or echo frame on the second channel still passes the
dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP check and ends up in:

gs_usb_set_timestamp()
  gs_usb_skb_set_timestamp()
    timecounter_cyc2time()

timecounter_cyc2time() reads tc->cc->mask. Isn't that a NULL pointer
dereference in URB completion context?

In the second case, a channel with HW timestamps opens first, so the
timestamp state is initialized and the delayed work is scheduled. Then
a channel without HW timestamps opens, the first channel closes, and
the second channel closes last.

The old gs_can_close() checked only the last channel's dev->feature, so
gs_usb_timestamp_stop() was never called:

	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
		gs_usb_timestamp_stop(parent);

gs_usb_timestamp_work() re-arms itself unconditionally, and the old
gs_usb_disconnect() calls kfree(parent) without cancelling the work.
Wouldn't the delayed work embedded in parent then run after parent has
been freed?

In the same scenario, re-opening the first channel calls
spin_lock_init() and INIT_DELAYED_WORK() again while the work is still
pending.

The code changes appear to fix all of these. Would it be worth naming
the NULL pointer oops and the delayed work use-after-free in the commit
message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122-gs_usb-fixes-v10-0-7c165c35d04a%40pengutronix.de
