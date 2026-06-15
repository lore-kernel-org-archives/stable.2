Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669D3F929E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534346; cv=none; b=K9oiwNJlkNJCVqUapZy8UJYcvEZAZTiNAQlW08jCZhu0VWN54kY5zYEctmzgo4APWxmGlRVwZWGfyNCCXl7BYVC89Tr5lFzW0yekwrLS1R3GZdqCrTAtKsRWFNU8uDLo9f7ZfCb60bi1RhIuIZtFRyFoSkGJ/63ucRt0d/kcxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534346; c=relaxed/simple;
	bh=tdI+POKt+Uq2+TzTKvv9LXYIyNhigcnIVRICPPKccHs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=f0NhDSJ7AKT75KrXtyjrVfH1seDrEJz+VVSqiqStFcyCB93BfHTO4iq6mGAC8EgH+1HzVMq2y0yllBSDQQOfLcFbHln28WrH0hnbXAcKu9k0viR24/TlWkAG6X/lNAtubcjNt+eg/v2qpMrsYcXY8Y6uNxkSFJGmp3RFY9hLCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=eCF2gU7t; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="eCF2gU7t"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69e505c7e22so1030050eaf.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781534342; x=1782139142; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tObXM7iM6hx1hzc3bf0Uxt9MNB4bRmN27ZohzveT46s=;
        b=eCF2gU7tkIxe6w6vFuLn+CM4o/ErlLN2FpRjnH8BeIXSad0YK/qKvkDJi5nwmTqyr9
         EfnFh24JU2B8OjMbdOIFwr2GifN4PAWeY/+aQCm6zcHkhDT4I51uR/D0nQkU2diFQFm+
         evsqFzTxHRyvzMO7AN4SsECwnJTt/F+WvSQ2KPz++ZqAF2bwueDHzhk4JdGHlZI8NFlv
         F9eE+dqpOqYS2+p1VQSm2kB/vV6gpQ39CYU+UvbFzJOPQAtYnE8mJqUg4E4DOQewkmWh
         Pu/laSsliW0PFgMzpCdczHnzCwgDWM92l2QBQXjkGwZEV7OnT4+NpZojINkxabOMk6wn
         5B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534342; x=1782139142;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tObXM7iM6hx1hzc3bf0Uxt9MNB4bRmN27ZohzveT46s=;
        b=hyfVA/Oq5K2x3qiZmuuCGhcS96YbxgmiowfJri+KrMzI7NCmvZt2W84jDRLxJEiSR4
         DRYzG/uS54SHsFPDJyhXN5sBp1nyKc+MPWAX5IwaIBCr6ohesLp3tsF3uaWbqCdxoySP
         36cR8JBzDmKKOH+S3OmZBleqzd9cH4hMTmEkvHpa/MAMQGqj3RN9c4bACm9bpQ7kTRaZ
         bj2lS3dWKUSBWCJGbBzhojXJCwMC4UuuPnZhdIVupj6WtnpJOIvrdQTXOfxfzNzEa068
         qLETli8Sy8iXG5GSuLQHDU5FrQLPXTG0hU8igB5IH8HRqIoaBn4AcL6NuD0tvn76NcRw
         t6Ig==
X-Gm-Message-State: AOJu0YyNtl5yVzTcPnhBsJ4DA/AKxjs95sxzBGl98Njodc9aYZQxHsKH
	/4v+qy3fCCyriHIq30p5lvYG3uihE2OYeHI9bZQRZdXoOx3QYldr2x7OE28puQNnm4c=
X-Gm-Gg: Acq92OHuT/3e2z8n/SyCxb7BKKJz6fzTDkX/fDbVeE1ctFXc6JOw8k6Ir68QNMqFM0P
	E0Eijz2Yso+KJN1Hql5TGnVq0bzJ5KwfX2nyM5Wmc/Drb6GnRc26/iHF6rQOi561CC1L3KHwjIu
	DsdDQbmda2Tk0sy9Nxw1so0BZpqytzJMez+J5UKX/fbF3PHCtxC+JzCCFEcpzDTGriCzzNpYW52
	L0fvmnvkwHzI4Omol3Me2pXdBxLqdYI3vJSx+ZYqZO8d12Ek4SNg4oUxVn6CrFCQrrqDIzgh1Ob
	25NLYurF3WjL6OZrTiq15kgcuvnsafDFCMiJMUe11PyaTU68Aj2Z9KP1lZWpHhPrFU/sssLMDeQ
	5w1XZaPUKzIg0BurpB2WVrUToq1+BniQb18RFBWGhRp2nWZDZAvCwYcadHWNosHHcufesG1AHzB
	8mGhcEC+0p+ksaL38rD5lOg4rxWcmxk9hAHyi6YATbO0TMef4J+c+VbTSPHQ0KoxG+79oXh1CQV
	GbWKsz6qj2Ox1/ezt8=
X-Received: by 2002:a05:6820:150a:b0:69e:9632:8993 with SMTP id 006d021491bc7-69edc622bf6mr8994909eaf.16.1781534342521;
        Mon, 15 Jun 2026 07:39:02 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00f5d2a4sm2986401eaf.15.2026.06.15.07.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 07:39:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------cYx96X0L7r2rInT9nxwAchRX"
