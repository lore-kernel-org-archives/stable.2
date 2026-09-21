Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104654B4870;
	Mon, 21 Sep 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003489; cv=none; b=kiW34goYh7/Tqr/EpnrSEvjQrAT3qK+0SPK63CWUt+Pv9gkSNm7pK1ffs6j+yTXBxEPjDKzquTiPuSJYe68/seIsnn0mjnr+/zt48PKJqZMri1ReOjPOcmNy+lqbSi0ffnmRgGWXQ2Vm75Onlc2dgMk+MS8SiNdOBOcEiHwe/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003489; c=relaxed/simple;
	bh=F723jUb4FX3wnPM8/1OM5X8MykUBmpaUpNENj61e5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWgxEfBa5hAa/B+OLviOHOIUxc0JpNDkzIPCJVl6PQCSKio0BGFvHoPLVk1KyIktOrJE+iCehuZm/kn1gXV6iTyDWvv0L2lZVc7XZbt8sxzcVCHdltUQTWvLJqWsfAl/+hN1IRcBvYRvMNgPCD4h5OyYIbdMqMcWau4E7GvKrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkt648Lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkt648Lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A601F00893;
	Mon, 21 Sep 2026 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003484;
	bh=/EGmor+rdd8V7CS1kyIpOAdpprLtqx5XjF9/vJmxcJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nkt648Lc3RXSNvhcwChJrvmz86eV+ITMS4OhUJypkqOk4LQkV60uAHKYPTHGop08u
	 MIJ4QounFQNV+ZZEmBeZAIhiTkSDb6Oe9u19KhcFNMqkflJJoGVksTklZXYrodkyiW
	 1WRvmDtrAFch5e1tv5a7+prJKyHjlnWbiD2rlzCLtx6//qA+RSSU62IaAOW5mq+Uy/
	 paXL0iR+aZRLZYFsu8w7Pth1h+VGfjTTXZRKxkh+phcHXv+zt7cWQ3DRMg6XVVzOAB
	 j0y2McmqsAeMlqV3ehkG+P89xUklD2RXaivQYaKEWg8CWvOPCeFPu+Kd1DEqX2e+cL
	 gomGJw1O7xaFw==
Date: Mon, 21 Sep 2026 17:11:21 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: oe-linux-nfc@lists.linux.dev, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, david+nfc@ixit.cz, 
	sameo@linux.intel.com
Subject: Re: [PATCH] nfc: llcp: Fix socket reference leak in
 nfc_llcp_recv_ui()
Message-ID: <arFJGDb6WiuBi0nE@quoll>
References: <20260916073424.1971784-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916073424.1971784-1-vulab@iscas.ac.cn>


On Wed, 16 Sep 2026 07:34:24 +0000, Wentao Liang wrote:
> In nfc_llcp_recv_ui(), nfc_llcp_sock_get() is called to find the bound
> socket. If the socket type is not SOCK_DGRAM, the function returns
> directly without releasing the socket reference via nfc_llcp_sock_put(),
> resulting in a reference count leak.
> 
> Add nfc_llcp_sock_put() when the socket type is not SOCK_DGRAM.
> 
> Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/nfc/llcp_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



