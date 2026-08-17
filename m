Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937283DC857
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985780; cv=none; b=gP16mzXRrzo/L0NDrMqDknSs52WLFFkMFZrKrmZvBE+UpUb2Al57IVRfcfHPGYJLwcY7BOoLQbUaYCiMt3WBxML2sjOdqfqbR3R1GvvtkoONwWOHmQwsjIQr1mMIBlaFm5Tf9tKvdUQmo1vU5lVetuYCeMIco9F/eAIk2yQQIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985780; c=relaxed/simple;
	bh=lWWM9eWYrdBnIjngfz8xN12uYcDZNfPkeMROsEkfpO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upobLh7EH/YRC3xGv0oWoi4evYhk0NnQxR/2ZVTrnzXGJTEet7zJlede1ww/ZalPSzWSdFA2jTQNxotIEAGi5QUu6cqbUMmSEe+U4+B2g5pmV+InIK3pR23qfFZaiV7pmoWo6hofSnVfiuDw6DNp0ChyKO5zsPKq+0Gtsta1iec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C4Pzb7mm; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C4Pzb7mm"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lWWM9eWYrdBnIjngfz8xN12uYcDZNfPkeMROsEkfpO8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786985772; v=1; x=1787590572;
 b=C4Pzb7mm00OWVdV8Yz1zcn6whJG6y/wBVPkfsaUdbCoGbB1GAeI9dSWlTRBHaR0s5ObmPEoT
 k7HNZ82SpvUWCgxXYcgA89vKfGiBgjVR5PE3vhmgfks1r2QAAabF8IRF0V4WpH7yNfEG3iIbOqV
 JGKznYK7MxSOcFTKllg7SXqI=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::6:5429)
	by smtp.migadu.com with ESMTPS id 9420b58903291c55;
	Mon, 17 Aug 2026 16:56:12 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d88017c7-7089-4e85-b56e-21175310db93@linux.dev>
Date: Mon, 17 Aug 2026 17:56:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bnx2x: fix NULL pointer dereference in
 bnx2x_free_mem_bp()
To: Jiangshan Yi <yijiangshan@kylinos.cn>, skalluru@marvell.com,
 manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: dmitry@broadcom.com, eilong@broadcom.com, ariele@broadcom.com,
 yuvalmin@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 13667453960@163.com, Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260817151326.765824-1-yijiangshan@kylinos.cn>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260817151326.765824-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 16:13, Jiangshan Yi wrote:
> bnx2x_alloc_mem_bp() sets bp->fp_array_size before allocating bp->fp.
> If the fp allocation fails, the error path calls bnx2x_free_mem_bp(),
> which dereferences bp->fp in a loop bounded by the non-zero
> bp->fp_array_size, causing a NULL pointer dereference.
> 
> Move the bp->fp_array_size assignment to after bp->fp is set so that
> the loop in bnx2x_free_mem_bp() naturally becomes a no-op when bp->fp
> is NULL, since bp is zero-initialized and fp_array_size remains 0.
> 
> Fixes: c3146eb676e7c ("bnx2x: Correct memory preparation and release")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260815122149.951215-1-yijiangshan@kylinos.cn
> Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

No need for this tag, it's not used for code improvements

> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Please, review netdev contribution rules at
https://docs.kernel.org/process/maintainer-netdev.html

Especially patch formatting and 24h cool-down period
