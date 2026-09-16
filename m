Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4B4AAC59
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574797; cv=none; b=Evw7uYTwDHzSb7ukRUw/txhKKfhG6/ugklnnEb66vZRJ1phXS0q9e16nUo4sR+5oBkAi7lkPrZt//fu7UAnX3OcIvpRGiz0ZzD08CVVQWBzNFiU73rGrVNo74IUHX2oQCjXBvGT2CPFCvUW7Df9SH2ASKVwjOXzB+8SFRjWAKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574797; c=relaxed/simple;
	bh=XM4HvxMzhZvfrqgXWVaSyOlckYDiLP4At6vnwObzNX4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lBdUKz9umYQbgoFgFSX6bmPvIaqLXNLOMN+j590NyiOU6x04h0dS6INJ++usEiaa1IisUfx2lnAbBLR1VbazR9weEzYRYqe3HBqtrL2gAUfKwdhWl25CT1cVGFa1qCRaXl7TBM5Pit7oUIplGJfp6YxlCJzR82FMHIYQmTlNCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dY9+WVF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dY9+WVF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061D81F000FF;
	Wed, 16 Sep 2026 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574795;
	bh=CFz5b0kQd1A6pYQcpTZRvAxPqDtDUd3mH1ncRWjFEVU=;
	h=Subject:To:Cc:From:Date;
	b=dY9+WVF5DJIBYJtT57JRGBF5D7wlPj76DmNkeWL8omiWmUFpGqHsP4byAOWV2Z+Er
	 d1wbXBF5I3ooR44Zc7rma3DwH1Nk51zjZrTZJA7K4AxDNWRBo2tr0N0uNlwS+TneQO
	 Q2MNWqmWqPII8NDq6VB3kE2Qg5ddBSd86tuBNpbY=
Subject: FAILED: patch "[PATCH] erofs: add sysfs feature entry for xattr prefixes" failed to apply to 6.6-stable tree
To: jefflexu@linux.alibaba.com,xiang@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:42:51 +0100
Message-ID: <2026091651-stubble-sloping-7a9b@gregkh>
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
git cherry-pick -x 839f075aabdf5c21048f9801b87c0b841dd3d064
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091651-stubble-sloping-7a9b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 839f075aabdf5c21048f9801b87c0b841dd3d064 Mon Sep 17 00:00:00 2001
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Date: Wed, 2 Sep 2026 09:50:39 +0800
Subject: [PATCH] erofs: add sysfs feature entry for xattr prefixes

Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.

Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
Cc: stable@vger.kernel.org # 6.4+
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index e4cf6fc6a106..0b8b4354e40b 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,7 +5,7 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		compr_cfgs, big_pcluster, chunked_file, device_table,
 		compr_head2, sb_chksum, ztailpacking, dedupe, fragments,
-		48bit, metabox.
+		xattr_prefixes, 48bit, metabox.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 6734483a440f..dfcec9376cd5 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -95,6 +95,7 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+EROFS_ATTR_FEATURE(xattr_prefixes);
 EROFS_ATTR_FEATURE(48bit);
 EROFS_ATTR_FEATURE(metabox);
 
@@ -108,6 +109,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+	ATTR_LIST(xattr_prefixes),
 	ATTR_LIST(48bit),
 	ATTR_LIST(metabox),
 	NULL,

