Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6C242D65;
	Thu,  2 Jul 2026 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=aL8TcbVPK/49Gquxse7IrPqzqZJM5ARoQVhxmedBltrIeHs6jfHYmAroJp7YXVB8QYkIUoFoFcD36UhuzBUQn4cIkwb25dhoccUnIj7gnm3gh+xdh45fpqY8BMIB/WQ8RNl6M5091ScfMpK7hgXRKpPAkvh1hFiRsMzhfxTkn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=kT/NBqQunlWsQ7ubvjZhQleFnca7dO290+Jy4yB4+cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/xbjw1ODO4chm1y7e5mzpRVz1D7x77ESTt4O0IlqbRaT4cs8qVTZhpYmvtRB3y0zy3WFyapAPokOk8/w1BkRbrkk4pmGBoM+h6OFCM85Bo3n33JgJ6b7Q3JxvbsVj3K8phIZVSisIo5SXZNEpuviBt8BoIfUsi5Hc6T6ECefe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRSYZ+cN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRSYZ+cN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EC21F000E9;
	Thu,  2 Jul 2026 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952729;
	bh=RQBnHF1qtS6KGf+wzw5MMQOAlTk6sYRCuY6XAJaTSS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRSYZ+cNrD4eaUMA1Yzo5UAlyJZNYfyijYcOlj2OVeGlPPY9GsH1pOdugbAyeMoS4
	 NChqDFgyYeU7McLKXTf0nYvCFkvviI+yaTpiOFcxsTVGdyZj95XW0xUy0o3yTcmnaj
	 jI1eyP2zW2Zlrg0MQYoKJf9U4OpRVUMCxFcbvYtydGwRdlQKjJ+ytNKInAj/TZNUQS
	 Bkw6/sI5mR0fLWCnN8523HCIJej/TfLJnRwUUvMSzmIn8eVgBvMv94iHsyODWSO6Ac
	 e0/MvxdoPGsBKr2E9i5v6Mg7fGYruiA73OUsMQbwnsQitQYYtbfbfPdJz/zE3qu6cd
	 rr7sQRTyK90Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Wenshan Lan <jetlan9@163.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Wed,  1 Jul 2026 20:38:31 -0400
Message-ID: <stable-reply-cpsw-new-510-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630200717.1994713-1-etereshkina@astralinux.ru>
References: <20260630200717.1994713-1-etereshkina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If an error occurs during register_netdev() for the first MAC in
> cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
> cpsw->slaves[1].ndev would remain unchanged. This could later cause
> cpsw_unregister_ports() to attempt unregistering the second MAC.

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha
