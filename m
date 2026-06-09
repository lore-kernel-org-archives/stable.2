Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FEA2E040E;
	Tue,  9 Jun 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015090; cv=none; b=QQuymCVRKey4A6aG/yU7eXg0vXp6+ojvoSM/jzGvtokcN55p7QCqfpBtHpleb6R44FZM1F0te9rjZLaR4UfxCsXIOqvUelKn2yc391EOICfrZ3MV7i8yXHgQOSCarYQhpugpU8zJPsfoJ/ilgU04EVMmuEatY4XzAKfhaRUrp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015090; c=relaxed/simple;
	bh=gnwR7wZ+5RCRuZrbsQitVhLW18mHrGZ8vhJM5UJcYH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jnLbnExd7bvPvkmtolSu2lW7gfHpqAntxnHQw1yeyaxgkvgK+Hl499OnEn+hfZZvTS8IndXlMtEBXzvoTAxyyiOqpGnzfBjocJ3zSFbLMJd+bfMkSFfM6eRJOf2sDMACozpm0ZuUiaV33xC+nSx56vAnCVf0x8CEQD9IK6pbXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGn9s51g; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGn9s51g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781015090; x=1812551090;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=gnwR7wZ+5RCRuZrbsQitVhLW18mHrGZ8vhJM5UJcYH0=;
  b=WGn9s51g9XDZquYasW0rg6wNqlm1YEcQvTx0MaywefI3rgjM2Dd1j8nN
   xZUhIUB6XWL0t8TUQCiu/aXwo0+5OOA6ygcDamVvdmOhc2a3TP2txT3lt
   KY0Pj7c4SmAZ55j+0ng8NhxpFQxFcuamaX85RSAwmreiD27Z6/fuu7a99
   wTt2y3TOyGIkfPEJEG3keAFGShicy0HsS+hoKKw3XWM3kCajvByTgSC1r
   tmdjKXlrmvwzHN0awsi0WSI5sphdGn5OLdmrYqXc7NDcgZXdYSnFwNEVl
   TPpOvEruWRLaB5vIJpcuava7FYyizrDPF/kJLwLJHwy9/nbbqooGrAZWv
   A==;
X-CSE-ConnectionGUID: UarcAUP5TzKQqmtl+iElHA==
X-CSE-MsgGUID: C6i7iVICTZyM/+nN5lZ1Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81962198"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81962198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:24:49 -0700
X-CSE-ConnectionGUID: WxGD4JxCRIy+DoWujlOmww==
X-CSE-MsgGUID: iTCD9epYTiqLtpYQn6bpkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245024799"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:24:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, Krishna Chomal <krishna.chomal108@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ahmet_=C3=96zt=C3=BCrk?= <sivasli-ahmet@gmx.de>, 
 stable@vger.kernel.org
In-Reply-To: <20260608134255.36280-1-krishna.chomal108@gmail.com>
References: <20260608134255.36280-1-krishna.chomal108@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx
 (8E35)
Message-Id: <178101508117.11417.5011316528727663268.b4-ty@b4>
Date: Tue, 09 Jun 2026 17:24:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 08 Jun 2026 19:12:55 +0530, Krishna Chomal wrote:

> The HP Omen 16-ap0xxx (board ID: 8E35) has the same WMI interface as
> other Victus S boards, but requires quirks for correctly switching
> thermal profile.
> 
> Add the DMI board name to victus_s_thermal_profile_boards[] table and
> map it to omen_v1_legacy_thermal_params.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8E35)
      commit: 56b7981c6f21670c0a1a62e6d2f9afb380e2596d

--
 i.

