Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951F1AB6F1
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293995; cv=none; b=da+CFWHxG2V4yDW0zCfqSiPA0Y+4P93d/Fa3fmjWAOBaGTZ/+sDyGrv9NEKU/C6kQF8CBLe+ZHW8voW66dl7R1ADwpHuAumCadeJ6a2yl2LGx6szKCCfglcWny8FnBfghndydWUiRCX9OvoV7ZNqc1J49EMwULiCsN5xeOY2JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293995; c=relaxed/simple;
	bh=ndy+XQIjb+bXruAl3ufzMAnurhqUwUJT2EMJD07YEn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXd0127JsVIVHLUEsfIJrkma+XRggeh7Iss6hHK6wlSSqYlPT/n4KHPYxzKo+ytAXikMzuuHU4/5uq0g5fCez74bdB2Qkx1q4f3+JGG2PW0z1Ls9z0kPW2ABqRoLbX3RFbxO6JbbD07tQe5Ug2kmAbDBPCQ9Gm7HwaHGd5cDOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=h6vTe0lQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7pvbAzE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="h6vTe0lQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7pvbAzE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C47571400086;
	Wed, 24 Jun 2026 05:39:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 24 Jun 2026 05:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782293992; x=1782380392; bh=qwPtXcTmpk
	w3vEjsqekKQfXtxvhPBQW5o2Gmds+R4JM=; b=h6vTe0lQqBm7kUgOyjDib1YDUJ
	jT/Uz8+eOZIzvGwhG7IUjz8Tpcr8eS4ls7HssRuL/aCRrJZmBZQNKgM2aHKwUOso
	nXwxEHYLCxDY0gyvdIbvcs4+dEJcfRGHHwNIHqJAjOjaS+VjOD1XIflxJzLQ9LBD
	6pAYXNK749z4q/ilmuxklN71FMDjLjFGFi6cO1UKxQAvJRYplzcV3jKb4FiqzaGj
	Hqc/b2giKZOoBa+7GAlLZMist5T+zrVbZq5W233BCWmXquLBd+3oP6KqseL1aCM3
	VVM5inuRNe+tH0+wd/u2Q4MxNO08VG8A72j6jgtWdzoCr0MBZV7/gonDUcoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782293992; x=1782380392; bh=qwPtXcTmpkw3vEjsqekKQfXtxvhPBQW5o2G
	mds+R4JM=; b=Q7pvbAzEh8Frh0wBQhW6A7vVsYImLS8V9rCd1gjEw7OdsIm+9h5
	iYsXs81DfP79xGCnMOmVNwyKQCXQSi83FKD2l5gtYFAF/l4czF3lmdakBOyLWnmr
	iYK6e2G5r4YxzxiI5cuuMNR6qzAe+7iYo98O5m1uLB2wnLrdfbeomsx2Nj9BE9OR
	6FKAXvSo4S2OuScNf5Gy3Z52BGQgWm7cuGK9Hu7QzT55zlLWrVAkXvH10Fcpvn2T
	O1qk5IxIjb3+FL6bLhsKN14vOOG4sWV3hFJAbGtpKdGT2NhuuwWty8l2qAyiPGWu
	bdFEktTxz7ZwKGnOCyNFxLM9qfv/+T8t8kg==
X-ME-Sender: <xms:6KU7ahErKkWTWVfSNBe4677DQNnSCOs3P2OlcMjf7hvCWXECKjPcdA>
    <xme:6KU7akKqcaAZtqxyi_Co0u__XwLhxASp0LHFGodkynzGqR8ba2Yh6Ffe2u4N01TGy
    RWQh8K8zrlgaTvEv2s971iPPNl8V8eMq2EfLnrGYxqlGjpm>
