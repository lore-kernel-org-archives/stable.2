Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F611264612;
	Fri, 16 Oct 2026 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110136; cv=pass; b=QTHL2B9uRrn0G0wV2lK7Zv6/5ntrCQbr0ETFBzsIuU9jQpUNabpzkT1P50iC5yyogMuK2pjbTkXQqf/FByRg1mY7BVLEOcuQFcExBk/4O/t5RqePQK0f3mEY6q2xxp7Q1nDm2f7KLbqHi/jPTQ1Bm3q2AHLwNQuXvdswOTq545A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110136; c=relaxed/simple;
	bh=bP+KVYVAqjLheb6EGd540JgwAFSAWbX/yPhhJ8pICGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FGoJIFc9KNvlaVwEasiA3QFVDrUBs9dDLqy6UYMAuNAaL9yj6Wsm33fagwZw2lbXup1HPLgZ112dzrqOaSZmPS/u8MgSyyZnQQBaErF/sqhRD9qtJ3A14zsmd/+DiFocD2q4cX21tE0Ft1eA3tn6gQIfDyALSZNkGWcrKiLmQWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=XHXnt2sz; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="XHXnt2sz"
ARC-Seal: i=1; a=rsa-sha256; t=1792110110; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fraCKwKX0fzN5fIIcWea1PgSkWDBUI8OyAjCzt7eKbksO8lpjZJBQ6Ctzk0YsGQjaYpsF0pIgkDoEHjbF3G+xAtfSus19YCuhSmzJRBHpTPTmMf9vKivKk8X1XKENOgAc/1bku+z/Yq4t87A7ntjpCwHyPD8ThLT2jYXChmKunI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792110110; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q/KULuIQAtVhjOrq/I9pow3roLZGV4T+euRV0IgVIXA=; 
	b=NT0LSbcnrdnwcnUdPKnGTczpqXGj2EoPl9sDZs774SGcdP6Aaicb+ZQ7cgpIWOHP56BaD2SPOOfcVvLU9Wd1Iu2cylCXP7ChBZ2aXVA5eJgMWbRa9FlAO65Ao+sHAUrJAOR+xoQYe6au1gKYr50oINwOrtc7rQq/JMgsZT2keII=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792110110;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q/KULuIQAtVhjOrq/I9pow3roLZGV4T+euRV0IgVIXA=;
	b=XHXnt2szDmIb1ZtOxhXdd6InOuBLO0IBNrPCTcyDXEtqhCSC5paP3qei6krP0kof
	UIY4p0kGXAdMv30d6vkqoS8ZaZKr2vyJ4WgqoA7clpfuqHSUhLadjSwkXARn2U94K7V
	IN8fl3X4veU40Fm7GAEj2F3QbFhI/lgUeeMZGYK8=
Received: by smtp.zoho.eu with SMTPS id 1792110108025344.3056124488576;
	Fri, 16 Oct 2026 02:21:48 +0200 (CEST)
Date: Fri, 16 Oct 2026 03:21:44 +0300
From: Igor Velkov <iav@iav.lv>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: =?utf-8?q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>, shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, dlemoal@kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is already valid
In-Reply-To: <179196286749.38040.5597453767131590054.b4-reply@b4>
References: <20260911211559.207990-1-ehbello@gmail.com> <179196286749.38040.5597453767131590054.b4-reply@b4>
Message-ID: <20261016-h64-pcie-resume-tpvperl@iav.lv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 12:57:47 +0530, Manivannan Sadhasivam wrote:
> I do agree that the Tpvperl delay is *redundant* if the supplies are already
> enabled by the bootloader. But I do not agree that it causes the Endpoint to not
> respond.

A data point from a Kobol Helios64 (RK3399, JMB585 on pcie0, ep-gpios as in
the mainline DTS):

- Enumeration at boot works with and without this patch.
- Resume from s2idle fails in rockchip_pcie_resume_noirq. On plain v7.3-rc7
  with the mainline DTB, 13 cycles pass and the 14th fails with "PCIe link
  training gen1 timeout"; resume_noirq returns -110 and the board resets.
  On an Armbian kernel with this patch (all supplies stay enabled across
  suspend, so the wait is skipped on resume too) the first resume ends in a
  synchronous external abort in rockchip_pcie_rd_conf from pci_power_up.
- Plain v7.3-rc7 also hit an asynchronous SError during the bus scan at probe
  in 1 of 4 boots.

So on this board the resume failure does not depend on the Tpvperl wait.

Igor
