Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F837F320;
	Tue, 11 Aug 2026 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786427564; cv=none; b=BW7Dx3jm3PsmoHS8LxevJOVU9oPl98sfoz5aE2LwM8tt9Ek54nUDPpcNKcCzyJOE4eUXVp5CaCLQVDQY091DggM6CYcRLtw5HlO2c97fXVlGS8C2uZ0EqIllrFCDNrhIxRVDN1fMBmEt0IyVgBfjRpoz9r43dDrvlhmYcftdlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786427564; c=relaxed/simple;
	bh=tcZQQvw7I8q0egCL9Ih7GTdIKttnlAMsv62HwqSqDM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbMjpftQlrnkwY55Vx3pZna9hAy+JLIJy4sA9dXes40zV+pNK4fZcTMM0IDqyPriuAIwNnmUgGeU8lud0hSi7bldNG2UA5iKAzXIw1dKUHkwcvDnh77YZ+45GiN3L73YAT+j+oa70qV6nGPN9uQTjJSpq0siGySghP6WiCMhh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSeAxHxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSeAxHxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436351F000E9;
	Tue, 11 Aug 2026 05:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786427563;
	bh=RoHt8I8oDs8GqSb7bHRfcwB/Dfr54MBmMPMgkF3/JOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BSeAxHxZuwXbkLax//y/bgPNyiE6ABIV2B9PxTwevZxeuYoXfqzU0eMXhC5UQL44z
	 B+DF/7msEPGzclMnyeTQhKApXlexbtN6/f0AQek+5t8K3yXUZOkBBWkeOLQcfTfnQC
	 +iiv/Qjm15GXc94hwaUzZZBbvtWnPNlIjxlo6HClHDsv3gIs89C9GdlPQQsAmzdLOz
	 OsSqssKh4IUzCLXSyfapY7P19zJyjSFRpTIQx+UEcqjoB+1ecSovx0Jo+eakTfc2ya
	 bH/dQFZCo/YiPnCJsa0OkqGMDF0a7GTxYeoxr99dbhnVWEAbFvjt7QMYo2zVK380Gn
	 UFGcHH8F/+U+w==
Date: Tue, 11 Aug 2026 07:52:34 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, shawn.lin@rock-chips.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, heiko@sntech.de, 
	dlemoal@kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-ep: disable link training work on remove
Message-ID: <of32vj6w52rwcop7wn7vi3rh6o7im2wkbds6icp3mapxf5nzrt@efoivwhiltvd>
References: <20260811025315.136998-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811025315.136998-1-fanwu01@zju.edu.cn>

On Tue, Aug 11, 2026 at 02:53:15AM +0000, Fan Wu wrote:
> The endpoint driver has no .remove callback, so on unbind the
> link_training work can keep running after the devm-allocated ep is freed,
> causing a use-after-free.  Add a .remove() callback that disables the
> worker.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: bd6e61df4b2e ("PCI: rockchip-ep: Improve link training")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6

This LLM tool should've told you that you cannot remove a
builtin_platform_driver(). So this patch is essentially adding dead code. So
NACK.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
