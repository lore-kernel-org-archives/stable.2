Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF62E8E09
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493769; cv=none; b=ObUs1WwxIt/W5DKxH2Y8N4k8IuqALRBXPh/yRWwgr4tiJhXEBsT7xRN3oklwAkSpla6ds1Pv2e8hI4zYAIowuPnPxyUDVSC5IECS3w7ARvN0Rk+X3YvUALrDdvkMfvY7VoHaepSQqPG4OpFdfZERc6z29JhgkoDF9J/4lhdXrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493769; c=relaxed/simple;
	bh=M1rufIhD7IvaoPOzTymKGetZ6Rh6wUAkv6Cg3RmfhD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr4zAfg9xpntz7EZ9Deo9Oi+ViZMglUfOS7ITm+NV0yYlghpHYxrzuU5HfAITArTQUukHp+o2ZHoIRUwuYqu19HNiMf/ZdpXxYFSl6VM7kL4fXqhKtxy6h9WYNrxB/lgpipE4uqKhDguM1/AwtJo9tRcl2ETjeYH8h88R8Fa6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mo55CQGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mo55CQGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D29E1F00A3A;
	Wed, 12 Aug 2026 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786493767;
	bh=Wxzl6tUCMMvV8EaTaeNBVaB9ueeSQjDiQCMVnHESaXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mo55CQGzirQtLI3jfSod8jBf93ZPcmWsaYZrRBK53ZC1uHs4Nt0A2YYCjnqX9qOF6
	 lQP75/RC7hyaFZX4uCqoVPd1+Bf9OLeN0FZNALH4bsrS6dqCsHwhMzx8VEjYJetUyQ
	 odIJsg5Yqn0AldPJN9PhUtJHDuAv5KviJbJ6H144=
Date: Wed, 12 Aug 2026 09:14:34 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guillaume Morin <guillaume@morinfr.org>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Zijiang Huang <huangzjsmile@gmail.com>,
	Kairui Song <kasong@tencent.com>, Hao Peng <flyingpeng@tencent.com>,
	albinwyang <albinwyang@tencent.com>,
	Baoquan He <baoquan.he@linux.dev>
Subject: Re: [Regression] 6.12 port of CVE-2026-64415
Message-ID: <2026081226-herself-obvious-3955@gregkh>
References: <ansgKOOXi6KE3oKf@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ansgKOOXi6KE3oKf@bender.morinfr.org>

On Tue, Aug 11, 2026 at 03:14:16PM +0200, Guillaume Morin wrote:
> Hi, 
> 
> The backport to 6.12 (commit 60cbe67d1342f34b66df1c2ee328e3cd333767d7)
> of 66366d291f666ddeda5f8c84f253e308de3e6b55 "mm/swap: add cond_resched()
> in swap_reclaim_full_clusters to prevent softlockup" seems to introduce
> a regression.
> 
> The cond_resched() is called while holding a spinlock:
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 883333a87a45..552df432c37f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -767,20 +767,21 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
>                                         offset += abs(nr_reclaim);
>                                         continue;
>                                 }
>                         }
>                         offset++;
>                 }
>                 spin_lock(&si->lock);
>  
>                 if (to_scan <= 0)
>                         break;
> +               cond_resched();
>         }
>  }
> 
> The 7.1 and 6.18 backports do properly call cond_resched() after
> releasing the equivalent lock.
> 
> Simply moving the cond_resched() will fix the issue:
> 
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -770,11 +770,11 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
>                         }
>                         offset++;
>                 }
> +               cond_resched();
>                 spin_lock(&si->lock);
>  
>                 if (to_scan <= 0)
>                         break;
> -               cond_resched();
>         }
>  }
> 
> 
> HTH
> 
> -- 
> Guillaume Morin <guillaume@morinfr.org>

Can you send a patch to fix this?

thanks,

greg k-h
