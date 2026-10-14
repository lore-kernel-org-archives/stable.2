Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E15326C4;
	Wed, 14 Oct 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985646; cv=none; b=U1OGzdicZ1daP6WypdBBQIM0OJhp/KjvkklNhYddVzL88HlocdcajHgMXkKibSH9rhvf5aDncoXrYLpRAn1YjbGunAESqDI1isp/OBBVo5IgmAZRWPhmMFCLD6thzRRKaKHchKbK1qtxCEu6WqO8e4GgzjimDwco5kh+/IkAJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985646; c=relaxed/simple;
	bh=6ASFf07XweXSERXGnO7twNJTmQ8Y8HezJlmn/kBZMII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbAbOcTy3fw4t5SS8Mnv4fTmNV0J7+Wi6f5tI/uIjEmLMDbs4OaepQUcBaPR8ERp7RIAbOIUCkFkOaff1e1moUnpP8JrYEquDlUsC47HU5G6v6L2AaL13II+LKmWWhoAaGCamheVhcEOT4G3mSl9B0jyJHbo2t5iEQVTP8gy6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=boO1QOH1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZqfWmao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="boO1QOH1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZqfWmao"
Date: Wed, 14 Oct 2026 15:47:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791985640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uVgl9VYfCbdSHLAssk4hvktk7d7dQKYFOwGQqB2NYo=;
	b=boO1QOH1cBIu7/DEtSP8qOicZRXgqc0B3025RrJrJiD+5eTuR6cBBmANJQiQrOtoyIWKMF
	i8dl5wZ67J9vEPw6UFsR38Cc70G6JbDCn4H9BuBpGmVQXetydRz0PIyuK3Br8dS3RKcf7r
	CzQJQnJHFrdH/mchTJa18kpcx9aWx1xiRtiDD03UiTcbRc8sWXpOT9e/TIjDTwffqPcf6I
	NuAx1dv9xy5Vv8IGZs7oJlBs4q4dDSUOhjEOupPrJ/4pqDwg6TbPEO0KaGogK/7g7z6J2i
	4iL+SrrNM/u3QQ1iaWi14xPVMlqzfekNSwjwHopgeT9vb3ymgK/iNOji4GU9fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791985640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uVgl9VYfCbdSHLAssk4hvktk7d7dQKYFOwGQqB2NYo=;
	b=IZqfWmaoyGoHLcJIbk9Xj/hGNsfvedsiTtoUeI+aH3a8qcMqFIdR8qOyER3Eqac+Fqmp4r
	CibG956GlCHZrbDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Subject: Re: [PATCH net v7 2/4] net: hsr: preserve submission order without a
 forwarding lock
Message-ID: <20261014134718.YGcKmfB9@linutronix.de>
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-3-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009201324.17-3-xiexinet@gmail.com>

On 2026-10-09 22:13:22 [+0200], Xin Xie wrote:
> Holding seqnr_lock across dev_queue_xmit() serializes numbering and
> submission, but creates transmit-lock dependencies that can deadlock
> stacked HSR devices. Merely shrinking the lock to the counter lets
> one CPU send frame N after another has sent N+1; old HSR peers discard
> the late N as stale.

What are stacked HSR devices? Looking from the setup in the referenced
report this is a bridge device attached to a HSR ring. 
An announce frame is sent and this goes to hsr_dev_xmit(). This does not
look like a normal setup. Is this something you use or is this something
the bot came up with?

> Use one consumer for master TX, interlink RX and internally generated
> supervision frames. An idle caller processes its own input inline;
> contended inputs wait in a FIFO drained by one BH work item. Allocate
> sequence numbers only when the consumer executes a frame, and submit
> it to every lower before numbering the next frame. The short counter
> lock is released before forwarding.
> 
> Limit queued inputs to 1024 jobs and 8 MiB, reserving capacity for
> internal supervision. Carry transmit recursion depth across deferred
> execution, cancel the worker and purge the queue on teardown, and count
> queue drops once through core per-CPU statistics. LAN A/B reception
> stays synchronous and tagged frames retain their received numbers.
> The ordering guarantee is per-lower submission, not physical wire
> order across multiple TX queues.
> 
> On PREEMPT_RT, high-priority load preempted both the inline consumer
> and BH worker while another CPU continued to enqueue inputs. All
> 2118 inputs completed without drops; the finite data workload
> completed 4.07 seconds after the load ended.

This looks very complex and I am not a big fan of it. I would prefer to
break lock chain early assuming the setup is valid/ sane (see above).

The ID by itself can be assigned with an atomic_inc() but then you don't
have the transmit ordering. So you introduce the workqueue for the
ordering which is ugh. I'm not sure how this works if you get
submissions from two CPUs given the lock is gone and the workqueue is
per-CPU.

> Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
> Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
> Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")
> Signed-off-by: Xin Xie <xiexinet@gmail.com>

Sebastian
