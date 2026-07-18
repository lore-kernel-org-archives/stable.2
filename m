Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9037FF5E
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384034; cv=none; b=YV7e08tFdwSj8ZNyLHfCnXZuGmHisYJra5wGLQBilIm+MWBgoiQpxLRy4S4oOaRPtj0Z4fk/MMWGcp3qyNVQn7RvqT86EZ15WKobVYYKGdaW8gAneSBXqvD1OtE7IrsKkHofuPOR+GfeNnngP6mIJxLinMjR/6Qo6Y4Edg2eDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384034; c=relaxed/simple;
	bh=l02zWMAuDP6KcJlfFyW+ZETLma/XHm2vVvlqj9+yuVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZWNGvTM5c+jDSiSdurQ4zDfXJF+0IfsSATDxS+k5YrptoonaXBMv03vUy3Jd3ABPVUHrdflox+lGuPvUZvBdMyPhap0DD6ZI0Y56zhhWsGq5OF48W9q3kJ+VSMfTIsU4NKPXkbblqVDwVbJVyWYrocwqQXnV8txJIESwW7uhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5soukgo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5soukgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784384032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCU2rGh5Cxun9d6ye08sFZOUqBIoJdbLrfNH/ZbKECM=;
	b=F5soukgout7pr03SQPtdm2uzxyOgoK5iWWCKBo9oHON+GlGgyc9uHThI5RcUtx2cfcLzyS
	hbt1zD75mgnVh8uk6YarJYNZO2Em60JE7X2HgZtDqzHUI39vMI8Y7M7w/TdK6ZP7yDODtu
	EH//8UXmEAnU2sXWbxZkRg4VrkTwrLU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-YKB008Z-PliMca8TyjKf5Q-1; Sat,
 18 Jul 2026 10:13:46 -0400
X-MC-Unique: YKB008Z-PliMca8TyjKf5Q-1
X-Mimecast-MFC-AGG-ID: YKB008Z-PliMca8TyjKf5Q_1784384024
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC49018007ED;
	Sat, 18 Jul 2026 14:13:43 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7BBCE158A;
	Sat, 18 Jul 2026 14:13:39 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 18 Jul 2026 16:13:43 +0200 (CEST)
Date: Sat, 18 Jul 2026 16:13:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bradley Morgan <include@grrlz.net>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, brauner@kernel.org,
	akpm@linux-foundation.org, jack@suse.cz, avagin@gmail.com,
	ptikhomirov@virtuozzo.com, mjguzik@gmail.com,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
Message-ID: <aluKEZtkhbC0yUcT@redhat.com>
References: <20260718032000.9184-1-blbllhy@gmail.com>
 <20260718032000.9184-2-blbllhy@gmail.com>
 <alt9fbrO1WlJg-Jh@redhat.com>
 <FF14144B-5235-4805-8E78-5C1AFBCC631A@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF14144B-5235-4805-8E78-5C1AFBCC631A@grrlz.net>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 07/18, Bradley Morgan wrote:
>
> On July 18, 2026 2:19:57 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
>
> > Hmm. Why do we need get/put_pid() ? I think that
> >
> > 	rcu_read_lock();
> > 	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
> > 	rcu_read_unlock();
> >
> > 	return ret;
> >
> > should work just fine?
>
> youre right that the get/put is redundant. kill_pid() doesnt sleep, it just
> grabs tasklist_lock,

(no it doesn't take tasklist)

> but i dont think either form is actually safe, and thats the bit id like
> Cen to address. rcu_read_lock() only protects the pid if the freeing side
> defers to a grace period. on the cad_pid path it doesnt:
>
> proc_do_cad_pid():
> 	put_pid(xchg(&cad_pid, new_pid));

I must have missed something.

But this patch adds synchronize_rcu() before the final put_pid() ?

And. If kill_pid(rcu_dereference(cad_pid)) was not safe under rcu_read_lock(),
then get_pid(rcu_dereference(cad_pid)) would be equally unsafe?

Oleg.

