Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50D3F6C27
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947224; cv=none; b=Eu2SZodPsnukz19jFHdWVrd+0eBaLzQlrEqMnWEqrOHN7mG3OYsH/6Xsi0ALxkHK+VV2JfX0bnbbUMi0pjLGN65RYuM/NEbh3aEKjQv3VZsszcKo6ozzjOEJoBS6WBgxpSPrNcf5MDfiRqQSr1lCGWuqZD/y63FEs2vksS16BuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947224; c=relaxed/simple;
	bh=ztCBIMUWenp0DiKZuziovrIQhSYZDFW/5Omjjhejk9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LCKpA70dqmFoJmd3ir81qSQmGjfBRPzCUS7aTb20pXzVgZEtz5gqNxEOjCJKn+mMDY9rq2NcAZ3SUWSTHg6+J24ijboJ/IqwoDevtdZXOUo4TpylgGVbWJ8oBZQRLsO+P2rPbneI4onRyYamVVeF5q3Mo9gwqKkCJnDlFkV3TpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJbsLicq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJbsLicq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C05C1F00A3A;
	Wed,  9 Sep 2026 09:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947222;
	bh=f/aioOF7pNSq4d0nrfWTnXSTY86gR+AN1wv5fyKJJN8=;
	h=Subject:To:Cc:From:Date;
	b=UJbsLicqTmndOy7eK17M0O2DklfeFofroSs1AD57zg9pRsuoyOqaZYqzMNRREUQRO
	 11Mzpje03r1dFgAj7S0Hj0kpROAKiAMmuuudnyf0VVXdGSCcYEpbAJ6/GFVUawRlfc
	 5T+oUIPbvU+Gzre8Kn15H9Yoi3DhAHHoPsq0r1Pk=
Subject: FAILED: patch "[PATCH] ring-buffer: Allow splice reads on static buffers" failed to apply to 6.12-stable tree
To: vdonnefort@google.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:42:39 +0200
Message-ID: <2026090939-revisable-paving-9733@gregkh>
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
git cherry-pick -x 6365c44a824ff138e7926413932bb5c2e28a4c8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090939-revisable-paving-9733@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6365c44a824ff138e7926413932bb5c2e28a4c8c Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Tue, 1 Sep 2026 16:54:42 +0100
Subject: [PATCH] ring-buffer: Allow splice reads on static buffers

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

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b0963ac6fd16..84fd4cdd486f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7193,15 +7193,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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

