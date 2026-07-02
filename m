Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A7481FAC
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996738; cv=none; b=dWaeuKDp2uhkZktXH3osKRzuDNuiFzDFgZUlKDbVj93AvhsmfDlUhBy/qWT6E4K56UQX+96wWrAv/oPjcMsfCu3UPwbK7DPLe/NKlJANj/69njWL67Pg8Yjr6K9oRtGfx0YEFCxsHzsgR2HqYUXFiVLxv6poqWg1ZP8Eki7jDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996738; c=relaxed/simple;
	bh=uDbSz3NSQUa01G2zc5ndpp5tUeT3AO11gkYhOju0VIY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yy7CtQ08mh4Fqgk+LA3EvR5JXhKzGydBaADqwfxgrXjFFpVJljJZk/BqRT4JwmhZ86UcM/wqggbvOEtrTxzi2kF6ZE51YkTmuIJYgac9WhTO5xxj+EL9EnWdXGo3sevF82rkZEkUMKU2bYwd/oVANNcRl0yztmYSWj1TrAeE8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aeQdgNBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aeQdgNBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E211F000E9;
	Thu,  2 Jul 2026 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782996737;
	bh=byc2PuZpo1Wa5BsfgUnq18G/rMqmAaP2xSUPpDstmeA=;
	h=Subject:To:Cc:From:Date;
	b=aeQdgNBQDpAox/gyLEz3rLC70upwVRgZFlevR9sfQXJWybh7yDajODsi+B5P0waEl
	 VF98vI7eTtvefI7uyINz0STlGTd/6QWJLHlSlWJyQdoH9rXOTAYAwtnvPAGBSYWoPd
	 l04wF3Ox/6tHYw3sDaW5SZPrt2hMfsLQxmC+064Y=
Subject: FAILED: patch "[PATCH] userfaultfd: ensure mremap_userfaultfd_fail() releases" failed to apply to 5.10-stable tree
To: rppt@kernel.org,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,jack@suse.cz,peterx@redhat.com,stable@vger.kernel.org,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 14:52:13 +0200
Message-ID: <2026070212-deeply-dab-ca15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0496a59745b0723ea74274db16fd5c8b1379b9a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070212-deeply-dab-ca15@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0496a59745b0723ea74274db16fd5c8b1379b9a9 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 13 May 2026 11:14:16 +0300
Subject: [PATCH] userfaultfd: ensure mremap_userfaultfd_fail() releases
 mmap_changing

Sashiko says:

  mremap_userfaultfd_prep() increments ctx->mmap_changing to stall
  concurrent operations, but mremap_userfaultfd_fail() does not
  decrement it before dropping the context reference.

If an mremap operation fails, ctx->mmap_changing remains elevated. This
will causes subsequent userfaultfd operations like a UFFDIO_COPY to fail
with -EAGAIN.

Decrement ctx->mmap_changing in mremap_userfaultfd_fail().

Link: https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org
Link: https://lore.kernel.org/20260513081416.495963-1-rppt@kernel.org
Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4b53dc4a3266..390e4b7d9cb9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -786,6 +786,8 @@ void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
 	if (!ctx)
 		return;
 
+	atomic_dec(&ctx->mmap_changing);
+	VM_WARN_ON_ONCE(atomic_read(&ctx->mmap_changing) < 0);
 	userfaultfd_ctx_put(ctx);
 }
 

