Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528561;
	b=KzYBKkqHKuMUIWmi2jaiJ/wlXqjlpJZ54pUDr9tnu9oXRQtC3WgWBshhDd0XWPDs9xPW
	 tKJ/q5k9ld/kMsOOymAJxhHjDODogRZs3sQeoRuJBplQdyXDfbrpFS5fBiWde9hrIzhK8
	 Cmi2XY6qrQTZR/+bPqZSGbGAyE03acqKk8/k5+YapxM225SfCHaFWzCAeAF5uZDrikPjS
	 0IxPHzzZVN+4YOAkjIgR/G9gMbJ5cLr714BrtDGp+0ItoJPY/7ENYRj8Lfs/YLM0KMMiX
	 O7deVsuXyegqExw6fV4UPUVscUxmjqI5ZQKdSyrp1P0wsH0BnIxHC4YDR7ZmR8Lihsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=njlJ33l5OqoDckYqSYGuylmOTQxiBjEh77NJyjCPwxM=;
	b=XvK3yKcEJ036+jvogAjsDdZnnKur2zfU5TJ4yCuoeHXoTVAts7FPVnSOnf2HPNxHpS1w
	 kcG8ED1jpos59na75mOijdya4kvx8jmS0aQnGVJ1AILdelfDpiGtMYZ+yCygbT22R5aC+
	 Gv7xcyKMblvRH3TPpZXarsEpTo0QFzJMS4Ely1v9pdvNkVZIEdDfzotq+J3hij1LaifTi
	 8g/BIHuoN4AGjPHRNpuFNlKxoAWAAkCySCAZbZI+8DBbqEtbp3dxc1au3GCYsL7YJd2iy
	 ro/jbv32mjiUns0Lh3jxxMj0J2eczAnh8d1VR/caZyLpi6BEBqXzhYwRSd96oUhOy+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=StuxCrmy;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06C606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B06C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=StuxCrmy
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4649b35bso5531f8f.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792528558; x=1793133358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=njlJ33l5OqoDckYqSYGuylmOTQxiBjEh77NJyjCPwxM=;
        b=StuxCrmyILzFrEACw0ZRhYnkF6RJryUVmNsu9DeO5A58HPNS1DMQ3gp5FuCExjU3zm
         cBNrOt0VT0QRNzvzGqBIiFVMpHrN8+C7Sq9ZimYrLXlruuAKA/KeLFflhi+AcKpiF/Dy
         cZUnmdlctUR+0mLvkbSs5PxxYpx3AzmqmvImRaontZ1qI+1jkoXXar5dqDZoH8NRpXFj
         qAZJT7paCzlc0GVtfBolg3Qrcyymi0M9EQzZVv/9WxF3mJa5E8xJHO1jf7AX354Js2Wb
         o7hqb/LNCeqhVYumUwc2+C160Ar94zOGikM9+QE4xDCSeVGDgBVjsQKI7HIgDCH3onMJ
         HXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528558; x=1793133358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njlJ33l5OqoDckYqSYGuylmOTQxiBjEh77NJyjCPwxM=;
        b=Tsdbs4BZQAWiKu+PfSLRImLcmgSQp2dLshh21EAg+WSGbNCQYQWUVbLGS2KmL7Xwpy
         Rem3KYoz+sYDBXEbksVJbX/yVTPYzrZiZmA5VcxLz68BNmmn63yUekZ8gzzFDkgRyOV+
         +tCMt4yVF1eppMFiiGtIcKqPBT41CShYQpsS37GlN8kevD5l8onTsL5N+VL7c9T6UobU
         CxNI2kxjVP50pYo5GNvtzX95LbBL2iGw8zMw8M917Z45TeyP1+tBEH8cz2GooBxH6V91
         Q209OYKggMtNVcNqAcX+ukkmCQEZunXT+4lg+ZP3rGN/aRjquvsM+jlwL92P9Yhw66La
         wsWw==
