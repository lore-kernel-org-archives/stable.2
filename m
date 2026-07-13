Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF0433E81
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950601; cv=none; b=EpbWQwk2qYRjODd8PPostC7a5JfNtIcRIOfd1EzvmUjvPVychV2ya6qH0LHT9lQPFyo+5Sh4O9q93oQI5XIbfE0TsxRl/OQnh/sA9Z/O1f/78fs75Vwx6GgqlNjo4h8O5wscmmh8vDGWe+tAfaLNWc+zrj7a3uvn3dHb8Om9Sso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950601; c=relaxed/simple;
	bh=+lMCCcsL9KhGqzAnvde2v5Etjt6yi8xbmgjj8iFutzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjy34xcOTpWR7rJa8BqIwoh/SjwC2veKm0vJVJeuH7mVYb83+ePSOA0+7DHxAvezi++tuS24MYwzhBKwS6as6nlpvrfqKMoQ6w6+DwUfsENr4ZDBOzI9z8VqvdS/yFAzcpMoolRFyChWMyInZR6+Wzq7k+0idqf69mjLde2P+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=VE3W/5CL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="VE3W/5CL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15cd3fd760so369449666b.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783950597; x=1784555397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHaZPwi3IrnhWNTxPLfcIu6e1zyZHnrUTB5eDWHk9VE=;
        b=VE3W/5CLfwjnt5rRAWRRQBWyjvHP58SuUMw7ueNsskTOU0DyKAq/wIVdkopYq21JQu
         k4v/2XpwCwHWfAHk6NQZQQNqFXTXEqFIxBkMLjy5/CwcPHSBgK2xc2rEbWOVmja2etow
         QDFS1HIa9W7yHBrFAPCC+rznXdYolMGUlTXW4LVRd/VxdOVL8I3to6WHP3mYYN4dFfVh
         uVqGEFkI87ACwMd5yCef/2yozObT62LHYzAdwvkc+uzRn0+TmaTjf6LhNKXhcnyhFLMy
         t+fX3tnzH33Mkp0ORNLg6HZSQE6oUA4cSZiMKuEcz20Crv6xfnp49cOpuATaWI/4gZYY
         b4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950597; x=1784555397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHaZPwi3IrnhWNTxPLfcIu6e1zyZHnrUTB5eDWHk9VE=;
        b=AjoxT5ecuyvSTevb5IEXTNm0yqJhinXT7qbU6Of583aENBwodfpJRk5b1Zae1V7eHD
         fhDU8NwGjKJVF26hPMlLCZXiRHI7mS9ueib4PyoMiusTYBuG5HmQ81X+9q57fKC75Fu9
         3hlAA/6isPmi+eBNYJsvI6f7fgpXw/xyduk7lLwl8A1FC8BOiwA95ETd5xDrdLUKa9s8
         vTbGTAkdSQYDOcX4IiNZwV6RJtg1FfyhWBFi3gW+3qFxJ08TICA2xr6JeBIZ1LPz+5MQ
         BRoflfl8ldJTeRKnQ0SHIbe64yAEZVSl7oCvmL0ZoxJUEDEaSBxr78S66oT0vv0EkBFP
         eVZA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1KwjjvjSkF3FMetZzPOocUBBF1UL6/kqheb8CxwNqHaWFMXCuJSImj7Wvo5HY2xa4KCHGxoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbRPexJV6wEWswjHT1A9kUy42CeQt3M6tw6uaGr/5q6cAxnsH
	BcMStGQJP3sI91lH73aPb4XFNY7VGJT3Ty+/D4gcCzMmixQeITqxwxZ6C6YgpF2dGLY=
X-Gm-Gg: AfdE7cmkQsh3Q8vYEEOPvcZWSI7nK149jYUl8bemGwnXEMVHBjTyuCoAJYQdUKxtgxY
	yEOecdlveJSaDMPHZJIBrzA1BAB5GmtZbxNTDzcukpO3JC9HoXUwWKEOCqja5V/vO91Hj/6I15p
	4FDDJLvqCVvBjbDXhQzBxYL2puFPfNg4aVDn4XEW7jAiV4cGlYBptdjduWoj9U0hiyb+WDVcgPL
	jA4l0YSa9KySueV6floQuH6567oHZYSaV+5DEk7qIJ7sbF/NHO62kTWBxY9+W+05OyTrW0s8JWU
	ZXhZkvEgb1EhXlByapstJNfAQVlnzghjoG9yQROKhKuXA5GAvSPyDsAHOP483iP8/c/dz00sPDy
	3Q3JuTpoIf8KxlecBdmcFaSNUTLeGOv80Q/3UC/1OXXi/fx3K3t2UTRG8FMW9GOqVav71+uMlgr
	bi
X-Received: by 2002:a17:907:95a8:b0:c16:581a:2a51 with SMTP id a640c23a62f3a-c16581a50bemr62872666b.12.1783950597109;
        Mon, 13 Jul 2026 06:49:57 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ca1bd81asm819021466b.30.2026.07.13.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:49:56 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:49:55 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, 
	sched-ext@lists.linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCHSET v2] sched/psi: Fix psimon fork deadlock and
 rtpoll_timer UAF
Message-ID: <alTs1drVX4kb124h@matt-Precision-5490>
References: <20260712174619.3553231-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-1-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:17AM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: - Retagged sched/psi (was cgroup) (patch 1).
>     - Added a fix for a pre-existing rtpoll_timer use-after-free that the
>       Sashiko AI review flagged on the previous posting (patch 2).
> 
> v1: https://lore.kernel.org/r/20260710134945-psimon-fix-tj@kernel.org
> 
> a5b98009f16d ("sched/psi: fix race between file release and pressure
> write") made pressure_write() fork the psimon kthread while holding
> cgroup_mutex, which deadlocks against the sched_ext enable path blocking
> forks before grabbing cgroup_mutex. Patch 1 moves the fork outside
> cgroup_mutex. Patch 2 fixes the use-after-free from a schedule attempt
> re-arming group->rtpoll_timer behind psi_trigger_destroy() by shutting
> down the timer when the group is freed.
> 
> Matt, patch 1 is unchanged from the previous posting except for the
> subject prefix, so test results against that posting still apply.

I ended up testing both patches. This resolves the issue for me!

Thanks,
Matt
