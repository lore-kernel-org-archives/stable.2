Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=145.239.82.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377687;
	b=HQIHv/9fa0+aws/hSOKwVj5VZCQ4fkr9XbDm2voDZEPehMDstwnL1uYwyVTxhvGu5GhT
	 jm/V5VyXE7GLZeZ/jO6GktedGb3L0zQ5JK165/j5MnaWZrScaqzQR6XNEG8pFZLgt1+Hs
	 cDTFl5xupnhF1//EEbQS9Csu4mlzwvqhRK2T5Dud4HqzqpMLLLrDtLoTd8EBgxRW9P/oA
	 dQ9FLAeYccVW7tB01SNXMjthMxr0ajciv6z8c7oQ4bdmomJZK188D/vuOe1sMaPPXyZFf
	 Ia4gS6pvqztDOyf/7iStDWheKNXzCAjxIr3LNGwHWSVEwjuGGPls8DjWdiVhuFzBQzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377687;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 Disposition-Notification-To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Sender;
	bh=0/6M+JTM3dINWlMae2cUvXu/c1hGJdmRRNabsHePMrY=;
	b=jMdfG2gCXeh9bQAuRCnDbFlEAV7yn7M9vtN7Bc6mAnemMOg+Zw/AT3hiOiKXIxsuOIDa
	 JEM4sVlZ4mmZ501XYlqBeu7MhYRVDgNmbFc2yt9JBqJ0OZQojMgQyVwd3702PnSqmmah0
	 aCo4+kMpsXInk2EXkvkVh/CG4d+vwQZuZADc+eGuVjtDO0oumSr3Mr/Oubd/Bw+wTH+Hv
	 vQlnfrRzDamrlkt57TEUW794YCjctIeJRcr0n64PKobaENcXnuD8prX4dh8lupEjnoYGR
	 dgVEqOPeLvYun+eHVjr/BOLl+g2Lq250dIdblu6gCl8HuxAGskGJu3S6oPT2H5YPH7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=maciej.szmigiero.name;
	spf=pass smtp.mailfrom=vps-ovh.mhejs.net;
	arc=none smtp.remote-ip=145.239.82.108
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E35606A31E;
	Sun, 22 Nov 2026 20:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E35606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1xVDkM-000000014eN-3x9X;
	Sun, 22 Nov 2026 21:01:10 +0100
Message-ID: <925a4f3f-95bb-496e-be19-abf96af34d89@maciej.szmigiero.name>
Date: Sun, 22 Nov 2026 21:01:05 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wwan: iosm: always send the host sleep message
 on suspend
