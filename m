Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85F3AB476
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191014; cv=none; b=bcxEqAtrOraMs3HJSvAH1rIcC+YVrVqjLq1QD4HOAMFskAOy4cK+jZZMF0pbQFCbECuPBEpwJ+8Nxr7ZO2qIBTUhTRbojNier3fEMlC6HLNEp+rQbE2a6Jrdr0we6kDTb+xf+IdGxx3e/YZC30PQbCjLYL6qllOvKHVXyBhAdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191014; c=relaxed/simple;
	bh=UyprD8dK1vJasAk2nyE3HBkKUtvGbLmm/rSqz8n9qdY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IXoeRpWwE0rZ+pQrK5hO5vzSKGADfKz37XngkxLJEw/RbGlf0GWlZco0PtHzTJQaafdTuOkkfmrc6FBrHMgUpQTPEWXE4EUd4+TN90gsEpFOjGi+qQ6T60XVO/q985E+uReS3EtkctK71Np2iqRRtfSrx//6LMPZmITM0qZWXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h+OdTiUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h+OdTiUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC181F000FF;
	Mon,  5 Oct 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791191012;
	bh=6WGIDcH18me9Jn0dC9vmRotKO9sYCUiIUAw3hU+5JtY=;
	h=Subject:To:Cc:From:Date;
	b=h+OdTiUeWO0kUlLs/5kFSfmtmMMLtTt4vWdq1D5nPiSC9axzYi2/jrIlnxs2qfPlI
	 1N0rK6e8Aua2fPqrb8TNym67iRu99ka3kQGELwlE6WBagJxa0w+5AZUAHDcnx5O4zh
	 v9zLoHXgK94HSbMKtgh2w1Px8ReeB/e5ag7ALZs0=
Subject: FAILED: patch "[PATCH] tty: vt: fix memory leak in vc_allocate()" failed to apply to 5.15-stable tree
To: 25181214217@stu.xidian.edu.cn,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 11:02:40 +0200
Message-ID: <2026100540-disbelief-sphinx-4c6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5b114bfc1dfd88f9d50822d532f7f1fce0f7388a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100540-disbelief-sphinx-4c6a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b114bfc1dfd88f9d50822d532f7f1fce0f7388a Mon Sep 17 00:00:00 2001
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Date: Mon, 3 Aug 2026 22:45:56 +0800
Subject: [PATCH] tty: vt: fix memory leak in vc_allocate()

If the screen buffer allocation fails in vc_allocate(), the error handling
path jumps to `err_free`. However, this path fails to release the unicode
screen map attached to `vc->uni_pagedict_loc`.

During the early stages of vc_allocate(), the unicode screen map is either
newly allocated via con_set_default_unimap() or shares the default unicode
map from a previously initialized console (which increments its refcount).
If the subsequent kzalloc() for the screen buffer fails, the err_free path
frees the vc structure but leaves the attached uni_pagedict with an
elevated refcount. This results in an unreferenced object memory leak, as
the reference to the dictionary is lost and its refcount can never reach
zero.

This issue was discovered by DevGen (an automated virtual device modeling
fuzzer based on Syzkaller). During fuzzing with kernel fault injection
(failslab) enabled, the fuzzer forcefully failed the kzalloc() for the
screen buffer, exposing this error-handling path leak.

Fix this by checking *vc->uni_pagedict_loc and calling con_free_unimap(vc)
in the err_free path before kfree(vc). This safely decrements the refcount
and releases the dictionary memory if this was the last reference. The
explicit check is added to maintain consistency with other callers.

Fixes: 34902b7f2754 ("tty: vt, get rid of weird source code flow")
Cc: stable <stable@kernel.org>
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20260803144556.163856-1-25181214217@stu.xidian.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf37495a8..51f8fd103dcf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1134,6 +1134,8 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	return 0;
 err_free:
 	visual_deinit(vc);
+	if (*vc->uni_pagedict_loc)
+		con_free_unimap(vc);
 	kfree(vc);
 	vc_cons[currcons].d = NULL;
 	return err;

