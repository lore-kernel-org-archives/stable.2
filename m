Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588065478D;
	Tue, 23 Jun 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230377; cv=none; b=QkkseMN/mKe9kphHiORXU110new5Mu2e0WQ3Zgs2Oe+yTSOfmXLOqlibYSF5Z5ufgdzTPxaxvBajwttrx7AokYhG7JnDt6p39ridkV9J7+DAXrccmYbmB7hjFVdYqO6MlU7zbKXHTc9obn3shSud4UEkwSYYypu9XdQBkvPqrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230377; c=relaxed/simple;
	bh=3YbxOkAFmrrWFrmx4lKEWGRhnfP2EL+6MR25TY9MDhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/VW6AyT2yfWaEDANTiTVr8l0C6fR9ixgtt8dTu3c779AttBgfLURABAf3f3Zz7b6rUEcwJcW+4MbSoTLZ2sn1ITujl7pMABLRHMdLxhXTkyKgVZCW7JgE9T4CoiDBf0LxASq9GWZA7JRdaecZcyB/gbenXbvLmwvfPKtOtteXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBNgyJsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBNgyJsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD75C1F000E9;
	Tue, 23 Jun 2026 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230376;
	bh=vLtVFSmBuhYWJsbQwd3uD5Ya7gbzMbUajH/IUCeuC7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oBNgyJsjV4puyRG3/LGiFkqJx28rxvjqq2eOLbrYuRYnRFJgklCTlDEXQu9bpQ3LB
	 q009GD0lS8ypf7LEQBh+038bHWNQ/+7/rdn22kz63Su4neeVBdnQiD5DLdmnjfLDde
	 6dzGKrnSCoJuy4N8yw/QFCuZDNxWNo3HcuHUplOLxKX4l243WLM5AP/qHb0y+KPZN1
	 MDqKEaoh66XGgHx4Wo60Ns9C2yMLFhKEPstAvcnsfikeyqC+zFzZHBk5B3hub4P3pk
	 mMBw2zUUM/RhZyMbO3p0DsBltGQVHZWWSo0sd1rQwZ4hpkJbRJf8/c2AWWmqw3ycZR
	 yA5gVbScHwZhg==
Date: Tue, 23 Jun 2026 17:59:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: w15303746062@163.com
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: fix hardware state machine corruption in
 error path
Message-ID: <ajqtEIAX_D5z_UW5@zenone.zhora.eu>
References: <20260512093534.348655-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512093534.348655-1-w15303746062@163.com>

Hi Minguy,

On Tue, May 12, 2026 at 05:35:34PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> A severe livelock and subsequent Hung Task panic were observed in the
> i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
> unconditional hardware register cleanup in the error handling path of
> i801_access().
> 
> When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
> controller is actively used by BIOS/ACPI), the kernel does not actually
> acquire the hardware ownership. However, the code jumps to the 'out'
> label and executes:
> 
>     iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
> 
> This forcefully clears the INUSE_STS lock and resets the hardware status
> flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
> transactions and totally corrupts the SMBus hardware state machine.
> 
> Consequently, all subsequent i801_access() calls fail at the pre-check
> stage, triggering an endless stream of "SMBus is busy, can't use it!"
> error logs. Over a slow serial console, this printk flood monopolizes
> the CPU (Console Livelock), starving other processes trying to acquire
> the mmap_lock down_read semaphore, ultimately triggering the hung task
> watchdog.
> 
> Fix this by moving the 'out' label below the hardware register cleanup.
> If i801_check_pre() fails, we safely bypass the iowrite8() and only
> release the software locks (pm_runtime and mutex), strictly adhering to
> the rule of not releasing resources that were never acquired.
> 
> Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
> Cc: stable@vger.kernel.org # v6.3+
> 

Please, next time don't leave a blank space in the tag section.

> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The patch looks correct to me, although I'd have liked an ack
from Jean.

I merged it to i2c/i2c-fixes.

Thanks,
Andi
