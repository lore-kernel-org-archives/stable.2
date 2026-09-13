Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B262E6CA6;
	Sun, 13 Sep 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337835; cv=none; b=jk4IDU7+AGiavKh3RDuWeKKXaTbzjwwOe//KjmlkWxDZBgM/EQuJvPkjRWDG7Xcbxy/y2BL/l0u4+Ekoc0GMib/j0luEtDSjwY4msllSVADZwRbYLPmX3vFBhbARfB6b1UZ95LuytxiT66tsMZshpzTU8OYpmiGYXSLRD+NvfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337835; c=relaxed/simple;
	bh=P3Yqnv0X7ymNcHUb66eA1skRpfvkIJbgZFhnf4TYK8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEVeXVqWODK8bJDuHqe9dY0wkpT+qE2bSYfzfWI+9roXB+lzrZLah80aJkcURiTs6BLHrhGlu0lKyiAD6NGjNKepf5cqo+SebXYRrczFLldRDLqGL2K63hlh7irE5nUB+ZFssVL9faD/ULiXzQhcNs5S2wug++kSLSrstSOK4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWgMELoQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWgMELoQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789337828; x=1820873828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3Yqnv0X7ymNcHUb66eA1skRpfvkIJbgZFhnf4TYK8Y=;
  b=jWgMELoQohRUc3MZfBQnMTV6UPaNFzyWrIfov+hR0udt2uK+8TUhd77j
   QuyLgoIFIDTKbo1yHawuU1xODxWYU/zR6i2olniZMnsHUbowuNTiLOIbn
   gqwN5ly2oWvWR1LTAG0IP0Jbl0sUMRzQ+AoueKlTp1yxJ0WSbxGdjG5b8
   4xDnoY4ZHoknqvLafY3Mrq/vKWMDOW7h1pZomyMRQSJv7+T+sRFSgPMe3
   6k6vehaFMs0GRBZ/TjujY+a8DLxlnU35ESg3UNvO7Q/BPkPCV2g+fJs5q
   TzJdYzsrF7iqG07p1xy7OiSZRxdonlNZYfoYat6j2hRTx26KEAl+GX75Z
   w==;
X-CSE-ConnectionGUID: iqgwqSELTImqDMxdfSp8QQ==
X-CSE-MsgGUID: QsoxSAu3TOye/DJusGZ2Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100362758"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="100362758"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 15:17:07 -0700
X-CSE-ConnectionGUID: kst5KOfBRiWCm61Vb7Qdig==
X-CSE-MsgGUID: ydURqJlXRSm5fQm8IoxkSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="277720779"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Sep 2026 15:17:05 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x5sVT-000000001MR-07h7;
	Sun, 13 Sep 2026 22:17:03 +0000
Date: Mon, 14 Sep 2026 06:16:20 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] gpib: tnt4882: fix memory leak on probe failure
Message-ID: <202609140612.F8ICypXs-lkp@intel.com>
References: <20260913063603.1443403-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913063603.1443403-1-lgs201920130244@gmail.com>

Hi Guangshuo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/kspp]
[also build test WARNING on linus/master kees/for-next/pstore v7.3-rc2 next-20260911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/gpib-tnt4882-fix-memory-leak-on-probe-failure/20260913-143603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/kspp
patch link:    https://lore.kernel.org/r/20260913063603.1443403-1-lgs201920130244%40gmail.com
patch subject: [PATCH] gpib: tnt4882: fix memory leak on probe failure
config: x86_64-randconfig-r133-20260914 (https://download.01.org/0day-ci/archive/20260914/202609140612.F8ICypXs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260914/202609140612.F8ICypXs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609140612.F8ICypXs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpib/tnt4882/tnt4882_gpib.c: In function 'ni_gpib_probe':
   drivers/gpib/tnt4882/tnt4882_gpib.c:1588:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
    1588 |         ret = ni_gpib_config(link);
         |         ^~~
         |         net
   drivers/gpib/tnt4882/tnt4882_gpib.c:1588:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpib/tnt4882/tnt4882_gpib.c:1595:1: warning: control reaches end of non-void function [-Wreturn-type]
    1595 | }
         | ^


vim +1595 drivers/gpib/tnt4882/tnt4882_gpib.c

0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1557  
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1558  /*
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1559   * ni_gpib_probe() creates an "instance" of the driver, allocating
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1560   * local data structures for one device.  The device is registered
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1561   * with Card Services.
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1562   */
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1563  
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1564  static int ni_gpib_probe(struct pcmcia_device *link)
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1565  {
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1566  	struct local_info_t *info;
fc2c620c3924f26 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Michael Rubin  2025-03-19  1567  	//struct struct gpib_board *dev;
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1568  
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1569  	/* Allocate space for private device-specific data */
bf4afc53b77aeaa drivers/gpib/tnt4882/tnt4882_gpib.c         Linus Torvalds 2026-02-21  1570  	info = kzalloc_obj(*info);
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1571  	if (!info)
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1572  		return -ENOMEM;
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1573  
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1574  	info->p_dev = link;
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1575  	link->priv = info;
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1576  
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1577  	/*
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1578  	 * General socket configuration defaults can go here.  In this
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1579  	 * client, we assume very little, and rely on the CIS for almost
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1580  	 * everything.  In most clients, many details (i.e., number, sizes,
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1581  	 * and attributes of IO windows) are fixed by the nature of the
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1582  	 * device, and can be hard-wired here.
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1583  	 */
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1584  	link->config_flags = CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1585  
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1586  	/* Register with Card Services */
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1587  	curr_dev = link;
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1588  	ret = ni_gpib_config(link);
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1589  	if (ret) {
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1590  		kfree(info);
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1591  		link->priv = NULL;
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1592  	}
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1593  
4d0c779a70d29c2 drivers/gpib/tnt4882/tnt4882_gpib.c         Guangshuo Li   2026-09-13  1594  	return ret;
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18 @1595  }
0cd5b05551e0224 drivers/staging/gpib/tnt4882/tnt4882_gpib.c Dave Penkler   2024-09-18  1596  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
