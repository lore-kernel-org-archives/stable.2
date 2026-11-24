Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478689;
	b=JxZO2kFZxLgHiHQE1SfnGObvsO7udhNpi1xmZ+TVqr8E59SH9HLF46VA0RzQQHvYjWvP
	 lqUuP0nGxcxDS2LaNDOZJUGPbV43VEc+5hPCmxwUZNsihgn6tkcIgjyDCVOuK0oNmceLZ
	 w66cDQJoIXcMD710hTohN3FxLtLj0f2GxmMyvERMAQE17NUhbAPE8RU8PqgLe8yeuSunV
	 O2VqBLWX71qsRWZDHFJLjvlbBD+yU3DnCncMwdW9CDKzAc61oC/P267GqWajX9AaSlvG8
	 1gtMsJJfGBrMcd/VbINFS7cIgM58HC/4LZGV3XrGHQtk04dFUpUbbDsxgwh6mhzaDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NrqsfqzthGjJFnZQLwLkp8teKLCeBqgZhrjo/nTNW9k=;
	b=iYXKJkbrDFaGvsGA+aPvyFquXwcz19aTM3mefpDaWPbogOvUqQ1dQVN9wvMKPdvxiHP0
	 8F+hPq2j/0HItKH9WzxWVmMaxoqLbRpZPv1jx1TsjZOgOBSVds6fEwGfpNPXsKheb1wWm
	 HFctRhev15cHnPlFids1/MWTmNWc/TgSq+y1JAg/JCNJjxODiDXZWQTYYUgpRHSUkYX2N
	 VKF2fWhGtxQta/vBayWUtrYMpZp0v8uXzLRc9vmz30T6osin4zlbTQAFXwQ+M7OG+APx1
	 c6c/SAnizjdaCfTfVnsNVTkqV78kb9rbDK8GcpU+HcXR71QT1450ypDBhO0ATmi/xdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gqnhxcHK;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10383606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10383606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gqnhxcHK
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2036727a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795478688; x=1796083488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrqsfqzthGjJFnZQLwLkp8teKLCeBqgZhrjo/nTNW9k=;
        b=gqnhxcHKXD3IRaY+uy37bTOm0gMDtN0JowrvVe59uofy9L3GzXkmUymPMHMbYp1nFT
         XrtL99E1WI/NqFV8PXSeq1CZ2iFUwGadsZIEr5ara+ITENybhtiSLgIHEjh3HB5stw03
         TlA8A02gMafZr4AyP2p9yz96UQhmIKRVppwxAzHgRdbPOoacBhbpF8MOKpGDuFHCGvn4
         Pr8erwNvSGoMB2UmNRDwG+AvAT80BBfnlfUiIG0VFSm9eNE7WjIpp4GqIWdepmFHSMhJ
         kXI36RXcf7jjxTzcMra1CzTgWC1//uKaP7BxQUs7dC81fxIs8307b/a3L6MANmqxILob
         KgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478688; x=1796083488;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NrqsfqzthGjJFnZQLwLkp8teKLCeBqgZhrjo/nTNW9k=;
        b=VYXo1dEUkRbQGo6pkQWoqhlzcgDEWHtXAUfvXA+6MKJoUeUdyyw3nPJHTilQuM6+vo
         nY0N+HrapVHWNYHD9CTGb3hJhHm627PnzFIxm+xthIuhHNGhGqrVmql0N6Ak4Rht0obs
         F3GutiM6OInAw+JohYxpum5t0dynDqGxizT10XNPQUDEEGz7bTj6HeoRQ/rSGNI5W7gu
         qJsEpkISRR2j3Z/3LGgBJS/YVGWl+KOMUa+V5Cm8dFduw6QimVvwrVjw3nUYMZVoWb61
         St6K6Ybu/F4YTg0t8ZW6d7VZochFzl+Nm9gYbSPw86qPoj1sMq0rkpo/gosSLtodLEFa
         R9dQ==
