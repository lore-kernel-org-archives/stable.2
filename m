Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603225;
	b=xYiZFfmJoEEGj5HfFIw49s/LH6RE2iN8gI40zW/YxEub5dSBQCjD/uUk4hr4aKIYNM/3
	 HbpBTCMI261YmooeH2MGytTgX2ex0/2rp1sjjeeyNkppObfGdY4TXXGIVVVVoSjJyAyYO
	 Eo633as5nGNvNWLZKsexvI0NNZUDLThFqbl8BGufdF5g4DOAvkWI3o4a0J4NMKLCoIDo7
	 eMCCsBCi/axMBHkyNR39X8900b1y7QzfLgTHCFGCL/xfaRAtBdX12wr8oGpSbD2aiD0Vo
	 Wt9DQr8DQMvJ4JwDd935Ekwx12N1mgv7Qk4DgdERBoYAI7Dhm6sIcxAAhUfPUdlg+Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603225;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XNAnCf3O6GZwQzAaXCh3vmXbcKDkTdnJ6nz/uBPrygg=;
	b=0ttZOnpYWeKl6I58COTE4QhgqN1ZC/gvoL+hEFzIkTc1kDDDRBsrUSKGtGiEJd6w/drB
	 QdNYwzRaCnImVPh2lVvHYatSCs0mHltRIxesZJnT8rZzhcZb+c0fWUngwykFgHVxTbllM
	 MSrr/S+ye6aUa6ibt1B/9Pow7etMahenQuyCmVhjbuYUBa1AUPJ1qP97Fe+kTDKmxSW6P
	 ikAkh4gohu/usA+MgnYgBrKLdpNZEp9zGajNlOCianGy/aOurI9Efl5NbbxvmjBvWAbKP
	 sjmGJNx5J01FCdlfrIRRe2OYSguclLdDeGUPcCmTGw4avQ6ViNKPZf1bbHhFa3KypMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gWrJSq67;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE3606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gWrJSq67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D361F000CA;
	Wed, 25 Nov 2026 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603224;
	bh=XNAnCf3O6GZwQzAaXCh3vmXbcKDkTdnJ6nz/uBPrygg=;
	h=Subject:To:Cc:From:Date;
	b=gWrJSq67Qzyht9PinYwMGdwCzaWCGfRWwdMM2Uw+uKUrusG6XSJGxLHvRgMr3qdFm
	 Vm7b75R28obJEHqHZ51RRffmplMXJZvyWUSZGwEr0UKuSInr/fx3qlMnWMu+Z8z9Q+
	 WePaLLXImxCgeHHFs2S0oDuvUGoYgUf0NkeJvowg=
Subject: FAILED: patch "[PATCH] wifi: nxpwifi: guard the 11ax response handlers against a" failed to apply to 7.3-stable tree
To: yhlee@isslab.korea.ac.kr,jeff.chen_1@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:30:54 +0100
Message-ID: <2026112554-preteen-repaying-2352@gregkh>
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
git cherry-pick -x 6a5cf549f4dcbd502db8cd00c5f49d20a2b9648f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112554-preteen-repaying-2352@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a5cf549f4dcbd502db8cd00c5f49d20a2b9648f Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Tue, 20 Oct 2026 09:50:25 +0900
Subject: [PATCH] wifi: nxpwifi: guard the 11ax response handlers against a
 detached command buffer

nxpwifi_wait_queue_complete() clears curr_cmd->data_buf when a
synchronous command is interrupted, but nxpwifi_process_cmdresp() still
hands that field to the response handler. The three handlers in 11ax.c
store through it without checking, so a late response oopses.

Check the buffer first and return 0 when it is NULL, as the sta_cmd.c
handlers that commit 068986fd6f2a5 ("wifi: nxpwifi: detach sync command
buffer on interrupted wait") covers already do.

This is a local denial of service: it needs an interrupted synchronous
command and a late response, both on the local host.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>
Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
index dc1e747383ec..7e9127ae2f42 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11ax.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -205,9 +205,13 @@ int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
 	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
 	struct nxpwifi_ie_types_header *header;
 	u16 left_len, tlv_type, tlv_len;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap;
 	u8 ext_id;
-	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
 
+	if (!ax_cfg)
+		return 0;
+
+	he_cap = &ax_cfg->he_cap_cfg;
 	left_len = le16_to_cpu(resp->size) - sizeof(*he_cfg) - S_DS_GEN;
 	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
 
@@ -346,6 +350,9 @@ int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
 	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
 	struct nxpwifi_ie_types_data *tlv;
 
+	if (!ax_cmd)
+		return 0;
+
 	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
 
 	switch (ax_cmd->sub_command) {
@@ -584,6 +591,9 @@ int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
 	struct host_cmd_twt_cfg *twt_cfg_cmd = &resp->params.twt_cfg;
 	u16 action;
 
+	if (!twt_cfg)
+		return 0;
+
 	action = le16_to_cpu(twt_cfg_cmd->action);
 	twt_cfg->sub_id = le16_to_cpu(twt_cfg_cmd->sub_id);
 

