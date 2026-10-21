Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555588;
	b=AvaPKVF6qBpQulH8d4Dk4P0fwicz/oACtZMoNnlNCnA34pDKkuMod2K58EhiFVyItYMp
	 YwBT08toOOEvu4SDnq7+HbPxSg4xpChJItOdVDbKsfwtD9ETrhXU7KZGn3EQTgmQ9Ibsv
	 7YYCMxrHQQDclRd1CfpuCA9s3MTdEGbEBdOr+smCJ3xFV8r/LIlsMqngLwd1fRWsVTmyl
	 BVrbeVnK2GPa4VtSfxN0EI5hXJmDuNNu+syDxjUWaBvZ9oTNwdggCy81WAN7ivYmUPyy+
	 86uMOnLOAzRMaZ3DTl+NiYVeAH6cN1Dmg48KIBF/H2mtMEX55dTI+0OP3e2+XiKncXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555588;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=h1VifQxHOvSIuRV3xF17NLPUJExYIFG+4qI3A3UN69U=;
	b=VMtd1COff1R8koq7Hj1NXV8Eo+pIH9CPkE5JoLfJnqmF9Ok32/mk/2OPbnL7WuLetyeB
	 ZRiV0MsOAbE9yil9iGz+Hhdf1WGlat3W3ZpbWCQo1FRDIo+dC4eb5CEk6NAZz+Zhm671/
	 6BBPcintIaZ1T/3dxpkWFuILrF+B5IbvA4iZpZGQLJHflWx2Ai6OknKa0ZTITY9HR5+cd
	 KPwZG31AbxslrejyD3PQLGalVabls/TjHET1w03i5mPW2BQs6xUwjcGed3OHaHpB8gHi+
	 Pl8oPFqnFjbWgntJ4U9AH1HlXcRZ/X+sNP7w0dgRrYUHk5bltUfEJr9/J2xrFx/NwpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YlM3PfZl;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0835606A33E;
	Wed, 21 Oct 2026 04:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0835606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YlM3PfZl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792555582; x=1824091582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cyChiOQQGkCpQKGhiB5E8ZyrnofaXhG+aYNotHbWR2A=;
  b=YlM3PfZl8XQjkCdQU8dFfvZO9+o06iS9XvEAOSy6LJE5YoCZSdoiEP53
   CHNx85uevew1x3+p002W9mg/9AtPEutRIGPPqTcmA0FXs+Fe9fGCmkhbu
   TS720VjUEyLUNyAJKIWLKn/SnMegEo3tJ5u391pOSEMjVavRBc35dwH6I
   xbux/2m9CC46MsbXVfKUL3sJhNE1hIRhSNeqKVYd9j75nKNc8Hq5ntccN
   Wzii1QxMccwroFFAUCt9R4/KlvCFX8ebA219OVJpFCZuTgz4NyIG8AaoO
   p/Pvhmnq39AgpH2LT7Nodg8AO/TTO1ELODMf9WSEaG0xByBH9OG+E+2Vv
   g==;
X-CSE-ConnectionGUID: qTGaVuS6QZaVO3uJAI3Kbw==
X-CSE-MsgGUID: SDd+q9FCSS6F3Zm4QJeR1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1263817"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1263817"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 21:06:22 -0700
X-CSE-ConnectionGUID: xVxOU5uvTxmqcUXduAhXcg==
X-CSE-MsgGUID: +yPgw3TjRp6qfbOfSYRFSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2867428"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Oct 2026 21:06:19 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xJNaj-00000000OwI-16Xl;
	Wed, 21 Oct 2026 04:06:17 +0000
Date: Wed, 21 Oct 2026 12:05:25 +0800
From: kernel test robot <lkp@intel.com>
To: Piotr Kubik <piotr@kubik.pl>, Johannes Berg <johannes@sipsolutions.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Piotr Kubik <piotr@kubik.pl>, stable@vger.kernel.org
Subject: Re: [PATCH wireless 2/2] wifi: mac80211: set the link addresses of a
 4-address AP_VLAN before its links
Message-ID: <202610211107.BOyMUaJh-lkp@intel.com>
References: <20261020124446.188739-3-piotr@kubik.pl>
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
In-Reply-To: <20261020124446.188739-3-piotr@kubik.pl>

