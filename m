Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC7306743
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841154; cv=none; b=jMzui3Ic25mTzBvPwvAUbrYrG3PMfpodsFEgH54kodbbnZpHQkmKVX1DtuV+rqwJspwFfagaxBUjjDX96k+gfjRd7WxHqdX/Xr2wEGQwA800RSOwelDABxZrcX+OquRhjNHy9hoYORNr2C2zJezq9O656tgcmNshleH7kZPqFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841154; c=relaxed/simple;
	bh=W1L6RapybPqU3GszpreGeXxLT+BoTY53RWrH5Olo6M4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WA8On+EWr2zbryZvdHKl5qNPmc2LshTUkadgBJGssdg3ZTLKqblRp38PiPXBZ9+kO2Sj0nWLLqTxaqFHWbu5Nn6N9H83BZI8TeYF2085GD2kMwRJQhv2eLukCzlo0YxTa6nwyc5zJCqfhzr3pAD1LVVo5X2GE9Fbwad6rXE64UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=B4WbqqPn; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="B4WbqqPn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 724BD113315
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781841150; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=kbd+As49J161UDsoIgPxhFKSYbEO7uz3p2NHD0MBp9o=;
	b=B4WbqqPnSPWK7Fvkxp22YyzwtSkNgXR8mwGlcWksuAJc29frFkeMqeP5ffW3TNtZH1+A4y
	CY9S/VWrxKFVrB3D/MWXq332zYxY35+N53LM0HH1CB3J1PefE/Mbxf3RljMgYVSvq8dkmH
	0RKKGRIxcvOExsJUoLr/dpsUEcw2aLr2McTmLFpwyATopvXe0Lz44++baP8B8mGaNHblH2
	LaXF3Sd3xnmQEM39Kyq6hWZkAO4R7DY+F4f3eTG4KRu1AYN4cv9uwDLwgzWEtD25LV6URf
	3gmZGTq7jZxu+eGLni3q34VqQt0KlHPMFvCbKHjwgBr1ImEJQ62zqaF82FZfVg==
Message-ID: <6b4fb2b3-8af4-4963-aef3-ff55797b9954@nabladev.com>
Date: Fri, 19 Jun 2026 05:52:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-stable <stable@vger.kernel.org>
From: Marek Vasut <marex@nabladev.com>
Subject: dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume
 regression")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Please backport dbbec8c5a79f4c7aa8d07da8c0b5a34d76c50699 to Linux 6.18.y .

The commit
dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume 
regression")
fixes clock enable/disable unbalance on suspend/resume, where it 
generates a warning as follows. This was fixed in mainline already, it 
is missing in Linux 6.18.y LTS though.

"
ck_ker_eth2stp already unprepared
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1047 
clk_core_unprepare+0x1d0/0x218
"

Thank you for your help.

-- 
Best regards,
Marek Vasut
