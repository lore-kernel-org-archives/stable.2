Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529430;
	b=sRwV25xpKbzyZWj7GL7ZcAGOewvGBmeKRRjMKvG+o2FBNynJfGYntrEotExQ8BO65NLC
	 +PKnd7v0xUpk+F/gLQyiboz2R7ByIhCyu7QvmdSYHsGK/FlVyhZ3tqAlMU9ibcjn/cD25
	 CYCmM/ydc0twOfdw9tSeOWI2AKtTxa/ztKOmKKo6BtayEbmIwo06PESDHbh0lG7Y6nemD
	 d6R+R8v1y3eGir/dubslpwzZjfbN4LzhPGrhIupCs/hIaNssd/baVwOIqkfffjPLQdJng
	 OSh2iU5SO6uT1ikzlInThokjyeTTIsJCqqrT+6QrxSSvduq5nK88/uBf9L5QGrpCO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529430;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=Yf16UmoCdaq2rgm91/Zix7F1KLA/6UUFuc21FWaR1GM=;
	b=RDNfnjqpFQ6chkgLRDudWz74CkOc8j9nezP9A9/7lx+0mIlk00AhhCV6ia/nqmjzMzrG
	 aXsVAfAblTcMR9Xh8RahX/fxalC75lWVAKMvCb6TtxvGNYEHfcFFLBASd6zGgxD3/42Us
	 L/lRYLCF4wJjlKWjrAzWel6V4bF0ZOEZRrwmQX8ImWPQgDF3S7hrwOLqksQqJlWZrnt33
	 r+jAVQ19d9gCsm7p0BIO6+P3KakbRb0TdV0lCZZD6CW2Q+Z83TaRhnVpdVUvyOuIdnAO7
	 CV4whRe1lK8h3SDvwDsEugoC4/YEWMaHJEOToCVLm7Wuv4TTE/6aeMwd6NbEIulhrOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NlZWj9w/";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6F9606A321;
	Tue, 24 Nov 2026 14:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A6F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NlZWj9w/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795529429; x=1827065429;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DbF9blqS58BsaJrl77anwBbzdIRE63KSKh4+UiAGdb4=;
  b=NlZWj9w/DYGwwx6X10B/Emz3NA4vxTeS5ujTmtCAGjb2qxOiGvYy+ELg
   PGVkQx7Wc1roNt4frctDspWpVgYMkZnS03nqGpQuejYa8zbIUmhnBOjgj
   LpcAUC6OYCrCLSxWf+fVaEU5QOg8nm7lKWlO2LYwLWOc6+2XrHSEOT4d1
   TfJbB0oimPrC4/9L6m+Lc48+6P/YGAlnWRwdUYdr5vA0w9r9CAMS/pKjj
   XxHQUurHszu08f8/JjYPq41VKDUQYbWsjOhlBDTEG1QWMfUvIrT7Vq7ZI
   MKR8laKTGRTMwg1D6vJbuegTL7VOIMN8e5xdSbKLwt2kCKeRg4Qssys0I
   w==;
X-CSE-ConnectionGUID: 9IWQfRUWQWuZdumYkbA/vw==
X-CSE-MsgGUID: QYE1cFBVTDOWDl04ReT/3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4458048"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4458048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 06:10:28 -0800
X-CSE-ConnectionGUID: QoaCtDQCQB6HE+TPlvwb+A==
X-CSE-MsgGUID: akfHCXbTS5WImxDVLwN3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11782092"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 06:10:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Nov 2026 16:10:20 +0200 (EET)
To: David Matlack <dmatlack@google.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Alex Williamson <alex@shazbot.org>, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 07/16] PCI: Serialize bridge window sizing and resource
 assignment
In-Reply-To: <DN314UP7ZLCR.39N4XNGLWKR05@google.com>
Message-ID: <42d7af61-bf69-b440-8685-5d9cec4863dd@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com> <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com> <DN314UP7ZLCR.39N4XNGLWKR05@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-391643659-1795523890=:1182"
Content-ID: <56a05202-b09a-9069-dc67-183d2681f167@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-391643659-1795523890=:1182
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0777c4a3-630c-0741-ee0d-4cca22293e78@linux.intel.com>

On Mon, 23 Nov 2026, David Matlack wrote:

