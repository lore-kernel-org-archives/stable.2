Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3558FD08
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067340; cv=none; b=YwaFsuBLBjAByw74rISEyVacqWweC7HvM6h8DI9WrHJweRynwdy8Zs2NCM7eK95ARNrSG0VEmAyAZ5nQ4OwVYjsvhunXTzwU9ikwZ1j3nlTPHEjH7GTmrcN1Ly0MzygIk6tXim3+e4kkW61Z3kxeR0cx6UsO9KCABv/1Qzc8HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067340; c=relaxed/simple;
	bh=3QeNqjLuGiTrrYc+ZzkqDEn/ijmMbg8qgSQErim1RVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGhLS009Rd/ozfiIPnTN2oYMVM4YRJ5ryIMuapcXJtQ/0BiuUYsnF3UW6LS3k0ynIEcHRPtcqDzq/8mHr95AGmb1IgXGpvhqi8+ji096vxDpTb3Fpg7ZAlZEc19u6Svst9YxKWd3T3IzGguBuicckLukE0hbhp6y+tAxRcy+cK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXY7Jo9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXY7Jo9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812501F00898;
	Thu, 10 Sep 2026 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067338;
	bh=x6w+I+WaBxsTe5rllAAtHyhhI4P6uaaFXNguqrMqUck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXY7Jo9kZzDqRySTmDyP0oyOgy/Z0Au6s/384avo7PO1HhJ0STtBSJ9fpxhytYl+U
	 iU4JOE76ko3uOkOGh0LSvWIEeXsg6Eva1b0aRrJwTM02hTVEjA6H4VzLmv6XCi32Z3
	 KNfoU4oLfp8pE7HEXMR/ruylDHfA8mFnadUbE/8orG404AR3hQ1lPGhWr2dqgaVptY
	 snue1ylv+StcyFoXgTXFGC+aEK+1C+B1uwpSwN5h22y38AuGfseP87bmQdEEeBJkeI
	 loQPXGBmYqleWqYNob1msyV+G+b+gH8u0iYYDNgJfDj3BwIffefaAB7GNXFFdlTxyP
	 84Wvhy15ymg/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ring-buffer: Allow splice reads on static buffers
Date: Thu, 10 Sep 2026 15:08:55 -0400
Message-ID: <20260910190855.1454582-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190855.1454582-1-sashal@kernel.org>
References: <2026090938-botanist-exceeding-0112@gregkh>
 <20260910190855.1454582-1-sashal@kernel.org>
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
index 1ee13086316bb..59c5362fe0f8b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6739,15 +6739,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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

