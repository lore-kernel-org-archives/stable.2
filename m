Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284284;
	b=xeV997osUGbeSiS6eduiehkkL5gmbkjWcu725JxCjFTNqaA+GBsIORpVPDYVhtv+W9m3
	 NWaOZTtrgKi9dqFHI+be9EzFO3DBcXwjox/ikADU07/lhgSeODQozO9PxrXDPvVZBC8Er
	 cm3Yyxxm2HxMhPm94+gr5uQCAxWsUQyOSUG02lrkx4tzGwDtDoADrmq//Ei6tUq/CK5VH
	 U2koJv2wiZjNN8QUN8mVhwfbmr+dQ6RjCHYw9GilGLMXPgOly1X4zJZa2hB5Uy9nV23Vy
	 k0x8F5PkcrHIUzGXs9KVyhw5y+nKPphgQPNK/7PkkKTrRUG7JbCZGtc+zKAM+gC1HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284284;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=01nmAsoYPJKA+BrrlSiNtDfrv6z2N8+l8YqH7IDGRcI=;
	b=3LYuNBpEqKJ55LoIWcl9E5G/T7jwnbenRG1faKQq6vp9Gce4nXGTVyrRrjXCDKD5xQ23
	 Ieva0c0cWpM1LEvHit+cE+1WpJuHhDvvJwVCHXZRsr2b1KqkbVvIthRXTUmH9W/Tq9yMG
	 4HvdtkgzYaFE/GHj+G6998bcmzSMbekX5pD5YFdnksq7I592GkoVs2y3Pu3MJmqe95Wdf
	 dWuxt9ZI4AcctWUWjeLlUWDS+9qIT282eNA3pEm1cGyDDsW12TXX+CpCx6zKLE5nLdY6h
	 VJDXHaLZiuA98SeUSf1B7OkG7tl0BGKC7tU/Hi8fHN8+F2Lm3293yHEhWdvjLuBMsAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yLW1Gt9u;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDF606A31E;
	Thu, 29 Oct 2026 14:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00FDF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yLW1Gt9u
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7759BC0404;
	Thu, 29 Oct 2026 14:31:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id EADE02002E;
	Thu, 29 Oct 2026 14:31:18 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:31:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Anvik Loitongbam <permissiontogallop@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
Message-ID: <20261029103117.50aae919@gandalf.local.home>
In-Reply-To: <3fa26fac-5317-4c09-a181-c9c15e124972@kernel.dk>
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
	<502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
	<20261029094842.58dc252d@gandalf.local.home>
	<3fa26fac-5317-4c09-a181-c9c15e124972@kernel.dk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4imy6fuq1gw3qz839ne4ra8f87xkf4j7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EADE02002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+JjW6nO4iATk1vhHY5G07RHKR/Uknq/JM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=01nmAsoYPJKA+BrrlSiNtDfrv6z2N8+l8YqH7IDGRcI=; b=yLW1Gt9uOF9d3jofjHLXly8TvL4ePv/Or19oXbgLrLm2x7i/OEkGz2BZbM2VwgAApsiRS+GjidI1dAlVxtBaEBVDGXS5npYDFdAwA5ZT4d6RMzCKGErIQxIo2gZxh7la6j2Z+DvUsKxt8yUFrj22gMDHR0p+exPFf+y6ucH3i4I=
X-HE-Tag: 1793284278-788853
X-HE-Meta: U2FsdGVkX18tlO22/dU+v0bLBcjGy/MNd1iHM0GJf4s1P3ZPPyejYm/PybPM6Oo2EzDV+CzfKqwapgcI3dLKaGXlOIzMKsMciDOociJfLK9gjrD6PflnPBas0alvblkhG4Y7QS5Xcn8fJN9uv+8fKYPDNkUSgUs6Tp9CylhQlzi1dMbSXSq3iOsg3DD9vRUAEeeRm6y7PLbIk8Lh3YTaWTJbIyJXFhF8rSprdP6H6m+yMqmHR5g/wX1O1Fp70a7ioQqgvAWC7NeHlepL/U81ZUYz50eR0PUJDfFQzL6UDaFRCnoO7xuQB3WYICDIWtp/

On Thu, 29 Oct 2026 08:28:13 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/29/26 7:48 AM, Steven Rostedt wrote:
> > On Thu, 29 Oct 2026 07:42:09 -0600
> > Jens Axboe <axboe@kernel.dk> wrote:
> >   
> >> I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
> >> should still be an RCU read side critical section. __rt_spin_lock()
> >> calls rcu_read_lock() after taking the rtmutex, and then
> >> rt_spin_unlock() drops it at the end. There's even a comment on
> >> kfree_rcu() callbacks in there too, it should not be able to run until
> >> napi_lock is released, which is post the loop.  
> > 
> > Good point.  
> 
> If even the preempt rt people can't get this right, that's a little
> worrying :)

I really didn't even take a deep look at how preempt-rt was involved. I
just didn't like the assumption about the RCU internals in general ;-)

> 
> >> IOW, I think this patch is unnecessary - there's no bug there. The list
> >> safe change could be done as a cleanup, but it's not a fix.  
> > 
> > I agree, it should still be applied, but as a clean up and not a fix.  
> 
> Sure, like I said, as a cleanup. But would need a resend as the
> analysis in the commit message is entirely wrong.
> 

Totally agree.

-- Steve

