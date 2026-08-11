Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019B456DE8;
	Tue, 11 Aug 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467831; cv=none; b=FUwQF3gMq01Sf5n33g2Wq1yKv168NTvM4oYVzILAlrL6iXo+wHe3evWQNW+Nz8vQIsUrgSlMzsezd8YhjqT2X82frIMwiHjM7NwRzQHkaa7S8y3xzFv+69EBmhk4lUVqiErABxJcYDALSuTWr8XvzVfVckmIAZLc7Z7ET3+ZuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467831; c=relaxed/simple;
	bh=WMAFVGNo5GDI1FyvLwMra1OZdedJVdf+v9znczCOPR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aOAE8f+b+JdFN5DY4cpJCx+di5geCBfAbKI11RnonPlzr+0AhnAW8TfXi1VbQErcr0wpwCL2+I3gBZ47rdsDTi4t5mLGGBxY4KDzy1JXEOYw2MoPkkZDNHTZDj6q9UEf2Eno2mL+1zlwnW784YutK/IsKg6aJm1yBe/i3l1750c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/JpIADs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/JpIADs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1144F1F000E9;
	Tue, 11 Aug 2026 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786467827;
	bh=cMyTTa5KAjyZtVZZYKXgPBl0VYfKOHY5hZtIr8dRpwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j/JpIADsBUI1Do9UvT+M2IL3RJVAsIYBy++rjBQHQQHLLM+d5+h9eruafLfp8U1+3
	 avw4Ti5i5yCFSJXep9tH9anl4xuTsc3VrqEcrfCzu+cIFOCCRtyB9D2UoiywJhksjA
	 WLRgrAfHQFpN2OP5Rt815NVXPUHyXuJ2orgkDHkYLboUDOj8eP6BpRe/H998SWMsit
	 gmTBu5RqqbtIjMgDe/tsslGoo/i0bkiPJcwPWUFAcV5bwWVF3gGKdmvbkO6W3w+je5
	 Zq+vYrHT+hufTg8FbMjqkDkQ7OC5L6BfgPs4XXTE7kyC/PKLyaTfBZhGvd7WxTxMaK
	 2h7MBXrF55fsg==
From: Vinod Koul <vkoul@kernel.org>
To: Jason Yang <jason98166@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260811-dcphy-maxreg-v1-v1-1-aa63f6a63a64@gmail.com>
References: <20260811-dcphy-maxreg-v1-v1-1-aa63f6a63a64@gmail.com>
Subject: Re: [PATCH] phy: rockchip-samsung-dcphy: fix out-of-range
 max_register
Message-Id: <178646782464.1081354.15306186863821576156.b4-ty@kernel.org>
Date: Tue, 11 Aug 2026 22:33:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 11 Aug 2026 16:10:22 +0800, Jason Yang wrote:
> The PHY register block is 64KB, so with a register stride of 4 the
> last accessible register sits at offset 0xfffc. max_register names
> 0x10000, one register past the end of the mapping: dumping the
> registers through the regmap debugfs interface reads beyond the
> ioremapped region and oopses on the unmapped page. The oops fires
> with the regmap lock held, so later PHY operations deadlock.
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip-samsung-dcphy: fix out-of-range max_register
      commit: 4486e75ba647bd8b98fc1f053101b40caceeed4b

Best regards,
-- 
~Vinod