Hi Piotr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Piotr-Kubik/wifi-mac80211-change-the-links-of-an-AP_VLAN-station-through-its-AP/20261020-144445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
patch link:    https://lore.kernel.org/r/20261020124446.188739-3-piotr%40kubik.pl
patch subject: [PATCH wireless 2/2] wifi: mac80211: set the link addresses of a 4-address AP_VLAN before its links
config: powerpc-randconfig-1001-20261021 (https://download.01.org/0day-ci/archive/20261021/202610211107.BOyMUaJh-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261021/202610211107.BOyMUaJh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610211107.BOyMUaJh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mac80211/cfg.c: In function 'ieee80211_set_sta_4addr':
>> net/mac80211/cfg.c:2739:31: warning: unused variable 'vif' [-Wunused-variable]
    2739 |         struct ieee80211_vif *vif = &sdata->vif;
         |                               ^~~


vim +/vif +2739 net/mac80211/cfg.c

4fd6931ebe24640 Johannes Berg       2007-12-19  2734  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2735  static int ieee80211_set_sta_4addr(struct ieee80211_local *local,
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2736  				   struct ieee80211_sub_if_data *sdata,
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2737  				   struct sta_info *sta)
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2738  {
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26 @2739  	struct ieee80211_vif *vif = &sdata->vif;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2740  	struct wiphy *wiphy = local->hw.wiphy;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2741  	struct ieee80211_sub_if_data *master;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2742  	struct ieee80211_bss_conf *link_conf;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2743  	struct wireless_dev *wdev;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2744  	unsigned long master_iter;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2745  	int link_id;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2746  	int err;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2747  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2748  	lockdep_assert_wiphy(local->hw.wiphy);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2749  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2750  	if (sdata->u.vlan.sta)
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2751  		return -EBUSY;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2752  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2753  	wdev = &sdata->wdev;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2754  	master = container_of(sdata->bss,
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2755  			      struct ieee80211_sub_if_data,
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2756  			      u.ap);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2757  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2758  	if (sta->sta.valid_links) {
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2759  		u16 sta_links = sta->sta.valid_links;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2760  		u16 new_links = master->vif.valid_links & sta_links;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2761  		u16 orig_links = wdev->valid_links;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2762  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2763  		wdev->valid_links = new_links;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2764  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2765  		master_iter = master->vif.valid_links;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2766  
5cb41f5375432b4 Piotr Kubik         2026-10-20  2767  		/* ieee80211_link_init() takes the address of a new link from
5cb41f5375432b4 Piotr Kubik         2026-10-20  2768  		 * wdev->links, so set it before the links are added.
5cb41f5375432b4 Piotr Kubik         2026-10-20  2769  		 */
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2770  		for_each_set_bit(link_id, &master_iter,
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2771  				 IEEE80211_MLD_MAX_NUM_LINKS) {
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2772  			if (!(sta_links & BIT(link_id))) {
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2773  				eth_zero_addr(wdev->links[link_id].addr);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2774  			} else {
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2775  				link_conf = wiphy_dereference(wiphy,
5cb41f5375432b4 Piotr Kubik         2026-10-20  2776  							      master->vif.link_conf[link_id]);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2777  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2778  				ether_addr_copy(wdev->links[link_id].addr,
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2779  						link_conf->bssid);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2780  			}
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2781  		}
5cb41f5375432b4 Piotr Kubik         2026-10-20  2782  
5cb41f5375432b4 Piotr Kubik         2026-10-20  2783  		err = ieee80211_vif_set_links(sdata, new_links, 0);
5cb41f5375432b4 Piotr Kubik         2026-10-20  2784  		if (err) {
5cb41f5375432b4 Piotr Kubik         2026-10-20  2785  			wdev->valid_links = orig_links;
5cb41f5375432b4 Piotr Kubik         2026-10-20  2786  			return err;
5cb41f5375432b4 Piotr Kubik         2026-10-20  2787  		}
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2788  	}
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2789  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2790  	rcu_assign_pointer(sdata->u.vlan.sta, sta);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2791  	__ieee80211_check_fast_rx_iface(sdata);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2792  	drv_sta_set_4addr(local, sta->sdata, &sta->sta, true);
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2793  
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2794  	return 0;
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2795  }
469d5d5a3b7a133 Tamizh Chelvam Raja 2026-03-26  2796  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
