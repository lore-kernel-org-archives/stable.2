Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840D4BC025
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813114; cv=none; b=SIOtU1qZgAvmrMZ5i/x3hRvhWBgTb7XifDXPEKjebd1FZnh63crlkpfiEOk8CDJTBNQ0LaoLxsntjh+CbCUngMAdaW7kP6D+BUqBiTylfh1EUhA5teGLVfSq6r58LhdYvZVX3JwGm1zRsaVfNHARtoU0Nxs1Qn+3dTxB1RvmkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813114; c=relaxed/simple;
	bh=NLl8xX64qUysTRlROeOb7n1q7keFDdRwmOKA4zAW6Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pa2Y87DgQdb8U+BW45oGKyRsAH7GY9jB3vCvDeeeys5JQSZQ1GD3KcB0I8rsNLVqvnSPIlfi7WudkYK/jKV3NqfDGoZ6RJ5bso0D3sV2ouGK4oGe8uktYWhxO+0NEruS4fJNndsMb6p4MEv2lXGCfq3zWNoVQ50xfMtlMx/PcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/0BOwq1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/0BOwq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784813109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLl8xX64qUysTRlROeOb7n1q7keFDdRwmOKA4zAW6Tw=;
	b=P/0BOwq1bJDPCqAtSL3UCT6HRB+69j5CfcmiZqhgCOC5f8bR0LF5hzoOuiLzMo8FKXzAj1
	mWUhsbuqMC46VHwVl1bzk/sZKgpO9bkQM/yDtf9OxW1SEtOKTmOMMLNN0U9bMmUVy7jXwK
	Y1MFgmlbBYZTY4dSGJRrMhNeGdZoSmI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-zjSYh1KQP7SmczsilVVRIA-1; Thu,
 23 Jul 2026 09:25:07 -0400
X-MC-Unique: zjSYh1KQP7SmczsilVVRIA-1
X-Mimecast-MFC-AGG-ID: zjSYh1KQP7SmczsilVVRIA_1784813105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E66A195398C;
	Thu, 23 Jul 2026 13:25:04 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.47.238.119])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 507563000225;
	Thu, 23 Jul 2026 13:24:57 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>,  Keno Fischer <keno@juliahub.com>,
  Ingo Molnar <mingo@redhat.com>,  "Peter Zijlstra <peterz@infradead.org>,
 Darren Hart" <dvhart@infradead.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Yang Tao
 <yang.tao172@zte.com.cn>,  Yi Wang <wang.yi59@zte.com.cn>,  Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,  stable@vger.kernel.org,
  Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <20260723-obgleich-kippt-gegeben-c84192e6d6bb@brauner> (Christian
	Brauner's message of "Thu, 23 Jul 2026 14:53:13 +0200")
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
	<87bjc0led9.ffs@fw13>
	<CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
	<87v7a7jeav.ffs@fw13>
	<20260723-obgleich-kippt-gegeben-c84192e6d6bb@brauner>
Date: Thu, 23 Jul 2026 15:24:54 +0200
Message-ID: <lhua4rh7s9l.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Christian Brauner:

> Fwiw, I added unique inode numbers for the lifetime of the system to
> pidfds some time ago. The inode number is allocated for every struct pid
> and available via pid->ino. A pidfd can be stat()ed to retrieve it. Just
> mentioning it in case this may be useful.

Is there an efficient way to get this without allocating a file
descriptor, and without /proc being mounted?

Thanks,
Florian

