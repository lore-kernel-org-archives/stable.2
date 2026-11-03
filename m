Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693663;
	b=TFz3jYBP7JHPXxR98Jg41j8gkmAyWehCOSddnHI9bXJ4rZ8J8sXRGT8QA2SW9khImJgq
	 SJ9aRjZjqOnEOu1/NUbFy6jFllqRnsBQzPuYOkmnIqkvux3vj7vjGjWyDeXsjGIa9ngBn
	 BQFt1ky0Ap2jJbG5zkLleCghaClZi0hwG8GdQttue3WvscF1a1wHb5OsJzzA0b+1oNsLQ
	 ZUD53cuwMW4WH9tJkLY17RfEXRjYj83QkSyIJTwbX0aMGfSClgdxkp9mZOiM34SXObGqW
	 0opvh4BbV9ob3+DvAg/h7mg0FDToj+5DlQepimHci3pmEaPDgtA1HaiobCcpFUuZrdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693663;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=9WvENImLqxCgY1amf4low1ga5uTuzK/2834N4b/cV4Q=;
	b=p+9GB2VZ9eO1n2/9PUZJ6Eyxj53Uh1iuAFNRo97Ui90g643nXEHUR2vC8PsdqB96oskF
	 MkbvRWeqTSCoxeXd1ZHBLul1AGXJUoJy45zpHinjNo2Scy+jEkh3iy6OqG8JcpNVyitqK
	 HL8NK+5hsSBunsBso0q3rI5cJSjMktXYwDGvZVSiFR+8vqYKJwBLzrIp2uIR3h4tNdQGK
	 vzUmbEtZTCUlmE4vZfm0wrMkgI7N4OKyj+5qdqjFdedUT364TC4W5r8KZvGYHSnW2Jppc
	 x6P6ipJ3LnMpwhf3gIO4mWuCG9orb1yA7p2selGXgIjTCvPjQZQULGa64GW2KgD2hrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07995606A324;
	Tue,  3 Nov 2026 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07995606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8187468BEB; Tue,  3 Nov 2026 09:14:18 +0100 (CET)
Date: Tue, 3 Nov 2026 09:14:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: wait for SRCU readers before splicing the
 namespace list
Message-ID: <20261103081418.GB4301@lst.de>
References: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com>
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
In-Reply-To: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 03, 2026 at 01:30:35AM -0500, Qiliang Yuan wrote:
> Readers walk ctrl->namespaces under ctrl->srcu, and some of them sleep
> there, e.g. nvme_wait_freeze() waiting for I/O to drain.
> 
> nvme_remove_namespaces() moves the list onto its on-stack ns_list with
> list_splice_init_rcu(), which only waits for RCU readers before
> relinking the entries. A reader still on the last namespace then follows
> its next pointer to ns_list instead of ctrl->namespaces and treats the
> stack as a namespace. Deleting a controller while a Format NVM
> passthrough waits for a delayed read on the last namespace gives:
> 
>   BUG: KASAN: stack-out-of-bounds in nvme_wait_freeze+0x102/0x120
>   Read of size 8 at addr ff110001d2f3fc38 by task nvme/4413
>   Call Trace:
>    nvme_wait_freeze
>    nvme_passthru_start
>    nvme_submit_user_cmd
>    nvme_user_cmd
>    nvme_dev_ioctl
>   BUG: unable to handle page fault for address: ffffffff8af04850
> 
> Open-code the splice and wait for SRCU readers instead. This also takes
> the RCU grace period out of every controller deletion:

This feels like a design issue with list_splice_init_rcu or rather
using list_splice_init_rcu with SRCU.  Do we need to encapsulate
and verify this logic in a list_splice_init_srcu so that other
potential users won't get it wrong again?

> 
>   64 tcp controllers, 1 namespace each   before        after
>   nvme disconnect-all (ms)               3543 / 3474   3221 / 3146
>   nvme_remove_namespaces() avg (ms)      39.6 / 38.9   34.4 / 33.7
> 
> Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  drivers/nvme/host/core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..8f032b3edde9a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4754,10 +4754,25 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	/* this is a no-op when called from the controller reset handler */
>  	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>  
> +	/*
> +	 * Readers walk the list under ctrl->srcu, so hide the namespaces from
> +	 * new readers and wait for the current ones before moving them over.
> +	 * list_splice_init_rcu() can't be used as it only waits for RCU
> +	 * readers.
> +	 */
>  	mutex_lock(&ctrl->namespaces_lock);
> -	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
> +	if (!list_empty(&ctrl->namespaces)) {
> +		struct list_head *first = ctrl->namespaces.next;
> +		struct list_head *last = ctrl->namespaces.prev;
> +
> +		INIT_LIST_HEAD_RCU(&ctrl->namespaces);
> +		synchronize_srcu(&ctrl->srcu);
> +		ns_list.next = first;
> +		ns_list.prev = last;
> +		first->prev = &ns_list;
> +		last->next = &ns_list;
> +	}
>  	mutex_unlock(&ctrl->namespaces_lock);
> -	synchronize_srcu(&ctrl->srcu);
>  
>  	list_for_each_entry_safe(ns, next, &ns_list, list)
>  		nvme_ns_remove(ns);
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b
> 
> Best regards,
> -- 
> Qiliang Yuan <odys.yuan@gmail.com>
---end quoted text---
