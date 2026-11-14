Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.58.8.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671398;
	b=0WKLv5T7yHelYPlZdCkTWDznOj5G2rkMygvVPDU2i+UM0kmkM4oiZgYKmz3wt/ennrJ4
	 Gd4pHNrEHpNmGp5+Q0iHlsFPy2688IvnUDkJjm/VpbbPxXDIq9zCV8TfLM444v+GrZNrH
	 m865UTMJsSTbmvmKbBAxETJT+Qi/Kc1ZNVmVwvxfm+3u/nulgn4IZ2VM5tCZlrmKVFO0H
	 MPExHVSR0F0xsi34sPuHBdVD+8DEN6AbFfob14PiqjtlA4ImgKCmLZ2jEtd2KXxaI6nIH
	 wnFdmt9zpVj5bTe9ACUkI6BEon+IsJSnI682wcKuxi6B4L5MouTRqkTGGqPZbxiPdQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671398;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:Content-Type;
	bh=o5DnMkRRYa/2d2eTcqfJtTS0iCcyKqGOGfoKXlR9sQw=;
	b=ba5S2jhc+A/RWjzy3tUp1hm/4HgCuk0z4pIpYkFHdW0n0zGNAXOwqub/Y8x7BPDrW4po
	 l6abn63ghp1RkkqLa78wb/qcPY+nK/aQFpiWiti3+WKgE1+lKBR1woo2tLRwuRHDWAO5J
	 0RZy4A2/hiEBZWozLM2Dz5mQySpojy5mobxIk3npCzZZeKRa0ByI4r5fH08Jr9oPzpj2k
	 EZQKXlfmjFnQ1eSLjRLVLHazarVLIGhFHpjtoNMrMWK01hH7/v1DaydtfcNfGB0oJMKnr
	 v9oIAAdjLr4YFln8EiN+AsEi9hBXppYYqSsgKasnyWGGwqOFCUWDZcW8z4Da1iVsEaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wagner-flo.de;
	spf=pass smtp.mailfrom=wagner-flo.de;
	dkim=pass header.d=wagner-flo.de header.i=@wagner-flo.de header.a=rsa-sha256 header.s=fuldigor header.b=MJgAZQeQ;
	arc=none smtp.remote-ip=89.58.8.210
