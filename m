Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120906;
	b=1PhrgZmM5fnQNOBX7VCuLBn+QPfgoTHw4n6C/Urx+pBjLIev7otarlgShJY+h8+NLkeM
	 5cnYGM/CY74I+r0jiBxQRQfGHnGBhP7oxOcJyA89VPKudwnQCm+d5sA5VBUXnPvdcrCPS
	 hMqx29vU10uAMp7r7spz54juQWQfQrbk0I2WIB//yyfTlQytVEs+HiF3DIswkMndEsO9T
	 J2Bp6G0hfuGTSSPkS9rvpfiGpoAE0AsPce3M/iTtj0R00Yf8wH5sFFj7zVe2c2JFDcYxK
	 IelsphUI/lOqE0xx1FvKwJypDcgAUEhR6wi6O6P2WuBxP3+clMyX9gEM6IL3kXwpcAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120906;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EqRKj4JjHw6XL8/kSkGRlKo0pVt1CLaSeDtymMxLZjc=;
	b=UhL2LUa7TSejdMq8SkTGYSTEYwNhgu6UzvLmPRv57VF4Zr5BG3k96ri50syPjpCOMeAT
	 aTT+XFzY8Y1lDxthZZ464VhgDIYfQBQpwJJiHouXmE7Y4RRGDv1U0j/m9P6wa68zFmHHw
	 /nhEMRZfjXx7Iua+5A994vjYpuLrxNX/b4wFOSoVMKqcTuVGk7hZ0vYSUNUF4PjyaIo1+
	 6mayq3JaGHI8mrsRQbHWK44mPZ7RnhY7J0utRxI3d6BUVwIM/j84qU1lMCInVXw+u2W8h
	 2b1NUhpwB953uWz0ebXOC8pMQQZtdFzZawtvCVUNuExJPXh/SjYtgGreZZUu4wPT9Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YaYcSimt;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2140606A31A;
	Tue, 27 Oct 2026 17:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2140606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YaYcSimt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793120904; x=1824656904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZY+GVp1iLeMaklemOOZDjWJMytlYyxP/MoY5YjBxoPU=;
  b=YaYcSimt+oUAtggKTp1zllMcgaUF8nK5n6TdHEi4t6jfpS2PtbgcQP2b
   TXQWzrH6QPj6F9PReQiNKHAi0JmvTZ8EAtGJVH7e/dbDConq9Qr8T855T
   sIV4fNY1BiDblz3VtQbrjqsCj/5kH+Jeu3CD/HCo/i0OY7+pGOpdYDEcq
   Ax+zw79ag1QPJhDv2Gsm5svIdEpSO632vH9lpSpAp58eB2SacY2FVKfvD
   DcIKrsJVX/ZlymUyG/mvTpWJpQz44vm1sJre1FSpQcGtYTheU4KqUzY/j
   j1edwDhoj4leULNismOrrjr1qOILD5k8D9fk23zR2OZN44MKHfxVjEcIB
   g==;
X-CSE-ConnectionGUID: HDnwve3wQY6F1E8rzOH2KQ==
X-CSE-MsgGUID: RzKj8TjLTzqxo/TvjmVYnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1828577"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1828577"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:08:23 -0700
X-CSE-ConnectionGUID: G/XzPPOkQ/mehdlrVHha1g==
X-CSE-MsgGUID: UJLaONPAT5SA3mKcICqqjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4596521"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:08:21 -0700
Date: Tue, 27 Oct 2026 19:08:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: liuc63 <liuc63@xiaopeng.com>
Cc: gregkh@linuxfoundation.org, khtsai@google.com, fangxy@xiaopeng.com,
	rdunlap@infradead.org, dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
Message-ID: <auDagk-2QU88ofVC@ashevche-desk.local>
References: <20261023110113.2969708-1-liuc63@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023110113.2969708-1-liuc63@xiaopeng.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 07:00:59PM +0800, liuc63 wrote:
> get_ether_addr() parses a MAC address string with a fixed six-iteration
> loop, unconditionally calling hex_to_bin() twice per iteration.  It never
> checks for the terminating NUL, so a short string supplied through the
> configfs dev_addr attribute (e.g. "ab") makes the parser read past the
> end of the buffer, triggering a slab-out-of-bounds read reported by
> KASAN.  hex_to_bin() also returns -1 for non-hex characters, which is
> shifted and OR'ed into dev_addr.
> 
> Bail out as soon as the string ends or a non-hex digit is found, routing
> all failure paths through the existing eth_random_addr() fallback so that
> dev_addr is always fully initialized before the function returns.

Instead, in lib/net_utils.c:

bool parse_mac_pton(const char *s, u8 *mac, const char *delim)
{
	...
		if (i != ETH_ALEN - 1 && !strchr(delim, s[i * 3 + 2]))
	...
}

In include/linux/hex.h:

static bool mac_pton(const char *s, u8 *mac)
{
	return parse_mac_pton(s, mac, ":");
}

and here

static int get_ether_addr(const char *str, u8 *dev_addr)
{
        if (str) {
		bool valid;

		valid = parse_mac_pton(str, dev_addr, ".:");
		if (valid && is_valid_ether_addr(dev_addr))
			return 0;
        }
        eth_random_addr(dev_addr);
        return 1;
}

Note, this will require select NET_UTILS in Kconfig to be added.

Make it two patches (first prepares parse_mac_pton() for others to use).

-- 
With Best Regards,
Andy Shevchenko


