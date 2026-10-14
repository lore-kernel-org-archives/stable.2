Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F42474246
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969229; cv=none; b=jhRn3KPDxd/1+wCvtWM7kX7WJ1XpKLcMkSshcCcDqHxCuov5Z8XxMZDSEVbLZ/XpatTjbglAVdyq8bKdSnF84jepBUYFKMRB7cZAyzctASS23VU39zo36TD8HnIpCzp2D3syAnEoI4FdL3uRaCAdmny5Tt3KvZa960BBvWu0qqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969229; c=relaxed/simple;
	bh=oA4tFtMqs14J1OHw0hiEwTe8Icz1MDK1KJbF38IMy/U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CV/5Nilm+nMzejmwyWxdELKkLFjhd1frrIaxaWCnAcJ6mqTLs6O0TFY84PvmubB4lbj0R2XWn1QHfzrdEyqLgc0oG2nrOh5CUsZJ/qSnahcNkhFYvra6fQeVvkXb78j3UnGu9z1KG44NSX3lyYUjw39vu+TscqJUje/+QZRmrh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IzusoGSn; arc=none smtp.client-ip=95.215.58.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IzusoGSn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oA4tFtMqs14J1OHw0hiEwTe8Icz1MDK1KJbF38IMy/U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791969224; v=1; x=1792574024;
 b=IzusoGSnDPfv+DDZ94tQpTYjTRqM/HmU+O23gY0gIz9mLl5KhtUVB67K/9yahZrKKww6WhV4
 sNCOV6foJaKpzxxQnX88MBtQnb3/1Y7N+7kIlXKdNBBFU+FvjdqLdTv4aZbSBghjRxOq7QJgTUj
 lZJf5iIqlfFZy/KWv80hmpfo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a13822d5b20933bb;
	Wed, 14 Oct 2026 09:13:44 +0000
X-Mizu-Trace-ID: a13822d5b20933bb
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 09:13:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <30d573f3dacbc0700605a29ef8ce1f4cd9c5dc8c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next v6 3/4] wifi: rtw88: sdio: Fix unhandled RX
 request interrupt storm
To: "Alastair D'Silva" <alastair@d-silva.org>,
 linux-wireless@vger.kernel.org, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, "Alastair D'Silva" <alastair@d-silva.org>,
 stable@vger.kernel.org
In-Reply-To: <20261014074426.2183095-4-alastair@d-silva.org>
References: <20261014074426.2183095-1-alastair@d-silva.org>
 <20261014074426.2183095-4-alastair@d-silva.org>

Hi Alastair,

October 14, 2026 at 9:44 AM, "Alastair D'Silva" <alastair@d-silva.org> wr=
ote:

> On 3081-based SDIO chips (e.g. RTL8821CS), hardware does not automatica=
lly
> clear REG_SDIO_HISR_RX_REQUEST when the RX buffer is empty. Masking thi=
s
> bit out before writing back to HISR prevents it from being acknowledged=
,
> causing an infinite interrupt storm loop that locks up the system.

In my opinion, I would reword this first sentance. Your own probe shows t=
he
bit does clear, post_drain_hisr comes back as 0x00800030 once the FIFO is
empty, so what the hardware needs is the software acknowledge plus an
empty FIFO. The old code masked the acknowledge out of the writeback so
it never happened, which is the failure the second sentence describes.
As written the first one reads as if the bit could never be cleared and
the drain did not matter. The fix depends on the opposite reading.

Best regards,
Luka Gejak
