Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028123DDB0A;
	Wed, 30 Sep 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761680; cv=none; b=ovHUmopMjbeI0XbuVQlgKdfQfCqFCuDu5vO9xDgDF+n7U1rXGUMPPQDQWgnUNiokrfsloXW9naRib3SrevtkMJkCMnoKFQVugAHeMFEvM7ch8K3uYyOWRgBQMVLG/otZXSSOC+vVQs9rMx8lUDVP3LVC/pawZ7gLRCfWHq50eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761680; c=relaxed/simple;
	bh=B7sU+JYKVX69Tn8BilhYZIlgBnfPnitcXAXiwOWYmds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BXpwURqWPCFzTdaBvMosMGZbkZABGmX2/rBcTxCFlByCyxYijGWAM6JskNJKcMBSy2gHvp6eL7vMm2XoS2PRaLPXo0buz0qlUiunLCUg4WT4iVwKx5ggQZgtrl9FiWHMgKpaaL2hQlDXs3C0nYQwKHCwliStEstaPFocY6i5Fhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 010f6dbebcb411f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4f68d59d-f336-4019-998e-c8b25ca05050,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:e81a37adf8bbab61fd4706f2095968cd,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 010f6dbebcb411f19a56ed5b684f684d-20260930
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2083579561; Wed, 30 Sep 2026 17:47:52 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com,
	weirongguang@kylinos.cn,
	zhangyunfei1@kylinos.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH net v3 0/2] net: ngbe: fix error handling in resume and open paths
Date: Wed, 30 Sep 2026 17:47:46 +0800
Message-Id: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two error-handling fixes for the ngbe PM/open paths.

ngbe_resume() declared err as u32 and returned 0 unconditionally, so a
failed ngbe_reset_hw(), wx_init_interrupt_scheme() or ngbe_open() left
the device in netif_device_detach() state with a broken interrupt
scheme while the PM core was told the resume succeeded; the reset task
bails out on the missing netif_device_present() check, so the device
cannot self-heal. Patch 1 fixes the type and propagates all of these
errors, making the whole tail of the resume path consistent with the
pci_enable_device_mem() failure path at the top, which already reports
its error.

ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit to tell the
management firmware the host has taken over the port, but no error
path cleared it, leaving the firmware owning a port whose rings and
IRQs are gone. Patch 2 rolls the bit back on all open error paths,
matching ngbe_close() and ngbe_dev_shutdown().

---
Changes in v3:
- patch 1: set WX_STATE_RES_FREED on every failing return of
  ngbe_resume() (the pci_enable_device_mem() failure, the hardware
  reset failure early return and the wx_init_interrupt_scheme()/
  ngbe_open() failures), so that a later ngbe_close() (ndo_stop or
  unregister_netdev()) skips re-running the teardown on the
  already-freed post-suspend state instead of freeing IRQs that are no
  longer requested (Sashiko review of v2);
- patch 2: correct the Fixes tag to a1cf597b99a7, the commit that
  introduced the bug (the first ngbe_open() failure path after the
  DRV_LOAD bit is set; v2 pointed at e7956139a6cf, which added more
  failing returns but not the first one); no code change.

Changes in v2:
- also propagate the ngbe_reset_hw() failure, so the whole tail of
  ngbe_resume() reports errors to the PM core (Sashiko review of v1);
- drop the inaccurate "device can be re-probed" claim: the PM core
  records and logs the failure, there is no re-probe (Sashiko review
  of v1);
- patch 2/2 unchanged.

Link: https://lore.kernel.org/netdev/20260922100836.1147718-1-zhangyunfei1@kylinos.cn/T/#u/


Zhang Yunfei (2):
  net: ngbe: propagate resume errors to the PM core
  net: ngbe: clear DRV_LOAD bit when ngbe_open() fails

 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.25.1

