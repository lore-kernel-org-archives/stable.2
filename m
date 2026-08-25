Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407936308A;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635293; cv=none; b=NrZYWTdrHtONU5mS925BLWcuThBTsOaFirGDFQEl4e19PHiYLTcMd/mPsIzIUNKhyeX5XVtFo7vlvCVVQUdoTk/zD/VXLSE6dpsHW+D5y1emaF0IA/FgIX7Ag/QpAuK7euBXM7G5M0aKFfVeKnMblVVv8HqsUtRGiKAO/09j7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635293; c=relaxed/simple;
	bh=6Y1XbZWfQiu+oywBa1EwFn9wtGU0Z1a2BMaPr+MkY/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oen7WB8B0NLxKvnoHCxHMPY7b2AoUS3znFwReQaIijK5YGSlFiOI/Ed+cCSCJ5dm8BA/taNzvWAZ7b/VPn+TahQ5H/p+66Fb25XL22MfHwuCKqia5rkOAZqNap4rauC9PJJsJQ7aqNFOa034+4ATkS6lfzQfTWKisPsiOtURKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shmbcStw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shmbcStw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 464F8C2BCFB;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787635293;
	bh=6Y1XbZWfQiu+oywBa1EwFn9wtGU0Z1a2BMaPr+MkY/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=shmbcStwdzlHkU1pz/DI2vV39TmrISx9lmIQrhIfUmUx/y/qLodk9wiYX96kxKGvB
	 nobQLcSIyb7/KOr1JSD4u6K60xTmg43z+/6OgwF+4MW63MHdWfZ03l1WezOG/qiHy3
	 xVgWRTfMzHT2BvfEm7+/NE/AoPqxvkAimXBV1m4fxifvVV1do9PikYOBWRi84YiwgH
	 E9eulQP0H5nywd9RMIvmN5ysSli0to8x5fmkQ7hjUDs0WmjXTxLO4b7mddN8mV/vvU
	 tAwEzu7EagndrRIn0lJ40Rk0PNGsZJuvvzgmNuJAdkWFwbl11Eh90rYRP0Z6ETxUBE
	 VuYprDepuR04g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A853C61DB6;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
From: Ivan Immanuel Shaji via B4 Relay <devnull+ivanimmanuel1234.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 01:20:38 -0400
Subject: [PATCH 2/2] ring-buffer: Stop remote reader update when page swap
 fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-kernel-patch-1-v1-2-e9349aa0b165@gmail.com>
References: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
In-Reply-To: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787635292; l=1498;
 i=ivanimmanuel1234@gmail.com; s=20260825; h=from:subject:message-id;
 bh=Yt3jJEKjDX8/on3DO9yN+/vqaXIqohP/+YVJCaaE2TA=;
 b=KmTfJ3GvG/u3YrBfBZAyX5nOKK+yVn9H2LRQsIdURBZL6eyXNJKeUDzGR4U1N8WGLf9D7C5OU
 bnWoYbWgI93DAs3LZpK+WUo1uq3qAEUUgZNrxB3zqY9axeBmdR+8JnZ
X-Developer-Key: i=ivanimmanuel1234@gmail.com; a=ed25519;
 pk=Wx8O3UUs3XneDkbqbOJJnlNdWSpEf2tWbTAoE7/vnqE=
X-Endpoint-Received: by B4 Relay for ivanimmanuel1234@gmail.com/20260825
 with auth_id=975
X-Original-From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Reply-To: ivanimmanuel1234@gmail.com

From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>

The remote swap_reader_page callback can fail when the writer moves the
head before the remote catches it. __rb_get_reader_page_from_remote()
warns about that failure but continues with the unchanged reader ID and
rearranges the local page list as though the swap succeeded.

Stop immediately after warning. Callers already handle a NULL reader
page as a failed attempt, and this avoids splicing the same page as both
the previous and new reader.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3c3ed639923d..d11b2759caac 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5805,8 +5805,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	prev_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
-	WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
-							  cpu_buffer->remote->priv));
+	if (WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
+							      cpu_buffer->remote->priv)))
+		return NULL;
 	/* nr_pages doesn't include the reader page */
 	if (WARN_ON_ONCE(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_pages))
 		return NULL;

-- 
2.53.0


