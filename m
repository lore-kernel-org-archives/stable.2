Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DBCA45;
	Thu,  4 Jun 2026 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531554; cv=none; b=tAzXMdpoT36/FPmzuA1NJIPmwWC4kQcaa0CpNq9tV0QE86J8WeJ92aSaqYJoCUpHvzsN7FP3zmizLrr+bvl0clTh5eAX88nczhDTmv+ozyp+bTmTdb1x6cN1XnPBHEVbAy0uJjEdnBvmQ6mO6PIuNGGIgXsddWe+H12FEzYwcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531554; c=relaxed/simple;
	bh=RJVuoGu6wDgFAw/E895KbFt3cdYjWuuScm1vlafFGQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk0DN9ywolHnJ8vaNTENfumy4H2eJgbFGqJi8TsRjjvGQBjAAcxAXIWnOwsHUwTiKe5zggivcpFe13Qq43M05ZWAFZLmyAHDYbkcraMbpbuK/njeSkS9DIi/b57KMGA3jDrUOslSYhSN7VL0fwt2Cr00hfjzqHZiUhEsKar9vew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeaoxBHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeaoxBHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614131F00893;
	Thu,  4 Jun 2026 00:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531553;
	bh=kP9pyEAShCQiMfRAek7apupVhl8YFC91fnZd+w1KxO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeaoxBHrG8tB6YjsJdpQsCAv7YqYEyzL/Tv8HqZheTWQiT8JgYHkGNYSW5HjkAecF
	 DWnAbeY73dKlP45+ocAdFNntKu8W/HMKEkzVV161OrpovcgWpKKztlrgiso4P1Q8SY
	 gAYeDaQh6/G4hvN67Ioamu0vHwoB9JRCr4ic9PLjGHFyCuzU3P0BTVA9zrFrDxH7fX
	 HdCi1kWtAURvs+bUVuzDSaUOZOHMbOaB5dxQC6Lao1Fn3JhErQSmpIXCeBNNATQItz
	 IVKHdOpnXEECtwhJOU72H2ACmsHMe3/GuEmIR6NLaMgUAlJnvAfclZEshC5QhGTm/N
	 Oc9pOd00LImRg==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Friend <netdev@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Subject: Re: The backport of upstream ea5df88aeca1 introduces a regression on 6.6.y stable
Date: Wed,  3 Jun 2026 20:05:39 -0400
Message-ID: <20260603210831.item004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CO6PR11MB55865EADC225FA57A8473BD4CD132@CO6PR11MB5586.namprd11.prod.outlook.com>
References: <CO6PR11MB55865EADC225FA57A8473BD4CD132@CO6PR11MB5586.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ea5df88aeca1 switched VSC8574/VSC8572 to vsc8584_probe() but its
> prerequisite 1bc80d673087 ("phy: mscc: Use PHY_ID_MATCH_EXACT for
> VSC8584, VSC8582, VSC8575, VSC856X") was not backported, so the revB
> guard rejects these PHYs.

Thanks for tracking this down, and thanks to Andrew for confirming the
missing prerequisite.

Queued 1bc80d673087 for 6.18.y, 6.12.y, 6.6.y, 6.1.y and 5.15.y. On
6.1.y and 5.15.y it also needed its own prerequisite 31605c01fb24
("phy: mscc: Use PHY_ID_MATCH_VENDOR to minimize PHY ID table"), which
I've queued there as well.

-- 
Thanks,
Sasha
