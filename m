Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B53E4C7B;
	Tue, 29 Sep 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697390; cv=none; b=M7vZdPfn1q8Rul7K5gcdWnBh8rFwczq3/s4uoSnSsHTRvRfigRVFnCxQahYhlprAGPggCH5QrXlj1FK8Ft56kM2NIZ1T4hIUcB3bEs6E64aTY2NSYV+vptrma65mIzrb/4OS5GuQCoASPXwgAn8s7EEnq/Og0YZ1hSE3OvJXvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697390; c=relaxed/simple;
	bh=zegh4LFoKhBqjlXiI/g7/A5pNiFDzaVN2JRWluqZ1Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfnGE25W9PpedAum7FaOgwLjfY66Ubt93hDi4ZE2AXl8/CKeh0z1EEeh23t/NyoDLt4it62Rxvhzoui99Vv2QCAM3Xh9RBemIUjAv4YZrKtesNO7SsC1Y+Gx+07KQ6QIUYPAi1cSyIr+jBEsuV63/6ol5ArXrrDY/t+ZL3u0s6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRCvzG7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRCvzG7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABFD1F00898;
	Tue, 29 Sep 2026 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790697388;
	bh=kUBh2UQP/V2sa5bNZn9dZqHFYt04+I/d8vGdQpNZwKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eRCvzG7QJ9jLj7BJK6RrWjjT/eKzdSsIW+sliNHAwl1b/hqW0pJtBAVFkMEVjEPuW
	 w+eueV3gA+tQxA1gbl0RVElWmSrUsk4TYrw9j2CS+Z2aizS9HL1o017OWHqo20Zqnb
	 w86XvJHoMgdQjrBMWSAyCyjfBgFhF/etwD+OLzkZtwZjz1Pm3oJ9k5W6gZJAE4n1jU
	 Vvhctr8U5xdGjo+RDzQq9Kf96wMuZf8Vd4SdcVvC2CXC3LowX27utvA4hSRThSanmy
	 k2uCOMxcM4ON2WveK2yJHmlbZ4vWVHGJ3Plh/+wHrT3AMAd2QyQvyXIAMLObyuN3L8
	 Osdd0fH0y8HIA==
Date: Tue, 29 Sep 2026 16:56:24 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <20260929-dazzling-gray-sawfly-cfd671@sudeepholla>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
 <20260928-conscious-spectral-manul-19bc10@sudeepholla>
 <arsYvrYaQIr1lwbT@shlinux89>
 <20260929-abstract-accomplished-lynx-3edcbc@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929-abstract-accomplished-lynx-3edcbc@sudeepholla>

On Tue, Sep 29, 2026 at 09:35:21AM +0100, Sudeep Holla wrote:
> On Tue, Sep 29, 2026 at 09:47:42AM +0800, Peng Fan wrote:
> > Hi Sudeep,
> > 
> > On Mon, Sep 28, 2026 at 01:09:08PM +0100, Sudeep Holla wrote:
> > >On Mon, Sep 28, 2026 at 07:49:01PM +0800, Peng Fan (OSS) wrote:
> > >> From: Peng Fan <peng.fan@nxp.com>
> > >> 
> > >> When multiple devices share the same fwnode (e.g. the SCMI bus creates
> > >> both "pinctrl" and "pinctrl-imx" devices for SCMI_PROTOCOL_PINCTRL), only
> > >> the first device registered becomes the fwnode owner (fwnode->dev, set in
> > >
> > >This has been rejected in the past. Apart from the trigger in -next,
> > >anything else has changed ?
> > 
> > When both pinctrl-scmi.c and pinctrl-imx-scmi.c are built into the
> > kernel Image, both drivers call module_scmi_driver() at init time, which
> > goes through:
> >   scmi_driver_register()
> >     → scmi_protocol_table_register(id_table)
> >       → scmi_protocol_device_request()
> >         → scmi_device_request_notifier()
> >           → scmi_create_protocol_devices(fwnode, ..., "pinctrl-imx")
> > So the on-demand path already creates both "pinctrl" and "pinctrl-imx"
> 
> Yes, but this particular device is i.MX specific issue as it should
> have never been there. So I will discard that in any future discussion.
> Use the SCMI pinmux driver and get rid of SCMI pinctrl-imx.
> 

Anyways, I cooked up a patch that may prevent the issue with pinmux.
See if something like below on top -next helps.

Regards,
Sudeep

-->8
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 25197197db8e..cee7cc777724 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -60,13 +60,6 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);

