Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8A249EB
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322946; cv=none; b=PGmZpqF063KJGiCGroc3CIT4bYfXb0eM8RmqJYNqwABWiGgPecemxQ0FahtKLjPxmJWHuelUhP4OTQZFxtS0ZovpNC2C0mGknHSWl8QoFjC3j5KhEJ4pQ+b32Wu68vA/yAdWZg8Nb9YVtSArmo6NVY3ofbvxv9mOENtk9C8HfQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322946; c=relaxed/simple;
	bh=Hc3W23XMhYAH031LbqZW55Gyam8qSUinkvhRr0nyNa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im9A/ZIbopN+P/ZWx8WVT8JwJYf2mAvs/1OZ4d85zFWhImh65jCK9rvTwXG+Drvevwd7F+Igne5feH/S+Sye29ZxmVGigZS6FL06q7eXB9YNYtqhsiS27gD0zh9HnkQ2gh1mUaYTP4pyRBijHnBNninRMgCiPbvwo4FxE9m6CQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO1LUle4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO1LUle4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5FB1F000E9;
	Fri, 21 Aug 2026 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787322945;
	bh=Hc3W23XMhYAH031LbqZW55Gyam8qSUinkvhRr0nyNa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mO1LUle4AbhIyhVP1dOaWVoCLfghie1JpRjv4L0HqwhC5qKdP6vPueiJxL1IMYWzA
	 P39cDJx+Ws1XpH9rDDHbKIVooh9ZepMboaNt4Zrv23L6qgAzqMyjO0MbwRPDhpzSjD
	 2O4cHFNfawP6PNOl+TZpAAfNNE9YiRunAP1ErmQQzsgbPa0GXpejH5swYChi7qtCQF
	 sJy81kRG63Frt+dtgUkKCJE2mlkFI3NpP9fsYK1qGxS099U6WBMoBrBquKCNXIZ2FC
	 QAo9Zk8AmetU3TfbCa8uFu+toqyW71Y77Je2jZTxMqSD4eJ4o5R2w8ZwdTyBC/6ReK
	 x62fZefA8TQ+A==
Date: Fri, 21 Aug 2026 08:35:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aohiPzxHPKtUT_E8@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
 <aohQ9NcuMtSqWvvd@ryzen>
 <aoheN_L3iJNU3Ji6@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoheN_L3iJNU3Ji6@kbusch-mbp>

On Fri, Aug 21, 2026 at 08:18:31AM -0600, Keith Busch wrote:
> I think you're relying on nvme_fc_init_ctrl's nvme_put_ctrl() error case
> to be the final reference, but it might not be if the character device
> was created and someone opened it. If so then:

And a successful open requires the ctrl state is live, which it is not,
so it is always the last reference as needed. Okay, please let's forget
I've said in this thread!
