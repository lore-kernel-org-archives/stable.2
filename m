Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414B46EF9F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067671; cv=none; b=Z8IUzGMnD6dZI4pfUQJN9Vdrr6Rmar2NJ0dpBum8UmtDhQzz+cLQE1YsFq3JgABxryZn37jHhyo/ldbP2H5AlTCPDbyJTNbih01di75TRSRZhZk71JgLKYUGIoSLAc2oVx/p7ZYFLFGjxXYonFJEqE092hyrBS8aut/cbEquLCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067671; c=relaxed/simple;
	bh=yONbx833vReCL8u21KQDtpx/GldC6y5ERofgpR2+z1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+GElFEyr0GaUN9PHNKow2fqazTuuDr57Fw/1PfbzI/AcmfBMPi3+wiT535UCMCr3n6cKUxH4aQWSFDd0DT1VYPFwtNYcNjx2iIv/DLMmP5jCxLs7Hyp7Lr8WWb8Q1b7gzjOJaDP+K5oY3+pkkwBKKKGWvDs2MNX/dj4Jgw6VwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ0vx3BW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ0vx3BW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8074E1F000FF;
	Thu, 10 Sep 2026 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067670;
	bh=naecBUT99YvpTKuUHAJNiLz/RpubelS+GsAgSuFbFMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJ0vx3BWRcK7cGRoYnV6bk427MFH//JrXGRi6wf++5Qm6hMkkzFLK0TLndivS4Vaf
	 7B6+1SScwZpiWzKUQxhDI8mHI2Rbe6/4mBRJbsL9adO3XUwsHYc3ddauqIUIAkUgmN
	 2uk7CnTOEDu+tsfR5qhdo/hSPksJ2y2GRYMWgY3UsNC5U1jqqKCmYq64+f703xVyL1
	 sQVpJhoZLC0g2EIluoqrcdH9eXQ63NKcsuqH2S2XyMzx56V627zi3x8thTbb+icEH8
	 Zv96iKJOY7GVtY3wXCiBksSHh+4xUmvh1A2/8RKa80GAR5f6HDy3requvUFx3Nc5qJ
	 t+Y04GqzE1eRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ring-buffer: Allow splice reads on static buffers
Date: Thu, 10 Sep 2026 15:14:27 -0400
Message-ID: <20260910191427.1482318-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910191427.1482318-1-sashal@kernel.org>
References: <2026090939-revisable-paving-9733@gregkh>
 <20260910191427.1482318-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit 6365c44a824ff138e7926413932bb5c2e28a4c8c ]

ring_buffer_read_page() rejects splice (full=1) reads on static buffers
(that is user-mapped, persistent or remote) because !read check assumes
unread pages must be swapped. However for those buffers we have no other
choice than memcpy the data.

For the memcpy case, only return an error when the writer is still on
the reader page for the splice interface to wait.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901155445.1475405-2-vdonnefort@google.com
Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 18095c7d31fa7..f913eee68fa35 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6581,15 +6581,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		unsigned int event_size;
 		unsigned int flags = 0;
 
-		/*
-		 * If a full page is expected, this can still be returned
-		 * if there's been a previous partial read and the
-		 * rest of the page can be read and the commit page is off
-		 * the reader page.
-		 */
-		if (full &&
-		    (!read || (len < (size - read)) ||
-		     cpu_buffer->reader_page == cpu_buffer->commit_page))
+		/* If a full page is requested, it cannot be the commit page */
+		if (full && cpu_buffer->reader_page == cpu_buffer->commit_page)
 			return -1;
 
 		if (len > (size - read))
-- 
2.53.0

