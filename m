Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784847;
	b=F2gvBT5kawVpTmtq0Ez1i4VHsUJqovjJUhhJPFgn0WdlIEjGc0nCk7b9phbuF7dA53ig
	 kK8hbK0TT7eidU19TlD/je0kJ2dZDnMLRG83g4tSZOoLVTvbOxbCKeyOgrCSmtZZa6YR2
	 mfs4qV64s2g/d1X1+HlbkW+PWo4dp8z38IbWnAcQooyjtaDmWEqqKsm91JAuGGcWaJuI3
	 1/Of/9sKCx/Y+KGLLfVIlrJV8TULM+j3fAsRLHXyUFcV5BRM7X3L+zUwKkVU9QNHHRg+t
	 V4T9T73RUEmbEpYLs5O/kRgvmTC/34tLoRmLo6HJ+JGSoASaz1b8YYyWqZENPZ/ZWrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784847;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QeLhvkX3NWJ4S8JQPYbjel83/diYUBmz82AKkpUE+tA=;
	b=ozsdckAk4t+hyCuBzgcAe6gqDKvvM8qdm785qxvPmUfDq0CpxfXTWswl0hPosl3PV7t7
	 YoefDd33/WO9QTz7JXZrQkpBQ1eOlbGOONLFQ12lUBxTW8dGasGGZ8W1/HzudvBAmws3q
	 kNvPDruxvFDS1EG3aaULiGm7MAjTy6ijakQ7OaXKhmYe7DhjFt3pL8t/VWCh+vA3WsBCe
	 RZmdCzRS6PwQx2og8ZpfEW21U4LomkOjMcsIzsFfa/Q71HbhLkcZY+I2pTNb9Aw2joYQH
	 AmSvwdiKM/geLlr5IGfgOutdV5ReMm3zHO8QO2IcaRiK5oiH19TAr3g1W6659mQQUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIVzPsJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0DF5C606A31F;
	Sun, 15 Nov 2026 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eIVzPsJO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 28FBF1F000C4;
	Sun, 15 Nov 2026 23:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794784846;
	bh=QeLhvkX3NWJ4S8JQPYbjel83/diYUBmz82AKkpUE+tA=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=eIVzPsJO69ekiasN2+DKI13yQSBHSkfxRsthhZfWk3oHuARd3DcA9mLmqoK06rcOV
	 zy45GlQ+j2AbPir8fNu/CCaGfi6dICzlWqishevDgjbMzQfVTvTzFg8zQYuUES83iK
	 eQtZxTyE+a9tQ2avk5cMI7xmAiS956cYmxJ1BlLBjmRjrZ2tBnLj6AJ44dqq131i9b
	 j9wqiEcRqoXANUyD+2Rd3TGWEjR6i74EbxiMedbeTzelmzUGVqjxRF6KOlGNpDs8/2
	 vyCx8nTv+qN9nC2g+loJ43E6QTB8EbOzqwPTXy0oaZlB5vJeCAtAZX3ZRYYu0SbxDn
	 PURd6gUZ2WHYw==
Date: Sun, 15 Nov 2026 18:20:44 -0500
From: Joel Fernandes <jfern@kernel.org>
To: Chris Wiseman <chriswiseman@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
	Cheng-jui Wang <cheng-jui.wang@mediatek.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Keep lazy timer intact on second lazy callback
Message-ID: <20261115232044.GA3906606@joelbox>
References: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>
 <20261115023115.GA3752240@joelbox>
 <18e81aaf93650e1b.3137322e32332e3235332e313736.231b55.0000sendgmr@google.com>
 <20261115034343.GA1016414@joelbox>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115034343.GA1016414@joelbox>

On 11/14, Joel Fernandes <jfern@kernel.org> wrote:
> 
> 
> On chriswiseman@google.com wrote:
> > Hi Joel,
> > 
> > > Looks reasonable to me. Is there a test case that you added to find this, or any
> > > power savings that you found with this added patch?
> > 
> > I spotted this while tracing idle rcuog wakeups with CONFIG_RCU_LAZY=y
> > and rcu_nocbs=all, where rcuog kept waking up after 1 jiffy whenever a
> > second CPU in the group queued a lazy callback.  I verified it with
> > rcutorture (NOCB01) and measured a light background callback workload on
> > an arm64 system:
> > 
> >                         Before          After           Delta
> > rcuog wakeups:          1,885           1,174           -37.7%
> > 1-jiffy timer resets:     739               0          -100.0%
> > SoC power (CPU+DSU):   94.1 mW         76.5 mW          -18.6% (-17.5 mW)
> > 
> 
> Looks nice! I will apply the patch and run some tests.
> 
> Reviewed-by: Joel Fernandes <jfern@kernel.org>

Frederic, could you review from nocb PoV too and let me know if it looks good to you?

thanks,

Joel Fernandes
