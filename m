Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292253C09F8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053198; cv=none; b=LzWmbB/nvOKz77zc5rqP5jEdK4jDVj5xm3/1YZIAPG1o3imwMVyH6+GBcxrgImVmdHE6P8xdtv0TUqNrtF9yvUqRmVuphTJ+ZBDS7Qjmwu/XWac7N9TNQXMPbvECJSHgTMAHGOHkvjw9BgNPh79kmNArHrsApIgG1h+0AZesxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053198; c=relaxed/simple;
	bh=K/q5U+pGBe9FGuZYGOdKO4tB2k1MgK3HgbJ09Hl64sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRry6r/hh5/ankaSRkA6hKAotP6yJxz3eF8yvsDFOwkO7qv8ZuKPn2nr5yhQtyy2BM122Oin+iYpv0k+u9PTAVOcnd6YvUfY2wbtOV/GvSPAWXWdwq55klVhJRF0KYvpMAhLElMeZhPFONbaNeFATTZ1+Ty6wrZtk2teTLtEXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0R3Iu4b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0R3Iu4b"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso14899105e9.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792053193; x=1792657993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYvKsnw/wo7FP7BSrciic/dcK/Yw81SsbNCEIrV3lTM=;
        b=R0R3Iu4bBtfvEtONOwmPz5f8h1t+gko0nL2i3DBmDtCJ1KInpyiWvkpwbKVpntbTqT
         W7zwSK61mn4vwlW73HQmhBG23MJE5vO9utJrx8kztus5O6rlSVqHkBT/XCeSWaM3uDkb
         BSpxrfImbQAPQsS+KZ8aRc/ni3o1N2714XTlGc+yKjVefrl0TiyBXu/Q/QoZz3Ywm7XP
         Izq7mp5eUQF0G7teHVRYo+bbfz9JxtD/h6QuKKP595kTf18ZEz7JaIE+X7v8xWR6v25m
         A97Qx4lfTVXKQL2IeJYhC/h40+lEPr6e+2FKmv6hsa2c9LqJ9UcjRbouke5Z2zzfOKFh
         Qi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053193; x=1792657993;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYvKsnw/wo7FP7BSrciic/dcK/Yw81SsbNCEIrV3lTM=;
        b=FZeGkdR00rx0R0PaG4sb5/f0hxIf/HqpmtGOFXyCC7x4O+lc+FIU16BsXXe/uz0iuT
         /UlGHw7DEVJu4eQFT7yVoruQ0BVpb4fXvVLKJklvKjx/2TLuF5/WFgibEamGcoE9VHw3
         AR25TUueWxz4Wqt9pnfNXzT8ldGdInGBpclqWJCgXRgRwECqr8GlLPP+Us7zdOCj5khj
         uU+Tu1Kw7D/o3ZT5YWAPFs4szxj0TiWDaYkGJYERGKpwU1w27Uf5Kc+sJToVQmb3w10z
         /pV+rL5kJN3gHtML1U78zKqA04wrBaw8le3Ny3XziSwynihJcFezOdcVJd+NYhWADg8U
         RquQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIyWBQunaqzm3AXiaIBioBm5GREHnKYxG7jAfR6UIszcDKeAjr9NAq8FBT08iPuoLf55V4asQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU5n3u2+0m98KyW4/Zyp8SewmOb5zO7sUVKvfiPoxVzC+z5bsH
	hBpzt+DC707Z0T6GQOEQ2BR1icyHxRg3D5drVFVJM+DlS+oNB0Xas20E
X-Gm-Gg: AYBFou2apeIRgzQn8/e+Md/YU5qXAhyu2QYjFsSWrHOp9UDbWJ2U1tm2PYj1HETggO1
	5IU9Mlq1xSC+VwZ6kCbn2gQkRdjTTzGzemXrxeJaZUIHw5u3hX3Ziu09TxJoeTgZ2ZxHezTz3FC
	GavAbq8uI9BfnsB9AGTbaTmVr18pr2+qheXw2XGRocWHLKWwfYx/A+StDyjQ/imsnQGNYpXgwku
	rn/KzCgvLJFAZTXbD9o7Ipfo2yznk4wCq6LS9Xov/llOuz7wUzZjggDBVI7AsuSTsXeuvN26PHu
	H+ziOGis7Fu2Ta9Bq87ECrUR1za/jVOvF5Qyru897H43dHcg8p3qgHJMCnyFtcl/k0pW5ZE7HVP
	cEFsH5YPN268nyb+8DG6AJ1NHntTHaB03JhmIRFYvYvU3G5fSXm9GjFnPLbKYRmXkb+ZDaKUp2f
	V/H+UEt3QKcFrCyBT04dBPlHUQ7pup3Y4oa5vCZtIqlwrdsMT8znYpcvnpON7WZp/WLxmsH5b9s
	YNrEMZsPA==
