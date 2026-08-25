Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11858356741
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670917; cv=none; b=MuvI/UlugZas8RLwiJS6IwjYYPwf70hvasjIwQx6zYegIdV3nRzxsbmLPDxnrL1I4cR2B53nj0T3cWa8CCeXvf16OB6fCxfX1y3zMI/4+wb6vpM/0C+y/GUu18AEOj51z/euZ5rwpRe/Ok+bQ3/1TTdYM1hoZWKLtkqMiZao1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670917; c=relaxed/simple;
	bh=24KhW8mi2cGsvoaETj80+NDyLTj1kVY6jhF8RNy7xb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB06C5TLJyY5g+kE2PWe5qfvIpk9UMzhCAjaOm5dJh54o6yjbVJ5NFd66Lk2oIy5KpO/DWEq0PGXir6LWGAprVu+Q96Mh7MyjUd9CXqNwBV/UBBh+cvozK0ZHv6dxqrctD/5czUBDAjve3w2KOcoohBkvT/htrYPQkGQytaN79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z06pNti7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z06pNti7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7A41F000E9;
	Tue, 25 Aug 2026 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787670915;
	bh=simhhYkV6FheXFayxykzGvq6TxgcHinXXWlPumTuGZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=z06pNti7JOG9KiFQuVF50vBfZPX47zVFF7LqKooyHVpi299EBCNAZPYCqXEeXO+IJ
	 Gh58u0GiBVHAm6+pvrEV74XJzTo+zIMMXihfaRP4Q40R6o3WLQ2gbw96YL/hPbC4kV
	 q05c9hxt8FGsa15kdKTVHvW/+HVjX0L2RfMHC6XY=
Date: Tue, 25 Aug 2026 17:15:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: peiyang_he@smail.nju.edu.cn, leonro@nvidia.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] RDMA/rxe: Fix OOB in
 free_rd_atomic_resources()" failed to apply to 7.2-stable tree
Message-ID: <2026082533-tropics-survive-dce6@gregkh>
References: <2026082516-phrase-console-29b9@gregkh>
 <95aae0da-b261-4536-b2f4-4616c91123e0@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95aae0da-b261-4536-b2f4-4616c91123e0@linux.dev>

On Tue, Aug 25, 2026 at 07:47:56AM -0700, Zhu Yanjun wrote:
> Hi, all
> 
> How to fix this failure? Should we make a new fix in PATCH 7.2.y?

The directions are provided here, in the email:

> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x de329533792a373186d79dca1ca120f8fa0afd05
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082516-phrase-console-29b9@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Is something missing from these steps?

thanks,

greg k-h
