Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411994;
	b=G5+hHtPDGKK+gr1o8YawqnK/+2N733ouIHsW6GABVDwPV7AuQWmmyL86c5+b5wjW7YoE
	 oN4hSp9l9ZoMnG4KCUBEfyXAf2j2J/U2PvHM7Rkc+xF7EgGpEF/XS8b3YCbPfGTnCaZeE
	 QdZtYcgIGvGtJNBWZ500No6uZDbRsLNMW8x+xPgpfjmlc5RxGFpayPBrn98bdsd/WO9L9
	 0YNOcQ2esStv2StVRuOWj3QxM1/tXlanOkCgjIOmno4SrCcfUUv/IJJXbYgz73qC198K8
	 OFYwUWPmEZXg+Mhx0J+q5+G1DARRmXJmRN+VFMnsm2H1WbMSTHKtawDs5VcBTVxyoKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fjF3PuqsrWfQtsmAaIVrIs9bHEEy53yBV4BWYGnSgVQ=;
	b=bg4WRCIwF8thi4E3fWWVv3vCi6lWsXnS7NsP/qvh5vv82OOYeZXIIss+A5UPz/dQARG9
	 IRLTPjJuYV43aMBpRL3dlw0RFZChXrM8LRNeKx5/voqFVKGx4OG5Nl+1oLAfGz0NaOmI3
	 syGxnGoIRutDkO4AfulncP0NBfvErDoBg3qK0BP6DvXxhnTYcpNJDUk0n4TAejg+D9hId
	 olhbLhmDJFSvblaVswX45J5UE8VgQ5Y4ru+p5yeJNxXn44al0MbZiL1XoHNXTb7y4HmMH
	 t/XsI6PetRdXvI5c7axqmrZp52Tw+8m/DSxsmIdZlHYMSS2Gh3y+xhWFo/ehkFS22Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GYeAId0G;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8677606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8677606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GYeAId0G
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd61bdc8683so1770478a12.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794411993; x=1795016793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjF3PuqsrWfQtsmAaIVrIs9bHEEy53yBV4BWYGnSgVQ=;
        b=GYeAId0G4pj+0B7Rj0IEQ6insRMQ+bfmgCfs/LIP+hx5TAL414QpSZJiJyPbCUdbmH
         0wTqam1h1H/8jIm+0YJ5kSdnOVoa7FfrnrnsEzndqh+iYMl5Ijwl9Xhz6v5aYQkSKF0D
         Wta4X5xBS2qDK24HJbrpKbZn6xn6583rwIKOAfmcssbJ4JmODgBM42h/9pEalsojaMvX
         YEyOl6C0VNOmAtX0/+cJXQwaEJvBWI43i5E9qDZCk+yMPZOnBuXfuHRuxxl0qkgw4LvS
         T3R81rLnFaoZqqj/xDRpzHOOZiFHwXaAKxBt6u4i0KoQ9V+BvY3I03aCLVCNTHMrxyTj
         FiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411993; x=1795016793;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjF3PuqsrWfQtsmAaIVrIs9bHEEy53yBV4BWYGnSgVQ=;
        b=snhcH9SBTSxGmkoNF3XXsOujTWEnOXVpH3pejzviMa5/szD6hL9lOkPUDywgtC5DAX
         SrbY/6SW/wkpBiPmFy0AxQG7QtcmmnhKd/f4Ww24n5d1lvzgsagTRlQu7Izb7mw+E3CZ
         sL+GOp9CzVO/+1nCuOdCzIZAqV/EcUTa6MUdcyjdJr7vzN74CrqJshwvkhoVCZxZePrW
         ZyV9adwlv7f7S6q4b618hbrnYuGGnTGmiYJtlSTDcfIygW74xHTaUpa9gfAs1Cu163//
         xsCzxfRBSr09EqhwCAiludXJ76rJPCuuMSIl0lQd3j0B2AwazwXVjRUha4xqDxdhOYaR
         KIlA==
X-Gm-Message-State: APuU4Z/iKjX7fsRhhB/XNZZG4ZM28/sbO9T2TBFGD7DapnywRFHoLlZY
	aKwSaRtdiOeubWaJ4fialVsqH0zeZsW4nVmAKW5bmzHt4nk6NGvTLCISEzvlLo8a/JiUsQ5T6b6
	hRhUg2A==
X-Received: from pfny12.prod.google.com ([2002:aa7:854c:0:b0:89f:6242:b2d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23d4:b0:8a0:2b8f:ba7b
 with SMTP id d2e1a72fcca58-8bc1635a56emr2804186b3a.0.1794411992675; Wed, 11
 Nov 2026 07:46:32 -0800 (PST)
Date: Wed, 11 Nov 2026 07:46:31 -0800
In-Reply-To: <20261111024039.676658-5-sashal@kernel.org>
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
 <20261111024039.676658-1-sashal@kernel.org> <20261111024039.676658-5-sashal@kernel.org>
Message-ID: <avSN16QFmmfYhFpZ@seanjc-mac.roam.internal>
Subject: Re: [PATCH 6.6.y 5/5] KVM: x86/xen: Enforce 4-byte alignment of
 vcpu_info registration
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, sashiko-bot@kernel.org, 
	Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Sasha Levin wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> [ Upstream commit eacdb76c5f04956035c5d7f7e1973028f30684a2 ]
> 
> Xen's map_guest_area() enforces that vcpu_info is aligned to
> sizeof(xen_ulong_t). KVM has no such check, allowing a guest to
> register vcpu_info at an arbitrary byte alignment.
> 
> Enforce unconditional 4-byte alignment regardless of the current
> shinfo mode. This is sufficient because subsequent commits ensure
> that all locked atomic operations on vcpu_info fields use at most
> 32-bit accesses. Return -ENXIO on failure, matching Xen's
> map_guest_area() behaviour for unaligned requests.
> 
> Originally observed in review of an unrelated patch:
> https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org/
> 
> Cc: stable@vger.kernel.org

Huh.  Do we actually need this backported to older kernels?  I'm not opposed to
the backports, but this seems like a rather benign issue.

Oh, /facepalm.  We didn't tag these two for stable:

  https://lore.kernel.org/all/20260831213632.81023-8-dwmw2@infradead.org
  https://lore.kernel.org/all/20260831213632.81023-9-dwmw2@infradead.org

a.k.a.

  301a5ced32e08e96212b413e896ef4c32d1ce961 KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
  1835551d4304abb1edcbf5d1ba71945279051236 KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel

If those cherry-pick cleanly on top of this patch, then:

  Acked-by: Sean Christopherson <seanjc@google.com>

for *this* patch.  Otherwise, I vote to scrap this unless someone cares deeply
about guarding against an oscure userspace attack.
