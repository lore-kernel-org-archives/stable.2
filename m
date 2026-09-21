Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4251588A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025513; cv=pass; b=FdWLvYa9kBpywmnghhkVoyP0rFX/4Rnso5YXDCg3mDPZBfUbB9eEv6z67AE1WT+TEgq02dEFrzJdnP51Ay9JOsTmG6xIGaVKAjWeKm8JS5+/BcKNc2z7DZiwz7c9myhYgpQV3BWlRvpBoSbpN2qbDVynhOtYCM4yfOtx5hBMH14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025513; c=relaxed/simple;
	bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIPr6GyUvLGbs6dyZqfUhLgNTT/E3k8EgTHOXwT9e1450VkGwB6x+TUPLtTLx2aG4N5cYWC/cpWSO76PIdljoi0/qukpSbr50KIlqLmv8DY3A02/3//JKHpVE9+81g1e0WEGBGiWFc96rQxhvHUvOk0n5fBIEtYhjQlCwhrVgr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJkJFPIs; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJkJFPIs"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso2916890a91.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790025512; cv=none;
        d=google.com; s=arc-20260327;
        b=Q7NxOgnVZvX+2xgezykdPIkDG5OVsDxBBBDjKS1YyY/tNXFskiWi68jjtcdmPb/kBx
         8sjC9cm/Q8qQp5IQQe5rIAR3ANjOX/QBSk2911EtjFEWRidhCi/JrMAEM0uf4Ub8JZEr
         gJTDZO77mTvRUYzGay4Q5OvoiAccb4u8dUKM+dR23pXwMtgUBbORl8izLbNtkJftmFsJ
         mabMddaC+XvStld7JRraDd5y76bpjNzpKZ93tIy/b621gZYdKHvtDKoKU+oohehXCDcT
         jq8afpHqwwHNUStJa3qNrYMClO3u9lljyyJP68cmZCldxXzWmTyXZLCR402UtOwSz35A
         N8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
        fh=Ev+dBNdeU3BKH+Nq3mM3lyxuQjzcWvDMkvFRiN+5+Zg=;
        b=q2kZFF/dgS2/xvHHm7kPkEe7q95SsGukuUiSPQyyY40N7Vg+GjMBkxDK8n6scKAxLw
         1T+DNSAF7+zfHlafe7fpODEaXxxnpXwO/HrojgkesanPAK/AwvWrhNPe3lvrfdvJDbtc
         wUgXyPfPb2vkYvUfzPKs6xb2iiYpNA6ovxaN6LQ/TM0ZDsioHjH0i2YiXX5ldUnwGasX
         H64CpqCkTL+rUEofjtlRrFR7N+hV2KQEuYe2vp0qLX9ffyLEY4BJIftRlcJjbe0RKD9d
         omNwwaBo9qqsdafJfwQqgRSJQn/cVovpiDwahMSFff4c8gbPmaIwaP7ZlDMMNYFyMCp5
         4/YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790025512; x=1790630312; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
        b=gJkJFPIs3HaVk5EWl09Y7xPXWILS8ig9j9JL/g9NI5d04UM5g+fEe840fDcHyGRFT1
         ehEYDxw4VjLK3Tt1ovC3+j/oePUFdhWbgszlvvfEmevhAjwT+AQ4kWNv+ldfpt+YcWon
         40Ul3IfIrCI+4y1TmR8m19Xqm04jMTABMtw0RsVveuHZDe9WRiv4Hg+WWVVMESbGD6aj
         CRHLBaWWDdE/ybO6LYMyUZYFCUYVoN/8I4huiKMhG/2/4RZqpLlS2se9+6H6bSW+jFkF
         qvU+k/waT7tt87MSAxAdFG48r8CsaAo6PMmaj2TUaYtwhtatmiZ/RQ2pj4fFXUJ11MuZ
         XwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025512; x=1790630312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
        b=ecrwdu6hviiDKh4uVbMvlH6P4tq8/YyIwd3wqgmpSucdvmP/ypKUq7pRoHkmoOQqAC
         Q7ACh4Qqbxu5DMoXrRIOYAGQWAErlZa2R5ILZKgDteNvLiTiwlREIyzseQ69xBt5kub7
         eK8pa09ei1NKT12QTW2WT5H1boCgeET5eHVSKHsOXeBUdY+bEFohZcIcwZkiEBM/Z5rl
         dKfqk0pMt5QoM1piuJ8L2lsmNT+9OIcyHAq6K4VvFxag5MiN9SlA+shtTJEsA6SYpOCD
         FFuuZnY6d1YXfdFANr9qq4AXd8tRBp8/2CG5apMXvgZZHTlOhqgLygGfUYMjr8IlbIrN
         PiUw==
