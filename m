Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9642A790
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980804; cv=none; b=T+RCZRnD9H2agpaK2ILUgAMRIwGd/8X/wnJHrbansVAEUxWr+2nbx0fC2/+3rIZE2N69QvC9Q9vv+x9fX/B++kFoTTtBguy0OZA8aS2i743DKwdUX1vuDklQ7jmIg0ls6dqN6k+/PTYVXPlhVHqp7C0Ye/C6ivqv8vd10CrWFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980804; c=relaxed/simple;
	bh=JIESVOQajvJmhekJ1n6lO3RCTjrnmuJA8CW6GM80i8Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sDXC0iP/9aTtZf5Srv+wjml3e/dFYLhrJwY6uYK+/jyzS3KnBQxGzhS9WUGi83nhEWIoMrDtczD2wmZ2lub6BF9Mik4niI1d91C1VB6pOdxvqxN12I+f2VHfYAsvu9eh9XnTYOwB4toL7JmSSIoev7I7tGYj4WTuNw+2sM0vT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lc+pG1Xn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lc+pG1Xn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2571F000E9;
	Thu,  2 Jul 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782980800;
	bh=w+8Bbh3OlWYyVGGfX7KvtKYaqQCbuQy4pJzmuqsMqQ4=;
	h=Subject:To:Cc:From:Date;
	b=Lc+pG1Xnqmi1GgMd/PQTQ9Fb7rbWBvYYpSzt7ZqND9HB4FvDOPNfQA5BoXwRLyOUX
	 UI0dBdJunY9RurdDPSyH/b1WP4csKN5PhXhVXZiNLLqkcvMNlATrl1ElPi1E9PdWuN
	 FajJOHjwGdNBaXOYZsEu34dQuC8SOKhEEsUpOHM8=
Subject: FAILED: patch "[PATCH] device property: initialize the remaining fields of" failed to apply to 6.12-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,andriy.shevchenko@linux.intel.com,dakr@kernel.org,rafael@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:26:19 +0200
Message-ID: <2026070219-marrow-guiding-4009@gregkh>
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
git cherry-pick -x 7eba000621fff223dd7bab484d48918c7c77a307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070219-marrow-guiding-4009@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

