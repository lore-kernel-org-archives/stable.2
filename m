Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23946A607;
	Tue, 18 Aug 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052055; cv=none; b=YqktrHQyf3SvxQ8Gz8FaSXvj0r+Z2ZQGz9hj0iNvmTnLMKRm9lWewbRKqGT43CxxoGP9MUH6ejlj9KIfJvfrBxJAHmfx2yEn8sfBiHw0QIwCWaemLe15reUV102RVw9aD76yg5zL5IoM6c+AtbqbpCsMcCQ0cav9oW8R1VqQuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052055; c=relaxed/simple;
	bh=E8oVBzZFTC54iQVSjK8cWT01QTEOTgNniR36YRlfbWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i2XovPOsziMMWj5S8OtVIUVUgIiBqAipOY4tc+Lu4JM0O0cCYTY1fTNL2BT2ujCLqF9sx8jQjfdaKaz06BQ2zFmWxfllSqRV1vYrBJVic7vwiqcGweOiV5FXZab0dBKeLADawJl1TTrXt9cLE3qAQz+qWhI3eF77Yv8M6lzllP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFWrqmq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFWrqmq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9771F000E9;
	Tue, 18 Aug 2026 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787052053;
	bh=yR2/vbESTOGTrlA0NejpUt4u/yY5VBbYmiH2teXVvnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CFWrqmq0kJXdmOH2Tbf9Tj26dJvao0x0uzPVzXLDTCQH5np/QbN0Xym7r6ZcHZPvi
	 cr4VCK86/a4V4fW56msRgvztaIezEDPe72AcZbgNOkh6NADhDZxuElw/g/QTmgC74B
	 B2EmUogZucACI9b4jWR0wIQebO/t7xjKAVpKvhVXapQTk+STDFjoatYNamS3Z3U2Tm
	 z610J5k0rHsKqbVkoLDAByi9/n6KiO9i7vSIt0ShASzONRnGhnLUrdvVcDESEN1ope
	 3E6py+vGnbukndbD1Vh9tBB1hOtxx2SRfvclOv5Jodt9nI0EEonbKlTBM67vSo0emz
	 JhtPfFlfpHMaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D091B3926658;
	Tue, 18 Aug 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net/ionic: avoid OOB TX partner lookup for
 hwstamp RXQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178705200565.2032994.16418553734393767214.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 11:20:05 +0000
References: <20260813083705.454897-1-anand.a.khoje@oracle.com>
In-Reply-To: <20260813083705.454897-1-anand.a.khoje@oracle.com>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 abhijit.gangurde@amd.com, sln@onemain.com, leon@kernel.org,
 eric.joyner@amd.com, vadim.fedorenko@linux.dev, kees@kernel.org,
 mheib@redhat.com, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Aug 2026 08:37:05 +0000 you wrote:
> The dedicated hardware timestamp RX queue is allocated with q->index
> equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
> contains the regular queue pairs, so using that index to set rxq->partner
> can read one entry past txqcqs[] and then write through the derived
> pointer.
> Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
> RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
> has no TX partner.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net/ionic: avoid OOB TX partner lookup for hwstamp RXQ
    https://git.kernel.org/netdev/net-next/c/d92255b405fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