Message-ID: <8a4f0b60-0333-493b-b59a-eeb4a605fc7b@kernel.dk>
Date: Mon, 15 Jun 2026 08:39:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: don't truncate end buffer
 for bundles" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, federico.brasili@gmail.com
Cc: stable@vger.kernel.org
References: <2026061524-overtone-renovate-0e4d@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026061524-overtone-renovate-0e4d@gregkh>

This is a multi-part message in MIME format.
--------------cYx96X0L7r2rInT9nxwAchRX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 8:18 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.18-stable.

-- 
Jens Axboe

--------------cYx96X0L7r2rInT9nxwAchRX
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-kbuf-don-t-truncate-end-buffer-for-bundles.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-kbuf-don-t-truncate-end-buffer-for-bundles.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBiMDFlNzRjMTg5Y2MzZTE3ZmJiOThmMjhmNjkyNDViMjU5MTQ0NDI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgNyBKdW4gMjAyNiAxNjowNTo0NyAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZy9rYnVmOiBkb24ndCB0cnVuY2F0ZSBlbmQgYnVmZmVyIGZvciBidW5kbGVz
CgpDb21taXQgNzBmNDg4NmJjYmI5MjllODgwMzhjODgwN2YxZGFmN2ZjNTg3YWU3YyB1cHN0
cmVhbS4KCklmIGJ1ZmZlcnMgaGF2ZSBiZWVuIHBlZWtlZCBmb3IgYSBidW5kbGUgcmVjZWl2
ZSwgdGhlIGtlcm5lbCB3aWxsCnRydW5jYXRlIHRoZSBlbmQgYnVmZmVyLCBpZiB0aGUgYXZh
aWxhYmxlIGxlbmd0aCBpcyBzaG9ydGVyIHRoYW4gdGhlCmJ1ZmZlciBpdHNlbGYuIFRoaXMg
aXMgdW5uZWNlc3NhcnksIGFzIGFwcGxpY2F0aW9ucyBpdGVyYXRpbmcgYnVuZGxlCnJlY2Vp
dmVzIG11c3QgYWx3YXlzIHVzZSB0aGUgbWluaW11bSBzaXplIG9mIHRoZSBidWZmZXIgbGVu
Z3RoIGFuZCB0aGUKcmVtYWluaW5nIG51bWJlciBvZiBieXRlcyBpbiB0aGUgYnVuZGxlLiBU
aGUgZXhhbXBsZXMgaW4gbGlidXJpbmcgZG8KdGhhdCBhcyB3ZWxsLCBlZyBleGFtcGxlcy9w
cm94eS5jLgoKSWYgdGhlIGtlcm5lbCBkb2VzIHRydW5jYXRlIHRoaXMgYnVmZmVyIEFORCB0
aGUgY3VycmVudCB0cmFuc2ZlciBmYWlscywKdGhlbiB0aGUgYnVmZmVyIHdpbGwgYmUgbGVm
dCB3aXRoIGEgc21hbGxlciBzaXplIHRoYW4gd2hhdCBpcyBvdGhlcndpc2UKYXZhaWxhYmxl
LgoKSnVzdCByZW1vdmUgdGhlIGJ1ZmZlciB0cnVuY2F0aW9uLCBhcyBpdCdzIG5vdCBuZWNl
c3NhcnkgaW4gdGhlIGZpcnN0CnBsYWNlLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvaW8tdXJpbmcvQ0FBRXI4amJZNjBub0dqMWZ3X2s5MVVKUkJreWlSVm9TNj1uTGhaN1N2
d2lkam40Q0FBQG1haWwuZ21haWwuY29tLwpSZXBvcnRlZC1ieTogRmVkZXJpY28gQnJhc2ls
aSA8ZmVkZXJpY28uYnJhc2lsaUBnbWFpbC5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnCkZpeGVzOiAzNWM4NzExYzhmYzQgKCJpb191cmluZy9rYnVmOiBhZGQgaGVscGVycyBm
b3IgZ2V0dGluZy9wZWVraW5nIG11bHRpcGxlIGJ1ZmZlcnMiKQpTaWduZWQtb2ZmLWJ5OiBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwgMSAt
CiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5n
L2tidWYuYyBiL2lvX3VyaW5nL2tidWYuYwppbmRleCAzMmQzYjhkMjZiZjAuLmMyNjBkNWYz
NGNmMyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcva2J1Zi5jCisrKyBiL2lvX3VyaW5nL2tidWYu
YwpAQCAtMzA1LDcgKzMwNSw2IEBAIHN0YXRpYyBpbnQgaW9fcmluZ19idWZmZXJzX3BlZWso
c3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBidWZfc2VsX2FyZyAqYXJnLAogCQkJCWFy
Zy0+cGFydGlhbF9tYXAgPSAxOwogCQkJCWlmIChpb3YgIT0gYXJnLT5pb3ZzKQogCQkJCQli
cmVhazsKLQkJCQlidWYtPmxlbiA9IGxlbjsKIAkJCX0KIAkJfQogCi0tIAoyLjUzLjAKCg==


--------------cYx96X0L7r2rInT9nxwAchRX--
