Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51422D8767;
	Thu, 30 Jul 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370989; cv=none; b=Wtp3bOgzPdSIn1NsxL+W6DKHzRs27RO3mNYb1oxyvEGMWCmx68KdODEjmI9ri6M2obSLEjJUWB8cBZhv/5ponEHOEi5oYy/EsD8mobQwg/eum0bUmO4eg+AcGPhKyHpmtd1ZIrCxgtgUpRyOsb8ejpGfme6WCxJQ1ib9/9Akin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370989; c=relaxed/simple;
	bh=P1YiPg4t92Fgdvv53R2b61R1zeguosUqvGGmuDmEjII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsoCaFzRTnRkpCTbWOSAhYbr/dTnuPY40mVbHf5IrzejCbYFLCJM0hW0pkXcbqGTm7EZe1WtpOyzF15vIlU9YEaOC5usTl7Esa3x1cZGj+hFVP1l+JdGLOmoE2vhLvMiQpflcrICUmHQIu6m0+9ykMp7PgFJ0vMNLdHbd3zPmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNUDxnyW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNUDxnyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B910B1F000E9;
	Thu, 30 Jul 2026 00:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785370987;
	bh=P1YiPg4t92Fgdvv53R2b61R1zeguosUqvGGmuDmEjII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZNUDxnyW7gsS6HCsr6lr7vyN9LUVKuOQQT0JfW4i5VztKSUi2fkf96UQb6KVJlSzE
	 rlVDuluYmgtPhRPdPbw8juw0rWZwpAyPGHHxHQ5UYcZmnr2AIeNWIrM3oPXbaoiv71
	 33+JJ9QejpzLqnQARHlqzq8MlrocQvukPIo16NQ66A0+Vrf5I1RXhvUJxRp9VDmZZC
	 QWkidKfYhuRUB8sV9ze2NQ2ZCP/CuEFKl9IUweuTBqjSC/jRzHJs6qhP3vxc2CA42D
	 heoL0myquTx2SEURnmbrf9WtbnjSh33+Jdp2ILZFxUobILzoBq/EzGYPa+fHZKHkYJ
	 sR3vPtJF2iF0w==
Date: Wed, 29 Jul 2026 17:23:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Florian Westphal
 <fw@strlen.de>, Davide Caratti <dcaratti@redhat.com>, Christoph Paasch
 <cpaasch@openai.com>
Subject: Re: [PATCH net 1/5] mptcp: avoid combining some incoming suboptions
Message-ID: <20260729172306.31deb67d@kernel.org>
In-Reply-To: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-1-f7e2d229159d@kernel.org>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
	<20260728-net-mptcp-misc-fixes-7-2-rc6-v1-1-f7e2d229159d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 19:11:57 +0200 Matthieu Baerts (NGI0) wrote:
> Some MPTCP suboptions are mutually exclusive according to the RFC8684,
> but also because in different places, the code doesn't expect some
> combinations to be present. That's specially true for suboptions that
> would be present twice, but with different attributes.

Looks like Clashiko has much to say about this patch.
Could you check?

=46rom my perspective I'm not sure if such RFC compliance changes
really belong as Fixes? I don't feel too strongly tho.
