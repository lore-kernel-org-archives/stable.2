Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097067;
	b=x8qlwvZT4JCmvFOpUxnoJhYe3A3jRqVp9HfKWsBZXFrcxk2laBDx7VB8CElKuMma0eLI
	 ml45fbaHzEtHKt2+Fihn7VuPnKJI8kSVnWv1xWRO5cohj9RBNzAf6MZNgl6XHg+PvU8DD
	 dI1criDfeh1JBAGtwIDc/4ZjE2eIwZV4Rm4E4MG2Cpcxm33q2OtYj1MuTCwhDUIXaZiqf
	 6nQojt0B5jHffadRlMVT1zCsIX1alyot7WpDpKSs6h2bLh28+xVJ9W6F6F78YbZWUdUcl
	 7t/csKGD6vL0yodmnAK/9qlS/FPogc+0mvzNgMII0gAjvpnHqVpP1wauQRKe/SkBsbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097067;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=t1Kvdj1fq2FNjCpeV0l+yuj6IJcjFbmYA/wXT7o/wU0=;
	b=pdKuERvONvrTS2dREKM/pBPg4lK4RMYVzCDuJydpIiplDVcDBdfZ7aZMp20YF8yrRWtc
	 viHIr4JJaqgfyL6v2K9mBQWnopbekL5GoWi8v3OBNGZxw63U5yFcNBoLvbMf4HvEYqrm5
	 /7Z9TV6DNFBqtustFaG1Y4jv+KM0mtF4Qa/bzpz79U1jyJ7Qdhk+GKTmFjsiz2jTTqCfV
	 31t4Iwe3iONBXCXIGAObHHhlS+dAV7E/aQE6ToEoKkYlPntjeetV2KrrTM548HTcEJQKE
	 k9Wvgtk1jL3UnLCXUDthiykmGK0KZS3JsWbg8YyFwVVM/csw+vkpe2BFMZ6Lknte4vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=iGPKbueC;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E6606A320;
	Thu, 19 Nov 2026 14:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9E6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=iGPKbueC
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jVgFK6K6PzLm1Z;
	Thu, 19 Nov 2026 15:04:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795097061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1Kvdj1fq2FNjCpeV0l+yuj6IJcjFbmYA/wXT7o/wU0=;
	b=iGPKbueCjY2wxQLML5h/lx9tPcHjwk+EuYiOdXDCKGgpttfCFS25fUfz3rHORa8UB07CZf
	Y0THPNUDDNg2cchEX6Y2dIZnkRYyofh/m2LztNsMvtRjjtazFPVcWjIA7tzVCJISrKpI/h
	GDiCK6b6jAOlooQvA+gqSPWyq8M4TevaITcLfzoeDBmq8hhJc1kHjTRpD6ci6uCkf2N46j
	X5rjXckHidhcyFUFPALDCm5ItHDqMKx5FUuK6opbfFU7yEvfm6j6hr7/pmQHfzKJADGvzv
	bT2GHRIwlp09e8YlDB0ntsv8036+hkeyylfCN2NZ0OqBaIbTQphCNTvGhJbYgQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Joe Damato <joe@dama.to>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] igb: link queues to NAPIs under RTNL after runtime resume
Date: Thu, 19 Nov 2026 15:04:09 +0100
Message-ID: <20261119140412.163202-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119140412.163202-1-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jVgFK6K6PzLm1Z

__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
requires RTNL, but RTNL isn't held when resuming from runtime suspend:
this triggers "RTNL: assertion failed".

Link them in __igb_open() only when RTNL is held, and from the work
item that sets the real queue counts on runtime resume. The links can't
be kept across a suspend, because __igb_shutdown() frees the q_vectors.
These are only freed while __IGB_DOWN is set, which is cleared once
they are allocated again, so the work item checks __IGB_DOWN under RTNL.

Tested with the 82576 emulated by QEMU.

Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
Cc: stable@vger.kernel.org # 6.16+
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v3: link the NAPIs from the work item added by the previous patch, and
in __igb_open() whenever RTNL is held (also on system sleep resume);
dropped Joe's Reviewed-by, as the patch changed
v2: no code changes; mention the tested hardware

Note: igc has the same issue: __igc_open() also links queues to NAPIs
(igc_set_queue_napi()) on the RTNL-less runtime resume path. A fix will
follow separately once it has been tested on igc hardware.

 drivers/net/ethernet/intel/igb/igb_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f51edc..6196d7a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4126,8 +4126,18 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	return 0;
 }
 
+static void igb_link_queue_napis(struct igb_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
+}
+
 /* Some settings need RTNL, which isn't held when resuming from runtime
- * suspend: apply them from here instead, if the device is still up.
+ * suspend: apply them from here instead, if the device is still up. The
+ * q_vectors are only freed while __IGB_DOWN is set, which is cleared once
+ * they are allocated again, so checking it under RTNL is safe.
  */
 static void igb_rtnl_resume_task(struct work_struct *work)
 {
@@ -4142,6 +4152,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
 					      adapter->num_rx_queues))
 			netdev_err(adapter->netdev,
 				   "error setting real queue count\n");
+		igb_link_queue_napis(adapter);
 	}
 	rtnl_unlock();
 }
@@ -4220,7 +4231,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		napi = &adapter->q_vector[i]->napi;
 		napi_enable(napi);
-		igb_set_queue_napi(adapter, i, napi);
+		if (rtnl_held)
+			igb_set_queue_napi(adapter, i, napi);
 	}
 
 	/* Clear any pending interrupts. */
-- 
2.56.1

