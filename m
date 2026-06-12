Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E62E2EF9;
	Fri, 12 Jun 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230277; cv=none; b=KTxRdNQ11g9hhfplkqy+99UhJYOW9CR8MzRVtvr8+9gAb0MZQ//xWR8P2vuCr6E1AwSUegeLgiH1F0Gp5y1mAg5zNzNgJT4KpsJfD1N0B0CtCctD0PjC9c3QGkcwd4d4NsoUR494yGKh2Pdo+Pe8HMAJxQuAqpqg1J3B0oMK43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230277; c=relaxed/simple;
	bh=zTGBTXl0ViAN2GDQrYz3xiWUW1bXEx6iD0qdjwqLlzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s92IPTByVPqY47zNWX9/gjZVS/+IPl4lrVHRkGD3p1UFHJo4RwXu1C0YMxns2yy3pghZazkfQVfg2xOa36FL7vMR1J3lVGTwmdm85IYF0Htc1947rHM2sY2ilzVl6bvmhXt0ygTtfLeOlIGI3iPlR7Xvxe4CvtiUqNvRT2QDsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlS6glMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlS6glMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622EA1F000E9;
	Fri, 12 Jun 2026 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781230276;
	bh=vadAOQacVxu+iSmH7N1q5YcflWk6I88dj6tEMH9/Vos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UlS6glMcOW0m7YUvzbP9E3nC+hlxiUVWH7MiTBPiSyJEeSH8JPihQcD4btCvFJ/sb
	 LFZYNlaB+iwBwL/DuCQgnSfwhKYF43S7VWWZ+0iFkrIWWFIbmiy8iU2RbBUcVxz/Bn
	 C0Gm3ohtNfvBnxFdkBx4i1R9d4edFozm0UGYMX7Ns/pV48TT0Ow58uF8IvBzCc6YsY
	 SJzEgnr8+qZzZD9MbwGkoKBzMKnZ77ZBCyCuRHCUfeF4p7Gev2N0//MUYC5/Ev+2zW
	 MKd2aR8gmGdBxEkdRGtD1o7w9JaJwgv06JGk39YC2AgDBMl7EhNa68mUbmzHgCGDWt
	 Q7mBIVqNqEHZQ==
Date: Thu, 11 Jun 2026 19:11:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vlad Poenaru <vlad.wing@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260611191114.5bc43a59@kernel.org>
In-Reply-To: <20260610183621.3915271-1-vlad.wing@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Please trim the pages of slop in the commit message and the comments.

On Wed, 10 Jun 2026 11:36:21 -0700 Vlad Poenaru wrote:
> @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
> +	local_bh_disable();
> + 	poll_napi(dev);
> +	_local_bh_enable();

tglx, Sebastian, are you okay with using _local_bh_enable() to trick
softirq into not waking ksoftirqd? The problematic path is:

  scheduler -> printk -> netconsole -> raise softirq -> scheduler (deadlock)

so the softirq may never get serviced.

In netcons we try to avoid touching the network driver if the Tx path
locks are already held. Ideally we'd do something similar with the
scheduler. Try to do bare minimum if we may be in the scheduler.
Failing that - don't poll the driver if we were called with irqs
already disabled.

Or maybe we only poll from console->write_thread ?
