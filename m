Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0824B04BB
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170442; cv=none; b=n0WU5GSDbtk6BXNLrWnHJ2/XRV1Br5+4M8/4XX6cHYzvSj0SMVykNAcdDajqlwDoEMjWS8clis5NUfBpIcbRIfjE5CEt3EvnlLoHrHrg2b6eJUPZycb3AYW12/6REo7poJ8886kGJC+lsZ7sJ/I3LOL3lHM6hWBToSu226541c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170442; c=relaxed/simple;
	bh=qSpKm8qVYSOvTOxBtt60ZAQRhUBfGoSzWBg5OmCgNqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqr/D/eliA7wGe0M52ivEbXlRAUFMcJLsNC/iHwlrsJ+AgmAquKO1AaqyH5FoNIZTbVntYsCB/fU7KnTar57t1MSmmg4oEk0gGf+/Fu4ch+NOmJBR8fdxnouTeemkWnOmRZN/Wwm07vL9C7QeBRYX+KOt4E17SS0uEICSZ2I1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T5cdrI+H; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5cdrI+H"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485ef63b68so506454b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786170441; x=1786775241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lTGXhZkKkMjM4bYTArrd/IOVVBEpZFENtQb7MJWwmLI=;
        b=T5cdrI+H2EB+c9CC5taQjhrLCwR+N21OU4dKgFUFSwRVi2aGBG0l+ZZ8mRXRSGLpFT
         ygNdg8FAp6csnEgbnupVwH9uK4PfFg0FydpcMpPyyOUQ5/VymHP521nvmhsVJK5T53gf
         YY8/kJa9rjRwKJvxjixnGQYc13JmteMtCvutA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170441; x=1786775241;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTGXhZkKkMjM4bYTArrd/IOVVBEpZFENtQb7MJWwmLI=;
        b=ZJAmCyRr4mbnsZ4th19tE6SMfxnNXmNSbVrJADyQMI8X+SJv4+vHKXA0mdI/wyxaDo
         59W60RSDnzAmQK3VjE49Jy0Rh9QElXkkvwM5XnGrXpzoxC11G7ZfBi9nvFr8wx+6syS7
         6Q6JxF2kH6En7/ai7C//CPCvABFNDozb6LRY4LAvmIhL/WBxmhL0TwyWi2bIcvQRxpZO
         +ypTZ5m8PHP+MgyuYEjboTFDviOF+6IFdsd23LSrWY78955U9VjUODL/mQI9CMYSliBh
         7LB5lAVRcXYcDYxELR2rTv3H3NY5BE2pQCtVNFmXYIitrGrcUllMm6FF2sn3ERFXFobL
         sEhw==
X-Gm-Message-State: AOJu0Yz5Jf6x/cgyTEUe7oUscei9uTkmCMAz4dxvTW6D9sqZUlBo/f1Q
	AVrTh61cdtb/XAoQGgGcRsc3KyORJGq1gbfuiT9pwJb0+ISK8+VJ0eBmFs/5kzhWWA==
X-Gm-Gg: AR+sD10HJi2NEOxFYnoZXr0ntdTtvNvYQH9i+/oV3vdbAiIY4GyMZCPeuIlICg/VVIL
	Tcr8b4AHGuaX8agdZCoA0FX1Ka9E3qA+pPVeTVa/QTM+HNgAtRInE0COFunllArCZS+W8i05yxj
	V2HqcW5bFkDt4nGpQCYbQzxQWn8qMb4gGS9kox7xJrsKgrve71OZrleyhXECeoULT29e95KrrRg
	pL279H7udWoU5QltDrIyWSYosYwZ/9qk2B7+5tLX5js4Aq3VC+8+TEF1iwAvgsYxwb96PN0LgN5
	D2a/S1MOi56vVfDvJtAIlMWEK/VDpJtZHHzhsvSqNONP7nNJQHd4IV20gE0LcpekYbCfAUP1BW0
	JS3AIMSXbuBLs7O/Xpcd1AWG5VFuw5VU2QbGqXXPSyzcMfpMROqiBi2fO9oit3I1jVHEwshChKe
	7he524nxc8MnCTUuCzGNelZ6F/NFl2qNpCAbvR5P+0vRzLJszwp4PXSyJNjzy9ToCJVBp17VPwU
	ecMcYyl989PtcVl5QBWMck/rFsS
X-Received: by 2002:a05:6a00:c95:b0:845:3033:6cb7 with SMTP id d2e1a72fcca58-84f2dfc8ec7mr27764185b3a.9.1786170440671;
        Fri, 07 Aug 2026 23:27:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f4e3:f7a5:b8dd:b3e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f429sm1786650b3a.34.2026.08.07.23.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:27:20 -0700 (PDT)
Date: Sat, 8 Aug 2026 15:27:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sean Christopherson <seanjc@google.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making
 MMU pages available
Message-ID: <anbL4h3ahwzG8iYa@google.com>
References: <20260808062208.522577-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808062208.522577-1-senozhatsky@chromium.org>

On (26/08/08 15:22), Sergey Senozhatsky wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
> after making MMU pages available for the shadow MMU.  If reclaiming shadow
> pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
> map memory into an invalid root.  On its own, populating an invalid root is
> "fine", but because child shadow pages inherit their parent's role, any
> children created during the map/fetch will be created as invalid pages,
> thus violating KVM's invariant that invalid pages are never on the list of
> active MMU pages.
> 
> Note, the underlying flaw has existed since KVM first started tracking
> invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
> pagetables"), but the true badness only came along in 2020 (Linux 5.9)
> with the invariant that invalid shadow pages can't be on the list of
> active pages.
> 
> Note #2, inheriting role.invalid when creating child shadow pages is also
> far from ideal; that flaw will be addressed separately.
> 
> Conflicts:
> 	arch/x86/kvm/mmu/mmu.c
> 	arch/x86/kvm/mmu/paging_tmpl.h

Sean, can you please take a look if conflict resolution was done
correctly?
