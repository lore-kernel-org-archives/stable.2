Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DA4218A3
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603319; cv=none; b=gq+jwIauO90BYl8qcA4bGe9Ub7mKy6kM5+bUevnT3JDc2eUOljfx9MioZYtI+DV9gy+9OOhozivvIShSdNZWe5xaTjG2U+7esAfUn86W8FP1nOSLiZd7kSQ5oblFOVVHvSOwzXT8H4OXO0xh9vFYDMFKhTF3QE5xBh25VQy1Edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603319; c=relaxed/simple;
	bh=iG49210mPJRB346YjOoXvwu+ax2F6sy5x/U7luKa+dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+G+7uNKJ9TcQQnW/FzDsuaWfPSQRvuuVlo0PJPUEH5g6FwiCvlc3VFymYxHllq6ZAINqbwJSmjge3fzjIJK+qYuj/X1ujW1AtX4wlirHrtZiKlvVKSsf5kx35S4cOx+ngZQPAl+NNeqglO7KbmNuC6JNAoY92K5CpTAA+sIwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8+W7b+l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8+W7b+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781603317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iG49210mPJRB346YjOoXvwu+ax2F6sy5x/U7luKa+dU=;
	b=e8+W7b+lE7l9OKUNxUgMfSLavY/6tyid8em3BtUEWQMhBF+If9b+noxWBt9SVxObE1bZ7Z
	OIAu1KBI3gVjqDgb7zYAUH6kQkbINxuEf84dZ6W7G6I4yAOPgmFkuf6brV5QhV/I7sVukE
	srD7h4tbdPmttXoRbY8nbU0q5gU0uB0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-3JPyiv44NBySqQcyDJU7qQ-1; Tue,
 16 Jun 2026 05:48:33 -0400
X-MC-Unique: 3JPyiv44NBySqQcyDJU7qQ-1
X-Mimecast-MFC-AGG-ID: 3JPyiv44NBySqQcyDJU7qQ_1781603311
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E043180065E;
	Tue, 16 Jun 2026 09:48:31 +0000 (UTC)
Received: from fedora (unknown [10.44.32.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 100FF180028B;
	Tue, 16 Jun 2026 09:48:26 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 16 Jun 2026 11:48:30 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:48:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>, Qian Cai <cai@lca.pw>,
	sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ajEb6efEx1FexevD@redhat.com>
References: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
 <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 06/15, Breno Leitao wrote:
>
> Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
> lock only to look up and pin each task. The stack is then scanned with no
> lock held, so cond_resched() runs between tasks and the scan stops early
> on scan_should_stop(). This follows the next_tgid()/task_seq_get_next()
> iteration pattern and keeps each RCU critical section short.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

