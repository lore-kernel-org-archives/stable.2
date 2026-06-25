Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71321EF39E
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401423; cv=none; b=oqIxI9vEA3ey+dDv5qcJ92fQBu/gbNuwR5EwH9knEICJlgZtL1s4M0/To2ScZfi0GdkYiTUAlimve6GplkdnRLho4VPLCOoHIqhDVszp01z6/yla7ScPnuCAQLDEfYJyFkhXSE0l8jy6HgOaIeE34ldUp5AHpyGWMt8RbXADZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401423; c=relaxed/simple;
	bh=Zl57gsLhXTd296OYxltndfkc0ADS84wRpCC8Du3pnUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPtyXE5mFlnrEZfVaLrL8Pwt6tJyB+l2LdK615OOa/44MaTq25HWeOBpgzpbC8fPokb434Wfn8OcmepOvd2Atx+7LS+IN27/+1m/iCTt/tXVWOH+v8uNniLypORJS3pvT66GodEB5Qx9ev8esq7mrXuBWehQVFNyHG4uWbsHlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AgquMysM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AgquMysM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4924e6fda5dso30905e9.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782401420; x=1783006220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hL6WQal4FI/mvhdzofHugqoqMtcJjs0nCtdAyeoXF5k=;
        b=AgquMysMLaXXUCZz9tOaq1GSj2WAMgIy1CIPC7ZAY9AVcKEl7+QFsrwkXi/mWNp9pT
         P84ErWNmJTi6fOWLN6o2unARbq4ju1NmN+6/c7cpK8PMsIptWxes1atVVUyMfLc5solV
         RDu9QF52UVlH7DG8XoVOmxHP3yxbOSdmT7YgT/mmPQ0Dhns/GTMRidN+SKrEFxJAKp36
         QpJ/LHzbrm+BmqDzepcLXZXaQ+QAnfquTWnMVqV7N7vXB1F+FqgqaQCCwLB3Rb0uSEf3
         0fHmGhb1GcHJS6jrEQnVH8CPZ4a0mn94rWRNhm6LPG2rLaRnWunWU1CndB93M69wSa0n
         ARvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782401420; x=1783006220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL6WQal4FI/mvhdzofHugqoqMtcJjs0nCtdAyeoXF5k=;
        b=jkPgz9yp+lFFkLMZ3kkcRrBmYA+b0horekAxOFM2fCfNaKBtChQbALiNqtc5vh0rAp
         KUXWe63qFb3Wjph5RzljyIo5WUONQWnfPjN9nRVFabhCnzEG1udENmkL4/xeIoAYuVxD
         jPM5jwHF1/Y8GBaWXQZA9Paq6uMjpagXjQiQ+AjandAdjxHgzDSJprHjX0qVng0CN0w9
         1KpWgoVIWCb9ZNvjctILUm2gABJDtjTNi/BDlbO5DEaPD888RlAq8wnoNd7/o45aRJoT
         9hVQcbs0WGCBkj+RtNEMUeqJM/AnoP9QTkMLhWIa+C5ka/C/ZCAmbNRKg2mw9DSkgftL
         rdXw==
X-Forwarded-Encrypted: i=1; AFNElJ8pplGUs1SPQOduBUyCt8Vca77bpZ83Gtn4QANvpmiFPC3sWSFxbG4ItxPgSRWcJfdaw0gfT+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ojx4lWplXm/l4FgIMIvFEnWkK6d5Tqb9o0MFX9Y30CZFiRVH
	Frax/BGqFI6l4R8bhj5JANQ4MP8HZfDTaNFyit688lemE863LN0/38vBRLF2AfFUzb4=
X-Gm-Gg: AfdE7cmRavoyWSegNrs0Be8XvMeLuworJAFezuc604QEjREraBJm+TFsfF9crtOvfdg
	I6OdI977lAc+6CWP7LNFfgQP0UsdLny3vOqiKfzFiP6tKF6Uc4HvhGHx61yorFZLSqepOI0dLDC
	MmrAMcIvrjGbZLNXGUsHtfe9JU5o933JUd0oXvMOOBYFd4KOfy5t1mP9iryCeiGIwV+GU8+7cYV
	zWMNhme4Dc/O7PmSEfWH/wlTonMpQXIlWc9MpShAV4ua7mLuj1Vug9bLwo5AkUqZQbeWrPxeKAq
	fxK/VHPbbPMgZTUUfsqPFgh8j1WANpkvv5/YbqT6peGc+o1G3poVwiUdrKdNfbQSOvtzrUxhEzr
	Uinu7ZpSWnNGw3mfTi2XovkrnfRaSgKpz2y2uP5gPac7quP9+d8mKElAxL8HibavH8HMG9u9TV8
	q4ypCcPXLdBByr1NQ=
X-Received: by 2002:a05:600c:37c7:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-492668963bfmr41296065e9.21.1782401420019;
        Thu, 25 Jun 2026 08:30:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fc0f32sm5471145e9.3.2026.06.25.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:30:19 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:30:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bradley Morgan <include@grrlz.net>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Fixed tag magic: was: Re: [PATCH v2 1/4] sys_info: add helper for
 callers that handle all_bt
Message-ID: <aj1Jh57McGH94gGY@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>

On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net> wrote:
> 
> > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > Add a helper that strips that bit without turning an all_bt only mask into
> > a kernel_sys_info fallback.
> 
> I assume this patch wants a Fixes: and a cc:stable also.
> 
> It would be nice to have the conventional [0/N] cover letter to tell
> readers what this is all about.
> 
> The patches all have different Fixes: targets.  This risks inviting the
> -stable maintainers to merge only some of the patches into some
> kernels, resulting in an untested combination and which might break
> things.

I do not agree here. The Fixes tag should should point to a commit
which introduced the regression into the given code. And finding
some magic common point beause there is some magic undocumented
process for maintaining stable kernels sounds like a way to hell
to me.

Best Regards,
Petr
