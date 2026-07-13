Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF34499A4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972139; cv=none; b=PJIOyFkwoEUzrw4kW1pSUvoEMzOCldi/F8Q0b83DSLWjKVPcQ4LkbToOt2pod05fMF6ptYVdnqjgbLNxIjBpRAcJ5Oh2ShGSnUS9NJs1UgNHXHCsilDBgcRfQ05H2AJwUqH2ywd8g3Xao8SKdfYR3sG2hTPQN2MkGzOc6A2STUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972139; c=relaxed/simple;
	bh=cl53LS9VyjfaeNhcfJF8+oJIveH4l0kNujEm4a/TVnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXqmewvXWcrkyU0+D66kMf3pJd0ebRswZBZUIGHGGsqaE8I76mWX/oVCTG623/tbZgbl/nTBvf6JqF1UB1nz+9vwtgzP2qvXy77VuBtAsjr/jfX5iktynnJnjTNQLL458VuGVbLQL2zmYX3eOvPiDHWNAbbYgcgMBeZOIDT/L+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xcxkn4Jj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xcxkn4Jj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783972136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oJ+EzR6/4eyBzTaIbA+IBRWvu+AJlHHcGpx6AmbYvOM=;
	b=Xcxkn4JjKVH8+Z8k75JvT6DKGR9WwgmND/UsAzwV14bOscuczQo4k+guWhp8l0Ude2D01v
	gnRBDBdV+qcp5QObPmbLm1LCABgB2eUiC8J9L2d/3Wx1ccMuZJBHBsGhxKsBOCY8ebJV3G
	GWH80GWsVts+LoR5NufHhDI8sKs80vw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-o9cP-YHWNDCVpkX7VZrznw-1; Mon,
 13 Jul 2026 15:48:53 -0400
X-MC-Unique: o9cP-YHWNDCVpkX7VZrznw-1
X-Mimecast-MFC-AGG-ID: o9cP-YHWNDCVpkX7VZrznw_1783972131
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 832761955D96;
	Mon, 13 Jul 2026 19:48:50 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 86B1130002DA;
	Mon, 13 Jul 2026 19:48:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 13 Jul 2026 21:48:50 +0200 (CEST)
Date: Mon, 13 Jul 2026 21:48:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bradley Morgan <include@grrlz.net>, akpm@linux-foundation.org,
	brauner@kernel.org, peterz@infradead.org, tglx@kernel.org,
	npiggin@gmail.com, pasha.tatashin@soleen.com, kees@kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: Re: [PATCH] reboot: enable IRQs before do_exit in the halt and power
 off fallback
Message-ID: <alVBG8OS4RBCOqDK@redhat.com>
References: <20260712125300.31501-1-include@grrlz.net>
 <87tsq3vbtf.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsq3vbtf.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/12, Eric W. Biederman wrote:
>
> Bradley Morgan <include@grrlz.net> writes:
>
> > The reboot syscall calls do_exit(0) after kernel_halt() or
> > kernel_power_off().  Those are expected to stop the machine and not
> > return.  When they do return (no PM info, power off failed), the
> > shutdown path has already disabled interrupts: native_machine_shutdown()
> > calls local_irq_disable() on x86, and do_exit() then hits its
> > WARN_ON(irqs_disabled()) at kernel/exit.c:930.
> >
> > do_exit only warns by design; make_task_dead() is the path that fixes
> > the IRQs disabled state (commit 001c28e57187 ("exit: Detect and fix irq
> > disabled state in oops")).  The reboot fallback is not an oops and wants
> > a clean do_exit, so enable IRQs at the two call sites instead, matching
> > the make_task_dead pattern.
>
> I think this is fixing symptoms not the actual cause.
>
> How does kernel_halt or kernel_power_off manage to return?

Agreed... and this was already reported twice at least. See

	https://lore.kernel.org/all/20250403-exit-v1-1-8e9266bfc4b7@debian.org/

	https://lore.kernel.org/all/20250410143937.1829272-1-Tze-nan.Wu@mediatek.com/

Oleg.

