Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219347;
	b=5LmtD4Vhn6oX7j0G8iJFYs+BUrcJwS+n6BRitVgxnKXLJRq/GPr7cRdHsem7EIOpk1tj
	 l51kobC1rRnvhqIHERnCYb1fOtAO9A+gYSNQ5ZZtxre1GAjcqwYQwwpbMUdjSFiUTMzME
	 uPhs6ifln72jJMKxNchLbiUojV8HQNrJRygL+oGkgxL9OMYEeWJlyMzDTBqLyuzKO8/3J
	 iMHISQbLtOu64SMnJrt0bzCe++o5iwMZRjfLl9gQfTT3WWKBlGEeRmm4HU+w6PUT24qrC
	 a0BBNIpH8sMirtHH4WHMYhi0V5T0d/weJRz9zxjdTFSv1rsf9m2oHHtefNQHX9bvJXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219347;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vVTWkhfLiH/QsLki+tG2g1OrDcp1ntC4ATOpIndsvv4=;
	b=U/V7Nj5o7L0mIj4FWyBJpl0j4T6rcHR86zeuDlREcQtBm0/drnd78H7AoJtlE1QuC9ua
	 STXHCDovH0ziTlG2OInwLGOLdu8bP5vaAGpi+GyCym+UJNFPsrBBJtewWPp+6Czs2YVRD
	 AS1BS7xoWxKjIjtzjFQw9Ax2ToeSsENxSyRCBOQwHE/oRgYOtYsaukFQRGomLfxN6BlaU
	 /My/mhh8Kdi7qmSMBzMlTjvYpFYrs69Ok94sHbp9QFKoOV+9h0rNkQHqeNy5IwJk1wt4k
	 0XJW/5ja+0+s4fKUUyEPHCmduz9ygBXXVhw549wojIj4OVjYAdUMv8jFRRrMf/El1KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9rz7AwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB46960A2602;
	Sat, 21 Nov 2026 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9rz7AwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639661F000C6;
	Sat, 21 Nov 2026 00:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795219347;
	bh=vVTWkhfLiH/QsLki+tG2g1OrDcp1ntC4ATOpIndsvv4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W9rz7AwUeMWreMrPywL+G/eoSE/ac2EveLkjzau1+l0PpgXWjbqzH2KWAYN5hxD/0
	 evRhjZHWufSyBIVEzlrjwmfIRXPIpt4QTk1ivutvkXBvV4bFQhJFI/26GRbX5pvHM3
	 EluX44uvrajwnxDAhlXrXaS9HMrM07H3/Ou6qQO3hPenvRQtCRv06l9uXteA/pLViA
	 O/TGDLSTfnS2YI04Br/iLpk4mLydKXSfwv1M7WJajGUA6OHjBWCG6swUWr+dJKhQ0M
	 WnI7u47mSRhMBbQggvz7GW8gE4F4+V8Q9YuTyV9In9Zwsf4s7HMXNClCq0SxgZhO/E
	 eRAYjIXBkfH8A==
Subject: Re: [PATCH net v10 10/10] can: rockchip_canfd: serialize timecounter
 timestamp conversion
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 21 Nov 2026 00:02:25 +0000
Message-ID: <179521934595.3131.13988876249908602124@kernel.org>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-10-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-10-df23913aa33a@qq.com>
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

- [Low] The patch is tagged `Cc: stable@vger.kernel.org` with `Fixes:
  4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping…

--

can: rockchip_canfd: serialize timecounter timestamp conversion

This commit holds priv->timestamp_lock around timecounter_cyc2time() in
rkcanfd_skb_set_timestamp(). That serializes the RX, TX completion and
error-frame timestamp conversion against timecounter_read() in the
timestamp worker. The comment on timestamp_lock in struct rkcanfd_priv is
also changed to say it protects tc and timestamp_active.

> Hold timestamp_lock across timecounter_cyc2time(), using the same lock
> as timecounter_read() and timecounter_init(). Keep the SKB timestamp
> assignment outside the critical section.

[ ... ]

> Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
> Cc: stable@vger.kernel.org

[Severity: Low]
Should the stable tag mention that this depends on the earlier patch in
the series, "can: rockchip_canfd: prevent timestamp work from rearming
after bus-off"?

The timestamp_lock and timestamp_active members of struct rkcanfd_priv are
not in 4e1a18bab124. The earlier patch adds them. It also puts
timecounter_read() in rkcanfd_timestamp_work() and timecounter_init() in
rkcanfd_timestamp_start() under the lock:

    spin_lock_irqsave(&priv->timestamp_lock, flags);
    if (priv->timestamp_active)
        timecounter_read(&priv->tc);
    spin_unlock_irqrestore(&priv->timestamp_lock, flags);

If this patch is picked on its own for a stable kernel that only has
4e1a18bab124, it will not build. A backporter could add just the lock to
get it building. timecounter_read() and timecounter_init() would still
not take that lock, so the race would stay open.

Other patches in the series list their stable prerequisites, for example
"# prerequisite for the Rockchip restart/close fix". Would something like
this work here?

    Cc: stable@vger.kernel.org # depends on "can: rockchip_canfd: prevent timestamp work from rearming after bus-off"

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a%40qq.com
