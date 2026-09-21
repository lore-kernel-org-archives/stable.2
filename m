Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81F426D3F
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000065; cv=none; b=ar9CcS8uPcYcXnRatHmFBRU/huPbV9MNrp+27EfQ/aB1iWZcZrq2DksottUEAN+0nbp9MhlHEQpBCtQr6OqMTUsrvlZodowbxHfdC6VjQta3EedhzGhV97FyqETmCzF9V2WctGwYEqSR2bN6h1Rut5d1/1VIwsOclOXtwro2Npo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000065; c=relaxed/simple;
	bh=bO3eqdk+KhsgCeaaCoHMrCMXw1pX4k1IkldDHTIa6L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g03Zl26wBiVdVroAsyuzAqv7rxYk95vM6QfYBbpHgFtjKpWYlg2Xc0CtkqH4cmWRl8IltSXgmh1b6lEwylgrsHnKBpiQ14T2gUiP6SJvs5VslgKCezGvlJC/BNX5IVtaH1NEG7fPEmWytHLVrKSkhKVCJRENtK28ZkcaR2VixFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHWV+bB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHWV+bB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790000062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moO88O+F0fAZ0OS5+T5zgKqHROvYfe+dUtWbWvUTEmQ=;
	b=RHWV+bB4vHAi1qK2bFDfTyHOiwWkuTgZsKO9+2Xw6z5/t3uXDmSD55AOBq+LzvX10fig/U
	Nv63BOklBTQvsUNYh5ULyI+NJbIqGrq1s/wkCYtIS6160hhNem3s09WxP8zCqjLiDCO7MF
	zq+6H337ADg1xo1yVw4HYxtmyrWSBnk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-PCjHSjL8OHGda3XrwctxBg-1; Mon,
 21 Sep 2026 10:14:19 -0400
X-MC-Unique: PCjHSjL8OHGda3XrwctxBg-1
X-Mimecast-MFC-AGG-ID: PCjHSjL8OHGda3XrwctxBg_1790000057
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9953D18011EA;
	Mon, 21 Sep 2026 14:14:16 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 397C219539A7;
	Mon, 21 Sep 2026 14:14:12 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 16:14:16 +0200 (CEST)
Date: Mon, 21 Sep 2026 16:14:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 09/17] ptrace: refuse to change the signal mask of a
 user worker
Message-ID: <arE7soBASlufuPaI@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-9-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-9-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/21, Christian Brauner wrote:
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1227,6 +1227,12 @@ int ptrace_request(struct task_struct *child, long request,
>  	case PTRACE_SETSIGMASK: {
>  		sigset_t new_set;
>
> +		/* A user worker only ever takes SIGKILL and SIGSTOP. */
> +		if (child->flags & PF_USER_WORKER) {
> +			ret = -EPERM;
> +			break;
> +		}

Acked-by: Oleg Nesterov <oleg@redhat.com>

