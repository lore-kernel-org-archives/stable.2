Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986831;
	b=HrKNr9aurfWAipjOQo44ZzkehL+pA89+E1cf2y1cn6m5v8CJJ345GnviBQMtGGH5aq/p
	 y9gOb9VWcezD6bmb7qmEogbGWkismrEsquWOAd9s6dkxgNAN07WPm3NCRiCbGiBpDmhNt
	 FNcx7CUYCsgsx83QScumbgkEFhjyV7Dth5v6YOpeyMGs6N5LHo+n12uYTuxUUJvKdEO4l
	 XgF8wuPN7pyvNlXKPTfyhLyW54reQ3HAAto1pNCdSpMQvFSLVSINwkGy316WTpHTDpSVJ
	 sHVvg/MljlQ7B7gEzlPVBbLbSw3l46kCB/P56jfI0L7a04Z2BLmBwxbnVJHICfMTH9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TcG0NDWnd1qx4NHjJ2geX0vpB3W+3NS6fw62BfZR2Sg=;
	b=anj62hte1+fWeiP/hyNsmJAS0OEMeZp32+iK7TGajaz/ORQZvUJaYsNvLO8iFWGO5umw
	 KaFpu01XMH0BMJOUvr0cjouGa3rKAFaxPWidjQO6Lne6qsKSApm2Vs/8MJldBLnM/N24M
	 hcz/YiA2YsVR4KoZU3la2mNxQ0i1Nuut/rR/UHBQhT9KMEuq2vdSnBdmo7/LzWzNJzQub
	 qgc4P1MP4PMSEkJSYgxF9mkqwYbVk5Fsfo3LHwYHU8V4dkbn4VP7lqmQTFjfLLP8FFv44
	 nA2VPkI/31B+oAlnxLY3l2XW3e6y1eRtXuymcjhNuwSi0puc4My49QXsS0/90o7JObA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=J1pCMHlz;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAE606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADAE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=J1pCMHlz
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a5506f09f5so353017f8f.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794986830; x=1795591630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcG0NDWnd1qx4NHjJ2geX0vpB3W+3NS6fw62BfZR2Sg=;
        b=J1pCMHlzygMGJ6Il2w/o8H5Yguspxmg0XuE4eD4XIkUITLHfHqwdvH3L4xXQX26/g6
         1KQyZOOJaGsy4QLmEeARNqUZcJ7XInHG8s+Yncct7Fv+136TyxFoX7ln94wlXtodQb19
         6iJ/zIqq6UNUep4HUSSBV6QS1pXaJIIKwOE0FpcI5RYfpjfD+Hy/F9qrJ2KHVdnD+O5R
         xdqSxPZl4yW+T4YVRZYTelzm/+VHfJpgsmaNvtm+dWvqjKSodjmwhcOaCVmwFCBNdn5g
         zKCQf+a8l7JdjPwNphK8riGWZowUTm5ioU6QOMSHzz9OTaFx6flQjd76uyLpuqkYb6Rf
         1YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986830; x=1795591630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcG0NDWnd1qx4NHjJ2geX0vpB3W+3NS6fw62BfZR2Sg=;
        b=DXpO7SqaxHxsibajPiHlGw1AMHNOTMf06iEBStWTbL+2ctYjx2ItbBY6V8hHMjo2Tv
         IyxWXogk5PpUrcFzXW75zKK9OmiNrueVxoQ8IjEEDD7NMERK7K5qa/GJzAAReY01w2Ux
         gXd7W9SS6wsMMiUS5BFEzrZigbJyWLMDC6kWfDtI16I2PYcW3AfK4JS6ADOwdomxwz7i
         MmzDHjtXKD73UmvXbzNP1wcFJfenHQxbP2IeGKf5h+On40ja8qBtl7uenMtExZAUf+Yz
         amoCb6z2qCDiNO+qnUX3GE+sI6+cql5YmZX1C78gVbsjw75Wo1yjK89UYeMHmYnLDkll
         DiMQ==
X-Forwarded-Encrypted: i=1; AL+hErGWzAXFZm05sYLO2CG3oVkEueWsPrr+7Jj5DMNMsHROSbL/k+rnG1scQbbUBkvI7aLBBjMJZsk=@vger.kernel.org
X-Gm-Message-State: APuU4Z94H+VTNyOM+Sch3/2XtWpioNMqc+Sxcc0gx7lEdOCEiYMgmvAB
	1LNBitfK42Mbaj7Hz6zSg456afSoVGGUGBb5O0HlOyMYyudufUzeXV0sgnnGsOAUc5Q=
X-Gm-Gg: AZFdTZec8Mcw3x0Ii5f3EGs0oeaI05O2meE6GWKw9a4ucwHtwuZxnVMHawtSj/fwcwS
	0ys+zXAYcOlb6L5wsT5KTQ7L4nQOs4gpVSoXyP8KKpWG42PWuD+EHqnl5BKu3/TsFegI5ZV+lRg
	ujQ4zxQmlhDDcgkhmLyQZbuxMjnDxtHEagXUNbHNb55rxRPfJuz0MPIx51mzdfzhDm75SG118YP
	NGAiEpSWUo74Mj69SZOzdtxGA+o56Un152q7+TcRtOe630YYeajVRl9AMhFmpQBaE4syQvJnCHc
	7ONQD8Gp5699xvs/hPNQ5Mra7AiJ0KkqkLBQPj5ow73DAmMSlKFFUkVBVxxnNMJoREoCBYL1fpw
	sF9nmx/l7sCnejhB4FWJINwnUKI8K4dCxLvHoceOByxD+iQHt/6V24MztCCeMH8cbeO1wJ07Fqf
	VDNqQ1DkaujinA1Ua6drfHzjNu5LWHp5SEEGk8zAi/JgMSaCAIDreEATHiLdWPsAKXVvMMw3uZ3
	wB10SCYaLZkMhc9jvvtWwGtCiCpQYqqLStEImYEkZawttYQQifJkh3ZM3eUjJgbBHw3fuDlgbAQ
	5oCn0Yld9oEzEuQzc/72Rw+cl0NmOg4Yinxi0zI3lfsfLdQtPygM97WZCenVA3NukjomJRhYkbG
	tz8eQYU4t0C8=
