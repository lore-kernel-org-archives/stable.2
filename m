Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145941;
	b=eJF65xmQm1zNzRk0IGoWPAbXccb0w5HqvSOtVW0/vESgrkJpAz78UHFl6/DSR83QFqi5
	 63w8AK2KiM26ZU7Pg1IuFN/iqHrLIZ2L/mN7/W4nRo8EY6zRUCJNe5wvxHTVgH1ltzIMU
	 SE8XVw9qE2UL0Mhz/XM3FYk8PPgqD25sxC+stpk9NcnUVLh+XvlAJtRd6LosgdMis31Ld
	 lf1fauoYxjnJI8zWCs2CPsp+nxU97Q2TPpYvuQSYf1R3Q/n/fmWKm0MQSwvu7DzsGI8nm
	 J+oXlI2cfW3AKv8zZEOLiNfzKMDxEw2m/cK3sxsq82KsGjfmUadWVSjdELKrl7NSkKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145941;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Bdo19lphmcGbMb3AWXQ9qdFkBCDD+0DLfLtuxQBXaU0=;
	b=s6nUP08u1j8+4AQ3s5Uh03FBsriD2iNBpJj6LfvIvqUodO8kKMdnKKN9JtgFAyiVfyes
	 77MopI040K2htkQ9+qv4wYsvdwF2iNcmIAQTHifEl/GEtSqktz94vsuR36GRv0hqaIXml
	 CR2cpZmvC8oTpJJdlR5atPY53mk6ievbBgXTOCQQ8S2p2S0cahYePOEV7uKjz8XR9BvqE
	 J3c9xz92L6H8tQ1cZSuQsOxzCKAOIMtIq9OkZDisnxDJEcUqCLt7+P+aanabG0q82LfM1
	 cs5nX2/YZBtYa9lJ7IZSxWwNdpHyP4treHXn85SF7fxKT+kQUOmOMUzmF3VlcRyV3Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=dBHRHGon;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4svZ3FoU;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAE606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EAE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=dBHRHGon;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4svZ3FoU
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 84C97EC00FF
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:52:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 08:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794145939; x=1794232339; bh=Bdo19lphmc
	GbMb3AWXQ9qdFkBCDD+0DLfLtuxQBXaU0=; b=dBHRHGonnwGV3s3eRyKQ20tm8z
	l3fL04ZaIIdar+xDST/jj328ydl5wweAs3QN0L7Lk4/VLNr4G+k/NPrUujuVmwSh
	GkBzG//8rJUmxOhsd6dzzTBCfzQ2UK0HoHppsIQFKaUuo3A+nPTrQNevut5IgItx
	tmua5kRNqyIEVC0zqImde57YZP86hziohfYxuZjzk11I4Ce78lEjd9xD3rwN6eYr
	kdFvIqr358swIfam89SZ0oKDaVTa1FR8Qh1CUOP52aL4aLik7ZXuTpV6ljRlSqg1
	YHnzmnkhRJmHzKejDJj2mCtJ0HuU7WGnZcuJ2mKnB40U/wnY5/aCLQjOv16w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794145939; x=1794232339; bh=Bdo19lphmcGbMb3AWXQ9qdFkBCDD+0DLfLt
	uxQBXaU0=; b=4svZ3FoUb+vM/K5fOElISVrVugpO6yt+gcIvWvBMq9ahUAiUzUD
	DC6osDuPCcftTMMWfFn7Tb/SBiTNB7qlY8GDf5CvtsahsepD5XHlokgDSQdwzCW2
	Dp6uO8P3mQCo6pgy+FqQLuAS4XFFKg1Z79AkiabkuU2+2mpb5z3ntKUcseD3Culh
	9IgVUFehhPivDjhr5UPsmdhzc06/ad8ptPiSvP3RY+kbAEuIYQCd+N4KM/d9evvT
	msopl2wbjryCkouFeEFAVyp+qdx7h9WlYUkHEhrSZUs2zJEDRhRdE02IHHJFFQOS
	2CFn1fYMt/uFh7ZnAOnEJsqHbH+k6o8S/Iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794145939; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:VKogpPpt0GikaPiyFRwQxItcXtpI4T/mFMiRM//X8gXN1NC
	n0zx+SbennMnlaOcl+DSUnDZJRoUYgKy/Pse+agUKPKgr9qetiRIvFi64x3oMRKf
	InKhkR4PNQB5FwkfjnkVlf4pizIiqA+jVTOhbDU26pqTvFPh7rrMwGMaEL2zuoyG
	Po0KdNYxZ1hoKT4HG7EwAbvtlDtN7pPnDMXQyGYLl2uvug7jxG0l53EFCT0XxNqB
	9vpKi6vwAO5OoG1HBpOdGYgcjjg90/1k3u08duwZDA+SloWSPJlLdvwyBergMcax
	2d49J0trhtVapstqFSyxBpH4g53/7RL9zbi1DJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mtydBmyy1Y0Nwtpx/XX1Ixrl/w7+VXvGql+5hc1j7eA=:5kJJ9+GaxPOY308wAKLcIC1P9dDrGVK9qVoZmmHj4O4=;