Received: from fuldigor.wagner-flo.de (fuldigor.wagner-flo.de [89.58.8.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056C606A334;
	Sat, 14 Nov 2026 15:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1056C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wagner-flo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wagner-flo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wagner-flo.de header.i=@wagner-flo.de header.a=rsa-sha256 header.s=fuldigor header.b=MJgAZQeQ
Received: from teclador (p4fe8fa45.dip0.t-ipconnect.de [79.232.250.69])
	by fuldigor.wagner-flo.de (Postfix) with ESMTPSA id 97B4C247B1;
	Sat, 14 Nov 2026 16:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=wagner-flo.de;
	s=fuldigor; t=1794671388;
	bh=zsCrDX7nTVibZ3D7ZKVFAJOdCHRHXxbIb6Vte0qGPXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MJgAZQeQxYUg5+ooSwAu1Kq5GzXJlD4i05h4MjNSbcu0A4aAKB83JN7LS622/r60n
	 RQLAGBi7iub+yykUbZogBg0kT46j3a619s277PG/bGfwvrFMX1NCUsDqgqlN+Rvpr4
	 cSpJEiTFxOySKzLrBJLjXUbk/G61/SwULm4jrW6k=
Date: Sat, 14 Nov 2026 16:49:47 +0100
From: Florian Wagner <florian@wagner-flo.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [REGRESSION 6.18.y] ACPI: button: lid events lost since
 6.18.57, please backport a004b8f0d3bc
Message-ID: <20261114164947.2ffb5ce8@teclador>
In-Reply-To: <2026-11-08-1-daily-reply-0002-acpi-button-6-18@kernel.org>
References: <20261108143640.6252e6a8@teclador>
 <2026-11-08-1-daily-reply-0002-acpi-button-6-18@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-unknown-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/tYvO2Of2RyCCp2rGf/+sa6/"

--MP_/tYvO2Of2RyCCp2rGf/+sa6/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun,  8 Nov 2026 19:34:30 -0500
Sasha Levin <sashal@kernel.org> wrote:

> > Backport note: a004b8f0d3bc applies to 6.18.60 and 6.18.62 with
> > offsets, but does not build as is, because struct acpi_button has no
> > "dev" member in 6.18.y. Using &button->pdev->dev in the two
> > dev_dbg() calls is sufficient.  
> 
> A backport that works would be much appreciated :)

Oh; shame on me. Here's the missing attachment. But then: I've since
had the time to test it on a release 6.18.62 kernel and can confirm it
fixed my issue (GPE24 enabled again; laptop suspends and wakes up from
lid close/open).

Regards
Florian

--MP_/tYvO2Of2RyCCp2rGf/+sa6/
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=acpi-button-enable-wakeup-gpes-6.18.y.patch

From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 22 May 2026 16:52:10 +0200
Subject: [PATCH] ACPI: button: Enable wakeup GPEs for ACPI buttons at probe
 time

[ Upstream commit a004b8f0d3bc5d82d3f2c91ff93f4b4b7ccb8f76 ]

Prior to commit 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake()
for buttons"), ACPI button wakeup GPEs having handler methods remained
enabled after acpi_wakeup_gpe_init(), but currently they are not enabled
because acpi_setup_gpe_for_wake() disables them.

That causes function keys to stop working on some systems [1] and there
may be other related issues elsewhere.

To address that, make the ACPI button driver enable wakeup GPEs for ACPI
buttons so long as they have handler methods.  While this does not
restore the old behavior exactly (the ACPI button driver needs to be
bound to the button devices for the GPEs to be enabled), it should be
sufficient to restore the missing functionality.

For this purpose, introduce acpi_enable_gpe_cond() that enables
a GPE if its dispatch type matches the supplied one and modify
acpi_button_probe() to use that function for enabling the GPEs in
question.

Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons")
Reported-by: Nick <nick@kousu.ca>
Closes: https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Nick <nick@kousu.ca>
Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
Link: https://patch.msgid.link/9629117.CDJkKcVGEf@rafael.j.wysocki
[ Adjusted for 6.18.y: struct acpi_button has no dev member in this
  tree, so use &button->pdev->dev in the two dev_dbg() calls. ]
---
 drivers/acpi/acpica/evxfgpe.c | 50 ++++++++++++++++++++++++++++-------
 drivers/acpi/button.c         | 22 +++++++++++++++
 include/acpi/acpixf.h         |  5 ++++
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 60dacec1b..4074b5908 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -78,18 +78,22 @@ ACPI_EXPORT_SYMBOL(acpi_update_all_gpes)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_enable_gpe
+ * FUNCTION:    acpi_enable_gpe_cond
  *
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number          - GPE level within the GPE block
+ *              dispatch_type       - GPE dispatch type to match
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
- *              hardware-enabled.
+ * DESCRIPTION: Add a reference to a GPE so long as its dispatch type matches
+ *              the supplied one, or it is different from ACPI_GPE_DISPATCH_NONE
+ *              if the supplied one is ACPI_GPE_DISPATCH_MASK. On the first
+ *              reference, the GPE is hardware-enabled.
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+acpi_status acpi_enable_gpe_cond(acpi_handle gpe_device, u32 gpe_number,
+				 u8 dispatch_type)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -100,14 +104,18 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/*
-	 * Ensure that we have a valid GPE number and that there is some way
-	 * of handling the GPE (handler or a GPE method). In other words, we
-	 * won't allow a valid GPE to be enabled if there is no way to handle it.
+	 * Ensure that we have a valid GPE number and that the dispatch type of
+	 * the GPE matches the supplied one (or it is not ACPI_GPE_DISPATCH_NONE
+	 * if the supplied one is ACPI_GPE_DISPATCH_MASK).
 	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-		    ACPI_GPE_DISPATCH_NONE) {
+		if (dispatch_type == ACPI_GPE_DISPATCH_MASK)
+			dispatch_type = ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags);
+		else if (dispatch_type != ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags))
+			dispatch_type = ACPI_GPE_DISPATCH_NONE;
+
+		if (dispatch_type != ACPI_GPE_DISPATCH_NONE) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info, TRUE);
 			if (ACPI_SUCCESS(status) &&
 			    ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
@@ -128,6 +136,30 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
+ACPI_EXPORT_SYMBOL(acpi_enable_gpe_cond)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_enable_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
+ *              hardware-enabled.
+ *
+ ******************************************************************************/
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	/*
+	 * Ensure that there is some way of handling the GPE (handler or a GPE
+	 * method). In other words, we won't allow a valid GPE to be enabled if
+	 * there is no way to handle it.
+	 */
+	return acpi_enable_gpe_cond(gpe_device, gpe_number, ACPI_GPE_DISPATCH_MASK);
+}
 ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
 
 /*******************************************************************************
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 4ddaee895..b507b88df 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -190,6 +190,7 @@ struct acpi_button {
 	ktime_t last_time;
 	bool suspended;
 	bool lid_state_initialized;
+	bool gpe_enabled;
 };
 
 static struct acpi_device *lid_device;
@@ -651,6 +652,21 @@ static int acpi_button_probe(struct platform_device *pdev)
 		status = acpi_install_notify_handler(device->handle,
 						     ACPI_ALL_NOTIFY, handler,
 						     button);
+		if (ACPI_SUCCESS(status) && device->wakeup.flags.valid) {
+			acpi_status st;
+
+			/*
+			 * If the wakeup GPE has a handler method, enable it in
+			 * case it is also used for signaling runtime events.
+			 */
+			st = acpi_enable_gpe_cond(device->wakeup.gpe_device,
+						   device->wakeup.gpe_number,
+						   ACPI_GPE_DISPATCH_METHOD);
+			button->gpe_enabled = ACPI_SUCCESS(st);
+			if (button->gpe_enabled)
+				dev_dbg(&button->pdev->dev, "Enabled ACPI GPE%02llx\n",
+					device->wakeup.gpe_number);
+		}
 		break;
 	}
 	if (ACPI_FAILURE(status)) {
@@ -694,6 +710,12 @@ static void acpi_button_remove(struct platform_device *pdev)
 						acpi_button_event);
 		break;
 	default:
+		if (button->gpe_enabled) {
+			dev_dbg(&button->pdev->dev, "Disabling ACPI GPE%02llx\n",
+				adev->wakeup.gpe_number);
+			acpi_disable_gpe(adev->wakeup.gpe_device,
+					 adev->wakeup.gpe_number);
+		}
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   button->type == ACPI_BUTTON_TYPE_LID ?
 						acpi_lid_notify :
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e65a2afe9..af796d079 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -725,6 +725,11 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
  */
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_update_all_gpes(void))
 
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_enable_gpe_cond(acpi_handle gpe_device,
+						     u32 gpe_number,
+						     u8 dispatch_type))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_enable_gpe(acpi_handle gpe_device,
 						u32 gpe_number))
-- 
2.43.0


--MP_/tYvO2Of2RyCCp2rGf/+sa6/--
