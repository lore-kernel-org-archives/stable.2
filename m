Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701561;
	b=muXmTLm8jfyClY+cKFPCIpUMN6inIgePkO/LPqWgZrYZxBDZNcnUPyyhvU5jI+rVF++a
	 18m9opIgEHoU9tls+fVrRW65WwyCq/5R/NbuDOyjiIn1Bfxaesz10YBBxTnvfvgNJ4UUq
	 pGjCrGQPnZHboe3k4Rype07r89N49YzDtkJTLAaxGP7TeJ+oEPgRUF3WaGOCEm32EX9ss
	 TSYWZ88Uqev+uJiIyCxl0ZYJPlyDy3NiyqM3PT/VDvsjnlg8T4uSPqFFsQqtthciYrQ+z
	 QvcOgjucs4BFnX78K7XRjA6c8h5QU/4wptJF+e3O47klw0Td/6S/zR4V+iPv+JVpZnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701561;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LVepNa8MBgnxzOIR4Tx+W3uy/yFi60gYxq1FZlSu/kQ=;
	b=kMvpr9JE6wjkvB/xj+SeOP3rc46tEI2thOB3BOc8gBOZaX5k9JjHLEZiRV4Ky4vGTlpa
	 eXMgSBflukhdzljxA9gueEdtGaeRoxSXqcLay66yJNk6cx5nq+1Q4NjbVMtRcnxRFIuQL
	 Mp8REypgmLUrl/ZKSj70/q2gel4tmJG9msGdGgo6NOnSvc4pu+RISothjConbXbNoeHdW
	 CNJD2mQCq/zeja243T6xTWPaZY6fdIKixEwTK+EKq5XAPmXFbLuYHhKJo30RcFFl5QWcm
	 P9E5M0Q/Xg4lVww30eW4xBdowLeip4H00troXcL+eDWUBi4bgZg+5q7UI4xuYllIqyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YKjrBA/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CD606D80D;
	Tue,  3 Nov 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKjrBA/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957E21F000C1;
	Tue,  3 Nov 2026 10:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701561;
	bh=LVepNa8MBgnxzOIR4Tx+W3uy/yFi60gYxq1FZlSu/kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKjrBA/mej4tTGzq0T8wexaUUvNDO1PFLajq/VyjYTc8bTtvyYP5brGpAOeaT6YFX
	 dyi3WDtz15/cPCJOfI1SBe1oS4pAHGoYDXl1Y2aMOZx1hBs2Za8+T2U8j7Vuwm8r22
	 S4NJPmIN+VLIIM0fB3kG/9e0RUaPu8gN/8nGHK/IEMmm31fjGD4G/1R3ejXgCsDYEH
	 WPww9c/E68B4mbK+0ocCC9SrhhY2M0JAKHW4qC/PsPOAp6uBOmdXR5y6Cqmiz0dNMc
	 N9WYEUWtyhn4uoWTG84NsEEzZBDxYBmi2+FSeV7Gn6MLo12p4FWCq3KJyQB9Dqi1rM
	 kfu+QknFBny6A==
Date: Tue, 3 Nov 2026 11:25:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>, stable@vger.kernel.org, 
	Madalin Bucur <madalin.bucur@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH] net: fman: drop the FMan device reference after port
 probe
Message-ID: <20261103-magnificent-happy-cuttlefish-adbaad@quoll>
References: <20261103100532.1309969-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100532.1309969-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:32 +0000, Wentao Liang wrote:
> fman_port_probe() looks up the parent FMan platform device with
> of_find_device_by_node(), which takes a reference on the embedded
> struct device.  The reference is released on the error paths, but not
> after a successful probe, and the __devm_request_region() failure path
> jumps directly to freeing the port.
> 
> As a result the reference is never dropped.  Put the FMan device and
> the port node before returning success, and route the failed region
> request through the existing cleanup labels as well.
> 
> Fixes: 18a6c85fcc78 ("fsl/fman: Add FMan Port Support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/freescale/fman/fman_port.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
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




