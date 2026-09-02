Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2341D4F3;
	Wed,  2 Sep 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387272; cv=none; b=pWGb0tKzyIc5HZrEhNONKWftJPcbEeVXWYBaZxk+8blgf0YeNCrYidK0+k0zy90kiBlLqvktnt/SDplM9dFh9/qqoPIsIHzgdBTrXPFdhDMoe2LAp/gFK8donw8m7EfO504twnJS0+5zsovO1C6QCcAS8cX8g49fPLBTjB53tTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387272; c=relaxed/simple;
	bh=mEGxaygLEVF+0pFwWFu7necal/VkHZ96PXEvCXDTTBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMjQiCJp1KFuXxarakiPPDbQgaPkI9HJMyuBvEmZ7W5hNf/iE2dG7tlrKPQbKRUwNHt6OaljXSLSSOjZCCbtp8V4yHto/NPw6HRk5lZHMQgYUEOBOWBT0SekIqt+yQf2ZsRu/D9zePHsrDoe+DAAuAfq/On68bqBvIHbhVEJG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyeb32ql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyeb32ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEE91F00A3D;
	Wed,  2 Sep 2026 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387267;
	bh=ZmMoe4LxxlhmDnwmcXUyGO7LsP2v+nJ/KvbYpZVDDHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hyeb32ql4z4cMIWCfHXpyttOam8g/A41304yT9nZEr4o+YskmGJDIfJraoBt8PhNG
	 8yA+go3YboVx9vIdY9ye7R+gj+fHnPecBGTOqxcupFhF3GPiYMzH4cN1YlhiU6l6JB
	 +UVpFaM3NCFPtRbED+gWn3LWfRn57AMHAbvHyjUM61dwYQ6QjziaqOs17qULfhB+91
	 ZEDbJxPn2oIOL5q+5xgDuIFYylT/g8YR1BLzUwT57HsyODwVu8FHRQng8h6oTL+FGj
	 r1bN7V+4UfO4IutiMXZgLqaEHpgDB+N3It8j5AnDVkYpNiquIqSa5XFrc/8jwJwSrR
	 /EEM1B+1JxM9Q==
From: Sasha Levin <sashal@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races with trace_pipe_raw readers
Date: Wed,  2 Sep 2026 18:14:05 -0400
Message-ID: <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901123444.GA1350131@google.com>
References: <20260901123444.GA1350131@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> uninitialized memory to userspace due to stale size values.
>
> Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>
> Not sure if this is the latest version or not?
>
> I see review comments, but no v6.  Anyway, no matter, it'll do.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
