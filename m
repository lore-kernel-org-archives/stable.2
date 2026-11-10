Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321171;
	b=Q/PwXkLkctqZKmAE0MpEzAKUPLUPq91PoVpJIVQboJXLkf75ljXnByeBnKjT+9ouMFq/
	 OR7kWU385fNG9zEBRUrARTV888WJf2uBzxjQwmbRynNhvOr+vPRHbzkJCYbxg5aO9VgQk
	 RdmbgCHvlAsSX48rH+xxcPTY+WH8iQRUaj/Xflr8Tbcah7muhnzeXLppjNaBsaCYDCxjZ
	 NEx8CuocXsX7fEsUcIHY16wIn4yNJ/fORQQP73887jGiFBzertB/Og1vLZrXZ6JWEowJW
	 /tGA7v2pezIP+2BmDMD6u0NDvHxR66qQc55bFO/BJYb+pOBc+yLdErdRvenBz5Ui7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321171;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=F/HuyNyKT2+GzcUJBapBdFQKnCb/37VyfI+ZWG2SjyY=;
	b=qhmnt415ZnjCsIc6ezyrjv/PHz+n87O5JKKJmZN6j+c54w9ZArqjLu6DmBQYmzfNAoZv
	 ohENMV1UlBRhUTJjGWM+aADSVoBIO/9Kdedke26yZpMRittrbiHAgffn/e2nGkyTNMT4B
	 snuzY/sEUnhoj//TiYAP8rPauZU8c/9WQaTeSMJlpvNJgcyVLdc49QSyw6mRYwtOyrNA7
	 9Lf1siVOb+9ebYOUG344S1DiKwv8mnxHqN+tlPkSEMV4wAB8ywFr3geciNeMGB4uhBQe9
	 ihgbUIzAATh0ejcbtLY3s4OJIJsl808DPDP2Ad8FnonPaQSbUrR1NWVZ4768H8V26lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gaZ30+wF;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE2606A31C;
	Tue, 10 Nov 2026 14:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gaZ30+wF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794321169; x=1825857169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cvc4VpkbWqnnr3npKGdN5mFkliwYnP43P6OeBF0pgI8=;
  b=gaZ30+wFYS1mIzEvhAtQgQ+EUwVYmGZGQK3kNpS+xIKccXEqNKFKjF/4
   m7M9Ll7N42aarx1yas3Rbdr/K9x459AB9+utDyFdwDtUsUsgGuqNZPNQc
   qQ7m4OOyqFhOfO1IUMCsu85fuDXDlkYGL8JXNtUwRvOLFlqyrsusuMUto
   OrIB9Lbo5h8tDeSEObJNU5zsbAGRCw49pgdTQ28332b57IsIpLejqw6uH
   CY8ePStO/LIZQlsuVB6DoTBf2UUaJgqP/3k6I5ejzTk8+WIfQHuGeb5pH
   LKEvsmxfp+K7kJxkabi79OjhjiK2fI/OucNJjVkNL00czMp1rqBUD/Vat
   Q==;
X-CSE-ConnectionGUID: QhDA+pqLT4qRRULH4N/QGA==
X-CSE-MsgGUID: OuUcI1ddRtGyokBEjQqDYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2972411"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2972411"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:32:48 -0800
X-CSE-ConnectionGUID: lunFIvEJS12CKDZnBH25eg==
X-CSE-MsgGUID: KPUXg0aIR32jzXdVTOvcIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7996829"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Nov 2026 06:32:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQmtv-00000000wxr-3kvC;
	Tue, 10 Nov 2026 14:32:43 +0000
Date: Tue, 10 Nov 2026 22:31:44 +0800
From: kernel test robot <lkp@intel.com>
To: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds
 down into the past
Message-ID: <202611102202.ZY3wJ35v-lkp@intel.com>
References: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>
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
In-Reply-To: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>

Hi Arun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7485659ecb81d5fce3a3edf2cae9fcb29c17b1cd]

url:    https://github.com/intel-lab-lkp/linux/commits/Arun-Iyengar-via-B4-Relay/rtc-Don-t-lose-a-minute-resolution-alarm-that-rounds-down-into-the-past/20261110-071347
base:   7485659ecb81d5fce3a3edf2cae9fcb29c17b1cd
patch link:    https://lore.kernel.org/r/20261110-rtc-minute-alarm-v1-1-be9d7c5227a1%40gmail.com
patch subject: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds down into the past
config: i386-defconfig (https://download.01.org/0day-ci/archive/20261110/202611102202.ZY3wJ35v-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261110/202611102202.ZY3wJ35v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611102202.ZY3wJ35v-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rtc/interface.c:562:39: warning: overflow in expression; result is -129'542'144 with type 'long' [-Winteger-overflow]
     562 |                         alarm_time = ktime_add_ns(down, 60 * NSEC_PER_SEC);
         |                                      ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   include/linux/ktime.h:60:43: note: expanded from macro 'ktime_add_ns'
      60 | #define ktime_add_ns(kt, nsval)         ((kt) + (nsval))
         |                                                  ^~~~~
   1 warning generated.


vim +562 drivers/rtc/interface.c

   512	
   513	int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
   514	{
   515		ktime_t alarm_time;
   516		int err;
   517	
   518		if (!rtc->ops)
   519			return -ENODEV;
   520		else if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
   521			return -EINVAL;
   522	
   523		err = rtc_valid_tm(&alarm->time);
   524		if (err != 0)
   525			return err;
   526	
   527		err = rtc_valid_range(rtc, &alarm->time);
   528		if (err)
   529			return err;
   530	
   531		err = mutex_lock_interruptible(&rtc->ops_lock);
   532		if (err)
   533			return err;
   534		if (rtc->aie_timer.enabled)
   535			rtc_timer_remove(rtc, &rtc->aie_timer);
   536	
   537		alarm_time = rtc_tm_to_ktime(alarm->time);
   538		if (test_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features) &&
   539		    alarm->time.tm_sec) {
   540			ktime_t down = ktime_sub_ns(alarm_time,
   541						    (u64)alarm->time.tm_sec * NSEC_PER_SEC);
   542			struct rtc_time tm;
   543			ktime_t now;
   544	
   545			err = __rtc_read_time(rtc, &tm);
   546			if (err)
   547				goto unlock;
   548			now = rtc_tm_to_ktime(tm);
   549	
   550			/*
   551			 * Round down so we never miss a deadline. If that puts an alarm
   552			 * that is still in the future into the past, the timer would
   553			 * expire right away and the hardware alarm would never be
   554			 * armed: whoever relies on it, e.g. to wake the system from
   555			 * suspend, would wait forever. Round up to the next minute
   556			 * instead. An alarm already in the past is left alone, it is
   557			 * handled by __rtc_set_alarm.
   558			 */
   559			if (ktime_after(down, now) || !ktime_after(alarm_time, now))
   560				alarm_time = down;
   561			else
 > 562				alarm_time = ktime_add_ns(down, 60 * NSEC_PER_SEC);
   563		}
   564	
   565		rtc->aie_timer.node.expires = alarm_time;
   566		rtc->aie_timer.period = 0;
   567		if (alarm->enabled)
   568			err = rtc_timer_enqueue(rtc, &rtc->aie_timer);
   569	
   570	unlock:
   571		mutex_unlock(&rtc->ops_lock);
   572	
   573		return err;
   574	}
   575	EXPORT_SYMBOL_GPL(rtc_set_alarm);
   576	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