X-Forwarded-Encrypted: i=1; AL+hErGWSe0gpQ8wnXFT2Vo+2UUzdak36zH3VwiT5o3HIhMaCN5vgl3ZfCwEgNAxsQqGanRNdsGMFLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AdseCJ1m74Rj+xU4fRZHR/SQwZlNfq/yZUn10/ET2N/evcbel
	oVlEIoMMJrFFEort0GbF6UjgeVlPbUNZvqoXcvcWAIC+gFbedU4j+N6W
X-Gm-Gg: AZFdTZcNcHxeImCfW4ap0EjyEDiVbjrrpRVNNqASF3lCxXb6DbUuM5W2yZ9PrDAsZ9i
	KEdGNIU3AKcy6tO45LwzVzOaSqvW55JKHp76tpF4rxzqH6d8qLgVr+UbdmADw026mDisasVqCzy
	6kYhy6fjtP0wlYxgr3P6Y9EaQE1rhSYlZAl/1rdcOvnuJWaF51/wQrCVL1XSyqNLzvT+HQLXqZ6
	Ndqr/NA1JMOqFqz2FvdkR8iJNK/vj2qiNvJubno5vZvT9z15r6V2SqWEDnyisM47FXHpYRXeGfE
	mRSFLmNznNCkHvUMEelfra/IYP+y9wk7Ci8z4cY43VdHjMuqEdi6ucVRGQRRQ0vBDhC5MrN1EDH
	f3i7YsWRwMpGmliDLshhIuVMxgPS72iGlLGcUhyNsvceqZt1rPMYHvaT5XFsuZSLP/Z+bSFL1Q6
	Dtvl/J3/FklsetkYoHA8Qc2vbY+AO+R7lignUdZa9YTGu9rcB3AcWEOnqMGpZhbps33D4RPlrlG
	0obf1VnFFmsRkLHYlBIGcHx5Mq2wJzgl4KlsrjJNcJFBV4lY5T5R5CZYa0j/2hoSnU4W1kTA/w3
	wVTUAXPwtDEU5wKHF8z06f+679mhbauPt1khw/GB5V7N
X-Received: by 2002:a17:90a:ec88:b0:3b3:b0f4:1bed with SMTP id 98e67ed59e1d1-3b41c8d4855mr11016819a91.19.1795478688087;
        Mon, 23 Nov 2026 16:04:48 -0800 (PST)
