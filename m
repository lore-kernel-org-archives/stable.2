Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700507;
	b=0Bf9VkD4wT5ubwKC4W9vHc3VCwKWNdKn3D3D0o2zeaNhseJHNwhim9mFeZ+jzyprr8/H
	 ZzYBlXYzHIkV0Rz7O7XTHKGNe2F1BPhAsTz3jGZi+nXK68hhhmOnlDbk2Rz4UsyOn7Qxc
	 xuEl+I7lfXjKibxDugTABsDM74ePzXLPbn88tyXpsigDCG/dE8wbgit8k/SvWNezjMTJ6
	 LRPVQRC5zpf8desNRKJBGeyA9+rTsUuZmOP8vNh+1Xhwo0Kku5GV1hgwgk5dnTYWF/U05
	 ADp7hmpit2Vx0zgiqEpXMN4bp4J/ek2FOWmX+1BttxRdIbm/a6piBNN9a8IAdGh07QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700507;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qu+ULS1G/vHgDQaSepKD9o12HnSf0Zm9QTE2GXOFXjE=;
	b=wMQJd7baEs2g1gVpDruLxiE75Vf7oQgw3ktV7xODLAj4axv3efnXhaTh5iCHmPPfQba6
	 UO/VV3IDEggT5JlrtoRbSGzfygLFB1PjJJ1XoHYba4JpkIdnLzLGQefqDldRJwO+HJ5eg
	 LZ7pHuM9b8k3GOPwmpwzIHo9KZDLVElq6GkwSurpRHYZ6l8W+TZ8JruJJizMQ5H1hbEws
	 ydLjLqYOS7uKcCavwR0rPkHac8ZlSY+mkuOjiWh6juBl2wo8xCmJ7L+/GXXMLaA6llC9I
	 WBO5iRPg0s7o8lD16TBc8GOuk2Pll8XA3dD1rYBKO7lSLv3MfzLTMg38LaFYXXdWzWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H950uVkj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD291606A31C;
	Thu, 26 Nov 2026 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H950uVkj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BE1F000C4;
	Thu, 26 Nov 2026 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700506;
	bh=qu+ULS1G/vHgDQaSepKD9o12HnSf0Zm9QTE2GXOFXjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H950uVkjdHVBcmwvRvu0yoe7S13dsymXZJoYapyu1pzxqpgirLkadRq6HFUrNg3vD
	 zDDHQvpgQwcxAjZ4+Vgwfw68MaUyvXbjhDfz3swzmNoR/yZ/RCwbDWSchYUy3n4ncM
	 JpdN8N2mNpoz8kBTOGgdZaXcqvGXpNqpzI44maTr4V8ppwoyo9SsIV6oMwzdGRUBdv
	 AjReAkE3MZDLHhXYoJPBleBXNMHYNE7MdxHmc43Q3ZNw6gv7vpzSZgj85q4Pib2Djp
	 i1X83Z8XDAvkDFUTplWMqAFq2n/3ZdWfYAN5ITUdWsTeGuLy9nx1F4LxG+jL3zKQLE
	 a6f3Cu+MbM/AQ==
Date: Thu, 26 Nov 2026 14:41:42 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Werner Gartner <Werner.Gartner@congatec.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v6 03/10] i2c: cgbc: Use real I2C bus names
Message-ID: <awg2_PLCeNgio_bp@zenone.zhora.eu>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-3-bb070ad3e9aa@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-3-bb070ad3e9aa@bootlin.com>

Hi Thomas,

On Tue, Nov 17, 2026 at 10:47:43AM +0100, Thomas Richard (congatec GmbH) wrote:
> The adapter names described the expected purpose of the buses ("General
> Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
> rather than their actual names on the Board Controller.
> 
> Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
> the naming used by Congatec.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

BTW, do we really need the Fixes tag here and the Cc stable?

Andi