X-Received: by 2002:adf:e003:0:20b0:48d:f996:1814 with SMTP id ffacd0b85a97d-4a63beaa10cmr2550113f8f.57.1794986829630;
        Tue, 17 Nov 2026 23:27:09 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095f21sm2901099f8f.38.2026.11.17.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:27:09 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 18 Nov 2026 11:26:41 +0400
Subject: [PATCH v2 3/4] usb: typec: tcpm: Leave SRC_VDM_IDENTITY_REQUEST
 whatever the cable answers
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
Message-Id: <20261118-tcpm-soft-reset-sop-v2-3-b6decdc95e66@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3832; i=alchark@flipper.net;
 h=from:subject:message-id; bh=G7XU0xn1rI75RcMPLmwPi+2SgMOdTFOSxMuyPhsEHOE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9DXYNPnZiVsmM3DWsKb8flF4Pv7XqWP2x5TUXftVkW
 FlcEz7q1jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUr/jHyDDtyqPrU96sft02veCzUFqZVdlFl1j3JSIN5yLmbz9476AjI8Nylkq
 F9X/Ftp+X+VNdced32FLN9uN5Ladu6bIu4ncJ6WECAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Only an ACK from the cable plug or a failure to send Discover Identity
takes SRC_VDM_IDENTITY_REQUEST on to SRC_SEND_CAPABILITIES. A NAK marks
discovery complete as if it came from the port partner, a BUSY retries
the request, and no answer leaves the state as it is. The source then
sends no Source_Capabilities until the sink gives up with a Hard Reset,
which cycles VBUS, and after a NAK it never discovers the port partner.
USB PD r3.3 section 9.2.26.2.5.1 goes back to Source_Capabilities on a
NAK, a BUSY or no answer in time, just as on an ACK.

Move on in each of those cases, and after tTypeCSendSourceCap in any
case, so that a request which never goes out cannot stall the source
either. Drop a request still waiting on the cable plug, and its AMS,
when moving on.

Fixes: af8b627046bc ("usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b9146658f6e5..ab7ec5334564 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2745,6 +2745,12 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		break;
 	case CMDT_RSP_NAK:
 		tcpm_ams_finish(port);
+		/* Go on with Source_Capabilities, as after an ACK */
+		if (port->state == SRC_VDM_IDENTITY_REQUEST &&
+		    rx_sop_type == TCPC_TX_SOP_PRIME) {
+			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+			return 0;
+		}
 		switch (cmd) {
 		/*
 		 * The cable is not allowed to respond with NAK so this must've happened over SOP
@@ -2812,6 +2818,11 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	if (port->vdm_state == VDM_STATE_BUSY) {
 		/* If UFP responded busy retry after timeout */
 		if (PD_VDO_CMDT(p[0]) == CMDT_RSP_BUSY) {
+			/* No retry before the first contract */
+			if (port->state == SRC_VDM_IDENTITY_REQUEST) {
+				tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+				return;
+			}
 			port->vdm_state = VDM_STATE_WAIT_RSP_BUSY;
 			port->vdo_retry = (p[0] & ~VDO_CMDT_MASK) |
 				CMDT_INIT;
@@ -3039,6 +3050,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		port->vdm_state = VDM_STATE_ERR_TMOUT;
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
+		if (port->state == SRC_VDM_IDENTITY_REQUEST)
+			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
 		break;
 	case VDM_STATE_ERR_SEND:
 		/*
@@ -5548,8 +5561,18 @@ static void run_state_machine(struct tcpm_port *port)
 		 * Straight from Discover Identity to the cable plug, rather
 		 * than back through SRC_READY after a message from the sink
 		 */
-		if (port->prev_state == SRC_VDM_IDENTITY_REQUEST)
+		if (port->prev_state == SRC_VDM_IDENTITY_REQUEST) {
 			port->upcoming_state = INVALID_STATE;
+			/* Forget the request if still waiting on the cable plug */
+			if (port->vdm_sop_type == TCPC_TX_SOP_PRIME &&
+			    port->vdm_state > VDM_STATE_DONE) {
+				port->vdm_state = VDM_STATE_DONE;
+				port->vdo_data[0] = 0;
+				mod_vdm_delayed_work(port, 0);
+			}
+			if (port->ams == DISCOVER_IDENTITY)
+				tcpm_ams_finish(port);
+		}
 		port->caps_count++;
 		if (port->caps_count > PD_N_CAPS_COUNT) {
 			tcpm_set_state(port, SRC_READY, 0);
@@ -6560,6 +6583,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case SRC_VDM_IDENTITY_REQUEST:
 		mod_vdm_discovery_delayed_work(port, 0);
 		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		/* Go on even if Discover Identity never goes out */
+		tcpm_set_state(port, SRC_SEND_CAPABILITIES, PD_T_SEND_SOURCE_CAP);
 		break;
 
 	default:

-- 
2.56.0

