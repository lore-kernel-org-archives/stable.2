Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D190430312;
	Thu, 20 Aug 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225600; cv=none; b=dqvaqCg5kIwsOfM05QQPBZGFYSDsBO2GHXSlQzDOSKmNFbfEKimYQPLuIPhWYkbfwGKxi8cOd/TsJTkL0D/V3WgQCSttxZDBZMzj4ihpNeK5IuODNOcDX09PMPcB1DMDZ7nCdhaozjl1Lmt5X1kMdkeuazzGFkxRzRp6+cxWv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225600; c=relaxed/simple;
	bh=HrBY1qBbAzS3fUDhOzFTOW2iufARlaCa/A8JdL1kaAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BHd/9JP8TWDT0gEkXVy7dMSijMaqnBXFel58qprifsiWDmQE16grH+bf7fu6UpvkY2Zx4rEjfKnuoMPPHtLEQnQKoimwejFFD8v5suRUTojnt6y3hWQKbO9Hp3L917TBujP07I4p9gggtuSp2zQ6toAZpoLZIQ5iW2fiAt5H2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY3r5f9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY3r5f9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A751C1F000E9;
	Thu, 20 Aug 2026 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787225599;
	bh=URZGRebNnSorLpyvvN+/qSn659k+OBVM75iYaRXqeSw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NY3r5f9FPHb2fh3ooyp8KbetLWCrnQHXDmpgfGjdagFYyIamY8DqRime0R/R5BYPs
	 tCoZ0bMHY0EAGHU1Cc+ErMQXFGvUOynDiTfMlfWrmM1WuwfZLOJC/KNxoEudyUthGN
	 pfS+oay0HmvSsHLumP1v1e6xmleXiJnQd2WmMoOx9W1id0PpqXz4nUFAAWCY3a6de5
	 BfuIAhueqC8UvZb3axgyEQuuKOjP+++6t7UyxOEG5SHq/rq9rVmMMWspNWeWgTk3xG
	 TEFqQ1K8w8JNgGdH1Wnhi49P4D3sNPPnBd6z3qsqSQKzhuU3++oX5yJbQoz4mxzx/n
	 FlHGU/AZJgp0Q==
Date: Thu, 20 Aug 2026 13:33:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Johan Hovold <johan@kernel.org>
cc: Guangshuo Li <lgs201920130244@gmail.com>, Even Xu <even.xu@intel.com>, 
    Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sakari Ailus <sakari.ailus@linux.intel.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
In-Reply-To: <aoQaUAK7wiG1YjRD@hovoldconsulting.com>
Message-ID: <p80oq2qq-5o87-01o7-qr0p-5op97414951s@xreary.bet>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com> <aoQaUAK7wiG1YjRD@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Aug 2026, Johan Hovold wrote:

> > quicki2c_probe() calls pm_runtime_use_autosuspend(), but
> > quicki2c_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> > 
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> 
> I see that the HID ones have already been merged, but for the record:
> 
> As I've explained elsewhere, this is just misleading. There is no usage
> count leak here as the count is balanced whenever the user re-enables
> autosuspend through sysfs (by writing a non-negative timeout).
> 
> Drivers should clean up after themselves and disable autosuspend, but
> this is more of a clean up than a fix and should not be backported.

Hi Johan

unfrtounately the HID one was already merged as is.

Looking at this now again in more detail, I believe the code change is 
actually OK, but the changelog is misleading. Or am I missing something?

Thanks,

-- 
Jiri Kosina
SUSE Labs