> On Fri Nov 20, 2026 at 5:47 AM PST, Ilpo J=E4rvinen wrote:
> > +/*
> > + * Serializes bridge window sizing, resource fitting, and assignment.
> > + * pci_rescan_remove_lock cannot be used for this because BAR resize a=
nd
> > + * some drivers run these operations under device_lock() during probe.
> > + *
> > + * Context:
> > + *  - Nests inside pci_rescan_remove_lock and device_lock().
> > + *  - Nests outside pci_bus_sem.
> > + */
> > +static DEFINE_MUTEX(pci_res_setup_lock);
>=20
> Hi Ilpo,
>=20
> Could this lock live in struct pci_host_bridge instead of being global?
>=20
> As far as I can tell, a sizing and assignment pass never goes above a
> root bus, and root bus windows are only allocated from, never modified.
> So passes on different host bridges never touch the same resources.
> Every entrypoint has a pci_bus or pci_dev to look up the host bridge
> with, and pci_assign_unassigned_resources() already goes one root bus at
> a time.

Hi David,

I don't immediately see anything preventing from moving it into the host=20
bridge struct, I'll look into this. pci_assign_unassigned_resources() does=
=20
process all root busses but sequentially so it should work too.

Not sure if it really helps much currently because pci_bus_sem is also=20
held but that might eventually change (there's the series which=20
attempted to split that into a separate lock in each bus, I don't=20
remember why that work stalled).

> To be clear, the lock wouldn't protect any fields of struct
> pci_host_bridge itself. It would protect the resource[] entries of the
> devices below the host bridge, and the BAR, bridge window and Resizable
> BAR registers they mirror. The host bridge is just the smallest object
> that contains a whole pass.
>=20
> My motivation isn't performance. It's that global locks make it hard to
> tell what data they protect. pci_rescan_remove_lock is a good example:
> it's held around runtime rescans, but not around enumeration of ACPI
> host bridges at boot,

Not yet. ;-)

=2E..I already have another (unsubmitted) series that adds=20
pci_rescan_remove_lock around host bridge setups because they too can race=
=20
with a sysfs /rescan leading to adding devices more than once, etc.

Early enumeration obviously won't need it but to be able to add lockdep=20
asserts to strategic places, I want to cover early init paths too.

The host bridge setup locking series requires though that=20
pci_rescan_remove_lock is reentrant (the v16 series inflight) because=20
there are a few cases that face lock-divergent callers (VMD, some HP=20
driver, some arch code that will be partially fixed by that v16 series,=20
and a few others I don't now recall).

The races that this series is fixing, however, are easier to hit than host=
=20
bridge setup ones, because, e.g., ThunderBolt hotplug racing with some=20
probe() initiated BAR resize does not depend on root triggering a racing=20
rescan call through sysfs.


> and that was confusing when I was working on PCI
> Live Update. This is a different lock, of course, but it would be nice
> to avoid adding another global lock.

Now I actually started to wonder why couldn't pci_rescan_remove_lock also=
=20
be per host bridge?? (+ a separate lock to protect root buses list)
=2E..I think I'll take a look at this as well.

> I tried it on top of this series to see how much it changes. Only this
> patch is affected. It adds a mutex to struct pci_host_bridge,
> initializes it in pci_init_host_bridge(), and uses a small helper in
> setup-bus.c:
>=20
>   static struct mutex *pci_res_setup_lock(struct pci_bus *bus)
>   {
>   =09return &pci_find_host_bridge(bus)->res_setup_lock;
>   }
>=20
> All of the guard() sites and most of the lockdep asserts already have a
> bus or dev to pass in. __assign_resources_sorted() only gets a list, so
> it would have to assert using the first entry.

I can just move that assert one level up to avoid this problem.

> Putting the lock in the host bridge would also make it reachable from
> remove.c. pci_destroy_dev() drops pci_bus_sem after list_del() and then
> calls pci_free_resources() without pci_res_setup_lock. I couldn't find a
> path where this can cause bugs, but that seems like just a lucky
> side-effect of the current code. It would be nice to have the new lock
> explicitly cover that case too.

I don't think remove can cause problems because we also hold pci_bus_sem=20
over the entire sizing and assignment operation on purpose to keep the bus=
=20
devices from coming and going underneath us.

So either:

1. list_del() has already removed the dev and sizing nor assigned never=20
   sees it.

2. pci_destroy_dev() cannot remove it from list until the sizing and=20
   assignment algorithm has finished.

=2E..So to me it looks it works as designed, and luck has nothing to do wit=
h=20
it. :-)


=2E..I think what you were actually suggesting is to extend this new lock t=
o=20
do something else than serialize sizing and assignment calls. :-) It is=20
not meant for that, and even less so competing with pci_bus_sem's role in=
=20
protecting devices in buses.

> This is not a blocker by any means, just wanted to get your thoughts.

I really appreciate you taking a look on this.

--=20
 i.
--8323328-391643659-1795523890=:1182--
