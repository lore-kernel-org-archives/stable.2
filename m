Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431D364942
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022051; cv=none; b=ea9331K+b1dUXKKqVNXpoAAohS/dBPrSR6UOwD1N5dMvLpJSG+bb+nLnSTY75uun/xG2St2+Ni/ULFdd1kxd4XeG4uhIUOrMzLQmz0Q8088tuvGxwDmqc7ZeI6xDC7ZMWc4Qkop12rBhk+TyUUYE48HcW/lAN5XIqE2Qfk/TbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022051; c=relaxed/simple;
	bh=kdzjhGbLB/20GSErxZ1mVIgUWD0e739DSeSt3mySW70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unc4RMe+YWHCqDEHr0UaFYcZJMxVC5CNKh99b/7zRYb69MavhAYbdL5+4VgaT+Jf069rpWWQ3LJplYcghKmpXU50j7EH93TCMpp020bAT6TG4UHltRF9nooovfY+os4kNJODIYb4BQHdjwRW8V2LkzODxO9O4mClhUYmyQ1HAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icXC3Fgh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icXC3Fgh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781022049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQTypC+zUo+gB9LA59kpzVIAOOhzbl/lP+y21Fa313o=;
	b=icXC3FghM5ZKnDJDnEw891ytqJXQrTH9/AoSvPzemg5lv27oli4XggbDA1/W7WGrPfxIhh
	rnyW0F+pYRMXxbXoGnp6E0Rx24yRKDG8JJ7pxv6iFIaMNojLugyLtd5PFhwQybTiugKNB2
	AqvWlziR6BQ2HX4A7KpU0jhUTX/yibw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Qh-hSxSlPOiKJiFO7uVcJA-1; Tue,
 09 Jun 2026 12:20:46 -0400
X-MC-Unique: Qh-hSxSlPOiKJiFO7uVcJA-1
X-Mimecast-MFC-AGG-ID: Qh-hSxSlPOiKJiFO7uVcJA_1781022043
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D239180AC70;
	Tue,  9 Jun 2026 16:20:42 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EAA01956053;
	Tue,  9 Jun 2026 16:20:40 +0000 (UTC)
Date: Tue, 9 Jun 2026 12:20:38 -0400
From: Brian Foster <bfoster@redhat.com>
To: Eric Hagberg <ehagberg@janestreet.com>
Cc: Gregg Leventhal <gleventhal@janestreet.com>, hch@infradead.org,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [BUG] iomap/io_uring: O_APPEND async buffered write silently
 re-appends a data chunk (corruption) on XFS, 6.1.y/6.12.y
Message-ID: <aig9Vm2a_13bPc5G@bfoster>
References: <CAFN_u7FrgM4Dzie2jjkLwWV8P0dvUG_Wwy3Q9B3-2HnnWiDu8w@mail.gmail.com>
 <aiLxe-9Sub8cI3Py@bfoster>
 <aibns0xP6IVVNWh3@bfoster>
 <CAAH4uRB+Bh9UEVEW8Sb2yM4YhB-Q5UJ6KJJXari3DDF3n3S+-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4uRB+Bh9UEVEW8Sb2yM4YhB-Q5UJ6KJJXari3DDF3n3S+-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jun 08, 2026 at 01:17:10PM -0400, Eric Hagberg wrote:
> On Mon, Jun 8, 2026 at 12:03 PM Brian Foster <bfoster@redhat.com> wrote:
> > Another idea that came to mind is to try and just replace the -EAGAIN
> > return sequence from the low level iterator with a flag that triggers
> > -EAGAIN from the next iter advance. The idea here is to allow the write
> > to return partial completion (i.e. so no iov_iter revert) without having
> > to return an error from the lowest level in the stack. I had claude come
> > up with a quick patch [1] for reference/experimentation.
> >
> > This is based on v6.12 stable and compile tested only. It needs more
> > review and testing in general but might be worth throwing your
> > reproducer at if you can..?
> 
> With that patch applied, the reproducer runs clean - no errors - and
> gets roughly the same performance (maybe slightly better) as when run
> against a 6.18 kernel on the same VM.
> 

Thanks for testing. I'll look into some more regression testing of this
patch and try to clean it up and post it for proper review for stable.

Are you using the reproducer program in your original mail to test? If
so, does it require some concurrent memory pressure to reproduce, and
are you using anything in particular for that?

That test seems small enough that we could potentially include it in
fstests, though I'm still not so sure about the mem pressure part..
Since you guys wrote the test, any interest in porting into fstests? If
not I can look into it.

Brian

> Thanks,
> -Eric
> 

