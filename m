Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577759;
	b=wzFNcY+E9TD7hYdnnr5izlDjlZ5D0oGLVX4q7rms4ozyqR2OEpTGxlttIFAZUZMqcHj0
	 4yyZ0OsM3i0zHQpyykToVDaXUY7g0+kpJqmom3UCiFyICu2GD2TkfgpUxYXaBhgogaIBt
	 INFgEK6svkc2dZCTL8JN92sP5IdtWoA8JBrVBa0WbuvC8aUCFKTsnuXCOEMC6RXMJ0JJz
	 rGwXYhhgDE91Vcd85IEfMYtRuSFk2m1HcSny9vvq/BVyiBxbYfNqzv2DGGErEU715ji7Y
	 i7fJlWgobwu+9/eTlzJvVGwx3p/1LMK8uh+6Ru7Y0JRyrvyv6k9w9Hg84HSj/WwCNPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iaZEgFBO0oN7uYyRNO34L79aitowmvFZR4PRL3xrbhA=;
	b=mEvEGzPurN/aalkRq4rH8q/ob/cbVzaOji7Zqr4SH2RDuJy2qACDdYXbPVzzgk4flrN3
	 xXwfOIxHLokC6zHGUB1gIAOoarzYggDxcrwoI7Zp5MzkD13JmxYUwo4rphl0DFFUf4rj2
	 hGOfg1bYvrZKGx6Ie4tMx0ZnhQylc8cDK+mbSI0HR9SZ134+O+OKDvlCdWRjjAetnn6cH
	 Gk2QIihrJqXI53IgmnsknTh5P9hjtKKGRjL3dwnzhSfuVvM0dTLUYtWKfoehaCa9D4djW
	 wv9O2RcPtiPv44J90C/yK+79rz3D+wMmf0nA+AAeUYplGUxUlY5TMvzZNRmwbe3suNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldea60Y7;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AC606A880
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55AC606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldea60Y7
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso656145a91.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577758; x=1795182558; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaZEgFBO0oN7uYyRNO34L79aitowmvFZR4PRL3xrbhA=;
        b=ldea60Y77L8XdLaoFVYj7SbvCOAQT3aoZ3sqpFSGcD2f4plIFiedS905Gt0APcYH0k
         jRhtDQqE6zKe+9LpBG1ufAX2UgJMZjkqk6JGSV8hTx/qi4J7v2zC1shw6z9KhL2i9V2b
         COfWUvBauXn5tC0VJRNPvD+YpGN95+acz9kH3Q54VDHOFSsvQkEGUBWscp23gYhPByLb
         X9VousiCKXhv0SVOSb/7ukmkTOeSMoLk82UfSBOgUCbuJcBSvf3sdZ9ezWcb/g3E6yAZ
         t7JEj0yWX9AIjqbrPiYqbbyU6GyuC6f0LvWDWgtr1feCG8ugz3F8FjfCbPziVJh6A0+6
         P2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577758; x=1795182558;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iaZEgFBO0oN7uYyRNO34L79aitowmvFZR4PRL3xrbhA=;
        b=O/2Wz7gSEt8uVDUTFLqnUK5r9tFCn3bHzgKl69BCxev6Vsm6SKvVtmhxydlHsKNf5n
         9OPWdp0Cp0TV4Db7MM+8+ALiZV5sxXuTPuwXQTCrtZnRtn8VZ1x0fgpydZHW+Fuq7Lh5
         O71XXXl8PTqtbnaPPNGzgz+uT9sRjCZA0gHsWQmrQdwWKvPe9sV8Tzi9nm/9x6Antxl6
         lFHLOQaNznNPEWpHKRW5dUPmrXOMRljwdBzLCFN4A1JQXnN1GgUC8N6idm7yUYoJkWOY
         Bgk0RyR2mMwuePixwRGOcTuFNBkG/eOuJgKBqzRrQaE3LHTj/EzZu8N7W74bo3FUgk9A
         v2tg==
X-Forwarded-Encrypted: i=1; AL+hErE2e41Pm0znrhPwnbqcPYNRSWYwGPCKesbU1DBtEz9ki6dEXf0dTpspB4CL2GZvVnx2dRUZGuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pP2rgyAUodErft+4Btx8FoUPMcVlK4cIG/VqHEMC7W3VA7akB
	KDd3+nXBI4ZokfiSN3BPL94iPc6W5YXp/Twv9VVS+k3ppwkEIe9nD18FQ9+/Enl3QDNqbiLb95V
	0Lw6anA==
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:3b0:ac19:f886])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cb:b0:3b1:832b:bb3d
 with SMTP id 98e67ed59e1d1-3b1b0ba66d9mr2028281a91.57.1794577757932; Fri, 13
 Nov 2026 05:49:17 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:38 -0800
In-Reply-To: <20261006093354.590415-1-bruno.produit@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261006093354.590415-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441841896.82698.8297015734174614821.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: x86: Cancel PIT timer on failed creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Bruno Produit <bruno.produit@trailofbits.com>
Cc: kvm@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 06 Oct 2026 11:33:54 +0200, Bruno Produit wrote:
> Cancel the PIT hrtimer if PIT creation fails after registering the PIO
> device.  This matches normal teardown and ensures the timer no longer
> uses the PIT before its memory is freed.
> 
> KVM registers the PIT's PIO device before registering the optional dummy
> speaker device.  If speaker registration fails, a vCPU can have already
> programmed channel 0 and armed pit_state.timer through the published PIT
> device.  When I/O bus registration became fallible, its cleanup did not
> cancel the timer before freeing the PIT.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Cancel PIT timer on failed creation
      https://github.com/kvm-x86/linux/commit/381a21cfe810

--
https://github.com/kvm-x86/linux/tree/next
