Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804615;
	b=cKH1nDYOCURtGdc9kqLEWk27aYWpsokubYovUPObjiLyDSi/yVMlHmB10ay0gOrLi2pY
	 ZyfwiuMwGOd+Dooa8Mz9G6bJFLD+RRnyr2wFoWBdvHa83uxS6i4qZY/npqBJBZg7Yo5ql
	 AW4JFKGwmjKIm2uo2tpfQ32YdUM3gOmDrVVUA2bYpEj3TK6hGC+VAPfH6obD+NasX9Y0D
	 s1S3mhDB3FpUM0kh01nYXfZK6MqUobgwmfpI7rHQ4JHukwESdq1w+ntKBk2xVYrbLTq7U
	 Sy34AS8sbbRCgd9ihIUZI/zhio15lQipj2SXv6qpP2CQNFPWtj3RYJ62rDqn9teopyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=klwD3EXRgDnfqwdUpP3U5Vta6LNIT3neRNdHzC55DFo=;
	b=r1CyFTn0poyMSJVZhTg/ZQ9UlIpDW74rXx8L/y1zWTXsBET1itdcn+u3t4BGsvqh8zHw
	 ubQuzjk2F28YMqZPfy2yz6ncsfmKQL4zOw3xpkM8XXxzMdtUeFMH0CFJ136bOTNryEBNc
	 2sdC/2u2+tV/9wUs14tYxDb1072uA0Fr/XhpbRXgJCCmG63tFVpc8pI82vSfOV2I4dGoe
	 6wzHzEMSIfjlChvqlMtKmnIuW1ZyohwDNFAVZmd1i1v4cR2y4oJBq1DCEgDkMRZqreHYe
	 JJ/ek+ieKjclya0SPDvPD2PdeBpqye1O5dN2pwrfG4aEXFT4qboV+iUNyVUtdc3FG2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLQFa+PF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DDE606A32F;
	Wed,  4 Nov 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLQFa+PF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E0C1F00A02;
	Wed,  4 Nov 2026 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804615;
	bh=klwD3EXRgDnfqwdUpP3U5Vta6LNIT3neRNdHzC55DFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLQFa+PFz5dnPoG/7z7HtBq8sXHL9Y+k5xDxiRw9wHNHVlK1fNWW/LkrAac+fp+vW
	 /9wXrZWl/0+WXxxXqXm9yX54f41eV3L2NcZMWlxpMSkRyYVOWkAONLOQJMvfhpTpw2
	 qzo7vw8vcoMrNT/1qjbfNZAXUX2JgQT6lu2Z+KWWfwgv99ZQUBqAKol4DJOlVgPvkp
	 fjjEDA5HXabNQKyHxVYjQjxEnamWqTc5aPMAoWpHPGbrUW603RjPfmI7Avt+Cw2/Pj
	 ZYZV/6OFiaV7UvLQtinBfq7/Hky7YN+QqD9cIXgurdZlt1hFtZKA9So8CzuTS0+qVw
	 NTrNv+0kub/ng==
From: Sasha Levin <sashal@kernel.org>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?=E5=BE=90=E6=99=97=E7=BF=94?= <xuhx@hust.edu.cn>
Subject: Re: net: rtnetlink: rtnl_link_unregister() vs in-flight RTM_GETLINK dump readers -- v7.3 lacks the synchronize_rcu() fix (Fixes: 6b57ff21a310 family); A/B reproduction on stock 7.3
Date: Wed,  4 Nov 2026 10:03:16 -0500
Message-ID: <2026-11-04-1-daily-reply-0007-re-rtnetlink-unregister-rcu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <42fe949f.1d67d.1a1a145bcf0.Coremail.xuhx@hust.edu.cn>
References: <42fe949f.1d67d.1a1a145bcf0.Coremail.xuhx@hust.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-11-03, 徐晗翔 <xuhx@hust.edu.cn> wrote:
> Upstream already fixed this with a synchronize_rcu() in rtnl_link_unregister()

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
