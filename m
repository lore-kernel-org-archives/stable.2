Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4662165EA;
	Thu,  3 Sep 2026 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394943; cv=none; b=g9RDyklMHfvSjgxGUGKAmhyMyrrm3j2+Sbk/pB4aGghcoRefcIP9H2C9w/37eFbbx3rS/6hQKdMyViZzhhmj3RoYOIkqAGgkIpnDD71LuKgshBjb4i+VkYrNBfrrPrwwqrma9d6WN3WF5V3wl/Nm15lSUs7nae68nkiDPwi2X5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394943; c=relaxed/simple;
	bh=UlvUCkiHz50e+s02GSf4sNxeCeKccUxCMvFeqxSZ6wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OqKYFL3EWUVNZ1Iv0IsN4bhfgIS5sq4bRMiA7mAPrcbiaUWCBIHX3EPBZR2FHi5PcSGKA3uDX49UVFkoZi4T8xuBr3zm4Yj+jgfB4yLQrK5KRbpAAU4IBNOl6DRhkMAZF0JBJANgsyW7wcfIoNGboHtKsk1HfCBhP2O8PzVFyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcTGa2Q0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcTGa2Q0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E969C2BCC7;
	Thu,  3 Sep 2026 00:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788394943;
	bh=UlvUCkiHz50e+s02GSf4sNxeCeKccUxCMvFeqxSZ6wY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZcTGa2Q0JtbR6jdZL9rojMa2UwfoBpMjFwjoAGxIYoJCNTPEs9ppciVljqEuAamFA
	 /D8ecoOrWIdBJqdBWskHa6Wdswb0Ltk4TpdWVRB+zrQdSDnguDBA76TWvB5GohD2qQ
	 fdM8J7oxhn0rvb5WU8zlpVwvKplGuDibkYgh5TI//1PzAhihaYx/IK1WWM+I23T2lU
	 yXkbLfxk/nkwPrrt1kBk2z/UyBMOqXMC9qVETWooEbj2xD/scUO47S2WiY+R7sHmn3
	 gcxK9vN4aQsmM/qjlpRk7nujTAS+1rmde9EqfEAvDwecNkn4qaAu/pJmM3MYD/fIdz
	 HOpA6ouny2rNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B306C624DA;
	Thu,  3 Sep 2026 00:22:23 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 03 Sep 2026 00:22:21 +0000
Subject: [PATCH] usb: typec: tcpm: recover after failure to start the frs
 ams
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-frs-error-handling-v1-1-ad0fee541847@google.com>
X-B4-Tracking: v=1; b=H4sIALy9mGoC/x2MWwqAIBAAryL73YIpPa8SfVittRAaK0QQ3j3pc
 xhmXkgkTAlG9YLQzYljKFBXCtbDhZ2Qt8JgtGn1oC16SUgiUbDo7eSwo2ns0ndOD94ZKOEl5Pn
 5p9Oc8weebwfzZAAAAA==
X-Change-ID: 20260903-frs-error-handling-253b87a09fa2
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kyle Tso <kyletso@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788394942; l=3025;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=biiAX9QFebDyRLFSxDi+iEYh4i0wJY7gp/fEzN5Cur0=;
 b=V2p3cEa2GfvG7Yf4C0cILt1385Ga0C2k75aUm3QPFGxW89AAsZsEVxxe5/8psQB+KPeV+QC7Z
 BgGVMtpvF6XB9oHL8iUhPu6MZEu/xxVSDiMwP9DPyzEX9YqBODXkVKx
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Reset the port if the tcpm fails to start the FAST_ROLE_SWAP AMS by
initiating error recovery on it.

This helps in cases where some cables (incorrectly) signal an FRS to
an FRS capable port during disconnection. The TCPC autonomously starts
sourcing VBUS on detecting the FRS signal. However, the VBUS sourcing is
left on when the FAST_ROLE_SWAP AMS fails to start (as tcpm_sink_tx_ok
is 0 as CC is open due to the cable disconnect). This is because the
code sets the state to INVALID_STATE without resetting the port state.

Log snippet before changes:
[  101.401960] AMS FAST_ROLE_SWAP start
[  101.401971] Sink TX No Go
[  101.401982] sourcing vbus
[  101.401987] VBUS on
[  101.402159] VBUS on
[  109.257809] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_READY, polarity 1, disconnected]
[  111.267442] VBUS on

After changes:
[   70.541211] AMS FAST_ROLE_SWAP start
[   70.541220] Sink TX No Go
[   70.541228] state change SNK_READY -> ERROR_RECOVERY [rev3 NONE_AMS]
[   70.541362] VBUS on
[   70.541365] sourcing vbus
[   70.541367] VBUS on
[   70.541374] state change ERROR_RECOVERY -> PORT_RESET [rev3 NONE_AMS]
[   70.541410] disable vbus discharge ret:0
[   70.543028] Setting usb_comm capable false
[   70.544009] Setting voltage/current limit 0 mV 0 mA
[   70.544034] polarity 0
[   70.544239] Requesting mux state 0, usb-role 0, orientation 0
[   70.555550] cc:=0
[   70.555595] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
[   70.555697] VBUS off
[   70.555702] VBUS VSAFE0V
[   70.555762] CC1: 5 -> 0, CC2: 0 -> 0 [state PORT_RESET, polarity 0, disconnected]
[   70.587794] VBUS off
[   70.587799] VBUS VSAFE0V
[   70.655672] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]
[   70.655682] state change PORT_RESET_WAIT_OFF -> SNK_UNATTACHED [rev3 NONE_AMS]
[   70.655686] Start toggling
[   70.656274] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a8cd1959c426..c1045d850897 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7113,7 +7113,7 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
 				port->upcoming_state = FR_SWAP_SEND;
 				ret = tcpm_ams_start(port, FAST_ROLE_SWAP);
 				if (ret == -EAGAIN)
-					port->upcoming_state = INVALID_STATE;
+					tcpm_set_state(port, ERROR_RECOVERY, 0);
 			} else {
 				tcpm_log(port, "Discarding FRS_SIGNAL! Not in sink ready");
 			}

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260903-frs-error-handling-253b87a09fa2

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>


