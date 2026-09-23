Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0913ACEF9;
	Wed, 23 Sep 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166950; cv=none; b=Pg3Gx0VT2bn7KfqM+JN22TbcMFMGr7K093iVRPbS67A/MDpjKARNjhr5fo1uG81IqCXEXUJo12mCQB5cFzwqa8IU79Ao7ekbOCMp0j47ljMPczB2rvxXxORNu6D+AhAb6rOWu1Go6MWGWHoWAXZcKL+vTX17aNsCTgEMt+T+Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166950; c=relaxed/simple;
	bh=TR1ks53Mu/FJ2r5qW5C8B3D0GUcWmmmERba0oHGrCd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=COOc3UUz2ymPp0jTOieCBapdo/dFP+esIHEg9xW8v+ERbkufZA5eLOT+ptVT4ZHNaLDbLIMVLmdH1AuKhXOyfs34MaNSwXIFc+zdg/jwtCLO4cOqi9W+EH6sgk03EXKCjCY6qPyEviZg3oPJeTDSugimj2Xzt/DqFu90WuIs3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDrwDmt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDrwDmt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C84E1F0089B;
	Wed, 23 Sep 2026 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166948;
	bh=9KsKOIPLtU1rbiWY3Id1SMc79Dvze0biHYy+SZuaDWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kDrwDmt42N6ryKTzfYCE+RIzlMSJVWawUWxnAbIYMw8p08ZaKIKYzRlfOXCB5pTeP
	 JCmGq2IXTK31tht/yVrNoZiPNrQfMMb0E/ZZh05Q8ITxRwgRAaadbOcWEYMHyVgroz
	 BGSoUzB9s8irG4c2A9zUh+ts9C+kzS6A7J03/8gvWFpntlMprJWh4WtmXbfPlQJIKi
	 SZ5qVd8qvZ8W3MstLQVlc35fvLh6H67ianvdz5/IfwyA48t4zeW+jxB4xXcjAmcUjk
	 /jD84uGRa/rdEOdl8uyjk0V4cT+gbB2lmzVJv+PSSihrA9iD7PKGtLMfQ2wN4xPha5
	 wY9qLwhEtRx+A==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Oleg Keri <okerixx@gmail.com>
In-Reply-To: <20260918-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v20-0-dc244e124e71@linaro.org>
References: <20260918-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v20-0-dc244e124e71@linaro.org>
Subject: Re: (subset) [PATCH v20 0/6] Add phy_get_by_of_node and devm
 helper
Message-Id: <179016693988.140073.11333980752731618724.b4-ty@kernel.org>
Date: Wed, 23 Sep 2026 18:05:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 18 Sep 2026 14:56:35 +0100, Bryan O'Donoghue wrote:
> This series has evolved from a CAMSS standalone series to a series that is
> mostly on the PHY side now, so I've split the series up to reflect that
> fact.
> 
> Starting off by fixing a long-standing use-after-free race-condition in the
> phy core flagged by Sashiko in v13. While my series doesn't introduce the
> bug it seems appropriate to address it anyway once flagged.
> 
> [...]

Applied, thanks!

[1/6] phy: core: Fix race-condition between _of_phy_get() and try_module_get()
      commit: 090055ee629523092688da42428558ba56d4272f
[2/6] phy: core: Add phy_get_by_of_node()
      commit: 89c5ae2b19619e41f9098011667fc1f59c9f322c
[3/6] phy: core: Add devm_phy_get_by_of_node()
      commit: 2ee4e00dc1a38bf7bbe128825a63c6b523480c33
[4/6] phy: core: Add missing kerneldoc colon in two locations
      commit: fcce260fa4ba624dced020789d0a9a0cc1670062

Best regards,
-- 
~Vinod


