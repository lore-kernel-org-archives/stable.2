Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891558;
	b=4WSbb2ss6+By5aV6iHdAUB2Xm0C3ZsDUglQSdzX1nP2uSKllvyFTEI9Y0Pl1iM8af0gc
	 5xLTeo6x5rA4tfweRaW8qspihWQxa2KpU6Bys2z9HSiGgJW6gscvlfGFEVnNMSm8/f7iO
	 WHULrhe4bQKOQn4Do1kIKo/HP9n9WMu3GNQzMNkLATfvI6aV6c587+3U1rLgZqwQoBxEH
	 rXw4BmO+oBphlyh/Xq3e6EjZc04KwqImjxFJHfVTJY8nj5n2Xbb9TvUiqBr7K0tVcXlfm
	 KNvttVnP6VzP79LX+nVhI9LZcVwr0VrlOlnDpzy9sSQg9Dtr9n47Dsmz3p0wGwfeiPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
	b=QNEYF2mtOIKNqEAR9T1s+BcOS1hVGfrt8V4js04tvwCSMgySRBkHHLWC4LbjR0EAKLxL
	 N9aGlf9poAw/5toPhfqQ2199Cy6Yv7JtWOcaR7yZpXfbZ8O7PapokF2sEh2OBoMGvBU/F
	 2d2N6UuAqRzH/JPtWvu4s7WSyhQmLQ6LXIUzdwhdhU3pV+nuW10NfkiFKtF4b6ioB29UT
	 z2sTxgX0pvjW2UMpdsBkTNJvr45aHOx8pTHsMYZO54YsvqMUHQftsNFJ+90fV8OtF4iE0
	 0/hkiP+j9V/CDrD6VaNyR7wXDws5vazbEn0s0LWAgy335hspDWZCTAt6LI+1XfERvJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qI1ONhEo;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10B606A336
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D10B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qI1ONhEo
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso2005491a91.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793891557; x=1794496357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=qI1ONhEo5O/PUua6b/xYgbH7MhXZqfYLgPob83JACF9YTx7BBm6p4z9NR6jMai1qcm
         PaxoRyVDboPe1GN2MI5loKzDkvOWRB8HRzp1/P/fXNJScCPevciK7pGtXDJ/iu39dA9b
         6qpDX071VclhUe4zMoqbQVUxrw4Kp3oV/ONMzrlc0R+WOneulxq8vGo+W0vJSD78FHuY
         QsRFRMrDNVhpAlvKcgoxEyw0cwcCIbpuMc6YfY3d5RXl5cnhqBA25WjWZ82EP3bpFmO4
         ighzHirlpSOERUZU1VIgt0KnBmPMQtDHWBzBb6EqQ68MJD9RGDCsHsbcZj/AZBQGeuyJ
         fMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891557; x=1794496357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=NOKk/fjNLyNXNmNBIzT/xqp+JKP2XeTfU4hnD2NGWpyN3IQnmED2136NJ6IVHKot5s
         saWqpsa1uv5icKrqiQlesTP4+PJtEL+ipZOEYLF6f6Q4MlfxSlLrN1ZZd2/qFaaHeLsq
         wCM2bbFKUO3b6t6DPDGVQR+1ELcQ5GPJG0JxrsSraIuUbs86kyZQBTxPEKd347byMqVw
         bOwLwPkuM4Y390L/1nzeEEYvQS4khkwDE/kZnanTSGltmaQoK+4c1FglxAawIYwhH741
         ObmeAWyX0hDK8BIyUPK+J17CqOdNrOneaA0aZgBTeEqWTnrgzeEybiqg2j2pvERk0rhr
         H2zQ==
X-Gm-Message-State: APuU4Z95Iq6a7BFJ80i6CnLF2bWutWksNRD6fGKFXbkmnJ5tSG+kOMFq
	xjGl81x4w6CxDAvw/TnN5T5i1phMiRzYyQHEOwLSxwcZ3wGkNIZKN+DYxoUkHzgpLfkOjObffza
	+k8iHjw==
X-Received: from pgia3.prod.google.com ([2002:a63:e403:0:b0:cdb:1c92:d2df])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1845:b0:3ac:9d14:feb1
 with SMTP id 98e67ed59e1d1-3ae8976dcfcmr16105362a91.43.1793891556631; Thu, 05
 Nov 2026 07:12:36 -0800 (PST)
Date: Thu, 5 Nov 2026 07:12:35 -0800
In-Reply-To: <20261105121533.2097788-1-xiaoyao.li@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026110459-cone-playlist-3832@gregkh> <20261105121533.2097788-1-xiaoyao.li@intel.com>
Message-ID: <auyc4_lCvhW64512@google.com>
Subject: Re: [PATCH 6.6.y] KVM: VMX: Preserve negative return value in
 vmx_handle_exit() with bus lock detected
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Xiaoyao Li wrote:
> [ Upstream commit cef48693da1e964e9f192bfc16cd0ed287c48337 ]
> 
> Preserve the negative return value from __vmx_handle_exit() when a bus
> lock is detected, instead of always overwriting it with 0.
> 
> The purpose of bus_lock_detected handling is to force a userspace exit to
> inform userspace that a bus lock happened. The negative return value can
> achieve this purpose, and changing the negative value to 0 fails to return
> an error to userspace. So, preserve the negative return value.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20260819094903.3060020-7-xiaoyao.li@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---

Conflict on the exit_reason field due to lack of 7172c753c26a5 ("KVM: VMX: Move
common fields of struct vcpu_{vmx,tdx} to a struct").

Acked-by: Sean Christopherson <seanjc@google.com>
