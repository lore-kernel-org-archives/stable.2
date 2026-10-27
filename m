Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136434;
	b=O6a1OhWjatX+/5O7ummpFkdViP4lR8zZPa8RyfCW0SJzeJ9VupfQTk1glvkQRRNs4Hr6
	 LJeAG+WbOpYQ+S0e425RY0vbe/eDjUIpLzpMfu+iIjlvVUq+LLHm4lhjlo2X2exHpwyat
	 YspnkBkhll+QjgiebVWYAspQ+VtJkUwYvjfjO8SzH23HQlpfqhpR1DDlrhBKCmIu1fUDs
	 bBrkWapaYGsC2WEhy4owT/XS5vg9rnLvLRGDLnSd9nVzkXt+/PLILFD0f/5R0Q3l7uxrm
	 jHA4Gr1Z91GAoWhcvA2Ed0Y9J3xpF35lE2kmGFny//B2JefGXR1aPw+KAtGaSfqKXOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kESwSTGC/FOWEdvQippRMdRenOboGaWNTRd7jgw6cOg=;
	b=3m3HNKiG2f8KPgCMQCK6QxNciby2R6IMk7FZ19mS6CHPUPMjgJRingtGprDr0dXSOrOQ
	 t0AB1y5mxekmmyHpOF01Sm/shJ8FOVynLA6UxdYkOsdOEnbTtjBw6UsXUEikB275TgVXD
	 BNScYwPfytOh5RxgzM/QtcigedQt665ogg7lueCXfn8Z7t7QaXnO8hslrL5TKO0Pd12Fg
	 vgSIZWrtgJPlp/eMdeBTbU31/Vx4Ldlly3TzvofuX6fpeF6JPHrOzl7t9i2dIRIWSJNDA
	 bPRFenotWVmgqQKrR35Vt7tcDiW0feXrreZBu4X0HzJGpgIt8uen2PwIP77tXRSsSSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFfoSiky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91759606A31A;
	Tue, 27 Oct 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFfoSiky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E11F01825;
	Tue, 27 Oct 2026 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136434;
	bh=kESwSTGC/FOWEdvQippRMdRenOboGaWNTRd7jgw6cOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NFfoSiky1ZEnDDq3KMO0a3U7/6jgcMEXup4NtpE6hfOL+ubUr+0YF5aMw7KafAtQN
	 54Prid+YQ421EjJolvdBnjf+GoMrBIGQxShkeppwF+gf9+UrX8pGdJ1eC5e4vxIl3U
	 S+lODW6WsFAhlNmuseE9eaFQ5SSWl1h/c6erQ6cX+iDRgUqUUF2UEWU0C0ENVR5/x0
	 WSwrp1171WirTr+BD5LNvM5jIc2VDl6Yh/tl0wTvrNjsovAVcM6sJKq0bDktUes7x1
	 1aVLrznR5atMwv+dplpwhOJVCLQ6ejLrSANjorFZbm8H0DFbc2cXoMielkE8FxAe+v
	 HtzgslMrCGLig==
Date: Tue, 27 Oct 2026 14:27:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, mkl@pengutronix.de, mailhol@kernel.org,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v8 1/2] can: dev: can_fill_info(): don't wake up
 controller if interface is down
Message-ID: <20261027142713.5fdd318b@kernel.org>
In-Reply-To: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
References: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht>
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
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 14:50:11 +0800 ChunYuZhiQiang wrote:
> If the interface is down, the CAN controller might be powered down and
> its clocks gated. Don't call do_get_berr_counter() to read the bus error
> counters if the interface is down, and adjust can_get_size() to match.

Please don't CC netdev@ on run-of-the-mill CAN patches.
Follow to MAINTAINERS / get_maintainers.pl
