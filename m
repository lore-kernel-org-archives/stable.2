Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0889390239;
	Sun, 13 Sep 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288200; cv=none; b=pv1Snxk9ZefPK7pVlBjxIMkcGRl73q5Ods2E4ohmsk496qoTDMlYCFAC9B3J+5X92s8azHItqJLr9ybILzsNfK0CKpjg3O8g8QYLV5xtQaPkeDRjmdApj6WbD5FQyjrOEEu60xXsyUNBxa3ym+OSSK1Mlj7c8ukC5EfvN2lWChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288200; c=relaxed/simple;
	bh=DsE+snbRwxWp5DUNkW3lLcQE5xBkY0HKHPPkCh24Xwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYiEX5m6EaCOUcb1bq8E7mFbuK3K0gwAj/BrB04BmGgCpBycckneOrY5bilgADxdFiGF8L+as6mWYA3jg+RDLlD/BDn5VDEapUK3YLNoZpiGtE2/h/oxvlmSAzg9FNCkMLGABMK+zQ+czhHOMeoV2fdBpLMAF0RzGfzpo7y13DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=2IoV3+zG; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="2IoV3+zG"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7D28614C2D6;
	Sun, 13 Sep 2026 10:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789288197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjZscpFYFEDU0J361ubN6K2hgmZzPWFU/4Xw8fjDe/E=;
	b=2IoV3+zG6/tVPVFa2kQPQcc8l0pG21JQPHl5jqrFiE9kEjJGbutJjGb9jqGwbpHD8B5Eh9
	NSCPQW0wSLO1g5uVqcfSYv+zKugI1esLuSj31KKeB+IoYX8BdphVuN5ihsmwz0SMWnt4bm
	hnMxB4K58ngZShgg41ZIOwgfK105rgRf2+WV+A3M22I2ucRWbN55gs7JC4M6KaYuSuGaFd
	NjCPGJ3M7dhflWt2DlJrhOpoKK5mgv9MnOiiE3GbGyFkH1FRlB12srMrhqTkJxqnvA/47P
	51He3a/xpIwxRcshOGGuKvWMysrOXXy4vBIQ0ZyYO0e2wySWu+UrmW7nN+QpuQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 534f1be8;
	Sun, 13 Sep 2026 08:29:52 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:29:37 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <mgr@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/9p/usbg: fix descriptor cleanup use-after-free
Message-ID: <aqZe8Y564O2ubaiu@codewreck.org>
References: <20260731150414.3135662-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731150414.3135662-1-nicoyip.dev@gmail.com>

Chengfeng Ye wrote on Fri, Jul 31, 2026 at 11:04:14PM +0800:
> usb9pfs_free_func() frees the f_usb9pfs object before calling
> usb_free_all_descriptors().  The usb_function passed to the latter is
> embedded in the freed object, so removing the function from a gadget
> dereferences freed memory.
> 
> The failing teardown sequence is:
> 
>   configfs unlink
>     usb9pfs_free_func()
>       kfree(usb9pfs)
>       usb_free_all_descriptors(f)
>         dereference the embedded usb_function
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in usb_free_all_descriptors+0x138/0x190
>   Read of size 8 at addr ffff888106a73088 by task poc/95
>   Call Trace:
>    usb_free_all_descriptors+0x138/0x190
>    config_usb_cfg_unlink+0x1f0/0x2f0
>    configfs_unlink+0x321/0x6f0
> 
> Free the descriptors before freeing their containing object.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Thanks for the patch, given there was another identical patch earlier
but Michael preferred your commit message I've kept the original patch
with your commit message, keeping you as Co-developed-by

It should get in 7.4 if I'm not hit by a bus

other mail
https://lore.kernel.org/r/20260529081817.77898-1-zhaoyz24@mails.tsinghua.edu.cn

commit as of now
https://github.com/martinetd/linux/commit/0955472fff1e9f9e410a0300136924ebc8bd7a16
(look in https://github.com/martinetd/linux/commits/9p-test if commit is
gone on rebase)

-- 
Dominique Martinet | Asmadeus
