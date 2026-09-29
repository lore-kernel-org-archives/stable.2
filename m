Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9B560AD4;
	Tue, 29 Sep 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707869; cv=none; b=Xhp784lLfPQmO85xR6vXFLQuhfVZvt1DYrv9KHawvSNufrLqQMVXoEYomuzxoajuBRuq6y8F1kgDl4z1c2F4EK3XvRzBza7NdPUifhySDJ+mPF0cMQOrIWsL05ZgxxLUS+zo7bzqSv2//Bbz5MlZTlZzIkt9rhOjiQ5p33oh7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707869; c=relaxed/simple;
	bh=UcNOhN9av9ri12YYn1dHbrlTQs/pUKtv9rBdSpVFcRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9BmwZ2BCIHvLX1u8uqoZNMHzHoYKYvYjPio5HKBOCvFsIi1EvOUJutZLTj0JTZbnpZ+Gc3usPJ/zKmmyrLMdV5MHUaEmJNx3ZnRq8xi1x3wA/ReL5/AcoXGZ5FDiMKEQFnavQCNarkC93Ud6bw1j6xFjHABkZXc1tDYnMCwWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epbvt+zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epbvt+zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44441F000FF;
	Tue, 29 Sep 2026 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707866;
	bh=uSBRVfr/kJMhRJtoeRN7vF7rdvtDjZ6MrXLWTgzGBoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epbvt+zpvpKeuAjYgDnTi8QyozRcClw0fI0Sz5mF455ElDNG/kVdTLDNtazZdFHMG
	 PRyquP/Xpo5g3VFDIisAQp7faLBcqXy36cs3Q70dFhhkalX+Y7+7jceMVsNVGN9JGK
	 ER/HOkYU77OCzpBefv7ZdiWecTd38UIlBuoELoE0AO+w5sBlSu+U9+qgRQg41gKMSU
	 eeofuAjCq1Dyt3Dv5rQcqNlnpM14/y0mz+sw1Qo4VB50jamBgYRSdSs6FBV3CXOULE
	 DPzTfd+cJ3PB75BTrBjSnJJ08xO7MevTxitUKD8Bh9LdEqHzInnJfI92WmbJo3Virf
	 kjpMc4DFRfhIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Li Ming <ming.li@zohomail.com>,
	Dan Williams <djbw@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	Li Ming <ming4.li@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] cxl/mem: Fix no cxl_nvd during pmem region auto-assembling
Date: Tue, 29 Sep 2026 14:50:47 -0400
Message-ID: <2026-09-29-daily-reply-0004-re-cxl-mem-nvd-autoassembly-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929030716.86736-1-artem@trailofbits.com>
References: <20260929030716.86736-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-41085. It registers the nvdimm bridge before
> endpoint probing can auto-assemble a pmem region.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
