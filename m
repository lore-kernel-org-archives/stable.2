Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E431A55B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006499; cv=none; b=iVQ3cUboQMfQ6VCN5BO2jUaD11V5JFHiXW3ZLhmG37+ttgQwZ1ZzhlCW5Q9G3FMUwx9wpNTznPUu7tiqJFfYryeL+L1pdvZLY8Ix4WRtNS/Eca2lDO+fMKOpBe5DeE7FD52km8Qwq8pajb9NGo98cqDhqiI8QJJ+IVFYJIzOAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006499; c=relaxed/simple;
	bh=llOq2t+9u3Vl4RUYRVfmJXkW5E5L7FGkJgQvKo1vUUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmJ6XcOS2NDDsbe6BqGUi/MlBT+32KyWy6G1S59zkotcBHLd2Mn8Y/8MBGGM889loM+Hsqb2mVLQdBwgear3u0mMuDon3rKrMsUP3yCh/fVZT9g/vtf9islFotWCUmN2o/AF2B1a7l+rdOp1gHvzRmtufULYFoSW8u6od7Lwt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO91rfFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO91rfFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44731F00898;
	Thu, 10 Sep 2026 02:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006497;
	bh=vqOFyup19L0Nvwbu1VfAMG8qxR+GMeKoD8ScMcU74SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DO91rfFnWLEPwrehEdhOMouQ/D6s9NvLKeY8azASj0Cgcw5+QpCVfnBI27tgGicAm
	 /ZIS4R6q9s5r91SJ6dGhxFJ/66jmkbGTnN5JaoRukihBHT+vgEvuo6wWkMT1G/d113
	 46r9ehDOD0B8VFpNljaPKRurExc+xyhgWx3g2kdkzsp7C/USFJArFJL+Oy5Dmhm+fH
	 b7DdQ8QTlAG95DToF6Wof1kho7TimOy3tMchNPFvWPE2drk489T4I/xkg4XocRenpC
	 vri+rH0LiFp2cFroJH6Wi3EnXCyvw3A7BH+XqLT6kispOOGpvn+jNpOJMq2QZE5EAq
	 adetmG1RPpR0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling
Date: Wed,  9 Sep 2026 22:14:54 -0400
Message-ID: <20260910021454.3999749-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910021454.3999749-1-sashal@kernel.org>
References: <2026090802-sauciness-bleach-95a1@gregkh>
 <20260910021454.3999749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amit Sunil Dhamne <amitsd@google.com>

[ Upstream commit cd3b9cea675bbfebc223f007dc2f4e79524fa54c ]

When a sink detach occurs while waiting for TX send status, the old
TCPM_SOURCING_VBUS event along with TCPM_VBUS_EVENT and TCPM_CC_EVENT
can be queued in port->pd_events. Because TCPM_SOURCING_VBUS is
evaluated after TCPM_VBUS_EVENT and TCPM_CC_EVENT in
tcpm_pd_event_handler(), a stale TCPM_SOURCING_VBUS event can override
the detach handling and incorrectly set port->vbus_source and
port->vbus_present to true.

Add a state guard to check that the port is either operating as a
Source (tcpm_port_is_source(port)) or in a Fast Role Swap (FRS) state
up to FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED before processing
TCPM_SOURCING_VBUS. Otherwise, discard and log the event.

Log snippet for error condition before fix:
[72792.204955] state change SRC_ATTACHED -> SRC_STARTUP [rev3 NONE_AMS]
[72792.204960] sourcing vbus
[72792.204962] VBUS on
[72792.204970] AMS POWER_NEGOTIATION start
[72792.204974] cc:=4
[72792.205319] state change SRC_STARTUP -> AMS_START [rev3 POWER_NEGOTIATION]
[72792.205325] state change AMS_START -> SRC_SEND_CAPABILITIES [rev3 POWER_NEGOTIATION]
[72792.205332] PD TX, header: 0x11a1
[72792.216911] PD TX complete, status: 2
[72792.216957] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms [rev3 POWER_NEGOTIATION]
[72792.218005] VBUS off
[72792.218013] pending state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED @ 650 ms [rev3 POWER_NEGOTIATION]
[72792.218020] VBUS VSAFE0V
[72792.218024] state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED [rev3 POWER_NEGOTIATION]
[72792.218458] CC1: 2 -> 0, CC2: 0 -> 0 [state SNK_UNATTACHED, polarity 0, disconnected]
[72792.218467] VBUS on --> VBUS left on
[72792.218980] disable vbus discharge ret:0
[72792.235193] Start toggling

