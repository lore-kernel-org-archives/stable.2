Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891582;
	b=rbZ0CNj5DYz2XhfjWka24ny3X1bE7y9DCBeilUPCS0+ks8LkK4bFUs6FVVZ9CFkiLGKb
	 nEDBEzuryD29Ht0bNe8dE8mEJOMolLjr8Jf8yNthaVsSlor564EIYji4wiDSva6QN8r5L
	 e61T1sbx0wVVVp0amifEfbp4T3TJ/z84N6/Rn9nPCaEXi/YbrFH+lGr4ZqIgDbrDJVz/V
	 hFQVD0Bep+2PEeuXHkYLzzXdHFrfJtyouM9/DLD8/zYc5wUmhSRReTr+xEP9d6N/LK6YA
	 j7PG2Gl3ZHceHN7dVYsRa4H02Wz1Olxh4N9/C0e5hgWCR0p/e6I6w71iw8idl5Qtw0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
	b=WaOB4MM6kpvbvxFIIRn57RRWMsOhjQAZIn3snuudm+3Eww5Q+2itBCpKvyrZh+Vg+qda
	 Kvh8d90y8B2/zVqO0oPIbuCV24PoVXHShSvWu3QvTyI5DPBF0I/D+SFkddrZjlGS/osm/
	 H9MM8q9bFFJowUN90k3pnhKUU3mydVa3tfyqIy8/3QGc9F6cBcDoCI1lt4ynbhoS48cC1
	 yIAxOMNlWrwT/+q1Py1M0SRjDtLB5k1pvslaKdg6gatTo5Ub6c2QmsxqaXHNV1iqsHWn1
	 JVBv2unNAJvB9NQyZq0YVde7xdmlYCOxWset7WwMMsW95H5b7WETFamt++5jsW0i1FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HX7ZPRAs;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF8606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DF8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HX7ZPRAs
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so2084242a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793891581; x=1794496381; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=HX7ZPRAsmzxUDvXeDin2+5Dds+G408j6vMPLXPbFamY04PRf9J/7MjROJUUgk7OcD0
         0Yz+KOVbuoVgzL/lgBUEa1be8/w0Zth0lKjj3xegkStFwE0aGY83bC5PyQ8YS9cAWIZ2
         upHdvwxbqNfffGr5wh62HUZ/O5+pJdm1J5DS7hk8ModXyA23H5GY+rneqkU8cPS3ZAs3
         KrbYzxvxk1LiWSOZMysREIwL3MkFH8aX/ves8WXwm5GpBwpIa8zOezYuCsAumAneJM6f
         wtof5qY6bVAOoJDdHrDBZYFR6tGq/gh3DFqQRLCLAatL6mfgRIK+mn2BorDHDJow7aIp
         v6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891581; x=1794496381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=wzOuUVRAPnpGZG5fzxvjET5KcMmh/Vf7awy21DLHDW0EIvjVkzYbglBG/yXk20slwf
         ZFrigJXg41N2a2/ZPAAnYLPH8xYRZ6Jd7h1+sInojIChdMdFjwTOov6AkCLeBaAOr4oM
         KAJQngAHd7RMYhpWYMMCmyJ+uQxuuKEzuNJH0ABHVUyfNar4lGl+3ooWK5QesTb5tQab
         D/ZHcG3rsYiaizoaHsecMyu5eK/+DW70HvyABw4uWX9f2hmep6fLkajJy2O52NGWWf39
         Ka/xxhw3AQ5kSu+bzrUAKQgcuqJWTN7ZVUtlxF9+8UECsO7M2MN40vaXzLPGDFuspCr5
         o/Ww==
X-Gm-Message-State: APuU4Z9A3jxT03Q55rEpYXVlxzm7jIyQFjFHIrpb5IrCjrvOwnwSXW9F
	lRxC8H1JreD5Q81X8sd8VjVCZ/GbcWtyOZ+8DVseioLQT5u5opj3IK5nvNl6EQ4dqaq8iNTTJwx
	kFeUDTw==
X-Received: from pjbss7.prod.google.com ([2002:a17:90b:2ec7:b0:3a8:8cd:a0a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c1:b0:3a8:59d3:5317
 with SMTP id 98e67ed59e1d1-3ae89751035mr16951423a91.32.1793891579841; Thu, 05
 Nov 2026 07:12:59 -0800 (PST)
Date: Thu, 5 Nov 2026 07:12:59 -0800
In-Reply-To: <20261105121632.2103355-1-xiaoyao.li@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026110459-dismiss-purse-35a5@gregkh> <20261105121632.2103355-1-xiaoyao.li@intel.com>
Message-ID: <auyc-6hFd44ROybd@google.com>
Subject: Re: [PATCH 6.1.y] KVM: VMX: Preserve negative return value in
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
