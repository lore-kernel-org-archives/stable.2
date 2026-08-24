Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07335AC11;
	Mon, 24 Aug 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584603; cv=none; b=W8w+3mrwoprZhM9p9FboZDECRdp1zXxS6Yol0ojFbnpVVlxFwc1MoSSCcZPc3pADlnQJHer6TQGcILydyoU5xHRv0GIz4P5lxXAV9vemswmGGCZmKzWZKBkOnIhIb377pf/xgGcvbL9k3jVwp99uhtRz5x0oGxgGc9KI9GZx2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584603; c=relaxed/simple;
	bh=yERbh1D5+TBS3EF2mArulBMjtPYfB4hlHuES0xwoAQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJvIR4+fOq5Yknn6sLQvrPlxh7OXhObupF+pYTti05r4Utq91bIe0C5t67MC3TqdHdY+U5cXAljw5zdOIaC9y2qYo9318YE2CNJNPG6lAx47jTXruxrQyvx8WDvV//znjy93JNn1bqja10roRxtNbAPbc9QHD+RKYk/l9sQjGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r2bzLXKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2bzLXKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B191F000E9;
	Mon, 24 Aug 2026 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787584601;
	bh=q0+lX+x3jHWxzyQifnQxqFsMR9R+DvvDGbmtvXnWtD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=r2bzLXKihJlYf6Vvj4N6w2rFrhJ0Q0adkWtqJLfxIT/0DEK9t2YCMBhIHk6pjBvq4
	 co9hK7hbAbLro/c87CcccWryx3TkOQhlToFbVAXUhr1mDMwMUMhKHqx8gRGOLPgVaC
	 MszDFLCD1cwjQ9W1Mv2PlK22sCMu+Em+S1DeOQJ0=
Date: Mon, 24 Aug 2026 17:16:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH linux-6.1.y linux-6.6.y linux-6.12.y 0/1] ndisc: backport
 ndisc_send_redirect() cleanup
Message-ID: <2026082425-struck-compacter-2bdf@gregkh>
References: <20260824133852.328978-1-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133852.328978-1-lixiasong1@huawei.com>

On Mon, Aug 24, 2026 at 09:38:51PM +0800, Li Xiasong wrote:
> Please consider backporting upstream 0784d83df3bf to 6.1.y,
> 6.6.y and 6.12.y. It looks like the missing prerequisite for
> dbc3791e3b24 ("net: do not send ICMP/NDISC Redirects when peer
> allocation fails") already queued on these trees.
> 
> dbc3791e3b24 adds "if (!peer) goto release;" inside
> rcu_read_lock()/rcu_read_unlock() in ndisc_send_redirect(),
> which seems to leak the read lock on the NULL-peer path on
> these trees. This cleanup drops the pair (callers already hold
> rcu_read_lock()), so the leak would go away.
> 
> The patch below is against 6.12.y; the identical change applies
> to 6.1.y and 6.6.y.

Thanks for noticing this and the backport.
