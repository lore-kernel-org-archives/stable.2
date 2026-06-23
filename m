Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDD399001
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198412; cv=none; b=krYI4Rz1KZO5gE8bHhguMlzWwQuaQiPcezCZwl3qVii7wPpSef84abXQ6aQVd+uF9SrMWBPoSlRDCGr8/Ji0n38act6El5R94O6kc7L5kLp+bRFozJNYCVsVmySRt7RlTBk8nQK1Z3t7DCVm24g888M/g+pnzdtRfGXc5A9HiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198412; c=relaxed/simple;
	bh=4s7onRT01ASFyKqHj9AVpQMGFNh/pfCV695fBbGFx7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr2Wp9KMWyKZLwTNXmd1KJsZUcWYbnIqiMFkY8pkYdagHrvSsImRWO1xV9l2doVL0B6FzWMHrSzlaHCDVCSionTliVQkr+8huxa6L59ItB7Sw//+2izbT9ybe8esXC7lKs0KnGpOx6uYwZd2ZAO9JiuMAP2W9l8rXmNtRUEQvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSKbVgWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSKbVgWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E7A1F000E9;
	Tue, 23 Jun 2026 07:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782198410;
	bh=D98xzTk2QBfOwFijV4+apc2Xxh6rGbchzapzxTZYbGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSKbVgWmhpTEtJAx2Um3PWtWmS4OLg780FzibO35xJcuqQfQ3tsLb65IC+ERsF+1o
	 ky1i955/rtm/R7TEMlWzTUTWbiF/6OmoLY71feEIS56BVsenCinfTAZt/nz4KEee/E
	 gsTUGRQqNZ2GgFKb5eSL7nSCvNz7oFE+gdZQ4MLg=
Date: Tue, 23 Jun 2026 09:05:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062320-backtrack-unusable-96e1@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062331-bruising-wimp-74a7@gregkh>

On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > Subject: net: net_failover: Fix the deadlock in slave register
> > Commit: b84c563
> > Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> > 26.04 (LTS) uses this kernel. Thanks.
> > 
> 
> Sure, but note that 7.0.y will go end-of-life in a matter of days :)
> 
> Also applied to 6.18.y which will not go end-of-life.

Nope, breaks the build :(

Please provide a working backport if you need/want a commit backported.

thanks,

greg k-h
