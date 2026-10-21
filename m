Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584811;
	b=UmH1gurbaghf8bYoes0xtBwZHfd5BKIdWiPfU7NTRMkKeoePi1J3L35C/AB4SjBY4M0B
	 BMmru1wHi0X1yYJx8knKLVYSn3liF2/DdU1cxQ40BEXMITEllV9N+LTdvCC/B1jI/aAh7
	 dBobf+k4OG/g8P2cLCKzbogZSQcD1d/1ga3P+9cSKK5dCo+VK/MgnghDaP+cWgM0ns2Xb
	 DS12Fpqe6BQQ7kdqfz9faouoDs/pmlCd/4NcGQQeAIOOWRnrpto2by0MCsX1BsKyZFl+K
	 PbPFYYqSpfAgQ1i3gvr8FuM7JC4JcMFZN+zs1epjvc3oQyCJ8CGSLH+Rs6sRIGruetA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584811;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=C6r9UhT0HEFK6UfPUuCuwD1iwb6CoAylgybqtONDCEE=;
	b=acCFfRy7diDZwIZIBTF2juDbCYO1MEw8+wgDXYhhFl7oDrt3oHZ0Vlu0MTquCQFQgfDi
	 otZ3Jb+8kO9pPlf7sUV0cRocpc7QF6ebXdce2qriwHGnuSKLQlv9li6CmxCzUnImNb4ei
	 54n7zC/2H/tn1RHMHeL2jkkc5mDzmXM9/6qD+GKhvWub+DrDw+8vNF6ze/t9NQ2JcJdrN
	 FruIUh3lCWuDMmxrZrZmVVNbiGf3j035nnJC7qLzPNxWZrgETT+jz7BKnQTa5UdltfvY9
	 mhcfpPQ79HcV+gj+f+UuR6qnbtNoqcphqlpo8Oent8AI/njQLbvAQxOl1pA9Vj9iigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MBYTyeFM;
	arc=none smtp.remote-ip=95.215.58.52
Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD67606A320
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD67606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MBYTyeFM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C6r9UhT0HEFK6UfPUuCuwD1iwb6CoAylgybqtONDCEE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792584808; v=1; x=1793189608;
 b=MBYTyeFMKkcyIw72jF+6bWNkiKIUt3NrTNSgWG912A1qpVtKQIRNg/vL5Poug4XSi7ik7tmA
 Cqh+FYsTt4uKMAPIooWWsTAu0hWwpdJhk2kF4XTt4uVz/ZO+dAKve/abkEfKJkRDBY5PhCnurSM
 LbVwLpoMdDAbHnt57YSf90S0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b83924a915bfa6de;
	Wed, 21 Oct 2026 12:13:28 +0000
X-Mizu-Trace-ID: b83924a915bfa6de
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so8780e87.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:13:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykgTA9PiGrDH0H7eTBJvprMqJxJFrnwaHntKoCjrQkh4lFS8wUbE2rCdPixcFrltJ3eaBgu50=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5nXMZGjaWjZgiQaSNBK8/EntFwdrYCby3IT+ju7hQE8qK/1A8
	iMHuGFO4Kwug7WmnTNovUDtkJcCUHf+xBSnFmB46pryNT8YZfdQvf/gmMRxf9i+q2MQNYsYZQSa
	KaWgj1a8cenjBwaT2//jfpTuPprR1y/qQoZkpqYPe
X-Received: by 2002:a05:6512:3a91:b0:5be:362f:27b4 with SMTP id
 2adb3069b0e04-5be66f45d0emr297020e87.7.1792584802992; Wed, 21 Oct 2026
 05:13:22 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021110000.508827-1-vdonnefort@google.com>
In-Reply-To: <20261021110000.508827-1-vdonnefort@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 21 Oct 2026 13:12:46 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzHFpdR0CD0e0MBRenhci614qVEz=bidKtszqKRoqst8A@mail.gmail.com>
X-Gm-Features: AclHuK9dxoyuqm6J1yx8Oee_PPPZNymPFmNEb-zW_eag5eTNixeBeaxaZ8hZ_ug
Message-ID: <CA+EHjTzHFpdR0CD0e0MBRenhci614qVEz=bidKtszqKRoqst8A@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: arm64: pkvm: Clear GICv3 LRs in the hypervisor
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Wed, 21 Oct 2026 12:00:00 +0100, Vincent Donnefort
<vdonnefort@google.com> wrote:
> The LR registers are architecturally UNKNOWN when the CPU boots or
> resumes. However, in protected mode, only the used ones are reset.
[...]
> Cc: stable@vger.kernel.org

Could you say in the commit message what happens to a guest when an LR
isn't cleared? It's what justifies the Cc: stable.

I tested it with QEMU modified to leave a chosen value in the top LR
at every CPU reset. Without the patch, the guest took a spurious
interrupt when that LR held a pending interrupt. When the LR had only
its EOI bit set, the EOI maintenance interrupt stayed asserted while
the guest ran, and the guest didn't print anything in 150s. With the
patch, neither happened.

With the commit message updated:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
