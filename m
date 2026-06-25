Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065583D6CDD;
	Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384140; cv=none; b=no0U9SFPFJ/2qN7X0UFp5NAtsbqpyGlBEHXWi9518z67QaZ01xuuTTlwGvrz74YHU+nGb7YQOANBr6AeznykSjIlN7msSkCcqxI4UhDO/2nhT6TIxTghu12KRjTotyOjJhRCpduLYoMSsVPXGzr6CCIM0J5AECkJgOAMdnFpv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384140; c=relaxed/simple;
	bh=ZR+GjtvoecijEwle9P5G2tsWGiYXO5hOiJ2OdmIXkAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw59OEV9BJPHR81Bpj4KHiGo4h97821dc0kfseltjp/ljADMiIUqpfK8CSi0eGFOZptfjkDBFPTX1GABqvmbTf28Xj/1kmSDzGd819P65+xGWXwJWKIR+ik+SvyDrieALnbPLRYuL9yxjSKZ5DcPDEA//qHi2K5FNEKwZ5LyXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1//s2ej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1//s2ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD81F000E9;
	Thu, 25 Jun 2026 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384138;
	bh=5YwpA7XGSLdzMcQ+7rmuij24ME/LFoEBRrd3cnJs/9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o1//s2ej90chSy1MgNMUcb5IjtctWLJ3jD/0lBj+E5XaAQkCqBmM5YXRWUjYs/9nO
	 Q2I26+0rJIIwFbyGO4kOLSRIiw84zbSWitIjMsGyQl3+PshFe+nvOyFtdXRq9MA95J
	 H/m77yMASDKn8ocFcS9jTuoa/K2ur7DIwHxKSJx0mTBlpkMgqvLPNpXALxQWr4UR4M
	 2oVFehqpUgfA0XfdcXMeLBs28hNjiewNBuj6p06opaOqUNhLmkZ5umwG0ihgkl0ZPu
	 eiB3Ic1/DY47/dc90BknhKbv1deQp5a6yKpTUVjbga4+KVBprnA14pc3OzgfJaFkHQ
	 Mv2o0phNuHK8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bjoern Doebel <doebel@amazon.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:58 -0400
Message-ID: <20260625054005.0014.ringbuf-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122351.2477592-1-doebel@amazon.de>
References: <20260624122351.2477592-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

I had to drop this one for 5.15. The upstream guard(raw_spinlock_irqsave)
conversion in ring_buffer_read_start() introduces a new
-Wdeclaration-after-statement warning on 5.15 (the guard variable ends up after
a statement), which the build flags as an
error there.

Could you respin a warning-free version for 5.15 (and 5.10, which has the same
problem)? E.g. hoisting the declaration or keeping the explicit
raw_spin_lock/unlock instead of guard() on these older trees.  6.6 and 6.1 are
already queued.

--
Thanks,
Sasha
