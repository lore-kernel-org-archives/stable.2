Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDB3C1D62;
	Fri, 18 Sep 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741788; cv=none; b=KgIwRm5qjyk4tvvddgwez07pKcpRwjShcLKUGg9al3XXKY9DUHw+JXcWA/RQl17U3uRzuspa1TP040O5wKbPMYB/MHLysqCGHX10F9dulO//SvEqybKwGCE8oOWpmZtqjrRW0LZW99NAW/qRbJpHwOc8F02XMXT/vdvCbepBK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741788; c=relaxed/simple;
	bh=xNDIe4xQhd6rDetWv6az1RvXDpleYlAx/7+sFXaDpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpkoSxU8lFkbpBE7OEgrNbf0R1wZ/RQnzuCEiLhsGTmdy8NUfVjmeILQRkWXgrBSMnxs+7aO7DvLvaXhW6Ax6coXXiwR8vbA5SDvge+ZNeUjdgfNMh9AI8OMVc0ZIlxATMXmTlHCWL1fgRKVRTVD9JA/BVErzjbYz7+o0bA5K6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niy30VT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niy30VT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B521F000FF;
	Fri, 18 Sep 2026 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741786;
	bh=C3spve4byqYzWkhtX7Z1uSwfKm3Dog4UDZegAdsYF48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=niy30VT4DpS3IqJE3lE2Y38gqFkVE24N7haV1aSclNsAlIay2KKYOxlSYTspkkKe8
	 /oSj6ITWVBwXnyYHbckgRQdDTisYbCE0wzuyBwPxWfanIu5FxNvrSm+lqNBJyCURL0
	 HYLuktP6BDmXqLR7kL3FXIapydJQvdHSUWIYAurv4EKg4/i0HBfEXVX7mzKi8nLfA5
	 8O5nDFCa2ycK2jLsOjwY7bZTygYhMbKDlstsJx2oyBQnEXZIsTjf4H7XEEvCSEliYo
	 QYxVYcc/9gVGUkb3Jbq8vWklRjnbyAwuRpDOFxF9+979ek2oywaWuWTD8Mja64awcl
	 0FhnLa2vmlUmw==
Date: Fri, 18 Sep 2026 16:29:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
 <aq0_lvHDViIpX_Mu@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aq0_lvHDViIpX_Mu@redhat.com>

On Fri, Sep 18, 2026 at 03:41:42PM +0200, Oleg Nesterov wrote:
> On 09/18, Christian Brauner wrote:
> >
> > I think this works but they also need to check ->in_execve as the
> > exec'ing thread is obviously never signaled:
> >
> > @@ -2709,6 +2707,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
> >                 .user_worker    = 1,
> >         };
> >
> > +       /* A creator past its fatal signal or in execve gets no thread. */
> > +       if ((current->flags & PF_SIGNALED) || current->in_execve)
> > +               return ERR_PTR(-EINTR);
> 
> Ah, I forgot to mention...
> 
> Can we shift io_uring_task_cancel() up, after setting bprm->point_of_no_return
> but before de_thread() ?
> 
> I know nothing about io_uring, not sure this would be enough...

From my reading of this code it works.
The cancel runs task work and any create_worker_cb() queued before the
exec can still create an io-wq worker. If that happens before
de_thread(), that worker just becomes a sibling that de_thread() kills
and waits for. After the cancel nothing new can be queued.
