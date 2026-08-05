Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B03E49EA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923267; cv=none; b=bW2LxxJRsoh2hoQpzupNaonnkOvDFSdASHGTGf3xqGS0dHNyHkWk1nPSLhUfhnoJNa1rppR0vGaC02Gj2oW6l+VhFkqfLCI2hF2YU7iZQcrfN8En03gRjQrFF+Jg/Qk4DnHUxOIEv8/mRxhilusjQByFQcGbEBjgLgInJNWSqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923267; c=relaxed/simple;
	bh=cDLRDXRKeJjc6J8f9ajRplxSYfUtEMjR+ab2FBpRjVY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iYN2mQQ5pnF7LYRbfHHRR1iJnFMS25PGLMuoLL0+A+CM7ZA6BGuFYCeWoRXRo184o8JVgGXHJ/ZPJ7DUTRYqIMFdVlE9rlhx3cEC8724TmJeXlTvGHq+ObnOteeeHCerbVB3lUzDscRl+7sqHwr5rW2EEUIR/o5iwx5s+3NPOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHBQE953; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHBQE953"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B188B1F000E9;
	Wed,  5 Aug 2026 09:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923266;
	bh=cM5uXPHekbeiGB/CQqBi02AmyQPaHbIsnnpPl4l8Kh0=;
	h=Subject:To:Cc:From:Date;
	b=sHBQE953X7KcOh9uKEKTbbK04r0smLRQrWBDF2Kp/vJCFb2utICaXXf4gOtzd2qXa
	 BdmEVAhf1CxjKaZ+LtZvTxXSEkQCxPXlFYXTrHVQpGR4+8t05hdq+Aw2d+PlOjKr8c
	 qtD4cylKtj135kAy9ETojox4GM6BIJ2RyziStwJk=
Subject: FAILED: patch "[PATCH] igc: remove napi_synchronize() in igc_down()" failed to apply to 6.6-stable tree
To: devnexen@gmail.com,anthony.l.nguyen@intel.com,dima.ruinskiy@intel.com,maciej.fijalkowski@intel.com,moriyax.kadosh@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:47:21 +0200
Message-ID: <2026080521-detention-unleaded-97b7@gregkh>
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
git cherry-pick -x 5ffab5b9589c50e4cfc0cf36ffd76c89422d4019
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080521-detention-unleaded-97b7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

