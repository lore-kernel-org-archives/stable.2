Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124136;
	b=nQB1zZoDZZmNkJvxRuHoZN4bmBsnCBvf1aFzCxR72T++XRKUtg7mMJFmhyogsrWTHrEb
	 a2H0LogmuziIcZ8yUInvt1WQSzoRFb+YX4NHq/L8I6Df8xEesMqiv4nmH5A7dcwVYHkZf
	 GdtwbMVCONm3gf2CsDiPOzb9MTcZuULRhLPa7Ahva/HvD9N8Cy3JWwyLjn2O3XfMb2Jdq
	 Dri9QdoXb+qIarA5VrNvedmNW0pqvSxbzTOZMaeLxl8xvBEs52x44r4lhJClEqpyxLPG4
	 CZkCpxTy182iS1DGY3KdZ4qshFdqMAGL0GWo57Z+/ivfUwqnoVsGyAaNwUy7nMIZMDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124136;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=36E1OyuSAPV7X4+4WcIua+s8Q58mSHGZB0W0hhOOVr8=;
	b=QSnHSyFCFcRsNsb7tkR2Tdd5NmZJMfYob2dbOevdl7nfAOVjuZ9+lpDmcmwydlu8fFGG
	 L6HouPpjDHnywJ1HsC2bEqNOzNZ+9A3Z9DhkyMq6PCxdDnYGqw2fM3I9m/mlVwJ9EE1ls
	 33dy0JmTIm5EbXiXb+dZKF6uaj6ynkz123pOUJARn144GbBKe442Cpu7Op8/iciP8SIoi
	 Xq8o48wEvBIuZJtJa2NyvC3/zIsuu3B0ljmKRhpnxZLN2ztf01HpUBaAKfLo4bKI+NUQb
	 X86fud+Cu2/4DGk/iNbspgyUU4uHrbUw7V29n0GZ21rKrGONRDVIGUG/tfphOX18zgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GwWGA/ul";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E987606A324;
	Thu, 19 Nov 2026 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwWGA/ul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC81F000C0;
	Thu, 19 Nov 2026 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124135;
	bh=36E1OyuSAPV7X4+4WcIua+s8Q58mSHGZB0W0hhOOVr8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GwWGA/ulz08qobge5x962HV1PohVZEPZTlv0JCI7I9HlAcPyxho1658WyJ32Ot5OA
	 kY5nOqWvYxi86J97ki72HLMyFbzqqQMQQ8alQj96dov0RkgMoYkErMbTgxQcsiNbdP
	 xh56cbmqngZJsCyI1EZsJ3X22L9oMrfxrNL+7n0e0vAzCPXg+SoT3JoqCpwqSR9Nhm
	 fX3SRAG2HAekcowsvQiJ7IPJSdSbvDZU8GK+QqqlQX0OXAYeNON4aEnFiT/VTmC0ls
	 PQULJcEmN/QLMM5bPrkwC5VC8WnJ8T26JGsWQzGyZbvvujHNMQrmLkj0djp3PeXtsN
	 7eYiCCxn3ZNjQ==
Date: Thu, 19 Nov 2026 22:35:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Ho Jie Feng <hjf3108@gmail.com>
cc: basavaraj.natikar@amd.com, stable@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: amd_sfh: Use shared interrupts
In-Reply-To: <20261023081803.21761-1-hjf3108@gmail.com>
Message-ID: <77539o3q-1nq4-pn33-96qn-5n4s6s808qp7@xreary.bet>
References: <20261023081803.21761-1-hjf3108@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Oct 2026, Ho Jie Feng wrote:

> The AMD SFH driver requests interrupts without IRQF_SHARED.
> This can cause VFIO PCI passthrough initialization to fail
> when a passed-through device shares the interrupt with AMD MP2.
> 
> Request the interrupt with IRQF_SHARED. Check for a pending MP2
> interrupt before clearing and acknowledging it, and return IRQ_NONE
> when no MP2 interrupt is pending so the interrupt can be shared with
> other devices.
> 
> On an AMD Ryzen 7 7735HS host running 7.0.0-38-generic kernel
> from Ubuntu, trying to pass through an xHCI controller
> (1022:161d, 0000:e6:00.3) fails with this message:
> 
>   genirq: Flags mismatch irq 45.
>   00200080 (vfio-intx(0000:e6:00.3)) vs. 00200000 (pcie_mp2_amd)
> 
> QEMU reports:
> 
>   vfio 0000:e6:00.3: Failed to set up TRIGGER eventfd signaling for
>   interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy
> 
> With this change, the passthrough is successful through VFIO
> on the same host.
> 
> Fixes: 7f016b35ca76 ("HID: amd_sfh: Add interrupt handler to process interrupts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

