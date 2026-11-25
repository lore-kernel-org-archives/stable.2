Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603227;
	b=ZWO9+ZLwyIGIWsgwU+Ksga2mmQSKAQ3XSUTGoGjX60ifOkAerAlgeFZ1aEo1/qqUSRr7
	 59D5KPHvub0LP5/hlBLxmvev8VlGSx2YW++I7pqkM1PKwy1iBN1xahVSuJYs6nHLf0MuS
	 Ea6j5jtWflVE7Ij8q+wUJpRNbhd5rB7lOf6w5ZzHlde33z6UyRhxmlpN5ZzStLt6hRvyq
	 NoedFpmdlEEaV/eT5U4ccZIXxaLqH26Vm9+nQCLBEDLsW6sTHI6rcWZhqiRRlO1Ez9poI
	 VVFhXM+CGqICG2SgUjVAqCAHI6pxUE0bieBCEtJPpeBBTfTFOlWZs+AxNRLq5WcJq2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603227;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QvNLUmpbFzJyg6bfsdf1UZ6Vbf0rGlqsLLyVsvVftW4=;
	b=SjWQLcPOKjCx7GkUouaA8OqKV8tfnwvWPFDBakdTbWOvY9j3Rt9VXvrQRzuNGuUbGeMU
	 uVt/kuORe7pBYZHOEHXSqvIiBgoX4yHZVz5+pUrUYrousCxvw9GmxuqdpmsTSWWw11LTX
	 4kTHezcclvNhOu7nDlzWSSxAkOp2pjSECFQSXA9IJZi6HGOUEX8wvHJZJBn2SY1pO29gL
	 N+HGmfmHkHjdKgl1f3PVhCledXtgYqTpDmit5oOQhPov+Y8kcti/8nRDv1gYvfHRdqErM
	 88npEnVwWXa6jSRr6xuGSpXQJdpHmCGpAYaIogExQMyCh52wKJooDcYbHPFCqGVA1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WaKO98V3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F1606A685
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WaKO98V3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB1F1F000CF;
	Wed, 25 Nov 2026 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603227;
	bh=QvNLUmpbFzJyg6bfsdf1UZ6Vbf0rGlqsLLyVsvVftW4=;
	h=Subject:To:Cc:From:Date;
	b=WaKO98V3IH8fcJtPxFrTlabpf28ElrNsMC2IsnNhj5CnSSvHgZGTnIk1u/vRHSa1W
	 +H7f2HByeBQ3aqM1ThbcvOhg7Zanatnaj0SmHTA1BHRCFBuWq3PAkZ2X6spWoq9HIV
	 Yx3dUBgMzOd2pEvR+EiHM5ZCmRH4W18xThlyE3eA=
Subject: FAILED: patch "[PATCH] wifi: nxpwifi: read the 11AX_CFG extension ID at the right" failed to apply to 7.3-stable tree
To: yhlee@isslab.korea.ac.kr,jeff.chen_1@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:30:58 +0100
Message-ID: <2026112558-amino-egging-2000@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1cb78390d1c6c7908ab9838238a702799e0f7e9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112558-amino-egging-2000@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cb78390d1c6c7908ab9838238a702799e0f7e9f Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Tue, 20 Oct 2026 09:50:26 +0900
Subject: [PATCH] wifi: nxpwifi: read the 11AX_CFG extension ID at the right
 offset

The send side writes the extension ID as the first payload byte of the
TLV in nxpwifi_cmd_11ax_cfg(), but nxpwifi_ret_11ax_cfg() reads it one
byte later and copies the HE capability from the same wrong offset. The
capability test runs on the wrong byte and the copy reads one byte past
the declared payload.

Read the extension ID and copy the capability from the first payload
byte. A zero-length extension TLV has no payload to read an extension ID
out of, so skip it.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>
Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
index 7e9127ae2f42..16bda167fa66 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11ax.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -219,13 +219,13 @@ int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
 		tlv_type = le16_to_cpu(header->type);
 		tlv_len = le16_to_cpu(header->len);
 
-		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
-			ext_id = *((u8 *)header + sizeof(*header) + 1);
+		if (tlv_type == TLV_TYPE_EXTENSION_ID && tlv_len >= 1) {
+			ext_id = *((u8 *)header + sizeof(*header));
 			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
 				he_cap->id = tlv_type;
 				he_cap->len = tlv_len;
 				memcpy((u8 *)&he_cap->ext_id,
-				       (u8 *)header + sizeof(*header) + 1,
+				       (u8 *)header + sizeof(*header),
 				       tlv_len);
 				if (he_cfg->band_config & BIT(1)) {
 					memcpy(priv->user_he_cap,

