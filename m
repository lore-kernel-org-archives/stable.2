Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80E7081E;
	Tue, 25 Aug 2026 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646306; cv=none; b=VLOxrsC1yh2BOXoUfGtCjkOahlRWDvFKh8kRL2LWPG4FeC9QQox5J9QtQxAMA+pUpDMKkduLQrXJwUVmKYsySBN52qGM6RONwhLmHxZDLx9GX6cAKay7NG5dLQSDfyGrwjuP0uiw28b4ZeEptZyqrPRjMY8C0MRUCu3o7RJYh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646306; c=relaxed/simple;
	bh=3Arvg/Z7t541bnNnv8tATh8KJx3KCUVvAbe3BqetXAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0n9eCwnzw2mDdYtgsHIb7BEVRi2ZvE7dSpb/RmK//FXYLeQwywQ2ROHH2+mPCufXvIyfF4sl4bBsfpdekB85ehvFfI1u9P8LTSJ1hncVTQbCl+D8YPPejNH4xSHlZjhUrE1CHjcW8vYJJh7QNPkGXuwNucdx2htx8oHatOwDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PwchZaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PwchZaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7ED1F000E9;
	Tue, 25 Aug 2026 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787646304;
	bh=L6GLVc9MfIyepECb6CymswjSoYeLQ6qjUw2dWWPhrkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2PwchZaK3WE9iWY7HOqWOn6RSXiuVVp67sjlE6lQse13ehgQODSYZwMsUB+Ktfy7h
	 P9p/jdDSgqnZEVQWyTE301qBJ8BqSt0fjGm+HntyGpXuxvK1XE4CNO6DCCZdwZLH92
	 jWLg0Lhn3jtbr30WVY83k1i0E9L4BhymMJeOnsNc=
Date: Tue, 25 Aug 2026 10:25:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?7ZWY7YOc6rWs?= <hataegu0826@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [STABLE REQUEST] bpf: backport de36adca6346 to 7.1.y
Message-ID: <2026082526-remindful-aids-773b@gregkh>
References: <CAPa51zmwhbD2Xc1kFJY8HmpG-DY3OsK=G=h2Yn5ismeGCxo==g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPa51zmwhbD2Xc1kFJY8HmpG-DY3OsK=G=h2Yn5ismeGCxo==g@mail.gmail.com>

On Tue, Aug 25, 2026 at 04:00:34AM +0900, 하태구 wrote:
> Hello,
> 
> Please consider backporting the following upstream commit to Linux 7.1.y:
> 
> de36adca634634c205a9eb8b56a28175ab7abf5f
> ("bpf: reject overlarge global subprog argument sizes")
> 
> The issue was introduced by:
> 
> 2cb27158adb3 ("bpf: poison dead stack slots")
> 
> which is present in Linux 7.1.
> 
> The fix rejects BTF-derived global subprogram argument sizes larger
> than S32_MAX. Without the check, the caller-side PTR_TO_STACK
> validation can interpret an overlarge size differently from the
> callee-side PTR_TO_MEM state, potentially allowing the verifier to
> validate accesses outside the actual stack object.
> 
> The upstream commit includes a selftest and applies cleanly to the
> current linux-7.1.y tree. The fix is present in Linux 7.2 but is not
> present in Linux 7.1.10 or the current 7.1 stable queue.
> 
> Upstream commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de36adca634634c205a9eb8b56a28175ab7abf5f
> 
> Target stable series:
> 
> 7.1.y

It does not actually build properly, how did you test this?  Please
provide a working backport that has been tested if you wish to see this
added to the 7.1.y tree.

thanks,

greg k-h
