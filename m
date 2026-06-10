Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFE478E5A
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122707; cv=none; b=qwnjBn6+zQ8sJ+msvfM0ExyY0n1NVbP8UN2/70qMEK59p2ZDckibKF2LgDjNmuN6U1r6WLbIPntctqvZDppdWtFxHRN1X4JcJ8S6OrCe0k4LyuHmm3TR2QW3+LPOkzTHgzAFFFfnPTvo9XJz46eFmGYPr8h5w5ieRJqt98uMy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122707; c=relaxed/simple;
	bh=Y6MwGr2oEYK/SnCBrMYn6beno09KqZT2t1eU9aDIu1Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UBvNjPPllHcNKq1xCfcCmSv18hlZfk/K/v5py6LljvXjSQCe1XtZBxX6QBAQF1XE17AFOOsH+yUtxH1CA2V69lwYJR4gbjJIasyti4a1VCvilOS3ZmDkmWYYgaxM660f9NE/npFvqsPI+frgdBt9c0SxJzvsmsLeP5c9S6uyvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvvo1gfg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvvo1gfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781122704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Kqiuy5RLvww5uBDPzmc5eblCf78iN81cvtV4zBZRR4=;
	b=Mvvo1gfgntx0ubXNv+9T7zGEleM/m9gJBsghW5D93YSsq8zu4cFfwdGeQVzgihobLKNd3M
	hTEoBeYUWgOTkIrrPzA9OFVPI94AHdMpAvqF2uGL9gdrnOtP8dOfoX3q09k6P7+Tr3m0W+
	eFPFJ4CkfdiVlqIABPTaDMLAos1L5XI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-ztm57z7bMwmNOSpBBoUpaA-1; Wed,
 10 Jun 2026 16:18:18 -0400
X-MC-Unique: ztm57z7bMwmNOSpBBoUpaA-1
X-Mimecast-MFC-AGG-ID: ztm57z7bMwmNOSpBBoUpaA_1781122697
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3770A188EB6A;
	Wed, 10 Jun 2026 20:18:17 +0000 (UTC)
Received: from [10.44.48.10] (unknown [10.44.48.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4712E180057F;
	Wed, 10 Jun 2026 20:18:14 +0000 (UTC)
Date: Wed, 10 Jun 2026 22:18:08 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
cc: agk@redhat.com, snitzer@kernel.org, bmarzins@redhat.com, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] dm log writes: fix refcount leak in log_writes_map()
In-Reply-To: <20260609035243.184530-1-vulab@iscas.ac.cn>
Message-ID: <ae5a0cfc-37bd-2035-60e3-d459ad0cb194@redhat.com>
References: <20260609035243.184530-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Tue, 9 Jun 2026, Wentao Liang wrote:

> In log_writes_map(), when a discard bio is received and the device
> does not support discard, a pending block is allocated and its
> pending_blocks refcount is incremented, but the block is never
> freed. The function calls bio_endio(bio) and returns
> DM_MAPIO_SUBMITTED directly, bypassing normal_end_io() which would

Hi

Is this true? From my reading of the code, bio_endio calls clone_endio, 
clone_endio calls ti->type->end_io (that is normal_end_io for 
dm-log-writes), normal_end_io sees that bio_data_dir(bio) == WRITE 
(discards are treated as write requests in bio_data_dir), pb->block is 
non-NULL, so we grab spin_lock_irqsave(&lc->blocks_lock, flags); and add 
pb->block to the queue.

Am I missing something?

Mikulas

> enqueue the block for later release via the kthread. As a result,
> the refcount for the associated pending block is leaked, and
> pending_blocks never reaches zero, preventing log_writes_dtr() from
> completing and causing the device destruction to hang.
> 
> Free the block with free_pending_block() before completing the bio
> in the !device_supports_discard path, matching the error handling
> done when page allocation fails.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0e9cebe72459 ("dm: add log writes target")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/md/dm-log-writes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index c72e07c3f5a0..05133b1553ca 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -709,6 +709,8 @@ static int log_writes_map(struct dm_target *ti, struct bio *bio)
>  		WARN_ON(flush_bio || fua_bio);
>  		if (lc->device_supports_discard)
>  			goto map_bio;
> +		free_pending_block(lc, block);
> +		pb->block = NULL;
>  		bio_endio(bio);
>  		return DM_MAPIO_SUBMITTED;
>  	}
> -- 
> 2.34.1
> 

