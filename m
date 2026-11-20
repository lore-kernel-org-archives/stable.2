Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.48.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171586;
	b=ohvX0vMFk+D61FbaT4ChxRUt5R6m0bHUQ3/Z2pRR1kVyiExGvUxuygOOcLy+DyFEhVsJ
	 eWiu9GJc11+Qw42bCJkWyfMGkgTYrl2wkkYEd1ymk8KiZJm9rtJkLRGPTR/emLf1k4FaH
	 lsLnI6vxR7xPb2Mw8hjAcDbpWxiwh2zKFu/zSAsFC9wwoSQHFTsgMFWO4uMd7C42G2p2+
	 /pnWAOyT7v1ocz8wnkM6uYFrFgT/2wCqTjv/DQzrB0YkM/p2/EbqZ1NKePfVkF2Z4oCCy
	 4HaBdzeD9tB5apJ2KFgZtuPPGAGwWbz7MAlbHVZtcWN9zNQI6g19zQvJUGGjgEjdGeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171586;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=JV2acAQmqGKfDbCVtMogdgCc+FnQWR86JztEUsUWjJM=;
	b=VwvhklNn7PsYRfWPZAx/ZhT1tN6Ye5hfIrHpuMbQslW4zXn0i7tOcxZ7vERs6DpfZvv4
	 F7ndmkepNXl4MmFyKuWLo1y8JrDP2faXjNq3rLl+8jHma/ze1CZH+z7+tgZvIPDVgavwC
	 HAY20v4h22qvK1qpXWtVt/LU7ck3iA5nBaJ/4gWLPWle3UkPSQuNSIQ9YDMzWbPExbMPr
	 iPK0F2UBkuz+JdcRhhkNZAH0DIW8sc3rQYDPaEm+FgVJRoQjnsZfmQaBnNCQzdRGOTb/b
	 CRDzy79LcgXiYwj7nmHkfuc4mWMpTDYoe7gG2OfrvbAPTr7g76/PARhQGi3pqDGGO8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ahmedabdelfattah.dev;
	spf=pass smtp.mailfrom=send.ahmedabdelfattah.dev;
	dkim=pass header.d=ahmedabdelfattah.dev header.i=@ahmedabdelfattah.dev header.a=rsa-sha256 header.s=resend header.b=N97xfKNq;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=hkVSnF4J;
	arc=none smtp.remote-ip=54.240.48.59
Received: from a48-59.smtp-out.amazonses.com (a48-59.smtp-out.amazonses.com [54.240.48.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE459606A331;
	Fri, 20 Nov 2026 10:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE459606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ahmedabdelfattah.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.ahmedabdelfattah.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ahmedabdelfattah.dev header.i=@ahmedabdelfattah.dev header.a=rsa-sha256 header.s=resend header.b=N97xfKNq;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=hkVSnF4J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=ahmedabdelfattah.dev; t=1795171585;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=6CD2vOsCvJqHeLL+WfMDNvW1b1UbZ+Ck4Y3+1Csv8O8=;
	b=N97xfKNqCaWCFd2qaWcA7qfcgwPG3bj66p3I/eNAy5510DAD4yiee/ZLvTU/dz9c
	R9Ez/3QQLWwKPiQ3DBjRWgHbUM2k0Rvka5l4FbCyh3WcmttgKocinjuSimrq81Q5Qxt
	muzqp8UlK6bdNLorSJIcnsTu+lhvyCZ7lIvuW2BQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1795171585;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=6CD2vOsCvJqHeLL+WfMDNvW1b1UbZ+Ck4Y3+1Csv8O8=;
	b=hkVSnF4JMsSfmb6Z4yWQ0NJdJuoyL2nqSK3+2UC9Meb1yHrZXTo/O5nIsbnwovbL
	/lwrcmpIFxTrUK6rVM0Mn0pYkJz/gP2yHWi9aosGAT/0Ei1enLxQHZTBpt+7V2lvB2D
	KgWr9Lmg3k0DpBxe4YFtFqFdCgUDUwn0HFXW4MXo=
In-Reply-To: <av_uoSlMShJiJsff@intel.com>
References:
 <20261119-x86-mce-storm-no-cmci-v1-1-bc593e90abaf@ahmedabdelfattah.dev>
 <av_uoSlMShJiJsff@intel.com>
From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
To: Chao Gao <chao.gao@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mce/intel: Skip storm tracking on CPUs without
 CMCI
Message-ID: <010001a1f8908ab7-fa522391-bf93-4fe3-9ddc-e2f3e8e43ae0-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:46:24 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.uCKvsN4fow5iTxhgdfCiLkD52dLS8e5zeZeNIHIyObThYgWj6io55JEpA9Lr59BibvMHOQwybONW0pi/CZ0koY1A1i17AG2yWEV8SeTaUDUkRN5zlcaoQEhviEafOoOqtPZhQs319GE3nsx7+JZeBdmAUyq6td6+kg0Qy2oXHvo=:1.us-east-1.pAEstvQcjyhQNKGKcgSlzI7SVR8ZSG5wSmKwiz/A8Dg=:AmazonSES
X-SES-Outgoing: 2026.11.20-54.240.48.59

On Fri, Nov 20, 2026 at 02:54:25PM +0800, Chao Gao wrote:
> My understanding is that QEMU gets host memory errors only through
> SIGBUS, and the host kernel does not send SIGBUS for corrected errors.
> So QEMU never forwards corrected errors to a guest, and a guest sees
> them only when someone injects them by hand.

Yes, that's right. The =
guest is only where I noticed this, and the
sentence about KVM guests =
running into it easily is wrong: in a guest
the errors have to be injected.=
 I'll drop it.

> Can you reproduce this on bare metal, or in a guest =
without manual injection?
> If not, this does not look like a practical =
issue to me.

No. In a guest it takes injection, and I have no Intel =
machine without
CMCI to try it on. Going by the SDM, that is everything =
before Nehalem
(06_1AH).

What I can show is that such a machine needs =
nothing unusual to get
there. For the first test I had set check_interval =
to 1 s to save time.
I ran it again with the default 300 s and one =
corrected error injected
into bank 9 every 2 s. mce_timer_fn() halves the =
poll interval after
every poll that logged something, so the polls close in=
 on the bank by
themselves:

  uptime    next poll in
  313.8 s   150 s
  477.6 s    75 s
  552.7 s    37.5 s
  592.0 s    18.8 s
  610.8 s     9.4 s
  620.6 s     4.7 s
  625.7 s     2.3 s
  628.7 s   CPU0 BANK9 CMCI storm detected
            unchecked MSR access=
 error: RDMSR from 0x289
            unchecked MSR access error: WRMSR to =
0x289

So a bank that keeps logging corrected errors for ten minutes is
enough. I then stopped injecting. The storm ended 30 s later, and
cmci_storm_end() took bank 9 out of mce_poll_banks. An error injected
after that was still in MC9_STATUS after the next poll, which ran with
a mask of 0xfffffffffffffdff. Nothing sets that bit again on a CPU
without CMCI, so the bank that was reporting errors is the one that
stops being polled.

That last part is what d7ac083f095d ("x86/mce: Do not =
clear bank's poll
bit in mce_poll_banks on AMD SMCA systems") fixed for AMD=
. Intel CPUs
that poll because they have no CMCI still have it.

With the patch the same run has no storm and no MSR errors, and the
error injected at the end is logged by the next poll.

I think that is still worth fixing, but I agree the changelog oversold
it. Unless you or Tony would rather not have the patch, I'll send a v2
that says which CPUs are affected and how the storm is reached, without
the KVM sentence.

Thanks,
Ahmed
