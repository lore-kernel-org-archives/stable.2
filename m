Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252941A268
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783740727; cv=none; b=KCDddDT2eFKvXgLpqFbTMGtt2TulO/UQLaJaQFEtVkxyxxiOSmqiPSKzqCbR3h22F0MJwhOq/Igt1aOImE8WVbwr2gSTC/nOfTcL+peJnYvBlXXN1cZ0EwaiZAnR4PoPL+LCncE29uEohQxuTVbl60+RrEa1/y0RF/tKXWZLwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783740727; c=relaxed/simple;
	bh=2Xn6iVu651al8KcGkcyVtEVecMtHscc91szy1eS0+M8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bxt31rfSs9Tcpzq6tRzJ4lcj71vaZk5NXkEjPYF7bLcK1sVIoOMqw4qatWbbk7yTPhYHsp/WHqHJrDSd4pyG3s6NVlq4QbtDel/xImkYSSXg1sD/EEQR4+NKEbf/lcdb89lL0iEhLeteMATpbI2eF6OOvfRlq36mjB3uwNayC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcomLNnl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcomLNnl"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1333287a91.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783740725; x=1784345525; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QRUA0T/6rJLjJGZRSGfGUI1p1QAMGmjUm39A81E0yZA=;
        b=GcomLNnl1JBoR3IW6+IizjbdENAlQrpvAGxDqI+FoHRYW0EnwX3l3KQxAoXsH7mMeS
         koY0SZ6A9p/44zccwHg8KkQNVJd+V6Zz+Psuu7+B0vhxKjSnSMy1yMrE7VMcx+yAsl9l
         xDsEp/B04gooMCojzRWxkuziLDJk5nhgVJ7/vzd21C5ZNj25gfu8Bj6L49R29bgIpnlR
         xV0ePKDrhOz9Cx0ademoSL6ayXD4tRpOGZqnON4JMyMFLx5VIs4/Hj/k9j+0GT4VXUhi
         jxFZzj7gAnwW6Kmsa5EhzoVmC0aY5dXPRFiSKj7o2YjzywkuiS1wuWh8Ova/4mQKUTLL
         o70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783740725; x=1784345525;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRUA0T/6rJLjJGZRSGfGUI1p1QAMGmjUm39A81E0yZA=;
        b=S08DQETPDrL79HhccPZ5p5HiLpdt3NOFS+f9Ano5Ar8YmqrfTJTIvjGGET0jgvQ42X
         9yOeWcK9gYnILj171AmqEN4EtQNkFiTL1rK6NWAY65CsG1BHIRsYY5uNdYJ4HzjLNeWA
         U06+jcOPgN0RgJr1gNihvQw7dU+lU6R0FgljE+gXf3dPm2759bGLvFnkYmMBXxATaQvT
         sKK9OQS2XGIhjZQlcbB6tVul/e3k6Zugp4r/QVsK7HVZ/rqK4Hh7SXUUN385mkwuYHYC
         RopTQV+s6Z2zFLE6kTmcjV64p4B02xZzwz1EbegGVetYARkRtR84cWgoD+jT66Cy39uC
         ylDg==
X-Forwarded-Encrypted: i=1; AHgh+RqLlDr5QSjTnafXxG1+HK5R7Ruy/VNthgepdm+t0TQyjbp0WCtSZc9p9DLjtTKPF7M1Gc7qyLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwRhIr3DR+x6Q+ubpDpbLFFTFEg9ZiDZB0fJN/visvIAFPDNs
	qHuAhTWK84ghG9Uig0xLOxQ2I8gKIsG9iphq+9q9CQzsAl3X2gnOGPkf
X-Gm-Gg: AfdE7cni4fAqliQUgJmnd4afoN4qVFx2df/xR4ymki+Zjo6iW6I6iCL59rcLs+cvBbk
	ne2pjbzxq1Ayug2kjrP49owC98dzYVZvsr+ynRxJ2TaiB3pXnxWOaIk1ARmJ4Jqe1Xc9BXWUTDo
	ruAdNc9dt/krr/Bx7OK9ctuyM9K3ZzCw8JlNJsNN2cWTSo797I2nGV/DGzuONV+96q/PDzUXzKs
	2BcNY0/zUI/quYhgQsLAzGK+xKyPJxavQMJApuWfvvoRpzXax2ctX59hl9KiUYQLRBrkadnc4Gv
	M3d1Quc9HsQ43Mc+lT0I+9DRFPGe3WurekzPub1BA8A1dS6A3VC9Uj39OmalUtRu/5kRxsn35+9
	crh7/fu7MiQVh+PgIKtJtxi2mjTeBjBAnxts1ORE2Kc2zucNVv59E+ocpY3TsWXuq0HvxX17onX
	4T2t909dIOR6E=
X-Received: by 2002:a17:90b:1c05:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38dc77b46camr1413183a91.41.1783740725360;
        Fri, 10 Jul 2026 20:32:05 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483dec6sm46717596eec.11.2026.07.10.20.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:32:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/crash: stop watchdogs before booting kdump kernel
In-Reply-To: <094c3b8d-8ec7-4358-8bd7-f1b7eaa3a0c8@linux.ibm.com>
Date: Sat, 11 Jul 2026 08:45:26 +0530
Message-ID: <tsq6ushd.ritesh.list@gmail.com>
References: <20260603070217.483696-1-sourabhjain@linux.ibm.com> <20260603070217.483696-2-sourabhjain@linux.ibm.com> <4ii8w2ex.ritesh.list@gmail.com> <094c3b8d-8ec7-4358-8bd7-f1b7eaa3a0c8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

>> Looking at the code, we already have a mechanism to register a crash
>> shutdown handler which anyways is getting called from
>> default_machine_crash_shutdown(). So, I think we could use this generic
>> crash handler register mechanism and keep the wdt specific calls within
>> pseries/setup.c file...
>
> That's a good idea. I wasn't aware of this crash handler.
>
> The main reason I wanted to stop the watchdog as soon as the kernel
> enters the architecture-specific crash code is that, on PowerPC, the
> crash path sends IPIs to all other CPUs and waits for their response
> before continuing. Because of this, I thought it would be better to
> stop the watchdog as early as possible.
>
> I knew there was an IPI timeout, but I just checked and it's set to
> 10 seconds. See crash_kexec_prepare_cpus() in crash.c.
>

That's just the max worst case timeout value, which is unlikely to be
hit. FWIW, the watchdog timeout value in the example usage for
sbd.8.pod.in file seems to be 15sec.

> The crash handler is called after the IPI wait. So, in theory, the watchdog
> timeout could occur before the IPI timeout. But I think that's a very 
> unlikely
> scenario, though.

I agree.

> So I think disabling the watchdog from the crash handler
> is a reasonable approach.
>
> Please share your thoughts.
>

yup! I agree, the crash handler looks to be a much better approach
since it avoids, hcall definitions scattered in common
powerpc/kexec/crash.c file. This also provides setjmp/longjmp for
recovering from any bogus exceptions during crash handling.

But we will know more when you will give it a try!

-ritesh
