Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93699584944;
	Tue,  8 Sep 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885973; cv=none; b=aXRUt8dQqXLt8tjPKCjtKY9HYxSKhbZpLNJpoUloI3RXRmKFCVzDcWGlkZPp483sjhvcxlbkZPXlKT23EFTul0efD3wngqjwSGQUu/wr8FRSZ4kMBoBn8Lt1xY5mgCiwJrEeU+tr3sJsYNK+kH3MJFYwWZ4h0LBQdbos2UL7PPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885973; c=relaxed/simple;
	bh=UQDOhMmId5GcFk41MzuKun8L0gg0x7wRS+/yLL1y/yw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=el0d6+hmzoU0gCOJ7M4pBPmcXMfSSQfNqUy++nJ09G3mFHNPusRvjzqD12eWL8vOItUg59DV5ApHA/x3NdhuTtiz2XjgkxKVnW+WBhasdv5YVGwymFcY+iQfkJKLyIkH7m39RLHDUj1dMmm3RkGVCntZXj7tohgjdDj3ei/+QjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locrian.net; spf=pass smtp.mailfrom=locrian.net; dkim=pass (2048-bit key) header.d=locrian.net header.i=@locrian.net header.b=bn9n8UFZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c41GqfjZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locrian.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locrian.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=locrian.net header.i=@locrian.net header.b="bn9n8UFZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c41GqfjZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 56EC8EC008B;
	Tue,  8 Sep 2026 12:46:10 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-05.internal (MEProxy); Tue, 08 Sep 2026 12:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=locrian.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788885970;
	 x=1788972370; bh=NGqizxzouAdfy+DM5egPfb4OgLDAXx2HVrfQ9gLtbYc=; b=
	bn9n8UFZPkjmO/i8lmjhrYS94b5lnGeRPo+sudfGi0ODMI6vbcjgz1y+NPAyqY45
	wGuPUm27wPu2LkMN0Zqft9hzowonFCc7YbQ63t2zSx2PEg6D6NVZWNCWwuvDpzGK
	sxs7HzG695jYFOofdXe8ulQ7Sqg1pLNWXKF5SPpg5d2OQxIEpiQTZZzkTcdTmXza
	onZk8fELnAUESrJde09SVOvDvkSq++KCR281ZANYhzml1UTaGgVqGoIbY+L4k/Rj
	jbTaZCSQshtsxyMhRCv1wyV2IQvFPpeym0DeONScUgEX2RFWB4Y76H7329O7FNkQ
	cF3chL5n/rQCGP8AiDp/0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788885970; x=
	1788972370; bh=NGqizxzouAdfy+DM5egPfb4OgLDAXx2HVrfQ9gLtbYc=; b=c
	41GqfjZ1Lz4E6bHNXhh4qY5ZyJDw9gBv+USR+BwtYdyd407ZgAl5PFRNmUHkrCYu
	Z7H3dl682yU7A/EPIUi5+GleSFYyCj6rKv4M55tiHNWSSke0p2n8PW9MrqpwoeyQ
	9PWAHu3Yk0k1YfkS6+gh/CPNasBmMC5GW6Jzo9HxCBz2mXvH97X6vpyL4FE69zHu
	CqAGo2mJbuueykdCffv2b6KDM7IVmwgdgSYhvqPj/BXw7Qz1lqcm0hxjL/3G0YfJ
	XVQ80nOvo+RJ74bQQ11mC+eRnpk6eblhTD7fz27cUDZ2V8OSJrIGOVuKab78o5EE
	pNEg1EHB6OmmFjG+HaV9A==
X-ME-Sender: <xms:0TugahnT_bEFYZYIsDH13r7bBWSbjloQmSJoHirzS3ZHhc7Gvly9zA>
    <xme:0TuganorVvmaRcn4__o66Uaiku0xxkT1bBzPiWqxlKOW5ekRFM_Brh8Jvs8eyKcZv
    CdzofbVqFFjzOvoONgGDBeiObSdIR3Rzz6gDSbCG4BIx3GWYHa5f4Q>
