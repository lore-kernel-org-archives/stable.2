Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDFB38F24F;
	Thu, 16 Jul 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220800; cv=none; b=idZsH1LFxwCfH59ShoMrexPhhb0JeSQh0qy3ZSxcsvEjGSmdt+I6lNe58/jjCu86eDNqU1w1hw8otgWsZ2hpQJDDNgmDu01qjblqI+oikWf/ya6vvRhHQcZho9p9l3hIYPs6kCN9q8R1rsdko8AfH8O4vhPnC4cCn7H2xTiomRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220800; c=relaxed/simple;
	bh=rRL3aDuoPxiaKhqeD5yE4i1nBA5bgyn2hTSGJZykS54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DsQRQ9V689pV3cRYxBE40bg9kic2NT5z3zx15TPTbhda83nCYKYVKZBYJK/LuyR6VhF1CMAoevzT0jlVof5708Fn0TYab5jItuZMARSFtFAA5X1E9zkT6CQBWGN4YHMyCX+lpDRrMZPYdXqRU40lWJIqz+BKtQqnffuG4c0JLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcTXFE11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcTXFE11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985E91F000E9;
	Thu, 16 Jul 2026 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220798;
	bh=UguD3qkiJGbI87+Av0EcwBEa3lW7uKxy+m4ANw9z4Qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FcTXFE114d+ckzWIzEadZ0UB7Qt6lqvotoY/ZaRtji6g8wBAUuP06MLc/mNM4IVBp
	 pcBQTywfaE8/6I8xQPlz6jZk3RzLqY1rEIhnFjy1U/Chtt6VWCND5/+vN8+SJV5rZq
	 jP1gwivXKrHHVWFmfU+15k2zo3SccPCStu9bKmfgFFJMsad4vRFJz1rEt2KwBRJGK4
	 bSkyWZslIVrg0Q7VYMTeYOUnc+Ovv5kBkOefUwP77bhR/S/mz5ET+D4uOB3t3rwe30
	 Z19iBmCNwenclpfbj9JmyPapSK559XeCYLUGk0PgyRVh0rvJyklHINPUp26XcT8PIn
	 bSQqDaY2q1IcQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>, 
 Ali Tariq <alitariq45892@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Elfring <Markus.Elfring@web.de>, stable@vger.kernel.org
In-Reply-To: <20260716102053.185276-1-alitariq45892@gmail.com>
References: <20260716102053.185276-1-alitariq45892@gmail.com>
Subject: Re: [PATCH v3] PCI: starfive: Fix resource leaks on error paths in
 host_init()
Message-Id: <178422079520.175592.708202335281352614.b4-ty@b4>
Date: Thu, 16 Jul 2026 18:53:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 16 Jul 2026 15:20:53 +0500, Ali Tariq wrote:
> starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
> optional regulator in sequence, but does not correctly unwind these
> resources when a later step fails.
> 
> If starfive_pcie_clk_rst_init() fails after the PHY has already been
> successfully enabled, the function returns directly without disabling
> the PHY, leaking it and leaving it powered.
> 
> [...]

Applied, thanks!

[1/1] PCI: starfive: Fix resource leaks on error paths in host_init()
      commit: 22877a061f81c5d58041e384b3131684bec636b9

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


