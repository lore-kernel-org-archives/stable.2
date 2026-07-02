Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31435E1D1
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980841; cv=none; b=jKrkASBlYfnARhGoIvF2s8n2dExYUgEi0JkOJbHqHpzNrLO4NwXsoRGcbKRrk7QAl7M15SVsNRIKZTsEaP1X0PN8kntHuLUAcWTwXq4PQj37SSt0nY4gV6KZpDKV0d/xclAfPlXt0ALa1mxX8Staz723ksBn1bE2URK5XYa50L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980841; c=relaxed/simple;
	bh=1HJuqbD0svFeAYdnwEvqlb3THp6SMEr39OwSE38OhzE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HPbM85ctCmtIhHfNC3wPyCrseL4caVnIRtk9tZWtasNSS4sdqiosi2I5rWU9Z/v+LHuwIrRbO1G5h6MH1V2fhB8PqLk5rVMdma7359WpRWJ7j4PLXKGRyTAyWvAb+OQwPcjOq93xk73nyAEv17Zt/RlT/TliO8kPsYUkWbRqz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwwISxnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwwISxnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0954F1F00A3D;
	Thu,  2 Jul 2026 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782980839;
	bh=0OzW+LRHbK//j80QIvZr3Ua9PXjBsh2YyN/vSc3AisM=;
	h=Subject:To:Cc:From:Date;
	b=IwwISxnQlHaqu2uqvJRvZJVVioe0Zd4RRXHsj733e2TyaoCMwTq+Ubf+DXyLQ6Mj2
	 ogM62xL74r3rrtXW4cospbvrUyBxEF7Ac1flf3DhKuQmuJnry00airz9hCp29m2RMU
	 5KwAPqFpArBXSr0ujd/TC4z0c383GJ8vIqwP1FPg=
Subject: FAILED: patch "[PATCH] device property: initialize the remaining fields of" failed to apply to 6.6-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,andriy.shevchenko@linux.intel.com,dakr@kernel.org,rafael@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:26:20 +0200
Message-ID: <2026070220-submerge-batting-b601@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7eba000621fff223dd7bab484d48918c7c77a307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070220-submerge-batting-b601@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

