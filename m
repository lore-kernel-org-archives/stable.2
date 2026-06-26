Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1033E3DB3;
	Fri, 26 Jun 2026 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464349; cv=none; b=T16E5vihFLfcuwH8vB/Yh+EdFJBmbr1Q1a2X3FPTMaIMJBBwo9vSVDxdCzQzqnF3l3tr4AfSY3IfaVemZKHYv8tcwNKiRXt4elBwkld1CPMrG0AkIOgMso+NreGYeo/x5EuUc7M5AaXNLzjLyfrDiBeIQFZnBYAXF10//4PxSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464349; c=relaxed/simple;
	bh=1UF0WDNGhDqYTjziiC+O+RdTBtqnG+eCF4aTFyvq1dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/d6u4/c3Wt6ezZOIxjreWK/zQBtJj7UQip5Ew+SWnmGClDHx8Tc3J2G+Q4BNW+ukqi9tWk5T9qwQf8r+rsS2CTfM2yS6+F+p69qEptpReauEDlmbVGajanWWEdXQn1NwZICOR7FrwWYry+fawMA9NnVzyNfvXngLG2yx2sQa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S1ZFr7O0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S1ZFr7O0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g6
	D9+ohCvg3vZ+/EOx6cBBl2sEkP0E6MD+F/xOBlluc=; b=S1ZFr7O0jqjDdPbXqW
	2/tuGvwWkvu1gAamVjK+MxN+mTq8PkTcLomqgPuXLoFo+FUv1zePBbMDLTN7T6aX
	/qhPA6K3eLesy0KyP7ITnGk9J8/oLmEC5EihynB/h/Kp5cqc8oUCVjyZxrdjBQdf
	Zx0gQfg1Z1pScDnhKmNGcxLb0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAX4WdMPz5qXqbaFg--.37560S2;
	Fri, 26 Jun 2026 16:58:53 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: vulab@iscas.ac.cn
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] block: Fix dio->ref leak on integrity error in __blkdev_direct_IO()
Date: Fri, 26 Jun 2026 16:58:45 +0800
Message-Id: <20260626085845.3461889-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625092106.47695-1-vulab@iscas.ac.cn>
References: <20260625092106.47695-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX4WdMPz5qXqbaFg--.37560S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUenmRDUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwg0NnWo+P02AAwAA36

---

Hi Wentao,

On Thu, Jun 25, 2026 at 05:21:06PM +0800, Wentao Liang wrote:
> Fix by matching the existing error handling pattern used for
> blkdev_iov_iter_get_pages() failure: end the current bio with an error
> status and break out of the submission loop.

Looks good to me.

> +			if (unlikely(ret)) {
> +				bio->bi_status = errno_to_blk_status(ret);
> +				bio_endio(bio);
> +				break;
> +			}

Small nit: consider bio_endio_status(bio, errno_to_blk_status(ret))
instead, now that the helper exists.

Reviewed-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

Thanks,
Yang Xiuwei

