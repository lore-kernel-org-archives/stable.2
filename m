Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986828;
	b=qZN9SOFABbW5T0Qj7p5+jFd1AEBpK6oob0CyU3AC7k97MIuJKh7RFOJOvj/O8cN07Y0e
	 Tz+EgRqL6DRaX0EO4cp++8fME6hMwvsP0tZz7zX8YQt8hwI3m1empjf4U6mgbV/G+h0eI
	 3s5wEAVPFRoIL6iccAFJUH/Tv3Zgle8PyKZDjj76LSXKGUqkNgma5ezCaijPivGJ44fDj
	 5etClcOaRLkb8QmhIxvPS0Vn9gqok9eH54AlrHqncdPXuknT2TvButryZ8VB+TH7r1uzH
	 /SKfEdLnqbRc7x4WGpAAyzBA1xw3qE4dZ/Z2XXKsFbXCVi/B0pgq/LCqjxpS3G/v/jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IEfLep2EKbzLK5wwOg4/ywwAQ7ECQZqB1AGacSMQjoE=;
	b=qSuKHl9NbJjzoQit+JrUdAXi7gS2tldSxkSaX1Xos+vLeli3xxpYF/B/hFpU680Jguub
	 p/GTdVN6vu+JLYiF++YmYJ/3/K4NIO9zy6AAM+dVt3K8AJf2vjh2QsQ4p5qgP4bXIMJM3
	 M5M9bwER01aeenr6j8iOBGVUbYJjwwNUui1Vxf8q/XJ2g6G2wjBGnuWNHk3ZmYKEQJEba
	 JuyfX4NyanmHZw1LKVvFwRRHocTOHvyGsW04nfwq27r6mv2/dFLsusW5BVnZFTJXLPCkv
	 KMSyensOVpQ9zOFM0yj5Ovdcy7PZOYWrgy6Fnom8m77XxUgNfUQmUiT0UovmOFDXjLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="tpx8Mqt/";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CE606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9CE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=tpx8Mqt/
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-49412eb1474so295066f8f.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794986826; x=1795591626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IEfLep2EKbzLK5wwOg4/ywwAQ7ECQZqB1AGacSMQjoE=;
        b=tpx8Mqt/VsXQddxf19gFW3u+Mg5sf6PNfwh3Kapd6e7ORRC/4ZFjeGEzONFb9lKret
         M6NIIgn1Buz2M/IsdpPPtUhczLk4VIXMKnuI2lq5iptsV7uc+jF+LwGnS7aVZMDdULkg
         pCwDTvfgcITwoS2cGYE8GlK/K9nUzt1nOcTyY4my3+aNzdouxejtULwEgzGR1g/i8qIS
         mg6Xy60cnzHZlQ+OzxF2LsWIiDTxfXTLnQUYSuBEwhWiQfTV65iDldjpsv35LPnJjPt8
         NNLosC+UsoVuX03KfJ72qH0Suer13g6JL3a6Sqc7P1mEb2KXSLAvXSUmYxR2rv/YCEcl
         NR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986826; x=1795591626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IEfLep2EKbzLK5wwOg4/ywwAQ7ECQZqB1AGacSMQjoE=;
        b=bHVxfTdi6J6UuVmjO50kb+6u4QcwLY9wnlKGX1RMjlh89dtTvvLTpqCeXiYDXHwTCQ
         Du9YV3lwIy6fEnqwEggW9my3xBxTXUN5rEo87XgogVtOqRQP3LFZSWILtbUxpA9ZTWuM
         9l3/l4JCUs7cCWelUic7RVEhRUwGujPwg4b+0WrBqTX5ktaC7KGDLfqaAMWMzGSUfh9x
         oUCBN9R9/hBAExNWuXaHINtbt9gDhnUFkUY3eqwV5gTJE1reR+9jDsY/AKH4MJGP3Dls
         G2Qw7e67DKNLxn5/0gqV1t/nyuDaqfEEGerbA7wo/xLGjSgOseM7rQvLrVnOarW270+O
         WYbg==
X-Forwarded-Encrypted: i=1; AL+hErGYAONXNXZ7oJsyU2qcJBpgAF6eqvwEQgcZHjxB9Nh2pfoZquSWTMNcpPuRhRQRCye9Ac/w3xk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8v1ua/oPzhzmA+QJF1bpMlBJG3n1X3Hiy0unoV5I7hkFIc2B3/
	6JGgDxVWvJdoZWdm/8n1UpTgY+WXYywIEkXm/ThBiaYSqu5HCunyPF8my/xF7Q7PozE=
