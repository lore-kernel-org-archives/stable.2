Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504B3655FC;
	Mon,  8 Jun 2026 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921276; cv=none; b=TIKSVCc482wPkANzIodihqzdGzpswN5AVsxQNimCBLYjlTqxusdLx7JdkmL9VFEi/5lmfxMc6t97lyKVN0O1N2BsDCJ7E0PpFyJN1vFl4o26TEYYT7BIm57EjQNCxcVCRGN5WT7IukJbFfmKsQeZjL6noM0nU6GtoMcoDtLEe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921276; c=relaxed/simple;
	bh=9OEzljqp5E4qVkjSuixpGUjKq1oI+R0jYb8o3RrR/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsMAirSvqxqw8nI2nfbQjKMZtI2PO7ZHEP3oa7E0YZRn2YZkpFuqX9Ukt7uSprpdxw6dZ7fFJ8rb1HpQG1MS7dMzpY67qwQScMIxJxn9dGpGB0ev2sblPk8mPDWzEier+Yvxw8k7zFP7tmGSCAyTUDYianASzw9T8Tyya/SjZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Le/XykrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Le/XykrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871AB1F00893;
	Mon,  8 Jun 2026 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780921275;
	bh=9OEzljqp5E4qVkjSuixpGUjKq1oI+R0jYb8o3RrR/5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Le/XykrZpF4874tb4AcStac7qxEfsC7WKfzz17UGvgXj0UJuymbl4ZqowKKMSwXQg
	 /J3aVncHFjjwyxN3dkCZ/isDRPKu6j6gkMqrPPntYeyKYJyvhe54CUundOc4rcP1m4
	 Wo+qFyPyNusHitpitBrHRzJHpuFlPWsnYZdcvUvY=
Date: Mon, 8 Jun 2026 14:20:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: af_key: initialize alg_key_len for IPComp states
Message-ID: <2026060809-customer-quintuple-4f47@gregkh>
References: <20260607210119.2437752-1-yzjaurora@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607210119.2437752-1-yzjaurora@gmail.com>

On Sun, Jun 07, 2026 at 02:01:17PM -0700, Zijing Yin wrote:
> From: Your Name <yzjaurora@gmail.com>

You might want to fix this :)
