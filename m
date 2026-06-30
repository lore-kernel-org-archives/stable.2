Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171F12CDBE;
	Tue, 30 Jun 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842541; cv=none; b=HY5uuORJQgWLnQaRoNT6A4TDhCOtXsbVR9jeZqD73iH4iNa8W37z6oGNHPPAZhOR6P/kgNoWGCr3cOdvkZAieaWmz1ttWZSv9rQMXrkqwhHpJHWZyggechlJA9ck1+ScnE7GCW4gX4oXp4+mvpNqYKrASSo09dmtEElMwZZHI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842541; c=relaxed/simple;
	bh=V16u8iU0zk+lCqlS1wIv/DHcIm7oRipJJhddV2VDekY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbJ2hMw/+Vq/pFsMsKTj8FKzDhpW4T/fiI68JKB8snivEHVN4luFKCI0Ryz2sNRcNhDb7ONGaB7b0Kdsjd9ps7uZxjjQTAFoUGlMx5Y66YW9mGQ8pnHcAkOtFmEHgXVa5edmDf8L9ACP8f4WmgbOx5TL5RG4soRY1OyS1aJ+9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW2LtgBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW2LtgBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4201F000E9;
	Tue, 30 Jun 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782842540;
	bh=xrqqsPqaXbkExbvl7l6TbPo4VTzO9ytLt6edYlDgBT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bW2LtgBuXbPQAq4eiMMa8cUMnVjLuqj3Q6ugsddafkV7o5cM+0nsN+QgGxgqaE9Ke
	 Hd2L/gR2uB4HHXsgPXibU6mlHo7TutX96zAGXa4SDB3W0MssskuFm1/Eozs7oBwvBA
	 arL/o6a4H3Fr26i7Cxlgj1M2y63FOHzWKO/ny5MVsnEGMsX3sys6c3Cs30jcJHkO9+
	 XRCna9Z2QOrPjFQ4omy9vh5UCxbCXgIqPfvOAEHTQtsCudlU/X2XioMfoqlzkl5rr7
	 lEWWmTRxZJRsYFaORIATLAzNFLotlOzIx22OKAL6w1ojr3Hk3eIYpyEl3bK8vY9eJe
	 Hrdb/XaxU/e/g==
Date: Tue, 30 Jun 2026 13:02:19 -0500
From: Rob Herring <robh@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	daniel@makrotopia.org, stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
Message-ID: <20260630180219.GA4139943-robh@kernel.org>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>

On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> Child nodes of a fixed-partitions node are not necessarily partition
> entries, for example an nvmem-layout node has no reg property. The
> current code passes a NULL reg pointer and uninitialized len to the
> length check, which can result in a kernel panic or silent failure to
> register any partitions.

That does not sound right to me. A fixed-partitions node should only be 
defining partitions with address ranges. I would expect a partition node 
could be nvmem-layout, but not the whole address range. If you wanted 
the latter, then just do:

partitions {
  ...
};

nvmem-layout {
  ...
};

Rob
