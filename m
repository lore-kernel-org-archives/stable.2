Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828E43A7FB;
	Thu, 13 Aug 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614495; cv=none; b=uHoBiWueb26mB3M/JrvPjNkGn581Ur2xZW9ZodKnAtJKsKBI+ELz9IDOEUStsrJW47nvkcrq6gQqg+bnTlQxmleJ/fpqhE8N22034gIgcQkk5ozH2AahCygcvePF0HIpS7PjgelAZH1AhkfVxA1WJR5U9XprMRV9ZVU7iHXUrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614495; c=relaxed/simple;
	bh=ZkgIabWGAntWYV6VTTWxAltfFpuWEQZthzTuj84b3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEbzpG8DntJwrydTcDybswIHaCeUnxeHaogmcJzb+KAK58yayYp4KKtZ1X2OcLm527Dnfz7QvvuF5/rEWdGpL69BYawCXPqqEnApNIQLCUHLcOvY/BCmNH5+YG3i5H0DQTsE4KKsSn/vrCdzpZHLamUa5m9HaCFQYvIoJaeF1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwBWDZ48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwBWDZ48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5270B1F000E9;
	Thu, 13 Aug 2026 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614493;
	bh=JhoXw3RFEqzXczfkUaS1se+ToO/5VXgXgifgsnHZJSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FwBWDZ48bk5dHLbMDY/xC9cgKSHnoiBSmLz2DW/DjHR3SoC/+UWOYwmW/2SwQIDy/
	 Uz3svXj01QDzv5EaKfFpdTEBSMGu3fJxifYmaSnHThWIp5kYKq/kPmFqSf56zqiNec
	 nPXJdgshyCALWe2LdgF8XQh410989Wpd5OjRFVgjg2+5uPPVWKWoR/wQbuCDmSVUK7
	 rs5Bk8KOS949QFZLp2927vJteotpJnu4Ermd+AZyum/mFbAhCGla3vyvrTHntAptOZ
	 VsJQ/rmOdC8c1o4sMNOdB9F88KMv9iyF3ZL7ArG3riD7R3UUOwF65Je0VS+4qz+l+A
	 maBhWG8RSLx5Q==
Date: Thu, 13 Aug 2026 02:48:11 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	gary.yang@cixtech.com
Subject: Re: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Message-ID: <an2S2-4J329OIqKb@hu-petche-lv.qualcomm.com>
References: <20260723-suspend_resume_fix-v1-1-c12a0e8eaffc@cadence.com>
 <amgbVsk6ioQQGzat@hu-petche-lv.qualcomm.com>
 <LV5PR07MB113546210770FBED0E2A26E84DDDC2@LV5PR07MB11354.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV5PR07MB113546210770FBED0E2A26E84DDDC2@LV5PR07MB11354.namprd07.prod.outlook.com>

On 26-08-12 08:13:08, Pawel Laszczak wrote:
> 
> Hi Peter,
> 
> Sorry about that. Yeah, I know. I think b4 added that address automatically
> And I didn't notice.

Probably you work at old kernel?

> 
> >
> >> CDNSP controller loses its runtime register programming across S3
> >> suspend/resume.
> >
> >It is not always true, it depends on SoC implementation. For some
> >SoCs (like CIX P1), the controller power still exists when the
> >system at S3.
> >
> >> After resume the operational and interrupter registers
> >> may contain reset values, which prevents the gadget side from recovering
> >> correctly and breaks wakeup from S3.
> >>
> >> Fix this by reprogramming the controller state required for normal
> >> operation after resume, including the command ring, DCBAA pointer,
> >> doorbell base, event ring, ERST base/size and event ring dequeue
> >> pointer.
> >>
> >> Move the basic controller register programming out of the one-time
> >memory
> >> initialization path and make it reusable from the resume path. Also
> >> separate ring allocation from ring initialization so that rings can be
> >> reinitialized without reallocating DMA memory.
> >>
> >> This fixes S3 resume on systems where the controller register context is
> >> lost while keeping the existing DMA allocations intact.
> >
> >With your fix, does device mode wakeup still work, does affect the SoC
> >like I mentioned CIX P1 which keeps power at S3?
> >
> 
> Yes, device mode should still works correctly with this fix, and the
> patch does not break platforms like CIX P1 that keep power during S3,
> but I have verified this only on my FPGA platform.
> We cannot test on CIX P1 directly. but the logic is sound based on
> the hardware register behavior.
> 
> The resume path uses CFG_U1_PIPE_CLK_GATE_EN (bit 0 of
> XEC_CFG_3XPORT_MODE_2) to detect whether the controller lost its
> register context:
> 
> - On platforms where power is lost during S3 (like ours), the
>   controller undergoes a Power-On Reset, which sets this bit back to
>   its reset value of 1. The driver detects this and takes the full
>   reinitialization path. Wakeup is not signaled in this case, as the
>   USB link has been dropped.
> 
> - On platforms where power is retained during S3 (like CIX P1), this
>   bit remains cleared (it was cleared by the driver as part of a
>    previous fix). The driver detects bit = 0, takes the CRS (Controller
>   Restore State) path, restores saved registers, and then calls
>   __cdnsp_gadget_wakeup() if the link was in U3. Device mode wakeup
>   works correctly in this case.

Add Gary to confirm if it affects CIX P1 platform.

> >>  irqreturn_t cdnsp_irq_handler(int irq, void *priv)
> >>  {
> >>  	struct cdnsp_device *pdev = (struct cdnsp_device *)priv;
> >> +	struct cdns *cdns = dev_get_drvdata(pdev->dev);
> >>  	u32 irq_pending;
> >>  	u32 status;
> >>
> >> +	if (cdns->in_lpm)
> >> +		return IRQ_NONE;
> >> +
> >
> >If the interrupt happens before cdns->in_lpm is clear, there will be no one
> >handles interrupt issue.
> 
> I will change it to IRQ_HANDLED. 
> The controller is stopped during suspend so no level-triggered
> storm can occur. IRQ_HANDLED properly acknowledges the interrupt to
> the kernel preventing it from disabling the IRQ line due to spurious
> interrupt detection.
> 

It is not so simple, it needs to co-work with wakeup irq. See 
cdns_wakeup_irq and cdns_drd_irq please. By the way, why you
add above code?

-- 

Thanks,
Peter Chen
