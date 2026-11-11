Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412208;
	b=LAX+CRG/OQEVZbQxA+RCm55aBlQIfL9paSzb3xlmygpQDKgwDr63Vxd2M66vvdqPG9cC
	 FZZyHWSUbfjVrv40Ipne95bIITt88i4G/8qNwaNbn2b4WPEK3YZBjYhIfmInhuBhgf8oc
	 LWqoAVmPRN+Ffo7qjmbUPMGq0nFxGIvZts2zPhHOPQDfkGnbHsoCgRpH0mHh7PG853zIR
	 5uQkqEIXjTkGdQYE2RDczosGcdtEAOlON6ok+Hnm/HV3rkYoMLtSkYsiFPvBO+VQUcHl3
	 +daM3icbnALhe/tuGZBkOAN/sspZS4Axvcx84paz+38105W6AYA4e3SVempEQisUmuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=p9uBxF8zAwsGzViSKWKNClth/leQ7GkDq8uq7CMUhPA=;
	b=Y9NdlkFI+HyG2FsiCSS0ZkFvU9MkVjD1TqCVbxavBfjYxBiOe0mU+g/cKmhnn0RJR3XE
	 NLtc6KJYkNcRr0mfQpeF2U+f9fon8hPpPgFG5Gh2f+LrVIFpjZUi2+Ry3lsmKs+gErb4I
	 9OY34Rmb8qgXEiceVL+IkI9RWdhtitB0sGcMPb5VgTrA2ejg38yOKjWSfHRuhPAxaQ3gg
	 2zTiec4W/La7KQRI6fg5OEdvMh2p6XrHZCGU+1TG7PQrLAmKyRun99cn/w0j/iTCqFul0
	 ZU8PLJ69Vlz+U/gibmtPkb1gwQ9R2XHfR2NhndFmP6COiHLrhlvixzUxBdF6mwKKo7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXACOPK0;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4D606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D4D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXACOPK0
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so4674945a91.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794412207; x=1795017007; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9uBxF8zAwsGzViSKWKNClth/leQ7GkDq8uq7CMUhPA=;
        b=LXACOPK08bCHJNYaTs4XReKtYgQEO2ozUqs3F8xs1NZqAhys+ATr8QQaXdtu4cBzRs
         44PnoljQUMGUlddxS79ZmxCyRuGq0h0pTagmg7eP4q7hLjnTbcgDcfZtSwGfH9iUYXUq
         dGNEpuYFNQ39tsMG+puSWzaYUWgQlwIEbey7zIuKVke/vmB9Q5rmP1VjXOju20GzZiKY
         WOCHcijGozdM4vkxjlnCax8sLwqAvswaJEA6yi9Eduwj7hYfmCGr2qR8NxNujH5DUZtr
         S4wN6LBNqyWSPQvdQjeLmlR4cHAROJfI8sPZUIcjcm3wrKXVHnnuvhsIGQwjbCfVsEK9
         9UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412207; x=1795017007;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9uBxF8zAwsGzViSKWKNClth/leQ7GkDq8uq7CMUhPA=;
        b=Edwl5nhyDvJW8mC96vGwBPVnO6DWoukRX2RGvbZ4aTaU5AsRT7hOHRFcZ1yNty0RZQ
         tOH4sxVA0p4RV4jQdI2lmXSk1XKdXKXXBORlI3IQAb6jax5APg8ER1BiP+DDBIkByFk8
         qMyOpzgUY17mnl2suIl8oGEntO35vFtXQkV6gOWqNTedxYVVBd0n9YVJwsIxO2o56NVX
         9XuMuMF7SA9bPb/um+25FJMExHM+kE+SqRO+M334bUMTEqjUcl8m600bYF5KtLil5L3t
         Qmj9DHJlJhA0Kydh7lbccMGTkI9C+UH0s/4jnoHg46Engjb5JpOqed/t39DxdsrzLxq8
         UkwA==
X-Gm-Message-State: APuU4Z/WqiXhN0GbEcqN+HGeOIDJFJ20RijQ2GTyyrzobcdWbYgdkonm
	EYUcPbgCCdYmMyIvRxt18AdWz9hy6l+4cX9Mfn9RUfrNARNipCRHdlAI4j5OxMghM1hcconnGQT
	cndqelA==
X-Received: from pjbmg3.prod.google.com ([2002:a17:90b:3703:b0:3a8:8cd:a0a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c87:b0:3a8:c0cd:57fb
 with SMTP id 98e67ed59e1d1-3b182f22e4amr2794156a91.42.1794412207305; Wed, 11
 Nov 2026 07:50:07 -0800 (PST)
Date: Wed, 11 Nov 2026 07:50:06 -0800
In-Reply-To: <20261111024039.676658-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org> <20261111024039.676658-1-sashal@kernel.org>
Message-ID: <avSOrlBDdNHHrrI1@seanjc-mac.roam.internal>
Subject: Re: [PATCH 6.6.y 1/5] KVM: remove more traces of device assignment UAPI
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Sasha Levin wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> [ Upstream commit c0a411904e1548d287dc4a031ff19d00e0569202 ]
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")

NAK, this makes no sense whatsoever.
