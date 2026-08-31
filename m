Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DD3B4EB0;
	Mon, 31 Aug 2026 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151953; cv=none; b=YkAqt2Rh4ns63ixd7yQ5+/GhETAJASGp82i2xxQKNXqn6GFCFx+a2ekAmVSvQg8qvDFgtXI1toCpBNaYPwIpphX/+pCmUR2zx5pi5q7tqM3JCfk9G3S9cNyr4Aq7eABJ/6O+oo6HO30vnV+NS7VAl6yUBhMM3frzWTirIx1M38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151953; c=relaxed/simple;
	bh=tA9l5/dHuAPYTIdiGZKyC9du4c+Yc06j2MqdBYQrNXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgu8sIraMX1eA2w5iQAeyCVPc7U7VT9XgUEzk9erhAVGDG3CvJ0MIG5Tkx9p6qESl2KQLhohZu5C9FVg3Jkp0+tdljWQ0NsUE3fFuWmxPhm3YelsS8aDw7eUFMkC3OHAZkvxFyigMiFQIeU4RffobTF8BayctsH1mBxEfIFLyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrGYb1RY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrGYb1RY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788151950; x=1819687950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tA9l5/dHuAPYTIdiGZKyC9du4c+Yc06j2MqdBYQrNXM=;
  b=YrGYb1RYuw3fmzIb7x7UlCzfPIkq2Vt5l99d67UCqq/TL3GplskFXRjW
   2nPnipKFEY77aqap2iQKEjs1kVCNoDg8UYZsBPFmYYUckC/UcO3uuowXX
   DwXRp7vbRD/uRRvPbFnSr9VGpRGHcLkHk+SgJE3fycMWDkp7HBghSVNRw
   7ZhcVOFs32Sedfl/7v1lA2jfhTi1rOLg3hV+GifrzoQKEEqzsFzse5FLM
   GmIVNxd5DoXsWRjY1MxVl8TnLcpIxXZH5OgAq/1FKSY7tBeghCyYCd2Qn
   UnOJWPKyyXhojJNh5ELy7GvJza4G8qOD2/g8PmObE3c4FV8YRMGPg3PXd
   A==;
X-CSE-ConnectionGUID: rEpr4XXvQhWr3slCfycUKg==
X-CSE-MsgGUID: fOuyuKbQTMOmtCVrXRL+Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76094333"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="76094333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 21:52:30 -0700
X-CSE-ConnectionGUID: K1ui655VRYa5eMuYx1ZGRg==
X-CSE-MsgGUID: PnOShGilTGSPN7IWoTdfug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="293499621"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 30 Aug 2026 21:52:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 17CCA99; Mon, 31 Aug 2026 06:52:26 +0200 (CEST)
Date: Mon, 31 Aug 2026 06:52:26 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: =?utf-8?B?RnJhbnRpxaFlayBUaWNow70=?= <linux-development@tifran.cz>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Gia <giacomo.gio@gmail.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	westeri@kernel.org, linux-kernel@vger.kernel.org,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	kernel@micha.zone, linux-usb@vger.kernel.org, Sanath.S@amd.com
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
Message-ID: <20260831045226.GA124825@black.igk.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <CAHe5sWYnbJAjGp66Q4H0W_yk9uYTcERmW=sPvJSWTsqbFZFCVg@mail.gmail.com>
 <9659dd5d-af8d-4100-8fc1-ceca42223827@amd.com>
 <f8d6f64b-0783-46bc-82d9-cd56da07cac0@tifran.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8d6f64b-0783-46bc-82d9-cd56da07cac0@tifran.cz>

Hi,

On Sun, Aug 30, 2026 at 11:33:31PM +0200, František Tichý wrote:
> Hi all,
> 
> I've run into this issue on 7.0.10, 7.1.6, 7.1.8 and 7.1.9 (specifically
> Linux 7.1.9-arch1-2), as well as LTS kernel 6.18.45.
> 
> to Mario's questions (thank you for them; they were captured on the
> 7.1.9 kernel):
> 
> > Can we please get some kernel logs for these two cases on the command
> line?
> >
> > thunderbolt.dyndbg=+p
> 
> Here you are, the system does not load the graphical interface:
> https://gist.github.com/Poirot12345T/be6b7849e039687e248b8c302615d9f3
> 
> > thunderbolt.dyndbg=+p thunderbolt.host_reset=false
> 
> In this case, graphical interface loaded successfully:
> https://gist.github.com/Poirot12345T/c63a1a3b2b6609b30a1182e7681fbec1
> 
> > Also what is the value for:
> >
> > $ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection
> 
> That returns as "1" on my system.
> 
> I've also done some digging myself, here's what I found out:
> 
> (note: I will use host_reset=0 in this post, even though the thread used
> host_reset=false. These two values are functionally identical.)

Yes correct.

> Originally tracked down in amdgpu bug tracker
> (https://gitlab.freedesktop.org/drm/amd/-/work_items/5632) and based on
> the suggestion to use thunderbolt.host_reset=false mentioned in this
> thread, I traced back the issue to commit 59a54c5f3dbd (authored by
> Sanath S, CC'd) which touched drivers/thunderbolt/tb.c (Thunderbolt/USB
> subsystem, added Mika Westerberg as a maintainer and CC'd linux-usb
> mailing list), more specifically function tb_start() and this code block:
> 
>     /*
>      * Boot firmware might have created tunnels of its own. Since we
>      * cannot be sure they are usable for us, tear them down and
>      * reset the ports to handle it as new hotplug for USB4 v1
>      * routers (for USB4 v2 and beyond we already do host reset).
>      */
>     if (reset && tb_switch_is_usb4(tb->root_switch)) {
>         discover = false;
>         if (usb4_switch_version(tb->root_switch) == 1)
>             tb_switch_reset(tb->root_switch);
>     }
> 
> This block should be located between lines 3060 and 3070 of the above
> mentioned file as of the time I am writing this post.

Does is work if you boot with the device connected (and host_reset=0) and
then once the system is up, unplug the eGPU wait a little and plug it back?
That's essentially the same thing as what host_reset is doing and is pretty
much the nature of buses like USB4 (e.g the user can unplug the device at
any given time and plug it back later expecting it to work).

> I was able to reproduce this issue using AMD RX 7600 (journalctl dump
> link:
> https://gist.github.com/Poirot12345T/909f3d071f87655d875445e536da74d3).
> I have also tried NVIDIA RTX 5060 with the nvidia-open driver which did
> not trigger this behavior in the default setting. (journalctl:
> https://gist.github.com/Poirot12345T/4deeae10508e3971521aca9e612b5737)

It depends on the GPU driver. Some of them are prepared for PCIe
hot-removal, some are not yet. With the rise of eGPUs I would expect that
we are seeing more and more support for this though.

The ones you shared above looks like amdgpu driver and I don't see any
issues in the dmesg.
