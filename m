Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBF3FFACC;
	Tue, 25 Aug 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658582; cv=none; b=toiMzbddy9jJ8iI2Pkwledu8ZCgZxKmYzDhHJh/GGLpLh/TIpbOPAzAVLrSkiZfwZkoEljs2MGWnpsND/xh+WwoS7hlLX70yhRDTv7PrGw4m0HG+h8OP5P+3Wadi62/U6/ryNY2f/74KY9RS2Z7t2waSF7BXvOmBrzxAQvp+AZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658582; c=relaxed/simple;
	bh=6AeKEmAbglrYMuTQDcgryyRF8OFnCwxkKDCoXKGt4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+tb5Y3njtqt48SCO1+MCsa4O47DgvSdXI9/0LoLLeUehUswYhsJMlez70p0+lI0sAy85TjK+X4LHBGrIZHcuuhEYpLTW5FqrzpNBf4l+0uyKq4oojn7XJId01SqWvtHOeIriVCix63acp+9v7lU5r5ibVjTD1vAglwt/45JD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz7psXWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz7psXWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4581F00A3F;
	Tue, 25 Aug 2026 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658581;
	bh=fW3Uz/X24qHx+oUgJ0jCrQNRCEkUirr3meKSn7X1+3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kz7psXWleF6u08Y5fhW1+PAhI2ABQ/6znyEBZOKQ7NA+ATiNuEbcwjLO1VpBgx0Dk
	 ElChkumr9p2CxdXsVW6C+rtkxoV1Ylc5lz/+MisYhwI9mSpvxJQsNvVTA1nZxmXkFo
	 tJJyVoRspGOcRtxvZqiSGx1YoHxPVFRmA/XQRX444nbW05rRB40hBr9zTyVT4G/g1R
	 fNRalzuTCylLoNeIwvb0SNP6tdE2nZ4a+U9C5QDiKcKwjkOALUzMdS8TwfEvwDTlzk
	 J5OkdOuFzNxcQy13FF07ijcXuZQ6ih7UOYlvw4QBKjWh3hGf9kcmVZrExToEBNdWFL
	 ojKl0m8PLewug==
From: Sasha Levin <sashal@kernel.org>
To: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Wei Wang <weiwan@google.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12.y v2] ipv4: start using dst_dev_rcu()
Date: Tue, 25 Aug 2026 07:49:24 -0400
Message-ID: <202608250002.b8a90eb369f250bc@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082420-reanalyze-dehydrate-c386@gregkh>
References: <2026082420-reanalyze-dehydrate-c386@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24, 2026 at 11:05:52AM +0200, Greg KH wrote:
> Doesn't apply to the queue anymore due to me taking this patch series
> from Sasha:
> 	https://lore.kernel.org/r/20260821144926.3428433-1-sashal@kernel.org
>
> Can you rebase it on that?

Miguel, no need to respin - I've already redone the backport on top of
that series. Queued for 6.12, thanks.

-- 
Thanks,
Sasha
