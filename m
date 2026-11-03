Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701583;
	b=xRkgqeGE+mIPBqcXC79etvHVVAy6JQp6s5RFwRpQnp9HOm81DKAgxy0/HfbmBgF/+X0Y
	 PBXuN3CrA3dZe4X5q154vHs92NJGGZt4eK/RzLPZzYSHQ/CWZbRYASvD/wRcIaNe5oZDV
	 Kwonw6TYkHfZe8XPiIpUmehIKMMA9UGqMjcptsg7pIXSeaLP2pUiDQnt992nit1JWuQ+q
	 xHyGOH0q0JWFBH/Jc2KwCm6ssJZwbHOs9XS53QMzDEMzzFabswxsYK0Mo3Vfpy8JvglgE
	 kJTEsF8/2vyJbZ/igQ2qoMpEqZ1IL12qIJXm0aTXHO+oULb0PtSAtPP8c26wuugm1ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701583;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hPelRDqUwp7KW12HTuin5RprdXgKQmkVT6tqrMUtOCQ=;
	b=FIfTvkNHWx7L7cla1w6A41LKBpIs+NzKDImXtrDovUffuKhQyy9t3+hNDtLGsbscX4fw
	 oCRqb1QRfMriU2XIaf8Oi+IC05n++L2Lb4yMjDooDwuSA7XUZQCX1Z1FKn5RusP0dbI3m
	 GPwStE4pY2a/VHxxuEG+6pumrgd2wcTS344BWN++eahJGMOLvPqpPbSKxyg/l2wl5nuVf
	 WDM91Xhf39J6uM2rDDCOzTVfCAiHCxOnvAdUcrVeNgFhJO66U9rbrOLtLC50cK9jBe0fG
	 uPYo6GE5Anub70gUaj/TcGXS/oMZYpx/JnY1oD4w2fB7csJDwDSMYI2zQXMJWO8sv1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpW2RbXp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91A6085081;
	Tue,  3 Nov 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpW2RbXp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C3B1F000C1;
	Tue,  3 Nov 2026 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701583;
	bh=hPelRDqUwp7KW12HTuin5RprdXgKQmkVT6tqrMUtOCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mpW2RbXpTauD/p5AFD+KrapAfxCBIXPHR4DSCt/bR9ViaLUyQoHkZoe8IXf3yY/Z/
	 4j0187qoKzSBfHPC6rlahSbbFFFgw9Iwbk9inUyiHosvEcXM4LCwszYM/FwrGcOWhO
	 n9O0QDcfv9kMw0jrcI7HBM7tEspOehTakMbUdE51LzI3KCH+4hQmtewP6zrE4oOAK0
	 T7ExtJjn2pvmeCprKrujBhkSe9wwiAKKOQRhkF55oCzCH1uPGzgEiwWeWNYyBwH//I
	 OGIleM3ZZ3CxCAtrLNG+GkQjevH5HVqTm4Hy/wLVyzZXt8z5nUz7JhMYycAOBvbZxu
	 Rq9zY/QPQJqpQ==
Date: Tue, 3 Nov 2026 11:26:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH] can: flexcan: fix device node reference leak in stop
 mode setup
Message-ID: <20261103-fanatic-thistle-spaniel-aa4ede@quoll>
References: <20261103100526.1309829-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100526.1309829-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:26 +0000, Wentao Liang wrote:
> of_find_node_by_phandle() returns a device node with an incremented
> reference count. flexcan_setup_stop_mode_gpr() drops it only when
> syscon_node_to_regmap() fails, so a successful probe of a controller
> using the GPR stop mode leaks one reference on the GPR node.
> 
> Release the reference on the success path as well.
> 
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 1 +
>  1 file changed, 1 insertion(+)
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




