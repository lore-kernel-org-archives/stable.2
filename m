Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651785;
	b=mW8xjSbksD+LJafORroVih0Vq+6nq33FOrBazIFO3VkSoeMAayBwKv/TsnadiojhFSSi
	 nTCvm5BEFbDEEE27C2WavNkOEALLYve/0e75Vlv4sT6F4IEGLaCTGGvBCakr7Y8QxudYt
	 UaWR/aZ4+qXzxRw0S20fKZ2t6tcq/a63kXvNhcj8DfD9BeXec5goMjpityP/7Bw0Dy41c
	 4rwmYJp335JeRl7LdHAuMpL+MWlX5ptUQ7QknqXdUi/erxeNeZeE9Le3BZtGePMHvYSaN
	 nYFuCFDoB0nt3b0WxE/4FnbdSR0aAhmFu8VfNzk5VijEdUm3XJrLLQC4f8FMJkfUJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651785;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=b78t6Os4sAH3qjsyxE6k8yXo3EadbTdi4onIYpZO5Ck=;
	b=b2atIuUqA838lppnVq5DLxsTMxzmhe/58kGEbZg/SYQU/eaYKyTR65DNFtWWYNWjNEky
	 rHr87pZmeNSegZ1mMwK4kgZuXBGkHle1/9J5EYBdKi0ySXquk5XuLsCkQmF3wYwlDMLTn
	 BMitUApZ4WEDQ6mlzdqIGZoxsqUrqC15AJ2nPT+TDq/M8NdY1v5DbcQJPxCEFQSOZTYfo
	 Xw2QWJ4GQzqIKXDxMa8ufFSev1Kapkkq442keO4hM5O4Weal0N/2uAVmgsHPVDIuVvjDP
	 6AHSGZ2PES8PzJ6eXc9uZDg9foW/GiBI96J7fSMnneCCzFfVDAJd4IG7kRWQDmPkihA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJ9bXgMd;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E09606A31E;
	Thu, 26 Nov 2026 00:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4E09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJ9bXgMd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795651785; x=1827187785;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LvP5mZre8VsoM5eNNyoILwGnMME08JBoLfspF73wXmo=;
  b=cJ9bXgMdzJAd0VWBxwA1goyiqWwE5oGzZilr1mPUTKLa3yXAr3feXbgN
   I89Tdsf4oEcPRp2N2Rqv4vrGuPUmVKJ5b0eggJQ79/uJ6meCoeFP1z4eO
   LuqQNgTf0jUkGs5hqSupfPyQncwYRAuNNUaLvQeqv+jPfsmL2zM4z5xYe
   JuyJohEObKQIg9Jrzi1k+LH+2yFrdNmk+fB6nsYt1Hhi94xE5iZVzdsml
   hBrc52a1Iar9PZAzS4xB1LvMEvRpwKpzrjtdTnhHSz+pmlE0dlcHMBhq2
   gJ/4jmJxrKCxuLHh+ULVyBdAVk3KyGvYcDRKT9hN061I1mr7Ba9GVYcc5
   g==;
X-CSE-ConnectionGUID: +zilg5pNR+2Yo/nXMV8nVg==
X-CSE-MsgGUID: Aa3n6PnMTlWdeS2ZxW7Y/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4536708"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4536708"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 16:09:44 -0800
X-CSE-ConnectionGUID: wQHXDJjLTWmx0Wj+lNeOwA==
X-CSE-MsgGUID: VU4jRMqaR1eXc0q513NL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11899238"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.241.240.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 16:09:44 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yao Kai <yaokai34@huawei.com>, Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 liuyongqiang13@huawei.com, Yao Kai <yaokai34@huawei.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Avoid destroying the device workqueue
 twice
In-Reply-To: <20261111021026.3354620-1-yaokai34@huawei.com>
References: <20261111021026.3354620-1-yaokai34@huawei.com>
Date: Wed, 25 Nov 2026 16:09:44 -0800
Message-ID: <87v75ksbav.fsf@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Yao Kai <yaokai34@huawei.com> writes:

> If idxd_probe() fails after idxd_setup_internals() succeeds,
> idxd_cleanup_internals() destroys idxd->wq. The PCI probe error path
> then calls idxd_free(), whose put_device() invokes
> idxd_conf_device_release() and destroys the same workqueue again.
> The err_evl path in idxd_setup_internals() has the same problem.
> This can corrupt the workqueue list or access freed memory.
>
> Clear idxd->wq after both error-path destroy_workqueue() calls and
> only destroy a non-NULL workqueue in the release callback. The NULL
> check also handles failures before the workqueue is created, while
> preserving its destruction on normal device removal.
>
> Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> ---

I just sent v2 of the idxd-fixes series [1]. Setting ->wq to NULL
doesn't fix the double frees of ->wqs, ->engines, ->groups (and
friends) on the same error paths. My approach was a bit more general:
remove the early frees and the early destroy_workqueue(), and rely on
the kobject .release callback to free everything.

But if folks prefer this approach, I would gladly rebase my series on
top of this one.

https://lore.kernel.org/all/20261125-wt-idxd-fixes-v2-0-25a4691dfb9e@intel.com/


Cheers,
-- 
Vinicius
