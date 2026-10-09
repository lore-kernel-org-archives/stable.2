Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4753128DF;
	Fri,  9 Oct 2026 04:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518851; cv=none; b=hFSP1HrzJfihHel+0UWndlJik/2j1KkxXSHXlDnA8Tn7GiYnSMawgrtt0G5b25wTGw283hvDNn0SbsWDUFooFaLQaDM1n6txyX3Poa1Izz9ziyoZ56lTgt+kLeKe9M7JEiPoMAi/6PjNt/24r3kMK8GGvKgfef5/ojBND8AkYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518851; c=relaxed/simple;
	bh=yiRYsPt6ex94Wh/ZXrOWcPq5aRU4Q16tccWf8j2Y3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KewQeWXwnUXjceyt1Ab7e8ZDiDLIOhYcHC+e+pO/IZhT5vTFxdO5W3e/nwMn2mXNS39Oy35jsCOIUsthPU77szw1bjZ7txj5RXMn/1PA69UT1DQmPK+E8eXpq05YWHB9OQ9SX3+AvNHcQ1/pMYOvTZFQwpttG4livgBUKzjK+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6tOSzEW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6tOSzEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791518847; x=1823054847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yiRYsPt6ex94Wh/ZXrOWcPq5aRU4Q16tccWf8j2Y3Lo=;
  b=d6tOSzEWqnutP1rLKAKG2smOZTfY34InFEN8fV4tQC8Y64tHFCxPmIn0
   u92Ktqca+WzAW/mf6mnMNhWIAebw8D7d9137y/rhVvWpsNDabs/RfOcw1
   B4ZBcXDpFjxqpSIe6ISodByzcCq8bfpGchvD7o/z/wQ5JBvc8OydKjB6R
   B0ukNowyesx3wExWyfaUijERvYEzNWSoXOBHrEFrEV/aafhzP86BkVLlQ
   9WPibqf/XDQW1647fVEL+pZZJj79rx7zLRvVj1rZsLEPBKAlumPY+Rcdz
   lNg7QmULbz4B4VTjr3iFfIVd/E4DLpUAPNai0gihtMeVsatrkNr3dQ2ng
   Q==;
X-CSE-ConnectionGUID: o8zs06MUR2+1mPcmB9QWHA==
X-CSE-MsgGUID: Qd9FTCpnTTSugVUGOHeWCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="200679"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="200679"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 21:07:25 -0700
X-CSE-ConnectionGUID: jyAuyDsuTVS1P5uXcAccbQ==
X-CSE-MsgGUID: IMskUT41RLehVC1pfbtzeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="538168"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Oct 2026 21:07:21 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xF1t8-000000005Hc-3osz;
	Fri, 09 Oct 2026 04:07:18 +0000
Date: Fri, 9 Oct 2026 12:06:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, rafael@kernel.org,
	lenb@kernel.org, pavel@kernel.org, willemdebruijn.kernel@gmail.com,
	kuba@kernel.org, pabeni@redhat.com, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org,
	=?iso-8859-1?B?Suly6W15?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
