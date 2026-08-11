Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D03DD852
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474566; cv=none; b=OhiiTsKWVLCrmo0Vs3rhzlZDCKlqSnzl3Ke2QdNuRI3FUBtF4H7k4KF5ZXrNckbN8qUqSCVTsADzXwiCuq/TMPjrrUeajmCGOgt9EWVRMvUDZoHNWxfkbhgg5QikmM/+8lleXV8qnNxTV3cxmx1DBzjxKWyjkajbDO8nKLpVpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474566; c=relaxed/simple;
	bh=mZrVY3h+Qp94YF3FhfO0/KaL7vomZ5i07t0RV5Z3hFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev3eDXGZUlqiDu+UrSEoSusBiDgGrpJColcZOYcEinkPmxDKzKT+4DJ6HAKRNU7s70PADs4W5yrFeUDOimMCM9Swua9H3rrkvmvNh77jgNWNgRGK0fN7kMe33//FYCqw7LmabDPcI6ZqlTHHI2P6nPyfaH/LlcpsW8AhUmc6b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X46MpPDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X46MpPDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AB91F000E9;
	Tue, 11 Aug 2026 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474565;
	bh=K48jktuOMKSx8NWndR/16lLrl9CKZa+xhUIl0liG2Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X46MpPDS+cdK2K0XO46Rt2g/SVJNcqI/ghMjqy7x1SpEaR4fpniFc1xdYQKuw7aqc
	 ETxtLzlVKXmiJ4Ye9IuazybxAR9IZY/fE9VNENfM3KmGXBQnjbzUmrne6ngtp4zcaF
	 5w+RtRPgmeTLgIUt4kzuS92a9Pql5tqnQDGxIglubCGcXSnbeUu0GfrKiTfTlwlLtj
	 1wmnj6yfUTRC1tZQrFSaQTpNfbe/1Cc5RQHjFFWj6JJtGacAGzVk2t16PXI+fCrLHf
	 zq8NBqyfpUukC70ZsGNCgLp/T51tN7yZf5XwJ9pgcjlLL8yFuSx3i3X5im2/DVDR3W
	 qmnylMXTo6jIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 5.10.y] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Tue, 11 Aug 2026 14:55:50 -0400
Message-ID: <20260811184500.stable-0005-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810131217.238074-1-dengler@linux.ibm.com>
References: <20260810131217.238074-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Extend the _ip_cprb_helper() function with another parameter 'scrub'
> used to steer scrubbing of this buffer. So now the caller has the
> opportunity to decide if scrubbing is needed or not.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
