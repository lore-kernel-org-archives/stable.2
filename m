Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C047D933;
	Wed,  1 Jul 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905466; cv=none; b=GHDWXP4lmZzwsYaOaxk/wgHXQYY9Y+SsTOIjOcsUxXWBaxce/FsVipUJTJrZQLtbf6HNt2ehY2tkUXhDtmSTUhl82eJ+pXfHvBHHm87cp6TiOV4bxwGYr4JM5qX5PJY9NJxnb3S0dpQHhWLDALHt1nNHGo1lPgbBfpHmm9abPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905466; c=relaxed/simple;
	bh=n3U/JKxIldXswCDYEFKm//QA+bbG73EakfmSHVKLGao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GgosuL5pVgIrqZl4HSObxeYUnFwNiuJCo3bdVKLsxOvQaLJz3w3R8X/jrlDhTXTQdfqyfowOBx+NgiH8V/XeP77nw69QZ5LC/AIHmyuUvW5AWsP6SmovgB11DsS9mEWFrxPeeBKJhJfLfe4H7H3sUEGNv1f9tCmrYaBLQSK1M08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOvNQZba; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOvNQZba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782905455; x=1814441455;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=n3U/JKxIldXswCDYEFKm//QA+bbG73EakfmSHVKLGao=;
  b=aOvNQZbac5IAVZUXsIoKsOUjS8fU2WUYHk8/FammQR7F///TyofUaU5B
   Fz7IZ236Emadt9Wrg8uff7tJ4ukqVe7OHtPnsy1k2sG3L1MDhsJOq4Bk1
   CLePKdeFlLugAUr2ebjeYci43Mla+TZ0xI3PI0i4nhKaEFlV8G0kuqMac
   CdVa5mARUl4OF1j9tZJMR9rpPOAiHYWvushc/mPta6rHVA6xw2iGyROt9
   qWLQaLsplgZaQaWxvFsiRaxvI8te7LbDJbiltFvLrbLyDcOhDsvIY6RUJ
   07fMomYWhFbE/oswIGwDz1r3KZ2WcDxcWE07pQ6AcrT+lNM3N+SR3rA+H
   Q==;
X-CSE-ConnectionGUID: jKyfxPHJQ9O92lXZ3jAuNA==
X-CSE-MsgGUID: QsyGsXnYRgSSKlIh89pmrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94790895"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="94790895"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:30:54 -0700
X-CSE-ConnectionGUID: 7FiqlKuYT9GRNmaLww/nKw==
X-CSE-MsgGUID: g2qiDsfgR2ijDBmUBXdMlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="256463408"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:30:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>, Hans de Goede <hansg@kernel.org>, 
 HyeongJun An <sammiee5311@gmail.com>
Cc: Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260614045353.143500-1-sammiee5311@gmail.com>
References: <20260614045353.143500-1-sammiee5311@gmail.com>
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: Don't hex dump
 attribute security buffer
Message-Id: <178290544609.22449.14194327862270091885.b4-ty@b4>
Date: Wed, 01 Jul 2026 14:30:46 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sun, 14 Jun 2026 13:53:53 +0900, HyeongJun An wrote:

> set_attribute() populates the security area of the BIOS attribute request
> buffer with the current admin password via populate_security_buffer(), then
> dumps the whole request buffer with print_hex_dump_bytes(). This can expose
> the plaintext admin password in the kernel log.
> 
> The same issue was fixed for the password attribute path by
> commit d1a196e0a6dc ("platform/x86: dell-wmi-sysman: Don't hex dump
> plaintext password data"). Remove the remaining dump from the BIOS
> attribute path.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent or clearly a regression fix.

The list of commits applied:
[1/1] platform/x86: dell-wmi-sysman: Don't hex dump attribute security buffer
      commit: 0df706e5e724418283233cd02fff2e7afc682776

--
 i.