X-Forwarded-Encrypted: i=1; AKwUvBy6Yya3YRULv65n7ZllyuqFdBYIKLc4I7ss2eY1jSUUBiFemccCe4MGUNaDDfloxpYxjU62XEo=@vger.kernel.org
X-Gm-Message-State: AFuF++lZKdpGL37vDn07OFtO5TizljvvcDjq1QLP7vSuheY8DJLsvF8O
	B86FvKB3p3D5q3gkWlKkxT2SMRU93qdnBR3oopypj6yuzRfW96654f5C7nYGIVJJsq6d4MO0jjd
	nuPUvype4cCpRp75hWWtbRjQjhyf/RA09/9XSOlU=
X-Gm-Gg: AYBFou0CFSU1hMZ/WVN9y2UfhjxuEUg+iAFF1es7Dgm+rleR2HD87UnFQ2Vs3oBdy/7
	ja0PNyMwVpoPanxNQdnrN2NDUoUV9YnqpNiy2CdVpGtK6Zpdg8dnVTxa/Mj1V0Gn0Shj0BWFJ3w
	w6OOKkQ8jTE+u9tK5suc4Y4ew8unIwSpED+OmgzjPAgKvh1DCak6aT+aAgdTMQVhkpelhVQv+qH
	zyGI9PrLd6p4jQUGFpaBbvzMLoAxNH9/mJGaHPv8zX9bJ1wj6yrcdf5uwqu1wgJraTsC/+Y2roG
	Go5DyO3B90JBAo0GOdvOM/pxMtCTUntYCDMn6rk1LnXviNv9hqFePQ==
X-Received: by 2002:a17:90b:2809:b0:39e:4c7f:8b15 with SMTP id
 98e67ed59e1d1-3a06ae45c96mr221446a91.26.1790025511678; Mon, 21 Sep 2026
 14:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com>
In-Reply-To: <CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com>
From: Hic Haec Hoc <h.haechoc@gmail.com>
Date: Mon, 21 Sep 2026 23:18:20 +0200
X-Gm-Features: AcwNN1XDR3liA0aUKbpLmsIaVZiCpdO_7eTgmIqmdYIp2_7ENPKfCo1bzTJtA7k
Message-ID: <CAKp=m=DkRA3FQdJC+1AKDtn1X8ZuO0HRF5H7PJVf15uQyBuEbg@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: David Lomas <david.s.lomas@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	matthew.leach@collabora.com, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	Florian Schmaus <flo@geekplace.eu>
Content-Type: text/plain; charset="UTF-8"

On 9 Saturday 19 Sep 2026 at 22:53 David Lomas <david.s.lomas@gmail.com> wrote:
>
> Same commit, same symptom: my report with the blocked-task backtrace
> is at https://lore.kernel.org/all/CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com/
> (XPS 13 9360, 8 GB, zswap). The hibernating task sits in
> throttle_direct_reclaim() waiting for kswapd, which
> freeze_kernel_threads() froze just before
> hibernate_preallocate_memory() ran.
>
> #regzbot introduced: 783c8109844503bd1c35dab41b6d5fd074a9f131
>
> David

Hello,

I'm replying to this message because I was not CCed on the later ones.

I can reproduce the issue quite reliably on this machine, and with
Florian Schmaus's patch applied on top of 7.2.5 it survived ten
hibernate/resume cycles under significant memory pressure without
hanging. I can't tell if it could reintroduce the problems that
783c8109844503bd1c35dab41b6d5fd074a9f131 was trying to avoid but at a
minimum it seems to fix this particular deadlock.

Best regards,

H.
