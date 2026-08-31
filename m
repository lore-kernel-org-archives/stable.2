Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EF453A26;
	Mon, 31 Aug 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194276; cv=none; b=ipD0obwJuZ+G+K7MSBgoGuXThRlK1izkHjIHTxTScITEZvV0W6wooA3yuJ30simN1BRgSPB5Sw7UGFLMEra3+PL5/FWDfUi0SyS6Hb5KA0IYzpQEfHVTcFec5CgZYkj9EMfAkY/8OGfrePFAquI6Kk2tfsQrtw9eyV6ongB+KyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194276; c=relaxed/simple;
	bh=3sRwmQR6WCHqBwP2A4vwQnU6vIH8UZHzD3bVhXpYbuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rSVK8y0HmxI1XhPnGYZ1Dq679AmAb3uuFNp6CINvf53csUBQpaR9y7AdvMD9g9KrKrEIZ9G3UHcJxnKeZEa0lDzH/PDi491Sp8Ranlokvu0/7FZNu1U9WRIj+pkbqqndYzMzjqTryNtHWGOwNofjqOUYR6wZiOqI6RQA1QUMsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ON8rU9Xq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ON8rU9Xq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788194274; x=1819730274;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=3sRwmQR6WCHqBwP2A4vwQnU6vIH8UZHzD3bVhXpYbuk=;
  b=ON8rU9XqfTcmqFe63cxUepEoxVkh/sZtir/Ucf+Wcho/I28BbtuJTRKN
   t/HXDioXDsScT+Ure5j/Hp7bTqxhYXXW5yOxMU7qDwrmU+z2Tx0f1XGuv
   QeZipNRUELQaxlg9jbK5XjhjfdmnvhAx2lQKZbmZTweN3UR/G6hj1CPFZ
   3OzI1ZjzUCOqTuqMFhv2oP1CPtBHMPPWjfLPJrez/MLO5CpOAbj0zl5ig
   HjpvFHtmbX//qFWIPQZioINaSgzZGxY52QCc2qlUWNbYHQRrL1cRQOa1n
   nm8iRAzuxM4sqhUHkU64yPV9rsBPwhi4d6REF2RmmhV2fbZ0Z6+GPDhhD
   g==;
X-CSE-ConnectionGUID: lhizMGAaRpSj5OLkCfFB7Q==
X-CSE-MsgGUID: LRM+m9SPTT+46z+zfjMYSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="98944010"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="98944010"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:37:01 -0700
X-CSE-ConnectionGUID: u65W7CjNT5GF5F9UMEZtMg==
X-CSE-MsgGUID: BKa0tJ/3TIG+RpbExaKNfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="265132991"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:36:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Arda_Do=C4=9Fu_Ari?= <arfeliousheres@gmail.com>
Cc: Krishna Chomal <krishna.chomal108@gmail.com>, 
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260827235139.154462-1-arfeliousheres@gmail.com>
References: <20260827235139.154462-1-arfeliousheres@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6
 board
Message-Id: <178819421355.5478.8095156615439150656.b4-ty@b4>
Date: Mon, 31 Aug 2026 19:36:53 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Fri, 28 Aug 2026 02:51:39 +0300, Arda Doğu Ari wrote:

> When adding support for board 8DD6, &omen_v1_no_ec_thermal_params
> was passed as driver_data instead of &omen_v1_no_ec_board_params.
> 
> Because active_board_params expects a pointer to struct
> hp_wmi_board_params, dereferencing active_board_params->thermal_profile
> results in a type confusion bug and invalid memory access. Update the entry
> to point to omen_v1_no_ec_board_params.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Fix board_params typo for 8DD6 board
      commit: 9a71037abc42203caa9041906fb6d012390642a8

--
 i.

