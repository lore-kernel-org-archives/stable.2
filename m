Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700741A519;
	Wed, 22 Jul 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735525; cv=none; b=Y14llxo2lRkmRGuvAsgQPcq8yU8mL+6gUHYxknDc+oDwll+JVdtHFIUCUQlUa1nwsR/GNibWK15oQcVl4QviauglVr6e4j8YHusOfjdapWPANqSkEYaEUxF3NI9RIHQGQ3F1co08XCbs2osX0j3NLycMvvPcRBcChJPd//ZMW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735525; c=relaxed/simple;
	bh=d01zzY8JpQv9yxL2KBCoOwtW2eehVW5xpHM0F/+SopY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEpBFmoZVP9OlAMdAypQtuhqypkI0zRMO2oqXmRLsJ5pCo9gmYtKcQe6TyFNNKg+1bpjSxsdlNlVRfbRaRANuuIPVFVNfDgGf/P05lTGxXmrSQ+gMxSWVj9134UrzTLJtO9Az//N2Fd33ZgR81W/8dNHBwfRv3YqDqdqWPxcjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJz+SuU6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJz+SuU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784735521; x=1816271521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d01zzY8JpQv9yxL2KBCoOwtW2eehVW5xpHM0F/+SopY=;
  b=UJz+SuU6tQhjPrvxotE+SIN4Fe2ldIZzcPpLttHcb4wDyNIZKJoS1IGi
   RQZoBUxowBAMuYD/Bk9k8ebUmgH3RT11iRk/llrSEq67bzp2gzRUNvZBm
   CJzFecUI0XGQn2lv2oaZkKQzsYczXn8ljWCw1dM3rD1GoYqzTXU539xYs
   I7e1nsVPT9CzldU1C/kmHNtZrnGdqIv0KeZG71gdXdN88E2Mm6GQ/dmQ+
   58UfqLbUBMbA7SBTzHx6N0t5hN1OUs8FYfyvXdWGtDPE401gfvLDlHn+4
   f5nbKjod9OhaSXJDXfO5UP4vDO29z9rcHlwzEaVLK0boiknJytFxG/7T5
   A==;
X-CSE-ConnectionGUID: Jaw/lcD3TvOKGAiVh1ttRQ==
X-CSE-MsgGUID: /O/beLzUTOyeoOP2a+YVTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="72916851"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="72916851"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:51:59 -0700
X-CSE-ConnectionGUID: sXuzmB/FTDaSFbIy2B6bXg==
X-CSE-MsgGUID: hsQxKDs9T3SzSk6WQ1/o2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="258191820"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 22 Jul 2026 08:51:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 91EB698; Wed, 22 Jul 2026 17:51:56 +0200 (CEST)
Date: Wed, 22 Jul 2026 18:51:54 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Fix use-after-free of ucsi on
 remove
Message-ID: <amDnGh33sH-yo8nb@kuha>
References: <20260718021142.3146566-1-fanwu01@zju.edu.cn>
 <al8thH8aWmMOUuAZ@kuha>
 <F4203724-2CD7-446A-B766-79015B8E37B2@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4203724-2CD7-446A-B766-79015B8E37B2@zju.edu.cn>

Hi Fan,

On Tue, Jul 21, 2026 at 10:47:59PM +0800, Fan Wu wrote:
> 
> 
> > On Jul 21, 2026, at 16:27, Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> > 
> > 
> > I don't think this is enough. You now create a window where the ucsi
> > is unregistered, but you can still call ucsi_notify_common(),
> > ucsi_connector_change(), etc. So you'll end up with even more problems.
> > 
> > If I understood correctly the long explanation (I'm guessing generated
> > by gpt-5.6), the problem is that ucsi_unregister() disables the
> > notification, but it does not flush them. My proposal is that you fix
> > that by setting the ua->ucsi to NULL after calling ucsi_unregister()
> > and then always check it in ucsi_acpi_notify(). You probable also need
> > a lock for that.
> > 
> > thanks,
> > 
> > -- 
> > heikki
> 
> Thank you, you are right. The proposed reordering does not protect the
> connector state freed by ucsi_unregister(), while the notify handler can
> still enter ucsi_notify_common() and ucsi_connector_change().
> 
> I also see that simply serializing the handler with ucsi_unregister()
> could prevent pending command completions needed by work being cancelled
> there. Thus, a driver-local reorder or NULL check alone is not sufficient.
> 
> I will drop this patch and investigate the appropriate synchronization
> scheme. Do you have a preferred direction: should this be handled by a
> core-UCSI quiesce interface, or by a transport-side locking protocol?

Let's keep this in ucsi_acpi.c for now.

Thanks,

-- 
heikki
