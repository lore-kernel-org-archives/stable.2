Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894C18A6DB;
	Thu, 15 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065170; cv=none; b=Z/WL3+bSq4h6n2vriFn9FD7x6vHJhN1N7NdpNjU+dT/E2+OXjSKIMbq7nxrRwepIYHoLplvnkdlB/4XH9b/BgGkuqG12ZVLaqQNNlDXwNYBFejpckVzbb98TAJ0ueBRMrhImfBiSTk903JaXowSCzjJuMfemOR2Wwp6PL1RUpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065170; c=relaxed/simple;
	bh=2sQJXFyArpysCD9tVrNpkqhP5VFkJtWpl4LxV8vfjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6RZSttjLJ3nbAowD+cYuiQIX4fhkkb3GQVjuHWQUSRieW8UojTjLppKueuPMRa6bK9F3aJoGIExkSOqztu1Qgh0KAMz5Te/lAEk741wyvvEGbWgOw24SMAJj0/HuYK0WoJTcYxEE/GL/hiU+0wFMoYdV83lYDXZjO1GNTMOXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ/rBYLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ/rBYLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D1D1F000C4;
	Thu, 15 Oct 2026 11:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792065169;
	bh=sC72EAmoifBVTLDVj0wP5wmbgewZfK5wW+3tvU4ypAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kJ/rBYLcU9+AT5KZS7DdXNoxHHiA7p/tBxuSj9SdeuDX3SwkNYCOK6rMElDbIKpSd
	 slYAbvxbr/99RMRAV0C9R4Do//LZaggIJHnktZ7NXJDUbKRR6ouEBYamAsLMt1Fijr
	 mrIXPtbmJiLOIOqZezaZbz7QnyPttA0gu/jJRFP88nx6OLUvxKQ+7c0YM2oRJ1vyC2
	 xBLTj7LUp3A2MXcLTc6z2NzJHgx5EYzYal6DSef40zEdO/3lc8z+ifMX7XTpoYA6Te
	 BEoHcyKghzTdPdOYtGENPO5WG/IqVhk8Wy44SVXrC/uOBBL8wMGotd6aeUHN8ftG/Y
	 05IFduzs89D5g==
Date: Thu, 15 Oct 2026 13:52:45 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Birk Skyum <birk.skyum@pm.me>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Daniel J Blueman <daniel@quora.org>, 
	Sasha Levin <sashal@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL"
Message-ID: <atC-ZZLkXs3yM6l4@zenone.zhora.eu>
References: <20261014130805.48840-1-birk.skyum@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014130805.48840-1-birk.skyum@pm.me>

Hi Birk,

On Wed, Oct 14, 2026 at 01:08:08PM +0000, Birk Skyum wrote:
> This reverts commit cb97bf3d4f91453b881acaf8e9f0cc47bb40b604.
> 
> With that commit the keyboard and touchpad of the Lenovo Yoga Slim 7x
> (x1e80100) are dead, also at the disk passphrase prompt, on 7.2.9 and on
> v7.3-rc7. The first transfer on their bus fails.
> 
>   geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -5
> 
> With the commit the I2C serial engine clocks read 32 MHz, without it
> 19.2 MHz. A fix for the 32 MHz fast-mode timing is still being
> discussed, so go back to the previous behaviour for 7.3. This brings
> back the hardcoded index 0 in SE_GENI_CLK_SEL.
> 
> On v7.3-rc7 with only i2c-qcom-geni.ko swapped, the keyboard is dead
> without this revert and works with it.
> 
> Fixes: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL")
> Reported-by: Birk Skyum <birk.skyum@pm.me>
> Closes: https://lore.kernel.org/r/179173732257.29426.7905170638383807320@pm.me
> Link: https://lore.kernel.org/r/ae03e7a3-75f1-42df-b0e6-0e64358be647@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>

there is a fix taken here:

8cb5c17be3a2 ("i2c: qcom-geni: Restore the source-clock selection policy")

Thanks,
Andi
