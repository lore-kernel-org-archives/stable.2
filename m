Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEBC31A556;
	Wed, 30 Sep 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756651; cv=none; b=PPoFyuihcUU0afwK0uODv89rw+gU9T62inwfu99lyV172fLzWY7dzyeo/aYaKjCtJewGdBY665Zd6IJfFlHTrpQ250CvIQ1t/uECfs2xIE0GSXNLFYPPuOenZfFpl4oogzuH4dQ2LQ4GNLS1CTSBm21x0+6lJUiIQecVwe71ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756651; c=relaxed/simple;
	bh=Nq1KK/gkrmyH9eg27Vk4Rc5Pn9C2KHuC2TSuc24nN5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgNtYVieEXlv2dImqbP58Tfr2FubmC6eHvMB3yYNxFasJp5wUhExlxWpvVUkP4LtgSnZ8fU719jmLIY1kJntChBMIVIbo2JnyM/BcV2tyTxHDRkJ/NxC6kTW8Rjqe6t7fAnDyiJxwKw7SqgFZZi4chxSoGMRNwciwiEZ+lenSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym4ArElR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym4ArElR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A51F000FF;
	Wed, 30 Sep 2026 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790756649;
	bh=piGrZQhEosLer1f4tCmw1AsxMn1klfui0wcCvJ8Apfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ym4ArElRSLj0tGJSVcq17WZp8pahdWFaYpgfCq8UfagivBEeDAosG3xwOCC8aheFa
	 glfrILG1Atj42WC+40DPceVZjWDuB+fFhR+bz6zgayMqpY77lXS0fNUXaPGOZV/4OZ
	 IMEf1mBcuQgassN95A8B41cnXJbVWcXguw3FxCyiV0FZ0qV4BRDI+lMJj/LN1juumw
	 8tI2tRQtFesI9RNS7SXwcahr1EUBr14YP5T1T9GB2cqzjz838BdqiQJgyxaLNoKrFn
	 K6s1jgM6XRJOG/FTNxreTB6W4e/9jIONUaxAw5/WWlkj/69K8TTM8CVxSorRKj2PHd
	 kjq6uBMiUzq0w==
Date: Wed, 30 Sep 2026 09:24:05 +0100
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
Message-ID: <20260930-swinging-bear-of-diversity-44e4b4@sudeepholla>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
 <20260928-conscious-spectral-manul-19bc10@sudeepholla>
 <arsYvrYaQIr1lwbT@shlinux89>
 <20260929-abstract-accomplished-lynx-3edcbc@sudeepholla>
 <20260929-dazzling-gray-sawfly-cfd671@sudeepholla>
 <ary048HBAkJB4WR9@shlinux89>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ary048HBAkJB4WR9@shlinux89>

On Wed, Sep 30, 2026 at 03:06:11PM +0800, Peng Fan wrote:
> Hi Sudeep,
> 
> On Tue, Sep 29, 2026 at 04:56:24PM +0100, Sudeep Holla wrote:
> >On Tue, Sep 29, 2026 at 09:35:21AM +0100, Sudeep Holla wrote:
> ...
> >> Yes, but this particular device is i.MX specific issue as it should
> >> have never been there. So I will discard that in any future discussion.
> >> Use the SCMI pinmux driver and get rid of SCMI pinctrl-imx.
> >> 
> >
> >Anyways, I cooked up a patch that may prevent the issue with pinmux.
> >See if something like below on top -next helps.
> >
> >Regards,
> >Sudeep
> >
> >-->8
> >diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> >index 25197197db8e..cee7cc777724 100644
> >--- a/drivers/firmware/arm_scmi/bus.c
> >+++ b/drivers/firmware/arm_scmi/bus.c
> >@@ -60,13 +60,6 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
> > 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
> > 		 id_table->name, id_table->protocol_id);
> >
> >-	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
> >-	    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
> >-		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
> >-			id_table->name, id_table->protocol_id);
> >-		return -EINVAL;
> >-	}
> >-
> > 	/*
> > 	 * Find the matching protocol rdev list and then search of any
> > 	 * existent equally named device...fails if any duplicate found.
> >@@ -181,12 +174,35 @@ static void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table
> > 	}
> > }
> >
> Move static const struct scmi_device_id scmi_std_id_table[] here to avoid
> build failure.
> 

Thanks, it shows that I didn't even build test it. Sorry for that.

I may have to split this patch as multiple things are being changed. I will
post something later in the week or next week and target as fix for v7.4

> >+static bool scmi_device_id_in_std_id_table(const struct scmi_device_id *id)
> >+{
> >+	for (int i = 0; scmi_std_id_table[i].name[0]; i++) {
> >+		if (scmi_std_id_table[i].protocol_id == id->protocol_id &&
> >+		    !strcmp(scmi_std_id_table[i].name, id->name))
> >+			return true;
> >+	}
> >+
> >+	return false;
> >+}
> >+
> 
> Tested your patch it works well, the pinmux issue gone. A very clean fix.
> 
> If you post a formal patch, feel free to add my
> Tested-by: Peng Fan <peng.fan@nxp.com>
> 

Thanks for testing and glad it worked.

-- 
Regards,
Sudeep