X-Received: by 2002:a05:600c:6099:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a18e4e7a85mr348692075e9.30.1792053193202;
        Thu, 15 Oct 2026 01:33:13 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm17881280f8f.47.2026.10.15.01.33.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Oct 2026 01:33:12 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:33:07 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, wenxiong@us.ibm.com, Brian King
 <brking@linux.vnet.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
Message-ID: <20261015103307.3ba25345.michal.pecio@gmail.com>
In-Reply-To: <64515dfd9a6cd8c3f5665e72a6bf6b81@linux.ibm.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
	<20261002102931.3cb06009.michal.pecio@gmail.com>
	<561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
	<20261002161828.365ff859.michal.pecio@gmail.com>
	<55a53022d1c6f671a3ed549d8cf7cd1a@linux.ibm.com>
	<20261006125546.10471489.michal.pecio@gmail.com>
	<64515dfd9a6cd8c3f5665e72a6bf6b81@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 15:32:22 -0500, Wen Xiong wrote:
> On 2026-10-06 05:55, Michal Pecio wrote:
> > Are you able to capture the original kernel's dmesg (through serial,
> > netconsole, etc) and see if the same "Host halt failed" is there?
> >   
> Below is xhci messages after executing a kexec kernel. This is dmesg
> for kexec kernel.

OK, but I asked if you have means of capturing the old kernel's dmesg
*before* the kexec kernel begins running, including any messages from
xhci_shutdown() which may possibly be logged. This can only be done
with a serial cable, the 'netconsole' module or similar tools.

But maybe don't bother with it for now. Instead, try if this modified
version of your patch works or not:

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 34f342d2c7d7..977b2b42bcfd 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -749,6 +749,7 @@ EXPORT_SYMBOL_GPL(xhci_stop);
 void xhci_shutdown(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	int err;
 
 	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
 		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
@@ -765,7 +766,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	}
 
 	spin_lock_irq(&xhci->lock);
-	xhci_halt(xhci);
+	err = xhci_halt(xhci);
 
 	/*
 	 * Workaround for spurious wakeps at shutdown with HSW, and for boot
@@ -780,6 +781,8 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"xhci_shutdown completed - status = %x",
 			readl(&xhci->op_regs->status));
+	if (err)
+		pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
 }
 EXPORT_SYMBOL_GPL(xhci_shutdown);
 
---

> [root@ltc-boston11 ~]# dmesg|grep xhci
> [    1.085853] xhci_hcd 0005:01:00.0: xHCI Host Controller
> [    1.085992] xhci_hcd 0005:01:00.0: new USB bus registered, assigned 
> bus number 1
> [    1.144472] xhci_hcd 0005:01:00.0: Host halt failed, -110
> [    1.144518] xhci_hcd 0005:01:00.0: can't setup: -110
> [    1.144571] xhci_hcd 0005:01:00.0: USB bus 1 deregistered
> [    1.144778] xhci_hcd 0005:01:00.0: init 0005:01:00.0 fail, -110
> [    1.144842] xhci_hcd 0005:01:00.0: probe with driver xhci_hcd failed 
> with error -110

What about 'dmesg |grep -i xhci' (and 'grep 0005:01:00.0')?

You are likely getting errors from quirk_usb_handoff_xhci() as well.
This reminds me of a similar issue reported earlier this year:

https://lore.kernel.org/linux-usb/69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de/

> This is the reason why we can't see usb devices after a kexec kernel.

No doubt about it.

> > And if you enable dynamic debug before kexec,
> > 
> >   echo 'module xhci_hcd +p' >/proc/dynamic_debug/control
> > 
> > what's printed by the debug message at the end of xhci_shutdown()?
> > 
> > Do you also get errors from quirk_usb_handoff_xhci() by any chance?
> >   
> After executing a kexec kernel, is the control setting lost?
> I didn't see much useful information in control after a kexec kernel.

Yes, the kexec kernel starts with a clean dynamic debug state.

> Probably we can resubmit the patch with mathias's suggestion.

We could also try the approach in the test patch above, but doing it
properly will require a few more changes. I haven't bothered before
we know whether this helps or not.

If it doesn't help, it will look like you have something (machine FW?)
monkeying with the chip during kexec. Then we could try fixing some
known bugs in quirk_usb_handoff_xhci(). Maybe this will be enough.

Regards,
Michal
