Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423A1FE471;
	Fri,  9 Oct 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565828; cv=none; b=MN7Jnmm6a8WWEvjCWNXz1Rrs0bXYGtNCVMmY5DXRfKFt212lsIbQQgAGeYhZtJHYBQj/hujUyPS7BDVza3FxUoVKwTcIjcOXc43OOdALGily1ankkMpy8aOteBvm95Y2yJaFbj6Y67AO9nogskrSzO2phSlcBuiCg/uQ72VL7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565828; c=relaxed/simple;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKn1l7+XDqBGmgSHpmKazpOpUte7qEComkvhhMWEe/wng9RcUXL3o/wRu5XT9F2EBLVZadZ1dFLoPGHLFXT16JxyJlheL5f58EQRr0CqEX8BOQO+VebdqrQsMlIgPIbQDSO9eUzTSC4WpoG/BX+XL4RJnxC7QBuRkP6LgI0nYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGq10ct+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGq10ct+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C381F0089B;
	Fri,  9 Oct 2026 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565827;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGq10ct+EGdQoMvMBnywt/4E7GKhC8W4H2urVDdT96H7Pl19V8fziYa0MfjzAVDsg
	 IMOErbNyGL6oVc1dLbFfmJcaRzyqhXpkpJ4OcaaZO8wp4TuUUioUx/BSEFQ5go6/2e
	 zywZmP1UmU82nu3nTiAQ1+ETG/ft0eWFL9RBalI2bLt5eps2xQ0W9RF3Cm+OPpa3yC
	 hpwx/ikMuIohaYGIzMjQ7bqmDPUToTfiFbTGpfw8nHpnSQQ9EMtmH9rg+bqGzYI6ir
	 EbitcYjKQn5AgkaaV7VpVztpC8zp/nllGCmDzKDs84cTMi1RMDXyIUq5gHSQto0bzM
	 aCV4brDvHbNdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH 6.6.y 0/2] erofs: backport CVE-2025-68251, CVE-2026-53015
Date: Fri,  9 Oct 2026 13:09:45 -0400
Message-ID: <2026-10-09-1-daily-reply-0008-erofs-compact-index-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008190830.97970-1-artem@trailofbits.com>
References: <20261008190830.97970-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
