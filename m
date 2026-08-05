Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309546D579
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931991; cv=none; b=YObQguVySlSke5IUbz9hOoxJtV04VU08dgNGbulTa+liRcoiRD5SlWLi7mfnXByPy5C0dzDzk+QIJK48co/oeZq/DmuOKztwEQe4R4nOd5XLjAjO8v7Ch9mA4Ovi6yRhPdhRmIesbDl8eoK7bmtutfdWtIQtArcnB+hc2vYYUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931991; c=relaxed/simple;
	bh=KVgJ249zauCUKnRpVJx0rCCJHgC5v/eP7Dbkv3jpmuY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GSIcXUvYRguU841m6RfvYDZgdY5TzYyKDWFmRjJVwf1/NdK39zDLAqG4u/EBkv4BrqE1dhY+LkioasTaWWvEIuovJHqQ9I0DZflYrBvB2MWWDsSTcVjgd+dyEHbDicTjteM2PeA6JEMJIcY/O5bngpz9Gzw6TbzDhQnmIZ5QS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jy+yAJ0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jy+yAJ0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FFE1F000E9;
	Wed,  5 Aug 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931990;
	bh=uozscLpYUb1hpeo0S0/h3CVMoSkuiU04VUM5XpOgJyg=;
	h=Subject:To:Cc:From:Date;
	b=jy+yAJ0O2QowIDBSnmb/vWGX1Csdn6bFzcX4oFNnBtGl1yLLdVvN1fWmBZst9WxQ0
	 S2zOBk3itIMyUlsOvBsLmJ5a9l6BqBRslFm4IFkbD9nyaVPRsBw6P4oJiik631cM70
	 gpC1K6Dd2x3cIiblXJ1xQa31KNVUOHiP8N6z/OKk=
Subject: FAILED: patch "[PATCH] drm/amdkfd: Add bounds check for CRAT subtype length" failed to apply to 6.18-stable tree
To: William.Palacek@amd.com,Alysa.Liu@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:12:45 +0200
Message-ID: <2026080545-primary-unreached-7059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6e7566ba4739dd573c331adde1c96690f7a567bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080545-primary-unreached-7059@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

