Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=145.239.82.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377687;
	b=IEAFmaC7c0CE+4QLcArsQzhcGT2XdcBnhwTdzdro+H5QHd8XxL1mBNMkn2Fx30XMjBI2
	 nukvqVkLLsn7oK0vt/sB1y2ib0X/m035pJ2E7EorOrjjOl1j1LzEdDLN1LwWf3aGAC/mu
	 Z+hQKVxPBYLGhufFTl5liqxZ1+kEFiiKVtoMPX2UNoH0A3SmNrvyw3vtZgE2UltKLI3zV
	 ggl3tfkBTCflLfdyXQq1lznoG5OvkIdN5mjZembxw0SgC+68uc2Nt2+lMjvZA+9gaIil2
	 KJUNSF2I+vY1ZxBYSkQPOzNBOSnQSNJdcc+3CMEwOhxRtxUgw/WG4naz3taY2VGxayQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377687;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 Disposition-Notification-To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Sender;
	bh=+FkGnM2fnU0IKINvnoMfZCIIgvS7HvGvB/+EcCAgPi4=;
	b=Iiw8vLApl2xwVGHSaM8MOurVq9jy7a+O4O517oKIMaDW2EEnwaqID3O2T6wLOxSXf4L4
	 Il8oXZ7+oY0ijQ/ByuhK7/bOFNywGRXKYRAglcxi1qcAkoCsyfFLryyOzOrLyS+YmLZo/
	 aRv+fH76vJId+auHHtNpv9DaZwjWADB9tZvQHPIi14MFnLDtMEjQYYtT0lCFI7WKn9Rv2
	 xBm4q6Q4Iu3yrdo2tSk2h9PFntHW8TX9LEN81oszYcJJomahitZsUKGLahznxikMJbhGS
	 hol3RSXhSQJe6SeXLlttZqAOwRVJDboIJeJCxLqwvRKBEf+ljTyPooge7SJxUchESug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=maciej.szmigiero.name;
	spf=pass smtp.mailfrom=vps-ovh.mhejs.net;
	arc=none smtp.remote-ip=145.239.82.108
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE5606A320;
	Sun, 22 Nov 2026 20:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55EE5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1xVDkP-000000014eN-1meP;
	Sun, 22 Nov 2026 21:01:13 +0100
Message-ID: <5651d569-d291-48e1-b38d-8cbdb2c2f0a8@maciej.szmigiero.name>
Date: Sun, 22 Nov 2026 21:01:13 +0100
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
Subject: Re: [PATCH net v2 2/2] net: wwan: iosm: fix S3 resume by re-binding
 the driver around it
To: David Westen <davidlwesten@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, nihaal@cse.iitm.ac.in, stable@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261119042714.505405-1-davidlwesten@gmail.com>
 <20261119042714.505405-2-davidlwesten@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <20261119042714.505405-2-davidlwesten@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 19.11.2026 05:27, David Westen wrote:
> On platforms where S3 cuts power to the WWAN card, the modem boots
> again while the system sleeps, but the driver still treats it as
> running. After resume its execution stage reads BOOT, and by the
> first port open the boot code has crashed into the CD_READY stage:
> 
>    iosm 0000:03:00.0: PORT open refused, phase A-CD_READY
> 
> The modem then stays unusable until an ACPI reset.
> 
> Unbind the driver before S3 and bind it again after resume, as
> commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by re-binding
> the driver around it") already does for hibernation. The driver is
> then torn down while the modem still answers, and the modem is probed
> again once it has booted.
> 
> The target state isn't known yet when the PM notifier runs, so the
> default suspend mode decides: the driver is re-bound unless "mem" maps
> to suspend-to-idle, which keeps using the suspend/resume callbacks.
> This changes behavior in a few cases:
> 
> - On platforms that keep the card powered in S3, the modem is now
>    probed again on resume, which drops data sessions and recreates its
>    ports.
> - Entering suspend-to-idle or standby explicitly while the default is
>    S3 also re-binds the driver.

I think this re-binding should never happen on s2idle, even though S3
might be the default mem sleep method.

It looks to me that the only remaining case here is the "opportunistic
sleep" code which does not use mem_sleep_current (so won't be covered by
pm_suspend_default_s2idle()) - but uses autosleep_state instead.

> - A suspend to S3 that calls pm_suspend(PM_SUSPEND_MEM) directly while
>    the default is suspend-to-idle is not covered and fails as before.

Are there any such pm_suspend(PM_SUSPEND_MEM) calls in the kernel (outside
some test code)?

> 
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Westen <davidlwesten@gmail.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - New patch before this one: cancel the ADB timer in ipc_imem_cleanup().
>      - Describe the changes in behavior and the remaining limits in the
>        changelog, and say in the comment that the modem "may" lose power.
>      - I also tried detecting the power loss on resume instead; my reply to
>        the v1 review explains why v2 keeps unbinding before suspend.
>      - Correction to that reply: the XMM7360 here does use MUX aggregation
>        (CP capability 0x300), so the ADB timer is armed on it too.
>      
>      v1: https://lore.kernel.org/r/20261116031148.333990-1-davidlwesten@gmail.com
>      
>      Tested on an XMM7360 (ThinkPad X1 Carbon 6th gen, deep sleep) with this
>      series applied to 7.2.15: the driver is unbound before suspend, and
>      after resume the modem is probed again and comes up without an ACPI
>      reset. Not tested on the XMM7560.
>      
>      The investigation and the patches were done with an AI coding assistant
>      (Claude Opus 5.5). It read the driver and added temporary debug logging
>      to record the execution stage around suspend and resume. We wrote the
>      changes and the changelogs together, and I ran the tests.
> 
>   drivers/net/wwan/iosm/iosm_ipc_pcie.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 49052eb511ba..13e81012d818 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -534,12 +534,17 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
>   
>   static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
>   {
> -	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +	/* The modem may lose power in S3 and S4 and boot again on resume,
> +	 * which the suspend/resume callbacks can't handle, so probe it again.
> +	 */
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE ||
> +	    (mode == PM_SUSPEND_PREPARE && !pm_suspend_default_s2idle())) {
>   		if (pci_registered) {
>   			pci_unregister_driver(&iosm_ipc_driver);
>   			pci_registered = false;
>   		}
> -	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
> +	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE ||
> +		   mode == PM_POST_SUSPEND) {
>   		if (!pci_registered) {
>   			int ret;
>   

Thanks,
Maciej

