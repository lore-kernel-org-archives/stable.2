Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928051D53E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790288; cv=none; b=nxACOQQ7sCq+M+wcJDusM8ZhhqmC2p3VZ2GlJ8R8xu73TsG6hw7qRPvPPSH3Q5HWjHpDUhJQZFF23z7Ko9ppeuE1UnrtVmP9bXNPj0hSL1Ajvj7DHWb/OZvbTEmTaa+6j7vAXEBpi9NqVWcc30zUborvV0VBfWFGihwPV1uS4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790288; c=relaxed/simple;
	bh=HcucV7wgiRMMEHx0lghEVWHPqjfrLbu0IX9nEMYH68Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoXKBbwQpv+Svw6hPIvec/Civpw4Nc7+F9+4dt1HaVrLDW9gge8tP1s9qmUp2xi3gekfu4+eLTEH7UmYieoSPlWmLhYDiPDYCIc/rnBqpUjKHzNb9UHDqBOwU/yD/iYkeJloPb5/YenOcVP7BHYq/XFA6t9qsABwixrKUMEWbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfojU6ss; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfojU6ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790790287; x=1822326287;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HcucV7wgiRMMEHx0lghEVWHPqjfrLbu0IX9nEMYH68Y=;
  b=IfojU6ssoGYOq0YCJFUh2HXGEdaxFajQUzHuhml0lRsNoO25qDkQ6Lf4
   2ywMOwXHx6zLt9uNVZmN+FAAnS8r8g089WAtEdDrbis7iMu7lWX9ZC0Ru
   46eLGLMwEHY+5xV/wxgTQ63va1tyq2bsA7EaDydTYbGuxo2SPUkyANKkR
   gNVTmGkf3lmfoVE1fruEnNiuYicWhw0+o6zW3EGp/n5gfs4gM9kb0Uu8/
   3Swl9PsjjmKY5naehBcEq1w2LBm796WNjH6rkOFN0QD0+WpyzHLctZW8T
   +l6rktqmOqZ94DgDO+BVmfok9ccO2ko/Mi5okQwZYqjtZ4C6ulNbroazd
   w==;
X-CSE-ConnectionGUID: MgwWTHAtQKq3DydrsrsvJA==
X-CSE-MsgGUID: KLwhkLDrQgqshG5ZCSKaUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="113324188"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="113324188"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:44:46 -0700
X-CSE-ConnectionGUID: 2w1g4d8YR/yrrLbswK0efw==
X-CSE-MsgGUID: GTE+e7i9Q0esetPlUWdEnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="313685252"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.190]) ([10.125.111.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 10:44:46 -0700
Message-ID: <f313695754cff402ca802e71302463b6c5c731ff.camel@linux.intel.com>
Subject: Re: FAILED: patch "[PATCH] sched/cache: Skip kernel threads for
 cache aware scheduling" failed to apply to 7.2-stable tree
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: yu.c.chen@intel.com, mingo@kernel.org, peterz@infradead.org, 
	stable@kernel.org, stable@vger.kernel.org
Date: Wed, 30 Sep 2026 10:44:45 -0700
In-Reply-To: <2026093056-santa-ecology-041c@gregkh>
References: <2026092935-angelic-kick-1d0a@gregkh>
	 <850294df0f51d6ccb131557af74d4a42dde00b3a.camel@linux.intel.com>
	 <2026093056-santa-ecology-041c@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 14:10 +0200, Greg KH wrote:
> On Tue, Sep 29, 2026 at 03:45:46PM -0700, Tim Chen wrote:
> > On Tue, 2026-09-29 at 13:43 +0200, gregkh@linuxfoundation.org wrote:
> > > The patch below does not apply to the 7.2-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >=20
> > > To reproduce the conflict and resubmit, you may use the following com=
mands:
> > >=20
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-7.2.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 65efcccddc83d6a19e8a2e2a6117811e39e589bf
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092=
935-angelic-kick-1d0a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'
> > >=20
> > > Possible dependencies:
> > >=20
> >=20
> > These patches in upstream needs to be applied first before this patch:
> > f0d243a96f268 sched/fair: Avoid creating misfits during cache-aware bal=
ancing (should be included in stable)
> > 28f9c0e0a0b94 sched/cache: Decouple sched_cache_group from mm to fix UA=
F  (just merged in stable)
> > b636fef85bda7 sched/cache: Introduce task_struct->sched_cache_grp to fi=
x UAF (should be included in stable)
>=20
> Can you send a proper series?

Hi Greg,

Sorry for the troubles.  I have sent you a series that included
all the patches.  Some you may have already applied but I still
included them so show the order of the patches.

Thanks.

Tim

>=20
> thanks,
>=20
> greg k-h
