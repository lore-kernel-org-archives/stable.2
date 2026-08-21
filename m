Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29430D3FF;
	Fri, 21 Aug 2026 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294938; cv=none; b=aUR01zvznDCTb+3lonNkJ/nhmOf43bDZEpMfFdKRxIe+e4ABnQZ0ghG1oTdoPhRZeeWM2cqW3p+/AC+b2yTJBnhsBqjjHkwsbwyn2nYGRVcLdk1Aovo/ejvYrd93TX/o40QlIeqNnE2x7GcrjH1nL8OAh/NcNQUSGLKliI6tf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294938; c=relaxed/simple;
	bh=9YWFSioaKPVWJmuvo5caifUXUxnU9qnCJD3RL82welo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfDNxGfbs0gauFn98+yLy4HOXzUHVWpr526wMrZfKKyUMg6i6/dxFj8ncDAqAMSKcw2M4npBPRV4GEYS1DL5fLLpV/NXJ9PlpEL5T45d6L8CyVRSeV98pD/FuRjh4v1xctMtU1mkY+eubTmRAHbtc36oLhCXMBFbqcNxmG4mOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYAa0LVM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYAa0LVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787294936; x=1818830936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9YWFSioaKPVWJmuvo5caifUXUxnU9qnCJD3RL82welo=;
  b=XYAa0LVMxl5uauLbSckaHRJ3FT9lgxPXCDnnFCPunafSaL0OlZ+OZZFK
   9iEiBLDAfYrOmVjeVJqDGxooq9hC3JK9pwwbJnZXSlzPRVEvjItvhoAZx
   kPNhVVzYPzfCanTzm5NU1gKY8RoBdTn73jlAfNdbPRWAoUrLeNgT5pEBp
   ctxXwzRy9bpy/xci+HvX8lzp5pts4B6xx6RYp3QJGCd2yTf3PwI/KY2N2
   PCGRFThIe1LSpEwmqYn+KJPqFSUAG71bndtEPM8KrRdte2KcmquJlHNVO
   eOsVdGHIsFYl6vIE++ryy0BBCG0FLH3GofdgzdHEqvFxwZZKlZQQ0G3zG
   w==;
X-CSE-ConnectionGUID: G88cqOVmQXi5IGzdP07fhw==
X-CSE-MsgGUID: kHxNgO10SJys8eVJPc9JMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87714147"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87714147"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 23:48:54 -0700
X-CSE-ConnectionGUID: rO5Yqm9xTraoHEDpLn2+ag==
X-CSE-MsgGUID: hcxaeN1lQGuGuqrxmh+ePA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="291097771"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Aug 2026 23:48:51 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxJ3Y-00000000pVl-1HtU;
	Fri, 21 Aug 2026 06:48:48 +0000
Date: Fri, 21 Aug 2026 14:48:32 +0800
From: kernel test robot <lkp@intel.com>
To: Xin Chen <xin.chen2@oss.qualcomm.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org,
	liulzhao@qti.qualcomm.com, cheng.jiang@oss.qualcomm.com,
	cxin@qti.qualcomm.com, Xin Chen <xin.chen2@oss.qualcomm.com>
Subject: Re: [PATCH v2] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <202608211421.J0U0ljJ6-lkp@intel.com>
References: <20260818070324.136726-1-xin.chen2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818070324.136726-1-xin.chen2@oss.qualcomm.com>

Hi Xin,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v7.2 next-20260819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Chen/tty-n_tty-use-kvzalloc-kvfree-for-line-discipline-data/20260818-150324
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20260818070324.136726-1-xin.chen2%40oss.qualcomm.com
patch subject: [PATCH v2] tty: n_tty: use kvzalloc/kvfree for line discipline data
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260821/202608211421.J0U0ljJ6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608211421.J0U0ljJ6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608211421.J0U0ljJ6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/n_tty.c: In function 'n_tty_open':
>> drivers/tty/n_tty.c:1890:15: error: assignment to 'struct n_tty_data *' from incompatible pointer type 'struct n_tty_data **' [-Wincompatible-pointer-types]
    1890 |         ldata = kvzalloc_obj(ldata);
         |               ^


vim +1890 drivers/tty/n_tty.c

  1876	
  1877	/**
  1878	 * n_tty_open		-	open an ldisc
  1879	 * @tty: terminal to open
  1880	 *
  1881	 * Called when this line discipline is being attached to the terminal device.
  1882	 * Can sleep. Called serialized so that no other events will occur in parallel.
  1883	 * No further open will occur until a close.
  1884	 */
  1885	static int n_tty_open(struct tty_struct *tty)
  1886	{
  1887		struct n_tty_data *ldata;
  1888	
  1889		/* Currently a malloc failure here can panic */
> 1890		ldata = kvzalloc_obj(ldata);
  1891		if (!ldata)
  1892			return -ENOMEM;
  1893	
  1894		ldata->overrun_time = jiffies;
  1895		mutex_init(&ldata->atomic_read_lock);
  1896		mutex_init(&ldata->output_lock);
  1897	
  1898		tty->disc_data = ldata;
  1899		tty->closing = 0;
  1900		/* indicate buffer work may resume */
  1901		clear_bit(TTY_LDISC_HALTED, &tty->flags);
  1902		n_tty_set_termios(tty, NULL);
  1903		tty_unthrottle(tty);
  1904		return 0;
  1905	}
  1906	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
