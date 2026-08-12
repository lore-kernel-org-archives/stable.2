Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7853876DF;
	Wed, 12 Aug 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524930; cv=none; b=WLNJyZ7UsqSmsMIOEzFx5xX9MWZcq23SzD5vze8JH1Lb/g475qG24oTvqtu3jSz9YT+GFDCRMl0XL4S6z1BnKGmawHekPABQrNZzfItKZjOjB+V+/xh3YgjgHC0MAdq+CXSJNcuLgnH/XEcR4gIedTFfGrv775Xrc8M1U0Zl7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524930; c=relaxed/simple;
	bh=qeF3qzVD0a7yJfGxaupNzNTzHbIZrr6gK0tcQPX+O4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hX4Be+nmrcuumZE5WfS+X5YrjzksPckj9d/BsCx5JWZ6UZL1Ahn7NKmO0j+enRApb3Z98RpCmNVebjVe/mEA3ZgjTMPolHnT29tr3dsfTEIUp8E7pSYzQ7ZiTMoJQsggSUYbsaytD4gLdBfxXnmDvckUyQkXvMAbS01Hn2yZeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fINmhjFm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fINmhjFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786524929; x=1818060929;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qeF3qzVD0a7yJfGxaupNzNTzHbIZrr6gK0tcQPX+O4k=;
  b=fINmhjFmtEsX5l3sRUkBWGpt1ZeE/rgYs8GRs9mgclMRycQeVgcASGvf
   qUmrnlhUBrkKka2MvtX0wn0ktOWR7i5l0oBWQsMoZ5RsgzCmT/4UmSqdP
   jf+DMmtEbjL9X+OJI5gD2ZxQB+ku5K9gu02hfzXxM2wicUuJ4lX7PtWXV
   0uaQTnKZ8UX5/iMFNv9So0H4SFOrDclGshDiTfNDSrBi7FGzbq1+sajPc
   j9XwTVXwBB+mWNYyKIJEIU1MGrrpEZiEV9qgOEkHGovzPB2Lno/Bpmsaw
   g6yb2C0Dif/kojwiL0I3p+tnHFAxgjgYi18SHgNaiit0Ka50nebOJoBXJ
   w==;
X-CSE-ConnectionGUID: qBBbPuSAToOzQv/NsZD5Fg==
X-CSE-MsgGUID: 5tYI7FcaSu+V51GIyRuG/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97418385"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97418385"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:55:28 -0700
X-CSE-ConnectionGUID: be5EyKfISrG/MS/g4yZZIg==
X-CSE-MsgGUID: c5PIsKf9QLiv9p7wZij3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="260963041"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:55:24 -0700
Date: Wed, 12 Aug 2026 16:55:20 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	maheshb@google.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>, yi1.lai@intel.com
Subject: Re: [PATCH net v3] net: reduce XMIT_RECURSION_LIMIT under KASAN
Message-ID: <202608121039.ca91f25a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727200454.4048141-1-tristmd@gmail.com>


Hello,

kernel test robot noticed "kselftests-bpf.net/forwarding fail" on:

commit: ef83ebe178d46ab0d26a906be5fcd654a488c730 ("[PATCH net v3] net: reduce XMIT_RECURSION_LIMIT under KASAN")
url: https://github.com/intel-lab-lkp/linux/commits/Tristan-Madani/net-reduce-XMIT_RECURSION_LIMIT-under-KASAN/20260728-072802
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git bd0e9289e2642f6a5c54faad304ce0f41e926d22
patch link: https://lore.kernel.org/all/20260727200454.4048141-1-tristmd@gmail.com/
patch subject: [PATCH net v3] net: reduce XMIT_RECURSION_LIMIT under KASAN

in testcase: kselftests-bpf
version: 
with following parameters:

	group: net/forwarding
        failed cases:
		forwarding.custom_multipath_hash.sh
		forwarding.vxlan_asymmetric.sh
		forwarding.vxlan_asymmetric_ipv6.sh
		forwarding.vxlan_symmetric.sh
		forwarding.vxlan_symmetric_ipv6.sh


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608121039.ca91f25a-lkp@intel.com


KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-bpf-ef83ebe178d46ab0d26a906be5fcd654a488c730
2026-08-04 22:51:54 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2026-08-04 22:51:54 make -j16 TARGETS=net/forwarding run_tests
# timeout set to 0
# selftests: net/forwarding: custom_multipath_hash.sh
# TEST: ping                                                          [ OK ]
# TEST: ping6                                                         [ OK ]
# INFO: Running IPv4 custom multipath hash tests
# TEST: Multipath hash field: Source IP (balanced)                    [ OK ]
# INFO: Packets sent on path1 / path2: 6600 / 6001
# TEST: Multipath hash field: Source IP (unbalanced)                  [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12600
# TEST: Multipath hash field: Destination IP (balanced)               [ OK ]
# INFO: Packets sent on path1 / path2: 5950 / 6650
# TEST: Multipath hash field: Destination IP (unbalanced)             [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12600
# TEST: Multipath hash field: Source port (balanced)                  [ OK ]
# INFO: Packets sent on path1 / path2: 16505 / 16265
# TEST: Multipath hash field: Source port (unbalanced)                [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 32771
# TEST: Multipath hash field: Destination port (balanced)             [ OK ]
# INFO: Packets sent on path1 / path2: 16504 / 16266
# TEST: Multipath hash field: Destination port (unbalanced)           [ OK ]
# INFO: Packets sent on path1 / path2: 32769 / 0
# INFO: Running IPv6 custom multipath hash tests
# TEST: Multipath hash field: Source IP (balanced)                    [ OK ]
# INFO: Packets sent on path1 / path2: 6102 / 6500
# TEST: Multipath hash field: Source IP (unbalanced)                  [ OK ]
# INFO: Packets sent on path1 / path2: 12600 / 0
# TEST: Multipath hash field: Destination IP (balanced)               [ OK ]
# INFO: Packets sent on path1 / path2: 6100 / 6500
# TEST: Multipath hash field: Destination IP (unbalanced)             [ OK ]
# INFO: Packets sent on path1 / path2: 12600 / 0
# TEST: Multipath hash field: Flowlabel (balanced)                    [FAIL]
# 	Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: 1 / 0
# TEST: Multipath hash field: Flowlabel (unbalanced)                  [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12600
# TEST: Multipath hash field: Source port (balanced)                  [ OK ]
# INFO: Packets sent on path1 / path2: 16422 / 16347
# TEST: Multipath hash field: Source port (unbalanced)                [ OK ]
# INFO: Packets sent on path1 / path2: 32771 / 0
# TEST: Multipath hash field: Destination port (balanced)             [ OK ]
# INFO: Packets sent on path1 / path2: 16422 / 16347
# TEST: Multipath hash field: Destination port (unbalanced)           [ OK ]
# INFO: Packets sent on path1 / path2: 32769 / 0
not ok 17 selftests: net/forwarding: custom_multipath_hash.sh # exit=1

# selftests: net/forwarding: vxlan_asymmetric.sh
# RTNETLINK answers: File exists
# RTNETLINK answers: File exists
# TEST: ping: local->local vid 10->vid 20                             [ OK ]
# TEST: ping: local->remote vid 10->vid 10                            [ OK ]
# TEST: ping: local->remote vid 20->vid 20                            [ OK ]
# TEST: ping: local->remote vid 10->vid 20                            [FAIL]
# TEST: ping: local->remote vid 20->vid 10                            [FAIL]
# INFO: deleting neighbours from vlan interfaces
# TEST: ping: local->local vid 10->vid 20                             [ OK ]
# TEST: ping: local->remote vid 10->vid 10                            [ OK ]
# TEST: ping: local->remote vid 20->vid 20                            [ OK ]
# TEST: ping: local->remote vid 10->vid 20                            [FAIL]
# TEST: ping: local->remote vid 20->vid 10                            [FAIL]

# selftests: net/forwarding: vxlan_asymmetric_ipv6.sh
# TEST: ping6: local->local vid 10->vid 20                            [ OK ]
# TEST: ping6: local->remote vid 10->vid 10                           [ OK ]
# TEST: ping6: local->remote vid 20->vid 20                           [ OK ]
# TEST: ping6: local->remote vid 10->vid 20                           [FAIL]
# TEST: ping6: local->remote vid 20->vid 10                           [FAIL]
# INFO: deleting neighbours from vlan interfaces
# TEST: ping6: local->local vid 10->vid 20                            [ OK ]
# TEST: ping6: local->remote vid 10->vid 10                           [ OK ]
# TEST: ping6: local->remote vid 20->vid 20                           [ OK ]
# TEST: ping6: local->remote vid 10->vid 20                           [FAIL]
# TEST: ping6: local->remote vid 20->vid 10                           [FAIL]
not ok 100 selftests: net/forwarding: vxlan_asymmetric_ipv6.sh # exit=1

# selftests: net/forwarding: vxlan_symmetric.sh
# RTNETLINK answers: File exists
# RTNETLINK answers: File exists
# TEST: ping: local->local vid 10->vid 20                             [ OK ]
# TEST: ping: local->remote vid 10->vid 10                            [ OK ]
# TEST: ping: local->remote vid 20->vid 20                            [ OK ]
# TEST: ping: local->remote vid 10->vid 20                            [FAIL]
# TEST: ping: local->remote vid 20->vid 10                            [FAIL]
not ok 111 selftests: net/forwarding: vxlan_symmetric.sh # exit=1

# timeout set to 0
# selftests: net/forwarding: vxlan_symmetric_ipv6.sh
# TEST: ping6: local->local vid 10->vid 20                            [ OK ]
# TEST: ping6: local->remote vid 10->vid 10                           [ OK ]
# TEST: ping6: local->remote vid 20->vid 20                           [ OK ]
# TEST: ping6: local->remote vid 10->vid 20                           [FAIL]
# TEST: ping6: local->remote vid 20->vid 10                           [FAIL]
not ok 112 selftests: net/forwarding: vxlan_symmetric_ipv6.sh # exit=1

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260812/202608121039.ca91f25a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

