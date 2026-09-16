Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDA3DDDDA;
	Wed, 16 Sep 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581721; cv=none; b=OoqTERO768m/ZCamfGaQA3MkV/kiy44fMd+39c7BPzndAa7zJZQ9CHYVFbxMegeMFuOVHf91fR+ZljcpcmkDTEn80McQW2wNG/WsF4vcRuIaVfivdn3X2HNALTuF4xr/7V0IrgQe1L0M9NTTB7TSXcH8tQS3orDpvZmVYxGIx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581721; c=relaxed/simple;
	bh=DfWCFbsSPpm0URF+KRuwEGTvUaOgTaN9A4ckOJZyvBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HF58zmlFi37boM5/RBCL5jwLN5hvegXZkAfyOdC8VxN/aTomn9NPyOzoes0y5mYkpGCYAG56mMQnkn8P4XmsMAoO/JrgW0HHEVLOE7TdcXcrRqv41v/wO5/PEJ1tsVKCMA6Q9MZuoxlhEVq3a2ZLp58EKYm8EW674byns1fPaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocg5Gt4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocg5Gt4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E741F00899;
	Wed, 16 Sep 2026 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581677;
	bh=bIyOwrjPfbmrRMi2w4jcPe+JYruq0wx58L1aeao4P+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ocg5Gt4gVQ8HgaNxQVMNhPKC5I5pU7AM4A38nFHDfAq0CrwfLk8FRPzLFdcxdfZI/
	 SMT9yDHG/36znz2eC6g80ijpgBaN2ATgTmpuD98lpS79WFhwxUr8Vv1nWLcoI9TgR8
	 maurqLTvOTFct6na+QV2cl4ydzi3cX4g75Tw4+jRxaWnBQD9f5UOQsqFddGU9zJpHs
	 VWkOE60iYtDw8ZBMMsPVY40WNp+XksCUaOXpkAwSDobMDWM9pr6E6z+bk4ysdaX015
	 Cp5Wh0kghZ8gR1YfmRJIcR7aoyGpGTNIG09rF4dRShEBkOiFnN3ZvcOSHgdET+9k2A
	 Z/JQo5H/5Hamg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A1439E8A50;
	Wed, 16 Sep 2026 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: validate frame length before control
 and
 FCS access
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958161172.2777538.14752466072656228056.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:00:11 +0000
References: <20260915160239.3106697-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915160239.3106697-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 13:02:39 -0300 you wrote:
> l2cap_data_rcv() unpacks either a two-byte or four-byte control field
> without first ensuring that it is present. A short ERTM or streaming-mode
> frame can therefore cause an out-of-bounds read.
> 
> There is a second short-frame case when CRC16 is enabled. After the
> control field is pulled, l2cap_check_fcs() subtracts two from skb->len
> without checking it. If fewer than two bytes remain, the subtraction
> wraps; skb_trim() leaves the buffer unchanged and the subsequent FCS
> load reads past the logical end of the frame.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: validate frame length before control and FCS access
    https://git.kernel.org/bluetooth/bluetooth-next/c/6c78a213d907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


