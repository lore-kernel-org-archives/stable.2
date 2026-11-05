Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887094;
	b=Be7ySYfPNyEa+wUb8oJKhsxRb8gmr7NRescdDGtgPwpL/PbSgBWVZjZbv7EM1YC6rSRn
	 hbvJguzq/1OpxlIPwF4/GraC+v/MPpo6VYYG+Yror8S19UYGZA5b/I6IhyoNTxd8MRq5V
	 /Uw1ArA9JQnzHRag3F1gkc1L42jnBK5AhqX8v5cZ1OPQKdlBmo0dOUZLDMidYGhCP+vmB
	 XAEzEhu+c8cWY74i1bLfQw36UJOJxG7RGLeaF2/k8iTLRxxe48eJ1eUxVL8r6IqqJiuj4
	 Isydz+whvtSTaquKdFO9X3lwunBMW0THNQhsMm7PeqvIRF+wuaZesZMpmxCfsB6RX0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887094;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Agsm+Coa6LwlQ0CbapgWLxU9tKEb2Aqeb/DbVdUUjxU=;
	b=iRXPrxHc1oh5j5BTIt9TyklDY7jMtoanQ+PILDXhoBjTKy4Ql7fljEHB6slRsxpLHG9k
	 C2AYspxQbo7mOTC9LM8XRmCj+vnivpb1/RWuS53Cn8989+X6lhLB7Su9axU9DHEE+wqby
	 BVWD+qyFk8LQgBJMa4vR+I84ekVaIoeBJHInXXC8JflDVSCy3vrOy9UOZsPFzx9DHFf6A
	 laEHWjNzvNG+D9daxdUNzfO8HUS2Z5TnpIBRiZ0DHd+MBIuZwj0F1WQQYXteadODn4usP
	 gznQ3LdKa1Vk6Jt5eQnhWZ9E4swPAg44uJLacJgko8pOkcxBq0AKiOQHIpPMN+MRCtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAE606A333;
	Thu,  5 Nov 2026 13:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFAE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3mf6V4lz5B0ss;
	Thu, 05 Nov 2026 21:58:10 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A5DvwLh060233;
	Thu, 5 Nov 2026 21:57:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:58:00 +0800 (CST)
X-Zmail-TransId: 2afa6aec8b68d24-dd46d
X-Mailer: Zmail v1.0
Message-ID: <20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn>
In-Reply-To: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn
Date: Thu, 5 Nov 2026 21:58:00 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IHpuczogcmV0dXJuIHRoZSBuYW1lc3BhY2UgbG9va3VwIGVycm9yIGZvciBJZGVudGlmeQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A5DvwLh060233
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:58:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B72.000/4jL3mf6V4lz5B0ss

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_execute_identify_ns_zns() jumps to the done label when
nvmet_req_find_ns() fails, and that label unconditionally overwrites
status with the result of nvmet_copy_to_sgl():

	status = nvmet_req_find_ns(req);
	if (status)
		goto done;
	...
done:
	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));

The identify command has already been checked to transfer exactly
NVME_IDENTIFY_DATA_SIZE bytes, so copying the zeroed id_zns always
succeeds.  An Identify command with CNS 05h and CSI 02h for a namespace
that does not exist therefore completes successfully with a zeroed
identify structure instead of returning Invalid Namespace, hiding the
error from the host.

Return the lookup error directly.  The other error paths in this
function already use the out label.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
and CONFIG_BLK_DEV_ZONED.

An Identify with CNS 05h and CSI 02h for a namespace that does not
exist (NSID 100) completes successfully and returns a zeroed structure:

  unpatched                            patched
  ret=0, all 4096 bytes zero           ret=24587 (Invalid Namespace)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 92f5c1435582..cea05b4bc740 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -108,7 +108,7 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 
 	status = nvmet_req_find_ns(req);
 	if (status)
-		goto done;
+		goto out;
 
 	if (nvmet_ns_revalidate(req->ns)) {
 		mutex_lock(&req->ns->subsys->lock);
@@ -140,7 +140,6 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 		mar--;
 	id_zns->mar = cpu_to_le32(mar);
 
-done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
 out:
 	kfree(id_zns);
