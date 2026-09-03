Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703050AC15;
	Thu,  3 Sep 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465686; cv=none; b=bXVUfC2vBjO0kVzGk1pzF0oAKRmZE3XsUDocwjysy34GQFORow5q9QYTTAJiRcm+mTZmGS1Ny4g+lIHHiLk885P/iZ3pJuI1iJnfHR1H2YQIIS/xb2Fg1yCl6uHZ2dabF4I8MJzS9BgQdxrNIsWHCwI4Gby24iUkVNKEXVuCS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465686; c=relaxed/simple;
	bh=LXnH0ZN1HhPwUU8mTOsCJ4PUsBk4jRPx1Jxc/NOoYUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bQk9sA7QCjvK/WowOlQJ/z1UBGpRFae9QR8680PwUdHpmsq6Bizqo8AIBDXRMg6ynwzT7Fiq4b1o6Rs6mfiaLKmgVqp9AMlco3SZxtnDUrAYngU1yKPWLePlBIeztO60fiHxFdlMMCI1YRj5FIb83ShQHvQewxqcApiw20Wdcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeWEQ3C6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeWEQ3C6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388451F00A3D;
	Thu,  3 Sep 2026 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465677;
	bh=b0SuZZ4iPWoduJ2a9lGngkDiZTGkTHOO9kdnEWZx+mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OeWEQ3C6Ae917cWWpITHL+caUrfLNXQcnrQZSOjj4jT2N81qDb1DFS4OmprPYG647
	 dUVHyIbXPkaDYnqdMiKa3XggJhxFLKUTKfMhmABh3FZCC/IjSMk7gaepOX4sTMxjln
	 8ouvIoC1xuMuJ3GfUHNz4AXrmWjY24InBY4SVeMzIL5HDcB+uEIwPhZGThmjE4YO5b
	 QUrVGoG9sg3IlmEBSZMu9mg7T4eqxvcuCjjH816Bg7Rc+W7Ombdy9pjslJl1eWxP9m
	 CZvqXJ78ZhAdHiMgudAzXceQ69zdglG2j8XorZy0Zi6vkH9U+K6m+GzNaBgIkaiASb
	 SuW3QMWks5+Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A707B38119DE;
	Thu,  3 Sep 2026 20:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Don't leak return code when parsing
 firmware format v2
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846561855.3994681.6237344995216592209.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:18 +0000
References: 
 <20260903-btrtl-fix-patch-sec-header-rc-leak-v1-1-0ce37e2149bd@rong.moe>
In-Reply-To: 
 <20260903-btrtl-fix-patch-sec-header-rc-leak-v1-1-0ce37e2149bd@rong.moe>
To: Rong Zhang <i@rong.moe>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, alex_lu@realsil.com.cn,
 max.chou@realtek.com, allen_chen@realsil.com.cn, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 03 Sep 2026 03:18:59 +0800 you wrote:
> When key_id from chip is zero, rtlbt_parse_firmware_v2() intentionally
> ignores all security headers. However, the implementation simply breaks
> from a switch statement and leaks uninitialized return code `rc' (if the
> first section is a security one) or the previous section's `rc'.
> 
> Fix it by really skipping a loop with `continue'. For consistency and
> readability, also do the same for the default case.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Don't leak return code when parsing firmware format v2
    https://git.kernel.org/bluetooth/bluetooth-next/c/0aab041d532f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


