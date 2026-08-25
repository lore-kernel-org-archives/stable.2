Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52D38B7D4;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635293; cv=none; b=s42cyuhilsoZDz8qSWKjMt5CeikKPAI8dnGSlkRnI92SfNoeQeJ7gNoLaCUbk52Xy+kr7KNEbgVuc1ZiygtFG5ED7ziJ+O8W9CLaG0dYlLOqlX0ltttlV4W0Rsfgq1OF8G5SVbfp3516c0QXdWLahM1V/CxG9oiyADVEPEQW7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635293; c=relaxed/simple;
	bh=x74r0oqsaq9tYSELP0l1x9/SUc0crA2uxMOnhcHAnpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=biq+PQ3S3i4RVh8oFwGeleGfJulbGHCdQBfjJXlQ8jtHrGZJR21jg24Q4lHMU7Of4oAfAWUta6hShIrNqgAoRJBvRgJKCy8XO3hbhVFfuOSEynkSafOY5x/+kk9cPZImuaB3j1VdqvlRK40LhdC+IFNqGL6dCsaQuO7SKZaCVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtQ6WjJ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtQ6WjJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EE4EC2BCB8;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787635293;
	bh=x74r0oqsaq9tYSELP0l1x9/SUc0crA2uxMOnhcHAnpA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rtQ6WjJ8jx9oM1ZY1uPYNfVnfh8bzl6NAYepIun0iheRKDvQHcKzT7L8xvtX53se8
	 86Zm1uaTQtvn7YwelAnxI//45j9ShVVFsNKq2A3/dYeHKQxfPe+hflPOntxJkcRNYC
	 ZnX9d7lOJqC0FFfrltJyh6CfXEdjdRHejMVqgzHLOMNS3MjrzPjcJAW3nsSxk7/HzV
	 re+fENhpvslO6M+ajp/wb0oAFJsheuTLYviYtJ/9HTeXVBqLg4HsOk7FVuybkInIHE
	 3OkoWJwayJiJuOZ/1JM4nULIZFkxwKPx55plzL4DqQ4e9J8kfoRouJdY3t6qkG8wf4
	 DRZy9I8jFsbiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA0C5DF9C;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
From: Ivan Immanuel Shaji via B4 Relay <devnull+ivanimmanuel1234.gmail.com@kernel.org>
Subject: [PATCH 0/2] tracing: Fix remote reader page swap failures
Date: Tue, 25 Aug 2026 01:20:36 -0400
Message-Id: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avErBtQI4muEi0k/2ooLDQikO6et
 PwW72VKiIJEfZUp4pYkRyjQdUXT6sICFl9MRhmrOtPyhhiw8+muaWXNvlMWjYfSrqUSnRGzPP9
 wGN/3AxXYl1VgAAAA
X-Change-ID: 20260825-kernel-patch-1-d806e3de01a5
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787635292; l=1366;
 i=ivanimmanuel1234@gmail.com; s=20260825; h=from:subject:message-id;
 bh=x74r0oqsaq9tYSELP0l1x9/SUc0crA2uxMOnhcHAnpA=;
 b=ObxVAA6UI2ihrhJIU4/e9qvfLbnlcNFTBkhdrffzuyuU9mZ1EYkMCnplYc4UGI0p/FmqxQ8Rd
 jHQhX13kHVSDZda8WvuCSamRddJzrRXoxqKqSKhZRjixHXrI/RyE5yT
X-Developer-Key: i=ivanimmanuel1234@gmail.com; a=ed25519;
 pk=Wx8O3UUs3XneDkbqbOJJnlNdWSpEf2tWbTAoE7/vnqE=
X-Endpoint-Received: by B4 Relay for ivanimmanuel1234@gmail.com/20260825
 with auth_id=975
X-Original-From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Reply-To: ivanimmanuel1234@gmail.com

The simple ring buffer's reader-page swap retry loop mishandles its last
attempt. A success at that point is reported as an error, while a failure
is allowed to continue into the pointer updates. The remote ring buffer
consumer compounds callback failures by warning and continuing with stale
reader metadata.

Fix the retry result in the provider, then stop the remote consumer before
it mutates its local page list when the swap fails.

These paths are used by remote tracing, including arm64 nVHE EL2 tracing
and CONFIG_TRACE_REMOTE_TEST.

Testing:

  make C=2 W=1 kernel/trace/simple_ring_buffer.o kernel/trace/ring_buffer.o
  scripts/checkpatch.pl --no-tree (each formatted patch)

No runtime reproducer was run. The two final-attempt outcomes follow from
the retry counter's post-decrement semantics. An arm64 cross-compiler was
not available.

---
Ivan Immanuel Shaji (2):
      tracing: Fix retry exhaustion in simple ring buffer reader swap
      ring-buffer: Stop remote reader update when page swap fails

 kernel/trace/ring_buffer.c        | 5 +++--
 kernel/trace/simple_ring_buffer.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260825-kernel-patch-1-d806e3de01a5

Best regards,
-- 
Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>


