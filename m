Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CC2C3255;
	Sat, 15 Aug 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804255; cv=none; b=Av8SmkbeeXdYxw9A8WeuvngAReSkOXHdLJBMmndzVRHYqfx2clWMVBEv+CPglKX/J8i4AN3KwV5SRGxdaPc8ybbaLvxwkzz+FWfADZU2lQ10Bj2vvqYGRs7/yMS3gKYMV6JkmcC/HGaciW7wUAVzWfJiBsQQ3S5YTJiuAeM+sVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804255; c=relaxed/simple;
	bh=627YEaIgn6XIRErVvdP1vn7AftyvusH8R6f6VNQ6hHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pABVpMq5gr7USidYkWr/ToZX4SARwPm78rLn/Ku9oZ+nvmmxLtz2yim5zSKgd54OlAva7dWVz2Uwp0pu+0Jftyo1EjKrGROPyMHDWLK3fv8Qg6G+d6O8xIz8HoxjZVbbjOL1eIUl3hpMj97zUMVaHhlZePp/1dwXjdj2uh0SANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qdlve0d4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qdlve0d4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786804252; x=1818340252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=627YEaIgn6XIRErVvdP1vn7AftyvusH8R6f6VNQ6hHw=;
  b=Qdlve0d4G3oU2X6zPbpLfVlsNozX0CJEzfUXTp+rNK7vzIMS08gagpGb
   A6RloJxG6bfaRXzYZm00QZ4diWrPmvMswnfWirVjQCIjp3oO/hsrjV/OV
   EKMZgnssRWXIECskYogM7kIaCgBeYrRiQoTYl3yGsJNhX4qYBd6+un/Or
   qNzMq8qOXwfQxLxtOyTX+bqa82qlE4ux2nYueDpL8tHXQMhOV6stt7jI7
   CHr9xPST0e+WCqZ0HUp9lWi25vLq4i48hIJiho/tth3xPjblvxQYVJjnu
   OnwIGA4yUlK8qixvPbcWbw8tKfYI4XTXFcg/GqdDC2+dMJyV6qTbEHPim
   g==;
X-CSE-ConnectionGUID: 8fEV+XgKRkO/9XpfQS4R0Q==
X-CSE-MsgGUID: xWFJ5Q3yQ7umsRCorUFXWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="91167087"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="91167087"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 07:30:48 -0700
X-CSE-ConnectionGUID: JQba7RYARCyUEjhoYvFsFg==
X-CSE-MsgGUID: NatFumRNSIS8dNF5kinkkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="268740595"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Aug 2026 07:30:45 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvFPE-00000000cCw-3b8Y;
	Sat, 15 Aug 2026 14:30:40 +0000
Date: Sat, 15 Aug 2026 22:28:25 +0800
From: kernel test robot <lkp@intel.com>
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
	hyc.lee@gmail.com, charsyam@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: prevent write access to $MFT inode
Message-ID: <202608152250.mYKnVpFv-lkp@intel.com>
References: <20260702063529.45448-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702063529.45448-1-zenghongling@kylinos.cn>

