Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033C41A4E3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467356; cv=none; b=r57NmLY3gb1KcNHAY0qL9yK/fzaDhJaIh7PfWWZ5j7RuBVHGl8ytfMCRVrdCC32RezHlU6crtp1J1sso7oRh/V4pdptZ145K2rAFV5PdUY5gFhHji5JBg/PnxfUV5StAlSpZayuI7bBOTtKbFKkjBMKoe1OTNnb5yuY2ymv65tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467356; c=relaxed/simple;
	bh=lslLlEBPWTt+hnhyY1v9kgBlyQXXbYeNrQmRqy6D8KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tree2+ApstmamU1JNwAhz85LpahIETyaxdIVtmCqjAERN5iRMGwthTpDinMYyrsKg/NW4tDUkraczoO9yNOZdwDZiK5ETYczAslQ2iUhisgWTy18EpgqbiFFQ4owJKAuUJhyCYuCGXJxe8y5KeJjl45hJ9HK62Do5Gq3nXCrD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQiV85BR; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQiV85BR"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so1218818a91.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786467355; x=1787072155; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYIycIdW05WlllhYT2j9zqXtFyXlxqQx1KcGUcMKCeI=;
        b=oQiV85BRj+gM/SYiXFMzM4ABkVbrgl4SYl88taK6ZVwGGWtLGy3+2wIEpEKR/u9m3n
         H22qCkNCYKdiOPvrNbd5cQnSRsLYK4FQfX/BIUdVDUYNWwMhIpC5w52KTfeO9KaHsI4a
         uiZymW7Hi5tuE097cUW5GyrhojdwkiBMloU97/U4EUj7Siozj9Emfy3+Ab4TFfDJj22F
         mMZJd6V75Kjg+rc1NinN/AFmuNI/D0yhNPwP3pSXm6lLqSrWhEvcqK4Dc29PIkRnqaXB
         JSnb9jauj9jEO7uoKDjtwqAGb4kifNsr7d5mp2WlPV2/8N65tm84ZtyQxhtFI5GcKLBK
         wJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467355; x=1787072155;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYIycIdW05WlllhYT2j9zqXtFyXlxqQx1KcGUcMKCeI=;
        b=G47FFK3BECtIgzaePYRHgum1V12iXnLzXI8aVE+9GiWb5Dh+lpRdgLShCOdxwJolll
         9AlCGA0VnpnlCMZIyxSg8qBYglAYnC9VbMLOegTaOstgOOj6SXnks5zpchs7hZ4hJdXY
         OvDPxsZJSdwKbQWg7sOhgKBOIINx1D3b8dTt+pP7PBVp7L7LlRTvfdSS8T5T6jOM0s5l
         6NsfaJV1vdj+1uyWGYcfXsS3u9aQoQGquUP777P0q7biW6j6G0AdmUjFMcSuusv3+mXU
         4d9IcmqIWntr5178Q8jSvt99NFy3Nvhc4sZEv6xKHbqIXcfL4vdJxPb+Z+1/Sfw83saj
         AJ6A==
X-Gm-Message-State: AOJu0YzYOMV2A2mMqwxao0eWk6p3lvm39AH82jcFXFrmz8xIeZsyYH1m
	k1crmvXoMHhnxlscsOmzzpb+9RhnThcBbTpoNqVDpEJLztTnD5k4lzaRmJTRVA9ZsSZO6lXOxdX
	HJAi+SQ==
X-Received: from pjbji24.prod.google.com ([2002:a17:90b:2058:b0:384:7daf:f48a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2249:b0:390:84db:888e
 with SMTP id 98e67ed59e1d1-392f457e050mr637170a91.7.1786467354416; Tue, 11
 Aug 2026 09:55:54 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:55:53 -0700
In-Reply-To: <20260730121535.2208491-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072556-gem-immunize-5c2f@gregkh> <20260730121535.2208491-1-sashal@kernel.org>
 <20260730121535.2208491-2-sashal@kernel.org>
Message-ID: <antUGRzSP5OUiN1y@google.com>
Subject: Re: [PATCH 6.1.y 2/2] KVM: x86: Check for invalid/obsolete root
 *after* making MMU pages available
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 2abd5287f08319fa35764566b15c6e22cb1068db ]
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
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
