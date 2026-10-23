Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793350;
	b=Z1M4W/6IuWXukOKfbqg+MT+XDjeMlN/tO3pq2KDubwVQ61QbnEd+8mVSDEbE7pzo4oXd
	 GtKVuXByiuhZgHQc4l5x1mu6n7MSQ/kFZGa0wlT4tT4gEc2AVzq8sRzAJlfcwBncu8vhA
	 ibSp1b6LWaLOkHxESij5Bxr3ATvO/D++47hJAV4GtcD+d1Mn4sSuLeaqWBU6YRv4sma5H
	 GH+ntw776ypDyp0VEZdp8mcGugTEA0GkUeMgXrjYtEL+ENR7+kpTZGRL8O6J96sx9InXA
	 7L15PGYMTc26aSUdbIsgLm5NLCfA14ap+t+XdkCYRTzeEfJMDj7JUVrh0ZHXivrXyPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793350;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=F/szoS2mK5zh+IKcX8gQnqvf+pfueUDCbGAQFHFPWOA=;
	b=XKzh78/b8N/iSpHw2RATJ76NQCgWOGoM2BCLIKa1PRMT4EQwS4OYhEj0LnWWxxJftHz3
	 bDk8CEF3nkyXMONWTOBktV7r6ugH6fEPne5uh83XAmwZGkYnXuWc2cQbxeccmhR1qQoYW
	 ullCLbHpcdptWdPbTLUuE/lQEYOITTeiDfCIMJkTAA8TNusBuxiulNl8SphDMsjnkfqUn
	 MjFUfrAl4DTNTKe2zGnpb1c6yv+rojwsvWRBTfz0iTGcn5WvTZJnaZm1blvHFkTMXvF4Y
	 WCt+WmFQ39UsF+TC1w0dDtS4fu4gRN08vcdWoWRkkQ/G2RShC3X9Iy4L/3U0dkPPWUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=jsMojqdA;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1420606A31A;
	Fri, 23 Oct 2026 22:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1420606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=jsMojqdA
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A760D14028B;
	Fri, 23 Oct 2026 22:09:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 1E1806000C;
	Fri, 23 Oct 2026 22:09:04 +0000 (UTC)
Date: Fri, 23 Oct 2026 18:09:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Message-ID: <20261023180902.2bf7cef4@gandalf.local.home>
In-Reply-To: <75b66acc-354e-4cd2-b9cb-4c22e8a02635@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
	<20261021174406.2891598-2-vineet.gupta@linux.dev>
	<CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
	<20261023143816.48163575@gandalf.local.home>
	<75b66acc-354e-4cd2-b9cb-4c22e8a02635@linux.dev>
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
X-Stat-Signature: t8c4c1oeinfubypt9y96ounpn1cq8i6r
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1E1806000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18c7xFN/AyP36lmveAraBHyJYFfDlwqjks=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=F/szoS2mK5zh+IKcX8gQnqvf+pfueUDCbGAQFHFPWOA=; b=jsMojqdAIncuOJPK06fYzxnkXNJ9VAWIExLNmei7vHl1OKcMjHbJfZhtVrX5inu4UllXDRHLpxMXwSgbh9dbZx1DnV/Vo/yptzPfWGI3kUD9qfqKIITP/abxiiGkuKZ4c5GorYNuD197JSiUqczf39nCDATrpqXvfiSzoF55z2E=
X-HE-Tag: 1792793344-780753
X-HE-Meta: U2FsdGVkX18r58hygf06VDzyjSvq05C8+pMawJrbnCrbRcfIifeJ8azbJMqg7kb4Nls+RwctJyFyFMZm/QQ6RqvMvmiVdNiMkj3oQNli3QZSBEjGkq7yUxk+zu3D/RgH3j3ScIjh0TZ2WyMtjgjaxNHCDgaooLArLg6LKwHIXOyR/pkdgutn7aZ3R+ftIP3WOM/lIuPFrWeF7T1q753SR6/jn9GKLVh6pY9Bi/nabZY9P8IfQAJQOWhtAtPQXDFSh4b3Ge6dWELYLQ4iqJYAXfPS47oh5o7gRwyiOhxRngIxH5TH1rEBxF46tXi0vwD5Db78Hy6TThwXeUG6HngxhRU+8GSyB7YUaqz69NwcXN0QJm/LVf/Mcg==

On Fri, 23 Oct 2026 13:13:41 -0700
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> On 10/23/26 11:38 AM, Steven Rostedt wrote:
> > On Fri, 23 Oct 2026 11:13:44 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >  
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >>
> >> I presume this will go through Masami and Steven's tree, is that right?  
> > Yes, but it came in during the merge window, and since it's just a speed up
> > and not fixing something that's broken, I was going to let this go in the
> > next merge window. I rather have a change like this sit through a full -rc
> > release.  
> 
> It is a speed up but not for optimization sake but to cure rcu stalls in 
> production at Meta. IMHO it should go in sooner than wait a full release 
> cycle.
> 

Either way, I'd like to give it a bit more testing first. That is, the
earliest it will go is after -rc1.

-- Steve
