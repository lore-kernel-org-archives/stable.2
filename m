Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511135;
	b=MsttLBSqQj2Buqqp6ZY3M7MBuqx8x6Q0oiSJ3Iiyu/q/2P0/0kmWH4IH/yTfA4nfxJ//
	 0i/T/hwU2+txLRYg4oCKq+3zxP9gUhgqr/CIf/yyFTqhmTJFKCIdiAyM2F4thwU2O85FW
	 1chNNcH/kGzQI/2msGm/gw00yDBvXKXY5Brt1BF3QPWt/L/CPunHxTKxkO6oeeiGMhbS4
	 zQoEu63XobTc0Vrcr4FEfqAoXYyx04JGs1xxEIcNErqeNlxFYipBnCTopODVFyzl9bbWp
	 9jaGkTUUDG9AKN7oGWuLig3rnNC93j3XVTUtlOErpTZW6reHtSvh+C25DFzoTNxmmXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CQ4jB6tQUPZO6LegxC5SlNkrSZPGnxBmx2fZBvCkj0k=;
	b=eclvn7TUsNaTYk4/gzryvL83vUCdDGevI7mUCp5yVvZBUKlR+Mzz+LWdZ82QU2W81YHK
	 HEbG/y6WzQVP2iqxnFTo6WXjLer3FTCFQYU1ORd6MqWHS4Ol1tIHXO+cU/mJ3jXgKLXJ/
	 Wg2CVBLjeecJtqM5QpvmXzgm6jVrKUQ2fUfsQkAfiYxrc6GE/DA2q7USJHll5wVn4SXzq
	 QTTduXuEzohiuBfDn/ztePMhBy/jyqIhtfZFR+8bZILST00YmkZSOL24LKxIK/A3vC1f2
	 psj8Os4oMXyr1nRYFf3it5svTsTboz4ESIEwT93z2H541trSkZObmZwCSiVmofRcWig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c31W9LJE;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CD606A898
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3CD606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c31W9LJE
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed02a00b24so1470535ad.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794511134; x=1795115934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQ4jB6tQUPZO6LegxC5SlNkrSZPGnxBmx2fZBvCkj0k=;
        b=c31W9LJEm/rJlOmg3G7E+RY1tN7urBRlM4HSAXf9YPCezRBo13fAas5ICf5qREGHjB
         Nm/ZlTvnwm11PMejW60ZMX2vzCxpSdGtpzxRj3Z3IFADHswau77Dnfo2qcpcP4jF9vbm
         c6CRoD9EKIX81q1tMB8estKUtK4k9JZu13wnIJ6SlgCFmdVIJqS8f9kIkiVeD3loIr1X
         qnI05BnMvjDlOfEmNcZckkEpzfp4BCulggFYTea1upSYnc/aMaN+JF2x6mnD1o4RERzq
         iMW4iOVgH7qtVdCkR9NHzT2v2Hu4A41PjNEY+EBXBB/YBbBHxzt/hArnd9SHfnZ4lKdh
         o8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511134; x=1795115934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQ4jB6tQUPZO6LegxC5SlNkrSZPGnxBmx2fZBvCkj0k=;
        b=T1DmqHxZnVZSkNk3rY70A7j2CSZqtv/Rcf4s2KtV7ktlFtPXoTsjdCjPiVHuTVDPwI
         aJIllCY8Hcd+ujqsHLWpVPxznVsfENjFkTm1rC/LRqCZJ7LcMUuEH097QsvS/cjp5X64
         SQvzjT2eD+vxy3fRkafDLGW3tredrHqPK6YqcalEy+BntCf8ZsvJq12COHLvsuD0ii+w
         /clXL9tPz6g/nPGancSVlOcvMtITL2bZ2eeb25udbbEFhdJFT4X/hW1zddMx46NHH+AL
         oMUeb7WmtBAeoyGCC6puBxCr6cZ+4eo9oeWtbGYo+5S5vql8bnxyighOG7a3zK6ghg/8
         qm4w==
X-Forwarded-Encrypted: i=1; AL+hErGT4V3PXv5PfVjhce2DggCSU1gmJoapWHGfEfv66BM6Bnv6CzcZNwgJmU38eD7p98R8pyOmT6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lA1KzNDkLqk0p/rGVFiSHTAMgUrP/PSOMUSn5cuks/IkALVNw
	yAYxchIdvlneNOc3YMdB+3wgQbXjDVhLwtaBimTQuRlTVKOJntkmGU7vDW0zGUuiH8bGlg0Q84X
	xXygNjDcALg==
X-Received: from plbkl7.prod.google.com ([2002:a17:903:747:b0:2eb:3675:626c])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230d:b0:2ed:e35b:7ef
 with SMTP id d9443c01a7336-2ee0dad1302mr3283865ad.29.1794511134118; Thu, 12
 Nov 2026 11:18:54 -0800 (PST)
Date: Thu, 12 Nov 2026 19:18:50 +0000
In-Reply-To: <20261112160448.41566-2-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112160448.41566-1-lui2012qwq@gmail.com> <20261112160448.41566-2-lui2012qwq@gmail.com>
X-Mailer: b4 0.17-dev
Message-ID: <179451113091.3909038.17914676412025517919.b4-review@b4>
Subject: Re: [PATCH 1/4] usb: musb: cancel irq_work after masking interrupts
 in musb_remove()
From: Neill Kapron <nkapron@google.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: linux-usb@vger.kernel.org, b-liu@ti.com, gregkh@linuxfoundation.org, 
	nkapron@google.com, tony@atomide.com, bigeasy@linutronix.de, balbi@ti.com, 
	shimoda.yoshihiro@renesas.com, robert.jarzmik@free.fr, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

> musb_stage0_irq() can schedule irq_work while handling stage-0 USB
> interrupts, and the work can also re-arm itself from the session
> recheck path (musb_pm_runtime_check_session()).  musb_remove()
> cancels irq_work while the interrupt is still enabled and the IRQ
> line not yet freed: an interrupt landing after the cancel re-arms
> the work, and musb_irq_work() then runs after musb_free() has
> released the struct.
> 
> Move the cancel behind musb_disable_interrupts() and synchronize the
> IRQ line first, so no handler can be running or re-arm the work past
> the cancel.
> 
> Found by static analysis.
> 
> Fixes: c5340bd14336 ("usb: musb: cancel work on removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> ---
> Build-tested on x86_64: musb_core.o compiles clean
> (USB_MUSB_HDRC).  No runtime reproducer: requires MUSB-based OTG
> hardware.  Fix written with AI assistance.
> 
>  drivers/usb/musb/musb_core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 73ac25f53698..c71d0c7f1bcb 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2630,7 +2630,6 @@ static void musb_remove(struct platform_device *pdev)
>  	 */
>  	musb_exit_debugfs(musb);
>  
> -	cancel_delayed_work_sync(&musb->irq_work);
>  	cancel_delayed_work_sync(&musb->finish_resume_work);
>  	cancel_delayed_work_sync(&musb->deassert_reset_work);

Shouldn't all three cancel_delayed_work_sync calls be moved to after
synchronize_irq? Seems like these other two work queues are subject to
similar style issues.

-- 
Neill Kapron <nkapron@google.com>
