Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697698;
	b=cTLF1ndntfq4khWTv6fCNhGtiIrMzmdjGN6oyFg8hNaN6SIlg3rSuMsS6oj8c8LGqmNU
	 vIauxTOB0oErV3HgXZSep8wl7ZdYaF6zvZ/LCNA7m01p3ZS+BFf+SHcqD6rvr1NGF22M+
	 uoCtI5PIOfG2zSUl/xPVVeDfefJI3q6dwRKrsJjnTHKJaW+ku/D2wM7lXtoes+0znBUJW
	 a98C2yTZG7uCto/2t9H3xnacMVgaXHu/YOSwz96elQRGr+x7czOwTPDJstqGqnIwPutFe
	 vW9FATMSVWSVPQPszc2mHNJpuc2hv9ixaZHgrWi0ZhLen4RgG3nNTGKPcwYhx6qPKMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697698;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NP2sN5eUDGhbX35PtSoXTsLLFghlp2JmtENblnsMo08=;
	b=K1oV0HLMDT5NL1kmJxWk9gg03Q8fpNTSB6sbjsicmoBcfulknRBVjeGWPpTl+Lv7IUXt
	 XRffXiY0AK4UbL3QCD+tEV9uOLWXDM987I0+CSsOPNQo4mrQtlAB1OCIOdBPXFmjAutRq
	 mdlH8myh9eOhnUgqUNxZCp2Q60OZwgVl3Pgt+KP8r3wXBphDiQ3t0bQa7ObtP2qxrZxE5
	 T9Jezi20Kcw9gIPhgYqJys3E3XIPP4+1OQkjfmulsi3OqB4nYNn2ghKPIVo3dBPI0w18y
	 QQlJFlknoTxMHtOB/S2d2bx3t/v5QwCGw/Hjn9HRsVuThgVx+6cusaP2rKrAVFnMm2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFcNmD0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F3606EE99;
	Tue,  3 Nov 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFcNmD0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF71C1F00A18;
	Tue,  3 Nov 2026 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697697;
	bh=NP2sN5eUDGhbX35PtSoXTsLLFghlp2JmtENblnsMo08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WFcNmD0Mrv3w5J2CySc0bY6pNjKT28KaUljk7+PRe1+g0kIRloeyAQrYBZjfoanC3
	 9Wn3liETYSVPh/IPrChRzdF7XkITJinwyc9E3q2d5OQPve8glFk/Dj6u5DBYEVZtcG
	 aBv5xvy3JlcP17ZuZZflSnOiANDKDwfzdUI844SXqKEx4I/AY1c6HvvOVCwxNDkOcA
	 nxepUWwB87/nS/wUHrNHFFoODVZz6yWxEq/hpmxbadY3MElzkNmotmtIRrhBImCmFs
	 3hZ2RzQohztVn0OAE0KIJ77utmRrFEXiCTw6FE3CVeKyLByuxXGlX29iSVFb+sNXjW
	 h2wqRdkpjOPEQ==
Date: Tue, 3 Nov 2026 10:21:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	mchehab@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: cx25821: Free controls even if the video device
 was not registered
Message-ID: <20261103-vehement-likable-chupacabra-2b8437@quoll>
References: <20261103083132.1171874-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103083132.1171874-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:31:32 +0000, Wentao Liang wrote:
> cx25821_video_register() initializes a capture channel's control handler
> before setting up its queue and registering its video device. A failure
> in control creation, handler setup, queue initialization or video device
> registration reaches fail_unreg, which includes the current channel.
> 
> However, cx25821_video_unregister() only frees the handler if the video
> device was successfully registered. The current channel's controls are
> therefore leaked on those failures.
> 
> Keep video unregistration conditional, but free the control handler
> unconditionally. v4l2_ctrl_handler_free() safely handles the zeroed
> handlers of channels that do not have controls.
> 
> Fixes: f8d7ee70919d ("[media] cx25821: convert to the control framework")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/pci/cx25821/cx25821-video.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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




