Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864768;
	b=rx49ny3uOoJJjWfqgqS8cdliD50bxFzCIn/YDVbv2eTFBrMJ9Ikmti6qdqydxLXM1+oc
	 +svURG8bQ/Hjvpn2RmlMCeA9C4Q4DaPNvppsz9oC+Ao5eq2uejPZ6qbMo4SC/hhN+i3qb
	 3wtPir2TBxB/nnpsWbjYh0vBAF7hp/JOMblHZSIv/yOB7i2NhKGxhaDqCu+rl68vTdHfE
	 xtrZfExJ1u1mUZCAPOOY2Py+Jdux+nNUdOB/i28dzu724ylHwmwOoWR6Zd5NbGJG2VdeI
	 ACbHLMVMzErT3ZyMkiICIbtIr3StdoHtSwknBK859sPNh2E20Qh1b21ai7DJeigcctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864768;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=ekv8nZV2KRWXLq55UMkFX2h8AsIUilC5jxcfXsbLa8w=;
	b=d6ePkq/LL4FOcT4rwM1Y3FdogB59LnBELnwQcQpyOijAaaSCbM4G7YG9GvkD9blLwAST
	 n+GxlAGmInYU1ThUuproUTkXMU9JSR7YjpgDB+Qek+GaEh+r0efQxS421ckFMV/wYQJAU
	 Hjk56UUyahJZtK9z00JimjPpe7wtC9Py4Xq1xPxLa8oGMCAWW2XMOtKI081p303PQ2Cfv
	 vuITjGRtDCoSvDVzDVaEbS6KaxT8OkDa/ljlKpC8vYOvnt3hR2e8hwoNyCOWxXtQCzUDw
	 FOwSGevrUOUVtSHOq5cC7FBlwFJkrq/3RSrUEM4mIcE6OWG75OEf+4RB0OI9kNNRXHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C4606A31B;
	Thu,  5 Nov 2026 07:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71C4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2517868B05; Thu,  5 Nov 2026 08:45:55 +0100 (CET)
Date: Thu, 5 Nov 2026 08:45:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <20261105074554.GA17781@lst.de>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop> <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
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
In-Reply-To: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> Given Qiliang's response:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks.  I assume you're fine if we carry this in the nvme tree?

