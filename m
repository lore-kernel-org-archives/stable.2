Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14542A783
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980778; cv=none; b=FMaoCD1yb9KA/qisMCeo0sAsfwPMwPnX/unw9HmVFyVs+vtwixK0Xyek0k3BAVYUfATaIdCZPHn84I/h2DRmDyzehtVt18luYnLVIiKqYTPmUZeQdnMe1T5nBjEuFBeK4Aj5t/vuTzwl/HE0YjqhEh8BaE/ofm8Tv9R+vbPO7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980778; c=relaxed/simple;
	bh=jjud8H0YsHwNLDQyQG+vps4bbPQIEHspr8MZ7dXgx6w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mOUj4/3F5i+czowkprwqjH+iNvck12U1HeAySyW+dN4TabGTn7uMBO+2JV3Qzg1TPWfQSZXlCAeksjFaAd0OUY8iCzPUw8IWwiKrCc6LM0tvodnmNm++ukKZj84iger4SDHiKk0zo0jqTJhIyAxO0nRBw2HhZjPQ6T/Q4fILVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7QTly/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7QTly/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0958F1F000E9;
	Thu,  2 Jul 2026 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782980775;
	bh=fG+VLQqLXctb/q4latzXgHjg13MAAmkFJYHQb7cqk4w=;
	h=Subject:To:Cc:From:Date;
	b=v7QTly/lpheMWeEyMGHIn1tMPeqHELz9LAMxsHFKEsQIZRE4NuZX27dKOObwSj9rQ
	 gguDp37GG/06FpALvCDni7Qu9BRbHsGjbHOIJtE5qI2S3UGECFgOY/asR+rrAyljTq
	 AK6wR6b6is9XhNmGX1hgSKOW+5jfntVioBboeHis=
Subject: FAILED: patch "[PATCH] device property: initialize the remaining fields of" failed to apply to 7.1-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,andriy.shevchenko@linux.intel.com,dakr@kernel.org,rafael@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:26:19 +0200
Message-ID: <2026070219-kangaroo-washed-a6e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7eba000621fff223dd7bab484d48918c7c77a307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070219-kangaroo-washed-a6e0@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7eba000621fff223dd7bab484d48918c7c77a307 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 11 May 2026 09:49:26 +0200
Subject: [PATCH] device property: initialize the remaining fields of
 fwnode_handle in fwnode_init()

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitialized memory which likely
will be neither NULL nor IS_ERR() and so may end up being dereferenced
(for example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization. While at it: initialize the remaining fields of struct
fwnode_handle too just to be sure.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com
[ Fix typo in commit message. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 80b38fbf2121..c30a9baafc0d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -208,9 +208,12 @@ struct fwnode_operations {
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
 {
+	fwnode->secondary = NULL;
 	fwnode->ops = ops;
+	fwnode->dev = NULL;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
+	fwnode->flags = 0;
 }
 
 static inline void fwnode_set_flag(struct fwnode_handle *fwnode,

