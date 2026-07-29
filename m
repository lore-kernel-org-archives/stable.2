Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83C470EA0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323862; cv=none; b=FjKzCCV0Pew5ggsOWs8Ppv8MYYMMt3shQ/9nyrcV5d7Uqq2AhUhfydHmIedqUeRxUnDkvDpTzfud0hz+a0my0sCAqwbX5KGxYGZkOcOZpfZDIrXSfc0FSNKPORLnJzfxWHjhS0a2VK9cO0b7afXKb3pVZlm2XG7j5XePfoqYbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323862; c=relaxed/simple;
	bh=MYIBPpBvWE+zTpRSZlY5gpIkDnTsjc94GGiP9qeQuRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iLjKMP3XVvkbuB0z6VMVg7x87jzAi7rFwgbrJ8yHEgwemJAwhho29Y2/XVkyJrp4Kk7SuAkFst3qyyREsaC9fNa8eVLob6RhI2OMeIoDbFlv0mph5MBIkFKeqLzQdMeifasIDEGLDrt24xpusYEAE4Zq1TlXAdKETFUCaxfuMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JgpzXTXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JgpzXTXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555571F00A3A;
	Wed, 29 Jul 2026 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323860;
	bh=WaaMeQ7EHWnAjJLmYYdWNJ6LFcvLQS75nfYV9/C16RM=;
	h=Subject:To:Cc:From:Date;
	b=JgpzXTXcQisHMUoQB4ftyMKH4D/zUn3gdFiDBJYkxeg65SnylgZyOgBCFooCObI2z
	 jWtt7CoBUIw9KhUe7n8nr8A/hINnU3kSzC8rjFEx7P5DSYUwz7Ej6Pfg8rJxlNRnnJ
	 6TbNTlpnT4qmAEw0Z14V6XHN5Qd1+/pC5N3fietg=
Subject: FAILED: patch "[PATCH] drm/i915/hdcp: check streams[] bounds before overflow" failed to apply to 6.1-stable tree
To: jani.nikula@intel.com,anshuman.gupta@intel.com,joonas.lahtinen@linux.intel.com,martin.hodo@intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:17:17 +0200
Message-ID: <2026072917-oversleep-unawake-5cba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bbb15a6b042d02e5508a02b4847e02d2579ee7bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-oversleep-unawake-5cba@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbb15a6b042d02e5508a02b4847e02d2579ee7bc Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 25 Jun 2026 20:03:04 +0300
Subject: [PATCH] drm/i915/hdcp: check streams[] bounds before overflow

The data->streams[] overflow check is done after the buffer overflow has
already happened. Move the overflow check before the write.

Side note, emitting a warning splat with a backtrace might be overkill
here, but prefer not changing the behaviour other than not doing the
overrun.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: e03187e12cae ("drm/i915/hdcp: MST streams support in hdcp port_data")
Cc: stable@vger.kernel.org # v5.12+
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260625170304.1104723-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 9284ab3b6e776c315883ac2611283d263c9460fd)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e88fec24af49..521786a75c42 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -145,6 +145,9 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 		if (!new_conn_state || !new_conn_state->crtc)
 			continue;
 
+		if (drm_WARN_ON(display->drm, data->k >= INTEL_NUM_PIPES(display)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
@@ -155,7 +158,7 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(display->drm, data->k > INTEL_NUM_PIPES(display) || data->k == 0))
+	if (drm_WARN_ON(display->drm, !data->k))
 		return -EINVAL;
 
 	/*