To: David Westen <davidlwesten@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, m.chetan.kumar@linux.intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261122050039.861287-1-davidlwesten@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <20261122050039.861287-1-davidlwesten@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 22.11.2026 06:00, David Westen wrote:
> Unless the BIOS reports D3L2 for the WWAN slot, the suspend callback
> only rings the FORCE_SLEEP doorbell, and resume the FORCE_ACTIVE one.
> Neither waits for the modem. The driver doesn't keep the device in
> D0, so the PCI core then puts it into D3hot anyway. An XMM7360 in a
> ThinkPad X1 Carbon 6th gen doesn't survive that: after
> suspend-to-idle its execution stage already reads CD_READY when the
> resume callback runs, and the first port open fails:
> 
>    iosm 0000:03:00.0: PORT open refused, phase A-CD_READY
> 
> The modem then stays unusable until an ACPI reset.
> 
> Send the ENTER_SLEEP and EXIT_SLEEP host sleep messages on every
> system suspend, as the D3L2 path already does, so the modem knows it
> is going to D3 before it gets there.
> 
> This ignores the BIOS RTD3 setting for system suspend. The setting
> only selects the sleep protocol; the PCI core chooses the power state
> without it, and here chooses D3hot, which the doorbell protocol
> doesn't survive. Honoring D0L12 literally would mean keeping the
> device in D0, as commit f4dd5174e273 ("net: wwan: iosm: Keep device
> at D0 for s2idle case") did. That was reverted, D3 being the expected
> state.

I have mixed feelings about this.

Your platform specifies D0L1.2 as the target state so I presume that
is the state that the platform expects the modem to be put into?

The reverted commit f4dd5174e273 on the other hand always put the modem
into D0, which was incorrect in a different way - as, for example, my
platform explicitly requests D3.

Could you try the reverted commit to see if D0 actually works for your
platform?

> With this change the modem stays in RUN through 2 and 10 minute
> suspend-to-idle cycles, and its data session keeps working. Platforms
> that do well with the doorbells now use the messages too.
> 
> Fixes: be8c936e540f ("net: iosm: power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Westen <davidlwesten@gmail.com>
> ---
> 
> Notes:
>      This is independent of my S3 series ("net: wwan: iosm: fix S3 resume by
>      re-binding the driver around it"), which leaves suspend-to-idle to these
>      callbacks; it applies with or without it.
>      
>      Maciej suggested forcing the D3L2 path for suspend-to-idle earlier and it
>      helped another XMM7360 user with the same CD_READY symptom:
>      https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/work_items/992#note_2938256
>      
>      Tested on an XMM7360 (ThinkPad X1 Carbon 6th gen, BIOS reports D0L12)
>      with 7.2.15 and a debug build that forces the D3L2 path, which is what
>      this patch does, logging the execution stage and the PCI power state.
>      Starting from a fresh ACPI reset, the doorbells left the modem in
>      CD_READY by the resume callback after 2 minutes of suspend-to-idle.
>      With the host sleep messages it stayed in RUN through four cycles of 2
>      and 10 minutes, two of them right after a fresh reset, and ping over
>      wwan0 still worked afterwards. The modem and its root port went to
>      D3hot in both cases. This patch itself, backported to 7.2.15 on top of
>      my S3 series, then passed a 2 and a 10 minute suspend-to-idle cycle with
>      ping working after each, and S3 with my series still works. Built with
>      W=1 on net/main. Not tested on the XMM7560 or on a platform where the
>      doorbells work.
>      
>      The investigation and the patch were done with an AI coding assistant
>      (Claude Opus 5.5). It read the driver and the earlier discussion, and
>      added temporary debug logging to record the execution stage, the PCI
>      power state and the messages around suspend and resume. We wrote the
>      change and the changelog together, and I ran the tests.
> 
>   drivers/net/wwan/iosm/iosm_ipc_pcie.c | 21 +++++----------------
>   1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 49052eb511ba..dd7cfe3747ef 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -406,14 +406,10 @@ static int __maybe_unused ipc_pcie_suspend_cb(struct device *dev)
>   
>   	ipc_pcie = pci_get_drvdata(pdev);
>   
> -	switch (ipc_pcie->d3l2_support) {
> -	case IPC_PCIE_D0L12:
> -		ipc_pcie_suspend_s2idle(ipc_pcie);
> -		break;
> -	case IPC_PCIE_D3L2:
> -		ipc_pcie_suspend(ipc_pcie);
> -		break;
> -	}
> +	/* The PCI core puts the device into D3 whatever the BIOS RTD3 setting
> +	 * says, so the modem has to be told with the host sleep message.
> +	 */
> +	ipc_pcie_suspend(ipc_pcie);
>   
>   	return 0;
>   }
> @@ -427,14 +423,7 @@ static int __maybe_unused ipc_pcie_resume_cb(struct device *dev)
>   
>   	ipc_pcie = pci_get_drvdata(pdev);
>   
> -	switch (ipc_pcie->d3l2_support) {
> -	case IPC_PCIE_D0L12:
> -		ipc_pcie_resume_s2idle(ipc_pcie);
> -		break;
> -	case IPC_PCIE_D3L2:
> -		ipc_pcie_resume(ipc_pcie);
> -		break;
> -	}
> +	ipc_pcie_resume(ipc_pcie);
>   
>   	return 0;
>   }

Thanks,
Maciej

