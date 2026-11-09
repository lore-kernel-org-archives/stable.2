Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236369;
	b=PljcAF2soDR4ViPIvelUvSRN4jxRqBzFmRTGSS5rAuqCmM27du5tDiwo1xs2sJ5rvaJs
	 +8oxw/qvC35qnOegdMC8ObyUuzp8DbDCd9pK12ZWOaefn6GSHMK9bnth2b28y867p7YQ6
	 dMNakoxZy+H/qVk0RusyCHq6V4A7nOJcXS8/aIBXlrwp63/gcH2NiCE02tUMnPGGNirct
	 CsTmXnliTPZglG8QdBNHKOX2awy+YfTJoNtwzQX8ANPA1Lq3FalAKKuodCbsORV7PPBfl
	 ayB6eIz2SVnpTucObi3SjtHvGnPgb+t0oD9viUwlv5aVT4nJWMjeI7fvQQoPtfLYtzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236369;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=9kBySGtA1zaIj96oeS4c/VdA6rY+Dd0IQx9SYvPX/3w=;
	b=uFS83zjIewV0Ujguxdayc4Ee9B3v1neyYgwvK6cCpia1WX/aqsPs8odBDr4d3EEEupNP
	 4iq2CghU30P1Q+OPKyVzGRCAZrAfBaLlmgyodC9AOqDdKJ0wli+MWfZxZJtGy0XFMIdSD
	 KVIkMxi7ilQ5wJ3oi1mWXf4P7Nv5oUgM8PB4+Ww2c2Tjq/UebBQHBo6EzyH5WUN7L+kWl
	 R/e4fZy2L7aihX2+bqzcYTe2uJ4iMliL/lJ78IsY6Sh6ZmOhhwWt70pnOkY6y9NPIP7kS
	 DSEmhC5FgcWIK5Fw+pKxBLG7CkaY3JKdjzGfZv02MUjMjl6sLM0X3Nb/4lwS2nr30Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="d/rES4bt";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C3606A33D;
	Mon,  9 Nov 2026 14:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A4C3606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=d/rES4bt
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNXxW2qZ2z5BNRx;
	Mon, 09 Nov 2026 22:59:27 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794236367;
	bh=yUf9ZiOFIeuL9xUq1c7xwo9e4Y8iMnWWs2GPorLm9fE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=d/rES4bteGhWVCpXyIKFkpq7l+ECyto7R3zWHoPCxmk+YN7kQMlE4CffoeR5JpMIU
	 NrCbVwVPUuUSZ711O+YBB4v+EO41yMfwlA8h40wVx56uD084UEMaDf5PyFf1jLMJzF
	 b0LNvaLCrmP2mJvp7RNXTIKkposwJgjFAkObQfNFqHd0ziYBpUGSplvap++NGUO6B2
	 qqAEPWCSNNxaisXDIXF+26Uf+2tydYmNbKitWBfLhAVTsz9kkrC8obCNHoThznfgz0
	 CpfvZgW21lueRlxcHjoCC2eFPq2BvX2FfbzhsvHKAwppSwPO6HdwnRIl90XuWxnH+F
	 /V0fo2kkC5pKw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A9ExHnq067559;
	Mon, 9 Nov 2026 22:59:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 22:59:21 +0800 (CST)
X-Zmail-TransId: 2afb6af1dfc99bf-69794
X-Mailer: Zmail v1.0
Message-ID: <20261109225921056-4eg0BGEufMgtHypJbPmM@zte.com.cn>
In-Reply-To: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
References: 20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn
Date: Mon, 9 Nov 2026 22:59:21 +0800 (CST)
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
Cc: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQtYXV0aDogc3RvcmUgdGhlIERILUNIQVAga2V5IG9mZnNldCBpbnN0ZWFkIG9mIGhhcmRjb2RpbmcgaXQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A9ExHnq067559
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 09 Nov 2026 22:59:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1DFCF.000/4jNXxW2qZ2z5BNRx

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_auth_set_key() accepts variable-width hash identifiers, but
nvmet_setup_auth() always skips ten bytes before extracting the key.
For "DHHC-1:1:" this starts one byte past the allocated string's NUL
terminator, causing an out-of-bounds read in nvme_auth_extract_key().
Other nonstandard prefix widths also select the wrong key bytes.

Use %n to validate the complete prefix and record its actual length
for both host and controller secrets.  Keep the offsets as int, matching
the scan result, so whitespace or leading zeroes in the hash identifier
do not truncate the saved offset.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with host and
target DH-CHAP enabled.

Configuring the same 9-byte secret for the host entry on the target and
connecting makes nvmet_setup_auth() read past the kstrdup'ed string:

  unpatched                            patched
  KASAN slab-out-of-bounds in          malformed key rejected,
  strlen/strrchr, nvmet_setup_auth     connect fails cleanly

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 574025730834..e0fc257ab90d 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -24,20 +24,24 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 {
 	unsigned char key_hash;
 	char *dhchap_secret;
+	int offset = 0;
 
 	if (!strlen(secret)) {
 		if (set_ctrl) {
 			kfree(host->dhchap_ctrl_secret);
 			host->dhchap_ctrl_secret = NULL;
 			host->dhchap_ctrl_key_hash = 0;
+			host->dhchap_ctrl_key_offset = 0;
 		} else {
 			kfree(host->dhchap_secret);
 			host->dhchap_secret = NULL;
 			host->dhchap_key_hash = 0;
+			host->dhchap_key_offset = 0;
 		}
 		return 0;
 	}
-	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
+	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
+	    !offset)
 		return -EINVAL;
 	if (key_hash > 3) {
 		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
@@ -52,10 +56,12 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		kfree(host->dhchap_ctrl_secret);
 		host->dhchap_ctrl_secret = strim(dhchap_secret);
 		host->dhchap_ctrl_key_hash = key_hash;
+		host->dhchap_ctrl_key_offset = offset;
 	} else {
 		kfree(host->dhchap_secret);
 		host->dhchap_secret = strim(dhchap_secret);
 		host->dhchap_key_hash = key_hash;
+		host->dhchap_key_offset = offset;
 	}
 	up_write(&nvmet_config_sem);
 	return 0;
@@ -135,6 +141,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
+	const u8 *key;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -181,8 +188,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 
 	/* Skip the 'DHHC-1:XX:' prefix */
 	nvme_auth_free_key(ctrl->host_key);
-	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
-					       host->dhchap_key_hash);
+	key = host->dhchap_secret + host->dhchap_key_offset;
+	ctrl->host_key = nvme_auth_extract_key(key, host->dhchap_key_hash);
 	if (IS_ERR(ctrl->host_key)) {
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->host_key = NULL;
@@ -200,8 +207,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		goto out_unlock;
 	}
 
-	ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
-					       host->dhchap_ctrl_key_hash);
+	key = host->dhchap_ctrl_secret + host->dhchap_ctrl_key_offset;
+	ctrl->ctrl_key = nvme_auth_extract_key(key, host->dhchap_ctrl_key_hash);
 	if (IS_ERR(ctrl->ctrl_key)) {
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->ctrl_key = NULL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d7804bf91aaa..6a17cd9ee0a9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -400,6 +400,8 @@ struct nvmet_host {
 	struct config_group	group;
 	u8			*dhchap_secret;
 	u8			*dhchap_ctrl_secret;
+	int			dhchap_key_offset;
+	int			dhchap_ctrl_key_offset;
 	u8			dhchap_key_hash;
 	u8			dhchap_ctrl_key_hash;
 	u8			dhchap_hash_id;
