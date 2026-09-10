Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247014BE435
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057426; cv=none; b=phMFIpaSnNZLyb7sb/59VYZ7srrm9qcczWjVAswrsTgcHSy+iuZ1sUxYAGQoIdZCxHwQR0OIjyWopegW7J0tEgV0/kwIK1IVw1AgxNk1oII/00NrRTaD74GtAU3PxXiIBPZl/WSf2sun8q0Sm6uC7/s69LfM0Ihg2Id+faCL8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057426; c=relaxed/simple;
	bh=YSghPuclO7gQiXTLDzfE4bkBtKUF1sJO1s/E7HVHRx8=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=YAWSDRSiDAMdCA81zEvfbSHmhFynmTcay5sqCW9SGo3kY7IBiWo3UUj5sSDHiifhNLnb4hI/RtCnWM29F+i/VkeOH95aKsLvy9wNlhGwqi6vxWzgYLgsGiETqSX3zPB45RESTJfbY1fuiO/iS+DCmHHbWqkoArlVb3vX9E+8jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=CctjByDp; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="CctjByDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-type:content-transfer-encoding:cc:content-type:date:from:subject:to;
	s=s1; t=1789057423;
	bh=Ojl/NWsC9MSjDYgGDCuYdo4PQAJl7yOv7aALgpvhTkU=;
	b=CctjByDpfVpmnxgsUyiWguRtHQFglltrewxGSBTFmzx1pQDJTZZ4NMZ5bOva2GKcYVY7
	TNFulDf3GzGJNpZSCfjYZUcwzzcYmr3ahV8JfXCHxkk9jdOYyvKOPdrjoq3OazNtpyHlmv
	ns/FsTmTLLChVAuywYtb1G4Q4oj1nPb7194jTOwOwUCOt6aFolv43GCYMO21YsWUpYHzkJ
	g3kRUQ1FGVfOKUNC8T/DpBdSaLK9tBJjzgx1IAwixQVmg2k2NTaLF4gyv7psrpHsBtw0fk
	1GpyIlSnu91vSaGImW+BZD6sNdOCQouVSy0svPb8rhgvQRJEKj+1oyTPc1NXiDTg==
Received: by recvd-69664d99dd-bcjr2 with SMTP id recvd-69664d99dd-bcjr2-1-6AA2D98E-78
	2026-09-10 16:23:42.801218343 +0000 UTC m=+836507.408174706
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-6 (SG)
	with ESMTP
	id uocpkYPWStS876SvS2QkZQ
	Thu, 10 Sep 2026 16:23:42.691 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v5] PCI: Fix BAR resize for devices on a root bus
Date: Thu, 10 Sep 2026 16:23:43 +0000 (UTC)
Message-ID: <20260910162342.9854-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <29c5916f-da42-58f0-d4c7-815bbaed711b@linux.intel.com>
References: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io> <29c5916f-da42-58f0-d4c7-815bbaed711b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmednNviVbiXOC?=
 =?us-ascii?Q?oREWn0PvvJP53Uz8gPPC5zPjaNtjMPM+hLjOqwU?=
 =?us-ascii?Q?QawE=2F3B72uKOWIppfuG513fXq618S6PDhcLtW4t?=
 =?us-ascii?Q?6mNk3XgvuMeDVZkUvWdsdZ4eV2RtJ1CssKu6wNa?=
 =?us-ascii?Q?RESe8rnvPTUkNNkPAVyHBGFmtdEKysMLnVW8vKJ?= =?us-ascii?Q?qAK3?=
To: Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Liz Fong-Jones <lizf@honeycomb.io>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, Jon Nettleton
	<jon@solid-run.com>, Jon Nettleton <jon.nettleton@gmail.com>, Jacob Martin
	<jacob.martin@canonical.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Ilpo Järvinen wrote:
> Great, it worked (I was somewhat afraid there might have been some
> landmine for the case where there's no bridge).
>
> And yes, it's very important in general case to assign the resource in
> correct order because the assignment algorithm is greedy.

Thanks, Ilpo, for both reviews.

Yes, it works fine even without the bridge. This is what it looks
like when triggering the resize through sysfs, and through amdgpu's
probe-on-insmod, on the actual root-bus hardware (HoneyComb LX2K,
LX2160A, dGPU directly on the root bus, no upstream bridge).

Manual trigger via sysfs (shrink then grow back, forcing the release
+ reassign path both directions):

  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa4ffffffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 2 [mem 0xa500000000-0xa5001fffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: assigned
  pci 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: assigned
  ...
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: releasing
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa4ffffffff 64bit pref]: assigned
  pci 0004:01:00.0: BAR 2 [mem 0xa500000000-0xa5001fffff 64bit pref]: assigned

And the real-world path, amdgpu's own probe with the amdgpu.rebar=0
workaround removed:

  amdgpu 0004:01:00.0: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
  amdgpu 0004:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
  amdgpu 0004:01:00.0:  4096M of VRAM memory ready

No "Fatal error during GPU init" (the original regression's failure
signature), full IP block init, driver comes up clean.
