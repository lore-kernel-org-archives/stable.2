Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADE2C11C4
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761215; cv=none; b=eFc6OCeoXgwldZQjOS+Bl4/Ah4xvLsnKeCfo4QoRCx0IjKzBewStMuyIkHDnFt65X67jDZXTyGX7t7Rd6RFwrs+rJ/70cZ2GbE591VuV+oJigK1+5SS+/0xAnqJuHKleHTuJOB1ofS3MkfrG8YVux3PX85dUorRK9ARuYx+G4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761215; c=relaxed/simple;
	bh=bfJFlUYqH1LxK8gFhAYHxyxtX72qYYgYpKWrk69UFTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNOOaOi4O3eo0LXVii3P+18QFB3Tsqlbg22Hs0C4JtZRowt5XYPbllTjXeYyjtOtjUEHOPSoPFuKuSfs2nVjkGTopi+IJVbZj2+0MbmCNVDJc/JqwwrFhozIlK5P+Fqwi/QOCT7FQkxtU9Aza25BpChAq9wnTYzrnsA05GySQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUL3NfhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUL3NfhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7291F00A3A;
	Sat, 15 Aug 2026 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761214;
	bh=rJTDjNDC9zCQW2iTEGVLfttRQvcQKO7F/RyvJJOQHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FUL3NfhJLJDtFV5DZXyxt7/Cqah4wcRHoMlMyzb5aVPF4bI9CeIXRPa1tS2RTymD3
	 I8RDG4RBvg9JQfp3VFwn7KRAefBD92dHEpDIz3BHm8rBvtMAyg9WnJJi8nCIC4qCW+
	 +RDB2OC4MGVjQqjTbs4paa6/2tYS3YeW3RCMre8uCJH+bBHFXxdD0f8I5aGyriWqpv
	 weJb7zJYzdx2B/dcLC2j1iHAUecElWli9i1fakjcxYe53YONp/SEJYNtOlL8o1p8R0
	 RZ54wMN4fxTzPcNRRvjACc13y1nldpvu02qrFTzmwA/s3jgjuL4i62OH0cRBO4fc0N
	 4eufPEs6WOcFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	harshit.m.mogalapalli@oracle.com,
	gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	andersson@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	kuldeep.singh@oss.qualcomm.com,
	Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH 6.18.y] dt-bindings: crypto: qcom,ice: Fix missing power-domain and iface clk
Date: Fri, 14 Aug 2026 22:33:09 -0400
Message-ID: <20260814193000.9@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812-adapt-ice-binding-for-6-18-v1-1-e224dcf77072@oss.qualcomm.com>
References: <20260812-adapt-ice-binding-for-6-18-v1-1-e224dcf77072@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The DT bindings for inline-crypto engine do not specify the UFS_PHY_GDSC
> power-domain and iface clock. Without enabling the iface clock and the
> associated power-domain the ICE hardware cannot function correctly and
> leads to unclocked hardware accesses being observed during probe.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
