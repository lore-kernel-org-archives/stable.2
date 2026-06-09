Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F6253B73
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004706; cv=none; b=KV6zEhxJcjVjPCxDO311dQYHEYsfmYWRWR/cunc55RGbsClplN0Bnl/ztJMepvlrJuNEVzPNkK4BMIXLylInzKb0I+WvJ7nElMaPw1wtVSZZZA35ID4qu8prplh0mLh+dBOX1N+wZzm6f0wF8xIyZk1BkdIM7wcQjbFHJpr5hsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004706; c=relaxed/simple;
	bh=lgW/sfdUAlKAoRw0Qe3062k++JfjlL53FG9dErf/lMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od1o0HV7uM4iR0HUGZMvSbPD2KFKtnBPK6zr0OWChlLTBp+40wjVKRT5vayN7Y9ZiO0kKeUwfDTZJn6GTaj5b8KtBcTV5ispQotJ+G90yT1etyyQYkjfSuarYA+GZtJc3AzRqjfE2ay7svxpmrPOU4jNbCcDGPgUqlXXH6gYbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7r6ldrN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7r6ldrN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so4318587a91.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781004705; x=1781609505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ihKykckTZsKHkJC+MG5bCZ/tiG2rWZM9tZzQJhC1tM=;
        b=p7r6ldrNtI37Nt70YWiY2ERLrnJY5/RJELvufOseMSHwsb65XVbYCWItsuE/31wbLF
         sxMgqmRGyYqdOt7frtKlcvuA3T/Wweo7XVsEwq5V+ycX7MFYdInSB51shh04/X8RDSb/
         HWu6Qys7JhNpgKE1mCx1YLTvVueMXiMnkdtoQxK3vrIZRTPLMAj1C5RMRgtazmG8ZqHQ
         XPAV/ZkWEkl26W84mAh5GkZvq8z/Ew5qpNy4uKyko2stmB8PKoOy7Wg4Bk2dtuaVUr3z
         djS8pU+siB4+HgU2e2JXOjz2J2sTpowbKt0wtbn4v44oYcqQIx0Pc/VJrCnZUujAaZ4A
         Tj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781004705; x=1781609505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ihKykckTZsKHkJC+MG5bCZ/tiG2rWZM9tZzQJhC1tM=;
        b=MaLUNnsAsJbIHgRy/ALIp6nLJJeULuOJiKNGGZXjYZdiEMsPhtdrn2TpBQp1ijZi5f
         3VnWWjQXWsIIlTCQuH+fMmSvemCrM0Tr131K+R6hYTQPEH7NCP54c1OvIg48qzYv1eAO
         wfAP2Jwv8pnU8ft+VJbg7VPl4TRWMCvlfoaZOVk5VjtqCZxwjhCNJAIPiHRhYh96EpFl
         EsSxUVBxqhPuPOI3ibX7IaLm6BnykCDV6UF4MPTV+JndeVN478B/tLFwHNKrIdzjUPU9
         lwmHfLA07m0iw0bv/1neDwJQ39I+LTzJLYY/EsjiFYJUji/TTK64CXKObj+0sQhm7tbo
         bZsg==
X-Forwarded-Encrypted: i=1; AFNElJ9PX5qbjrJDtirhduNFe9aI5fQGMTqYZGHSPzlZmCLK1ttywwxPSW0CaxI/wBmlba7vZVPUGIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz384BrtV7Fy+7kHMilI+ZLlTIi9Ksr7gtZfRXVGcyJhsDjcoqk
	l39DVrUONvfaU+Kh7yQwJi0FRBGMmiZt+HuSmh3xViiaDNnaz8QgdLVq
X-Gm-Gg: Acq92OFt92+M1/tVzf9XuopcmecfC7tdKkQNPGD6xN3zCTRwxDnEFZcbs/8sj/+yNI7
	Xe1LzJkQ9mTk3pzvrHhzL6kSoW+XXXptBDU7GCCmwpNWCeDQ4Botrbog9wTUE1cJ8MVp7Hw8zSr
	0DhYAupL6OXhnsfupgC32BjO5XXzeJzONUIXzVIDQCl0F5mBp1XTM/YiSfY+8SbQP+nUMIeejjB
	AeU9V9fLdlDpDZrGMRrgQgRAlV5qXYTs1kENYVPopKqljh6cjMuhx2va5bO8rU677yjiu1O/vmM
	dq4ozCtfBtJRdHjOehOQNYDLfTSjRMtdUDT6KvcQfZT1JC/cHg77YrNE+PznlteH5wPngGjQ2aj
	Hcc2tuYwaVNuJY4shs6u6IhOJuTcKVFpnLdY/N5uxKZVY4Wgpsm4ybErQhSUlEjOsTe5llCBgvJ
	w6Iwl8Hvqj4xKPghx7u0eqolnnq/SVHnTC3ftpuWvYpOtIorT51GSwJQ==
X-Received: by 2002:a17:90b:2dc7:b0:36d:cf58:b79 with SMTP id 98e67ed59e1d1-375211ae901mr3074218a91.19.1781004705003;
        Tue, 09 Jun 2026 04:31:45 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221d1absm25724233b3a.9.2026.06.09.04.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:31:44 -0700 (PDT)
Date: Tue, 9 Jun 2026 20:31:41 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, oupton@kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH 6.12.y] KVM: arm64: Take the SRCU lock for page table
 walks in fault injection and AT emulation
Message-ID: <aif5nV0qvDy6-a9u@v4bel>
References: <aifnUC7gmeniiYPv@v4bel>
 <86fr2wt34q.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fr2wt34q.wl-maz@kernel.org>

On Tue, Jun 09, 2026 at 11:33:09AM +0100, Marc Zyngier wrote:
> On Tue, 09 Jun 2026 11:13:36 +0100,
> Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > 
> > [ Upstream commit f2ca45b50d4216c9cc7ffabf50d9ad1932209251 ]
> > 
> > walk_s1() and kvm_walk_nested_s2() expect to be called while holding
> > kvm->srcu to guard against memslot changes. While this is generally
> > the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
> > respective walkers without taking kvm->srcu.
> > 
> > Fix by acquiring kvm->srcu prior to the table walk in both instances.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
> > Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
> > Suggested-by: Oliver Upton <oupton@kernel.org>
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > Reviewed-by: Oliver Upton <oupton@kernel.org>
> > Link: https://patch.msgid.link/aiAZfdeyanIvP8SD@v4bel
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > [ Hyunwoo Kim: __kvm_at_s12() returns void in 6.12.y, so the context
> >   differs from upstream (return; instead of return ret;). The
> >   __kvm_find_s1_desc_level() hunk (Fixes: 50f77dc87f13) is dropped, as
> >   that function is v6.18+ and absent here; only the __kvm_at_s12() /
> >   kvm_walk_nested_s2() change (Fixes: be04cebf3e78) applies. ]
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> I don't think this is necessary. 6.12 doesn't actually have NV support
> (it was enabled only from userspace in 6.17), therefore the ATS12
> emulation isn't reachable.

Ah, I see. Thank you for the review.

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.


Best regards,
Hyunwoo Kim
