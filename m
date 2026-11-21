Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795287477;
	b=diwE5LV3zSXH4K/zTU6U2rqgdFEP5S7pZAwn+38AY2xBzrDlgPs4jmARiY6vsiJyn5DC
	 4lQpbK6e8OmrxAaEuuIrEqKc0+3THitw5qiYCuDnAnw4qnuGnmLpUoVI8vK6MOXkN1xcV
	 R2L96VFzQTI5M27p6REt5vlNbhE/tldxcEEWr50mSZ80FLPDTGeRzB2L/T20hwHUMWwTE
	 j3ICCgPxLKcCtLGbsxFj/6b9MbJ7LiSSvdhK61c6aI3Gq7+8QO85nZJdMx9qEF6MOSr4V
	 dWoDgEDQeRV5PZBNOpM/lHAzk/OTFGLBKLU2MgNUC8G3kmr8BrzEHb5TLFF8jyBm7tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795287477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=B4MC1zwDtHKkfjjcvpHqhFzlxWejU3rmnKNPYLZVYM0=;
	b=XBOeWiRECgkkYbsqDqSlFlGZ/7/tX0DJaIhJMpNmhVIiHWmYIxjNNltJHu+Hd2FH8CYd
	 C5r5WnJgMAAzn5PnHr6o3SNLs5c+SDWv0tuefgOmuTJXTM7m+/AQiSHVO8U9nC8YwAdtI
	 W94WkqgftKZLEs0AZ+fXom6e0Jf4zL9oI2PZfd8Mc4weGw8Q4PtrgJLogPzXxceWEy1Gw
	 rkR1FwOVrVw6kFEYo59Hs3cvAjgizA7BnigZx87s/vRLipQiCk0WAJgPaqSP6wuyINjyc
	 6MMwQi7c/vrnbCHGFdlEjLg/1w/shazBtufa9H7DbYrz3ky8oJPmfWgP2TeT4cG8YjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="NF382s1/";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC5606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 18:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAFC5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NF382s1/
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b847ab3fd3so2403007b3a.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795287476; x=1795892276; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4MC1zwDtHKkfjjcvpHqhFzlxWejU3rmnKNPYLZVYM0=;
        b=NF382s1/VdTVwSM770YoNpdZhfUYXc5xNd2j8nNkgdUywnOATf/HJomGaGY/5fm33i
         H/dFTdWvxoMJMB8lX1VmlqMedkcl3UUFXcdCB1YnDvWyp1u3jLi2x06AbqKcfPxCnBuU
         r6izioFqXM2Lllg+eYIFkjoHY1VYdwVVh+fq+tR5ajnovXnKKKovae+Yw8lISPrqfklv
         tANItNNOaxXRRapyDPrqwEW3Ni+wn3L8XMt45r71QcccTFL+MZ4WFe5UQv2y3RbkWzDX
         KtFyeZSj8YbB/5vDjbEqfmduP1D01VI6flbhIn8h4YK/w8kwxHDLF5hi20+XUpN/ERrH
         ePlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795287476; x=1795892276;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4MC1zwDtHKkfjjcvpHqhFzlxWejU3rmnKNPYLZVYM0=;
        b=UrjaTvU8GxSqfBIYmird15thORS9wOHNYocCnwUIheYTA3xco2EQ9vuovuF3wkXQNX
         uz5nwLve663M2/cdbBYli56JAY7cYRzKUjDIAjCBDl0JQxdCc7c+BL2PNzfH35eLsZFp
         bXVmm4STLLcwBy77Vnd2umfEqtzE93gVDn4FvH6DUpld7ytKpQtcjM7DaZVTHhGt+lPb
         0DgPllP0RmZ/F5UA2x0oGFJJK/JaVrKK3soe5xgenDsHzxUKiJ94lQdFOi64++AgUHR7
         2vgGygigNTGuqZ/i5I8NQ0TISvCssF8C9517BYFLN8en1N2lHOjMemRi3ADXVAf+c4Jm
         xhlg==
X-Forwarded-Encrypted: i=1; AL+hErHjJPOT8qJd2ufWjaX9gtjdjmkYHKLMSJV15gVxBerw5ulWZvUqjmXk8MlvWIAl/4KwB0T/1F0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jiSFe3j7smI295NAwpXu4hmvNBJQPQMOq5j5FNvpFf+thHhQj
	8qTEYct6/AwkVi53xQL4Jjt6uzrGCfq65biX7cWt638E1Ide5KiEPAPzkFUaZIuSQ2h4WBcn96R
	fzL3LPA==
X-Received: from pfnj20.prod.google.com ([2002:aa7:83d4:0:b0:8b7:600a:cc59])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7e84:b0:3fa:1dbd:7f75
 with SMTP id adf61e73a8af0-4014cd4a8dfmr6376382637.36.1795287475736; Sat, 21
 Nov 2026 10:57:55 -0800 (PST)
Date: Sat, 21 Nov 2026 18:57:55 +0000
In-Reply-To: <1595ACC3A3D11BB8+20261119041113.3514099-2-guanwentao@uniontech.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <1595ACC3A3D11BB8+20261119041113.3514099-2-guanwentao@uniontech.com>
Message-ID: <awHpd6a9_S_oI6kg@google.com>
Subject: Re: [PATCH net] inet: reject unhashed sockets during timewait purge
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: edumazet@kernel.org, ncardwell@google.com, imv4bel@gmail.com, 
	martin.lau@linux.dev, jiayuan.chen@linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, 19 Nov 2026 12:11:14 +0800, Wentao Guan wrote:
> A shared ehash can retain a stale pointer that is recycled as an
> unhashed SYN-cookie request from another dead namespace. The namespace
> recheck alone accepts that request, and
> inet_csk_reqsk_queue_drop_and_put() can then operate on an uninitialized
> timer.
> 
> This is the inet_twsk_purge() counterpart of the validation added for
> established lookups. Recheck the nulls node after taking the reference.
> If it is unhashed, drop the reference and restart the purge instead of
> operating on the recycled request.
> 
> Fixes: 4e2b3ef19e0e ("inet: reject unhashed sockets during established lookups")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

The correct tag is

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")

otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks
