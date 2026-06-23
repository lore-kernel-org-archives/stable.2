Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50C30D3EB
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231210; cv=none; b=fzaU/WRZ+nKZiTq8mxCz2kYS4MniP5C9p6Ow3GJnRvZtlxmVBp+EWHcEG4S1IaCPBWCgzme145hgR/EXN1ZINIpyupiqMc8RSZH4NIZ20JKKOIdAkYCQm+qViblq7w7swcCkDJUjmLAC20XNSG4IAcEdLqvZWz7kAV5JBTgXGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231210; c=relaxed/simple;
	bh=rB6mVYXXDHOlR5uCYK3SgikrRY57JV1RdtOiSeVXDR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwK+bS0zpv5S9oDQ2n/rnvWXyeJD9sG95EHvO8PV3x3Ipv6XNQL0vwhWzHW8Us2U3K/74rXASJyXgz8SN1pEsxCF0sBKd1PW5EJ12FU3VX9q0+TkLvl4V7QWaBOUXy13u6YMwc3LosmFjihjCzI+RA/F+3ZAuvjPq2hHtAFHabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J9zhV3lm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J9zhV3lm"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8e066990ff9so645366d6.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782231208; x=1782836008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1j3KoSBiivnqdcrOevh5ULZphp+5TbYQXFTFY6Ui8zY=;
        b=J9zhV3lmXoeU7nvc3MKhXdEpylvsr4u0hZ1uyZcscx3b7S8zJD3LjsAZnal+rcoCp9
         +PL9CTvXQqjXYG1RqOHsgH4gG9JTOuyj3/5pWXaAwEY6iFwc/GRas7ihEruebIV5ryMd
         N1/ttXvvJbdyXxzOVyUWqQn1KqS855a0f6wqaVjeQhtPYJ+vHkm11Y9a5jiw15FLa/Zn
         a6c2JfsA4VNyKsvTi4Cuiqbvjt03DRfY0FAEkQ/znIQkXX05gDFYM8o00Lfy9HFkqeqx
         /3VgiWiRACScAPLfdAeQGr5WZzgx0ya8ScWxkLkyljfmSjPRSandNWVwWJBSenUXLVt8
         WSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231208; x=1782836008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j3KoSBiivnqdcrOevh5ULZphp+5TbYQXFTFY6Ui8zY=;
        b=fVjv/dkp54sUENJqgSTrXYdV7RCeT8tB1snnTp8o3eGFsqb2hMnpzQPzHTodQZ8SVt
         +43walzMGczqA3c1kY5rwNPAV1opsRHIEjOQZHMdjpxUYuE+JrVUxKkHvoaIqaowigTZ
         xuBr0jtDl4RHpNvavnvC0VHQZ1z5H18S0fWzqNEsOrAPgrpn5+V87YUpl8HQ1K9tOGLi
         Z1WOEAG5cBNnupZPEtTNrHR8VYHfyGeKzF2NAggy6Zu7nrdw0dM2gYElPS3coPuO62zD
         uFjDkaCOB95oQ3EYrn8rM2ozhEOx7/cf39m9Py8NUF5kzEu1pRZefpYOHzRGFDyk8tBk
         YVKA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2JHNRG4lPdPmTkkmKPFSv15zHHAvCLAI17bXRsGmmVgfVxo2sVsMOW9rOsbZX5oWcbcKWv8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxekn5lITwN3XT1Ra3sGoAUe8xjCu90Vd2DiKUaY94PWbVxcgbV
	VrwqTyb6x6+/O4sHnKZWapUPwN2sPBJGNXqITvbLDk8uq7IBIFYAT7vBqwu6UkbMopE=
X-Gm-Gg: AfdE7cnr18DuqcEGPfpaAYR0ciNRA8juCaf4jpKWsOBJFwiEPyhC9mRw35x5zdgJHHs
	JM5aqWktBiLR9UCqI/Q2Ao8isrzgldV5RZa8Km/0maFEwh7rgsxBUdHB8VPKWQM5mavwiM2ZmaG
	HfIhS+rjNzNjbJEehz5OgCYb01jLwndO/Paee16A4LWnQvScvPwQ+akzcAH4EwV+Zo975tTO9dW
	3fN223fVQu9SqVNdVwdIXOpztzx+1pB3RAUcLFRVZHl/ET+RCl8ryw0e/nR3cuCuvcjh0u8PmSH
	qDdh2vgC6peZx1u4BRB2GmzgjwsYQpvpO5gm5VVv9OYQCZD8pchmiwWjryTWfjq5FXC+/skNC9L
	TyWxH8TgkcD6chCkVB/KjycoMoVZktPNwwCrvZqJqod7rGXsW4FU8IavXWCkTrXr4SpbnzMI8Zs
	ERvpqC2NW7fM0ofa2jwYWzDEs3w0lNyPKh6Dnrd+vM+WycholUka4hsi0KfdG9rvFx6oA7
X-Received: by 2002:a05:6214:5144:b0:8d9:ceb7:3ae6 with SMTP id 6a1803df08f44-8e3b6e146dfmr50627616d6.15.1782231208098;
        Tue, 23 Jun 2026 09:13:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f016d5esm127912366d6.10.2026.06.23.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:13:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:13:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/9] cgroup/cpuset: rebind mm mempolicy to
 effective_mems, not mems_allowed
Message-ID: <ajqwo58EJksSNuNE@gourry-fedora-PF4VCD3F>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621032816.1806773-2-longman@redhat.com>

On Sat, Jun 20, 2026 at 11:28:08PM -0400, Waiman Long wrote:
> From: Farhad Alemi <farhad.alemi@berkeley.edu>
> 
> Creating a child cpuset where cpuset.mems is never set leads to a div/0
> when a VMA mempolicy with MPOL_F_RELATIVE_NODES rebinds in response to a
> CPU hotplug event.
> 
> Reproduction steps:
>  1) Create a cgroup w/ cpuset controls (do not set cpuset.mems)
>  2) Move the task into the child cpuset
>  3) Create a VMA mempolicy for that task with MPOL_F_RELATIVE_NODES
>  4) unplug and hotplug a cpu
>       echo 0 > /sys/devices/system/cpu/cpu1/online
>       echo 1 > /sys/devices/system/cpu/cpu1/online
>  5) mempolicy rebind does a div/0 in mpol_relative_nodemask on the
>     call to __nodes_fold()
> 
> The cpuset code passes (cs->mems_allowed) which is not guaranteed to have
> nodes to the rebind routine.  Use cs->effective_mems instead, which is
> guaranteed to have a non-empty nodemask.
> 
> Closes: https://lore.kernel.org/linux-mm/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> Link: https://lore.kernel.org/all/CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com/
> Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
> Suggested-by: Gregory Price <gourry@gourry.net>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Acked-by: Waiman Long <longman@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  kernel/cgroup/cpuset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 591e3aa487fc..b21c31650583 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2653,7 +2653,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  		migrate = is_memory_migrate(cs);
>  
> -		mpol_rebind_mm(mm, &cs->mems_allowed);
> +		mpol_rebind_mm(mm, &cs->effective_mems);
>  		if (migrate)
>  			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>  		else
> -- 
> 2.54.0
> 
