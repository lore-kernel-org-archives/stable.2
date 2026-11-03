Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702454;
	b=d8OdQXWvHNHfwM48dU872RFUh9TTw3mz+GKBbB9VVpz0R4f9bgNzdfPkWnLDu6iI6nTG
	 Jwk6ot7u0h5vWuNZaCv/RLeWG5Uv+skHIqehejoePwGtRUaBstSToCL0HU9Ngql9s+InL
	 UNIwkqG8NGOWHLqX29vCv6jCAQZvL76YLzH4eZDW1s0+4b2n/o4LE8Te0u3dtqJcUt2K9
	 CXdLZbKsxQHudPf3J/8rZeOj068+MmM2OHqKns8WfBXCogo90m/f5QHdONW7btygdsjAi
	 MhKgs/r5MK8IDit4EtcLzD4PPp8jLbgzhRRxiRJ0ohub0Y9j6KbASBTMcsGF4a1YzoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702454;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IYxQu6rRV+yeU/8fjYNJ89G0AYUb0oOfgKRpklW/3u8=;
	b=1qpjf3ZyohQZB2ReBg2k1cVMjcGDKqMhfOsDine9SDYvt3QRhrFMdyyRlet4hO8UBwP/
	 2fi1ZQbffA8cWmw2cTMjN95oJ+sRXiqMrVlqdsWNDpIkC+uPTohkn11PRQ+1OEgTICkdC
	 W3WuhPn8Zg9ifUD9dXBHub1FW4Vo0+OE5g7UBJaRxpZForQeE+8YhX/+oO+5qBbThKEWa
	 zDKSF6NGTlVEihYbZIljF2FaosoetDSoV8RlomVTvUed2O/5fAPus/YJS+Ub7hKL3dr4l
	 G6lqEyHAgFIY1ilBy59Ws9PCaCu4aueUhuuue9lpvfGfvnP2SRjrSTLkxysfvrfaTbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1IsFgao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E5606A831;
	Tue,  3 Nov 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1IsFgao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA731F00A02;
	Tue,  3 Nov 2026 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702453;
	bh=IYxQu6rRV+yeU/8fjYNJ89G0AYUb0oOfgKRpklW/3u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a1IsFgaocJ/+veS0AT+Uu3h9gCVAOdbP71qRvxqY7UZ8nac3q+Ww5xCIyhw/GCNQF
	 Wwg3uWGybrOov4FmLlXoSW8tWuw2fQkGMsCuniXx62TdZnvhQIf0PXnezqXlfVwgIR
	 bRdAoET2uKSQGl/pQeCMNU2MUmjZX/m+j+gUXvrIcXxNJRYy/kOxV3B8nC2ejkMTf4
	 LY7U7ezH5A6RVtwR27NTf5zO5Kh+L0r3h+OARgRi1zEWFrfTXqC5c9UtDn4Vgob9VS
	 xROax+kPZlGbYQoT/UMxACOgOiz453rEbzuUGuLeDE/+/N0+a72sQ0PBSJ1azIF6Nj
	 vLTy+bEflIwSw==
Date: Tue, 3 Nov 2026 11:40:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, 
	stable@vger.kernel.org, Bryan Whitehead <bryan.whitehead@microchip.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: lan743x: disconnect the PHY when PTP setup fails
Message-ID: <20261103-offbeat-polar-starling-3aaa06@quoll>
References: <20261103102852.1340530-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102852.1340530-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:52 +0000, Wentao Liang wrote:
> lan743x_netdev_open() connects the PHY before opening PTP, but if
> lan743x_ptp_open() fails it jumps to close_mac, which skips
> lan743x_phylink_disconnect(). The reference taken by
> phylink_connect_phy() is then never released, and the PHY stays
> attached to the phylink instance.
> 
> Add a close_phylink label in front of the phylink disconnect, as the
> pre-phylink conversion code did with close_phy, and use it on the
> lan743x_ptp_open() failure path.
> 
> Fixes: a5f199a8d8a0 ("net: lan743x: Migrate phylib to phylink")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