X-ME-Proxy-Cause: dmFkZTFnLqIyYIBg+UtBhFjabtuEpxyPqfK5VS81h1mcjtMFHXOgRBXxvoFuwzCnsjeO1y
    sKj7jtYR7ssnejOl3UO5scbK69GdPke25I2fT5ZPllTo8pMKlso9vr1DFgVoLTq/k+wTzR
    6WpQMETdflfZLNfk/TFGZSFR4nO0zAZO7FzARuEHxXtqE3SVYzrK8BBmSm0ucT+c+bUFUU
    VeM2LLEfY14jQSCfOLpOQFRKgXLI5Pvd/tBhSzT1SUbHq+cFYCmrfTT9V65bieYUzclmYJ
    IWLXEyCLHEpTMOv+82lWopX/xSrw/kmbCfuFTZHJ6/5kJvQ6rRAP5iyhVBHBH9Yn0rNrOw
    Qndb3n8hZQ8WDsC6iBpJrsEDa4TjMc6AwZw9A/10+6kaSZ+OF+2CHnjxdfmfL6tsZTxb9t
    ISzjsFyPzZ4HqnGZ/9ecoAtpteka7Lt1rfkyIuGvGQP4bYng9Y4y0XK3ZM+FGl/kQUEJJ9
    mRxhbkhPcT/7Oo1s1TP7mLtZzUgiCoKAEmV3jKywWdZ7gfYf4DTjA75LjD/kYMDtBxmjhM
    OeYrVNAgrt0xXtfE20o94U+RyBuESHTV4/no3r4Y45R5fNLlRorleoDFnqIbnnrS3e0C8/
    5AzNqj6QS+HN+R4WzexiJTCkccpAgqTpH7WasHpjsbJ2pzPCNs79GqyEeWmA
X-ME-Proxy: <xmx:0TugamsZfcXm1GW73jZN_KwljsaYgk-yo2vS4o843D1VDoOyV6C-8w>
    <xmx:0TuganRf73ByB2a-ivU8VF6ZeE_SsEZpawGfayFZa-ZWOlbXyGRwfg>
    <xmx:0TugatIV74R6WLNZOF2eBTDXX467X5XCWPFkUNxw8eNfLfGmTyBzUQ>
    <xmx:0TugaqszrdNcMrFcAEpw_TmfHA3XtdhBDpkVWpZerqhbXYuWVCP9Lg>
    <xmx:0jugaiSCXwkVwr3JmIDHtJMGZNHhWEpTjR2fISl56U2RQSqP60AMSBZu>
Feedback-ID: icec1443c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4C992400098; Tue,  8 Sep 2026 12:46:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACnqMq6o3wCZ
Date: Tue, 08 Sep 2026 09:45:36 -0700
From: "Benjamin Peterson" <benjamin@locrian.net>
To: "Jann Horn" <jannh@google.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, "Arjan van de Ven" <arjan@linux.intel.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Jake Edge" <jake@lwn.net>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <48eea5cd-b4ad-43c1-b9d4-4086970c0be0@app.fastmail.com>
In-Reply-To: 
 <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
References: 
 <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
Subject: Re: [PATCH] exec: do_close_on_exec() before taking exec_update_lock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 7, 2026, at 14:26, Jann Horn wrote:
> do_close_on_exec() currently happens while holding the exec_update_lock,
> which is used in a lot of places that access process state to
> synchronize access checks.
> I recently added another such use of exec_update_lock, causing a
> regression.
>
> do_close_on_exec() can block waiting for a reply from a filesystem.
> That means a hung filesystem can block codepaths that use
> exec_update_lock; and it also means that a FUSE filesystem which
> attempts to inspect the calling process can deadlock.
>
> To avoid such problems, move do_close_on_exec() before the
> exec_update_lock is taken, but after the FD table has been copied if
> necessary.
>
> I have looked through all the calls between the old and new position of
> the do_close_on_exec() call; there seems to be no file descriptor table
> access in between.
>
> Reported-by: Benjamin Peterson <benjamin@locrian.net>
> Closes: 
> https://lore.kernel.org/r/f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com
> Fixes: 6650527444da ("proc: protect ptrace_may_access() with 
> exec_update_lock (part 1)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks. I confirmed this fixes my regression, so

Tested-by: Benjamin Peterson <benjamin@locrian.net>
