Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A03DB31A
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341193; cv=none; b=AKVJjf7ZTKE1OuS/EcDMLH5U911/2brAdvJ6TfeQNfXZhV6SBazKXfx6i5qodq7Ld5Lta0No7Rbee3U9bn7ZnRm17EValljkF1aO3UF1QzlF1pe/eyMJ0GLjH3Kc+q/rJlXnmIBGGqzvtQqrHKgdENq+f/ImKQVUQUh7l4ZDuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341193; c=relaxed/simple;
	bh=AJ/km8sE6GctD4RuE/KlvnKKGAXGH2QdqK+ac6g6Ezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE9b+MjfUSJhi9L5u/bM0Aqn91MXQiv01NVnMxivGn4L+ktyOeYgurHAZ9OOwOA5e2O7+WmPJ1kjUCmlI5VSGZJalPOkC0OnaZb2gynvSZKca2KTglhZjGSnGNpfkT5KUfsQTCBq9XUKKQKgmf3/Pjy8bbIZ8S83nU3ru7pYsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2tNA6R3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2tNA6R3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6d28aa26cso4973415ad.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341192; x=1792945992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8lASuEAWr02cFkueHsd07yvRwkaU6dw60ogYfI+giIU=;
        b=A2tNA6R3Vkx0sbAjhxknPHRb+hTU4X5Hjo3H3xLWAypJXOUWqXsLhSaLVZD5AXy4tU
         sj1/jYi+16zV3sW1W/tuFc8zIJco2PgtyAiS+KI9zfpBtASAzOXulIHbMQzmuh4c2OCe
         CGsrQ2LAQfpFEbO/Ni+RT4D8VBFFYL8aMR/gVRYCMAO4ptIk/tXvCSgz5OVSemO1fwgh
         Yc/qoea0n1PfS0ZhXh2cpp1YiTWX5aMsUbYVm7HioD6WbksWs8KQGvHEadH+BtMQ1AT7
         c7RHxtiARNrAKya43R1IGw3Hh+I3KMBZdoM3s5rOR5x35FbfnXc6kv3uIJtKEkO2aKK3
         O0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341192; x=1792945992;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lASuEAWr02cFkueHsd07yvRwkaU6dw60ogYfI+giIU=;
        b=IYfEzDZ7Rjzyb8PFPHhjAEFiXbGrOaArfHcFUfeyKtnLloFJHcjOflrjWqyxFTsAQ0
         UhpUFEJpCAWtwWn99S1JXyJy9LHNLBBCl169rb8KAiTbp7flxcCQApmsQi2maC+3uKRd
         G8gIiHI2AKC5BZxblCdlF8mBxNTYIDaVm8QIdt0UBxSgoZbuaMElZzaT/CYHGHmMS17E
         bGnNeh5/NKmP1PXPePI8U51ZVrT7qlAbCOyDsKqNKe/B70s/aMzJzFIMbTYOzwwCvaIm
         LEDwkxMgKnEGOFaXntcyi3Ou38unRqc9mMg8ot7ROcOghA61zCzRV4ThiZBjlbiZnq1K
         Blfw==
X-Forwarded-Encrypted: i=1; AKwUvBz0VNpyG8hLdd+ysfB+hkKW+kt3STPBMi8Hp0718gZ2LCVBp7HkDkW8BJMMPH/fXQ4WBQyi5wM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCBLa/d+iBdyQFtP35Vj764Lc6I3FmqUgQVTSHMruYDs5bcrIR
	NjVBmI5PwbVHbkKjUZ4SrLvCGDUbkC5fT4IuYVAwYKNXKV1HVvJR8ALT
