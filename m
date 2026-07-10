Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6C3C4B9A;
	Fri, 10 Jul 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685650; cv=none; b=Vt+2N1Xs8/BrMXq3M6WQf24j3FgMStYGURPBIy1Qf6W5KAGhvrIppwJ+aT7S+JYhMLdr3TchUQ+HdWmcj0EuKis0DQWm9ZEpK/opc1glUGx052yDK+TnG5BffcUJHiAP74CL8nXl2HtrvZkTuRcLlUwISsBwixGRxeRN+18IAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685650; c=relaxed/simple;
	bh=bdjRNhk3RVjPJ9TsFlHMSflZ1bbdKMQB0TUYLZ8JXs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUfmwcHhBKvrEejNu6zuEVMFHFr89meo8bTalixQRAOgCn5tK357cUiGUWSUux/91DXX5rMV66Z0qdkU6wJnKNGCTXM8oMxTCbklK1R6ES0I88dwccHO75w8JAhvsZaITxkFxcB9RfSei4oZAgJiq0DpZXyS2IzY8Pktmv/wmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=za01vZcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="za01vZcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E9C1F000E9;
	Fri, 10 Jul 2026 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783685649;
	bh=d1q24GUI6rsOfMLlnXuF7mfh7deLK/3ISIR9kpFFfVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=za01vZcO9eMchxVzzR7TPgdHicizAe7/Cs5hofAfBFdTmJI8wOgK9IL08mGNIzOos
	 +a1waIk+8NS7RxhIf8SYnp7SrXj23Ol6koytsu5sPyWqZIbXjISXqyZ8SXExLsZTQj
	 6BxsMuGsYNLCdQ61Q6tqxI45oVXxtZ5oZdCZUcM8=
Date: Fri, 10 Jul 2026 14:14:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Zhaolong <wangzhaolong@fnnas.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, albanhuang@tencent.com,
	tombinfan@tencent.com, jackzxcui1989@163.com, kees@kernel.org,
	osama.abdelkader@gmail.com, realwujing@gmail.com
Subject: Re: [PATCH v2] serial: 8250: fix shared IRQ startup race causing IRQ
 warning
Message-ID: <2026071035-shadow-headrest-17de@gregkh>
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
 <20260708031115.3757150-1-wangzhaolong@fnnas.com>
 <25599a7f-e9cb-4aa0-a375-d9b4ed52be5e@kernel.org>
 <5cf37150673ea4d5c28f94db91cdf68504b50522.5fc19520.ca7d.459c.8589.c67efbed854f@feishu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.5fc19520.ca7d.459c.8589.c67efbed854f@feishu.cn>

On Wed, Jul 08, 2026 at 02:20:34PM +0800, Wang Zhaolong wrote:
> 
> > From: "Jiri Slaby"<jirislaby@kernel.org>
> > Date:  Wed, Jul 8, 2026, 2:03 PM
> > Subject:  Re: [PATCH v2] serial: 8250: fix shared IRQ startup race causing IRQ warning
> > To: "Wang Zhaolong"<wangzhaolong@fnnas.com>, <gregkh@linuxfoundation.org>
> > Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>, <albanhuang@tencent.com>, <tombinfan@tencent.com>, <jackzxcui1989@163.com>, <kees@kernel.org>, <osama.abdelkader@gmail.com>, <realwujing@gmail.com>
> > Ah, you are fixing the same thing as:
> > https://lore.kernel.org/all/20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com/
> > 
> > I did not look up who of you was first.
> > 
> > Note the above contains you in the commit log:
> > Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
> > 
> > You both CCed each other, so you know the other's submission. I don't 
> > understand why you both send the patch? Anyway, you guys speak to each 
> > other and decide who sends the (fixed) patch.
> > 
> > On 08. 07. 26, 5:11, Wang Zhaolong wrote:
> > ...
> > > --- a/drivers/tty/serial/8250/8250_core.c
> > > +++ b/drivers/tty/serial/8250/8250_core.c
> > > @@ -154,10 +152,18 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
> > >   static int serial_link_irq_chain(struct uart_8250_port *up)
> > >   {
> > >           struct irq_info *i;
> > >           int ret;
> > >   
> > > +        /*
> > > +         * Keep the hash lock held until the first request_irq() completes.
> > > +         * The first port publishes i->head before request_irq() starts the IRQ;
> > > +         * a second port sharing the IRQ must not join the chain and run the
> > > +         * THRE test while the IRQ core is still bringing the line up.
> > > +         */
> > > +        guard(mutex)(&hash_mutex);
> > 
> > The same as in the other patch:
> > hash_mutex is no longer an appropriate name for this lock.
> > 
> > > +
> > >           i = serial_get_or_create_irq_info(up);
> > >           if (IS_ERR(i))
> > >                   return PTR_ERR(i);
> > >   
> > >           scoped_guard(spinlock_irq, &i->lock) {
> > 
> > thanks,
> > -- 
> > js
> > suse labs
> > 
> 
> Hi Jiri,
> 
> Thanks for looking.
> 
> Just to clarify the timeline: I reported this issue and posted the original
> minimal fix on May 27:
> 
>   https://lore.kernel.org/r/20260527092052.2086342-1-wangzhaolong@fnnas.com
> 
> I also pinged it on Jun 24:
> 
>   https://lore.kernel.org/r/ajtFoTHUQHJGYV5Q@MiniServer/
> 
> The other series was posted after my original submission and eventually
> converged on the same core locking change.  I had also commented on that
> series around v2/v3, pointing out the same startup race and the need to cover
> the first request_irq() completion, so I was aware of that thread.
> 
> I sent v2 to refresh my earlier minimal fix with a clearer subject and commit
> message, since the original patch had not received review.  My intent was not
> to create two competing fixes for the same issue.
> 
> I agree with your comment that hash_mutex is no longer a great name once it
> also serializes the first request_irq() completion.  I can send a v3 which
> renames it and keeps the patch focused on the required locking change.

Ok, I agree with Jiri here.  You two need to get together and agree on
what the final submission is, and how to properly attribute it.  Without
that, I'm not going to take either of these as it's obviously a mess.

Also, given that you both worked on this together (accidentally), odds
are it should just be a co-developed-by: tag being used.

thanks,

greg k-h
