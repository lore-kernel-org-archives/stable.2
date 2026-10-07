Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42D34B40F
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398219; cv=none; b=IjVLQX/WGDbbgFossojVbRygV22Yyt+i62w3ek/AA4mBQB3/EXzd2UFctqak/rA35btDL42tB8muejbuMidTC/XCp6FybvCNw+pHPkwKjhmeJhwJCjPd4Zu6He4yFX/oC77QrI3zIOLUayZMqraWGpmNxN9XHo9ZxyYUyUfPBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398219; c=relaxed/simple;
	bh=JrLa3HexNJbbVKnunxiIgrli+e3/+0NTV8uujfvINgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOJ7IQUirPJ4GJLYfq65OTmXaMxxyv1diTc4KjLNLxz7ZJi5nHXUR8w0ij0Wg2KZ+J9ZyFW10/4dBFP5I6VrzveSJEKtV7vHFA6sb8JzC9/oDbfCKLNLA07Q/fgX2WU/ethpREMxZZNQ87PM8zP7P36hQp/k20E+8EnJ0y/B6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pnn6qQPT; arc=none smtp.client-ip=91.218.175.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pnn6qQPT"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JrLa3HexNJbbVKnunxiIgrli+e3/+0NTV8uujfvINgw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791398214; v=1; x=1792003014;
 b=Pnn6qQPTkNDb7fB+zmasZrmvQUubbfQPMaAlerfGTGBdPr8DVUyefDCE3CXFyToeq73IxU9w
 oWjpbKckw9eQcSO9WSngZVTK0fUirSWtYjukNPP4li5stKq/yKjdlQSABbGZK++wuJYl3Xy+SEi
 HxfDhHFQi1r4/RSXcK+G5/2Y=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c47590e99ebdb691;
	Wed, 07 Oct 2026 18:36:44 +0000
X-Mizu-Trace-ID: c47590e99ebdb691
X-Migadu-Flow: FLOW_OUT
Message-ID: <92db8ba8-a77e-449b-b238-efcee90dad4e@linux.dev>
Date: Wed, 7 Oct 2026 11:36:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] RDMA/rxe: copy completer WQE to kernel buffer
 before processing
To: Tristan Madani <tristmd@gmail.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, stable@vger.kernel.org
References: <20260830191344.2026524-1-tristmd@gmail.com>
 <20261007163356.407937-1-tristmd@gmail.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20261007163356.407937-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/10/7 9:33, Tristan Madani 写道:
> Hi Zhu Yanjun,
> 
> Gentle ping on this v2 series. The v2 addresses your review feedback
> from v1 — bulk memcpy() writebacks were replaced with targeted
> WRITE_ONCE() for individual fields and smp_store_release() for state
> transitions.

Please follow my advice to modify v2. I have sent my comments.
Follow Leon's advice, please send the latest patchset as a standalone 
patchset.

Yanjun Zhu

> 
> Would you have a chance to take another look?
> 
> Thanks,
> Tristan

