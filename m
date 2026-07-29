Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE34484230
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330142; cv=none; b=YRSoXT1Sgktd1qt8I4Tb8XvL4LDqbLSBfuNzR/cTskaANuzjdXDozm/IJZ+oaFJcShEFfrlrxcw/DYl8tBkiyLb39jPjC2h53UCTfhuYd6GAJZGKDWaHY+mm68f+4IEq/Y3AWBsqF9c4P2c3qwhcOG4lephD7B1GXxhEL+bn2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330142; c=relaxed/simple;
	bh=ATdmEzAaxx91VRbB0P3i/s8kK7O2M4RY7muG2Pt1Vak=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CJrQ433h8jIKapQXNYdNtnO5COHzMv1al2cTORN7bs+1bz9Sg3kXbWSZ89L3jJaKUWrtG/9QvF7YiypdBzebgu/7+hMHkyHAl+v5/LRu5Aw+7jyj5JUwO7z3dwVO2vB8cnFfcYfnitwe3WPIAsWF5NQHs+NIKSDjZAD2MZ525DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ymh9GmvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ymh9GmvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16EA1F00A3D;
	Wed, 29 Jul 2026 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330136;
	bh=Wy1vCenP9TPAN0+qcWSWkz+n+D3Gvr9gRrAp80nnrdE=;
	h=Subject:To:Cc:From:Date;
	b=Ymh9GmvJ4ogEIg70Vs0t1rDl3cX7b6faPf1XmYDYif3jlBXxciZb2it9uQ31xK6CP
	 m0YowZ0gqQdRP/C+12h2kwW/8nKZ1S5jCJAuIQ2c4Yav9PuyKfb4ncKVHj+S3BpoAB
	 aelftfxQGtuu51RlI2hRD2JBUk07/rHfBtC/F0AY=
Subject: FAILED: patch "[PATCH] media: uapi: rkisp: Correct name version enum" failed to apply to 6.12-stable tree
To: niklas.soderlund+renesas@ragnatech.se,hverkuil+cisco@kernel.org,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:01:53 +0200
Message-ID: <2026072953-hamburger-filter-279e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c4c01c4fd4a3916ffdfb35ad9f511c48e289f51c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072953-hamburger-filter-279e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4c01c4fd4a3916ffdfb35ad9f511c48e289f51c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
Date: Fri, 1 May 2026 21:03:39 +0200
Subject: [PATCH] media: uapi: rkisp: Correct name version enum
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The name of the enum to hold the mapping of parameter buffer versions
have a typo in the name, correct it. While this is a uAPI header the
impact should be minimal as the enum is only used as a collection for
the one version number supported.

Fixes: e9d05e9d5db1 ("media: uapi: rkisp1-config: Add extensible params format")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260501190339.3449193-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index b2d2a71f7baf..7638b2220600 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -1535,11 +1535,11 @@ struct rkisp1_ext_params_wdr_config {
 	sizeof(struct rkisp1_ext_params_wdr_config))
 
 /**
- * enum rksip1_ext_param_buffer_version - RkISP1 extensible parameters version
+ * enum rkisp1_ext_param_buffer_version - RkISP1 extensible parameters version
  *
  * @RKISP1_EXT_PARAM_BUFFER_V1: First version of RkISP1 extensible parameters
  */
-enum rksip1_ext_param_buffer_version {
+enum rkisp1_ext_param_buffer_version {
 	RKISP1_EXT_PARAM_BUFFER_V1 = V4L2_ISP_PARAMS_VERSION_V1,
 };
 
@@ -1601,7 +1601,7 @@ enum rksip1_ext_param_buffer_version {
  *	+---------------------------------------------------------------------+
  *
  * @version: The RkISP1 extensible parameters buffer version, see
- *	     :c:type:`rksip1_ext_param_buffer_version`
+ *	     :c:type:`rkisp1_ext_param_buffer_version`
  * @data_size: The RkISP1 configuration data effective size, excluding this
  *	       header
  * @data: The RkISP1 extensible configuration data blocks

