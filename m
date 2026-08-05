Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76B40A93E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923259; cv=none; b=unxUO4iMOaExQQ14jHfGQas7sElhIX4Wt9UcclnKxOpdWfSt5HPfYbzIms0Qgt+lKBRh54psks2KAZh8oQYDbgdITINIt1S2G+1EZ2Us3ituHkjEaPIx4ftlkZoijVg5glDTXzzkAwAh/LkKO2UCLK25w79FhRtXSZEkzo7t/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923259; c=relaxed/simple;
	bh=RSSOb66sezFBpLoVdGXg7vJypRNXR4e4MvzB37/m2QQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V6x66o9c77g0qy4QUjkjNUuvi0VpJwD4P7ZAK7AcwMs9i5zQVRPmaaCnG9DRh983cgs9D+OY3i0X7wxdHMtpgXvnTG/pxkRO+cSkZJtwpAxvfOCN5c81X0qbsS0QffwUulkTdh/04X2tv/QjZjqgwekq5TCfynxpGl9nJwTOJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBnmPAJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBnmPAJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F4A1F000E9;
	Wed,  5 Aug 2026 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923257;
	bh=lH0E0Vfa3JHnv/U+afQocQ1hvgkmu6axak17yXcq+fc=;
	h=Subject:To:Cc:From:Date;
	b=zBnmPAJoVdyNa5aeCvApC9pQCwaY/Y7vRE0vRGD4zdRX+9SdwFJgBuHZo4I83zjtc
	 P3tG7sRQoJ4WFnHuV/03hlNslRi52LdkxI0YTCDMc4J8dYZ1+JBIlIOTpiKmNDY32Q
	 IhpeyYsyg9/iszeJ+V6i0DMWFuXLG9fjx/TtMq2o=
Subject: FAILED: patch "[PATCH] igc: remove napi_synchronize() in igc_down()" failed to apply to 6.12-stable tree
To: devnexen@gmail.com,anthony.l.nguyen@intel.com,dima.ruinskiy@intel.com,maciej.fijalkowski@intel.com,moriyax.kadosh@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:47:21 +0200
Message-ID: <2026080521-shredder-gawk-b169@gregkh>
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
git cherry-pick -x 5ffab5b9589c50e4cfc0cf36ffd76c89422d4019
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080521-shredder-gawk-b169@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ffab5b9589c50e4cfc0cf36ffd76c89422d4019 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sun, 12 Jul 2026 14:22:42 +0100
Subject: [PATCH] igc: remove napi_synchronize() in igc_down()

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..b3883a5a7d7a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 		}
 	}
 