Hi Hongling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongling-Zeng/ntfs-prevent-write-access-to-MFT-inode/20260814-004837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260702063529.45448-1-zenghongling%40kylinos.cn
patch subject: [PATCH] ntfs: prevent write access to $MFT inode
config: um-randconfig-r071-20260815 (https://download.01.org/0day-ci/archive/20260815/202608152250.mYKnVpFv-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608152250.mYKnVpFv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608152250.mYKnVpFv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ntfs/file.c:9:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> fs/ntfs/file.c:555:5: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
     554 |                 ntfs_error(vi->i_sb, "Attempt to write to $MFT denied (mft_no: 0x%lx)",
         |                                                                                  ~~~
         |                                                                                  %llx
     555 |                                 ni->mft_no);
         |                                 ^~~~~~~~~~
   fs/ntfs/debug.h:59:66: note: expanded from macro 'ntfs_error'
      59 | #define ntfs_error(sb, f, a...)         __ntfs_error(__func__, sb, f, ##a)
         |                                                                    ~    ^
   fs/ntfs/file.c:632:5: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
     631 |                 ntfs_error(inode->i_sb, "Attempt to write to $MFT via mmap denied (mft_no: 0x%lx)",
         |                                                                                              ~~~
         |                                                                                              %llx
     632 |                                 ni->mft_no);
         |                                 ^~~~~~~~~~
   fs/ntfs/debug.h:59:66: note: expanded from macro 'ntfs_error'
      59 | #define ntfs_error(sb, f, a...)         __ntfs_error(__func__, sb, f, ##a)
         |                                                                    ~    ^
   3 warnings generated.


vim +555 fs/ntfs/file.c

   537	
   538	static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
   539	{
   540		struct file *file = iocb->ki_filp;
   541		struct inode *vi = file->f_mapping->host;
   542		struct ntfs_inode *ni = NTFS_I(vi);
   543		struct ntfs_volume *vol = ni->vol;
   544		ssize_t ret;
   545		ssize_t count;
   546		loff_t pos;
   547		int err;
   548		loff_t old_data_size, old_init_size;
   549	
   550		if (NVolShutdown(vol))
   551			return -EIO;
   552	
   553		if (ni->mft_no == FILE_MFT) {
   554			ntfs_error(vi->i_sb, "Attempt to write to $MFT denied (mft_no: 0x%lx)",
 > 555					ni->mft_no);
   556			return -EACCES;
   557		}
   558	
   559		if (NInoEncrypted(ni)) {
   560			ntfs_error(vi->i_sb, "Writing for %s files is not supported yet",
   561				   NInoCompressed(ni) ? "Compressed" : "Encrypted");
   562			return -EOPNOTSUPP;
   563		}
   564	
   565		if (NInoCompressed(ni) && iocb->ki_flags & IOCB_DIRECT)
   566			return -EOPNOTSUPP;
   567	
   568		if (iocb->ki_flags & IOCB_NOWAIT) {
   569			if (!inode_trylock(vi))
   570				return -EAGAIN;
   571		} else
   572			inode_lock(vi);
   573	
   574		ret = generic_write_checks(iocb, from);
   575		if (ret <= 0)
   576			goto out_lock;
   577	
   578		err = file_modified(iocb->ki_filp);
   579		if (err) {
   580			ret = err;
   581			goto out_lock;
   582		}
   583	
   584		if (!(vol->vol_flags & VOLUME_IS_DIRTY))
   585			ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
   586	
   587		pos = iocb->ki_pos;
   588		count = ret;
   589	
   590		old_data_size = ni->data_size;
   591		old_init_size = ni->initialized_size;
   592	
   593		if (NInoNonResident(ni) && NInoCompressed(ni)) {
   594			ret = ntfs_compress_write(ni, pos, count, from);
   595			if (ret > 0)
   596				iocb->ki_pos += ret;
   597			goto out;
   598		}
   599	
   600		if (NInoNonResident(ni) && iocb->ki_flags & IOCB_DIRECT)
   601			ret = ntfs_dio_write_iter(iocb, from);
   602		else
   603			ret = iomap_file_buffered_write(iocb, from, &ntfs_write_iomap_ops,
   604					&ntfs_iomap_folio_ops, NULL);
   605	out:
   606		if (ret < 0 && ret != -EIOCBQUEUED) {
   607			if (ni->initialized_size != old_init_size) {
   608				mutex_lock(&ni->mrec_lock);
   609				ntfs_attr_set_initialized_size(ni, old_init_size);
   610				mutex_unlock(&ni->mrec_lock);
   611			}
   612			if (ni->data_size != old_data_size) {
   613				truncate_setsize(vi, old_data_size);
   614				ntfs_attr_truncate(ni, old_data_size);
   615			}
   616		}
   617	out_lock:
   618		inode_unlock(vi);
   619		if (ret > 0)
   620			ret = generic_write_sync(iocb, ret);
   621		return ret;
   622	}
   623	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