Received: from ?IPV6:2601:600:a482:7d70::b4f9? ([2601:600:a482:7d70::b4f9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b704cfesm7096451a91.1.2026.11.23.16.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 16:04:47 -0800 (PST)
Message-ID: <83ed6809-ff39-44af-8e3b-a8affa622177@gmail.com>
Date: Mon, 23 Nov 2026 16:04:46 -0800
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
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, m.chetan.kumar@linux.intel.com,
 mail@maciej.szmigiero.name, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261122050039.861287-1-davidlwesten@gmail.com>
 <179541288475.3135.162337854159176054@kernel.org>
Content-Language: en-US
From: David Westen <davidlwesten@gmail.com>
Autocrypt: addr=davidlwesten@gmail.com; keydata=
 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
In-Reply-To: <179541288475.3135.162337854159176054@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 9:48 PM, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> 
> This removes the only callers of ipc_pcie_suspend_s2idle() and
> ipc_pcie_resume_s2idle(). They are __maybe_unused, so a W=1 build won't
> warn. ipc_imem_pm_s2idle_sleep(), ipc_protocol_s2idle_sleep() and
> ipc_pm_set_s2idle_sleep() become dead code along with them.
> 
> ipc_pcie->d3l2_support is also still filled from the ACPI _DSM in
> ipc_pcie_probe(), but nothing reads it any more. Should these be removed
> too?
> 
> There is also a behaviour change. ipc_pcie_suspend_s2idle() was the only
> code that set bit 0 of ipc_pcie->suspend, and that bit gates IRQ
> processing:
> 
> [...]
> 
> On D0L12 platforms, MSIs that arrived between the suspend and resume
> callbacks used to be dropped. Now they go to ipc_imem_irq_process() and
> the tasklet. Was this intended?

Yes. v2 removes the s2idle helpers, the _DSM read, d3l2_support and the
suspend bit. The commit message says that MSIs arriving between the
suspend and resume callbacks are now processed, as they already were
with D3L2.
> [Severity: Low]
> 
> Is this comment true in general? For platform-manageable devices,
> pci_target_state() returns whatever the firmware chooses:
> 
> [...]
> 
> So firmware can choose PCI_D0. The commit message describes this as
> platform-specific ("here chooses D3hot"). The comment turns it into a
> general rule and uses it to justify ignoring d3l2_support.
> 
> Where firmware keeps the WWAN function in D0 for s2idle, the modem would
> now get the ENTER_SLEEP/EXIT_SLEEP handshake while it stays in D0/L1.2.
> The notes say that case was not tested, and neither were the XMM7560 or
> platforms where the doorbells work.

No, v2 says the PCI core "may" put the device into D3.

> [Severity: Low]
> The Fixes: tag points at be8c936e540f ("net: iosm: power management").
> That commit only added iosm_ipc_pm.c and iosm_ipc_pm.h.
> 
> The code this patch changes lives in iosm_ipc_pcie.c. That covers
> ipc_pcie_suspend_cb() and ipc_pcie_resume_cb(), including the switch
> on ipc_pcie->d3l2_support that picked between the s2idle doorbell path
> and the host sleep message path. As far as I can tell, all of it came
> in with 7e98d785ae61 ("net: iosm: entry point").
> 
> Should the tag be this instead?
> 
>   Fixes: 7e98d785ae61 ("net: iosm: entry point")
> 
> There is no runtime effect. But the stable tooling and anyone bisecting
> later rely on the tag to find the commit that introduced the behaviour
> being changed, so it is worth pointing at the right one.

Yes, fixed in v2.

> [Severity: Medium]
> 
> Every platform now goes through
> ipc_pcie_suspend()->ipc_imem_pm_suspend()->ipc_protocol_suspend(). That
> includes D0L12 platforms and platforms without the _DSM. What happens when
> the handshake fails?
> 
> [...]
> 
> Could host_pm_state be rolled back on failure, and then either fall back
> to the doorbells or fail the suspend?

Agreed, the state is left at SLEEP_WAIT_D3. v2 adds a patch that sets it
back to ACTIVE when the modem doesn't report itself active in time, as
the path where sending ENTER_SLEEP fails already does.

Suspend still continues after that. Failing it would let a modem that
doesn't answer block every system suspend, and falling back to the
doorbells would use the path this XMM7360 doesn't survive.

An ENTER_SLEEP that times out still counts as success, since
ipc_protocol_msg_send() returns 0 on a timeout. That's older than this
series and affects every message the driver sends, so I'd rather leave
it for a separate change.

> [Severity: Medium]
> 
> Every system suspend now depends on ipc_pm_wait_for_device_active(). Can
> it lose the wake ack?

Yes, and the signal case is real too. v2 adds a patch for both: it sets
the bit before testing ap_state, adds the pairing barrier in
ipc_pm_on_link_wake(), reinitializes the completion before each wait,
and waits uninterruptibly, like the wait for the ENTER_SLEEP reply does.

> [Severity: Low]
> 
> SIMPLE_DEV_PM_OPS(iosm_ipc_pm, ipc_pcie_suspend_cb, ipc_pcie_resume_cb)
> binds these callbacks to .freeze/.thaw/.poweroff/.restore as well as
> .suspend/.resume. On D0L12 platforms, hibernation therefore also moves from
> the doorbells to the ENTER_SLEEP/EXIT_SLEEP handshake. Is that intended?
> 
> [...]
> 
> S3 on D0L12 platforms changes too.

Since commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by
re-binding the driver around it") the driver is unbound before
hibernation, so hibernation only reaches these callbacks on older
kernels. v2 says so in the commit message, together with the hardware
it was tested on and what wasn't tested.

S3 changes the same way. Where S3 cuts the card's power, as here, the
modem reboots and resume fails with either protocol; my S3 series
handles that case separately.

Thanks,
David

