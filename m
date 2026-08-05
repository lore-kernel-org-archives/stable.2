Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12841D11C;
	Wed,  5 Aug 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948126; cv=none; b=RoC/eSepHc0s4wvU7S+lGXdL9C9yGBMkt3qCbCCpXQYvKv2uvgLrB595xKsVfCLTXchOCnIEdQQz4pDPETJt3lOPIkpNkcZ5tuWVDGDRb4IVVmEC2vCpbYpO3ByJmgy9B6tWJPMPUlXP4YJBs0L9j8nbP2X2DjMCORy+ORt2BQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948126; c=relaxed/simple;
	bh=eWbcxOCmJKyCeRr1iK7kEqZhgrvXtbjLljtdsR5ekkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVJg0B6tnLgttW5uYx/u+4BzOHV1yQnzUIGogA95C/GkruxPA92BdkuZiKNFvXLmQeKZo1xdMzg1RFdBAPkO2owR5dq+mDXfGnPbXTPF6dYfkx17Bu4K+Ykh7+b9+k0n80w6EitA7S2AIyIobC8rXOmb89rGeEvFUC/36ThnQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVmalbWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVmalbWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026961F00A3D;
	Wed,  5 Aug 2026 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948124;
	bh=ycWjVdLdAzGyqL7i2r8T9x05BgBr84IfzyhMfjltNmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVmalbWdFjaZOh+li6aoDLekMa8z+ItjrjDekKuENUJuTMws6P42OhYE/8W/72lNg
	 bQn38i9uI0WbPJxYV16Sj6Dl6ywntFJF9vEpQv06Nzzf2+iyxtnQcFQaxPSTd4lWbI
	 zUZmGubQ/wDFOCbWBIsW8kS+xqcsZJz5J1uVtESNkYiEDLhBRCNCJDVg8u2n/0yYzT
	 SQ8M1nhtp3+zVRdZlJ5dsglXkMyglo+4Xcxjf6cpEc7pBWIaGdu8CuCPcyU0AfM/Nq
	 GvDdxLIg0IX9d91W/tQ1XSyLWoPn7G5j17f2EhimFCdXnoIX2aIVMtjgJee/VNmjad
	 7bTDSlNcdbxTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yun Zhou <yun.zhou@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: Re: [PATCH 7.0.y 1/5] net: mvneta: re-enable percpu interrupt on resume
Date: Wed,  5 Aug 2026 12:41:54 -0400
Message-ID: <20260805164000.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805100136.59101-1-arbabhaider649@gmail.com>
References: <20260805100136.59101-1-arbabhaider649@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 03:01:32PM +0500, Arbab Haider wrote:
> From: Yun Zhou <yun.zhou@windriver.com>
>
> On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
> IRQ disable/enable scheme for NAPI: the ISR (mvneta_percpu_isr) calls
> disable_percpu_irq() to mask the MPIC per-CPU interrupt and schedules
> NAPI poll, which calls enable_percpu_irq() on completion to unmask.

7.0 is EOL?

-- 
Thanks,
Sasha
