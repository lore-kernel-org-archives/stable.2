Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616018E025;
	Sun, 18 Oct 2026 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306409; cv=none; b=L4uT6ASE142uD/5R//UABQwGv5v30aUKWan1YNZWdtbBuLpza5bmFDwkJ385W7m1lJxJNqAAGFwaCI0p2i9cotGilCNmAU0dz6Qt31ecBjMVWTaxc4Xd8Vcg+rhRcWNMxkYXvXSUXuZhMbCwOPZ/VScTOVwBKCX06TukxJnk4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306409; c=relaxed/simple;
	bh=w1wO8qQaTW2xkC3sLmBdQdWvViNPc9PnTY0M7UhlTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn3SegvnQ59sViNemkw1rGnX6HQ3AWULaGLlrsB3d33xIg+5ziEUUCrXR2yKm0kKIkxYwFzDPXmkJCWfua4b4cRAfVA1dGiPJM1aqzBbtCcVDSU3qkPrgqgWZbBBEN4Qs9f5ieCNCGspwOZ9n+MW8EpafzaSbxN7nL2thUwrFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgrO+BXp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgrO+BXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792306406; x=1823842406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w1wO8qQaTW2xkC3sLmBdQdWvViNPc9PnTY0M7UhlTYk=;
  b=JgrO+BXpUE3BfL6Ubbm5wx2XBYXPxkpAV9EUpTzcC2fBt3Yofrd85lcE
   YARotmS9u4PVZ6IYK1XNxDdSyOkuz3ec3kdZrwZYZcvGl6EdjWnoLU+EE
   z7uGXc16XMON4C3bUMFpmdGhck88Gk+In3KrgmbiBWEY7L2hZ2msGn9UK
   K86yvDQkUS8FmMjpcEI4MrJA49Xz4BEsHNEHLt/l8ZO5rgKsgRPOj5GvO
   XbjoYtzgubz8hrD3sI4TbwjYseATjcWuxs2kidfQp6i8L/rkH2c3W5/MT
   FghfOcBZKKPW6NN+s7nAw7CvEsRxWvMLC6K956CzyvN5GnVH7Hggnufjh
   Q==;
X-CSE-ConnectionGUID: vBJjgifTRiSOV95u7Np4Fg==
X-CSE-MsgGUID: 3F2u8a3KT4S3010fV66YMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="905559"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="905559"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 23:53:26 -0700
X-CSE-ConnectionGUID: S/HCpDVeSie483FaYbzM2g==
X-CSE-MsgGUID: krPEmQ7pQ5CpbGQ91WjgpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2354289"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Oct 2026 23:53:23 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIKlk-00000000KD4-01JU;
	Sun, 18 Oct 2026 06:53:20 +0000
Date: Sun, 18 Oct 2026 14:52:29 +0800
From: kernel test robot <lkp@intel.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] greybus: operation: arm the timeout timer before sending
 the request
Message-ID: <202610181452.8uUjB47B-lkp@intel.com>
References: <20261017171743.24612-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017171743.24612-1-ngocthang2710.1999@gmail.com>

