Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42062AF00;
	Sun,  7 Jun 2026 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825265; cv=none; b=kktmLk7fAT1w+Kx7K+igmgeWLzeSRGiE7fJ7ABuLnUbCj7WLoG4gJpRqZLZBXiDGwBfnxvtlgHzP4CIEV6U491M4gBlgYwlgAIYUbVqSnPRf4YptXcn5n4vr7dLWxUZGxpMZUDoHlAvo1odg7l7o/9UaZ32/YrqD968W1I9NlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825265; c=relaxed/simple;
	bh=oBU+hVOHZJL4Nc2u2hWaAGFWZciV2CK/BPbJbmdPQWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmavduMXn65aa7lbdoLBu06XmO+10IwWuEO4L1vzEoNes/HR5Oy5E18cawPV1FnGfHvYUxr5qasepgoD9VdFZMSxQ+FdmWeiKr/vhosiyieZ/ITjyHluYJu1LL5Dj1+V3zcuPLbj+i3aR0AaOCOL1QzsXKljfZnOdMUiq4ofy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxXJyWkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxXJyWkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5D21F00893;
	Sun,  7 Jun 2026 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780825264;
	bh=dQj5Uv7t9KZulzKNARL/h1xIIEJfpiotu+ZxBAIVAjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jxXJyWkYAheaa+HAD8W5RsBp+eg4te2bRDyYEF6DSdeQ1CshV9RPk7PIAzpuVOQZO
	 7FPxskvJfzH6AI155IUpqWnSrarh9/JsM4RsQO/iQHgxNWt3DX3zDt0Sf9X++xjMUp
	 J/gduDQhC1bGsbB68D05l9hxN7jNWCLYGevAX/rVPZx7O1qAuVnpD9GjgwxHReSmRD
	 72BAfOCWd35ovJVFebpIFVkNx29DSm/8RHi+gpnbX8cZwlgJVAKpZgfT4GvgpDrC/X
	 Av9yP8PB6oetxT6lEGeVHzh69SggTN9AQ6m+x7TElCkLGvSTsYolN2f+UdzTVDeWfr
	 rqpya3isueNIw==
Message-ID: <6d6f0792-2fbb-4985-819c-87fa499da4ce@kernel.org>
Date: Sun, 7 Jun 2026 11:40:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-apple: Prevent shared tags across queues on Apple
 A11
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.26 08:10, Nick Chan wrote:
> On Apple A11, tags of pending commands must be unique across the admin
> and IO queues, else the firmware crashes with
> "duplicate tag error for tag N", with N being the tag.
> 
> Apply the existing workaround for M1 of reserving two tags for the admin
> queue to A11.
> 
> Cc: stable@vger.kernel.org
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


Best,

Sven