X-ME-Received: <xmr:6KU7atn_dU1OD273bRHLjwY9ENpPkCwfAQpKgME9N52WburClM38JO42J1k>
X-ME-Proxy-Cause: dmFkZTEOgZZxH5b7brj7NLntQES6yrZD7j1rXG0dtZu3Yj4sVYvI20W6uIjrLB25lDOE2F
    mbwP66K9CNYNrsfL3n+cmjKNwlqbr5jbLCIDqEmcqLzzN0BAiz95ztFTRciAK/U+0BdNDW
    XmI9LKUPEwFeDCz2CcoK4VIViWxM6NQeWfydelVPJD/lQZ/ch19DbFPUmz6u8dIZNgLZJO
    kWuAhakDuiD2drDi4pNnKbMb+gGtlxejU5l9NF+3IYg0Jx8jCUQ+oeEXMSoBkMdybKrBby
    rWb2i0LaodAcv3Re2VTf/nb91WFKDoTs7//HqgJ8DAduDYqiwS/goRjxb+c/IPXi6kBsYr
    akNpFqWDg+wbGPxaKn9zhmMORjCsy+JQZ5LPA+eNj6ttUF3yxIQi8Qv81gWLg92wspKPER
    WLsngtgIbtKSPnc32JDUlZo2OtqkUYrSg8r7ba6rCULpATQrBcjH1B81mLDOjKbEc1829e
    1U410vbACJqsfvv+bGGZ2cJ9eA+orR77STti/xDfVEyQWJKmZhlUL6DaE9/WBZohkBbWVO
    DNhQ0OzrxqBKewvLhVYYJKXLZcDCy08V/aqmhQE2UXtU40zesOJ/M/hPhrPuJu8j4wAd/H
    zWhtHen80te/qdbaUexmUnTUQ6y8A5ii2U5PZajNmdnbY0DlWFMs+0n6WBiw
X-ME-Proxy: <xmx:6KU7akQzvVfJsowt77tsodpc3t2Ay7bEDqd8dsBrgmdAJ7BdhuOVbA>
    <xmx:6KU7anL_OBrAXBnmbm9Q-4z9A5LUh-mgbt_lNwvawwNbtFGYfdMkjQ>
    <xmx:6KU7aiAWCtRrZPatuY4r3vj4QKBlzx635iAZRKwtvRC5g-CQaHDUOQ>
    <xmx:6KU7aoC-viDVRn3COivJY_kjMcZ9IQyDdk_LBPNs9gbd8NcxpczLbg>
    <xmx:6KU7agVAEJBLvNOGcVHTKvC3QfSFN6FRmAgv266MUet8eg6gUE2smlGO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 05:39:52 -0400 (EDT)
Date: Wed, 24 Jun 2026 11:38:42 +0200
From: Greg KH <greg@kroah.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: stable@vger.kernel.org
Subject: Re: "ext4: get rid of ppath in get_ext_path()" 6.6.y backport request
Message-ID: <2026062418-upswing-scabby-0f83@gregkh>
References: <DJH66E0ZKMBD.RJREJPRY6MMD@smile.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJH66E0ZKMBD.RJREJPRY6MMD@smile.fr>

