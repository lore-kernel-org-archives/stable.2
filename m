Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD33C13E5;
	Thu, 25 Jun 2026 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370236; cv=none; b=c7pjVNiVxa33kHPv7NnUJsEuoYsNOe6xA02/chvJGpZufn6LBD4ETF1fmKwTPKohHtBis5OsYUwA4e1u6nfmg8PP/Ec2VyEkxWwRymzLA6Ke3qAodIqRvwnB28eH2yF0dzPYgAKN3YfLuiHg9okgCgU1qQEHaX5ldFunWDIL2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370236; c=relaxed/simple;
	bh=GefZF35raZ6OteNAxdpB6Muj5nJiGQPaf8cDHqX6/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcmsBQwJPT+UJ2/WSuBurGme4s5INVy4stKkdOVSIU03pihGNW1jjDsVbZUNFfYD9HWjlNwtQGifrC92vA2OImsFsug8dK0Z601KCyE0HGlXfcs5f1MvkHTYbVDbQAc+ce6KLWNdI28UKH4xWTHvNl2xQDjHXus57/fWK/RAC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k06w6pXz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k06w6pXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370235; x=1813906235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GefZF35raZ6OteNAxdpB6Muj5nJiGQPaf8cDHqX6/+k=;
  b=k06w6pXzBXUOCemX5tHsX5jMYADWI2FZ/cRzcEoXi4db6CDm7RXAElh7
   YKxXXO6d6sivUJ+iSNGa/MK48GQkT8RmwSOlAX1hfZyaVGXQQ71+g2kEp
   qYZxZJSgWHoWmV06myf8p9YY2tWEYWTyGt4iCRRf7LaLdnWQRbg96ra/D
   ziuskN8o1kCTBvwtBC8L7U3av7kASSy4NANiWoTq7dVq4JCIK8f44Pbfn
   Rv7pI6+qQg35o1a50C3vukN1SHTzSOyoAS1E8PQIKapsiOhuz3mZR0ja0
   1XTT3lsJNVE35i/cYMI11g6UCcSJkLxGY71MZUgh0vjmJm+fD1844N+5Y
   g==;
X-CSE-ConnectionGUID: d8OctcmfQFK1E99oaqFbhg==
X-CSE-MsgGUID: zZEKnuwFSImxqKjTV02sbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93498771"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93498771"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:50:34 -0700
X-CSE-ConnectionGUID: AUJfWk0lTYeAGYaCV6Ul5Q==
X-CSE-MsgGUID: D5r/it2DT/yciKpnq0dOpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246030253"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 23:50:32 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 27A9695; Thu, 25 Jun 2026 08:50:31 +0200 (CEST)
Date: Thu, 25 Jun 2026 08:50:31 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: andreas.noever@gmail.com, westeri@kernel.org, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] thunderbolt: fix bandwidth group reservation indexing
Message-ID: <20260625065031.GJ3066@black.igk.intel.com>
References: <7683233B90328D40+20260624062703.601833-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7683233B90328D40+20260624062703.601833-1-raoxu@uniontech.com>

On Wed, Jun 24, 2026 at 02:27:03PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Valid bandwidth group IDs range from 1 through MAX_GROUPS, while Group
> ID 0 is reserved. tb_consumed_dp_bandwidth() uses the Group ID directly
> to index its local group_reserved[] array.
> 
> The array currently has MAX_GROUPS entries, so its valid indices are 0
> through MAX_GROUPS - 1. Group ID MAX_GROUPS therefore accesses one
> element past the end, and the final group's reserved bandwidth is not
> included when the array is summed.
> 
> Give group_reserved[] MAX_GROUPS + 1 entries so direct Group ID
> indexing covers the reserved ID 0 and valid IDs 1 through MAX_GROUPS.
> 
> Fixes: 52a4490e89d7 ("thunderbolt: Reserve released DisplayPort bandwidth for a group for 10 seconds")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied to thunderbolt.git/fixes, thanks!