-	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
-	    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
-		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
-			id_table->name, id_table->protocol_id);
-		return -EINVAL;
-	}
-
 	/*
 	 * Find the matching protocol rdev list and then search of any
 	 * existent equally named device...fails if any duplicate found.
@@ -181,12 +174,35 @@ static void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table
 	}
 }

+static bool scmi_device_id_in_std_id_table(const struct scmi_device_id *id)
+{
+	for (int i = 0; scmi_std_id_table[i].name[0]; i++) {
+		if (scmi_std_id_table[i].protocol_id == id->protocol_id &&
+		    !strcmp(scmi_std_id_table[i].name, id->name))
+			return true;
+	}
+
+	return false;
+}
+
 static int scmi_protocol_table_register(const struct scmi_device_id *id_table)
 {
 	const struct scmi_device_id *entry;
 	int ret;

 	for (entry = id_table; entry->name[0]; entry++) {
+		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
+		    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
+			pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
+				entry->name, entry->protocol_id);
+			ret = -EINVAL;
+			goto err_unrequest;
+		}
+
+		/* Standard devices are created independently of their drivers. */
+		if (scmi_device_id_in_std_id_table(entry))
+			continue;
+
 		ret = scmi_protocol_device_request(entry);
 		if (ret)
 			goto err_unrequest;
@@ -195,8 +211,11 @@ static int scmi_protocol_table_register(const struct scmi_device_id *id_table)
 	return 0;

 err_unrequest:
-	while (entry != id_table)
-		scmi_protocol_device_unrequest(--entry);
+	while (entry != id_table) {
+		--entry;
+		if (!scmi_device_id_in_std_id_table(entry))
+			scmi_protocol_device_unrequest(entry);
+	}

 	return ret;
 }
@@ -206,8 +225,10 @@ scmi_protocol_table_unregister(const struct scmi_device_id *id_table)
 {
 	const struct scmi_device_id *entry;

-	for (entry = id_table; entry->name[0]; entry++)
-		scmi_protocol_device_unrequest(entry);
+	for (entry = id_table; entry->name[0]; entry++) {
+		if (!scmi_device_id_in_std_id_table(entry))
+			scmi_protocol_device_unrequest(entry);
+	}
 }

 static bool scmi_device_is_transport(const struct scmi_device *scmi_dev)
@@ -545,21 +566,9 @@ static const struct scmi_device_id scmi_std_id_table[] = {
 	{ SCMI_PROTOCOL_VOLTAGE, "regulator" },
 	{ SCMI_PROTOCOL_POWERCAP, "powercap" },
 	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
-	{ SCMI_PROTOCOL_PINCTRL, "pinctrl-imx" },
 	{ },
 };

-static bool scmi_device_id_in_std_id_table(const struct scmi_device_id *id)
-{
-	for (int i = 0; scmi_std_id_table[i].name[0]; i++) {
-		if (scmi_std_id_table[i].protocol_id == id->protocol_id &&
-		    !strcmp(scmi_std_id_table[i].name, id->name))
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * scmi_device_create  - A method to create one or more SCMI devices
  *
diff --git a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
index 613552e35070..b259a526ccc1 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
@@ -354,7 +354,7 @@ static int scmi_pinctrl_imx_probe(struct scmi_device *sdev)
 }

 static const struct scmi_device_id scmi_id_table[] = {
-	{ SCMI_PROTOCOL_PINCTRL, "pinctrl-imx" },
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
 	{ }
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);

