Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB88309EE9;
	Mon,  5 Oct 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222267; cv=none; b=ia6NXtBZUVFj7gUr2Vv5hcvOtC8blbpvgFC9S1RLwO7Cpu1ut3I9hMXBqYfrZO2Ei9vXE8vOX9WXXwgo9XvBHDQ3gHyTl8Dgm/nN3vUztnv/izZtan/UyoAd8NybuN+VACG7sljOCXs8kRNIPdNGG/dptjn32s0BqXIDd1PfrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222267; c=relaxed/simple;
	bh=WHp2M1rXPQkBqwAVqhzoj8S3ciydRsD1jTJkTnh1l+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BO5U1U/cGrg9bIBBNsiCQRMDkEXa0Ze8xevMVpRUnsvjOZ5rmV1TiNBXwkS4+QTai/YToAPu3qiTvcQAexLej8dbBumwNiUau2QuKenojale8kOOG5v9n2uiIGZfh79qFMIWablcK0JXPa54u9uDL09L4EQwMlqvNaTkpARS+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzb5hE7w; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzb5hE7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222266; x=1822758266;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=WHp2M1rXPQkBqwAVqhzoj8S3ciydRsD1jTJkTnh1l+U=;
  b=kzb5hE7wBP3ulE/XcEjJnZwi2rcsf/fEvqmTxsETFYv1G0c1KDkA4D4B
   ZeCKFiXT+aO87MYFcmbR5Ah0c2wlq+T0Ij+l7ItlIAXzKc6uD+KhdrKrg
   IN7994OIhoFUdad28ibc0gQhfOOycgDspj9eYUJInrbabuNQ4v2K0tmRA
   mD4dyMlXuXFsvRVNbWezbdHmzi14Sy1bCxCRnvemNoErw5VayPu77mp9z
   /TZshrapH63ts6SJ6/Trw5UmDawVfbJwMSNoi1j1IlfRYBgO2X4+4Wo/i
   8CsfvnXRdw6aOjxVakB2lRKf4GapHgyL1uuxECi3+GgM2e45mlBVWS8Aw
   g==;
X-CSE-ConnectionGUID: Jd0XLQhxQKqIiC+WTUQSfg==
X-CSE-MsgGUID: tMS6lSQ8Qcul3PBLuqsKpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94391007"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="94391007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:44:25 -0700
X-CSE-ConnectionGUID: XW+BQ1giRjudbei6XbK9MQ==
X-CSE-MsgGUID: is1GrpTXRUahI3+5O7Ozpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="314881982"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:44:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, Jack Boykin <jtboykin.jb@gmail.com>
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260902210217.69483-1-jtboykin.jb@gmail.com>
References: <20260902210217.69483-1-jtboykin.jb@gmail.com>
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix power_supply refcount leak
 in amd_pmf_get_battery_prop()
Message-Id: <179122225584.27048.14844877345530075961.b4-ty@b4>
Date: Mon, 05 Oct 2026 20:44:15 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 02 Sep 2026 16:02:12 -0500, Jack Boykin wrote:

> power_supply_get_by_name() takes a reference that is only dropped on
> the error path. On success it leaks, five times per policy evaluation.
> Unregistering the battery later trips the use_cnt WARN_ON in
> power_supply_unregister() and never frees it.
> 
> While here, return -ENODEV instead of an uninitialised 'value' when
> no battery matches, and stop at the first supply found rather than
> letting the last one in the table win.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86/amd/pmf: Fix power_supply refcount leak in amd_pmf_get_battery_prop()
      commit: 6676654ebfc858cfc416b44d7687ccc6bfe0b021

--
 i.