Message-ID: <202610091149.zThf8fez-lkp@intel.com>
References: <20261008124106.665014-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008124106.665014-1-Jason@zx2c4.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-A-Donenfeld/udp_tunnel-drop-packets-when-hibernating/20261008-144021
base:   net/main
patch link:    https://lore.kernel.org/r/20261008124106.665014-1-Jason%40zx2c4.com
patch subject: [PATCH net] udp_tunnel: drop packets when hibernating
config: s390-randconfig-1000-20261009 (https://download.01.org/0day-ci/archive/20261009/202610091149.zThf8fez-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610091149.zThf8fez-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610091149.zThf8fez-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/virtio_console.c:636:33: error: expected identifier
     636 |         if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         |                                        ^
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
>> drivers/char/virtio_console.c:636:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
    1173 |             smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         |                                        ^
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   drivers/char/virtio_console.c:1173:33: error: expected identifier
   include/linux/freezer.h:79:21: note: expanded from macro 'pm_freezing'
      79 | #define pm_freezing (false)
         |                     ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +636 drivers/char/virtio_console.c

cdfadfc1adb87fc Amit Shah          2010-05-19  608  
eb5e89fc70bb3f1 Masami Hiramatsu   2012-08-09  609  static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
eb5e89fc70bb3f1 Masami Hiramatsu   2012-08-09  610  			      int nents, size_t in_count,
fc220d6be3c7e48 Sungho Bae         2026-06-04  611  			      struct port_buffer *buf, bool nonblock)
f997f00bf8c3ddf Amit Shah          2009-12-21  612  {
f997f00bf8c3ddf Amit Shah          2009-12-21  613  	struct virtqueue *out_vq;
589575a23562b58 Rusty Russell      2012-10-16  614  	int err;
cdfadfc1adb87fc Amit Shah          2010-05-19  615  	unsigned long flags;
f997f00bf8c3ddf Amit Shah          2009-12-21  616  	unsigned int len;
a616ad344d9f7fe Sungho Bae         2026-06-04  617  	struct ports_device *portdev;
f997f00bf8c3ddf Amit Shah          2009-12-21  618  
cdfadfc1adb87fc Amit Shah          2010-05-19  619  	spin_lock_irqsave(&port->outvq_lock, flags);
cdfadfc1adb87fc Amit Shah          2010-05-19  620  
a616ad344d9f7fe Sungho Bae         2026-06-04  621  	portdev = READ_ONCE(port->portdev);
a616ad344d9f7fe Sungho Bae         2026-06-04  622  
a616ad344d9f7fe Sungho Bae         2026-06-04  623  	if (!portdev) {
a616ad344d9f7fe Sungho Bae         2026-06-04  624  		in_count = 0;
a616ad344d9f7fe Sungho Bae         2026-06-04  625  		goto free_and_done;
a616ad344d9f7fe Sungho Bae         2026-06-04  626  	}
a616ad344d9f7fe Sungho Bae         2026-06-04  627  
b187532ac6dba56 Sungho Bae         2026-06-04  628  	/*
b187532ac6dba56 Sungho Bae         2026-06-04  629  	 * Check freeze flag under the lock so that the flag check and
b187532ac6dba56 Sungho Bae         2026-06-04  630  	 * virtqueue_add_outbuf() are atomic with respect to
b187532ac6dba56 Sungho Bae         2026-06-04  631  	 * remove_port_data() which also takes outvq_lock.  This
b187532ac6dba56 Sungho Bae         2026-06-04  632  	 * guarantees that once remove_port_data() returns, no new
b187532ac6dba56 Sungho Bae         2026-06-04  633  	 * buffers can be added before remove_vqs() tears down the vq.
b187532ac6dba56 Sungho Bae         2026-06-04  634  	 * Pairs with smp_store_release() in virtcons_freeze/restore.
b187532ac6dba56 Sungho Bae         2026-06-04  635  	 */
b187532ac6dba56 Sungho Bae         2026-06-04 @636  	if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
b187532ac6dba56 Sungho Bae         2026-06-04  637  		goto free_and_done;
b187532ac6dba56 Sungho Bae         2026-06-04  638  
a616ad344d9f7fe Sungho Bae         2026-06-04  639  	out_vq = port->out_vq;
a616ad344d9f7fe Sungho Bae         2026-06-04  640  
cdfadfc1adb87fc Amit Shah          2010-05-19  641  	reclaim_consumed_buffers(port);
cdfadfc1adb87fc Amit Shah          2010-05-19  642  
fc220d6be3c7e48 Sungho Bae         2026-06-04  643  	err = virtqueue_add_outbuf(out_vq, sg, nents, buf, GFP_ATOMIC);
f997f00bf8c3ddf Amit Shah          2009-12-21  644  
f997f00bf8c3ddf Amit Shah          2009-12-21  645  	/* Tell Host to go! */
505b0451c47699c Michael S. Tsirkin 2010-04-12  646  	virtqueue_kick(out_vq);
f997f00bf8c3ddf Amit Shah          2009-12-21  647  
589575a23562b58 Rusty Russell      2012-10-16  648  	if (err) {
9ff4cfab82d27e9 Rusty Russell      2010-04-08  649  		in_count = 0;
fc220d6be3c7e48 Sungho Bae         2026-06-04  650  		goto free_and_done;
f997f00bf8c3ddf Amit Shah          2009-12-21  651  	}
f997f00bf8c3ddf Amit Shah          2009-12-21  652  
589575a23562b58 Rusty Russell      2012-10-16  653  	if (out_vq->num_free == 0)
cdfadfc1adb87fc Amit Shah          2010-05-19  654  		port->outvq_full = true;
cdfadfc1adb87fc Amit Shah          2010-05-19  655  
cdfadfc1adb87fc Amit Shah          2010-05-19  656  	if (nonblock)
cdfadfc1adb87fc Amit Shah          2010-05-19  657  		goto done;
cdfadfc1adb87fc Amit Shah          2010-05-19  658  
cdfadfc1adb87fc Amit Shah          2010-05-19  659  	/*
cdfadfc1adb87fc Amit Shah          2010-05-19  660  	 * Wait till the host acknowledges it pushed out the data we
531295e63be8c2b Amit Shah          2010-10-20  661  	 * sent.  This is done for data from the hvc_console; the tty
531295e63be8c2b Amit Shah          2010-10-20  662  	 * operations are performed with spinlocks held so we can't
531295e63be8c2b Amit Shah          2010-10-20  663  	 * sleep here.  An alternative would be to copy the data to a
531295e63be8c2b Amit Shah          2010-10-20  664  	 * buffer and relax the spinning requirement.  The downside is
531295e63be8c2b Amit Shah          2010-10-20  665  	 * we need to kmalloc a GFP_ATOMIC buffer each time the
531295e63be8c2b Amit Shah          2010-10-20  666  	 * console driver writes something out.
fc220d6be3c7e48 Sungho Bae         2026-06-04  667  	 *
fc220d6be3c7e48 Sungho Bae         2026-06-04  668  	 * Spin until host returns the buffer.
fc220d6be3c7e48 Sungho Bae         2026-06-04  669  	 * Capture the returned buf so we can free it.
fc220d6be3c7e48 Sungho Bae         2026-06-04  670  	 * If broken, buf == NULL and buf stays in the vq;
fc220d6be3c7e48 Sungho Bae         2026-06-04  671  	 * remove_vqs() will call virtqueue_detach_unused_buf() -> free_buf().
cdfadfc1adb87fc Amit Shah          2010-05-19  672  	 */
fc220d6be3c7e48 Sungho Bae         2026-06-04  673  	while (!(buf = virtqueue_get_buf(out_vq, &len))
40e4dc530118dbb Heinz Graalfs      2013-10-29  674  		&& !virtqueue_is_broken(out_vq))
f997f00bf8c3ddf Amit Shah          2009-12-21  675  		cpu_relax();
fc220d6be3c7e48 Sungho Bae         2026-06-04  676  
fc220d6be3c7e48 Sungho Bae         2026-06-04  677  free_and_done:
fc220d6be3c7e48 Sungho Bae         2026-06-04  678  	if (buf)
fc220d6be3c7e48 Sungho Bae         2026-06-04  679  		free_buf(buf, false);
cdfadfc1adb87fc Amit Shah          2010-05-19  680  done:
cdfadfc1adb87fc Amit Shah          2010-05-19  681  	spin_unlock_irqrestore(&port->outvq_lock, flags);
17e5b4f20adbe28 Amit Shah          2011-09-14  682  
17e5b4f20adbe28 Amit Shah          2011-09-14  683  	port->stats.bytes_sent += in_count;
cdfadfc1adb87fc Amit Shah          2010-05-19  684  	/*
cdfadfc1adb87fc Amit Shah          2010-05-19  685  	 * We're expected to return the amount of data we wrote -- all
cdfadfc1adb87fc Amit Shah          2010-05-19  686  	 * of it
cdfadfc1adb87fc Amit Shah          2010-05-19  687  	 */
9ff4cfab82d27e9 Rusty Russell      2010-04-08  688  	return in_count;
f997f00bf8c3ddf Amit Shah          2009-12-21  689  }
f997f00bf8c3ddf Amit Shah          2009-12-21  690  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
