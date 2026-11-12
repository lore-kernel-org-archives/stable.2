Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494467;
	b=H8SzMlobpeAdPsweV2KDXiJPKfQ3+UnG8TVbpZqvmaqyFvY/iJPhjkx5HAMH7Y2J/aOf
	 2uXaINIG8ezi4SD82IF0gpUEHmWAHz7U/N4nq5Oca8It3Cp7SxEL4nftE0/lHdz4xriqh
	 JgYnA6MVhGzmOk7szsflUX8exYTonnG1OdgM+nqwUX+dfINnZmvkGAyWTh8RQeUzH70Th
	 RdK96VZGvb6j3FLCuDzjmrzAMdv05zIuFHzpBGPnaVDDXxFuiqAR52peeaI3FfMdZ7OX7
	 EJRfD1USdqYRSo0jRWcigQB6quIIGcnbyvm8HGOQwfKIP48h143f7uZ3tRb58JYE85Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494467;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=F6bxHc314f0pSGilfckKFkymUMzhIgGl/FSU7UjQCE0=;
	b=UUU9Jx3rqRiIy8BaLpnrMXJtS1jTX5OeCjAoTY2HSvlvn6x0Gx4JFzs4H7SWlQrCEjqW
	 PHsV/cw5dI+0cWcyzfxnutpA0Pwe2PFwKZitHH1heKScQt3hfmYyEiH/246mZUOSUAams
	 TpH+KZlXcvuLp+jOe9KGTDCZxZ4hlcKrRRl7VVF/JVjztmlE8+Xm1wxH8WHk3+ZJK/Iem
	 l3huzsvfCd5ebdKw9OiYXsphaywbX4a0JZjvWsskZLw9wtxPPoX1A6yMTFqsw6pctWjP7
	 G5Mj/ny04Hp0OGAPcXouWhlgYFc/6PyCpTUOuf8sqgef0tLZhzuYdamMU8/qgsmBygw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=7Lle77wt;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D1606A31C;
	Thu, 12 Nov 2026 14:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=7Lle77wt
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 61E59A0600;
	Thu, 12 Nov 2026 14:41:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 7486120029;
	Thu, 12 Nov 2026 14:41:00 +0000 (UTC)
Date: Thu, 12 Nov 2026 09:40:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] lib/smp_processor_id: Don't warn if there is only one
 CPU
Message-ID: <20261112094059.18f66c2a@fedora>
In-Reply-To: <20261112081348.GB2668804@noisy.programming.kicks-ass.net>
References: <20261111092421.3771992-1-chenhuacai@loongson.cn>
	<20261111170600.GS1779021@noisy.programming.kicks-ass.net>
	<CAAhV-H6SYOjOw+owmStK7sr-HOiADC1zZ4Cii5hv1q+qYAUETg@mail.gmail.com>
	<20261112081348.GB2668804@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 7486120029
X-Stat-Signature: 88gmwgz3u55kexww8qi7suchqxacz5w8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX185GOKywlFFlJfCTu3GxCWoVw39LGNYJ3Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=F6bxHc314f0pSGilfckKFkymUMzhIgGl/FSU7UjQCE0=; b=7Lle77wtMD9XB5uNMnPNfCLzHiiosc8uuejeHnPqjrF+I3kqvpWIKnLekAFD0uOo4csitFNoA9P3BBVVhYArdSCu8BPjBe9hCHCOh8+8WKRVtNY/Fn7QR5+FOVRBvJPCXJDMmGy6sb741H+WW3LnywUXpxfvfezikBKoQm6VhFI=
X-HE-Tag: 1794494460-530483
X-HE-Meta: U2FsdGVkX19IKkfz9o5zVeyJW6LTZJfRx+zf0zFmoWrkA+CgZhlvPgDsEFUw8vC7dAGijfephlT3VbMn5qaLhVg3SaSPTtDte1bPrQzltXp/DXqNqcCeFXOLxGJNeo/fuZkm7ewWABHZvDxRM2nK0a8TNxWLaIxzotl5EC5ebEuwrpxeMx4ip4kiJLG+2wh19POc+bU9wU9LKF2euAM6BwDS52MpDr7yT7RfshrYPSnVgfps2TXYEEhk6zTX8Y5IbWvf2J2Bx/nRl/BkKjB0bYBmoiykDJbr98+C0/wwgtahHGMXkX/vevsSXceWJHlAsGXf7c5hGoG1nzdfHMrX2eIv9JTurj0SeQVWoK/TmZhVe45cIP1UlszO/vVYxDUd

On Thu, 12 Nov 2026 09:13:48 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> num_possible_cpus() is what I was thinking of. Notably, there is no
> requirement that the CPU bitmap is dense. You can have nr_cpu_ids at 256
> and use 255 for your boot CPU. It would be completely daft to do so, but
> it is still valid.

Hmm, I was under the impression that there would always be a CPU 0.

Is it possible to boot with a non zero CPU setup?

-- Steve
