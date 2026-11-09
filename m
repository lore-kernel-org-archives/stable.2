Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230551;
	b=3P3EBtg1X8B6F1oryHtgov2eQoeUNAmbkrgLAOhJQBVBWWF10FrQwulbVV3xq7srkSbS
	 0NyMLUv0TOfzF4ibYKvX3JVExaaZ48KJBEz00BbjO2UfEbO+OAoAuynp/+QzYyY1YU0Gz
	 YdLc+1sVS/T72VxQM1zPnMo1JflUpQ7JSytx9LoBftXmasuNUbjtYiAxAqIDytpnNfhI4
	 yz0rLmB6akqZiOPOq/JKEK7MRxX92hU8CPdGV+JtIZiNWH1g4kVqqGDhoBUI6eNbo7o5V
	 G3iW59nGtifBOhRBxGwBcO764DbKfydmJ/EqVpMdASZ+T3NwssgOw7O0mP+3/Xm1nlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230551;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=kA2godbZnBHxyz71XZOEW+H2DRSk3CIDmt0/jBvvJU4=;
	b=biHvQbrH6zmfB2bxSzGfqVpzyqGIuQVhY5Oah81yFJbufjHEKXCNabfeJNLVJ4bRyLz0
	 H4ecEiITXBFxVYguBDz+mhVV+FicWC/NN8kt/oVBeV+UPpVTTcEy4Kysn3+eWBAQLJ046
	 uoo5nJIjno2lG/8RXTAxdUUxIwmrKIWRlr8SP8f9BCVYjtgZya0LcDoptrBVMFLg1043O
	 vxkZlnO72JPWotfT3c90ZHc6S6+/Sli1wMxbOJMRHX4ryX/a6AerwtpQCKAnQXd+gZweQ
	 7Wm+dmWJ7+DAYB9S57LEmSFPb66vNh4cGAHxjrleI3+uhdTxX5Nfiqcf+1Y78IUF6pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4rTHREd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F60606A321;
	Mon,  9 Nov 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4rTHREd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2249F1F008BF;
	Mon,  9 Nov 2026 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230551;
	bh=kA2godbZnBHxyz71XZOEW+H2DRSk3CIDmt0/jBvvJU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G4rTHREdwR0I+nKNYEBwCJqYr/+YU/uakCfflvjUoZ1IKVaSmgE7HBHoTQqEHoT1i
	 Bmh0WdnTR9YXJYcHVoN7FeTFFAe/A6b66Dw+q8lTZ93B/Z/S7NExNQO79DHLPWzcr4
	 DbXy2i2Y+87zuahqSSK/9Fe0AqZXj//KA8DtwkMH0Dpf8qXCgHwrYR0CzItm6aFdG1
	 M9BEGONmuLdcUUJclzb1oh1FnL7EG7RkvKrSdktfIEGYLAamcKqNdeTOSI+O4KrY18
	 3FUqKafFOMIlGCU3bXECa9PRaqXQDwbSM6+QlQa0DivutJfwD+tX6EeK/7NLo+rRBe
	 lxIR02ANX54wA==
Date: Mon, 9 Nov 2026 13:22:26 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, idosch@nvidia.com, petrm@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write failure
Message-ID: <20261109132226.GL18859@horms.kernel.org>
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
 <179405323723.994134.11947248661617076904@kernel.org>
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
In-Reply-To: <179405323723.994134.11947248661617076904@kernel.org>

On Sat, Nov 07, 2026 at 12:07:17PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch fixes the enable-path leak but adds the same leak on
>   the port-removal path.

I believe the issue flagged here is pre-existing. While it does affect this
patch, the patch is still an improvement in its own right. I would
therefore ask for follow-up on the concurrency concern raised here, but I
do not think it should block progress of this patch.

And while the separate bot email, requesting information on how
the problem was found, should be answered, overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   mlxsw_sp1_ptp_mtpppc_update() has no serialization between its two…
> - [Low] The new rollback in mlxsw_sp1_ptp_mtpppc_update()
>   (spectrum_ptp.c:1223-1226) calls mlxsw_sp_parsing_depth_dec().

...
