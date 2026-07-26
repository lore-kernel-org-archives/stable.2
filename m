Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB6481B1;
	Sun, 26 Jul 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785075591; cv=none; b=o+0xVwYnHClbormY/bpApQwuz7G0+g+am4TdroyLA1YzcyglKGF4D66jVCymIYc3UsHxel2uS9vHDICu+mfh0E6hvzL2LIGef3hiCJ/YO/ackNSsZSGAP6RngFlwybeFmlD2+oiGxQTCrUl39AND2lPvKJvUWxscqYzjViCQX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785075591; c=relaxed/simple;
	bh=5LWuY4+s/p+JhpsAStdXXtxotIfNyNnTokH4+Gzyd4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUTHE8uEmOm/0//euNZv6nrj/G8mrFEXkjH3GJ555W6rTJcV4U5+/DNHOTqyMlhIVSBp58rh2O0P4A1UPB/VxmS/qDXY1rFeEdm+ErpKQLTdoEHQMR0Egd93xvE/i3T4NGeM2/sId84aaYwmeapKMDNJS3PAbfOIwEEIpTAw4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyGiV2JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyGiV2JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495FA1F000E9;
	Sun, 26 Jul 2026 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785075590;
	bh=5LWuY4+s/p+JhpsAStdXXtxotIfNyNnTokH4+Gzyd4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TyGiV2JBSt/WtVX9IXRU7oCxXsg1epiSvxE+6kDaOCJtOVKzwHFW+m/S66p2yoKKk
	 6pq1BN8UCdqcEJwLNNGyBz1ee/gq0CSsZiUZRdczn3sJS+ULvmf/WcYDzRuywvZRm/
	 dEq1qrh7RGbG3zADw0zWV68iHQQqGj90s8sPC7Nf24hSqtuSs02LZ8kDO+y3niNduN
	 /3YK7yET2mZnm1LK7ZC6mr94zWJz1iuCd2xcMW9EszSv6OEX02k3WVpkLQiYj1YzGZ
	 eOTXXN8RvyUsyClSuV4s8z37lXv8Hw6v3XmJD841xhtn12zHEgqQAGtJax46BRYzrt
	 y/ml4ZGaaF09Q==
Date: Sun, 26 Jul 2026 16:19:45 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: jdelvare@suse.com, djkurtz@chromium.org, hkallweit1@gmail.com, 
	wsa@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i801: Clamp adapter timeout to prevent system
 lockup
Message-ID: <amYXXbrh3lIIXcJ0@zenone.zhora.eu>
References: <20260723034331.116690-1-25181214217@stu.xidian.edu.cn>
 <amPinh8c7GwQx4Le@zenone.zhora.eu>
 <0fbbc160-a599-4384-b78a-bf8e6afd963e@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbbc160-a599-4384-b78a-bf8e6afd963e@stu.xidian.edu.cn>

> I will drop this patch and handle the timeout constraints locally in my
> testing environment.

I thought you were addressing malicious software :-)

Andi
