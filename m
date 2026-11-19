Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086109;
	b=K5L7Xpe07y3nelY43cXHXdgib2nopC5oTxkZQb1qUo16PGePki0h+stvrj/AIf9fX1Fa
	 PbxUasGacQKXQnMf4v11gkxpnXdlajTDi0ILZi7Aske7kcDIiMrZsC2bGYHwujQErxSPL
	 P3kaYuoHSg3G5BDrJdtOpfflm6ZjaXTaFUwYi0AmLvbFZwY+wtT4TiuXYeLeTBwTdTpf9
	 R7/dFxRRlNifmcO9EaYopQFlsvE2JGeyjfzg5+Kv+FUKegeeyj164KAjrmUBnv8BHTS4h
	 4HK+DgbHQG8ev16QXOWxKZeNdq3Ucbw7EGOku2tEv3DTtQ1lh9Z8er+hsiTIG9Uh7iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086109;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=t9zctAsFenItVdzIfNxAuLJcFKGbZarY6B5DfF4Pt8Q=;
	b=PbT395gfgz0QSg0lVofaY/oh4lHNtKXNU6Nrw7tRHF2tFOA9Cwg6QLn5lIo02xN1yZbt
	 xt5xaiOxn2bXhiHlXaKWKYbnnzWcstjzEHuavN61Ouf8HiVdZ4B8cKIzV6RqgsoLOkFZB
	 nckt2T6tsjqMr0jYUCIJ/ztlRFUk+lNWL7GhhReZzpw0ggAsQsdv7ZOufozQeB1LnYhV0
	 08P+EO0lFZ/MQG6LzJ0t8f3FXfPiFf54NCNhYYoBlDGmry8zQfJwpN8yvZ0OsPBnaOoCs
	 oPzinpIiymEXbGivgZ2YMG0tLVLLpOhEA8D4y0T/gpW359CpKS70DcaUsafzIrx4hag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xuq9CnSF;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0E606A324;
	Thu, 19 Nov 2026 11:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CC0E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xuq9CnSF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795086109; x=1826622109;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=zTvOojozxEfyMQ4tzrE11s0gcs2+zCz/fbu4bK+QT5E=;
  b=Xuq9CnSFFbS3Zd55qKW1dVM8Av6yhx/Goy+9wpv2DAC9uGDWLTP8La/k
   inyF0gq0spO4WQ9w/M6Wlv1E4oSLaRybFbLcPW8OUPiVENFhHFNqlyNSX
   xP3Kj01FsbgqgiujrHcfVUOAl3ZIyX84tkziudtehE6ToN1+5Ckzhhnzh
   t/pcMtB/aBL9X/X81Xbg0fGEoHJh70+qBUn0p7eh1MW5YUx+kYOOlJx9i
   BE4JroA2AWRIJ40DUWorhO8WRentRpjHLeuXmVqyYcDzBozRG3dF9Supc
   TgxHaz6rW+xz8FzuoQbn7XSJHsE6y612rBjloijc+H1zCnlOArztNWHAb
   g==;
X-CSE-ConnectionGUID: XEWSN+hkQrqajyQi+fHIlA==
X-CSE-MsgGUID: RDnAzVqnRs2EL93pT44BJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3848780"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3848780"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:01:48 -0800
X-CSE-ConnectionGUID: OhBYToKqRFS+jP6hSl3fdg==
X-CSE-MsgGUID: eV0dZ8LTTpGc/eUawzx7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10271201"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 19 Nov 2026 03:01:45 -0800
Received: from black.igk.intel.com (localhost [IPv6:::1])
	by black.igk.intel.com (Postfix) with ESMTP id 7148394;
	Thu, 19 Nov 2026 12:01:44 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Yibo Tan <lhfff@tju.edu.cn>
Cc: =?utf-8?q?Jean-Fran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>, 
 Surendra Singh Chouhan <kr494167@gmail.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260912161152.1683002-1-lhfff@tju.edu.cn>
References: <20260912161152.1683002-1-lhfff@tju.edu.cn>
Subject: Re: [PATCH v1] auxdisplay: linedisp: prepare message before
 registration
Message-Id: <179508610445.1209487.16986546761911617792.b4-ty@b4>
Date: Thu, 19 Nov 2026 12:01:44 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 13 Sep 2026 00:11:52 +0800, Yibo Tan wrote:
> Since the line-display attachment support was added, linedisp_register()
> has displayed its initial message before calling device_add().  The
> HT16K33, MAX6959 and GPIO segment drivers implement display updates with
> delayed work, so that display operation can publish driver-owned work
> before the final fallible registration step.
> 
> If device_add() fails, the registration error path releases the display
> buffers and the caller's probe failure releases its managed private data.
> The admitted worker can then access both freed objects.  In an HT16K33
> KASAN reproducer, a real device_add() -EEXIST failure produced a
> slab-use-after-free first in __pwq_activate_work() and then in
> ht16k33_seg7_update().
> 
> [...]

Applied, thanks!

[1/1] auxdisplay: linedisp: prepare message before registration
      commit: 29133e66ae15efcbaedd185cf16a09357c6d9486

Best regards,
-- 
With Best Regards,
Andy Shevchenko




