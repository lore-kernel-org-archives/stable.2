Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455626;
	b=oaaI44mYHTwlpLGDgl1zcI+zu6BgA4mc6kc6YN27Iyrs81PYRU44MViftJ0GnA8pOExu
	 6sJZfBtWihD7x8QkpHG6YiNZp1oGAepIU78ArxmjxSCLYnX0sTndDbsuWcoR1IihEMorK
	 0QJBQkg/Ma/9s8l4+EoI8slkEryXg4Qj8zQ5WvxugvyrOFSrYN2NZ8Rblyd19Kt+5FCzV
	 NXVW8qo2RTT/QPEmODCRZfmPa/rHoELrAEZWm+dq6C/zwQWure1ve3cGfog7dCRwZeP/u
	 eW9B1gevozfGZDsT6r04Fw09k3QAczenQnCDcoJdM97zYJTGBQgZ2iL7iTOsoAdgNNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455626;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VGSccGuc587cleRJ3vczX334RdsddPRyIAlwzcCirdE=;
	b=m+JA9lIfsQ6cNYN7p35+9+vtrRRxaXUSmH1wK81619BgqZEx15YK0DqKKKJbVk0omskJ
	 IzSXkM4mWxLsSo96nce+BXALZUf7K1dpM8PDeNzPfo/uKDNaSd3jglWzPZpMcFVKLmSsm
	 G3Sdq4zrd/j5HwGB/8cCATlI4TBDz3V5rPdNiZc4Iu7g52aSUz+RwnS3kWxQbZCYZPsMi
	 l614DfZW11ZfGQE2DS/LTeylG5wQIIBw/rdYmmSIHC6HiwFqYYP/e4THOdKeEPyhBki1u
	 pp94URLTtlgsKiKzfE0AwMSXg0c4fB5IZA4qYilvQmHS5WqZBhvBXOXZ8kzMcrlGMhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWkZQcQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33326606A323;
	Tue, 20 Oct 2026 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWkZQcQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF61F000C4;
	Tue, 20 Oct 2026 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455625;
	bh=VGSccGuc587cleRJ3vczX334RdsddPRyIAlwzcCirdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lWkZQcQ4p/TOJZSxpmjgbVii/QYcgeurjsP+vFBjtRB4ZKQE1ifV1lsbZ1ZvEF4Os
	 w43kPhSY2I/ys5ZnmOBLV9bWZJhQUVL7zUIYiszsYpdvXWKG13SccEAQAGw+xhE9lt
	 OgvXNI/nFC/JJQm0mmhgoH83SG5FgRCLKW/+RztNEZs+FvAyNygmDy4XJn7KxH6i7v
	 SDpatNXRjjmkvS/oOmt5zzu3UD/p4Tu9j62J2W348N/ynvQS0pWDS9q+3kBR2u/YR1
	 o4z2ezICC80snA+k0MqAVPtyk0vJ1luIhSoeP85c8z+aDd5MRuhryb989BeWUmX5MY
	 LPVuN/TKuHzVA==
Date: Mon, 19 Oct 2026 17:20:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: bsdhenrymartin@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, kuniyu@google.com,
 idosch@nvidia.com, razor@blackwall.org, fmancera@suse.de,
 atenart@kernel.org, i.maximets@ovn.org, qotmddnjs@ajou.ac.kr,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vxlan: reject appending a remote to a nexthop fdb
 entry
Message-ID: <20261019172023.28d34b25@kernel.org>
In-Reply-To: <179170221371.434549.11644886224016401666@kernel.org>
References: <20261010064802.2741221-1-bsdhenrymartin@gmail.com>
	<179170221371.434549.11644886224016401666@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Oct 2026 07:03:33 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] In vxlan_fdb_update_existing()
>   (drivers/net/vxlan/vxlan_core.c), the new `if=E2=80=A6

looks legit
