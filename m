Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C84318EF4
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829736; cv=none; b=iv2vPXgvdmcTrjhvKmq+vuPoB91dnLo24P8YQ1xXmTwR1cWoTV7fjrdPtcG5YV8GpTiiN2FZ9zk+pJaIoq6BI8V2REH9QjxzxJtiXF2xE4TqulLLfvT29Yo6ef32e5mYHUM9YODVrCjx8eRXqqeF5KsJxKprqXKZlx0RbsruD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829736; c=relaxed/simple;
	bh=zDchtkG0SHxwHlkSQPxGEA64pnEyQcwoePej9IajXBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMIa5SspfO3W1Q085erPrhSyXjniIdSael89pmcKev6GglVv5iuYW2J6DU5J+Xx4JNcw/PZ/TggfmaNC7qNi6tG5Bq0DMq20rlSQMuj9iQIStB/uEgWEYog+yCvTzAQSpXp4h5y5r7CBLpNlm367o+kQEYwuQVwVpmk2WmMoCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QY4FP97K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QY4FP97K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780829734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M529Pw8aQ7DzKV9C1FdjvA3fcDeW8DhgDiOdy61/ANI=;
	b=QY4FP97KHpPFx7isVtGjd+j16nUnM47z9E33zEs5KzyAbFV8LH6R+1r88HWIef5h6sRi5n
	rQ6HX+WfcxAdZCeWqtYmQkzEPAJG0YUCFHzHGjoXjRTBoRoGblRWAhegNTXgjgCAMZq9ky
	1uNPUFB3fY8JOiul5o9xYF/leKI0fBw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-4YQwnNpRPiaAzfHiQUe45Q-1; Sun,
 07 Jun 2026 06:55:27 -0400
X-MC-Unique: 4YQwnNpRPiaAzfHiQUe45Q-1
X-Mimecast-MFC-AGG-ID: 4YQwnNpRPiaAzfHiQUe45Q_1780829725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A90C918004A9;
	Sun,  7 Jun 2026 10:55:23 +0000 (UTC)
Received: from fedora (unknown [10.44.32.36])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 611511800367;
	Sun,  7 Jun 2026 10:55:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Jun 2026 12:55:23 +0200 (CEST)
Date: Sun, 7 Jun 2026 12:55:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,
	Michal Hocko <mhocko@suse.com>, Ben Segall <bsegall@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <kees@kernel.org>, Liam Howlett <liam@infradead.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 015/332] kernel/fork: validate exit_signal in
 kernel_clone()
Message-ID: <aiVOEKt9QL5cvkwz@redhat.com>
References: <20260607095728.031258202@linuxfoundation.org>
 <20260607095728.598854921@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607095728.598854921@linuxfoundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 06/07, Greg Kroah-Hartman wrote:
>
> 7.0-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> [ Upstream commit 09e7827e785729f391c8d46dc71becce70d296ab ]

I don't think this is the -stable material.

> Note that this is a user-visible change: previously, passing an invalid
> exit_signal to clone() was silently accepted.  The man page for clone()
> does not document any defined behavior for invalid exit_signal values, so
> rejecting them with -EINVAL is the correct behavior.  It is unlikely that
> any sane application relies on passing an invalid exit_signal.

Yes...

This patch is the preparation for another commit 0f8e38eeb995b
("do_notify_parent: sanitize the valid_signal() checks").

Oleg.

