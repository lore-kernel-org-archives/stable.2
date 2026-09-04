Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C662D46A1;
	Fri,  4 Sep 2026 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490393; cv=none; b=ujPbowDBmtEIFzBX1RajE/E7aiGoOfeG+cXUqMdvzH3SrzKHn1SwYaZqvB/6N9qyCjzKRA9ngS8/S7pW2RNhVSkPVFVENf+Ouywdt7of+Up1V2HAPsAeG2OBIftrNCLwnV5S1tKn44SQVj3nYQYHxxhYRhDfy1mZz/uSFTbxXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490393; c=relaxed/simple;
	bh=bkda4h23uG9MvDB9vbvgx5P8/fYNKmRlNqlHo4QvAww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjWD4wAUT5GfAlHydlKqim1iwEb5fd0H6A/uAFI3Q65x+kHAw6ZsGFVerJUkdU2cfXbatPS+rD4QYVOoHXQbse7NdHmVSSd+e9vESWnJocb/TOxLLiaylZpffu4pWxwSAXaGtDaxAnunTBBDfCwIzk6Vnl+w5E0eikUwy5SS7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWzGf8AQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWzGf8AQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AE91F000E9;
	Fri,  4 Sep 2026 02:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490392;
	bh=V2bOSqTcsB33iG8X4qc6MzBz87ElH9pinmHUjB4BUq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWzGf8AQX76TkoTbMQgJLfpEf9JXsmy9Vrw9vVquEisuJgfjbcBPmfm/16rhGx1eI
	 yvKGALIv176SG2FZRqrS2PTj6kvRMywcVVvMhp2StB7W9DFbmcWIl5s4z/iBtOgylU
	 gs2/NadD2bdG1tpSawT6zjsAB6sHALdBMH/i8xupci/kfBY7nEBxwssLChUxLvrTLl
	 98kwB76rBbVx3ms0wnrckUwyph2K8Uzm1pTU2DLWy6RBNTU8bIetbuHBZDc5WspZrQ
	 q74PS5Kb8icaISHxTa0eVaW4dO2DeB7gRMkTEA8JiEcY2+/j3YMC7ymgR0MP9Ph4++
	 Z09sTBMTal2jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Karol Herbst <karolherbst@gmail.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5.10] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Thu,  3 Sep 2026 22:52:50 -0400
Message-ID: <20260903-daily-reply-0001-re-mmiotrace-null-check-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902122830.447370-1-alexevgmart@gmail.com>
References: <20260902122830.447370-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by adding an explicit NULL check for tr at the beginning of
> __trace_mmiotrace_rw() and __trace_mmiotrace_map().

The callers mmio_trace_rw() and mmio_trace_mapping() still dereference
tr->array_buffer.data via per_cpu_ptr() before reaching the functions this
patch guards, so the new checks never run for the NULL case they target.
Mainline is only safe because of the later commit 6936298393d8
("tracing/mmiotrace: Remove reference to unused per CPU data pointer").

-- 
Thanks,
Sasha
