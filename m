Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454015350B;
	Fri, 28 Aug 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875264; cv=none; b=HPxA4yFUlA8WMPYdnixUpgCam388g1c5H1n/crnlxHzGJiu1Fks60b7LeS3xcjr6bsRTbxhqQUN/smWrdGvpWCfYEwn/XbOJIa/w0JcoGPT0vsEVLjcFVY/nu7mkNiUFgfhHzxc0qV9tDXOB9mt8K/koY384dUcDcBHyHoai1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875264; c=relaxed/simple;
	bh=0ZgjCKbMwzVou0p9Ymi/8dYXbBjTAJRAOE/bSdy+T5w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qe2+F2McunQaMaJjwmJ2mc0m/BZzv9ziqQEOTH3v6q3KNrkEXT0SDQxnpTu2o2EWelwd6u7WVpD0cy5XzYrU85buOJSajuFMKMaR4mMYb909YAQ2UNTCtnMewPMgIloUjY7ILmEWXfJqpe1VogDus2pExaZEyl0xxdwFkr+9MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ksUMTLtN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ksUMTLtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87C51F000E9;
	Fri, 28 Aug 2026 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787875262;
	bh=1t/+5302+32dehnpOZOB5oP6Yiq/g0Di93FlB9yrB68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ksUMTLtNhF44DoJZHFPFt6szEg8ujwjFKJPwOJ++2oRPVXQNdr9w//HIPi1oqBl3Y
	 D4l6GQH6ng45ZUvBDc3D1PH0dGZJ2XgL2iot6NQUCR7vEaHrqfSrZsDgiLdsQf00I/
	 dcEH7PGRT3zOkbfsUwpLjIMwAZ3gnOfzVZdXhf4s=
Date: Thu, 27 Aug 2026 17:01:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
 <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
 <tim.c.chen@linux.intel.com>, <dan.liang@intel.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Message-Id: <20260827170101.1261ed1ba5ce3d47adb41f24@linux-foundation.org>
In-Reply-To: <20260826171537.4167367-1-Vishal.Badole@amd.com>
References: <20260826171537.4167367-1-Vishal.Badole@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 22:45:37 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:

> group_cpus_evenly() builds the managed-IRQ affinity spread used by
> multi-queue devices such as NVMe. That spread is meant to be a property
> of the static CPU topology: it walks cpu_present_mask and then
> cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
> including CPUs that are offline at the time. A driver depends on that
> partition staying stable across re-computation - the CPUs a queue is
> given at probe must still describe the same queue after the device is
> later reset and its affinity recomputed.
> 
> On an AMD system that stability breaks across an s2idle cycle. With CPUs
> 3-11 offlined and only CPUs 0-2 left online, the machine is suspended to
> s2idle and resumed. The NVMe controller uses the simple-suspend quirk, so
> resume fully re-initialises it and recomputes the affinity spread. The
> system then hangs for roughly two minutes and stays sluggish afterwards,
> the controller only making progress through its command-timeout poll:
> 
>   nvme nvme0: I/O tag 898 (3382) QID 9 timeout, completion polled
>   nvme nvme0: I/O tag 398 (618e) QID 11 timeout, completion polled
> 
> ...
> 
> Make the cluster grouping depend on the complete cluster topology rather
> than on whichever CPUs happen to be online. Snapshot the cluster masks
> once while every present CPU is online and reuse that view for every
> later spread. Every spread then groups from the same masks, so the
> partition computed when the controller is reset matches the one computed
> at probe and each queue's IRQ still covers the CPUs it serves. If the
> snapshot was never taken, the cluster path is skipped and the plain
> present/possible spread is used.

Thanks, I'll queue this for testing in linux-next while awaiting
further review and testing input.
