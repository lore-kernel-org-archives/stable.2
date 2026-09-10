Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9C3769FF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006273; cv=none; b=S9cpGpfNktPxNdPFxLTHe1ezd3ymuQktFyeJaRvb4RBeXl0sewYrLOy9l3f9b1rm6J5fsrClJHpLk1Cdilo0P0JNq4mw4RDNsE6Bc2wKsqe7QdjwsMey0reJ/+8BqNOx0JcRfs1P192pPEeQu7FDWAuHFLQDzGCpszdeCSAb2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006273; c=relaxed/simple;
	bh=/+kUvMBC0mBkJUbVYwsecNMn3XwiiK+vVVH/78xk9RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8jSsWlj5M8abeXJH3KHi/ujN7XFYiS74Dd8o9mdOJtj/mr1mueDqz/MFtK+WMKj6Rrm3VB/eYBZdLJl8lxMzxKcoVM1vwlxxpT8AWVtKhrDoNGENDmZEOXN7vrqbpPGRCFaddEG4FlacahawjleYnKjWDWMT0fMOXI3NoVMov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1lzged; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh1lzged"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90A61F00899;
	Thu, 10 Sep 2026 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006271;
	bh=ZQhJ2z/gtlZPN/nZJ0bFqZGOOqI9tMrktfAp5qBR7nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kh1lzgedW5X/YSZwI0QuEMdaCG7CCx2BDuOlcj/Za7MYszMtJmR3u6BfmOzNSXnd1
	 kTAsiSJdw0MzxLuz/N8Brg2MTacYh/VgSOn358t4qLC+GMxUU5SHXOl3MxmmykBxBZ
	 Mn9lg4iCZ8QGjWyuUfnehJcayjFTsb7JYfhC5+Ugh4agJquW+4fTyin6r0l6pzcXqU
	 Oyxgb6QsdP/xjWPjOuqLXdGLgSJihgiUNFdAuen6yfElkeb6YHywzHQ8C2olQKRHIc
	 QU3219q7VUIygyJHTHLNvHDO4SSBhuPajIds6xOFgqpZXN0JciD9esGDqRx5T0g5zW
	 ZN0UljP/3SsiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: typec: tcpm: fix debug accessory mode detection for sink ports
Date: Wed,  9 Sep 2026 22:11:08 -0400
Message-ID: <20260910021109.3989265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090802-feminize-veto-a3d7@gregkh>
References: <2026090802-feminize-veto-a3d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit f6ec9bb4acc7182b25a793ad094a764e1cb819a7 ]

The port in debug accessory mode can be either a source or sink. The
previous tcpm_port_is_debug() function only checked for source port.

Commit 8db73e6a42b6 ("usb: typec: tcpm: allow sink (ufp) to toggle into
accessory mode debug") changed the detection logic to support both roles,
but left some logic in _tcpm_cc_change() unchanged, This causes the state
machine to transition to an incorrect state when operating as a sink in
debug accessory mode. Log as below:

[  978.637541] CC1: 0 -> 5, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
[  978.637567] state change TOGGLING -> SRC_ATTACH_WAIT [rev1 NONE_AMS]
[  978.637596] pending state change SRC_ATTACH_WAIT -> DEBUG_ACC_ATTACHED @ 180 ms [rev1 NONE_AMS]
[  978.647098] CC1: 5 -> 0, CC2: 5 -> 5 [state SRC_ATTACH_WAIT, polarity 0, connected]
[  978.647115] state change SRC_ATTACH_WAIT -> SRC_ATTACH_WAIT [rev1 NONE_AMS]

It should go to SNK_ATTACH_WAIT instead of SRC_ATTACH_WAIT state.

To fix this, add tcpm_port_is_debug_source() and tcpm_port_is_debug_sink()
helper to explicitly identify the power mode in debug accessory mode.
Update the state transition logic in _tcpm_cc_change() to ensure the state
machine transitions comply with Type-C specification. Also update the logic
in run_state_machine() to keep consistency.

Fixes: 8db73e6a42b6 ("usb: typec: tcpm: allow sink (ufp) to toggle into accessory mode debug")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>
Link: https://patch.msgid.link/20260424074009.2979266-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[Backport to 6.12: This tree lacks 8db73e6a42b6 and the associated
sink debug-accessory state-machine support. Retain only the source-debug
macro extraction and source-side call-site updates. Keep
tcpm_port_is_debug() source-only and omit the sink-debug macro and all
sink/audio attachment transitions introduced by the upstream dependency.
This preserves existing detection and state transitions while providing
tcpm_port_is_debug_source() for cd3b9cea675b ("usb: typec: tcpm: constrain
TCPM_SOURCING_VBUS event handling"). No functions are added.]

Stable-dep-of: cd3b9cea675b ("usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 2eabd89c36cbd..1354de477f289 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -531,9 +531,12 @@ static const char * const pd_rev[] = {
 	 (tcpm_cc_is_source((port)->cc2) && \
 	  !tcpm_cc_is_source((port)->cc1)))
 
-#define tcpm_port_is_debug(port) \
+#define tcpm_port_is_debug_source(port) \
 	(tcpm_cc_is_source((port)->cc1) && tcpm_cc_is_source((port)->cc2))
 
+#define tcpm_port_is_debug(port) \
+	tcpm_port_is_debug_source(port)
+
 #define tcpm_port_is_audio(port) \
 	(tcpm_cc_is_audio((port)->cc1) && tcpm_cc_is_audio((port)->cc2))
 
@@ -3974,7 +3977,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
 		break;
 	case SRC_ATTACH_WAIT:
-		if (tcpm_port_is_debug(port))
+		if (tcpm_port_is_debug_source(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
 		else if (tcpm_port_is_audio(port))
@@ -4998,7 +5001,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 
 	switch (port->state) {
 	case TOGGLING:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
 		else if (tcpm_port_is_sink(port))
@@ -5009,7 +5012,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		break;
 	case SRC_UNATTACHED:
 	case ACC_UNATTACHED:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
 		break;
-- 
2.53.0

