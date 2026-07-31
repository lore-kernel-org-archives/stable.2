Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759235B636
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487401; cv=none; b=IJ619NuRIOEQcBYPmv5X3MYFhAYAdD/RXYOMy2lYtO9lFruISvfVdW3ZPc8FoWIJOr3KOWFw4e4Z/snJjVHpnIey5K68Ujs+BZYKSGqQyxb8KN4k9dWVgyTgl82FEqmoe8Tk8NB19hwbgSy3t0fl/wHP/zlbeDA+aBRJjhFF6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487401; c=relaxed/simple;
	bh=j2SjsKR12g2/eBbTkDmKpAIozQiKr2CRlxunr3mLRqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLSEEUAsTGWZ6SuTSJf0IfMWr0ang4DR6saFXOMSeH/YpvBl5EAOi2V7lB3rLCyIjIg00sNCIl8M6u23XjoxU3p5/sF2qdkJx2y4ox7OXLS403pkzE8BavtTHdqlKc+oOoVZreLu0Q97D5ZdZGQZoWw32bWVRLDQuvwQfan21RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mpin8YGH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mpin8YGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785487398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQglzxkkmdxU07t5W1fs1kSnAyCyTXHTL6VYsYOcl9s=;
	b=Mpin8YGHg52okFntthsLb8URO7QRMX0BoNUwp3JVZmNsWENmGWu5BQNYzbgrbyWVoW61Ui
	f1Eog7lKlbjn6Ke+g4hY5PBLIeJlitnz5XhhsAii0z+L81jBcl15/GpQp9dze1CWrWiy6G
	ZOYGi3u7OakptuoSMYnjWOty5B2ATW4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-XyIQaXvYO3eIdU7voCsnIw-1; Fri,
 31 Jul 2026 04:43:14 -0400
X-MC-Unique: XyIQaXvYO3eIdU7voCsnIw-1
X-Mimecast-MFC-AGG-ID: XyIQaXvYO3eIdU7voCsnIw_1785487391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6274E19560AA;
	Fri, 31 Jul 2026 08:43:11 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1C1CD1956089;
	Fri, 31 Jul 2026 08:43:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Jul 2026 10:43:11 +0200 (CEST)
Date: Fri, 31 Jul 2026 10:43:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
Message-ID: <amxgF3S7jfmjHvPv@redhat.com>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
 <amokG13tEnA7VVVf@redhat.com>
 <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
 <20260730085421.d455361164695270bd764a4b@kernel.org>
 <20260730103824.GD751831@noisy.programming.kicks-ass.net>
 <20260731095652.fc5d64f8c122d7dc6ddd89be@kernel.org>
 <20260731083039.GD776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731083039.GD776954@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/31, Peter Zijlstra wrote:
>
> On Fri, Jul 31, 2026 at 09:56:52AM +0900, Masami Hiramatsu wrote:
> > On Thu, 30 Jul 2026 12:38:24 +0200
> >
> > Either way works. Can we update MAINTAINERS file if you will maintain
> > uprobe in tip tree?
>
> Well it is in kernel/events/ which MAINTAINERS should already assign to
> me, no?

Confused... you are already listed as a maintainer. From MAINTAINERS:

	UPROBES
	M:	Masami Hiramatsu <mhiramat@kernel.org>
	M:	Oleg Nesterov <oleg@redhat.com>
	M:	Peter Zijlstra <peterz@infradead.org>
	L:	linux-kernel@vger.kernel.org
	L:	linux-trace-kernel@vger.kernel.org
	S:	Maintained
	F:	arch/*/include/asm/uprobes.h
	F:	arch/*/kernel/probes/uprobes.c
	F:	arch/*/kernel/uprobes.c
	F:	include/linux/uprobes.h
	F:	kernel/events/uprobes.c

Oleg.

