Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655320;
	b=gC/Z8AjLI8gboQwrhR4DlbAg2gMrHBxEHbDk7prx3Lf2cD8rjOtfT9JN1poIkmJtpyPQ
	 A+qPEGxL89yY4YZj1FBneINvTflmyRKPjLnkndVNis3oBmfwBHi9vWyVRgDEgkcxxjx4J
	 E8deK38zXVro4WXgpyGiLAl/uKCH7eYqrWJFsSed4aSAwfAm6JWNN1Br/n8+wk+BYU43v
	 W4sA+V4hL0whBCnSFTEnvTY+Mj2J7+jG0ZD24DmyAPT6nvBeawvH2HtKWjZg1G0WK7dhA
	 7VJ5IrmKwu4DRI+xjDkn7aycR/CkIEmRAXs5sbE6sRuBZXocgrU6RAsYKMu95be9ZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655320;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4Ju039Z2MeKtZH/iwUVos3bdxPP/Y2nZbG4AaFuOPmo=;
	b=oGY9QVC6wkiTFlJvbUpW/IyJkoVJalPqC2N4JCUYcHqqlsw85P1Amf0GGjpcK7wJoa06
	 9NRyuq+f+ubgi4Z/WqXMIy+0/bk6q7CqOu0qyU1Z3bvUbJTeabq7RCV0dXKU+HwzXw0J8
	 gh+NT5lDsyloS/lFCw4aMxCfSrmrTPjoXOyNPTTFoY3JfXXPuC/WXlHd6XprA+ByDfQJx
	 1qw66kBNDugYx8XG54TGb4vxu7FoJakDlSj1OYEm18gmcipPuMuCq3BCwhrMnto77+mUC
	 Ao8ZwYtWqdyxrbhh8+gPdQeFR7/qsiBEFfNC1CwxNAaF3QdLNRkjxMhafOkkUI5Y7nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7i0IZPT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEB606A31A;
	Thu, 22 Oct 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7i0IZPT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB2D1F000C1;
	Thu, 22 Oct 2026 07:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655320;
	bh=4Ju039Z2MeKtZH/iwUVos3bdxPP/Y2nZbG4AaFuOPmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j7i0IZPTqu/H+ishh8ftP0bl8FDaQ0/noRkz8zNxxNEHNTWiZ6B3bai/vF1AlKbM9
	 A+Dujla0LNMWCqokewsm0XNP3h5ty/oS7/HsOcDqeALspyrt7swVOBJboKnmZf06iU
	 QIhx3eobRwRblXVFnQg0pHKC+teUR731EFLXhHZZp777au2NNmrHKQFJ7fYU8UR1yJ
	 tfX/J7TNNoPe5TE4OQlHrSZBbdCHwC1idTl1ZXxEkhhX2D66EaS8t1ibZDV5+yoogu
	 nY9MnxT0L71VUSmw60+Y3MXr2HuIzV+IhZ0c/8AsRgzZvRqyAnalyTq8sCz+BCKwUD
	 DT7GZ7c6fH2yg==
Message-ID: <2099889b-6483-4f4b-bc9c-723159528cd3@kernel.org>
Date: Thu, 22 Oct 2026 09:48:37 +0200
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
Subject: Re: [PATCH] ata: libata-sff: fix race between IRQ deferral and
 ata_sff_flush_pio_task()
To: Niklas Cassel <cassel@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <20261020101107.1449635-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261020101107.1449635-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/20 12:11, Niklas Cassel wrote:
> Commit 4a2e5409472e ("ata: libata-sff: don't busy-wait for PIO data-in
> command completion") allowed the interrupt handler to queue
> ap->sff_pio_task from ata_sff_hsm_move() when a PIO data-in command is
> still busy after its final data block.
> 
> ata_sff_flush_pio_task(), however, was written under the assumption that
> cancel_delayed_work_sync() is enough to prevent sff_pio_task from being
> queued again before the HSM state is reset to HSM_ST_IDLE and
> sff_pio_task_link is cleared.
> 
> The flush runs early during error handling, at a point where the timed
> out command is still active, the port is not frozen yet, and interrupts
> are still being serviced.  If the final data-block interrupt of a PIO
> data-in command is serviced in the window between
> cancel_delayed_work_sync() and the reset of hsm_task_state, the
> interrupt handler queues sff_pio_task after the cancel has completed.
> When that work item then executes on ata_sff_wq after the flush cleared
> ap->sff_pio_task_link, ata_sff_pio_task() hits
> BUG_ON(ap->sff_pio_task_link == NULL) while holding the host lock with
> interrupts disabled; alternatively it proceeds on a stale link while
> error handling owns the port.
> 
> Fix this by resetting hsm_task_state to HSM_ST_IDLE before cancelling
> the work item.  Once the state is IDLE, __ata_sff_port_intr() can no
> longer enter ata_sff_hsm_move(), so the interrupt handler can no longer
> queue the pio task, and cancel_delayed_work_sync() drains whatever was
> queued before the reset.
> 
> Also make ata_sff_pio_task() bail out quietly when the HSM state was
> marked idle by the flush, both at entry and after re-acquiring the port
> lock following ata_msleep(), since a work item can already be running
> when the flush resets the state.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-ide/sashiko-outbox-177477@kernel.org/
> Fixes: 4a2e5409472e ("ata: libata-sff: don't busy-wait for PIO data-in command completion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
