Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF18462;
	Mon, 27 Jul 2026 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116924; cv=none; b=TcOhvQqwPHgU9eVcCRuZHyq7/1YxoDgUvvTP2kXgcW9Fuahnmx340oCeeoswoUrayZTlAyEf18Ctic31cMWhrakkqY5WGm63flPtpZD+n7MXlLg7jyfA77LbQmtusCyzPJhm6hgCUzUO3N3NENj7s1Syp2MVjWQn3ETM53pEARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116924; c=relaxed/simple;
	bh=fn0ybXLscXyBMRVMwE1yE2QATyt7aRVVmkUea1LVS/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upXaBSBW/hW/01jGEBS2wyxLWA8nvdPnnQSD1X55KUaORM2lQzJBFJf6DcijhcKufbBuRQWadZyy8eP7kkQ5pkHtwP9oeqtSAs/OU9iJpiKk0iQCG2iJLt8jZyDvXr3RnTCZFAL0sUCSqnNnUq31iJOT6GBp38AqfMLIHXLTZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9byJ+kT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9byJ+kT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C9E1F00A3A;
	Mon, 27 Jul 2026 01:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785116923;
	bh=J16DiFtJTL/WeFkDSwaI6fDf5nafo+oCyc7XPXRXfvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c9byJ+kT5sW1al8hmceUTHoS3sROZV6sdya1M9kOXOgbY2JHgRJknYFNgDtVLdcx4
	 XCefo7jn13v/XSB2c2VZw83iumnkTbLGJ7SME+4gomV5ERg7NLE1acp3sZXLZQhCEj
	 wOUCUFhq0XlJ8DgoFaytLyGUkY4vAEoKUmCjy+b5bwQmOKX6j7wiJkaFlVVb2o0v0R
	 YM5K4L5pD9r7Zln1JQVhk64ZTQjTwyxAbUSG3p3J19rA7i1GRqVH4EhomQDX47W4JM
	 Yh9L/i6BQXAnSUmlu6Up+JIStpfTgnPDzKC113hvjsrvrccaSvS5qG8PZcRN/yYNYE
	 WoZ10kp1fyBSQ==
Message-ID: <838ba900-1510-4fab-8ccc-3331ffcc332f@kernel.org>
Date: Mon, 27 Jul 2026 10:48:31 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Increase STANDBY IMMEDIATE timeout
To: Matt Vollrath <tactii@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260724073942.1751381-1-tactii@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260724073942.1751381-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 16:39, Matt Vollrath wrote:
> Correct a previous change (see Fixes) which reduced the standby timeout
> from 30 to 5 seconds. Increase it to 15 seconds.
> 
> I was troubleshooting an error spotted during system suspend:
> 
>     [ 1217.152867] ata1.00: Entering standby power mode
>     [ 1222.322948] ata1.00: qc timeout after 5000 msecs (cmd 0xe0)
>     [ 1222.324010] ata1.00: STANDBY IMMEDIATE failed (err_mask=0x4)
> 
> This drive is a Samsung 870 EVO SSD in good SMART standing, and I wasn't
> aware of any reason it should be taking so long to standby. The issue is
> intermittent, but I observed it sometimes taking 7 seconds to manually
> standby. I assume this was interruption of background maintenance after
> a power outage.
> 
> As a desktop user, I would prefer to wait the extra 2 seconds at suspend
> to let the drive finish its business rather than drop the rails from
> under it.
> 
> The change from 30 to 5 seconds was implicit when switching suspend
> from START STOP UNIT to an internal command with no timeout table entry.
> No reason was stated for the change.
> 
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: Claude:claude-5-fable

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
