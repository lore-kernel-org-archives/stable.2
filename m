Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924D3C4B68
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994282; cv=none; b=U+K2G+duo7slGlBjrdmrkZrKIWLof+sY4TPfsRIPeCwIhLMwr7wbjFx4LBxq3V2Eq2RbU7u3fjdwrmbCsmVtxcTIQpY07NXJSshP52gbB/ZE2cYTv0oRQ0UKGcrlwshzg+JBJnw2cHtFVcHCbvz3gxPzZWPtCGBx2DtNCE9x/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994282; c=relaxed/simple;
	bh=aklumEa6XguIynReYEX+Y++SQ+69vSThlIRdZDlT/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpdGffUerGM4WIsbWr01PG9QflQ+4lAFPbqFoWNa9OBjTvZm3QnjH/AcRBvtJiiPz87ynC3mOlqOv4BsQwlUHL/T2ml+IReeeUUCEvWjuHVm06bPNgJOMyyrg5JMbik4zGfVRne78K7i4RcAFm20Fn1/yxXrIHPLRnujVORiBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Up9y+iX8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Up9y+iX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789994280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aklumEa6XguIynReYEX+Y++SQ+69vSThlIRdZDlT/FY=;
	b=Up9y+iX8RLigb/olOeOEoaSQbOZBpdloegmliGVXfSDxN8DlnkIuhedaTP0YWA7DsANSfp
	3j5oQSwl9PIR0CScU5/DGUFWn79etTlXt55sKtq0rGXybFmURBiWhBTJbUCrwiPIC1SGCb
	KFcgRLkBlFwywHXKEAXlhdcGLL7s4rk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-AVyL1piRM16vpWdFLrfcLw-1; Mon,
 21 Sep 2026 08:37:54 -0400
X-MC-Unique: AVyL1piRM16vpWdFLrfcLw-1
X-Mimecast-MFC-AGG-ID: AVyL1piRM16vpWdFLrfcLw_1789994273
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC4651956055;
	Mon, 21 Sep 2026 12:37:52 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A9A5E1956041;
	Mon, 21 Sep 2026 12:37:48 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 14:37:52 +0200 (CEST)
Date: Mon, 21 Sep 2026 14:37:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <arElG0TGxxLFn7Ul@redhat.com>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
 <aq0_lvHDViIpX_Mu@redhat.com>
 <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>
 <20260918-oliven-lebst-wohltat-c633868711f1@brauner>
 <arEHxPFFrRtvUSPJ@redhat.com>
 <20260921-aufwiegen-festwagen-ozonkonzentration-ffe78eafa8fa@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-aufwiegen-festwagen-ozonkonzentration-ffe78eafa8fa@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/21, Christian Brauner wrote:
>
> On Mon, Sep 21, 2026 at 12:32:36PM +0200, Oleg Nesterov wrote:
> > On 09/18, Christian Brauner wrote:
> > >
> > > zap_process() skips every thread that has PF_POSTCOREDUMP set.
> > > do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
> > > io_uring_files_cancel() right after that.
> > >
> > > That runs task work, create_worker_cb() runs and creates a new io-wq
> > > worker. If a thread started a coredump rgith before that worker gets
> > > created from a thread with PF_POSTCOREDUMP set which zap_processes()
> > > doesn't see. So two ways of fixing this:
> >
> > Christian, I got lost ;)
> >
> > TBH, I don't understand why the new io worker is really bad in this case.
>
> zap_processes() only counts threads it sends SIGKILL too. But every
> thread that later finds ->core_state decrements that count. An io-wq
> worker created from the exiting thread isn't counted and exits right
> away because the io-wq exit bit is already set. So it decrements without
> having been counted.

Aaah, I forgot that the new worker can exit too and notice
signal->core_state != NULL in synchronize_group_exit(). Thanks.

> > But lets forget about coredump/zap_process. With the change below the
> > io_uring_files_cancel() paths will no longer be able to create a new
> > worker, even if coredump is not in progress.
> >
> > Is it correct?
>
> Yes.

Great. Then I think your change is fine.

Oleg.

