Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E93D891C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370904; cv=none; b=Vs4rw4WBOqdHzW9N+WvCdNW9y+hWu+T7u7tpkhQcGGFEUet9fkWMLSTw9kOkD260SRrBD29KkPJ58yVgrkYJ4AwrhNCHpyEIyvj9CQTDZgNt6EhcYXxPVYHZj7N2lHj9IIob+TsppSOv7Hpx00fwh/IVAT7w5caqRuX2R/2/QZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370904; c=relaxed/simple;
	bh=4Fi81i3jK9fp9iQDYM1s+kCEYLp4mWY1a6Jm1VDemYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gGR7cEkke2daRfZq1YfCNx6sbIBocWCSpZ46tktWCQjE4hiifTTQM34Ic+ZKR5ofgC61QsZjg8CVpvaR1QyfAHc3sJc7gGElwnQ6hnXyo8H/MQvcbb1zgNISnVys0sQkZxpbI7sP2zIbY6jD/wQ4v2si+o3/NQBeccOCra14gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvzJtiQw; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvzJtiQw"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so3398871a12.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786370902; x=1786975702; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SazfxBrdBfOprIxCwznIAlYlzM43wuwerTN4/FVvJgg=;
        b=GvzJtiQwY4Uu12M6Rw+IBbCaYjz8skMoPdtHKek5EzIF3Uw+ZHhMRnr4pJGiUsqr0t
         xzP4PBhg5HDbHEz++QRLiAFGBWxIY7/BAgzsXBb7HNis+W2kdGaVxgLoMCWrkvJt00UF
         O+ZiB3YDJnegImX7pJTZ46KNH6DnAJ583Pq889ngXM38wmzldmGcTBG3CB7y3iMAMDu+
         GWNRQGB4H2DFyRipUHY3qotgFBu9Ur27IqCIS3GhyKvPPLXI+gX/Q83ZVBRudhZBFuqv
         psREPrWfLlFVvo1hYemR+JB9VpZ4KG6VK5BJDNNjnYFl/1rd71KKuOI9NGzq/DOKcEvI
         y/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370902; x=1786975702;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SazfxBrdBfOprIxCwznIAlYlzM43wuwerTN4/FVvJgg=;
        b=E52+u3275R2IF4+3tQdrx+jwdtjjE1hweIIJ/ECX7kCat7N0C2vg4qx5HRXiuCH5S6
         fbW1bCo/f8spf79a5vVAfRNcmMKvYPCsWaZ8pxrnhJcvRxQ/CbUeCdp5xIgqx7Ul5QvS
         /qOEs0uRYc3C4KKmew7qGDu8IrsFLCAXz8Ad0qcTMfQk8M8HPxMSY7F/G03Po8INcDri
         a6v1URszxBw+H7PQ7K5RdPQ0OSOzJA2SJsbAUpCexkFk9KlLGMi9klfpG5VFM16puCMP
         zMfBGTsSE1ITV7xq5gCDddtbdtbjB8+dYu2V96DR29dBVTdEmpnNdrfDD5PHalcQ0K+t
         zJYQ==
X-Gm-Message-State: AOJu0YxIbxXDUyp0H0czTZkH7DmbouD8woesxnzzb7yfEBV/nMyIDHjM
	NnGHRaBdp1ySSEWTGVI2Oc/eSZv/FgcAzu+iYBZphzVugZJUGHNDzw1BVMU2WSLRN2lxeRhJ669
	8Lee8Zw==
X-Received: from pga9.prod.google.com ([2002:a05:6a02:4f89:b0:c8b:2f5f:81a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b598:b0:3c3:a024:1360
 with SMTP id adf61e73a8af0-3cb85eaad12mr52607388637.28.1786370901911; Mon, 10
 Aug 2026 07:08:21 -0700 (PDT)
Date: Mon, 10 Aug 2026 07:08:21 -0700
In-Reply-To: <anbL4h3ahwzG8iYa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808062208.522577-1-senozhatsky@chromium.org> <anbL4h3ahwzG8iYa@google.com>
Message-ID: <annbVU1ig24ZES-p@google.com>
Subject: Re: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making
 MMU pages available
From: Sean Christopherson <seanjc@google.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, Sergey Senozhatsky wrote:
> On (26/08/08 15:22), Sergey Senozhatsky wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
> > after making MMU pages available for the shadow MMU.  If reclaiming shadow
> > pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
> > map memory into an invalid root.  On its own, populating an invalid root is
> > "fine", but because child shadow pages inherit their parent's role, any
> > children created during the map/fetch will be created as invalid pages,
> > thus violating KVM's invariant that invalid pages are never on the list of
> > active MMU pages.
> > 
> > Note, the underlying flaw has existed since KVM first started tracking
> > invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
> > pagetables"), but the true badness only came along in 2020 (Linux 5.9)
> > with the invariant that invalid shadow pages can't be on the list of
> > active pages.
> > 
> > Note #2, inheriting role.invalid when creating child shadow pages is also
> > far from ideal; that flaw will be addressed separately.
> > 
> > Conflicts:
> > 	arch/x86/kvm/mmu/mmu.c
> > 	arch/x86/kvm/mmu/paging_tmpl.h
> 
> Sean, can you please take a look if conflict resolution was done
> correctly?

What kernel is this for?