X-Gm-Gg: AZFdTZfUl8tBmy3ELSwCtyA9LthOj3q2dR7VbSsNVq+iW03QqM+N2jTEpu+tgssmLGh
	hbMny1KGxpB8yGUeMlFj0jAIJpKMKCZ0omL13ajcEARFC7+d1vmSMMY+O+VKus4FQpGWlUDbc9x
	wsLaQiPlSF1VnvxKYIW8QJRMHdLVAD2hu1UfzQbLRrc8fSjARqzZrpLKHJRltttrTrOXqSFbTCm
	X+uL2sLFhO3N81S8zHluaRj6ejpOUtdxjN/VYdKHBfJEqQHnhe9Q2Yc693WgbN+X2cNrSmfJJqh
	w4POMGS8WELM1BL9zOLftk5/YOyHcpQFA1BZ2R3IflABrlxEqBTu+NcIrJRiJI0M+TP4KIZlZk9
	Gmkg92WogxOnXe64tJcbm8adUXalISyxWvufITC5gVkCW8RNrcgUzSPXcAxIq7tTPgsijLQMm05
	5qzGa7rfpPIcNumEqFOxt9uFs49Xuv2bnFkQx4WuW0wg3Fyv9IOsUWpsj/87RXL8l83/ecPQ0sn
	ILKohSeXuWyYp/qlHaffsDC856RswhMsb71UpFKiUUQVBzLtudAe3dOZk8OIMEJjUX++tiK3xDQ
	zpSDR/BEunb+oghQ1q0tpR9QX4b8wj+LMEFctyXtq8BvVzO44v06pvdqMJTxebFP5XSze/9qeXD
	/rJnVt1gVOw==
X-Received: by 2002:a05:6000:4812:b0:494:6f49:246d with SMTP id ffacd0b85a97d-4a63b9d9b27mr3480382f8f.24.1794986825807;
        Tue, 17 Nov 2026 23:27:05 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095f21sm2901099f8f.38.2026.11.17.23.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:27:05 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 18 Nov 2026 11:26:39 +0400
Subject: [PATCH v2 1/4] usb: typec: tcpm: Keep the Soft_Reset target apart
 from the VDM one
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tcpm-soft-reset-sop-v2-1-b6decdc95e66@flipper.net>
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6130; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rXiocxvuACvVzl/cb4g2FqTc2srJ3wIGGcgRP+Lz7wI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9DXatkPBw2bjMT9Tyz9M7mm2nd+lNqHzu/E/zeBe3X
 PXlr/tLOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjq8OsM/+wj3AW595VYH3mk3V8myWObPF3lA5dV4tE1686v5Q/0i2b4K+jg2LK
 TaVODe5fenU4Fp8xChXfuwbkfJOY1Njv8jXrKBAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

tx_sop_type holds the SOP* of the VDM being sent, for its retries, and
SOFT_RESET_SEND also reads it to tell a Soft_Reset for the cable plug,
after a VCONN Swap, from one for the port partner. Nothing sets it back
after a VDM, so once a VDM has gone to the cable plug, such as Discover
Identity on SOP' before the first contract, every Soft_Reset meant for
the port partner goes to the cable plug instead. The cable plug accepts
it and the port goes back to its ready state, but the port partner never
sees the Soft_Reset: a source whose Source_Capabilities got Not_Supported
is then left without a contract. The VCONN Swap, in turn, overwrites the
SOP* of a VDM that may still be pending. This left a FUSB302B-based
source without a contract until it was unplugged, after its partner
missed a message following Discover Identity to an e-marked cable.

Keep one target per context: vdm_sop_type for the VDM and its retries,
and soft_reset_sop_type for the next Soft_Reset. Point the latter at the
cable plug only for the VCONN Swap, only once, and back at SOP whenever
the protocol layer starts over or a Soft_Reset of the port partner
starts, along with the SOP' MessageID counters.

