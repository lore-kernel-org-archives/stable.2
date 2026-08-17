Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464584252BE
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972031; cv=none; b=HRYI6MhyhGYGQi7m8UzMpGUNvm2qgCuJkQbe7UWRWTI3iYDJ7mWWYNLePAgqf8pshE5hVwYYgwW4E9niJp1BJGNZXBFa/ykzR10U7+zGzcVfvNhP/i/Da7X7wEF9prmaR+Td6q5kKyw8qvopMkLhrodIbkRaF70BfRUtj8/S9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972031; c=relaxed/simple;
	bh=PB5A9bvdJYD/cJdpjPhm5CcjT5C+X+7aQGIPpn1xBBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=poKgeDOVhlR1p3SiGQSX2XT9WIeno4u6KXXbJTaPgDT7SfHYAcPjuieV497fNjT9++KNEoMIPDFV0UsLCcAelrDc2Fc3PV1kc1HL4WVgJagzNMIFgL29/oEHgtBBr2O8cE27l6l8LZEJ+cWTys/wjYsAbAd1BzufH5tf7hf/sYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwl4CXXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwl4CXXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F50F1F000E9;
	Mon, 17 Aug 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972030;
	bh=DwVU5/FjPUcsf6Geaw4q4043MAs6XNipgQEPR1CypXY=;
	h=Subject:To:Cc:From:Date;
	b=wwl4CXXTooYxDDMcJSL2xDUZ2uO7xf3zlSvb7rPBcUvSTLBAb8cN3pjf185QoTSCf
	 jdGeroPLtUjkRiykfCRSHtKf0cZZFAaKT7icE9VUfDZWh8UGz+QHNq8V4jHxhup5nA
	 gachJE6j2N3TL1UYJbv/AJVp3AHRkup6VnhIDJOM=
Subject: FAILED: patch "[PATCH] ring-buffer: Initialise reader page order in" failed to apply to 6.12-stable tree
To: vdonnefort@google.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:55:07 +0200
Message-ID: <2026081707-pajamas-stoplight-328c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6d014e44b68ddd43f71288d2a4dbb1a259869149
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081707-pajamas-stoplight-328c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d014e44b68ddd43f71288d2a4dbb1a259869149 Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Thu, 6 Aug 2026 22:13:03 +0100
Subject: [PATCH] ring-buffer: Initialise reader page order in
 rb_allocate_cpu_buffer()

In rb_allocate_cpu_buffer(), bpage->order was omitted, leaving it as 0.
This is an issue for a ring-buffer with subbufs bigger than PAGE_SIZE if
when freed: free_buffer_page() relies on this value. Align the value
with the actual allocation size (buffer::subbuf_order).

Cc: stable@vger.kernel.org
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Link: https://patch.msgid.link/20260806211306.3704194-4-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6cbd80ccef37..760a00e8505c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2510,6 +2510,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	bpage = alloc_cpu_page(cpu);
 	if (!bpage)
 		return NULL;
+	bpage->order = cpu_buffer->buffer->subbuf_order;
 
 	rb_check_bpage(cpu_buffer, bpage);
 

