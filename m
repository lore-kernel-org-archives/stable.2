Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3846DFF1
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931994; cv=none; b=atMYH0BJrh19ZGqlxKV3Glb8ub9ZykGRZNLWI7TilHoBUi4HhtNNoqYYBPaveREuh4EYLSoCshWU1VCiz7/0yaJ2sopoFyP5Wrm8W2Ctc5q5w0a9Xly39ksULoMBoSonipAryPU/3I9U7RAG/+fjzbSDm4Px5zd85P3zgwq6/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931994; c=relaxed/simple;
	bh=UFrZ4ca1A7kaqzuUMuXCda0GWCDqXyoHftB3Mikyx9I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kk3Ei27yJ9sLig7P9MnVLxpDncFupGC2qRn7jd/v7vP7da5Xe71HVcHYLfalB59EJKQKZnIwkzAIbw1NUMDOSjF0UUrp3f4YydA+8I7CpXsh3A9KUsWsIEfX7LCWOvCjYbhE3uMImUNwDEcOxPO3MZHI8QiPa4mIOLiKz2aXnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1f8olOeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1f8olOeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9B81F000E9;
	Wed,  5 Aug 2026 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931993;
	bh=fvSnEC9IxNFjQBP0xIHeSN3ESNL0kX2y1c2SScZvCHA=;
	h=Subject:To:Cc:From:Date;
	b=1f8olOeXTh1VD5FpdWALqJjejtJg1EJK4bzXcjcWbRXfqjZGdY1o7HfmYukDdYlYb
	 BjM0eVbMYJSUAt7gjpDHxa14Gp0Bmn0qnx2AoP9DT5lekY2GffyhkNvp8vLjPx3kS/
	 QIOrydIe6Fg/7idMSxtv7/ExRSMTPzyAJIieTtP4=
Subject: FAILED: patch "[PATCH] drm/amdkfd: Add bounds check for CRAT subtype length" failed to apply to 6.12-stable tree
To: William.Palacek@amd.com,Alysa.Liu@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:12:46 +0200
Message-ID: <2026080546-bloomers-primary-c22d@gregkh>
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
git cherry-pick -x 6e7566ba4739dd573c331adde1c96690f7a567bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080546-bloomers-primary-c22d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

