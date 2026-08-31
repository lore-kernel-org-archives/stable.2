Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDC3AEF50;
	Mon, 31 Aug 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182341; cv=none; b=mYzg4amEd0jQOX4osDD85X2pRITATmmFZF1Y9GbLMQELo7acdVPPLiS8SDojQxWawwJFSM579uD7B7BhxjDkIzOmfdq0pao6ct6uxf839RKrkUFSd9WD8ykHmaECNIxNggna8Aa40VdvgUjNqx91B8QH+JaeayLTEpY/J9t6mZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182341; c=relaxed/simple;
	bh=hf1NWzRj0YZ1pkkGrrJ0vxoLf/vkpBRNSYLGyFrXXgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EpTbqvMMjEB/xXF0Wgue544bTOuGxh10eNV/9jG/n0Yy+7aAO+XQE6yfE8TywVBZMFC5gYnbiwpuVPvPZApKolh3R/Gadn+BDYiXbHk7XEfoVO3LJ0bPt6KJoSVNpdRWA6UU0hXMzeDip8eAxUUnZ5/3zzppme8e98GDytA/heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECAC1F00A3D;
	Mon, 31 Aug 2026 13:18:56 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, Liu Zhenlong <dragonliu2018@gmail.com>
Cc: jacky_chou@aspeedtech.com, mani@kernel.org, bhelgaas@google.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260816171633.15025-1-dragonliu2018@gmail.com>
References: <20260816171633.15025-1-dragonliu2018@gmail.com>
Subject: Re: [PATCH] PCI: aspeed: fix clk and phy leak in
 aspeed_pcie_port_init error paths
Message-Id: <178818233640.33196.12707078026403586187.b4-ty@b4>
Date: Mon, 31 Aug 2026 15:18:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 17 Aug 2026 01:16:33 +0800, Liu Zhenlong wrote:
> aspeed_pcie_port_init() calls clk_prepare_enable() to enable the port
> clock, but if phy_init() or phy_set_mode_ext() fails afterwards, the
> function returns without calling clk_disable_unprepare(), leaking the
> clock reference on every probe failure.  Additionally, when
> phy_set_mode_ext() fails, phy_init() has already succeeded, so
> phy_exit() is also missing, leaking the phy reference.
> 
> [...]

Applied, thanks!

[1/1] PCI: aspeed: fix clk and phy leak in aspeed_pcie_port_init error paths
      commit: 6c566177fc8f728271bed8018ac77b0a8199200d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


