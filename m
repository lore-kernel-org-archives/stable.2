Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317943BDB5;
	Thu, 20 Aug 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226446; cv=none; b=piAWsnivR4VjAWSIfVia0UesQlh4zwr61Z9Ij50EAcZox1XinL3ZuiRyGCP7KGBCx88pKZSDBRcDH1JiilA69MQlmNS2IIAGKZpSA7zZaYugMdxOt7xSGMSATp5SgBGMjIlzhPk5+tT/skRHyW1BsOaBh9Dtmj+PP+VsKExEf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226446; c=relaxed/simple;
	bh=R8MdvdcMsBp2N1mLyvICuMf0mtBfdLZDRyPQ371fdBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CgVWVbm5DOLdhcRUZpZQIR1OcCOwe4hYFVyccShQImX+LDHN2bMA1CDz2xp9e8CbF3byH+nqj4IGmoM1QxpnwIcqH/QnhNL/dyyoGRfNSlJUlsHXUkd5ZAkT0WRhbfOHbDT/MkF16KXcQ/wp2RPZWsHuF3G/OnDbvgHEYpSEOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHDY/bVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHDY/bVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE11F00A3A;
	Thu, 20 Aug 2026 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787226445;
	bh=amGJiSy2PCt38pGB1PZMBn8SsVlXFSem11MDBJ86wqI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZHDY/bVXlNOryGERSOwvNopfYRi121xsLaLxlLEs6HFvjp936bUKm18tjBoB9x5/r
	 OhrfIFILKp2hhXR4uiGyv/FaNgi1KufT5J0TBKvDpj/wbdJzKcIfBfsYh9VFYQ+4+W
	 AjhOJVjEfN+hLdUToqIQGFsKkyy2BM5NVaRFIbaWYpNTTRbvv8l26ZAFTpaCyyVI2h
	 LzJ9pjDE+z4mqVmOzWvp3d3KZtupGeJFQVari5jYdtMEkt8l7jzt0mHa9eAw7LVGuL
	 697bpo0lW52RkBQ7NaX3N7PWcz4IiQMpaJID4pZKRptO3iV9utBD8qV9x1cYNFWfZc
	 c5lRNfC8ZR27Q==
Date: Thu, 20 Aug 2026 13:47:22 +0200 (CEST)
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
In-Reply-To: <aobnz6lCxib4-5Ma@hovoldconsulting.com>
Message-ID: <16ro5o3q-sn02-26oq-463p-17o3s9oso22s@xreary.bet>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com> <aoQaUAK7wiG1YjRD@hovoldconsulting.com> <p80oq2qq-5o87-01o7-qr0p-5op97414951s@xreary.bet> <aobnz6lCxib4-5Ma@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 20 Aug 2026, Johan Hovold wrote:

> > Looking at this now again in more detail, I believe the code change is 
> > actually OK, but the changelog is misleading. Or am I missing something?
> 
> Indeed, the change itself is fine, but the commit message is misleading
> and these do not need to be backported.

Ack, agreed. Thanks a lot for catching this, Johan.

-- 
Jiri Kosina
SUSE Labs

