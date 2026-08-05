Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A746D554
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931983; cv=none; b=AV70EXR5ZxSg4vtdiyv4b5o1wnZ2BF9WSMrnlbbe9aB5oneUfCgHOzuU8UzwE5uYkSk6uLv5aL/T4hoZfpigBCbGxgTYPlEs4/qa5vdCSoZdXh00M9vsgr8qgARhxX/qzWrtI+rhwdtfYCHIT28/0WnBQQAD0EnfRthPPqU85I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931983; c=relaxed/simple;
	bh=CjllhgK5I5h78aIJCklvmhdqxA48K+MvR3TKiJTCAb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XZBY1y3QtmSsfFkeOYBqiAATG7WWGQFYStW0CnT+xf26aQbpTMs9OetDCL6jiW1iNQlR1SuKxOiDy0m5YOm81jq2NajZHw/tAdoGv2uhFW/SdnnufiLgwSeeQMYOXD+21jqQJJKteWhE5faxWpkvp6PGpRj9EtauTkG1Nr2ql/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jWdHOrv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jWdHOrv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA821F000E9;
	Wed,  5 Aug 2026 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931982;
	bh=eaha6cB+EyHjyr30vz7r3GnW7wC2bQ1MO+pU0NeZq3o=;
	h=Subject:To:Cc:From:Date;
	b=jWdHOrv3uGvP8d1Q/ubGtdFzgIw1lb1BgRSCUcsMLHKHXKs25FMmBQKcG6VIyldVO
	 tKWuI0lfvmlrV/ZTghZSQ3fdJwHk+Zpb+XpwDvGkL8607KAxvlNtJD3W7uaAEr+Zxk
	 /WXr5Tz1zBpm9yFtzRyG4ERVWMsADnKH0OGIHf/8=
Subject: FAILED: patch "[PATCH] drm/amdkfd: Add bounds check for CRAT subtype length" failed to apply to 7.1-stable tree
To: William.Palacek@amd.com,Alysa.Liu@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:12:45 +0200
Message-ID: <2026080545-variable-gala-d869@gregkh>
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
git cherry-pick -x 6e7566ba4739dd573c331adde1c96690f7a567bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080545-variable-gala-d869@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e7566ba4739dd573c331adde1c96690f7a567bd Mon Sep 17 00:00:00 2001
From: William Palacek <William.Palacek@amd.com>
Date: Mon, 6 Jul 2026 10:25:58 -0400
Subject: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length

The CRAT parser validates that the subtype header fits within the image,
but does not verify that the advertised subtype length fits. A malformed
CRAT table with an oversized length field causes out-of-bounds reads when
kfd_parse_subtype() casts the header to specific subtype structures.

Add validation that sub_type_hdr + length does not exceed the image
boundary before parsing the subtype contents.

Signed-off-by: William Palacek <William.Palacek@amd.com>
Reviewed-by: Alysa Liu <Alysa.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 48e1d1e6e8798aef0312e68d8e586021b5b3cf4d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2a239f45fc24..6e0df685503d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1412,6 +1412,15 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 			break;
 		}
 
+		/* Validate subtype fits within remaining image */
+		if ((char *)sub_type_hdr + sub_type_hdr->length >
+		    (char *)crat_image + image_len) {
+			pr_warn("CRAT subtype length %u exceeds image bounds\n",
+				sub_type_hdr->length);
+			ret = -EINVAL;
+			break;
+		}
+
 		if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
 			ret = kfd_parse_subtype(sub_type_hdr, device_list);
 			if (ret)

