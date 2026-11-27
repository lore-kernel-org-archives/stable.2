Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798923;
	b=hx+zR5JfHR+rrcAK8SZLy4x5gDy/h++/uRqkR2j8kPhIEb0A4Yl1kZfgCieWjTu/HsIV
	 u36+vvSUJtiI8Xv1mD6n9bBScnZ7zLtUUt11Czb8AYGcOSPHCvBwC2ImQYZB1IsSdG/BD
	 XQjn0Y3wOG0ZYUOV0Aq1voN2BSm6mN99K7ng78ZRiFkZbeJV9vqgd4QaTIMkgQZDLGJZ4
	 Vw3hhitl7AxfNe/UL0PL8+aSaJgST+xdW4Z+PvkpRJZrWRXeyR/YCpdNKVObzu7o4gSZ/
	 JFBVMvZefuhQtaV29z4xSH3pHKWp1IFpgpp6D1nzZaXdgtE4TdenwB1JvO2oVYdpmwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p/tdZN05GP9dAjCct5j+JwM9cgoPvAvp68wrEQEWYio=;
	b=yILwFE6FSKoncLEoIO+DfwF2JnH6sa9eEqDx0W5XYfizev31Uamxg6+VEL6odX/WeuDc
	 AafFJPHTOE5X18vzt/peEzzeCX6hKGjIMl8PIKPFfxLPAxy7JZCF8rVO3AHJh8Uotxsrl
	 jcBTUFQ5GzuYBroF/95n3ETi6QAGapIoYEcS5SeBUko0RZntWZ/ZAgI/qj0p+Vv/kA9ku
	 HBXHI4eDN0xO6gWwFbaeMRBb5tbeXarF4XW6dVOVgfLigR5DW8jP1aqd51EZjCYiTF/z2
	 lBaxYiZ7NuBwnisgFdau9FqF05fIxP8uwI4x35o2Ic9j2E5vQbVJUfNOoKExr1LtrFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8DmxH7R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD20606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8DmxH7R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE11F00897;
	Fri, 27 Nov 2026 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798922;
	bh=p/tdZN05GP9dAjCct5j+JwM9cgoPvAvp68wrEQEWYio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8DmxH7RZSSYvXJlF1U9FaAReNcEdI8zsjLs4ZKonaOI27qjpfeKbGXdBxPle45Nx
	 H2iCYTp2IWEPMvhJ+9NaDK7LbMffuFBUDtSY9diPrSDB70G9/xvggpwWaqmpbQAGZo
	 je3+zL6FVuN1attxGMg6GQNZLvVgI9fUQet2X/Tb3Oe9hSp2lEmnbrcyMCRr/8GlvC
	 5L9vHZreXLZnreMBkvwdYCAeMKos7HERj0iLLOnnfxykpM3hCvpu525YZ6DUrCbaAF
	 nINsBJutsTfGTI+7JmJue7gC6gAovWLZCjPzZ2mUFMO7GsztiV5e6i0neASL6rGsjM
	 k3839gXi67qyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH 6.18.y] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Fri, 27 Nov 2026 12:01:05 -0500
Message-ID: <2026-11-26-1-daily-reply-0017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125150833.340764-1-kapoorarnav43@gmail.com>
References: <20261125150833.340764-1-kapoorarnav43@gmail.com>
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

> GNRL_CTRL1/2 hold the scan period in units of 8192 / FOSC, but
> sx9360_set_samp_freq() computes freq * 8192 / FOSC and mis-scales val2,
> which is in micro units.

Queued for 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
