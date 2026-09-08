Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A2534468
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870605; cv=none; b=W4OyWmcuezd9IchRV/ob8nlGFdtF3roXKH6Sw4RmCAgrJOx3+j+RPiCHvYHP7oN9lzBprA3W5d+IbZ4h7GUYEuaGM86F6r79F1TOS8fPUJfsin8Ho6qYViHxW3g8JKLAU/myoPCh62XCD2nA7KuJCcPc+hyUe1my1XyBSXh0Cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870605; c=relaxed/simple;
	bh=6Ek/xXEsOPRxSGVSjbbsINWnbU6jtsMLnc5o3Cdw6ro=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HbxJ3mVoA1Ar3go1DmxgjNK+P80jEeyrroDDCQuZOl1kRsoE056kkBX6KLXdDRy/qgy5RC2QgKURYToixQPgD1OEjtTxUo/fFpWyk+5/raWOMkJVft2+r3PGjMK0enNpintuVUhqcnZnceOB8J6jaJVagTeHd6bZk74CHN7WY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWE6eqf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWE6eqf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990141F00A3A;
	Tue,  8 Sep 2026 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870604;
	bh=tqpSwP2qHsWRIF/bQJ+DKMaD75qn2WrDPZZQ13b7H4k=;
	h=Subject:To:Cc:From:Date;
	b=HWE6eqf0hYf+JGz7HALOsbgW0Z17b5iMWm8kPwrD1WRz5GDI7EcBDw57DvLVx4Qhn
	 7Mi2EA4WGaDUrddFi+Mfn9ok5w5aW5BEEwemVV/O+k238eFKx2LbgsmbaAy3xFuvdm
	 ZkiNoNlxFcIa8+HaGy1nSfe8wwsS4g/BQppOlKX4=
Subject: FAILED: patch "[PATCH] usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling" failed to apply to 5.10-stable tree
To: amitsd@google.com,badhri@google.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:29:04 +0200
Message-ID: <2026090804-natural-naming-bb59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cd3b9cea675bbfebc223f007dc2f4e79524fa54c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090804-natural-naming-bb59@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd3b9cea675bbfebc223f007dc2f4e79524fa54c Mon Sep 17 00:00:00 2001
From: Amit Sunil Dhamne <amitsd@google.com>
Date: Thu, 27 Aug 2026 21:16:17 +0000
Subject: [PATCH] usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event handling

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

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a8cd1959c426..2d6b14aa2085 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7119,16 +7119,32 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
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
 		if (events & TCPM_PORT_CLEAN) {
 			tcpm_log(port, "port clean");

