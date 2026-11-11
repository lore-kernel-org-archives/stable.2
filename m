Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439807;
	b=wxxpD3CabMDvjyZk95bfZemczxM2hzC//1FOsXlT/JgRq0J7titzUmdR3TrQ6QGsWruS
	 zBbn0RsyBljLMgvzbeFjzcfQigEhZdmQdGOydsdtQCBrXormy5ZjKbDUUgwmg9Tq8vHGI
	 GbztgcR/aVvL9rN+zQ7p8QmsvdZs5kXMv0BniEmckuz03yFXujZLaJ1iEIWuwmCHWUr8G
	 tzwu+yvsFXYA5R8dlcdvACOAHXCLbYMwTjcEiSGDCETj9W+GRCvQy6kKFBZP4rZq3uBQA
	 GCN2uVmmMfFQe6x/F5aBH4FKcpPfjBW5vwiS+VWTJY2ZhdoPq0S+OZTem8LUYBJVgiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439807;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d8gt4vss1VJAghWGOTbd3Q31kkkyerJCYC99PqwnhfY=;
	b=B7G1Mjbh+5DeKpMhK3a7QqFrkKwb8A7iy4l7kn0mfFzSfXybpcDuWDsfo71rSq4AEio+
	 Uk/Jr3BQTf8v4T90FEfIVzk/IdccQyP4m0tvW/oYt8R2v0FGYh9o+6+55K2mBIXVSF14v
	 klemGDXNuzHYKbxsBPmrtIAyplS9XJBHdt1K5HEStT2NUpg+CkC+R+U5aQsBqCLTBJxzN
	 ZK8XswfnMix/FB7RKtJZwYwjiB8DGgmb95rMLP8e4ziHYp8iACw4SNFIidkgxYKc9wNEB
	 XSZAWh1BJ0KarrmmXRpYWr6ZZLnFUZxfuHvOycRofrdaTrceHMb0WsnKWekUkovL0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3Xf7DTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642F606A324;
	Wed, 11 Nov 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3Xf7DTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4801F00A05;
	Wed, 11 Nov 2026 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439806;
	bh=d8gt4vss1VJAghWGOTbd3Q31kkkyerJCYC99PqwnhfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K3Xf7DTYCLVLHaDe5VUyzIV0hhxz+D6otyW3n0nrvVQC0ygVy51dTyM4hsYFvKW/5
	 nHzv/BKfJVt3ZyTys+k8pnIl8EyT11iw6w4+6yaWV5koB/3H8y8ODNJfH+hS5Sp6MN
	 LdppUoDvydcDLHnPTK28ApfILrpUoljS8WpLR4SqNKEfUylT2r3pTFcrKfgKz2cJmP
	 CT6wjcGyFFydV+hGyKoffrBgR/+j3c1w0yT1eaSZpJP3uWmDKBq+aHk6cEfrLkzRxR
	 1Oa/d3Dx0iGAkf+dKp/KovjcLuqS9TpizdbZvugffVq0yklvtk4dMvQmRg8nFsx8tj
	 6ULpunjvDTcdw==
Message-ID: <2ac04d8a-5557-4c2f-b009-c0b02773b480@kernel.org>
Date: Thu, 12 Nov 2026 08:30:03 +0900
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
Subject: Re: [PATCH v2 4/4] ata: libata-scsi: fix remaining passthru field
 pointers
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111223133188VjHq0FbmnzuEZWakS-EYD@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261111223133188VjHq0FbmnzuEZWakS-EYD@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 23:31, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> Several error paths in ata_scsi_pass_thru() report field pointers for
> the 12- or 16-byte CDB when rejecting a 32-byte CDB. Initiators then
> receive INVALID FIELD IN CDB sense data pointing at an unrelated byte.
> READ/WRITE LONG also reports PROTOCOL when its sector count is invalid.
> 
> Use the PROTOCOL offset and record the FEATURES, SECTOR COUNT and
> COMMAND offsets for each CDB format. Report SECTOR COUNT separately
> from PROTOCOL when validating READ/WRITE LONG.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
