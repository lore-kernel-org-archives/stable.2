Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704210;
	b=vVbTtiaJk1S/sCC12KOytLF9ixJsABWB0JkvMhJfJgOSSKQO3cpftlCpz+9ZHJPTMJLC
	 agvyHpBYVR8pfop+UlatC+1LO0KZv5Nn6VhLufEtibk0u0zp8nWjrPYCZbQ2bW0KpfAjp
	 x6J1rqkVXCEugn6wAdmLX7v54QS64XIvfI0t5EOHUiH8rZGVOLCBWgoPn/BX21TN8Fd8Z
	 7wx2y1l6Iz3SAK4ORHBGqPdXoBt4kPSts9jq2tEZFzCVi8tmZfGOhHKpd9gD+2JJB8fCa
	 /Ss9DQoNFj6FGcap8tXZA3/bL3eiwV6RMH/oEN8SRRavGTaJZOuHBjadUDpyyRg186Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704210;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M351HoN9QnzW4bajTJUrOSxIeJFA3W05dDUYpXeLH3c=;
	b=0+GDFKnFZ5joyjrfU+lWCel05P62B01zkPEAZESGntlQGZ63A3WM5nPhVvVhVyMop3oO
	 JwbasK/ZJcbEppL/jddQJTyK9vnhFiTJbNeBfcTNU0E8n9oBqM6Ija0+gyt//H8HWm6Co
	 aabHUE1nPCvJANvI7Q+YC1qAM6BZyOV48eFlyqJ1BFcXj9/ZLAl7n/ou3YFO1fd0TlHPk
	 aPzc9oSdqzmf6boRL2Y39ZsYq+uUs9wrgU/Jt9wjB/tpxdQqgdHqoVLG9JDtVYR/MlyxV
	 fn0CUqwWz+A35QCapyj90tXg2px8WAYSVVUcltRozMzwZRDKDwyEUGFWwnhNs+F9p4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqHxQZEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0616606BF86;
	Tue,  3 Nov 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqHxQZEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A538F1F00A17;
	Tue,  3 Nov 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704209;
	bh=M351HoN9QnzW4bajTJUrOSxIeJFA3W05dDUYpXeLH3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JqHxQZEbjqIPWdvJn3/s8FzkAMJ3m7hfBmzygiVTmR7MngOYVd4fwl45ATYkbt9yZ
	 Kx6kVV/jvmvI/Oq14BHn2zGSJuUn1eQYDhJDdkeXtFKrrd085LSeZlpEEKuamnrab4
	 flrrkqyWYxbzI5s+kam2gkU5K7LxUOlKvISq3KbPbjhcPzrVp6BgjCa86T6puu5jFT
	 NZJ6lI4YZD6Asv8g2O0GbkWm1dZgDd6aK5SsCpgmc6nr61YuqFUah5z7rA4DPUZMiq
	 7lYIl8HIUfuiS/vcE84+KEsC4RRQQmQI5bDjIbXgrGkosdXqNLQHY6zHhdDO/IVIdM
	 iDZyYe8MSA4QQ==
Date: Tue, 3 Nov 2026 12:10:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Vadim Pasternak <vadimp@nvidia.com>, Hans de Goede <hansg@kernel.org>, 
	stable@vger.kernel.org, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform: mellanox: unregister the fan device on probe
 failure
Message-ID: <20261103-ancient-excellent-mongoose-3ed148@quoll>
References: <20261103105545.1394576-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103105545.1394576-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:55:45 +0000, Wentao Liang wrote:
> mlxplat_platdevs_init() registers the mlxreg-fan platform device before
> the watchdog and DPU devices, but the error paths for those later
> registrations never unregister it: the cleanup chain below
> fail_platform_wd_register drops the watchdog, io, LED and hotplug
> devices, but not the fan.
> 
> Unregister the fan device on those failure paths.
> 
> Fixes: 158cd8320776 ("platform: mellanox: Split logic in init and exit flow")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/platform/mellanox/mlx-platform.c | 2 ++
>  1 file changed, 2 insertions(+)
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




