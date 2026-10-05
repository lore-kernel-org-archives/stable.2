Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76A4CDA20;
	Mon,  5 Oct 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214674; cv=none; b=ZtwB1/UgeuSwUnKBosiP08KZYFILmd6YXrC7c14D0lBylV9jZajXsyKkkM6f35uEYLvclL/mexABWZLNm+3veOBn7fmpdUZu6Oj05uK1LlnhJn1YQQa21KSKwrAsILbEq4AgwtmxApwVLUdsnHY21K/yDt7BMfMjYzNUgyNPd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214674; c=relaxed/simple;
	bh=f4r+XfxffhNNNqtRA6T6JeCh+ER1EcQrXGPNGhvWxek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8IFZI5iiRokEpzVmmx3+51SW0x/PSkOSNsl/+4HexGAgOnIL3sxVyid7qbuxiDGPzoLEdwuVdAylyAiTe42jcjKrJQErNvO6+X5HYpX6mMYXcOX23pDq4KlbjC+JBwJQGDiFXySCi2tanLqNIYx9ApeKIflFTvFTpiVLCGhPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAml9YF1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAml9YF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791214672; x=1822750672;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=f4r+XfxffhNNNqtRA6T6JeCh+ER1EcQrXGPNGhvWxek=;
  b=CAml9YF12Rg6Z/oRM0U0rTAmivb7hn999H7XnbLRXDb7Sy7Lv0DliwW6
   M5Bk+9KBTE3yfDaOKIJvgjZUA+aHoMYpoTRTKFo9I1rHFtzYkS/Uel8Uo
   FlL92SrX0OQMFGIQhNtsZ86p9TKfM7tU9ziJ/6b3CKzxfFnPQjcNQIOYC
   btdLXHRrWykjEM0X5FlSe2PiVW/OC5IJA1f4731pvOmmaYKbf+9OXwylu
   /Xx7jmbh2XOTR17aKCcLtuDxrkEUesq3zHMBqPixpeC639E/BkLd6p3qJ
   c/VYmI6Y9VRNXr0rhO0At++W4oqz1sS4kJyWVXuNZoW2ahh7fOegCglAr
   Q==;
X-CSE-ConnectionGUID: YCF8SJPiQ6iBK3+IxuVrVw==
X-CSE-MsgGUID: 8pKbkGlXT8ijvd/4XGvoMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91995664"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="91995664"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:37:52 -0700
X-CSE-ConnectionGUID: t2fLNjRLQg6hmpGQwWu02Q==
X-CSE-MsgGUID: fQYzPph4TCCdVDWjWHb2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="874036"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:37:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Muhammad Bilal <meatuni001@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260826103012.240453-1-meatuni001@gmail.com>
References: <20260826103012.240453-1-meatuni001@gmail.com>
Subject: Re: [PATCH v2] platform/x86: hp-wmi: fix heap OOB read and memory
 corruption in hp_wmi_perform_query()
Message-Id: <179121466646.12659.18198017075450025095.b4-ty@b4>
Date: Mon, 05 Oct 2026 18:37:46 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 26 Aug 2026 15:30:12 +0500, Muhammad Bilal wrote:

> hp_wmi_perform_query() evaluates an ACPI WMI method and expects a
> struct bios_return header in the returned buffer. However, it only
> checks that the ACPI object type is ACPI_TYPE_BUFFER without verifying
> that obj->buffer.length is at least sizeof(*bios_return) (8 bytes).
> 
> If the firmware or ACPI method returns a buffer shorter than 8 bytes:
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
[1/1] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
      commit: c59252fa6260423ec3c4aa90b144fcad66851c76

--
 i.

