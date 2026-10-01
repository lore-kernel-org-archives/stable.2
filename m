Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A1486B90;
	Thu,  1 Oct 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887067; cv=none; b=D3C5scESm4KqZv4HbYuOTgQO5aQ2RkXT7Bk/9SOVu/IR4H4fmU9K8jOVPuUItrKMtULcpkPRJ8IOR780ZcsAvqChsCZzJ+LqzgLLqatKdFvi2W3dEuipy9sarDweX8SjHAGpSVkVtMoAzL0wyvuCOYhBlHN8eMOUl3M/4aZkDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887067; c=relaxed/simple;
	bh=OxTMrSVgT0lqmqDZvAG+HGAFHJPFlw4PUzoa1mdEt/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR/bG2bjpKW+4NP4J4EkM04kBgb3ZPZYnPZi3tcuq5Gg9ovuFVVB92CgqUDV72zdmGaL3OkDJu73Ij+tD0o+wmlSGXEPgllCJIM5s1YdXZ5qOkA5AcM3+IcTohuPtLGEdEV5nIMn4uFP6CNS7c4H0AIUpmQ+/67EUAPjempPONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F+sKo2CY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F+sKo2CY"
Received: from LAPTOP-F8U7OQUB.localdomain (unknown [167.220.81.157])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2481720B7166;
	Thu,  1 Oct 2026 13:36:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2481720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790887012;
	bh=owUIPjGXDyRahKF9rQvqaDza2qq0SU+V8BI0G1vditU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+sKo2CYH8RjnxPzNEzGlpPP1VX3dCl9sZ1ZKBmY6YXAhJswR2RsGa6cy6SjDPWiB
	 F3sj8mylTOd/FXZMGvCokZMy4Tpx9Wij182mIcdPcbxVagmiSBIHFDDCK6CHHm2muV
	 6AFlXxQEIGUl3wxBdOQCPVdQ/ILjXHx8DgVzsC/c=
Date: Thu, 1 Oct 2026 13:37:36 -0700
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, raminwo0202@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, apais@linux.microsoft.com
Subject: Re: [PATCH v2] xfrm: prevent policy_hthresh.work from racing with
 netns teardown
Message-ID: <ar7EkCXMTxG43af6@LAPTOP-F8U7OQUB.localdomain>
References: <20260929235256.1398309-1-taherafahimi@linux.microsoft.com>
 <2026-09-30-1-daily-reply-0001-xfrm-policy-hthresh-v2-6-6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-09-30-1-daily-reply-0001-xfrm-policy-hthresh-v2-6-6@kernel.org>

On Thu, Oct 01, 2026 at 09:52:05AM -0400, Sasha Levin wrote:
> > Mainline commit 29fe3a61bcdc ("xfrm: prevent policy_hthresh.work
> > from racing with netns teardown") fixes this issue using
> > disable_work_sync(). That API is not available in Linux 6.6, so the
> > mainline change cannot be directly backported.
> 
> Queued for 6.6, thanks.
Awesome. Thank you!

> 6.1, 5.15 and 5.10 have the same bug and also lack disable_work_sync().
> Could you send tested backports for those trees as well?
Sure. I will test and send the appropriate backport for other version as well. 
> -- 
> Thanks,
> Sasha