After fix:
[ 1195.291691] state change SRC_ATTACHED -> SRC_STARTUP [rev3 NONE_AMS]
[ 1195.291698] sourcing vbus
[ 1195.291700] VBUS on
[ 1195.291707] AMS POWER_NEGOTIATION start
[ 1195.291710] cc:=4
[ 1195.291758] state change SRC_STARTUP -> AMS_START [rev3 POWER_NEGOTIATION]
[ 1195.291794] state change AMS_START -> SRC_SEND_CAPABILITIES [rev3 POWER_NEGOTIATION]
[ 1195.291798] PD TX, header: 0x11a1
[ 1195.297056] PD TX complete, status: 2
[ 1195.297092] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms [rev3 POWER_NEGOTIATION]
[ 1195.297177] VBUS off
[ 1195.297184] pending state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED @ 650 ms [rev3 POWER_NEGOTIATION]
[ 1195.297227] CC1: 2 -> 0, CC2: 0 -> 0 [state SRC_SEND_CAPABILITIES, polarity 0, disconnected]
[ 1195.307469] cc:=2
[ 1195.307544] pending state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED @ 650 ms [rev3 POWER_NEGOTIATION]
[ 1195.307555] Discarding sourcing vbus! Invalid state SRC_SEND_CAPABILITIES
[ 1195.957636] state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED [delayed 650 ms]
[ 1195.957732] disable vbus discharge ret:0
[ 1195.970196] Start toggling
[ 1195.970468] VBUS off
[ 1196.051637] VBUS off
[ 1196.051642] VBUS VSAFE0V

Fixes: 8dc4bd073663 ("usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)")
Cc: stable <stable@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260827-sourcing-vbus-v1-1-9be1aca991a0@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6ff7d4dbaafe2..e09e927fc76c8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5549,16 +5549,32 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
 			}
 		}
 		if (events & TCPM_SOURCING_VBUS) {
-			tcpm_log(port, "sourcing vbus");
 			/*
 			 * In fast role swap case TCPC autonomously sources vbus. Set vbus_source
-			 * true as TCPM wouldn't have called tcpm_set_vbus.
+			 * true conditionally as TCPM wouldn't have called tcpm_set_vbus.
+			 * If TCPM calls tcpm_set_vbus to source vbus, vbus_source would already
+			 * be true.
 			 *
-			 * When vbus is sourced on the command on TCPM i.e. TCPM called
-			 * tcpm_set_vbus to source vbus, vbus_source would already be true.
+			 * When TCPM_FRS_EVENT and TCPM_SOURCING_VBUS arrive simultaneously,
+			 * handling TCPM_FRS_EVENT above transitions the state to AMS_START
+			 * with upcoming_state FR_SWAP_SEND.
 			 */
-			port->vbus_source = true;
-			_tcpm_pd_vbus_on(port);
+
+			if (tcpm_port_is_source(port) ||
+			    tcpm_port_is_debug_source(port) ||
+			    (port->state == AMS_START && port->upcoming_state == FR_SWAP_SEND) ||
+			    port->state == FR_SWAP_SEND ||
+			    port->state == FR_SWAP_SEND_TIMEOUT ||
+			    port->state == FR_SWAP_SNK_SRC_TRANSITION_TO_OFF ||
+			    port->state == FR_SWAP_SNK_SRC_NEW_SINK_READY ||
+			    port->state == FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED) {
+				tcpm_log(port, "sourcing vbus");
+				port->vbus_source = true;
+				_tcpm_pd_vbus_on(port);
+			} else {
+				tcpm_log(port, "Discarding sourcing vbus! Invalid state %s",
+					 tcpm_states[port->state]);
+			}
 		}
 
 		spin_lock(&port->pd_event_lock);
-- 
2.53.0

