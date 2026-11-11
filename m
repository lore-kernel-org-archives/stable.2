Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412189;
	b=EM5R6QispTt5SlNf2XQ8ZHHPdzxMfQYqCqI1MdiRF7Ejbg30vOtmDtsWa/iXDpFczBoK
	 xkkz+EP4dxnibJeXrJoeMWEt1J0MC/TlxLMtp+9k79hldj1YKJun+BlBBxZAvnxz0XL4G
	 zGm6QQxXf1E/6zxiP7zjJC06ZNxdC/UTJl2nDFRin0P4LWY7I6LaXNoEDeHbFt9rDsIZq
	 tiDA5Yxk7QWbKTBbAEThTsoevvpTOd/bVivsREikDFUsxAVhLrWEwj7f36J6ntnBX+jG6
	 Xyg4N6lcMP5f1MblgU471PtIzL0qV/3JhDf7WTeVo8YPPITGtZ65oobitVLnuSKwBDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8lr3aKoxXyqF6nskKr2Vhxx8OsrFnBfqQgcxE5WVowo=;
	b=sTJYxTu+aVGvIPxLPjmM+URGbONozBverQ6XNvYbivlOZiUb0Casq4hwEtOHFW0UWYf8
	 Dq/lEUM/dPMaoJ02LEDrXGCDCrcRA0EkFq27eP6ymDyhBRwtERjeMS8MHRnUctpAbCIF2
	 VpIO17FJqfXKcivAoXpWA3jg3dkTF7S7YJcods3Y7qlV3r/zeRQGZChQUqL644e1awLwA
	 g1jDiXOee5ZojJkjwKe8oiRkXY2s7o1pgiEZrXi/Ibs55kxFGiWwCjyaWiZbe1AN/q5I6
	 mb7kY46RevIFoSUasFpZ11UM1RFWOgXQsS0JEJMji5TpXcBJdiAsIyA03MCLVUCPZNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A+6+M2s2;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A4606A335
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A3A4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A+6+M2s2
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso4237168b3a.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794412188; x=1795016988; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lr3aKoxXyqF6nskKr2Vhxx8OsrFnBfqQgcxE5WVowo=;
        b=A+6+M2s20ZIin0mdb4xop0p7biVDFV0/CAdSYByXL2NwZCE3lspI43Sb0ueQjxwVTy
         g0JFcIwh9NWo3+/e3uDpMGF/TM6aQ9hWOOcXJU4kTpJP+PO4h/8o+y4ja3Gfh3AfD3Jg
         LlvH+1WDYzLR3QgrlrssdCR47cGUY15FqJzglhgwC2s8Z7f4qVzhRglnumn/ti+oNk2E
         RDCNRLk9c/noQyleQI3UcDEWMB0yNJGJdASWIMeprcqW+v6YgJBmgIZ1ZCxi97/fQwp8
         ptrZuHSSsE55RIGn9WN9h7mJMvy9mKXiVcbXprSKZv7KRpuqCKxPT47zZRb7/5lUBaI8
         RMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412188; x=1795016988;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lr3aKoxXyqF6nskKr2Vhxx8OsrFnBfqQgcxE5WVowo=;
        b=GfBr/+npYJ6pcsRGLzCphV+QWHKFXMdhU/hmpxJbmAajtItw83m9y0B9inu5Ckhnt2
         XbxHAQmveC2C46BQNLhS9TAFpv82KQK0w2JvZfoRM+ie0CH51KDRtIWaMn54NXv8/fPr
         3GTUmf9pW3ThYpJywL29SZJtHh4cLRQzp82dRm4ViGyDYKk1E4jz4FWARvd7RTVwONBm
         Ca6xy9K+HGMNi7a7xLrTZKTlp4Bv94CZIeqrzgpG+m98XzI7ssOXpjNHewvnTRvebvp1
         M+H0EUAbM2YmjbwI8XDwv3WyUxftv+RoUoMWXn9RqfuO4wFV5qi9Gkp830eroah3qOyN
         DPoA==
X-Gm-Message-State: APuU4Z/1mP8FKCdEFPw3FujkmSyvAPmgNcjqh8yaun2wCeTFjLGvY9+q
	berWNwXzSnQVlR1kNuVSC2Jkqg+5MeRHYPHoVRzOp2L+LB8s+m4CkMSEnHLsFha137UUB632Mgw
	aEt/VUg==
X-Received: from pfbgr6.prod.google.com ([2002:a05:6a00:4d06:b0:8b5:b13b:bc77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:909c:b0:881:4b67:ffd
 with SMTP id d2e1a72fcca58-8bc1cd60773mr3020747b3a.26.1794412187659; Wed, 11
 Nov 2026 07:49:47 -0800 (PST)
Date: Wed, 11 Nov 2026 07:49:46 -0800
In-Reply-To: <20261111024039.676658-2-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
 <20261111024039.676658-1-sashal@kernel.org> <20261111024039.676658-2-sashal@kernel.org>
Message-ID: <avSOmjBbfC60rZ4T@seanjc-mac.roam.internal>
Subject: Re: [PATCH 6.6.y 2/5] KVM: pfncache: stop open-coding offset_in_page()
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paul Durrant <pdurrant@amazon.com>, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Sasha Levin wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> [ Upstream commit 53e63e953e14a66b7d0d7e9c616cd602f3da9291 ]
> 
> Some code in pfncache uses offset_in_page() but in other places it is open-
> coded. Use offset_in_page() consistently everywhere.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Link: https://lore.kernel.org/r/20240215152916.1158-7-paul@xen.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")

NAK, patch 5 should work without this.
