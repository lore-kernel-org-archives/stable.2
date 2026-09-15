Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981893905E6;
	Tue, 15 Sep 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467962; cv=none; b=BVQoIfKd2AUiDUJQL8q91ZrrBc424s9c9UJXaLpoSrM1hLo27QqVQNyEJCLdDa1QhUzykLxJ3qV4umRga6OTqQorzdU6d879FXpdUfndYZmT+2d7XsOnlAaD7UL3MKFdIXRj5097GRkwGm7W61ardWpYnmI52UKopYsDKhWP+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467962; c=relaxed/simple;
	bh=NucUngAYc2cV45RFHzFf4AH61JUn2DVo7aG9EjjWCf4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g848hkbnvU3lZYHBBCGJt5jPVprSOId+JJ+ZtXUndEU/NzBzaZwI5vHozKT3UE9c+u3q0+p70t9E0klemmjcicLWU+wXgephn0w5Azvvmcks/5bEDC7X/nnfAAzP7+ascNlsUgQAonZXfI+S9ZOIUe6cBEc/srTN72zJJ2gKvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fadUO1Eu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fadUO1Eu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467959; x=1821003959;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NucUngAYc2cV45RFHzFf4AH61JUn2DVo7aG9EjjWCf4=;
  b=fadUO1Euf7+1aNvTF3Sw2M7rebLUd9/GiCgb45MpgysE/b8s3AsZHfsM
   mIBls/zR2VvTu5mOp7xnXY6XYtW02HSode09JJAxH3VWFZn81vrnX2zL0
   jYSicLSnqBVgS7sRrnTn/Fp7aCdXMZtGuSxkU+dMNvvaguB13CfA/3UQ0
   DVD/nPhhVPst8a44MnCfgG5Xx10sSqIBJ8nFrczKTh5HiDzGH9BqgEcP2
   AwuhzFm/H3Hoi8HkJ1FmDT4hYbXnMBizDbq6EUVrxLn8Ag6F6V3uGGQEx
   /jlVCsclCfA1W9Qy/z07xt7bZGHZCZMtZ1xUWva4nrP5VMGIpd91TZWoV
   w==;
X-CSE-ConnectionGUID: b+tutgheRlieXKkRvVFQEQ==
X-CSE-MsgGUID: Qe8fQY/GTJSwbPkFgev4EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101343248"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101343248"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:25:59 -0700
X-CSE-ConnectionGUID: bJQaPSO0Q2mBAs0lZ2Pzlg==
X-CSE-MsgGUID: HS5Txu3USeSGsIJjIFHd9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1181940"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:25:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Sep 2026 13:25:51 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Ma Ke <make_ruc2021@163.com>, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/pmc: Fix RTC reference leak in
 amd_pmc_verify_czn_rtc()
In-Reply-To: <96aea084-ed8c-49dc-8a79-e05f8412c904@amd.com>
Message-ID: <a4ffd941-952d-e63a-4454-47623e1403db@linux.intel.com>
References: <20260914122002.1701233-1-make_ruc2021@163.com> <96aea084-ed8c-49dc-8a79-e05f8412c904@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Sep 2026, Mario Limonciello wrote:
> On 9/14/26 07:20, Ma Ke wrote:
> > amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
> > takes both a device reference and a module reference on the RTC
> > driver. rtc_class_close() is the matching release, but it is not
> > called.
> > 
> > Use a single exit path and close the RTC there, in the same way
> > ntp.c:sync_hw_clock() does with its out_close: label.
> > 
> > Found by code review.
> > 
> > Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer
> > based S0i3 wakeup")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> 
> Rather than adding all the gotos, can this be done with a __free() cleanup
> call on the declaration?

Yes, that's what I too want to see.

I think adding a local DEFINE_FREE() is necessary besides just using 
__free().

-- 
 i.

> > ---
> >   drivers/platform/x86/amd/pmc/pmc.c | 22 +++++++++++++++-------
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/amd/pmc/pmc.c
> > b/drivers/platform/x86/amd/pmc/pmc.c
> > index 6792aa2c6187..543bd95e4766 100644
> > --- a/drivers/platform/x86/amd/pmc/pmc.c
> > +++ b/drivers/platform/x86/amd/pmc/pmc.c
> > @@ -671,33 +671,41 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev
> > *pdev, u32 *arg)
> >   	if (rc) {
> >   		if (rc == -ENOENT)
> >   			dev_dbg(pdev->dev, "no alarm pending\n");
> > -		return rc == -ENOENT ? 0 : rc;
> > +		rc = rc == -ENOENT ? 0 : rc;
> > +		goto out_close;
> >   	}
> >   	if (!alarm.enabled) {
> >   		dev_dbg(pdev->dev, "alarm not enabled\n");
> > -		return 0;
> > +		rc = 0;
> > +		goto out_close;
> >   	}
> >   	rc = rtc_read_time(rtc_device, &tm);
> >   	if (rc)
> > -		return rc;
> > +		goto out_close;
> >   	then = rtc_tm_to_time64(&alarm.time);
> >   	now = rtc_tm_to_time64(&tm);
> >   	duration = then-now;
> >     	/* in the past */
> > -	if (then < now)
> > -		return 0;
> > +	if (then < now) {
> > +		rc = 0;
> > +		goto out_close;
> > +	}
> >     	/* will be stored in upper 16 bits of s0i3 hint argument,
> >   	 * so timer wakeup from s0i3 is limited to ~18 hours or less
> >   	 */
> > -	if (duration <= 4 || duration > U16_MAX)
> > -		return -EINVAL;
> > +	if (duration <= 4 || duration > U16_MAX) {
> > +		rc = -EINVAL;
> > +		goto out_close;
> > +	}
> >     	*arg |= (duration << 16);
> >   	rc = rtc_alarm_irq_enable(rtc_device, 0);
> >   	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
> >   +out_close:
> > +	rtc_class_close(rtc_device);
> >   	return rc;
> >   }
> >   
