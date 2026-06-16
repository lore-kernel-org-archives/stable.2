Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBA3D47AC
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588292; cv=none; b=Cc4e33uRMNqsg46rhJQPHfSZFZV08Q/K9pXIX5VSULFUh6nYvtvm4VwY3my16mGaMMeBAn1+Igs2e0UX4OSHVBHU21V6My0BJ+ub2GFjrcNC2b9I/6bZIBj18TsYnDs9UIorDEtCvPgI41aCNEI2VXeX/y3GKma1f7ldIze5S1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588292; c=relaxed/simple;
	bh=XdS9IaH7eTSyUsehCTvsvI9k1zpbayLDDI9X3rBkMw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBQdG3AU3dzbFzhZC+/0h57k3zRocETkHyxRdzIbgO/HeGvFmmhbofOA9rhKFmSEZyGIr7tUuXc/BbTgwYt1GsQA6k/cw1CpViC9Tp3juT5kgwmmPYYW4h3EieneRJX8DPKsSGT9Y6A3f3Bj5m8RfZyMPP/Z9qt8543xCKfu08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E3CC8gBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3CC8gBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E464D1F00A3E;
	Tue, 16 Jun 2026 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781588290;
	bh=AEHZ/Qo/k60qpbZVbObGCFlQC7AjJAHcRqRaYGJR2yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E3CC8gBFkNYtROQnGXrq33d5frRo29xdG7M0KieHfRd8RBRVmp4tesxSHt89h0Udi
	 uOhwIh/bIoWoCQhEXNGx1cU20miEr4c/LEpO+Xk0HGOqAU6T71pTCB+UTo0YxStBiH
	 6fx5kfOO6lZZY9h/CZUELfkU0w2gvKu4+r3bj5FU=
Date: Tue, 16 Jun 2026 10:57:20 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: ylong030@ucr.edu, asml.silence@gmail.com, bird@lzu.edu.cn,
	n05ec@lzu.edu.cn, tomapufckgml@gmail.com, yifanwucs@gmail.com,
	yuantan098@gmail.com, zcliangcn@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: fix signed comparison in"
 failed to apply to 5.15-stable tree
Message-ID: <2026061613-purplish-macarena-b8f0@gregkh>
References: <2026050147-vitality-crayfish-d8e1@gregkh>
 <c5c51528-5bbd-48d7-860f-e45f5bc42649@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c51528-5bbd-48d7-860f-e45f5bc42649@kernel.dk>

On Fri, May 01, 2026 at 08:50:20PM -0600, Jens Axboe wrote:
> On 5/1/26 5:08 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 326941b22806cbf2df1fbfe902b7908b368cce42
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050147-vitality-crayfish-d8e1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's a version of that for 5.15 AND 5.10-stable, please apply for both.

Now applied, thanks.

greg k-h
