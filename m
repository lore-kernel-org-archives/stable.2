Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5C2FFFB5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577017; cv=none; b=SGabbVcahIuDShYkMTQaHnFKVpG3r+zFsNQ46MtsHjQVZu+qtIbII7PxHUDi35bT4GxJqoHIO0Kko9s1kfg34Ywy/KSROHWVtZc0tYtgFHslwJiMErvbgtRFQdsFQcqeR9UCQObzm2qxl+cUVvnLITZAEkuwGeNvfx9AwRJb4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577017; c=relaxed/simple;
	bh=WTv88pS1piYHaZqCCTqHPSb1WOUAbqfeKICv2O/qElM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tCCLLUvxeFWJz/FbzJCowYFcTlINj7Rh0iDJEo6Fy/k6xa0N+TKFq9FEXg7HSJYMEJexcgVvoNR31uV/T7u0sHvsP5Q/6q44rsOImi40/ahWJ/j9WoxZJ2/Jv0cRxdm0gZhpoY9Y3Gu8ctxKTS4Ef+2Aw8AlpIc53fbNX4effqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+05I01O; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+05I01O"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso130110745ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784577015; x=1785181815; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ef1+IvZCLF8E/vl5kLc0HDclZmYX/lxxqgnA8GJxZ6w=;
        b=r+05I01O7rm3xJZJ5zFj15GwmZUHfnS6ykPFIzh6P0kCRObitwaHAJoiF6FI58YfZb
         mIC6LY4sWfzNgqfP9sAY5gB+tGiwkqTFolBM4sAyFFyNrVfo2rHP3wiWFeKJAVjvbyTb
         uVi0DhzvPI2CnTV1o2J2KXRe0K2j2fTv3guW084Q2R+IJiauavxym0aZY0zoEDTbY6al
         5M/8ihKRF9GP1QNNYT+NEOaqB3bqUrAftTbOfbaY128muZIYLvf+Sw4OzymsK8iAa+U+
         KBl2MuXZ1zG/upnP3WBJWnuny5t5GZeN/OPUgUYp2G0wvZxufGA4cXfM9GnzVsoUp4YE
         EXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577015; x=1785181815;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ef1+IvZCLF8E/vl5kLc0HDclZmYX/lxxqgnA8GJxZ6w=;
        b=Yvza7gwWjdK1RPKsaqdO8ZMjOiOi3OtQT0qtP6cSnub6ufY8jvu6bbbdtnG4vwDnF9
         6qQDUgJwpqD8PewhTmPQEWDcwQ9IAIfQDyC/qgB9EH31mvo8u9n6ehW5RZug9+naqOci
         CdhkbPVkVC8Es6kGambMax8jIFrmUW9ETcQt3FLYhtM+ZYt80JHHeSKhExHaegkg/l3n
         l1KglHXB6Io1lDeA1m8NoZMznI84nP1wXh0d5l17rMb79wKawnUvJP9PrPpYTcZe6UdG
         bH32ZS40qqOnYabbJ90Sf2gXZPwFfrj13G0qsNIT2wYsRiMC6RHWvtfmV1rtx6H0Nrhv
         QnNw==
X-Forwarded-Encrypted: i=1; AHgh+Rom2D7EGFW2zPfVft9FDVvzTbAw8nnHxlq7R74rb+kKDPcSlA8Dz5IZmVHmDn65l+pRDmMs5/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxPH68DErcjNsW517DPmC0ZJPk6ZDT7/5Qz1w+1sgtwFuRZ3B
	brjHOSWtfaCd68CouyS4QTR3cxmUjLlnY8kzFGXc89Mes6Mg3gSf/PqOoSdZsJYC0M5DExFWLRR
	A4y1QAw==
X-Received: from plda5.prod.google.com ([2002:a17:902:ee85:b0:2cb:97da:d8ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8a:b0:2cc:61e8:5fba
 with SMTP id d9443c01a7336-2cf349a2153mr164731445ad.32.1784577014659; Mon, 20
 Jul 2026 12:50:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:50:14 -0700
In-Reply-To: <059088ac-81e7-48a9-b4e1-05dad48975f6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715063626.65899-1-pankaj.gupta@amd.com> <abecb83f-aea8-403e-bc10-4d8d878c0d8c@kernel.org>
 <059088ac-81e7-48a9-b4e1-05dad48975f6@amd.com>
Message-ID: <al579lcf0NnxhD3T@google.com>
Subject: Re: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, pbonzini@redhat.com, tglx@kernel.org, bp@alien8.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, ljs@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 15, 2026, Pankaj Gupta wrote:
> > > Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
> > > encrypted memory regions") added FOLL_LONGTERM to
> > > sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
> > > MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
> > > FOLL_WRITE on the pin.
> > > 
> > > Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
> > > guest memory, such as virtio-pmem host memory-backend-file mappings
> > > (MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
> > > mappings since:
> > > 
> > > commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
> > > commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
> > > 
> > > Region registration only requires long-term pin to prevent page migration and
> > > does not write through this GUP pin.
> > > 
> > > Drop FOLL_WRITE and pin guest memory only with FOLL_LONGTERM.
> > Worth mentioning here something like
> > 
> > "In the past, FOLL_WRITE was required to trigger CoW unsharing, making sure that
> > we don't end up replacing the page in the page tables during a later write fault
> > after already having pinned a (shared) page in MAP_PRIVATE mappings.
> > FOLL_LONGTERM does that nowadays (see gup_must_unshare()) even without FOLL_WRITE.

Heh, this was going to be my exact question about why it was safe to drop FOLL_WRITE :-)

> > Given that SEV only pins RAM for XYZ and doesn't actually write to the pinned
> > pages, we can just drop the FOLL_WRITE"
> > 
> > Fill out XYZ :)
> 
> Sure :)
> 
> I will update the commit message in v3.

No need for a v3, I'll add a blurb when applying.
