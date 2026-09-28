Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F64DE729;
	Mon, 28 Sep 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606352; cv=none; b=PZNf5Lhbe+fvHXWNs6FGXW1ZE3JiKtUaSj76tJXT4zHnEQK35SnACr99eRIzC8qThdsqeRD6f7pYbJpCt/xBteay+3rsnPFspJi5/1B6a9hp5QGJ7KFwbIjXc8UkMNPeo/YOY+VRP2cVFjehQjDTpQ4FoXV7+HdglmS+iIU9amU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606352; c=relaxed/simple;
	bh=4YjKs+L2GTxwc1OBkiJDc7B54oY4PcXWb8rFB33O4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crsq2vRhX0RNlVbLvgCF4VAhiMpUNnM/bldnilxtgX0Q09WbwDE0beB5pVN4ElRpjXnq3lZo2y0AdHZnI7Yszba0Kcgr1AnrtsyMD5tQJwaOonjdWo+387KnMBPZf9k9idxdG4seI0uwB3+On1pTw4pxTAp37KRbtP7JivuJDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5ZrpoO5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5ZrpoO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790606348; x=1822142348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4YjKs+L2GTxwc1OBkiJDc7B54oY4PcXWb8rFB33O4JQ=;
  b=O5ZrpoO5ctK1ckLnxKCVOEyWl2YwT7lDNxf8Xkqp8Vq0aDx2bBrF7CU+
   S7Sw7mxRWQo6J2jVfjQCSsA518n2pi1YTuGothIRrBZx8JVjgQ6QA8HKD
   NSm7uDLI6U7SxTizqaR1/dIMVxW9g1vdHtoyJo2dth305odaS5TJZV8jn
   k5lhIzPoJ1D6XfYGxIYqAjrsa43ep/XsH6h4heM2EWVqdug8NnXbUlVdW
   ZhqfMUr7bpoI9x/lzdpH4UU4BLoT9p30XenQaj0hMEV6t5OXsRbnnou0i
   PEGojPHrSBIi6bKNfPgST6Lp/th5pbCIwD6M8d7GeJJEMR9lgkFBvxfbg
   g==;
X-CSE-ConnectionGUID: l4jF6hM/SwOOKD4g41driA==
X-CSE-MsgGUID: SSYTAW8PSUCOcdGz0kWP5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90173831"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90173831"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 07:39:05 -0700
X-CSE-ConnectionGUID: G4kgOxMISGC+43LOX2830Q==
X-CSE-MsgGUID: PrTpgZWaTx6eAiTarsbhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="272867583"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 28 Sep 2026 07:39:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 640C599; Mon, 28 Sep 2026 16:39:01 +0200 (CEST)
Date: Mon, 28 Sep 2026 16:39:01 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Gris Ge <cnfourt@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Skip CAM query when partner has no alt
 modes
Message-ID: <arp8BXZIrW6UFdbi@black.igk.intel.com>
References: <20260927021649.8967-1-cnfourt@gmail.com>
 <CAMMMRMeX9-r_coX1zbUNoMGU+GUW56o4iY_jfyE5_ovFYs6UCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMMMRMeX9-r_coX1zbUNoMGU+GUW56o4iY_jfyE5_ovFYs6UCA@mail.gmail.com>

On Mon, Sep 28, 2026 at 08:47:40AM +0000, Andrei Kuchynski wrote:
> On Sun, Sep 27, 2026 at 2:17 AM Gris Ge <cnfourt@gmail.com> wrote:
> >
> > Since Thunderbolt alternate mode support was added,
> > `ucsi_altmode_update_active()` is called on every Connector Partner
> > Changed event.  This made the driver send `UCSI_GET_CURRENT_CAM` to
> > PPMs even when the partner had no alternate modes registered. Firmware
> > that does not support the optional alternate mode details answered Not
> > Supported, which produced a spurious error on every partner change:
> >
> > ```
> > ucsi_acpi USBC000:00: GET_CURRENT_CAM command failed
> > ```
> >
> > Fixed by skipping the command when there is nothing to update.
> >
> > Fixes: da87d45b1951 ("usb: typec: ucsi: Add Thunderbolt alternate mode support")
> > Cc: stable@vger.kernel.org # v7.0+
> > Assisted-by: Codex:deepseek-v4.1-flash
> > Signed-off-by: Gris Ge <cnfourt@gmail.com>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index bef3f9b71d71..71b28e4df470 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -360,6 +360,15 @@ void ucsi_altmode_update_active(struct ucsi_connector *con)
> >         u8 cur;
> >         int i;
> >
> > +       /*
> > +        * Alternate mode support is optional, and the PPM is not required to
> > +        * support GET_CURRENT_CAM when it does not support alternate modes.
> > +        * There is also nothing to update when the partner has not registered
> > +        * any alternate modes, so don't send the command in that case.
> > +        */
> > +       if (!con->partner_altmode[0])
> 
> Should we move this validation into ucsi_handle_connector_change?
> 
>         if (con->partner_altmode[0])
>                 ucsi_altmode_update_active(con);
> 
> All other call sites are already guarded by this condition.

Makes sense to me.

> Besides, I don't think we need that comment above.

I agree.

-- 
heikki
