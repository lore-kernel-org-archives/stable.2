Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E504481FA8;
	Thu, 27 Aug 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842398; cv=none; b=AU2EyADyafinHqUXU6r/y7xVoRNpRvdpEJoxDywYhjNL1YANRDwy9Rni1uMj/rCeuktG9Hv7ucbQ3UKsxc/kKNp21Bn6u+HHEddT6HkdTJavRRWp1woFuRKbt8/kZFDVpeR4Dhf3S6LSA0gGmoCP5V3TR6jhygVG+l52piLzDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842398; c=relaxed/simple;
	bh=81QOSb6WHiTKKuL4HTBq9LMB2pHRbvz1D7SZ4iyMt5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLeL837iVqxWWuxq61duGkzNGl+v0hLxZ3XPGOvg71oXRDCyVcx+A9/k331jsXfJtIG9klrrjr9EVocD/aDt9FllXQKzhv03dNM2ith9yidiZliEDXg5SLQmLWxkzyIB7A8T4qp2AXfNA8vlCMEwN7bzZTvNZYp4HULIGBc92E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=X/51bqOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X/51bqOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD5D1F000E9;
	Thu, 27 Aug 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=X/51bqOV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1787842379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0sCK6SUbWHFXdTQsqY/bqP4+Ssz96ab2ersrw+ylnU=;
	b=X/51bqOVZ/euTp5hF3rLnoHGZX97rol+LUHQEvTOnu5HbJobEUwiu4fL+LKVDyx9qOVSlC
	9EvVlqsECxsGxZYFSICDJRjly2+GFAR9zGJDxd+XEV+x/6xvcsjQO76Me0pBdCybiOQ1+o
	xqdDpjLMIuB9eaQyfVJj6iX6Xnkb+Bc=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id d311fca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Aug 2026 14:52:59 +0000 (UTC)
Date: Thu, 27 Aug 2026 16:52:58 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Zhichen Wang <wangzhichen@manus.ai>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] virt: vmgenid: set driver_data before registering
 notification handlers
Message-ID: <apBPSpFLsjlOTcxi@zx2c4.com>
References: <20260825135054.54883-1-wangzhichen@manus.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825135054.54883-1-wangzhichen@manus.ai>

On Tue, Aug 25, 2026 at 09:50:54PM +0800, Zhichen Wang wrote:
> Both probe paths register their notification handler before assigning
> driver_data, which the handler dereferences.
> 
> In the devicetree path, the notification IRQ can fire as soon as
> devm_request_irq() registers the handler: the interrupt may already be
> pending at probe time, for example when a VMM injects the
> generation-changed notification while restoring a guest from a snapshot
> that was taken before the driver had probed (Firecracker does exactly
> this on snapshot restore). The IRQ is also requested with IRQF_SHARED,
> so another device sharing the line can trigger the handler just as
> early. The handler then calls vmgenid_notify(), which dereferences the
> still-NULL driver_data and panics:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.38+ #1 PREEMPT(none)
>   Hardware name: linux,dummy-virt (DT)
>   pc : vmgenid_notify.isra.0+0x24/0x8c
>   lr : vmgenid_of_irq_handler+0x14/0x34
>   Call trace:
>    vmgenid_notify.isra.0+0x24/0x8c (P)
>    vmgenid_of_irq_handler+0x14/0x34
>    __handle_irq_event_percpu+0x44/0x1bc
>    handle_irq_event+0x4c/0xb4
>    handle_fasteoi_irq+0xf8/0x1f8
> 
> The ACPI path has the same ordering problem: the handler is installed
> with acpi_install_notify_handler() before driver_data is assigned.
> ACPI notifications are dispatched asynchronously from a workqueue, so
> the window is narrow, but a notification arriving between the two calls
> hits the same NULL dereference.
> 
> Assign driver_data before registering the handlers. The state is fully
> initialized at that point, so the handlers are safe to run. Should
> registration fail, the probe error path leaves no dangling pointer
> behind: the driver core clears driver_data in device_unbind_cleanup().
> 
> Fixes: 7b1bcd6b50a6 ("virt: vmgenid: add support for devicetree bindings")
> Fixes: e07606713a90 ("virt: vmgenid: change implementation to use a platform driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhichen Wang <wangzhichen@manus.ai>
> ---
> Verified on Firecracker v1.14 (aarch64, devicetree) with a snapshot
> taken before the vmgenid driver had probed, so the injected
> notification IRQ is pending when the restored guest reaches probe:
> the unpatched kernel panics with the trace above, while the patched
> kernel handles the pending IRQ as soon as devm_request_irq()
> registers the handler (/proc/interrupts shows the vmgenid IRQ count
> at 1) and boot completes normally. The ACPI path change is
> compile-tested; the window there is analogous but much harder to hit.
 

This patch went to gmail spam! I only saw it by accident just now.

Thanks for this. I'll try to test and verify this on Monday. Do you have
a handy repro script you were using that you can share? Also, wondering
if you saw this happen in the wild.

Jason
