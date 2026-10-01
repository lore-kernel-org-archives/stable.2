Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53504AEBCE
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848402; cv=none; b=Bd46pCW+x5NJiA2z9/pwyMRjOLg0Zc/NicVQxmv/hRoWXsIGzjLt8sKruaO94MhYuSiUEioLFOeOijnvJXzJ56w0SUGzzkwqbvrzeHdQlnp/rllzXnWuHBym7D5b8rad23w+wr50XIdjCMv+c7mMQw52oIx7uFkqZylWSr1Iex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848402; c=relaxed/simple;
	bh=+WLvS2bPVxxTaSPdd4uobOzINSNDbtxNDh9qJn2EUjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ui/A9wxkwwuydJ7vSKrQWgvXqdLxzuk7PSINvtclJDl2dA6ffy4J0mRmgxIsxSKpDx1zY8raB2rVtjGF0tGw/ItwYgWJHjNDnjYEjOERGv5KuGLZjZyaQtDUhf/Tnkyz8KJR3bwcdPXrrexYIs55VuIhXqYN7Nx0JV56QAnEf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HTAB18qk; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HTAB18qk"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48aff58e6abso984476f8f.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790848399; x=1791453199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QJ0zqYRdaf6SZM0JGYgcXH7jaR1ePmTYCcjY9AU/WA=;
        b=HTAB18qkRcBdR/GH1mUdj0K2S3B3o7qfm8lPJJgcMOlEHG2qiNhKkyALlwGKE+eZT1
         fSaottdDNIKXCax1WvAtIocfvyZVbSYuL0ZYiRwCq1BAUjJGUcfel+dVc4Rwa1L+Hcla
         wL8jBqMX7lqmc5LBAcEibPRTR7APVGKnMOwt+p147AYTZ6n5IqKCLCNtCMVTasN8vhvz
         nfJkPdSTb1NQytPztiMDmMTupihg1Lp1zhHtzFoPkGy89AyuEjMaOAgxzWAnXg2rwe4T
         ZdcM3RSEiIlyqPgrym7bYrwdKu3hWnuVKHsAm5GQxUGBA7uAsBUTFEmfW2ew15IAGIup
         tWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848399; x=1791453199;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QJ0zqYRdaf6SZM0JGYgcXH7jaR1ePmTYCcjY9AU/WA=;
        b=CGKXzK15FclqRgznGgs9qkOBad3gfHmV17xfxGvvxbLsE6zk+/pRF4lFPrfUrm3lxk
         on3k9eAiNVQ3j5AWDAaaSSUczm5K85CBbn4Kn0kGAdNWDN0j9yvJTFavlIP5ZwG+kZ6z
         VYTeBKrUeLaHLL2MUKocKa75aI0Z7T0qsG1Kz1f/rg6Cbjb1XbRKeafoM5I6CJinTzZX
         bNCpbIOraeo8Ju3Me+DZCsDCTmfcrKu22PXPEy1vMiWmfRM92ToThJvOJz8fGL9dTMUm
         wsA4543y1AuSDMZdHzcf7ErBIc8BYYBg8TTQvC3QyfP3bqgg8DJKJWqKDOI13q/X1sz1
         Ro4A==
X-Forwarded-Encrypted: i=1; AKwUvBySZtM5TwVNGB5oDZ6AOrw4Dc465rM2jguH8nrLdQqyOnDoVrS6UYHCtddSbph3zYGJyZww7b8=@vger.kernel.org
X-Gm-Message-State: AFuF++ltGauSMO4ney7NboeDk5rExOdkG8pyR4FBB/0G8aDrab9zDLtq
	vodzxgQ32bGwW3vhyBOhdFNu3Iv88CticklBxp7XXrrSORHKhqFZJGpqulLnGDkA398=
X-Gm-Gg: AYBFou085ZnSy+RlN6R4kmCBt7vl7+XgFuUHftNPmwwGS+YrEXRJeK0LTeSCW+whQST
	SIMExF3ouaFVqid/KbiLH1DslFa2bSyC9kbKNrQoE0D5+uCFjRw9DithSnaZXGpSY2EhUrd3+Cq
	7mwi3dagrJ4MmKCwr51ce1ZUQ3iWxczVpsNVRsU2x1Y5RdLmDKtI0AF/j8dicCNFangh2cHKVuB
	TYMGWpQFxw5UQ3YbFRLELUbXxpnMmgXoxJ1AOoSEg8SiJUzmbqnHQtk1L34rc8vxPaNPVQqISSD
	Ml7MHTTdMMMd/Pm1qEdwWech7osx+O07lIFYxT/FO3omJuNitCA3DIqET2/uys7tluA9RGIcJu0
	XSYoAB79Yk+3lHEQItlTStjpy7U/gJk3cOf7F/p3PH7qNbTnr0342Aa8mr09n7S62DYkvnZ17MC
	ai5RhVwg/ca66wXKbTdi2zj7iq4alC8vA0R8AVIpCuvHHNjqKKfUwqD791IhRM3JBIcVg+PEocT
	IgmskY1Fgjpx+WB6aQjHx2CYX70
X-Received: by 2002:a05:600c:3b23:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a01b119661mr72177145e9.19.1790848399085;
        Thu, 01 Oct 2026 02:53:19 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9248ccsm41237625e9.3.2026.10.01.02.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:53:18 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
Subject: Re: (subset) [PATCH v6 00/12] clk: nuvoton: ma35d1: Fix mux
 parenting and peripheral clock rates
Message-Id: <179084839794.49633.10441853107934842069.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:53:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

Applied to clk/linux.git (clk-pile), thanks!

[01/12] clk: nuvoton: ma35d1: Keep the clock count in the driver
        commit: 6c8177988fcc07bcdf2991102638b7db80e92bb7
[02/12] dt-bindings: clock: ma35d1: Document the missing crystal inputs
        commit: 2d9a942a7562e3cde3c9de0335147c5faa8d1eaa
[03/12] dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
        commit: c8a24538bd57ae545e7b8f9c8eb1c2f19a65a085
[04/12] dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
        commit: a05842820a01081012c3df0db3fabe07e36b163e
[05/12] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks
        commit: e9b3fde31626b9c5725856417308598ce1cc8541

Best regards,
--
Jerome

