Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180306;
	b=LCqM79SL2/ndJQ6eZmvBx5Ln5qx1KmHOVyXDE36vP4y04FKNySFf+MR3S2qRR2KJQvbX
	 E6YJIULerklwlpb+PsxFSaW4c/sagLYWUvCVtdN+K+e9SjoZNO5DE9YxcIXUXFpvpb4br
	 32faQXKgiGLsfiUaXEe+K8V50QNgkTqU07vm2jF30s9q01hC2M7CrCTCZcGSxkm+mdNlQ
	 ZjsV1KgNL16WwO68fGApoWvr6dKbioW53RSlnbywuKI43LmU8BpK1/DetkC/wlGDaKayc
	 gRWjH59lZurvKy1kRj7JWErad6pYYl3qVmT90GmJyxKvKNMgL+2edrV0pc+x5zump2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180306;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=C5Zve2yUOC8yB0rGIv8b0aK3NGYsoSH80/7cyPpB4hk=;
	b=qDuqPSFzCYP9eqINkW2kDAolD8XZiFal+r8xG6D+Zb5wfQV6/UfI8Dlf4csCbjQEzUKw
	 RFHZqRg44mNUbEcliuhUdY9ptpJf9xcnkKbB80tg1WZu4SI+pezK/+gabN6aF7LHMqau9
	 ii7QUSkwvCuM8gSIa5AbJo/KJnskOssZy3agbli2Qw0NovUWek2DgnNTllE6p9PUMGpvC
	 SXZgEoHG2cmkt8yVvHE0SJ7HqwZ4QYOocPRxjrks+viHZ6mWFf5w2asli+ZroI6n5+H4w
	 BBqTcsYHMoSkO07ldiakA28jkrQo3TdGVy3qi0XNIazNZ33jShVcD1RBK8u7gHoR5Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mcZ70rbk;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0F606A31C;
	Wed, 28 Oct 2026 09:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2F0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mcZ70rbk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793180304; x=1824716304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IlSmwz3t4apRrEpsmg5yqaNQ+6v66Gb3F1C490RGPSM=;
  b=mcZ70rbkNx0D/75sYooY393N+VMsTX7cW2Akt3CeSsVlI4s5OLMVaS+w
   9O6sytw4jQTh6/2az1yLd4GLmh3RCA1G1hfOoltkhRsvjzo4QUOyXCEa5
   2M+Et0lKwVRrCr/An1vJJrgBEQ5xv70cc7+YfYxnVgnR25Jg5TdWTvehq
   iFhLVa6ZF1H6dlgKB3cG4iGAf7CmGPKGNGR0DW+X/pwnf57P+fDTddR2Z
   pU7Hw9nwQxZkiEKVuM/ewBBXkIEUftSSNHSz+KQZ/tEnFn5Cb1fqR/wUt
   tXw6cYkoQCX4LL+xfHnNliSL6R3O3Y8ZlxK0A72hZ7zDWghCcbzrOk6LY
   Q==;
X-CSE-ConnectionGUID: kgoNT8BxQi6yACqGCkFS+Q==
X-CSE-MsgGUID: okHjTsC8S0WhD6nphXfFxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1788142"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1788142"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:38:24 -0700
X-CSE-ConnectionGUID: Q82VjP2sQ7yXQDALF0Wfpw==
X-CSE-MsgGUID: +1HltY5zThyFajnK6gx61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4762682"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Oct 2026 02:38:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xM06r-00000000YXg-1W4S;
	Wed, 28 Oct 2026 09:38:17 +0000
Date: Wed, 28 Oct 2026 17:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Henry Martin <bsdhenrymartin@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] vxlan: reject VNI add when the default fdb
 entry is nexthop-backed
Message-ID: <202610281752.nKGCORKp-lkp@intel.com>
References: <20261027104713.328028-2-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20261027104713.328028-2-bsdhenrymartin@gmail.com>

Hi Henry,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Henry-Martin/vxlan-reject-VNI-add-when-the-default-fdb-entry-is-nexthop-backed/20261027-184713
base:   net/main
patch link:    https://lore.kernel.org/r/20261027104713.328028-2-bsdhenrymartin%40gmail.com
patch subject: [PATCH net v4 2/2] vxlan: reject VNI add when the default fdb entry is nexthop-backed
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20261028/202610281752.nKGCORKp-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 1da436a23e613c425fc9b868fc8deb979ede47a4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261028/202610281752.nKGCORKp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610281752.nKGCORKp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/vxlan/vxlan_vnifilter.c:846:33: error: member reference type 'struct vxlan_config *' is a pointer; did you mean to use '->'?
     846 |             !vxlan_addr_any(&vxlan->cfg.remote_ip)) {
         |                              ~~~~~~~~~~^
         |                                        ->
   1 error generated.


vim +846 drivers/net/vxlan/vxlan_vnifilter.c

   819	
   820	static int vxlan_vni_add(struct vxlan_dev *vxlan,
   821				 struct vxlan_vni_group *vg,
   822				 u32 vni, union vxlan_addr *group,
   823				 struct netlink_ext_ack *extack)
   824	{
   825		const struct vxlan_config *cfg = rtnl_dereference(vxlan->cfg);
   826		struct vxlan_vni_node *vninode;
   827		__be32 v = cpu_to_be32(vni);
   828		bool changed = false;
   829		int err = 0;
   830	
   831		if (vxlan_vnifilter_lookup(vxlan, v))
   832			return vxlan_vni_update(vxlan, vg, v, group, &changed, extack);
   833	
   834		err = vxlan_vni_in_use(vxlan->net, vxlan, cfg, v);
   835		if (err) {
   836			NL_SET_ERR_MSG(extack, "VNI in use");
   837			return err;
   838		}
   839	
   840		/* A default fdb entry that is backed by a nexthop group can
   841		 * never take a remote; reject before the VNI is installed,
   842		 * otherwise a failure in vxlan_vni_update_group() would leave
   843		 * the VNI half-installed.
   844		 */
   845		if ((group && !vxlan_addr_any(group)) ||
 > 846		    !vxlan_addr_any(&vxlan->cfg.remote_ip)) {
   847			if (vxlan_fdb_entry_nh_backed(vxlan, all_zeros_mac, v)) {
   848				NL_SET_ERR_MSG(extack,
   849					       "Cannot add a remote to a nexthop fdb entry");
   850				return -EOPNOTSUPP;
   851			}
   852		}
   853	
   854		vninode = vxlan_vni_alloc(vxlan, v);
   855		if (!vninode)
   856			return -ENOMEM;
   857	
   858		err = rhashtable_lookup_insert_fast(&vg->vni_hash,
   859						    &vninode->vnode,
   860						    vxlan_vni_rht_params);
   861		if (err) {
   862			vxlan_vni_free(vninode);
   863			return err;
   864		}
   865	
   866		__vxlan_vni_add_list(vxlan, vg, vninode);
   867	
   868		if (vxlan->dev->flags & IFF_UP)
   869			vxlan_vs_add_del_vninode(vxlan, vninode, false);
   870	
   871		err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
   872					     extack);
   873	
   874		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
   875	
   876		return err;
   877	}
   878	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
