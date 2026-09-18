Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DC4052C5
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741458; cv=none; b=TGTYcyAaJDEDcFXh7o9klbedo1hDS87sALyyhdmbpn2kO0GqGfe3VK+PLx2EaFDGKUUSya8AWe7Ey0TciJ/FmJIX8CWSE0k3CHbHLaX1wk5Ctw/dL6tJiqO2aK3AbvQlJTX5YO73QO7IsbEFnSy2ZasiMtrObTMFyXPHRAnxVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741458; c=relaxed/simple;
	bh=1H1osbXaC7JZx474r3JdopArxaI4SmiR3L4D7z0R4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVxdCvivsLGBIUXDyxGwbaB+6s5t0c7jSvNg6SRgpD5sT7hWr8Eq+FFzk4Uma1FVBgGVEM58s2XpVnQSYxEXa5FiLAAOSIdgstSw5ILh7mIVEPulcrjuS2ltjnE/ms0IczJHC6mBPkkU67r2TQYNEo9fTS+uYM/CojEZasUV5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH/gd1QN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH/gd1QN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789741456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COGJ2JvndcwpiY85nNJ0ortnJmNdGWOwG92Ky7RrAcw=;
	b=QH/gd1QNItoZrAt3/60FFm+xmBKvmFkF8D3MymibwgUxXBsgFuvxO5zlQp1wK2Xa5xUk8S
	JaA0KNWbvtsZ/MriitIxWOCZeBMUrM3yI+D+CLKWBV5BxZ2paASnr190mRKEdCZwDAb1XR
	UODBcpvCeHs1rR5e/O22hKYby+vSbXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-_WEziOAXOlWM0WqjR88tKg-1; Fri,
 18 Sep 2026 10:24:12 -0400
X-MC-Unique: _WEziOAXOlWM0WqjR88tKg-1
X-Mimecast-MFC-AGG-ID: _WEziOAXOlWM0WqjR88tKg_1789741450
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811BE188307C;
	Fri, 18 Sep 2026 14:24:09 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6FDD5195604D;
	Fri, 18 Sep 2026 14:24:05 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 18 Sep 2026 16:24:09 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:24:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] signal: don't retarget shared signals in a dying
 thread group
Message-ID: <aq1JhBwfJKSKNNCU@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-6-f3787fcda051@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-work-coredump-fixes-v2-6-f3787fcda051@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/17, Christian Brauner wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3117,6 +3117,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
>  	sigset_t retarget;
>  	struct task_struct *t;
>
> +	/* Nobody dequeues them in a dying group, see get_signal(). */
> +	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
> +		return;

Acked-by: Oleg Nesterov <oleg@redhat.com>