Hi Nguyen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.3-rc7 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nguyen-Ngoc-Thang/greybus-operation-arm-the-timeout-timer-before-sending-the-request/20261018-001743
base:   linus/master
patch link:    https://lore.kernel.org/r/20261017171743.24612-1-ngocthang2710.1999%40gmail.com
patch subject: [PATCH] greybus: operation: arm the timeout timer before sending the request
config: arc-randconfig-1000-20261018 (https://download.01.org/0day-ci/archive/20261018/202610181452.8uUjB47B-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261018/202610181452.8uUjB47B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610181452.8uUjB47B-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/greybus/operation.c: In function 'gb_operation_request_send':
>> drivers/greybus/operation.c:785:1: warning: label 'err_put_active' defined but not used [-Wunused-label]
     785 | err_put_active:
         | ^~~~~~~~~~~~~~


vim +/err_put_active +785 drivers/greybus/operation.c

10c69399043351 drivers/staging/greybus/operation.c Alex Elder        2014-11-21  703  
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  704  /**
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  705   * gb_operation_request_send() - send an operation request message
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  706   * @operation:	the operation to initiate
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  707   * @callback:	the operation completion callback
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  708   * @timeout:	operation timeout in milliseconds, or zero for no timeout
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  709   * @gfp:	the memory flags to use for any allocations
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  710   *
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  711   * The caller has filled in any payload so the request message is ready to go.
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  712   * The callback function supplied will be called when the response message has
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  713   * arrived, a unidirectional request has been sent, or the operation is
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  714   * cancelled, indicating that the operation is complete. The callback function
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  715   * can fetch the result of the operation using gb_operation_result() if
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  716   * desired.
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  717   *
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  718   * Return: 0 if the request was successfully queued in the host-driver queues,
613c15e86b7ac3 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  719   * or a negative errno.
d90c25b0a279b0 drivers/staging/greybus/operation.c Alex Elder        2014-10-16  720   */
d90c25b0a279b0 drivers/staging/greybus/operation.c Alex Elder        2014-10-16  721  int gb_operation_request_send(struct gb_operation *operation,
a52c4352aef855 drivers/staging/greybus/operation.c Johan Hovold      2015-07-01  722  			      gb_operation_callback callback,
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  723  			      unsigned int timeout,
a52c4352aef855 drivers/staging/greybus/operation.c Johan Hovold      2015-07-01  724  			      gfp_t gfp)
d90c25b0a279b0 drivers/staging/greybus/operation.c Alex Elder        2014-10-16  725  {
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  726  	struct gb_connection *connection = operation->connection;
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  727  	struct gb_operation_msg_hdr *header;
4afb7fd0154753 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  728  	unsigned int cycle;
ea2c2ee8057138 drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  729  	int ret;
d90c25b0a279b0 drivers/staging/greybus/operation.c Alex Elder        2014-10-16  730  
ca1f8f809024db drivers/staging/greybus/operation.c Johan Hovold      2016-05-11  731  	if (gb_connection_is_offloaded(connection))
ca1f8f809024db drivers/staging/greybus/operation.c Johan Hovold      2016-05-11  732  		return -EBUSY;
ca1f8f809024db drivers/staging/greybus/operation.c Johan Hovold      2016-05-11  733  
37754030b0b9f7 drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  734  	if (!callback)
37754030b0b9f7 drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  735  		return -EINVAL;
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  736  
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  737  	/*
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  738  	 * Record the callback function, which is executed in
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  739  	 * non-atomic (workqueue) context when the final result
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  740  	 * of an operation has been set.
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  741  	 */
d90c25b0a279b0 drivers/staging/greybus/operation.c Alex Elder        2014-10-16  742  	operation->callback = callback;
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  743  
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  744  	/*
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  745  	 * Assign the operation's id, and store it in the request header.
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  746  	 * Zero is a reserved operation id for unidirectional operations.
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  747  	 */
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  748  	if (gb_operation_is_unidirectional(operation)) {
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  749  		operation->id = 0;
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  750  	} else {
4afb7fd0154753 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  751  		cycle = (unsigned int)atomic_inc_return(&connection->op_cycle);
4afb7fd0154753 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  752  		operation->id = (u16)(cycle % U16_MAX + 1);
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  753  	}
3e2ee2c1e50541 drivers/staging/greybus/operation.c Johan Hovold      2016-04-29  754  
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  755  	header = operation->request->header;
afb2e1342e75b5 drivers/staging/greybus/operation.c Alex Elder        2014-12-03  756  	header->operation_id = cpu_to_le16(operation->id);
e8b48d1586abd6 drivers/staging/greybus/operation.c Alex Elder        2014-11-20  757  
3deb37d4ad04c6 drivers/staging/greybus/operation.c Alex Elder        2014-11-25  758  	gb_operation_result_set(operation, -EINPROGRESS);
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  759  
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  760  	/*
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  761  	 * Get an extra reference on the operation. It'll be dropped when the
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  762  	 * operation completes.
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  763  	 */
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  764  	gb_operation_get(operation);
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  765  	ret = gb_operation_get_active(operation);
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  766  	if (ret)
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  767  		goto err_put;
3325a4ad7122ac drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  768  
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  769  	/* Arm before sending, as the response may complete the operation at once. */
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  770  	if (timeout) {
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  771  		operation->timer.expires = jiffies + msecs_to_jiffies(timeout);
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  772  		add_timer(&operation->timer);
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  773  	}
dbec27298b0df8 drivers/staging/greybus/operation.c Johan Hovold      2017-01-23  774  
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  775  	ret = gb_message_send(operation->request, gfp);
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  776  	if (ret)
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  777  		goto err_del_timer;
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  778  
008974cb528d30 drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  779  	return 0;
008974cb528d30 drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  780  
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  781  err_del_timer:
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  782  	/* A timer that already fired has queued work which drops our references. */
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  783  	if (timeout && !timer_delete_sync(&operation->timer))
7a8e53d4f57e9c drivers/greybus/operation.c         Nguyen Ngoc Thang 2026-10-18  784  		return ret;
008974cb528d30 drivers/staging/greybus/operation.c Johan Hovold      2015-07-14 @785  err_put_active:
3eeac7e37ce985 drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  786  	gb_operation_put_active(operation);
008974cb528d30 drivers/staging/greybus/operation.c Johan Hovold      2015-07-14  787  err_put:
ea2c2ee8057138 drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  788  	gb_operation_put(operation);
ea2c2ee8057138 drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  789  
ea2c2ee8057138 drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  790  	return ret;
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  791  }
1dad6b3515b2ca drivers/staging/greybus/operation.c Johan Hovold      2015-03-27  792  EXPORT_SYMBOL_GPL(gb_operation_request_send);
c25572ca943a1f drivers/staging/greybus/operation.c Alex Elder        2014-12-03  793  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