X-ME-Sender: <xms:k37waoaijaofLaNTi7WQZHS6rdyd9sQsVolRmk-sCI9VcWjR3sZorg>
    <xme:k37wassGyMlphVV0BU8-ctip-b6I6_PSE_sQd1DNnwgnov-yMLgcD1I1EWlLBXBfP
    N85mytTrg3NLbfOQr083lbBiMDSj3vOWE9nxQvTEKaJKuBFdI0>
X-ME-Received: <xmr:k37waqMV31NYPrhv65UMkORfD6yvFU1LUqeF7Jcs1kFtZo4MUDdlhrqTP0HxNlEC-vYGZNPt8KRgII33sxT6-Wh6qg>
X-ME-Proxy-Cause: dmFkZTEaAaIeCfznXH/Zx0ge4jnaBMiLzV7p+1vbYhaV/qypUwsaFWPLpQYnz4siyLC9IJ
    NEnCzWVJejzirxBVEV34DeJ5SAOe9ZP+89EEs/Um3ta1HNxXwqgufrgz76BSdUCUivWv6s
    KQN2dbtr/oanmNHaUDtL9asx/ciBWIrD/zLEMap3sH+MEAI2qjj0Nuq2BCj1A3dK777oVw
    iDsbK/PVJe1F22Nxujn2lGs4opZ4Azt8GDqa5NVR3tKLgd/fx7yMaxZPdrw4YdRtbWHNZy
    ZuuxK0Xo9vL/0JOQek3txgQZVrz1c2O9x4g9EUcUHJ2pKcKZHFrz/OB6kso4oLZUs7mTWp
    TfSwCbEmsOTJXXJvxwaT3XopirnQd0ZPFA5+75DW2YjO01rlZWn/9MLi5QLHhueYhNzKH3
    oHchqyb+NAa/0Fyd1PlSPb+YbbeIQ9jimg+Zg37k58p0VFFzDE/BIBROZIYbnk23a5ff0b
    cjuFPPxJmCXoh7uAU3KkD0PU5SHHZmF+G/euVK8r4XuPeAVbQTJvVGLLZGP4HFzy1iqeI/
    8jtsjXBqmK4JRlgJ8Exnu7bzvXxzBesmx7wxAqwAwFbh7XwUUNO6LqoH+r50hF/E3z44NE
    L+fAcnTpJxlLPwRM2O9iqwbW/1YBqFOIBHht98n7Q5MwCBhq3WmRx8vEVATg
