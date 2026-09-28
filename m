Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08148A8C8;
	Mon, 28 Sep 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616683; cv=none; b=n7+fuDYMGLQXu34xkSJ0pHD/RlJijrSQwzcY6Fk+RsT20oDVSj/Y6Tz86inRjgEGNU9sIGpWjhNYE0JtPAFPjrfYX4CUD2ESp07JLbzOt9dfV9qiPbQYo9BvdWb/M5FpfIIP81kkpac4bhAwObxeu9LSkVEelKCpIfjJkmeE+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616683; c=relaxed/simple;
	bh=10M2Fovlnw6ntLeYI0CF4Uv9gQXDIHADACGer0e1JMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=byJt+TKqMluoMUrLdrT9yb5aGiV309GO69me++2bMfhgGo4BOfOFeLaPB1yeR7hd5MZ8FOddn6DgXqUymsSuAQuoAeW+Id/K2vOhiorqKHx2NNqO1QV1swfSkKfA3+cD35sTtUCufyfGZGPUxUV6KQemZ+4yoTamKde2XDOSYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiJXpEY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiJXpEY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42771F000FF;
	Mon, 28 Sep 2026 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616681;
	bh=MK8QA8/oXI+h5EJbxl8CPDpwvDLqlCdIC1oiRys19ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NiJXpEY+1kLOKlvlrrjYFL/XGXYiLZKgdumbPKrdBo0p7tDNyxZ0I05iDd6gu/zBh
	 6mSfBA+yh04tXz7ORrzKj+t+f9yiMwYA0ydjmCTrpE2wzfKolKdXsrYK4YtZwuGgvD
	 VauUcq7KMUTF5BFqzAPR6F3WRtaEmKuNaUOQgnCi0NsUhd9hdrPx7PgjKPAAAaItte
	 hApQ3NBnRrGgLfqEAyHXg6Ezx/hM+7s57yIyfIneAV+EmvjYOlxFjF0dS2cVbY4G2W
	 wWjmeCJutiiB3PD1zbTidZBwCPjfokZsAyWbDM0k8/UmqB9EpG0tb5ktwfz3njTDkP
	 V5BY7u3iJ23nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D63924A68;
	Mon, 28 Sep 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: free the skb when the DLC has no
 owner
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061660640.34603.9560704992810045042.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:30:06 +0000
References: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
In-Reply-To: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
To: Maxim Skokov <skokovmaksimevg@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikhail.v.gavrilov@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 10:00:46 +0300 you wrote:
> rfcomm_recv_data() hands the skb to d->data_ready() and returns 0
> without freeing it, so the callback owns the skb from that point on.
> The tty implementation frees it when the DLC has been detached from its
> device:
> 
>   static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc,
>                                     struct sk_buff *skb)
>   {
>           struct rfcomm_dev *dev = dlc->owner;
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: free the skb when the DLC has no owner
    https://git.kernel.org/bluetooth/bluetooth-next/c/9d1afbf60ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


