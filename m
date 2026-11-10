Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344394;
	b=rIh9V11EgXrVHEXtFwbMrHGptva/0t1khLjj+dGpiPsgx2WLL2k58EWxqqwKzrujvka/
	 /5oNzGTISV/V20g9llDVphYAcvHRJHnrAtKcZ7Lix1FKqOH8yQFw0yICjWOeoF8UszRmJ
	 JbConuO8BuAhMqF/ruJFIgVzb5Dzp7JGXUQpuzQLgxPjRk2PZatr43IjF2f3nMjtz7KSr
	 cRg8CH4gTfpiQTRnyUHPKA3+aISyfhveXVlwqmLwGQcIUEiSY8jkSKuIknrVXXvvrN/lU
	 rjU5Cm1qvQgOgJbDbuBRVO+pp1aYRxBcfXnuiC1+fyGo3fp8C9SWaRvZpe5rkHoZjWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=otty0BX6J0wXtyMzxhjB/iCHrslx/4D1JT/DQ0ao3OY=;
	b=vQ6WXJ6xbrLRz2C4gCoNcTXLYBuGzLOZrGtB2RxQflJDrG4wbOR6jbUgGNyomAVFFQxl
	 QLLrsVGic3X0lG0tBfjKOQenhV5RtVDCtxf8PmclM+SkXm6hrpAw+i0fuldFxFfXgW2gT
	 xt3GCS1rzu5Ehd2M/cpPCClJ8BYMVMGJ9GMbXROLyJBiCMX3K5KDZdxEIsv8y/cil5MhY
	 q1g1mfJ0HnbVjbkAqZzNHtoSvu8V18SJfoGEWR2BiGPMq1yJ7hvR9a6zOenViuY2cdcEA
	 bfqb8ww7kgJeb6+Lip+KVKwNDrEif/41wOjUpHUXJ4VbeOW6puRoPcAvBnbpE4G9egg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1KNBc0r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9560A2601
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1KNBc0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF6F1F008A2;
	Tue, 10 Nov 2026 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344393;
	bh=otty0BX6J0wXtyMzxhjB/iCHrslx/4D1JT/DQ0ao3OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1KNBc0rbVvMs91uwV01B98vteJxpgnYBLB9xSP3zKAQ39Vl6GDF5od2Le0DEcnEy
	 gM6iaGkiiIwzqQNR8FBcrwSsqTsTqUrMOincrj7AWxz3kTMeX/DMc+gEFR5/6DGhqP
	 1MQKk40peoTkLucW2E6hjUhr2Lf2g0SedmSj1BckOjnlUO8hEBFs4X0D4Ddsci+jfF
	 0HVg8uTSWze6nd5h4z0ToiGTxv7TKYv/ezZUVd9hihzF1CqNvOJx4L8DIZUHpiWAdw
	 wNkp0MYCxipmgRJYLwxcvP6zy8YFDCSlU3UffmQur76kIRCzDHVWzyjKr6VcLa59cT
	 /AxIhM+5r5Mug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 7.3.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Tue, 10 Nov 2026 15:59:17 -0500
Message-ID: <2026-11-10-1-daily-reply-0021-batman-roam-adv@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184240.44536-1-sven@narfation.org>
References: <20261110184240.44536-1-sven@narfation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> batman-adv: tt: send ROAM_ADV on each roamed back client

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
