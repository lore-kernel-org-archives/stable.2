Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BA37A844;
	Tue,  7 Jul 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446083; cv=none; b=k3e0SR2FTYuR7Hv0j+xYDmzazdQCKv7wJ7LYu6sMhlawle2gwqbafehn69RLReqbi4uKbVjCKDp6ABardeY6VhD5puOWCuafFugeORWug8hjPBmPCTWgSgcKWe8BWsaEfQ8IgKKVmw4jyyLFelM2WsXYV7MnSukipyDW1uzYKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446083; c=relaxed/simple;
	bh=1hu2GddcExnoQMdRvB0QkLDfHECk1XQK3Hp1zC0Goa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+TQL19kFdoa/IkY8HnlbOsu7lDZfjF/NLw4SEcUkVG7cqQFKBBQBLPg+MmuyX7OHfzUu9qhScZ7U2Sf4PfF1fBclztQglfJSYNCy9NL4E6xRPcXncjySsOfwiRQTg8E5HccOPrDTJy2024OtPDGMbz+EBD0QErduivyAU5wQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2B58C4051A;
	Tue,  7 Jul 2026 17:41:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 271DC40;
	Tue,  7 Jul 2026 17:41:16 +0000 (UTC)
Date: Tue, 7 Jul 2026 13:41:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/user_events: wait for deferred event
 teardown after unregister
Message-ID: <20260707134119.6a014a88@gandalf.local.home>
In-Reply-To: <20260707165912.2560537-3-michael.bommarito@gmail.com>
References: <20260707165912.2560537-1-michael.bommarito@gmail.com>
	<20260707165912.2560537-3-michael.bommarito@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5b15rfkr1m8maiciouumtki5xkktqoxe
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 271DC40
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+JSL9ND3W6PTPGmriTdVZk3n4HK7ntelo=
X-HE-Tag: 1783446076-28099
X-HE-Meta: U2FsdGVkX192nl4t6NFxv+peeCTGy7UzM20JdGRdJ+OtpVBI6Dus+n+eKO25D/dHsIec5Tl3e7nEYM4VHzLcmPYLPDhFQEQZQO4n4rXsynDsuoMDG4kB1b7wrd18W9LgKqQBLmKmSRtiRSbVPfuDAdIdK3zKxcB/JfrX/LgXRePbZ4YucXcZoaYJnkmOQTjD0diQb7SoVKN3Cp0x0oWjDL4wMKgtZ1CjlSmy4VkI25nGW2iLTJWTXssJRcqDb31dTG7376LTPiZSXpllzjbmzZwhPxto4zV1REzLkyWKOAbr5kfYusQaNA9D/ne1pAyhXfvbdHLTc/gO4/bkOIpBbNzOQaRLs5w86LtJ5VN636IbfeIfX1i/glRWf2yZ0KCtKbkEobZam69oH7JCQP6C7Q==

On Tue,  7 Jul 2026 12:59:12 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

>  
> +/*
> + * Deleting an event drops its last reference, but an unregister may defer
> + * that put (and the freeing of the associated enabler) past an RCU grace
> + * period. The delete can therefore transiently fail with -EBUSY while the
> + * previous reference is still being dropped. Retry for up to ~10 seconds.
> + */
> +static int wait_for_event_delete(void)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < 10000; ++i) {
> +		ret = event_delete();
> +
> +		if (ret == 0)
> +			return 0;
> +
> +		usleep(1000);
> +	}
> +
> +	return ret;
> +}
> +

Care to address Sashiko's comment: https://sashiko.dev/#/patchset/20260707165912.2560537-2-michael.bommarito%40gmail.com

I'll pull in patch 1 and start testing it as this one is just the tools
change, it doesn't need my testing (my tests only tests kernel changes)

-- Steve
