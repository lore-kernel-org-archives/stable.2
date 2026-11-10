Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.13.36.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298805;
	b=5JHt8FzEaH0JCWVKAbZdfIEHGKxBGtzqCN3AqDitueXlYC9zoLoyf+prQuoOVfdJbQDR
	 qHCLIXNglWbRyVSXmPNSvnOBHCJVB+GuXgj8w9N3LxJD0KMn9NJlNL4jFFXlYeFicbI9S
	 z946MxryoVy8Qvezm46CEBdHSKJYy5HNlR0dYiWgDT2yJjiOK6mRpGiX6VQfVKJEADNLf
	 dv9N3iRAiGCHyH3VtwR8zru7jq9WDw3h5vIYBLHx0W69sHbhfGhTHfPyHG7IbK79e+g+v
	 p9rWQPfFqRRQgrf3h5Ml7E7GZv208R+qcMEMGxcml82ui2P28u4pY+QFlRSdL/wfpKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298805;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BwIHpdE+xgxXaWtsJRsjH/VFAQazTWJ4GCATHhX63qc=;
	b=qWo/NDquMpCxvCr6Ke0JTYrefkBlfeuoF8h0yEMYR0+UZo7QW1EWR4PFVHPwpq2pPoHZ
	 0HKxixaxxXHNWbsXFTTLB1BHX5+8RyT7k8kphNSEplN1bjX+3mezBBH7jv+W6CrKI7ovH
	 DpE2MFyU+/R8PJ8HOsKZT8a/SUVOji/INx9ZP0Uu0NbgG8ToDtWDJwgsYvxk+dkPTfBGk
	 ZJ8tOtAbAQR/zsppSK4omem7mBbkmHSd7djTiVCT7FtpUFUxnyOOcWPOVU7S+bP8701Aq
	 kbpn3K0+pWzrCiz1Qz3ne2jsyAO1FxsVviNnG+fUNuI/F7TFnwVOzwNuwr5qkufNgWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tecbeast.gmbh;
	spf=pass smtp.mailfrom=tecbeast.gmbh;
	dkim=pass header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=rsa-sha256 header.s=mail header.b=Q22fl9yA;
	arc=none smtp.remote-ip=49.13.36.206
Received: from smtp.tecbeast.gmbh (smtp.tecbeast.gmbh [49.13.36.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC24606A325;
	Tue, 10 Nov 2026 08:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC24606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tecbeast.gmbh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecbeast.gmbh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=rsa-sha256 header.s=mail header.b=Q22fl9yA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tecbeast.gmbh;
	s=mail; t=1794298801;
	bh=ACqy4zmqYt1x+ih2C5AXeNzO1+1/kWKPdhA2AaQ7tTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q22fl9yAnng9tpUaINqOg+sMtWPVLuU0eGJYxzyCkDAlerxoafCkeh2m+vz+8E5V5
	 wB4TQAJA5UfF0b6IMZBiBVcJwyLhp/tAN7PrCWoJdHjJIRz39AVe0CiAhZIJ8SAD04
	 4vF53cObsmVQodj1Dj2djB4IvSWbvZXW2aauyia0=
Received: from [192.168.2.10] (unknown [91.106.186.171])
	by smtp.tecbeast.gmbh (Postfix) with ESMTPSA id 6962611F805;
	Tue, 10 Nov 2026 08:19:59 +0000 (UTC)
Message-ID: <71332274-ae9d-4d2d-bbc6-22c559102c4c@tecbeast.gmbh>
Date: Tue, 10 Nov 2026 09:19:58 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add NO_NCQ_TRIM quirk for Samsung PM893
 (MZ7L3)
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109134541.3766394-1-tobias.kriebisch@tecbeast.gmbh>
 <avHfKaY-skamodEr@ryzen>
Content-Language: en-US
From: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
In-Reply-To: <avHfKaY-skamodEr@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

thanks for the review.

On Mon, Nov 09, 2026 at 03:56:41PM +0100, Niklas Cassel wrote:
 > Please boot the latest kernel, 7.4-rc2, and verify that the problem still
 > exists.

The three drives hold a ZFS pool on a production server. OpenZFS does
not support 7.4 yet (the latest release supports up to 6.19), so I
cannot run 7.4-rc2 on that machine, and I don't have a spare machine
with this drive and controller.

Would results from the newest kernel that a released OpenZFS supports
be acceptable? On that kernel I can test noncqtrim and nolpm separately,
and then boot a kernel with only the needed quirks and no libata.force.

 > If the problem still exist on the latest kernel, apply the minimal set of
 > quirks needed to fix the problem.

Understood, the v2 will only contain the quirks that are actually needed.

 > And yes, build and boot a kernel with your patch to verify that the 
problem
 > is actually solved.

If testing on 6.19 is helpful here, I will build and boot 6.19 with the
patch, verify that the problem is solved, and send a v2 with the results.

Kind regards,
Tobias

--

