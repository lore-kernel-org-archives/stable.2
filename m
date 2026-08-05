Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7B44E666
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932160; cv=none; b=AAjY0IZaqs3KSbLzEEIMuD7jrgqfMfHq1wD6ZnOjBxTojvc43cAhDVUuf+IJiIM780SEERFlDq+DL4lACZyajAWwf5T7uK6u4/44MX9buqf/GAebK10SIEnuAWj61x8KiF8dbcj6FYtBmz/bZxAY5ZJ5HsBC4L6M3RLwooY8oQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932160; c=relaxed/simple;
	bh=Jk6egul18in386hb7cCljG8fAijXs6ex2LTYO/Y2Pvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uTxEdX4aHB0calQqizF0e84a8hfpwok6AGoVGf1vuc5KL8swmooO9OPuSpkMnP2iTMpgoBLnHtnsXSatFz0Yd940JqHe9W+zQjYJf5DYFsjGJSrrIYhEP5SA5/Gej3uqQW/s7eghJkoSIsl4hruxY7O9Rzhsgxf0W1IlLSd6o/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wFhiUyYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wFhiUyYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9ED1F000E9;
	Wed,  5 Aug 2026 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785932158;
	bh=UXjXKjykDbsBVta+0aPqIY+46sjhy8q4XO6DjEZnN6Y=;
	h=Subject:To:Cc:From:Date;
	b=wFhiUyYl13FmoA5hhnHfxwJcDLMjAfbl6FCBrCyxH5qcIfuHsmLHgtcXy0x+mNebU
	 nUqMC788dHbxEAh2eUaWPn13ZdOimLNvHnaWz1MFBRdpVkBZH3BA/eBpgM8FOEi0D1
	 SE0LBAaC/8hXrXs4CYVOqyxNPWU7y/YO1JIyP3+g=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: drop dma_buf reference on foreign-fd prime import" failed to apply to 5.10-stable tree
To: zack.rusin@broadcom.com,ian.forbes@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:15:33 +0200
Message-ID: <2026080533-tartar-retaining-77de@gregkh>
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
git cherry-pick -x f739416dc555fa205a785e5135d73fa39b26f35d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080533-tartar-retaining-77de@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f739416dc555fa205a785e5135d73fa39b26f35d Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 5 May 2026 18:22:26 -0400
Subject: [PATCH] drm/vmwgfx: drop dma_buf reference on foreign-fd prime import

ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
dma_buf->ops do not match the ttm_object_device's ops, but does so
without releasing the reference acquired by dma_buf_get().  Any
unprivileged renderD client passing a non-vmwgfx prime fd through the
DRM_VMW_GB_SURFACE_REF{,_EXT} path leaks one dma_buf reference per
call and indefinitely pins the foreign exporter's GEM resources.

Funnel the error path through the existing dma_buf_put() so the
reference is always dropped.

Fixes: 65981f7681ab ("drm/ttm: Add a minimal prime implementation for ttm base objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Link: https://patch.msgid.link/20260505222728.519626-6-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..f9042bafdc93 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -547,14 +547,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;

