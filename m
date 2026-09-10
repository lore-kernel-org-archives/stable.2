Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A0421235
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038535; cv=none; b=bdFI2k/xkYj1TZWnE6tqyBTaHuEcmodJeY4OH3afSra2RksFdBz4gDjeWOW0eLdLGDILc7qun2+9sJxvy4SBYxVjiviR7Ynle1U1vKZi+Ct+Qc8Zk87GsaheLemjFgnzRj0j7Qi9ru/ZJxXoBfBaNL21zWAkZa+4bBo7duF1n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038535; c=relaxed/simple;
	bh=KgyYoNLG5rg40/A4KknC4JflJLqxaV7JefTftK/ZG84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+nkM0Ul77zNU+iEer+hmx9UW33UZ3Gf020A9gn6rsSphtcAMEpc8R6uxUQbJShMAIPW/+XEn6GZ4mTZcqbzkCmCgEnjMNWuEUIoVrdm9OtMQYKJszXsOwhjahFwLBlhyrooDvMa/LNVvxkYkynebkqBJbBe/+6y06kdALZAU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9TakiQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9TakiQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415F11F00893;
	Thu, 10 Sep 2026 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038533;
	bh=jnxZEaJ5ZE6jzk0toQtDUwAZ67qTNAh+qmCPKIYJ2vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9TakiQZ9XvzynCw1i1haxRggQMx8ZkTjwBdnDfX0kzcDwN996zCZY4TH+iAZyAtb
	 qbxNzrXvj4LXvfkKy6K0xGnWYq2DfOla/HIBhlhyu9J5n5I2fTqRrvVFwd0ZYOZ7G5
	 SdNDib59Ib12QuqV5NXHBUcQqSHe2L+KMwFAokGJM1sHmRXaynXUyIrrAufjX0P5r1
	 zYLjHk/xF3Q2BaEXVnSfA5EYUCAWvLJsZfGWpxs4rmKs3urDtwtSrJfa0OR4fP2olj
	 g3QAPGKkMC2//YpCxi3PmAMuHmT4o1oaNUOk0/tL8zsWfthrJOWgjz883uHo6ZuTkM
	 9gLJeNTFEuLmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: typec: tcpm: fix debug accessory mode detection for sink ports
Date: Thu, 10 Sep 2026 07:08:49 -0400
Message-ID: <20260910110850.4146076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090804-natural-naming-bb59@gregkh>
References: <2026090804-natural-naming-bb59@gregkh>
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

[5.10 dependency adaptation: This tree does not contain 8db73e6a42b6
or sink debug accessory support. Retain the source debug predicate and
its source-path callers, and keep tcpm_port_is_debug() source-only.
Drop the sink predicate and sink accessory state transitions, which
require the missing feature. This supplies tcpm_port_is_debug_source()
for cd3b9cea675b without changing 5.10 accessory behavior or adding
functions. The target applies with a three-way merge; its references
to AMS_START and upcoming_state still require a separate 5.10 adaptation
because AMS and Collision Avoidance was not backported.]

Stable-dep-of: cd3b9cea675b ("usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 992901274a243..5cd39ad963e1c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -420,9 +420,12 @@ struct pd_rx_event {
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
 
@@ -3095,7 +3098,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
 		break;
 	case SRC_ATTACH_WAIT:
-		if (tcpm_port_is_debug(port))
+		if (tcpm_port_is_debug_source(port))
 			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
 		else if (tcpm_port_is_audio(port))
@@ -3918,7 +3921,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 
 	switch (port->state) {
 	case TOGGLING:
-		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
+		if (tcpm_port_is_debug_source(port) || tcpm_port_is_audio(port) ||
 		    tcpm_port_is_source(port))
 			tcpm_set_state(port, SRC_ATTACH_WAIT, 0);
 		else if (tcpm_port_is_sink(port))
@@ -3926,7 +3929,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
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