X-ME-Proxy: <xmx:k37waj7H4P6wwrmpkALBoHPD70xgDw_3lNF6-PT4QXHOUETJ1jjNbQ>
    <xmx:k37wagQA5_c6ql60yDW_h12PAshjosr1168wjJ7ytthj6xooF0Z72Q>
    <xmx:k37wagCe3JH7p2sNQBx8zNPCRCMj123VxPlgz-0exwR2JJRJMzNLNQ>
    <xmx:k37wagEiJ-RvYufTIRKeWUjPCqjHZmRIhg9AUtAfPE_i6FN20j_o1A>
    <xmx:k37waokDvOx5QBDItHd0zzDr1oR62wB-TMEk06GN4Qzy0E_qAHN--usU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 08:52:19 -0500 (EST)
Date: Sun, 8 Nov 2026 08:52:16 -0500
From: Greg KH <greg@kroah.com>
To: Mohammed omran <sanhokh30@gmail.com>
Cc: stable@vger.kernel.org, stfrench@microsoft.com
Subject: Re: [PATCH request for v5.15.y] ksmbd deferred file_lock UAF fixes
 missing (CVE-2026-64396, CVE-2026-64437)
Message-ID: <2026110826-scarily-pettiness-3c17@gregkh>
References: <CAGwSD7TLViPzzXuZ37=M=8RJZrCN_ODG=DA=pLiivG6Lys94jA@mail.gmail.com>
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
In-Reply-To: <CAGwSD7TLViPzzXuZ37=M=8RJZrCN_ODG=DA=pLiivG6Lys94jA@mail.gmail.com>

On Sun, Nov 08, 2026 at 02:03:47AM +0300, Mohammed omran wrote:
> Hi,
> 
> three ksmbd deferred file-lock UAF fixes landed upstream in June 2026 and
> were backported to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.1.y, but did not
> reach 5.15.y (5.15.225):
>   f580d27e8928 ksmbd: fix use-after-free of a deferred file_lock on
> double SMB2_CANCEL
>   d20d1c8ba576 ksmbd: fix UAF of struct file_lock in SMB2_LOCK
> deferred-lock cancellation (CVE-2026-64396)
>   10f293a07f9e ksmbd: fix use-after-free of a deferred file_lock on
> SMB2_CLOSE then SMB2_CANCEL (CVE-2026-64437)
> 
> Evidence:
> - The CNA record for CVE-2026-64396 lists the 5.15 branch as affected
>   (vulnerable since e2f34481b24d, "cifsd: add server-side procedures for
>   SMB3") with no bound fix for it, while every later branch has one.
> - The deferred-lock async machinery is fully present in 5.15.y's copy of
>   the file (fs/ksmbd/smb2pdu.c): setup_async_work, release_async_work,
>   smb2_remove_blocked_lock are all defined/used; note the file moved to
>   fs/smb/server/smb2pdu.c in mainline, which may be why the backport
>   tooling skipped it.
> - linux-5.15.y's history for fs/ksmbd/smb2pdu.c (through 5.15.225,
>   2026-11-06) contains CommitDate back to 2024-11 and shows no deferred
>   lock fixes; the branch is actively maintained (fresh fixes landed on
>   2026-10-30).
> 
> Note: 5.15.y predates all three fixes, so it holds the original form of
> the UAF (a second SMB2_CANCEL -- or a SMB2_CANCEL after SMB2_CLOSE,
> which gen1's guard does not special-case either -- re-fires the
> registered cancel_fn over a freed struct file_lock, KASAN slab-UAF in
> __locks_delete_block) without even the partial mitigation present
> elsewhere.
> 
> Could you please queue the three commits for 5.15.y (gen1 first; the
> other two apply on top; fs/ksmbd/ path applies to the 5.15 rename).

Please provide working backports of these changes that you have tested
and verified they work properly if you wish to have them applied.

Or just wait a few weeks as 5.15.y will be going end-of-life then.  You
really should not be using 5.15.y anymore anyway.

thanks,

greg k-h