X-Gm-Gg: AYBFou3KMyJ8fLTTVzQQoLXvu+iknPKZsfPQMTbUw6tXyybDTn6mx+bDtX9i+KAHLEz
	Jc3WMhofb4ustkr6fvvJrzOYWcaLFVlhQtDp8rC9bpzPP0s9eNYGam4fisPa6SmfNHLTrQnTPVz
	T+rUsW28GMHZZxqYREbqLSbe/6kUKr3LQn0oNOUpoj4pa/tAGPnNx1IhR6qbxjKTt7FMPiJhz46
	MZuczcGfz+D9orr6NrVYzgBOX6F5hZ3Zt4W/pWd6qutSOOet4aD6JyW6xs3qFNWu6uKL68zFt29
	sxOjCtjYthXqBrOzUakTxg+5hQ1ADcz+nzmysYaJ02I/P8Pe9Dm/vnR5bR0SYyI75ZSAI67NRHU
	QztLabpaOB0TR3bK3iC16j61y1kq3eVC/M7zvdGi/NdcB1X6kURF5OARLHJzU6iFD2kq9UxcXia
	77NvBVSC1nuFTHCIJoFTccVBDJTkFM5a0O4wHDWmcZIYh6SJmaBJD1xbsxQQ75LxopSbki+Sbdm
	LYzwc/aqjxBG8jOvZD/22I=
X-Received: by 2002:a17:902:e748:b0:2e9:8510:6acf with SMTP id d9443c01a7336-2e9a6bff6c2mr46257275ad.25.1792341191722;
        Sun, 18 Oct 2026 09:33:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e83406bsm29315425ad.38.2026.10.18.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:33:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 18 Oct 2026 09:33:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sanan Hasanov <sanan.hasanou@gmail.com>
Cc: Marius Zachmann <mail@mariuszachmann.de>,
	Sanan Hasanov <sanan.hasanov@ucf.edu>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Savic <savicaleksa83@gmail.com>,
	syzbot+0f98b0c0bdeaab2dc2fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-cpro) Make wait_input_report_lock IRQ
 safe
Message-ID: <0b7c972c-f3e2-41ee-bd75-45bcae83a34a@roeck-us.net>
References: <20261008205310.30832-1-sanan.hasanou@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008205310.30832-1-sanan.hasanou@gmail.com>

On Thu, Oct 08, 2026 at 04:52:45PM -0400, Sanan Hasanov wrote:
> From: Sanan Hasanov <sanan.hasanov@ucf.edu>
> 
> ccp_raw_event() is the HID ->raw_event() callback and takes
> wait_input_report_lock with a plain spin_lock(). This callback can run
> in very different contexts depending on the transport: from process
> context (e.g. uhid, via a write() to /dev/uhid) with softirqs and
> interrupts enabled, and from URB completion, which is softirq context
> for HCDs using HCD_BH and hard interrupt context for HCDs that do not
> (e.g. OHCI, UHCI).
> 
> Taking the lock from process context with softirqs enabled while the
> same lock is also taken from softirq context can deadlock if the
> softirq interrupts the lock holder on the same CPU. Lockdep reports:
> 
>   WARNING: inconsistent lock state
>   inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>   ...
>    spin_lock include/linux/spinlock.h:347 [inline]
>    ccp_raw_event+0x51/0x110 drivers/hwmon/corsair-cpro.c:161
>    __hid_input_report+0x41c/0x580 drivers/hid/hid-core.c:2175
>    hid_irq_in+0x492/0x710 drivers/hid/usbhid/hid-core.c:287
>    __usb_hcd_giveback_urb+0x378/0x540 drivers/usb/core/hcd.c:1657
>    dummy_timer+0xa91/0x4cc0 drivers/usb/gadget/udc/dummy_hcd.c:2023
> 
> For the same reason, the spin_lock_bh() in send_usb_cmd() is not
> sufficient when ccp_raw_event() is called from hard interrupt context.
> 
> Use spin_lock_irqsave() in ccp_raw_event(), since it may be called with
> interrupts already disabled, and spin_lock_irq() in send_usb_cmd(),
> which always runs in process context.
> 
> Fixes: d02abd57e794 ("hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock")
> Reported-by: syzbot+0f98b0c0bdeaab2dc2fd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0f98b0c0bdeaab2dc2fd
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>

Applied.

Thanks,
Guenter
