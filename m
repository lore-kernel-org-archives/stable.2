Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB430F7E8;
	Wed, 10 Jun 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103573; cv=none; b=jdmkSI0IHKu4xQgIZAi875e0PRFQeevinS8KEPNM7A0CmY3rpsuGVDakAlgpXzsot24m6KCcv7Vgnwll2FSXiVaZ1hrLYjSRpJgCTVDbG0J6PO7kr1Dxnsbyhh4k6uBZuVCHi4chLavdcYghJvmiW8CQPWC3/fftk1rmSXnuYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103573; c=relaxed/simple;
	bh=0zFr4ZNgTSNJeZV1Vj0+SB5/anJ2JVjAHU16/FVM0CM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9w/xoBuz9ILotHIJKN3eZbNR8hyLPkEiVvRjdyLveRDgbFk+Z4yqD/wVCOwW9VadEAohK3+fC/H9nGg02MmPNOH2KUf4WUepW5b45nrZJIRxSKYQFTK6+cUpctxH3EuMe9z8m4BNs37fkPmZ/lCHFgV4x5gLcLbDNChr3hmI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvmozrl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvmozrl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9141F00893;
	Wed, 10 Jun 2026 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103571;
	bh=L2TxISszzWmB50xJe2/riCd5MF2p9LTabs/uDsxu680=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dvmozrl40W36pZF6hvrZNHCfI97sWBhwHUhg4aw57ziScXMZR6Mf1sCEPwJNT5luq
	 gQy0oe+zzRmWtHtgxNnL8O8zYyyqHcYjYxElTrdoqF0HBbIskh844CNElrDESg2Yy0
	 d7U0B+EzJLcD05uydB8IgpXh+ZiiFrY+l/FXikJ8aeTdjg3YXpxBw83SsIPfIdVt1Y
	 bvUy7e+s8xESUjmz2mGBqgW5YRlxo/ExOmrL8IUnALwzeK0BmdlGYp2kbDeCsSo6hE
	 W2RdonozWp/9mpa7xxaM5BLq2C9V/W28hBCgeeiBnJMstxI0DCu4Xw3NEqrwJWw5Iq
	 UkorpLD6RjRrg==
Date: Wed, 10 Jun 2026 07:59:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, Kito Xu
 <veritas501@foxmail.com>, linux-kernel@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: fix TOCTOU race in atalk_sendmsg
Message-ID: <20260610075930.0df376f4@kernel.org>
In-Reply-To: <20260610052315.64504-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260610052315.64504-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 13:23:14 +0800 Yizhou Zhao wrote:
> +	if (dev)
> +		dev_put(dev);
> +	if (dev_lo)
> +		dev_put(dev_lo);

You should use netdev_put / netdev_hold
Also no need to null check.
Please remember to wait at least 24h before you repost this patch