Fixes: 6bd181ba60e1 ("usb: typec: tcpm: add control message support to sop'")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bb90211660ca..8c5be904d772 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -675,12 +675,13 @@ struct tcpm_port {
 
 	/* SOP* Related Fields */
 	/*
-	 * tx_sop_type determines which SOP* a message is being sent on.
-	 * For messages that are queued and not sent immediately such as in
-	 * tcpm_queue_message or messages that send after state changes,
-	 * the tx_sop_type is set accordingly.
+	 * Messages that are not sent right away carry their SOP* separately,
+	 * one per context so that one cannot redirect another:
+	 * vdm_sop_type for the VDM being sent, including its retries, and
+	 * soft_reset_sop_type for the next Soft_Reset.
 	 */
-	enum tcpm_transmit_type tx_sop_type;
+	enum tcpm_transmit_type vdm_sop_type;
+	enum tcpm_transmit_type soft_reset_sop_type;
 	/*
 	 * Prior to discovering the port partner's Specification Revision, the
 	 * Vconn source and cable plug will use the lower of their two revisions.
@@ -2003,7 +2004,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	port->vdm_state = VDM_STATE_READY;
 	port->vdm_sm_running = true;
 
-	port->tx_sop_type = tx_sop_type;
+	port->vdm_sop_type = tx_sop_type;
 
 	mod_vdm_delayed_work(port, 0);
 }
@@ -3065,7 +3066,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		} else {
 			tcpm_ams_finish(port);
 			port->vdo_data[0] = 0;
-			if (port->tx_sop_type == TCPC_TX_SOP)
+			if (port->vdm_sop_type == TCPC_TX_SOP)
 				break;
 			/* Handle SOP' Transmission Errors */
 			switch (PD_VDO_CMD(vdo_hdr)) {
@@ -3102,7 +3103,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 	case VDM_STATE_SEND_MESSAGE:
 		/* Prepare and send VDM */
 		memset(&msg, 0, sizeof(msg));
-		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
+		if (port->vdm_sop_type == TCPC_TX_SOP_PRIME) {
 			msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
 						  0,	/* Cable Plug Indicator for DFP/UFP */
 						  0,	/* Reserved */
@@ -3119,7 +3120,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		}
 		for (i = 0; i < port->vdo_count; i++)
 			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
-		res = tcpm_pd_transmit(port, port->tx_sop_type, &msg);
+		res = tcpm_pd_transmit(port, port->vdm_sop_type, &msg);
 		if (res < 0) {
 			port->vdm_state = VDM_STATE_ERR_SEND;
 		} else {
@@ -5529,6 +5530,7 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id_prime = 0;
 		port->rx_msgid = -1;
 		port->rx_msgid_prime = -1;
+		port->soft_reset_sop_type = TCPC_TX_SOP;
 		port->explicit_contract = false;
 		/* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
 		if (port->ams == POWER_ROLE_SWAP ||
@@ -5801,6 +5803,7 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id_prime = 0;
 		port->rx_msgid = -1;
 		port->rx_msgid_prime = -1;
+		port->soft_reset_sop_type = TCPC_TX_SOP;
 		port->explicit_contract = false;
 
 		if (port->ams == POWER_ROLE_SWAP ||
@@ -6193,6 +6196,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SOFT_RESET:
 		port->message_id = 0;
 		port->rx_msgid = -1;
+		port->soft_reset_sop_type = TCPC_TX_SOP;
 		/* remove existing capabilities */
 		tcpm_partner_source_caps_reset(port);
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
@@ -6210,6 +6214,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_SOFT_RESET:
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
+		port->soft_reset_sop_type = TCPC_TX_SOP;
 		port->upcoming_state = SOFT_RESET_SEND;
 		tcpm_ams_start(port, SOFT_RESET_AMS);
 		break;
@@ -6220,7 +6225,8 @@ static void run_state_machine(struct tcpm_port *port)
 		 * A Soft_Reset Message Shall be targeted at a specific entity
 		 * depending on the type of SOP* packet used.
 		 */
-		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
+		if (port->soft_reset_sop_type == TCPC_TX_SOP_PRIME) {
+			port->soft_reset_sop_type = TCPC_TX_SOP;
 			port->message_id_prime = 0;
 			port->rx_msgid_prime = -1;
 			tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP_PRIME);
@@ -6439,7 +6445,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case VCONN_SWAP_SEND_SOFT_RESET:
 		tcpm_swap_complete(port, port->swap_status);
 		if (tcpm_can_communicate_sop_prime(port)) {
-			port->tx_sop_type = TCPC_TX_SOP_PRIME;
+			port->soft_reset_sop_type = TCPC_TX_SOP_PRIME;
 			port->upcoming_state = SOFT_RESET_SEND;
 			tcpm_ams_start(port, SOFT_RESET_AMS);
 		} else {

-- 
2.56.0

