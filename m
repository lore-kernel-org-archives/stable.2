Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28164483A5;
	Wed,  2 Sep 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351652; cv=none; b=hMNEBY0pFucFRhvKYkUgIN58UgKgCSXpKtacsCfukrYY6+ToehNcF0njpGiPqAsNXv7Mi1StL8eFuwEwm7580hCf8W9TLSliA+0Ya6+urLXJwLschuQE1RttX5n5ikT/g5F3BlgQ4YeENbjbXFRO73wSCI6PLK+yKuSb2C4eeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351652; c=relaxed/simple;
	bh=cJIMZ4lZIbD8w4mwUj2Dxv/6sHT2lej/BxCAJWfTtKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv3yAwAX7OilwMNWqEnm2+JOTBM1R7iDYECkBfovcTnePoRIydlvETZ9TXMXThuTZBrArpFWKfVrf6ev9r2GMTSJPkPSSwxwrgzZS/GmdFFFJiM3p4kG+yg18EpYlQHZybMJylLvQ/eSZ2l6JeFNftk3Y4EopyPSUOaBU9djluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Qf1jAk2Z; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Qf1jAk2Z"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E0AE0401D6;
	Wed,  2 Sep 2026 12:20:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id BE38C20011;
	Wed,  2 Sep 2026 12:20:40 +0000 (UTC)
Date: Wed, 2 Sep 2026 08:21:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Jones <lee@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, stable@vger.kernel.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902082141.00583dfc@gandalf.local.home>
In-Reply-To: <20260902115944.GS2943942@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-7-vdonnefort@google.com>
	<20260901123444.GA1350131@google.com>
	<20260901094656.487b278f@gandalf.local.home>
	<20260902082717.GM2943942@google.com>
	<2026090230-entryway-acquaint-d12e@gregkh>
	<20260902095744.GN2943942@google.com>
	<2026090221-riverbank-overlay-704c@gregkh>
	<20260902115944.GS2943942@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BE38C20011
X-Stat-Signature: sf5zfn987a5yuqxbzhd3bnsa6hjip5d9
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199xGKghEwveVcu1SvrIkrs0YGjBe3AmIw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=IbwYWfnjtyQ3yaplhR9ngk/1xzHrX/b1X3pp6UqlWkY=; b=Qf1jAk2ZkVgDw0Zi5UZvHlfxpfh/uAPypeXyQ+IW8b4zcouuDLL5AIYD0M9cYFG3P9jaMUWuxdg78uW2buMXBFx6vW7EHbOqFVbISFwjiXTvk/EHXRKC/osSFfA4CCgMobowM3SMgfC6VcYzHrulfVLc+AdOs4z5f1vu6du16Wo=
X-HE-Tag: 1788351640-24232
X-HE-Meta: U2FsdGVkX1/njyGzDkbZzb+OYMEWiaWLgEfd2Q7a/xlNs1AzgjZVgaNpuwcx7UTjqGzHNAsVFw91hqQPp9rUNWrmpBzXRd5kPyrhoyClsS2rsUumS1XQxyTuEVmktAV9uPIOh31Xa7W5VSLZe8vGm57Lf/jgHiLRDwpuDa4k664NSI2p7Hnb7zNkEw8gmqghw2opvlp1qv7MaLcJVS2EGaha0RzcuG4wQIHzO8kDhlE6TLYJZom9HOCDQ906AK6A0w7DxqiQLOrVA2VfbHDiQqtxiUFOPsxxn0tOrbRBhUPx+WqvF1+iEqSC6Pid3urLPlDarKhD4T8gxFg7ZZyVT/x6d9jF2Pe6

On Wed, 2 Sep 2026 12:59:44 +0100
Lee Jones <lee@kernel.org> wrote:

> > I'm lost, I was referring to the above git id that was asked about,
> > sorry.  
> 
> Ah, so Steven must have added it to the commit on application.

Right. As the maintainer, I decide what should be marked as stable or not.
I never require a patch submitter to add it. I'll add it if I feel it
should be backported.

There's even been times that I *removed* a Cc to stable because I did not
think it was worth the backport. Of course, I still keep the Fixes tag,
which means it will likely be backported anyway. But that's up to the
stable maintainers to decide ;-)

-- Steve
