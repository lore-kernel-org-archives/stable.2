Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B8378D9C;
	Fri,  5 Jun 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653956; cv=none; b=VuY3+e+RLctYhipmt8QE3mia5dzwxlqK09SfwmVYCK8ry6fb6ISqKa8LBkWKyYREyTvNA5rspcpQjhIn89IIYutzgKSaDWsH5MQPuCdO/2wI2kM6Yoc3LCKhGUBT77RCxEm1wyjFHsTX5CtoOC7w74VEJJJiOclY22hn4VBiy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653956; c=relaxed/simple;
	bh=FQ6GGz3nhA/S2r2Og6uOR+zEaUKOYt9HGGvDk52BZ38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bSi/myMLrqGayk0kBCKrKx56f7bJPwBL/9Um+IwmTTKRB+/ZRMszNU4ERYA5IpoexLm9O8ZBSfJ7WZ3R22ey9W/JGbfo107SSP9BcUeg/filShXecdTDqpbrOw4pepvGClOVkersxqGjwN6h01g+OWq4ECi+tGH4pR2na7dymcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2kNPUUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2kNPUUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4D11F00893;
	Fri,  5 Jun 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653954;
	bh=8tCAMEOJ2W0DgEOa63G9q49he5wAWVdyoSgRI6pyvy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J2kNPUUuUQCXgpxKc3kpE3IvsCEgKjNoJ3eeX24TGZrAHnSpVpWIDuFg/2DFIwiX3
	 +NzEG0Ys64yOjSYOSjKRpndtpVvyl9iSwnDXW6Zco0y//fWCPjdYbFlEGTYcVeYIi4
	 S5cliMDufqi7mUnWjn8eUk25FqBhT/GvBATei6Daqff8/inS//Hc+aSfdlTiJNpcQs
	 buVW0u+yx2l4GGIzexTpVSu+bX3+GNi45yQ6JxkRm5hddtR2lLhNAIyxcfHa0TNYJC
	 /MOtXqTESe5ZQdo/Y/cFRR/4Zi8PaIFeMA/aQsc7O4krNjD07MaaUrtSmW4cu584qi
	 5Aj2BFsbNYosA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B0C3930B03;
	Fri,  5 Jun 2026 10:05:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [linux-6.6.y 1/3] HID: core: Add printk_ratelimited variants to
 hid_warn() etc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178065395515.3231246.12606425356233054925.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 10:05:55 +0000
References: <20260603133140.3069226-1-lee@kernel.org>
In-Reply-To: <20260603133140.3069226-1-lee@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, lains@riseup.net,
 hadess@hadess.net, ping.cheng@wacom.com, jason.gerecke@wacom.com,
 vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
 gregkh@linuxfoundation.org, sashal@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, bpf@vger.kernel.org, stable@vger.kernel.org,
 vi@endrift.com, jkosina@suse.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed,  3 Jun 2026 14:31:25 +0100 you wrote:
> From: Vicki Pfau <vi@endrift.com>
> 
> hid_warn_ratelimited() is needed. Add the others as part of the block.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> (cherry picked from commit 1d64624243af8329b4b219d8c39e28ea448f9929)
> Signed-off-by: Lee Jones <lee@kernel.org>
> 
> [...]

Here is the summary with links:
  - [linux-6.6.y,1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
    (no matching commit)
  - [linux-6.6.y,2/3] HID: pass the buffer size to hid_report_raw_event
    (no matching commit)
  - [linux-6.6.y,3/3] HID: core: Fix size_t specifier in hid_report_raw_event()
    https://git.kernel.org/bpf/bpf-next/c/4d3a2a466b8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


