Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20913A9014;
	Sat, 13 Jun 2026 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395071; cv=none; b=lPiczVsNm1DBmfWa9sHla5rQrrLuPwkVl8hXpIUP4f6lp4yXTb0gw/Uq6O3CrbkNZQEF5X8nnl6y8Dts4+p7HZpC5hebUrp3UXJlHolQRyBWraJ3TLQOcySXLxinKO3nGymFwRSlNLufYrpesQusBdEzIe5SYRkPwe5+h4zaw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395071; c=relaxed/simple;
	bh=YG2cubYPjLHIC+ys6upSP0Wm9Bo/6TfID6JfaDk0S/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJFprgyVtgH9Jvh3xyAKovwpAr+40cG3CDDfx+2bzOBaeW6HL9o5WGgs9HOYczpMqlPVjVsh2MrqPPgtC2ud6qr4fmrkQu7WFTpUb0wuXafXo1xCJ1N+grZu06N3fI4KKU8hQ7aE5QVU/1oT8IygCjU5jin1aHhUMz8N+hA1JnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfdIllRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfdIllRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85F81F000E9;
	Sat, 13 Jun 2026 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781395070;
	bh=YG2cubYPjLHIC+ys6upSP0Wm9Bo/6TfID6JfaDk0S/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PfdIllRqsO4bdUGRPWYy7XNJJuIc2HR+5d0Ubp53CFofvJEolQsIH4fn5zfTSP+Hp
	 CAzJ9TXHT1VmXm12NmbWzTgtUH6o+3mz7kNXVjyExuF/6AhmjgDX8c91B2Y/0GXbrS
	 G9n0FX8vmuXWx5L3q6OBxW+K/URJj3ORiIsuoVBzPDjT6f6+3aIZqPZkGBTQ+Vai9F
	 ObcIDvVXa1ThlVBsM+J47zXJsh3vGw6CNCtyPS3sYkryM47bfRKMY9URJBU94P+1jf
	 dGIBnQsnORqPFA1G7hHRY001VwD3s6ZqkceMy42kxfz4GmbUgyVH4J5gVLPgypxVi6
	 RgVvQGCQRp5IA==
Date: Sat, 13 Jun 2026 16:57:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yiming Qian <yimingqian591@gmail.com>
Cc: security@kernel.org, John Fastabend <john.fastabend@gmail.com>, Jakub
 Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, keenanat2000@gmail.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skmsg: preserve sg.copy across SG
 transforms
Message-ID: <20260613165749.32fbdae6@kernel.org>
In-Reply-To: <20260610062137.49075-1-yimingqian591@gmail.com>
References: <20260610062137.49075-1-yimingqian591@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 06:21:36 +0000 Yiming Qian wrote:
> The sk_msg sg.copy bitmap is part of the scatterlist entry ownership
> state. A set bit tells sk_msg_compute_data_pointers() not to expose the
> entry through writable BPF ctx->data. This protects entries backed by
> pages that are not private to the sk_msg, such as splice-backed file
> page-cache pages.

Note to other maintainers: please don't commit this yet.
I will send a de-feature for TLS+sockmap to net-next,
if this is in the tree the CI won't ingest it (once CI
goes thru we can merge and fix the conflict).
