Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DC522F1A;
	Thu, 15 Oct 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071246; cv=none; b=bQ7e10uaLCQAX+P/yekOI/0fxOdOYyLgCtfwJ2dI9lPSga3HMiGV364U63Vvm2KNtLDCttgu7xqUa+D2X3LouC5YOju/30PWbgcoVTZO0DZxpFm5EbHQK/BtDG0RY9AVkkrHKTISp42YF2vNIRgkMpEDG58Vtop3BpvU5VS8AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071246; c=relaxed/simple;
	bh=bPLL8TPErcbM5Bj5i4pKw+WqSiS9eCP4lZKMQrveDMI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KXAwBB4Qel11rc7G2B5NE8lsyioacENxyzYVGuCA2LvdE3Em9Z8LIifxQXuJaKzZo5miuFUalbAe/86IiDmnJVIr8WmlkjthPKA+l1rrjK60w78LJY7zBy9G1VK9XgHCd2cQa3xLKJgMKvDH8XWl6EPeFgKZYpQQcLNfRfv73yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuQi7FH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuQi7FH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F04B1F000C5;
	Thu, 15 Oct 2026 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071244;
	bh=r7BXtOpv2uyoOOi5rjC+5uSD/dS7kT4PcmP95BYIThQ=;
	h=Date:From:To:Cc:Subject:References;
	b=WuQi7FH4fAxqLAdDYCiXPb9+zas3QUCIxbnMQEQNrdpNGGp5x9IvA5/56KUp8th7G
	 Uy3mGTpyEPK+2lYpALy/0Boo85YvFxV5kvv5SUXbM5QlQMMYpBm3z0mCxPLeIlI5ky
	 pVpddHJ1CClQUkmZ2OH9flE+MBPQzUYBiIEw1KakWz2+vVkjBFn1A1KtFnROPE+eAi
	 FemU/xvnzWmSkRmUDFjxqZcIKGLr9KYDA2k9qb71U0T2ZDNZUJLrHEZ4M1mmowRebU
	 CF+5bs8tOFQPeZ8ccYysd5rNElR93F9bkB8oj7KdLf5p8wiDDlE1C7PHEuqxSOQvew
	 Uy6SNgdvs3i4A==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLat-00000000MeQ-40qP;
	Thu, 15 Oct 2026 09:34:03 -0400
Message-ID: <20261015133403.783087207@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com,
 Krystian Kaniewski <krystianmkaniewski@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 09/16] ring-buffer: Fix false warning in ring_buffer_map_get_reader()
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Krystian Kaniewski <krystianmkaniewski@gmail.com>

The mmap reader can warn when it catches up with a writer that is still
committing events. rb_get_reader_page() returns NULL in this case, but
ring_buffer_map_get_reader() treats that result as an error.

The initial rb_per_cpu_empty() check filters out an empty buffer, but it
does not guarantee that the next reader page has committed data. Writers
do not take reader_lock and can advance commit_page before publishing the
committed length on the new page. rb_get_reader_page() can swap to that
page, catch up with the writer and return NULL.

Handle NULL through the existing no-data exit without warning. Remove the
caller's reader_page == commit_page check as well, since the reader-page
helper already handles that case. The existing metadata update and return
path remain in place.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260924084946.20104-1-krystianmkaniewski@gmail.com
Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Assisted-by: Gemini:gemini-3.8-flash syzbot
Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
Link: https://syzkaller.appspot.com/ai_job?id=488adc18-a10e-42d2-a205-25327c38837f
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ad3bc48e2670..e2b721d0707f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7998,12 +7998,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
-	/* Did the reader catch up with the writer? */
-	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
-		goto out;
-
 	reader = rb_get_reader_page(cpu_buffer);
-	if (WARN_ON(!reader))
+	if (!reader)
 		goto out;
 
 	/* Check if any events were dropped */
-- 
2.53.0