X-Forwarded-Encrypted: i=1; AKwUvBxZLVo/tP7XXTJAxxgXcO9rwQnp9x3q3xXXIyZG0c2puhDKQPp8Dl4VbJF7vz1ztc+b+wKTncA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPxXO/38h6hKjXWUhC1DVxu55ot1dvFUl2n4fj5Eal42D1NUAV
	6xTV6jZu1KiAjby9/Qi+XDPjU0yia2HgG36mhoPRfTv7GkIdqQVLzuR9GRrqRYgJgyk=
X-Gm-Gg: AYBFou0Tke/VFGHQ0N66ssfwYebi0unxzN9awCB14VMyKww/tyX4zqmm5dAeU0nPzbZ
	pBgv3SyNlVIIQSMBAsCO0lteJSHeLl92p29LpmD59Wku3w8VweViE8wjKKr0MA7F7059BHBdjfv
	tyoG+jMWtDDCTYB/S7vgsHbuTKfgXwkWWM3+eB5hGZtNi0cJmEXjYnqk3sjYPXX14Nz9l2bdKsQ
	VPCbw6qBhv2pPNvOpIG+69wfutR4SGHwZBNqU7MPc9fRxBcZTsBHV8jhEZd5oj7IoGB23iU3pB8
	pcpgMooenPZcVz95epbaNNwE1xkhUX1EEDKocYY8BdcwvQSUbEcWUMtuY6FgmQbJqB9qnAKOaSc
	zVIKk8l+fz1RJlg58mP1T0ZrlsbihkFs0dvfGZUbNgugX/xnO+otC/nf7b1d04XdBXuGJ+rpz/s
	Od5tG229YzYVonImHITmvXVIX0uNN0qa4JBW9giPe4p86xFp9xkPcziLosBG0JQtSPDP0DL44o0
	M60FRtEGoRIolWZJ+LsI0uWkEXZcvhSDAcGkEsxq8csmt/CQexpGE80CsAhuGdzU5valA==
X-Received: by 2002:a05:6000:4805:b0:48e:10a7:40f with SMTP id ffacd0b85a97d-48e10a70508mr19393904f8f.17.1792528558447;
        Tue, 20 Oct 2026 13:35:58 -0700 (PDT)
Received: from localhost (109-81-30-107.rct.o2.cz. [109.81.30.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c6dsm788025f8f.24.2026.10.20.13.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:35:57 -0700 (PDT)
Date: Tue, 20 Oct 2026 22:35:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org,
	ljs@kernel.org, dave@stgolabs.net, roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
Message-ID: <atfQrKh8AiKnvTRG@tiehlicka>
References: <20261019185002.3428594-1-gourry@gourry.net>
 <atcc-91WerBlJ_Q5@tiehlicka>
 <179252633386.238494.13826191476140121288.b4-reply@b4>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179252633386.238494.13826191476140121288.b4-reply@b4>

On Tue 20-10-26 15:58:53, Gregory Price (Meta) wrote:
> On 2026-10-20 09:49 +0200, Michal Hocko wrote:
> > 
> > Would it make more sense to 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f11491ee9ed5..e07db9514e59 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -7963,7 +7963,7 @@ int user_proactive_reclaim(char *buf,
> >  	int swappiness = -1;
> >  	char *old_buf, *start;
> >  	substring_t args[MAX_OPT_ARGS];
> > -	gfp_t gfp_mask = GFP_KERNEL;
> > +	gfp_t gfp_mask = GFP_HIGHUSER_MOVABLE;
> >  
> >  	if (!buf || (!memcg && !pgdat) || (memcg && pgdat))
> >  		return -EINVAL;
> > 
> > That would take care of try_to_free_mem_cgroup_pages too.
> 
> funny enough, try_to_free_mem_cgroup_pages does what my patch does:
> 
> struct scan_control sc = {
> 	.reclaim_idx = MAX_NR_ZONES - 1,
> 
> 
> now, whether the gfp_mask should be GFP_KERNEL, that's a different
> question i think.
> 
> (tl;dr i think my patch is still correct)

Ohh, right, I forgot that memcg reclaim always reclaims all zones.
Tweaking the mask seems more consistent but not something I will insist
on. Up to you which way to go. In any case

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
