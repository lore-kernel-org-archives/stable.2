Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADA472F76;
	Tue, 18 Aug 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062062; cv=none; b=eeldvNcom4eZIxxL9aimBVqcNNeDQzH7TmFy1tEmOgHqHzTDtt3OAbioAMF2XrJ/CmEJJ2Z8sX1lEJ+yoELhR40zEDgNNvgSkVUjJ7lb4W25Wv6Jn2K/A/wBSCYmEFLvoFlThkeWqgA+qQ9FTip7SB6p7cixsJRLhDyIYrARGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062062; c=relaxed/simple;
	bh=9HrHRYB4P4ljVNCJmsrIapZVFDa9DYVcm+v51prrTcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HBc/ZpdentrvMUBEtDXwxmpLX4VHTeZDwAjvnV134UBHZDq+4YZ+Ot7yHtnryYA8lQETq0I+tlbcPXVvbZG1iLIZTx9C0R4sfXaJp+3cgl325rC9XEaK95Yzk7X8AXZhAjzcd41Te+X/dBhsCq/JU5bFKWsZxAdeZ5K1tvMv+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqIAiFlm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqIAiFlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787062061; x=1818598061;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=9HrHRYB4P4ljVNCJmsrIapZVFDa9DYVcm+v51prrTcg=;
  b=cqIAiFlmiUfI88RYAZQTwpZsjNk5F0In8ThbFCU1CFupEqt/Za6Go03d
   zLEDwKUAVo06pVq6Yfaew9io70Yxm8ClbuATDZTZutmHb6I/lEi/WaRDs
   cdXyBp4yEbv7Y7QG55sgJILYbMwHTe7vdet1a+BLwTcjRneJv5DC7nRl/
   +4iV8S/e4Jz/6iJKk21a7BN9Y4e5XRxxX249iNa0E80SGJTVIm/1CQkE4
   /tsRzRyvS/JvSt+fv6Zmu+U8VVxrpoZVUXi+thx/wUQnkWs7tr8sS8oSX
   fJV1Mb013rSEhxsgNyF+1VuSaHHrP/9nUQORhX9KXHk7sBDsGkaFqfAwg
   g==;
X-CSE-ConnectionGUID: QyHaKi/tRdewZ9PsuiXk9w==
X-CSE-MsgGUID: +DEqHcKqTay43FO5Z2fPLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98917748"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98917748"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:07:40 -0700
X-CSE-ConnectionGUID: dHp9Djk+Rkq5U2KebbuBbQ==
X-CSE-MsgGUID: WyX0MHWyT3qYNer70YPs4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262609793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:07:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, HyeongJun An <sammiee5311@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260807144003.3498972-1-sammiee5311@gmail.com>
References: <20260807144003.3498972-1-sammiee5311@gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: ISST: Two ioctl input validation
 fixes
Message-Id: <178706205486.20251.10551775029465079194.b4-ty@b4>
Date: Tue, 18 Aug 2026 17:07:34 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 07 Aug 2026 23:40:01 +0900, HyeongJun An wrote:

> Two out-of-bounds accesses reachable from the ISST character device
> ioctls, both from user-supplied index values that are not bounded before
> use.
> 
> The first is an off-by-one on socket_id in the CLOS association ioctl,
> plus a missing NULL check on the resulting instance pointer. The same
> file already gets both of these right in get_instance(), which rejects
> pkg_id with in_range(pkg_id, 0, topology_max_packages()) and then checks
> the instance for NULL before returning it.
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
[1/2] platform/x86: ISST: Validate socket ID in clos_assoc ioctl
      commit: 9100b71ea369c2d9cefd3ed607f683087ff4b03c
[2/2] platform/x86: ISST: Validate level in perf mask ioctls
      commit: 74bb8134e55402cdd809d1613cac40765c6711c8

--
 i.

