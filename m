Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2A4499BA;
	Sun,  4 Oct 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117453; cv=none; b=hOOXXBplBSEqkZlnq5WPUzCf8/scwSHo6Cu5B529ucIIb+fg3i78GCWjxrR64pMRavf0cL0NUXKQEEyirr9WW8rLdsu5jeLzovhE7hJN/Z8hG8+ufkGYG6Hk69wiou7y3ETAzlqbDmTD63fB8BCTKHy3JR0k/oe1r3OhoqAp/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117453; c=relaxed/simple;
	bh=1uvB3wMoF3XE9HpvKP1nFWQmlzsVPHKqLCnReKp/hs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8LmVzkUf/JpL3gaEocaw4JscdgXCGaKhqgveNoWf86rNrSENPflI9yQdIm4mgdEz8soeqpsL49YiBR5pO+q3RoBs71QYvReBaKSG1GdZGLqYNsrUBPkq8eGDMZJyiOtmeufcbWgnzoKX7xUAfxhAxSOVxC+P+u67+C+9IT9rqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Md0YV6be; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Md0YV6be"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fec268ee;
	Sun, 4 Oct 2026 20:37:25 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] media: rc: Fix simulated TX timer lifecycle
Date: Sun,  4 Oct 2026 20:37:19 +0800
Message-Id: <20261004123719.1250610-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <asI2qe_wzS-VYFYX@extorris.mess.org>
References: <20260929143105.2170272-1-runyu.xiao@seu.edu.cn> <arvlSbG0Z0FGxq3l@extorris.mess.org> <20261004094507.1191384-1-runyu.xiao@seu.edu.cn> <asI2qe_wzS-VYFYX@extorris.mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa106eb47f503a1kunmeffb81fe33ce05
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQh5DVh8eTkMeTk1IGRpOQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Md0YV6be3wGdkDYA8ODd0bGg55vLiQloS9YJg4A8/DzsOrrYXm2Km3iQdj4kh0r2VdDFESrJSKhA/03uyzUMnu4SwhxQxFB1u8uWoF/YKabKHvnhCm88gEmRH43uj6qUQWl6i3s0+aKDzBM1jLg1ybBvJ6C4JMWFSFX9S//dvRs=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=1uvB3wMoF3XE9HpvKP1nFWQmlzsVPHKqLCnReKp/hs4=;
	h=date:mime-version:subject:message-id:from;

On Sun, 4 Oct 2026 12:21:13 +0100, Sean Young wrote:
> If the hardware has no TX capability then what is the point of those code
> paths other than exercises the code paths. Might as well go (unless I missed
> something)

You're right that `txsim` has no clear supported use case. It enables the TX
path on hardware that reports no TX capability and uses a timer to fake TX
completion, while the samples are still written to the hardware TX output
registers. I have not found evidence that this provides reliable transmission
on such hardware.

I'll remove the `txsim` parameter and its timer-based simulation path while
keeping native TX support for hardware that reports the capability. This also
removes the timer lifecycle issue, so I will revise the patch to remove the
unsupported simulation path instead of keeping a standalone timer fix.

Thanks,
Runyu
