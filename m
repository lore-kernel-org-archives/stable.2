Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B93B0ACC;
	Wed,  2 Sep 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333012; cv=none; b=VTyswzKsuJVmj4o24OOKJbVvLT5bwKUWoDGNmH0tZ38yGfLTc6p4Kl+HqsFdQt5ztoXCYS6g3nJbhS7dqnjxYYwXCBQ4mDAM/hmYGx9Ae5+9KuGzC2V+J+TjfsWpKUzfBm9ChODIPFcpiJgSiYKPSlmfN7CvHiZDNMm7EBGFctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333012; c=relaxed/simple;
	bh=CUioBGAgghsebrVo+V7sooNS7Q/AzGLAa9moociFkkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU51jsWYU8KHapDQ65euoWxbW/22BVW8dYdP8lh9/ZhMlYulNZZ9JMPU8aylnYcelGvq38sBED9+ovUhrL3OcHzVy7LB6l0Vqch/5FwRty32YT6Ic2NHpDMxxebGAyhszo45ZG2Sov4LwG9I8QQXLotAmkkS/6bXqHpmdnezUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emBAASwS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emBAASwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788333010; x=1819869010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CUioBGAgghsebrVo+V7sooNS7Q/AzGLAa9moociFkkk=;
  b=emBAASwSgGEGnJPkDI0dlfiV910jgRQyo5HhhDJ86KsJAERdJEdzbRIv
   TXurRJca6aP14LmWpbh3DSFyEjKQlTYgnkwxOQVKeQwXp3fKA8jNgUjfY
   QRWIK8Zfq8n0z9BcX+0G54O33dRObQ1XlNNuDsFkv+tyMHBx4hvmrPvNj
   YDV290MD33oypPX6xDk1qQ0D5G6gNxwdNV32NGhfu23/m7zW2Yy80BlTx
   wy9I0AXwN+qgRJHEYjXQLWdJwL6s8vsSUYKFUFhKXBgEBGxDD0zi2nMEN
   RbTySXHFoBPj4FWckVrIktRmXaQccDuLUv5+1fFwsAS1+gc2mxpTpMctm
   w==;
X-CSE-ConnectionGUID: kjC7xNtIT0mkX39Hd3mDaw==
X-CSE-MsgGUID: qADL4lE/Ts+1wcq6qJODog==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111550849"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="111550849"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 00:10:10 -0700
X-CSE-ConnectionGUID: 5d+UJ45fSr6YDx2EVoGTzQ==
X-CSE-MsgGUID: V93PDic6QaKTGsJNcamaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="269344913"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 02 Sep 2026 00:10:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7CBEC99; Wed, 02 Sep 2026 09:10:06 +0200 (CEST)
Date: Wed, 2 Sep 2026 09:10:06 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: fix NULL dereference in tb_remove_work()
Message-ID: <20260902071006.GJ106095@black.igk.intel.com>
References: <20260831075836.16038-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831075836.16038-1-pchelkin@ispras.ru>

Hi,

On Mon, Aug 31, 2026 at 10:58:09AM +0300, Fedor Pchelkin wrote:
> There is a slight race between tb_remove_work() and tb_domain_remove()
> which leads to dereferencing a NULL tb->root_switch pointer inside
> tb_free_unplugged_xdomains():
> 
>         Thread A                            Thread B
> 
>   tb_remove_work()
>                                     tb_domain_remove()
>                                       mutex_lock(&tb->lock)
>                                       tb_stop()
>                                         /* doesn't cancel a running callback */
>                                         cancel_delayed_work(&tcm->remove_work)
>                                         ...
>                                         tb_switch_remove(tb->root_switch)
>                                         tb->root_switch = NULL
>                                       mutex_unlock(&tb->lock)
>     mutex_lock(&tb->lock)
>     ...
>     /* without checking ->root_switch */
>     tb_free_unplugged_xdomains(tb->root_switch)
>     mutex_unlock(&tb->lock)
> 
> Commit a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without
> holding tb->lock") doesn't seem right to move tb_free_unplugged_xdomains()
> out of the &tb->lock section and the check for tb->root_switch, in
> particular.  It states:
> 
>   For this reason separate removing the XDomain from the topology data
>   structures (where we need the lock) from unregistering the device from
>   the bus (where remove callbacks of the drivers are being called).
> 
> tb_free_unplugged_xdomains() belongs to the former group of functions
> requiring the lock.  And it also calls tb_xdomain_remove() which should
> only be called with &tb->lock held.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace static
> analysis tool.
> 
> Fixes: a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without holding tb->lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Applied to thunderbolt.git/fixes, thanks!
