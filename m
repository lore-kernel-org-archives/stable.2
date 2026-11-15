Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794714225;
	b=1q4lHh/k1rwTKar3V17HQcwhdNW0edon5vunLxrTfyxugNVYEGqSq3fLhUJcvPyof+m3
	 hPeBkj1OcJdAZRkmaQcjZzNp8h6G9t7fSKM18cfpproLkPGOO1zbVQvBuN5iNqNarF86L
	 LFl9HAhgMOEz9mqmvsDRbYfKh1RdKkw9JZ7DEe32bKfk5B+3ZiAGX4P5ofoztwfOlFhce
	 47uTi8wrCrxGspdq96k0EMKUkbFQljkVxU4ehsLkwWmFUFdxGN8xoj5bTtXV95Gxw7WnB
	 RhdnwTA7MU2CHVXu9ZvL2HSyb/doI1K1wle1+MGJTCwO9v3309pFvoBrn2Wwu85As8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fuu4w8y4QBhDhcl+D0bGJubWdG7NjDIVPTDRgmaLY50=;
	b=mRnv+ysDNVb1eXfxacdro6+3KUDppi84it8AlNex/KXUFzWxf2NWTH5XiFTIOhRrNeQn
	 mcDBUM4yUtqXmqj1RrikBHhTsrBWwyw+m0KthusxsZ3SdJrIyN2KI2c61gUVRYiEe+T57
	 RExv9PD2jIFxNlmmEuvjcMV5HoFkIvj952xM4mTixA9JaxfpjUsslYTdFJh1Yj1sf++Zs
	 E+WV0H+a/V+Dt/JPhrbXIjGfw8RYfMaVXa58ltzQz9l7xg+FzSySQNCpkScmeXXOp2pKo
	 vA/G68clr/LEWSnOJzMniD6t4kGkiYkerssuf78jRZjDkvsqDLXKJIeCFDdyES1Yykw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBBgxW2Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 16C7D606A327;
	Sun, 15 Nov 2026 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBBgxW2Q
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2892D1F000C4;
	Sun, 15 Nov 2026 03:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714224;
	bh=fuu4w8y4QBhDhcl+D0bGJubWdG7NjDIVPTDRgmaLY50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UBBgxW2QQ+H04TvxaOsthH8nhi77uGHQLQsuSeLr5a5JoSGXwXR2jcztp4jAtOevh
	 YXUlIB+oQOa8ohY1FxX+k67D10dCIXBZhF4AK9ZjQeUH6Q0yxqlnl71aFlZyMjgIJ/
	 C4iVZJT2iJ/xGolYjMF2i2TPHNlo6cV888gy5MM0Og0VAXChREcvJyVZWghDN2NhxQ
	 Ry+DaiLx2pOvwxFpDkBQFO3uZJwP8qQkVwOpt1IVdceU7CzBIeGvKRh3AZ/HYca/VS
	 g8GIWFuZdrX5fr1hCrLaYj2jd2rMGjDX8JvRK5W1OZZ5ke8vJeFUivMxoNPOlA3HHs
	 +BQTOv5i3ePhQ==
Date: Sat, 14 Nov 2026 22:43:43 -0500
From: Joel Fernandes <jfern@kernel.org>
To: Chris Wiseman <chriswiseman@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <20261115034343.GA1016414@joelbox>
References: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>
 <20261115023115.GA3752240@joelbox>
 <18e81aaf93650e1b.3137322e32332e3235332e313736.231b55.0000sendgmr@google.com>
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
In-Reply-To: <18e81aaf93650e1b.3137322e32332e3235332e313736.231b55.0000sendgmr@google.com>



On chriswiseman@google.com wrote:
> Hi Joel,
> 
> > Looks reasonable to me. Is there a test case that you added to find this, or any
> > power savings that you found with this added patch?
> 
> I spotted this while tracing idle rcuog wakeups with CONFIG_RCU_LAZY=y
> and rcu_nocbs=all, where rcuog kept waking up after 1 jiffy whenever a
> second CPU in the group queued a lazy callback.  I verified it with
> rcutorture (NOCB01) and measured a light background callback workload on
> an arm64 system:
> 
>                         Before          After           Delta
> rcuog wakeups:          1,885           1,174           -37.7%
> 1-jiffy timer resets:     739               0          -100.0%
> SoC power (CPU+DSU):   94.1 mW         76.5 mW          -18.6% (-17.5 mW)
> 

Looks nice! I will apply the patch and run some tests.

Reviewed-by: Joel Fernandes <jfern@kernel.org>

> Thanks,
> Chris
