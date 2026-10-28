Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202036;
	b=A/gfFCo/WYDQLWJH95pdUHLjMlzKnzof0BLZ/sikdL7lGvo/Dwo1nqiaoDSpilxRATSR
	 guL6CLwNGXLCv2nZV+Ve63PDTBDmoo2skaFY+gxnLXGRchf7xKW/OAO7yRUaihGGnhEe9
	 2FXZT1vPamvue/6uzlZpN62izXVLUHBhve44sdGtgreAqCOn4Tr6P5R2HrPu/lEsjTX2Z
	 2L5P9D6goVaQzfAJSNtLgEHOpZ9nvoy4iG6VkAf/2QXucg50lfEQDaJyEokZzOJqC8XAg
	 qlIeDWbp4VxwWZbEQfiEO1TBZhsoT5qim/egP027uilj0vicE/AhAKf0tKI/wDvGj1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202036;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CqX1Esr4DHlyO93/7HT9V4FPub0OPW5DGyWWWpehH18=;
	b=MBfZY7wvXQqWVrbK/oRVfHP96CoA4nMA/s8wonOb8fPJACN4WAHePn1A68Brs95uU1IE
	 lJ1VHu4nzAmk4BGE2Geed7TMVDpqQ5x8D1FHWjy7Uqgf8YiiZ2QakmZf+dkh6mT0zI6fZ
	 kC9QnGlsf2EkzYxkxgN06qhMS5dUShO/LwKf/BV9Y0mbP4Ju9R+5LRqnIvUv7R/ucCRE0
	 SxdaZxsvqAu72WZ07nPK2xpezXJs/nDA/RFm2uCnVW3xTgd6+wp+TesS5HNKa3UKMoiP5
	 byEEubVcNFA2+RexZgJjCIaYjQpXfn0RCuYnn6PZTA1SOVgG6BrrIAAsHlgdog38rOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUnSWZzg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4701606A32C;
	Wed, 28 Oct 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUnSWZzg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3C1F01825;
	Wed, 28 Oct 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202035;
	bh=CqX1Esr4DHlyO93/7HT9V4FPub0OPW5DGyWWWpehH18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUnSWZzgv9LNx0RhwRsO2Pduse14QOTQS5OSuu3QU/QnlR01u+dRylY3chGXUnIeS
	 FUoAJVigwbFrx97/d06slesNYq3TBnn1YyQS52c3JMIxI5v6KKaiGFsqIo5hcRMDxS
	 04u6rleJJmIsfIdgQEecGvmUbs3PZ4qYkXG4rKwvpfFvBdtwh1bi+uIC2lQXecEsDt
	 HfXcL4XpmuI4HXINfTWxHn2neCvJpycbXsb+PK8VqA4w9ngM2NGpB4se+foFTCpfek
	 PiZw2p3rnk9oU2LEWqoMFb/YuxOa9k6smAinE9QaPp4DMqY0WiRPK+Zbzftq9XtSwm
	 57wNxY94CIqAw==
Date: Wed, 28 Oct 2026 15:40:32 +0000
From: Simon Horman <horms@kernel.org>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfc: pn533: complete failed queued commands and
 keep queue moving
Message-ID: <20261028154032.GY257209@horms.kernel.org>
References: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
 <20261027070136.1339-2-zhaofeng2@cmss.chinamobile.com>
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
In-Reply-To: <20261027070136.1339-2-zhaofeng2@cmss.chinamobile.com>

On Tue, Oct 27, 2026 at 03:01:34PM +0800, Zhao Feng wrote:
> When pn533_wq_cmd() fails to send a queued command it silently drops
> it: the completion callback is never called, cmd_pending stays set and
> cmd_work is never rescheduled.  As a result:
> 
> - a synchronous caller sleeps forever in pn533_send_cmd_sync()'s
>   wait_for_completion();
> - an asynchronous caller is never completed, leaking its callback
>   context (e.g. struct pn533_data_exchange_arg, and the sock_hold()
>   reference for rawsock);
> - cmd_pending stuck at 1 makes every later command queue up without
>   ever being sent, freezing the device until unbind.
> 
> The broken error path is as old as the command queue, but it used to
> require an URB submission error to trigger; a device that stalls the
> OUT endpoint reaches it via the send timeout added by the next patch.
> 
> Call the command's completion callback with the error and reschedule
> cmd_work (unless the callback chained a direct command by returning
> -EINPROGRESS) so that every queued command completes with an error and
> the queue drains instead of freezing.
> 
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> Cc: <stable@vger.kernel.org>

I think this patch also warrants a Fixes tag.

I don't think it's necessary to repost just to address that,
rather you can just respond to this email with the appropriate tag.

Also, I note that this patch did not apply cleanly (using git am)
and thus the CI did not run. I think this is due to minor fuzz -
git am is very fussy about that. I am unsure if there is value in
reposting to address that.

I've looked over the review of v1 and the updates made in v2.
And overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
