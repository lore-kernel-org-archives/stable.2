Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659384;
	b=2fcnDmmcfZEaneNuivI2QxtSXmg/aWsWKia/5Re/QWZeJ9MfkNBIA7BBLlwEhORPsnf/
	 Eh4nvacQ0ZIh/juGlRMzOF36sZL0yEPPN6qT5TGUhCOgdTtQXz8s4bLoPJJGXVirNJ9VM
	 PxJae2/Nn6YnREBUCsDoU4L0N53mygO3BHcADZ6MiuKDBjvEfYjsw1jwpWkFB9EzLBQ5f
	 hWvzu4KfKS7p4hTGrfVsaPoviEpQ+PH7k6fyjTaROByHOL3DTjRUIxoJTJOO/pjLShdEi
	 YEwEK3oW8kEqk5+V8chU/pXDBnodsO9stNFtZrBYnkysOYFRg1fLQD3NgaJqtwIyqSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659384;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uPDIrhBZZQhYm/jOhRKU4pdro1NOP3kPaXWAAZHnIVc=;
	b=CpwR4njyCa6zOoDu40hXIpGMLZxxsBd4JA7JxUo8cITP9w3fvsehIw+Ws+ysvgTk2IBR
	 4muo4nujUXbkZ1bNVcPevAaJmApkgtUy2bq7EF9WyoXEoJHA6UWXJ+hqqp+Eja8B8bNuu
	 XnE6WFcE3gZIb/KnXdGx/LIN87VAuNE6Y9hI23evT/Lw5u9Ia7ncDaOgnneLB8JAa7K01
	 MSmixvC4Mznq4f5C0bzxEUts4lBWsHH08tbZw04LOxOstM/xUnJSNPx8r109D7tMTOLYE
	 8FEwbfiNZ+UCVcfUBPTG1FBZCyiA5/ZhVZlNGgqsnjt1SqelffjIMKfmn1L9OKRITeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NehphdrY;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1767606A321;
	Thu, 26 Nov 2026 02:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1767606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NehphdrY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=NehphdrYlNJuhK/r3Pgz7mDNHQt6RPkJll3TIxy+8ZS1PPYun3eXPNZIY42GfunhZS+ZdWAJmcK5c
	 0sCASkkkykHR3NQBrS26wGVuMPhnDz/w0Ge5ub26/IQzJqKuQusv6bIeAsfmjYpPOfz0GxbBL00Z+y
	 aR3p5ij53/BkqIdU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76b07966df1d-5720b;
	Thu, 26 Nov 2026 10:16:13 +0800 (CST)
X-RM-TRANSID:2ee76b07966df1d-5720b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86b07966c228-589e7;
	Thu, 26 Nov 2026 10:16:13 +0800 (CST)
X-RM-TRANSID:2ee86b07966c228-589e7
From: guohongyu <guohongyu@cmss.chinamobile.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	alan.brady@intel.com,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: [PATCH] idpf: fix vport_id used as array index in MAC filter async handler
Date: Thu, 26 Nov 2026 10:08:54 +0800
Message-ID: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

idpf_mac_filter_async_handler() resolves the vport for an incoming
ADD/DEL_MAC_ADDR async response with idpf_vid_to_vport(), but then
ignores the resolved vport and indexes adapter->vport_config[]
directly with the raw 32-bit vport_id from the virtchnl message.
vport_config[] has num_max_vports entries and vport_id is an opaque
device-side identifier that the protocol does not bound by it, so
a vport id not smaller than num_max_vports makes the handler read
past the end of the array and use the garbage result as a
struct idpf_vport_config (spinlock taken, filter list walked,
entries list_del()'ed through out-of-bounds pointers).

Fix this by using the software index of the already-resolved vport,
adapter->vport_config[vport->idx], as every other call site in the
driver already does.  The index comes from the vport allocation
slot and is always in range.

Fixes: 41252855df77 ("idpf: add async_handler for MAC filter messages")
Cc: stable@vger.kernel.org
Signed-off-by: guohongyu <guohongyu@cmss.chinamobile.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706973..e72877242612 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3794,7 +3794,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
 	if (!vport)
 		goto invalid_payload;
 
-	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
+	vport_config = adapter->vport_config[vport->idx];
 	ma_list_head = &vport_config->user_config.mac_filter_list;
 
 	/* We can't do much to reconcile bad filters at this point, however we
-- 
2.43.0



