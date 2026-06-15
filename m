Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC773B71A0
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556202; cv=none; b=H99yeJFKoUPFE5AsSzdeiVZYE9GbCfUBwA5JhWwpHuN2b/Me5lniAFH8EVYh7pDb8BsWU+hmp+WqGr0yDimydn2xZahsjkwAF/hwTgWsrBfHU+9FUvsn8ORh4GACUJJMCRNsrX5VI8Q+88e2sBy4Nlri/16TCFqViKIRtTA5f0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556202; c=relaxed/simple;
	bh=ItAbYBi28K0MNqBDjO6bRAnm3lIyowUJvCtTVyIeJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJlDxdzAaUOeHrN4UXjOhrWhAkSqjm5PW9mNvVyuVG5QsFBFKPFj4Wvkfo9ay/M8G3XusziDyyWIx76fHQD1rswtE4WyeXo/Y0JGgwXCaXeSoXu8l43Y/K4NeJ/eqkYt26TkzZe6rmUZXi4DOFBnV9zcidy8S20wBrqnNcbHMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=trofXPR9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="trofXPR9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf1f074a12so38626055ad.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781556200; x=1782161000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IppM0Vc4ukPCYxBBrz8f6rK4ET/XTsCGtsSBhGqG1J4=;
        b=trofXPR9avEaWyEiAggHZBjsxDpClaiod04+q/w0NIffxaRJmxX+BIMANJkrhsUwRp
         Vmg61WY8sa2JMUctGUd/Bl3dEAdt/fjMprARaRyPuOK4RSopIT6+ACXytNhZitie4ktu
         vPkeH2lat88n7jRM5r4zhK+3D6ZvqyMFus5TmWpBxRTbOM5pzloSnCm5cn9lJcEtAjFD
         29VQjju6VtFUMfuGHHxRlkE7GV/F/b0vp4yKFaln2JWy2XOw5deS3ToR+VpDxPAN4VZO
         jj1UMfsiOs8tIwOQCXYxf+Sacss4ETAidsQS4pqR8zT7fFWK59llP0oTR2YdQDcP7Sc4
         mxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781556200; x=1782161000;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IppM0Vc4ukPCYxBBrz8f6rK4ET/XTsCGtsSBhGqG1J4=;
        b=VotfzwdB55W400HbplqH2pcpDh7/48n217TO9JgAaw5AbH6Y6qfkeQLxVCMgvQrNvZ
         6GHDfPvuIRn4960I827+gSNfbyoZwc9hwMtQd2Bw9Z6kMU3NWfcLiIdcKGr/JGzyAuV5
         PgbWetsvdNsDrxyMeyBRGFjqfpcAq9JGj1vxBPHnCflESKZRdSAYbq/9Hg9lHX1oH8df
         Ci4K40gr8P/cCD4rBXSmTG2v5ZOAclvN/3TAKyHdO2SXKlCs1b0pGk8oKjuy25l1IgTU
         9ngKHH9pAYMPHF6CfU23YTuyviCvYi5VeYJBX/xl87mNSZYUajT5nZJloGNNvchGGklF
         6+mQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iMPjb+IxJvfISOU7KhwsaWBltIMCuJl/R2GVQxazUQ7X82J6UD3xDr8AIXjfJN4TyXhE8XSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRjM+uIxsJU89uaGQesimyIG11ka2T6N7J0LAYCvrhqKv5+9P
	HGM5sRuD7oyu8WzK2vf/ZxpmnCcLJnNl7cKvdCimKMuNpbPwHJZ7EGjaHk02RKerkQ4=
X-Gm-Gg: Acq92OE5P40mJHZgsSaDId+A2JOAJCljKah8m5kwU3aVm87suJNaI8GNWVco2NOvxKl
	U4CpMet3MEt5OzhP/3tNbmXEV6/S446ukO8Nqb2sUOM4PglEt1PhwDRV06m6vSvNEV18tK/ofQf
	x9+u9v11OfuGnxOflW0GGV16EW4qBEDbDEuCD8axAUNFH88L9+FwwrgqtkAg5UdJ3wU6L0Jln86
	ZbYzRgYOWwdsVV6/eEFGhBR6zwIYna1ac3b0+/s8JUsWq6ZzTG/bsauEj3fnTbWaL+jmiX+DrRV
	C+wRvcENAhucw1BEWYvEu46MlKApMCTzLRmGWvcoux9MzHfebY8fZtmv7a9mBKWHc6rZ0I2TzoC
	fwE9eIHGeZFP9cXBwkOZcJoE+yh0cmAt+r0zS03OJDELshyIjxHxQTRJTcj/vfTR5SiA8mp9hEj
	t9qEo=
X-Received: by 2002:a17:903:950:b0:2c0:b319:fb43 with SMTP id d9443c01a7336-2c69a1731a1mr8508155ad.21.1781556200372;
        Mon, 15 Jun 2026 13:43:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433558449sm114681195ad.78.2026.06.15.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:43:19 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:43:18 -0700
From: Joe Damato <joe@dama.to>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>, Stanislav Fomichev <sdf@fomichev.me>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netdev-genl: report NAPI thread PID in the caller's
 pid namespace
Message-ID: <ajBj5j01YmdS02Uw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>, Stanislav Fomichev <sdf@fomichev.me>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615171736.1709318-1-maoyixie.tju@gmail.com>

On Tue, Jun 16, 2026 at 01:17:36AM +0800, Maoyi Xie wrote:
> netdev_nl_napi_fill_one() reports the NAPI kthread PID in NETDEV_A_NAPI_PID
> using task_pid_nr(), which returns the PID in the initial pid namespace.
> 
> NETDEV_CMD_NAPI_GET does not have GENL_ADMIN_PERM and the netdev genl family
> is netnsok, so a caller in a child pid namespace can issue it. That caller
> then sees the kthread's global PID, even though the kthread is not visible
> in its pid namespace, where the value should be 0.
> 
> Translate the PID through the caller's pid namespace, the same way commit
> 3799c2570982 ("io_uring/fdinfo: translate SqThread PID through caller's
> pid_ns") did for the io_uring SQPOLL thread. The doit and dumpit paths both
> run synchronously in the caller's context, so task_active_pid_ns(current) is
> the caller's pid namespace.
> 
> Fixes: db4704f4e4df ("netdev-genl: Add PID for the NAPI thread")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  net/core/netdev-genl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