On Wed, Jun 24, 2026 at 11:25:06AM +0200, Yoann Congal wrote:
> Hello,
> 
> I'd like to request the backport of
> 6b854d552711 ("ext4: get rid of ppath in get_ext_path()")
> on the 6.6.y branch.
> 
> Rational:
> 6.6.130 commit fb138df7d886 ("ext4: get rid of ppath in ext4_ext_insert_extent()")
> created a regression in ext4_ext_map_blocks() by changing the path value
> under error (NULL -> ERR_PTR). But path is only checked for NULL value
> in ext4_free_ext_path (not ERR_PTR).
> 
> The check is added in 6b854d552711 ("ext4: get rid of ppath in get_ext_path()"),
> hence this backport request.
> 
> More details:
> This regression was triggered during LTP test on a 6.6.129->6.6.142
> upgrade for a Yocto Project stable branch:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/98/builds/3837
> -> https://valkyrie.yocto.io/pub/non-release/20260622-121/testresults/qemuarm64-ltp/core-image-sato/qemu_boot_log.20260623002740
> 
> [ 6952.500858] Unable to handle kernel paging request at virtual address ffffffffffffffec
> [ 6952.503768] Mem abort info:
> [ 6952.504431]   ESR = 0x0000000096000005
> [ 6952.505333]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 6952.506541]   SET = 0, FnV = 0
> [ 6952.507354]   EA = 0, S1PTW = 0
> [ 6952.508154]   FSC = 0x05: level 1 translation fault
> [ 6952.509208] Data abort info:
> [ 6952.509849]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [ 6952.511175]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 6952.512372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 6952.513667] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000041250000
> [ 6952.514909] [ffffffffffffffec] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [ 6952.516423] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [ 6952.517503] Modules linked in: x_tables tun loop [last unloaded: ip6_tables]
> [ 6952.518691] CPU: 1 PID: 1078 Comm: kworker/u12:1 Tainted: G        W          6.6.142-yocto-standard #1
> [ 6952.520269] Hardware name: linux,dummy-virt (DT)
> [ 6952.521094] Workqueue: writeback wb_workfn (flush-7:0)
> [ 6952.521985] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 6952.523184] pc : ext4_ext_map_blocks+0x260/0x1860
> [ 6952.524011] lr : ext4_ext_map_blocks+0xdb8/0x1860
> [ 6952.524851] sp : ffffffc086a3b620
> [ 6952.525421] x29: ffffffc086a3b740 x28: ffffffffffffffe4 x27: 000000000000808c
> [ 6952.526624] x26: ffffff8017dd9000 x25: 000000000000808c x24: 0000000000000002
> [ 6952.527849] x23: ffffff8035e766c8 x22: ffffff802e589690 x21: 000000000000042f
> [ 6952.529087] x20: ffffffc086a3b948 x19: ffffff8035e767f0 x18: 0000000000000000
> [ 6952.530310] x17: ffffffc081691310 x16: fffffffe001ab548 x15: 0000005564d4cb48
> [ 6952.531519] x14: 00000000ffffffff x13: 0000000000000000 x12: ffffffffffffffc0
> [ 6952.532683] x11: 0000000000000040 x10: ffffff8005d81d80 x9 : ffffffc0803cce14
> [ 6952.533886] x8 : 00000000bab647bc x7 : 0000000000000000 x6 : 000000000000d847
> [ 6952.535065] x5 : 0000000000000000 x4 : 0000000000316019 x3 : 0000000000000000
> [ 6952.536264] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff803deec880
> [ 6952.537425] Call trace:
> [ 6952.537860]  ext4_ext_map_blocks+0x260/0x1860
> [ 6952.538589]  ext4_map_blocks+0x19c/0x598
> [ 6952.539258]  ext4_do_writepages+0x5a4/0xbe0
> [ 6952.539977]  ext4_writepages+0x84/0x110
> [ 6952.540624]  do_writepages+0x94/0x1e0
> [ 6952.541240]  __writeback_single_inode+0x60/0x4d8
> [ 6952.542086]  writeback_sb_inodes+0x208/0x4b0
> [ 6952.542812]  __writeback_inodes_wb+0x58/0x118
> [ 6952.543578]  wb_writeback+0x274/0x440
> [ 6952.544198]  wb_workfn+0x3b0/0x5c8
> [ 6952.544788]  process_one_work+0x16c/0x3e0
> [ 6952.545434]  worker_thread+0x1b4/0x378
> [ 6952.546059]  kthread+0x118/0x128
> [ 6952.546599]  ret_from_fork+0x10/0x20
> [ 6952.547197] Code: 2a0103f9 b9009fe1 b9000e99 b40055fc (79401398)
> [ 6952.548170] ---[ end trace 0000000000000000 ]---
> [ 6952.551090] ------------[ cut here ]------------
> 
> Reading the resulting code in 6.6.142:
> fs/ext4/extents.c:
> int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
> 			struct ext4_map_blocks *map, int flags)
> {
> 	struct ext4_ext_path *path = NULL;
> 	// ...
> 
> got_allocated_blocks:
> 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> 	if (IS_ERR(path)) {
> 		err = PTR_ERR(path);
> 		/*
> 		 * Gracefully handle out of space conditions. If the filesystem
> 		 * is inconsistent, we'll just leak allocated blocks to avoid
> 		 * causing even more damage.
> 		 */
> 		// ...
> 		goto out;
> 	}
> 
> 	// ...
> out:
> 	ext4_free_ext_path(path);
> 
> 	trace_ext4_ext_map_blocks_exit(inode, flags, map,
> 				       err ? err : allocated);
> 	return err ? err : allocated;
> }
> 
> => Under out of space condition (what LTP does a *LOT*): path is given unmodified to
> ext4_free_ext_path() that only does a NULL check (no IS_ERR) before
> dereferencing it. And that produces the oops and then, the LTP failure.
> 
> Notably, master commit 6b854d552711 ("ext4: get rid of ppath in get_ext_path()")
> never got backported to 6.6.y. But does add the IS_ERR_OR_NULL() check
> to ext4_free_ext_path:
>  void ext4_free_ext_path(struct ext4_ext_path *path)
>  {
> +       if (IS_ERR_OR_NULL(path))
> +               return;
> 
> Thanks!

Please always cc: the maintainers and developers involved in a patch
when asking for it to be backported, as we need their approval as well
before we can do it.

thanks,

greg k-h
