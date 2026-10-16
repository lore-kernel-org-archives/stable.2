Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38331494267
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177833; cv=pass; b=PO9+WANNrjBHjeLCDWayM0EKyJ8g3iwcgsqkqx6/kJLKdnxQ9YF00COfS0xdcCLKe8l9KyuMUTCAqRaNYwhb4H+AQmGxBxDj5vbufl35NX0mlBv7RdqrRhvTRrBKqjHcftqHUAnIo8JSHPeaE2Plmok/36CYTm6K01H0gwfackU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177833; c=relaxed/simple;
	bh=YRuIJ7ABSAjb+0Jp3iDXWI9Qs8U7wYfJJywbYqc2tYc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=U9Zrelee5dX4BC2lcWvYrkEC4CcTwV2kLInIpqRLfIDeS6BMKWypDniXgw66HuzbJVHHk0+vyw437qv9nLmsRq7G18AkbVseamehD0E/rGcEES817rvGOa42djWwCcoeOqLuWGBB+EAVI+PytITBjRKSt9Mhbf1QcIAlnaYloak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=harin.net; spf=pass smtp.mailfrom=harin.net; dkim=pass (2048-bit key) header.d=harin.net header.i=me@harin.net header.b=VaNHusTi; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=harin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=harin.net header.i=me@harin.net header.b="VaNHusTi"
ARC-Seal: i=1; a=rsa-sha256; t=1792177823; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c5LD9eOT5qQKk0Bqdbj5jh0oMmndXxK6F5nTRnUhB8HAxTg7i64updREBHB6ONkmgMnGsGS5G+1FlrYrdAG5sN8c3bpD+5EAhU9ZzSpPbasfCFEpf/EVPknRa4gX1a+ELVCY+Z0DVqJ5VnQomAmQkCY3RwTfyP2c0fIoD/z1nQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792177823; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+VPkHJ00/ZjzLiauT1BBnwcp+TNa5dMCt9O24IznZVI=; 
	b=iJ5PVjgKAVvNpg7YcrLeedvD9NBc2so3v1SgXkK8LDH0S+oGzzzBw9i6dn5c+Y1q8y7IqiI4zWtp+k7CQ3e5NgiCZMVVcMvQOsUIW6S2HxT0DW998/Dk3xvy8piVFZFIg7UId7hBtA+k91vrqLUGnV/Ee+cRfqTDJrJvRk4yGME=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=harin.net;
	spf=pass  smtp.mailfrom=me@harin.net;
	dmarc=pass header.from=<me@harin.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792177823;
	s=zmail; d=harin.net; i=me@harin.net;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+VPkHJ00/ZjzLiauT1BBnwcp+TNa5dMCt9O24IznZVI=;
	b=VaNHusTiKsXuieBmk4IG22DForoelLKDSbr4n3cbDyq5fzMviDwLOKZq450aPElp
	QTfMUW1hYyqfXIxreg/u64wH0B9sMhZeX1IBqtSucMxhnspAJ9k2+1MMBI5VrGTOGUM
	oaUyS1OMZrtaGzsnfI2S3Pmb1pcmEElV0apqwxEGf87XqzILXzhcVMrLjcWqgTX9Jj4
	SlFp6FOfk+UpRlgXraSo/l4tFNjJjRrU5zRaTLdt0/AFIQP7AEiJW7hz/3CtgCsLWWh
	XmYGLxs9XJdFeGzG04qTJNdmQWizQrd51a88oBJ/sty08XnYvjXk0CTSFgqf6zmiRcU
	Qh844eoD7w==
Received: by smtp.zohomail.com with SMTPS id 1792177821338110.5468354298498;
	Fri, 16 Oct 2026 12:10:21 -0700 (PDT)
Message-ID: <e5b53e3f-02ac-4afc-9fa1-823ddb80875e@harin.net>
Date: Sat, 17 Oct 2026 04:10:18 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Harin Lee <me@harin.net>
From: Harin Lee <me@harin.net>
Subject: ALSA: ctxfi: Regarding recent stable backports
Autocrypt: addr=me@harin.net; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

I noticed that some patches from my original ctxfi patch series are
being pulled into the 6.6.y, 6.12.y, 6.18.y stable branches as
dependencies of the error-handling patch (277c6960d4dd).

For 6.18.y, since these changes have already been merged, could you
also include Takashi's follow-up workaround and my subsequent cleanup
patches? Without these patches, some devices may have no sound.

75dc1980cf48 ("ALSA: ctxfi: Don't enumerate SPDIF1 at DAIO initialization")
c6cd83cceec5 ("ALSA: ctxfi: Rename SPDIFI1 to SPDIFI_BAY")
07b116b44e52 ("ALSA: ctxfi: Use correct DAIO type for da_desc")

The relevant part of atc_get_resources() for 6.18.y should look like:

...
for (i = 0; i < NUM_DAIOTYP; i++) {
	if ((i == MIC && !cap.dedicated_mic) ||
		(i == SPDIFIO && atc->model == CTSB073X) ||
		(i == SPDIFI_BAY && atc->model != CTSB073X))
		continue;

	da_desc.type = i;
	da_desc.output = i < LINEIM;
...

For 6.12.y and 6.6.y, could you drop the following pending backport
from the stable queues? It is adding new functionality from my
original patch series, which was not present in these stable branches.
I don't think this change is good for backporting to older stable
kernels.

a2dbaeb5c61e ("ALSA: ctxfi: Refactor resource alloc for sparse mappings")

Thanks,
Harin Lee
