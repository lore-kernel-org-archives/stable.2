Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D42FBE1F
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749271; cv=none; b=DSNjWDzeUO9YhS1xoB/GINsREhs4+wPgIsl71Uhwi1MRrraVH/8HOwSNkQBvsMhTomXzhIY5fC2/3yiEjqvofVLmCmpFfMJOJ+mvLsGXYyysbSFxnhmzgzEt0U2XJdQpB0jAjo3fkP7QIwXHBg14QEqwDEnI27QYndw8bEeCaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749271; c=relaxed/simple;
	bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdoQAaEWsZ8oDVnEzeOzsHexrfmUAbvNlNT0OaGlqgfmL/seTyh/aBZAC9kGVIQY+Di3gCpjPNbyI+HokjHsACV0T9YMF5C+ZS2FwcYgVbusuduAZbFsSxr6ZViRhPaOmIVZC5OqoQq+GJAo1DqdivpHRPk+mXBjs7/2FTWH9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=dLtyv4E0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="dLtyv4E0"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47d70879764so1003797f8f.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783749268; x=1784354068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
        b=dLtyv4E0xctcWwWXqtndK1SrCB8Ft/7IgzU1pDkgC7pETdYQSn1WZMd/JA2WIEAHyr
         9tZrC4D+IXEnk0FGjPL0etK3ZtFd3UDqbpGDracN0gyGDlaejjVYleRsKnU9QvmrK35C
         j1rJYZeoj2JPRCE4PX9TUu7Ef7wMTunBwhSE1isd5gGxY0yePa68fotLyh6Jzvsti5B9
         T3iRqH3M1ojqJlQdcTH9a+szjBrHIWtHqVReebSoE1eouszLRjFgoForA/A+yQLvCyHb
         D/ZVLTEAdMeEyi/To+xIS0r4EaOySIXA75yZCO6kvgXfIFtUAO+jFSe5FAcViy2Vxr5K
         aDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749268; x=1784354068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s8jLFIScodMQ29MEof5LclbjYvJlO2j6tbNbsN+hPN8=;
        b=aocyNLOi5s3W7LoYFiPEAtxYHicEeegKyV9mcsr7jhx1nvoAJg+Uqmc3ePbJRmW6Bj
         ezLCNjkojnNhjHJUXZg1LJ1MiRqpexepMZy9RO5M5m3PGjLIpgJ3aOP2hUb/DTUYHJE8
         SXG5KDTV5wTvNi/XZv3tQIW6QwSvCTxAiQJLcuZW757vsIVlHQVNN79cdLe2EosgzHmL
         iLiL4YqW2z9hsEKX3mRsgSG1ESnjTebp+xXK3Wl5E8xe0dq8b+NXUFZN4OaSusH8RTi8
         PLxCN8fTpAPU3xyUATtFSQ4LyqhssZ/bbWqHGQefnXcDWuSIElRKjOG0oaHt/M46URro
         pkqg==
X-Forwarded-Encrypted: i=1; AHgh+RqZHxhfxnwihtWdNrjH+wgi4wpGwcbLHebS/Xk5+HY5Mmzp4pKBZ/0FxPTgi4pijpo+1K3SJfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2e0oJ1YpCdlnQUOMOOw4xycH6An3miMS83N0ZWcg4deQ9z/qG
	kGiV0VUcvfcDUvPI75Ui3ll0MWMlG6+06sV4BlRKWN4Pjp00N56ZriUE1PJHfEYxMho=
X-Gm-Gg: AfdE7clwmwRuGcpWogQIEWFTwEUqawo1wQWav5Rv5gjWtM+CHHTEBYEmHklFSC72Z36
	z1HthKZxSsLIGAbpPup9YDd21ZIQKUAtBKi0ZFU+usauMMJgyxPBG4VfsI8yaIsgzPWlmgE7X6p
	jFL1wYz9Nl6gj6+TYw45/5b9g/iA/iK+U7ha3NbD/yXIWlvjxz6q4EK9F3iFGy1rMo8TXQ3+Fnq
	6fVqBK5869DOZ27d61oaTvQWmLrl/axCcsuTgt5uZ/oIwlNmdi5/twMCtUOrC+7LAJdVXytNkt3
	u3F68Z/Xi3ak4+g0trVy9AgwL80JSO4BTXdp0yty0iNQOmaY6HcpS9wmml2niv/IThU4uxT5jVX
	gvNXVvVf+vzU2Ldd+D4wUN9VDqgMIwU7u5VM2ZE8sPwKnjYtC43IQdHi1zXJ+KoslVXuUgAVMEn
	U=
X-Received: by 2002:a5d:5f42:0:b0:475:5454:49f2 with SMTP id ffacd0b85a97d-47f2dcbffd3mr1436432f8f.24.1783749267440;
        Fri, 10 Jul 2026 22:54:27 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26dc::3df:54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm67191335f8f.32.2026.07.10.22.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:54:25 -0700 (PDT)
Date: Sat, 11 Jul 2026 06:54:25 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthread
 outside of cgroup_mutex
Message-ID: <alHaU4MhWzq9kA1i@matt-Precision-5490>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
 <20260710134945-psimon-fix-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710134945-psimon-fix-tj@kernel.org>

On Fri, Jul 10, 2026 at 01:49:45PM -1000, Tejun Heo wrote:
> Matt, your reordering trades one deadlock for another: CLONE_INTO_CGROUP
> forks grab cgroup_mutex inside the scx_fork_rwsem read section, so an
> enable racing such a clone deadlocks the other way around. The fork has to
> move out of the locked sections instead. Can you verify this fixes the
> deadlock in your setup?

Thanks for fixing this. I'll test this out ASAP and report back.
