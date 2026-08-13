Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78051432306;
	Thu, 13 Aug 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655134; cv=none; b=OOKVJoIOtN8FgCPkELW+r88V/GkshJ3hktGWf4m7bc0FgI+3WkmLSQ/2oI5llPTHsd4ipjF2mL1mr0N7JAixRVxl6xvbJeGRKzt3saorYxt4BhKlXufiPTYPUonFTz9nM/x2ONW4Lyivm30J6K2sFAbv7kxB6BPEQtfOwSJPcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655134; c=relaxed/simple;
	bh=SiYlYKj+35471qYe5HbwxjXNyiXXvBqXZXImPNAYxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtk2ugmYoW84OwwP2BuToH3OayLh3u7eaekhBMt2o9HIJBTJeq1QHO96m4hux9+gll5oAwe/hnqhqNlRbWO3n03yXhut2zNa9teGN1SFsmz1/wxv8X1eRgbtxSndapmF6VHx8UVu/Hz6Bn5VijuYvDdWNHiar+3B+Mrt0K7facY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPH+g2K3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPH+g2K3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786655131; x=1818191131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SiYlYKj+35471qYe5HbwxjXNyiXXvBqXZXImPNAYxpQ=;
  b=UPH+g2K3E7+tJLvKaNhUo9yOtd1rFLtmmZe3q7dK0jLmXiWxlaWXjwGr
   KtuqjPvjlv3A6Aj8XicNa1zNfn6prckI3lAn2xGCmY8uQXY7qklmJiTW5
   IG6cRzENmo6JtrhAy4ZIbgLslQ9F4ndS7HqUb1Y9J2L05OcDtEVlxUP3V
   2bOXy1pnbd4iXkHKXUaEKL1DAGoEn/0UWNDVslYY/F5306CPhsqTIc/OK
   jKIaQQBIejZH+AfzVv5K3t61r3/LHvx+poy0V8Hk2i9f1bx97dn0EQ4WS
   KCtAE5FYBgF01/EACX+f36PIN7QZSUUowwcACxNLyHSahuuGRwn7+57JD
   Q==;
X-CSE-ConnectionGUID: NtI3fkzUR4ePrMyxO404aw==
X-CSE-MsgGUID: 3p4sk1InR8ej4qwMP0DiyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91049714"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="91049714"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:05:27 -0700
X-CSE-ConnectionGUID: ROTOgZb/SmikD8D/ghSEUw==
X-CSE-MsgGUID: 4yuAmO5PStqOptyputgo2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="293973524"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Aug 2026 14:05:25 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wucc5-00000000Wec-40yF;
	Thu, 13 Aug 2026 21:05:21 +0000
Date: Fri, 14 Aug 2026 05:04:45 +0800
From: kernel test robot <lkp@intel.com>
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
	hyc.lee@gmail.com, charsyam@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: prevent write access to $MFT inode
Message-ID: <202608140556.ICYSq5Cy-lkp@intel.com>
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
[also build test WARNING on linus/master v7.2-rc7 next-20260812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongling-Zeng/ntfs-prevent-write-access-to-MFT-inode/20260814-004837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260702063529.45448-1-zenghongling%40kylinos.cn
patch subject: [PATCH] ntfs: prevent write access to $MFT inode
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260814/202608140556.ICYSq5Cy-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260814/202608140556.ICYSq5Cy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608140556.ICYSq5Cy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/ntfs/inode.h:13,
                    from fs/ntfs/ntfs.h:26,
                    from fs/ntfs/attrib.h:13,
                    from fs/ntfs/lcnalloc.h:13,
                    from fs/ntfs/file.c:19:
   fs/ntfs/file.c: In function 'ntfs_file_write_iter':
>> fs/ntfs/file.c:554:38: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     554 |                 ntfs_error(vi->i_sb, "Attempt to write to $MFT denied (mft_no: 0x%lx)",
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     555 |                                 ni->mft_no);
         |                                 ~~~~~~~~~~
         |                                   |
         |                                   u64 {aka long long unsigned int}
   fs/ntfs/debug.h:59:68: note: in definition of macro 'ntfs_error'
      59 | #define ntfs_error(sb, f, a...)         __ntfs_error(__func__, sb, f, ##a)
         |                                                                    ^
   fs/ntfs/file.c:554:84: note: format string is defined here
     554 |                 ntfs_error(vi->i_sb, "Attempt to write to $MFT denied (mft_no: 0x%lx)",
         |                                                                                  ~~^
         |                                                                                    |
         |                                                                                    long unsigned int
         |                                                                                  %llx
   fs/ntfs/file.c: In function 'ntfs_filemap_page_mkwrite':
   fs/ntfs/file.c:631:41: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
     631 |                 ntfs_error(inode->i_sb, "Attempt to write to $MFT via mmap denied (mft_no: 0x%lx)",
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     632 |                                 ni->mft_no);
         |                                 ~~~~~~~~~~
         |                                   |
         |                                   u64 {aka long long unsigned int}
   fs/ntfs/debug.h:59:68: note: in definition of macro 'ntfs_error'
      59 | #define ntfs_error(sb, f, a...)         __ntfs_error(__func__, sb, f, ##a)
         |                                                                    ^
   fs/ntfs/file.c:631:96: note: format string is defined here
     631 |                 ntfs_error(inode->i_sb, "Attempt to write to $MFT via mmap denied (mft_no: 0x%lx)",
         |                                                                                              ~~^
         |                                                                                                |
         |                                                                                                long unsigned int
         |                                                                                              %llx


vim +554 fs/ntfs/file.c

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
 > 554			ntfs_error(vi->i_sb, "Attempt to write to $MFT denied (mft_no: 0x%lx)",
   555					ni->mft_no);
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
