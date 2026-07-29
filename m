Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F160471CE2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323843; cv=none; b=Qd3nshzNFrNj7x4FWzTWbInoJQXiplUqOgMFJZjbwn2UX5Rhz0Y86oG2dJEuMfpIG/X6LFFe8U3F/pqbGzNKmdnU6G2XaeadbjK9Ui/64EeFkG7nkd8A9/taMMV04gloR7PZ6ZpIHZfDHZC3RyT6noK2ZcT0P87PCAXDedqYfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323843; c=relaxed/simple;
	bh=tjgwd/i2FUJaLL2iDPywQ/UI8UCDYy/EgY3Ahuj4El0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m4YV8G9tVBWg6SJ4dO0qTM/vP1TlW39QD5s0mSZz90if77yinNWUDWsfIAfyFiCkvH2yU6t7HJbaLUbfLb25RI9BzNiqpNCIwgxppS9hTASyud68TWu7B1GQ5h9MsZd3sDScyr3yE0SUp5esZdtGhLc0xQ7IiHDyAJVT4UyQXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9yy6ycz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9yy6ycz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91611F000E9;
	Wed, 29 Jul 2026 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323842;
	bh=fJPWAUBhWF7IB3hefBFK3Hq7Txdz0VJkwp5NSvU/ZIA=;
	h=Subject:To:Cc:From:Date;
	b=Q9yy6ycz0y9ukmFBYO0Hga536LJNENFiKOC+Ilvba8eQWxPNMP1D9Gj0GHemhI7CY
	 ZMtjWxuZo90I3xaT9DiIneu0tSbRuW98NbocExwkzaML3KtZb5ukrCGM20bViBq7BB
	 VSsxbRa3yu5GliGFNJdguPQWL0d4lE1EQWQw4D+s=
Subject: FAILED: patch "[PATCH] drm/i915/hdcp: require monotonically increasing seq_num_v" failed to apply to 6.12-stable tree
To: jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,martin.hodo@intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:17:04 +0200
Message-ID: <2026072904-unwelcome-casualty-d8bf@gregkh>
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
git cherry-pick -x db9e64c983dcb07ff256bd455f258c44aa530ff8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072904-unwelcome-casualty-d8bf@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db9e64c983dcb07ff256bd455f258c44aa530ff8 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 25 Jun 2026 13:44:07 +0300
Subject: [PATCH] drm/i915/hdcp: require monotonically increasing seq_num_v

The HDCP 2.2 specification requires the seq_num_v to be monotonically
increasing, and repeated seq_num_v needs to be treated as an integrity
failure. Make it so.

For the first message, seq_num_v must be zero, and is already
checked. We can only check for less-than-or-equal for the subsequent
messages, where hdcp2_encrypted is true.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: d849178e2c9e ("drm/i915: Implement HDCP2.2 repeater authentication")
Cc: stable@vger.kernel.org # v5.2+
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260625104407.1025614-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 58a224375c81179b52558c53d8857b93196d2687)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 521786a75c42..0a076d2ed70a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1801,9 +1801,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		return -EINVAL;
 	}
 
-	if (seq_num_v < hdcp->seq_num_v) {
-		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(display->drm, "Seq_num_v roll over.\n");
+	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
+		/* Reauthenticate on Seq_num_v repeat or rollover */
+		drm_dbg_kms(display->drm, "Seq_num_v %s\n",
+			    seq_num_v == hdcp->seq_num_v ? "repeat" : "rollover");
 		return -EINVAL;
 	}
 

