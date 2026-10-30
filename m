Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368632;
	b=hpofj3ybGFK4hQxXbhXL9RruYo1yY4ZQ+u+HL0me3l5P7dZD2vv8x0xiAdRryJ448+eP
	 2q+YOefJa0i5hgfQizffqSmQ3R/3Iv0mZXXvZsKnwB5h28Hsq1nj1wrt6F7ZHnFLi36ji
	 w222vhE00Z//nlYexeDshCjVYBM8gKEpMBUveCXCL/3a8Yg1CHq8lRWfrvpTyLlHJ1kRK
	 nh1HZu/LzeXmaQRq/S43rp8/zXb1wFWlP4eGEaZ/6brh3VvlmVDfv4nS5Adn1gXfEHbIS
	 IroymQXl2CYeIXKEIjWaNUpV7Gr+UWZx2ptGayIBr8yAMhMk51B3h5x7NeBE/JjjjcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
	b=JtF9G3//ZYNfEWSw2z91B1dLF7vVXMV+KFibIX6gxlpGMsTSSx/dth7MXDDmLHI1te9Q
	 Az7ezy0lHm0ae1kmgfPNh0Q1/x0z/b9mqWxlqGLg9IhGSlj2fVzjvbdhptZ0PahQYgK2j
	 UATT5mY4r/cSnZ+g9sPu1KiNTGr0LLMvMP4jlRCUHYQBLGiEs2S39nMswcnKXKn/fDYSO
	 +JDMZ6DFlKfK6OEdv/cQjKDZjS9NXgDjJ5ATtc1YzGCC8r1381YA4A46yNuzR6hUfUNSw
	 YMFnKWDs8GFl4Ywk1u+n/3O/oZhFIo9GsoxBOJBiLX+UOu6WNmEAXuAk5ee4eZPNOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouxQTXuG;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516C606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6516C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouxQTXuG
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e96502e447so7102675ad.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368631; x=1793973431; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
        b=ouxQTXuGY0sUIyzArMYPWSLzsXzGVK8/GwzTMGcquJB53F0z+mtYa0vwvFzX0mKKJs
         i9ovdt2l6t/blE1Ru8wzBGANzZ9/sLcVu0/ows9x2wlcFiq57bgyp+WTw6E6AJX2EBZi
         YCzj2GjuC2xsnthiGOJO7aWt3jhVWeHUuQx2Kou2E77dkaam0d1Qse/rrRr/gk8ua1yW
         5gPjLDAhsCaT7BEhY/MT8ntk1Xlr8z4Kirg0mu9p5A9qICrUq1oyAS5N3o27acU3s1v0
         tsrN1vzsNR+PMGud1ia+XH3+rfzbwzkJdTgI3oOVOubg8Mizsn7qYpFgAEdU0F7VsvJR
         74ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368631; x=1793973431;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
        b=K7mc4UaC7IvWGkNYWJeRfYz3iJwLY9bGuBrfXWChl2AO1v3eh6QbS0JBSkMmG7RiYu
         gWXj7PfTGYK6MHtWlON+ejhQlGV96+htC+mbgTt80eJYtNxaLgpgbYhq08HvLcP94x62
         uB88YgsO6VYnhgcAD4foHzLDmWVrCBKacS4PsoEWt70PEQEDnjnYHmndMF4HF7sTOjBG
         3LsikeRI3AQ8RmehPXnO3Ejd6E8cV6SKE53zLT104NgJyB5nQngK1YUxFSvw3tyMBCQc
         o/ZK58L/gr65u5lGe9I7m/lmU9B3lr9Lko3rX+U7URWbfRvMDAKgbVZm57f9cHJL3Qoi
         xWQA==
X-Forwarded-Encrypted: i=1; AKwUvBxiqLs5Fx1iFS3apglk3nggmBpuIBJkMauhj5pLVsRP5aoste26nZr8N3+YMPYuwHj0rkGrKuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3T5PZpNQSPw90QFR4Vv4/tcQirsBLD54rib0awz69K2lRSGeK
	mWUcZW/UIvyzvqFLMPXcqGwYeOSwtVpCAoWvtl6xH1ra3dpEtaRTNPmssc0hyg==
X-Gm-Gg: AYBFou2bMmlWVEwTbAgq9alpfUoEKcfbUHIqe3zwHArbOLLPl70FrLNDzdbPzN724gr
	mxqZheWmVhE4+TGZMfNyij1ni5BMfXX5jRrCnxfbc/lksYzwLYHM3Gu51CG213cV8FABCRcnWSW
	OPjXB6JeKxeoTAqPjbF98mSoFXcUC59iN6bMH5UhZnwZtLGunySJyGtB3VEhzrqdW57edo2enPR
	ME/H7DLwli78LY+AOvKDPBOrYruAiIJCJTwluKkCjnDoWDo8dKmHh1cQW9SIBeBjhDNKxtxvMc4
	NyTyzD1iwiJvjzpoGJky4vJ3LXkBhaAkDtfcu9/luFa81GS+g5JQzp1VpT9T+xA9XRChZcrBzuI
	WfqycZ8pAA9XiPm++FgDg+MNiKxFYxz/42R4fvdEGDZmTc1LzKvSlB1PGuHxb2H847DFAUDZYv3
	j6+Q1VzCnmStr3vWZVnTTu2Cp8XvFo33QcfL1nrtzNB7sqnqPbWzrqegB/vgvx8egOaFY1UhgWT
	r4MoumqIfOOZp/vprRZLOJGTB1dReZW/tQNfZJcGuf3C+PpH+9wsJbxAtUBFRPIDx4yZZdpXDtU
	wRMsCbpWT10bQe1qMAcmEy5ivnY=
X-Received: by 2002:a17:902:c94d:b0:2e9:6645:e9a6 with SMTP id d9443c01a7336-2eb365363f7mr26307325ad.59.1793368630732;
        Fri, 30 Oct 2026 06:57:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c858sm7688305ad.35.2026.10.30.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:57:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in kvmppc_xive_cleanup_vcpu()
In-Reply-To: <20261012082922.218799-4-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 19:26:01 +0530
Message-ID: <8q3fwavi.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-4-gautam@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

> In kvmppc_xive_connect_vcpu() if there is a failure before
> xc->vp_ipi_data is setup, it can result in a NULL pointer dereference in
> kvmppc_xive_cleanup_vcpu() when accessing the MMIO page in
> xive_vm_esb_load(). Fix this by adding a check before masking
> the VP IPI before accessing the MMIO pages.
>
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # 4.12+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v3:
> 1. Add some more info to the patch description.
>
> v2:
> 1. New patch - Introduced to fix the scenario where NULL ptr deref is
> possible. (Sashiko)
>

Make sense. However, the order of patch-2 and patch-3 should be
reversed. Otherwise LGTM.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
