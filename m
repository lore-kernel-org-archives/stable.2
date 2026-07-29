Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876E2F851;
	Wed, 29 Jul 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289759; cv=none; b=BVh+yRPxbPKCRa8hyPkfqwyinU0jOMrLhNybA6ctcBQWrhQKMucXu4hue86EJPVbKZCJ1NkBW0ngBZdOSdDKcIeD0WsnnQ2YaLEmYsQyaloU10D1H6AHXqEdxqUOUz8BatyC4eCKUyK5KDobY30Lv+uvkmsNexBrYQkPEsDm/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289759; c=relaxed/simple;
	bh=urwml6ZFYPDCytIWgbLjz4DmPLPX5J/0Guva5Pv4kx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNzOFCpcPYF3k5frPgO6/PZhABwa8r9KNr0Ghf0FYhbv4xuXp2ChVoL7I407bKAMhrpXVt7WAlwN3IbqLZpiTzlI4BU+SI3+UIrOxTwxn0684Tdy0TPPjxgHz3BSBMvufwSE1+RhVhuDTea+DzSk5IkUcI9UGUZvLd5GpvJPTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPiJqSLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPiJqSLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AF61F000E9;
	Wed, 29 Jul 2026 01:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785289758;
	bh=9pyw3W/GQtvmE74CCOK+KwDbDpQSHlFRnAiMSIgOMM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KPiJqSLZgehZreDhFOPO1Q3noUMd67qgU1SI3vG3PDqMB1A/ujeMBqXS3kCcJyMTY
	 fTP25KQnqXNNTqx5HCJELl3WFbDT/SIsqM33U9RB0GOgb6ePbP9l7AjwTzW6qLYk4Q
	 Bi0AnDWk8DM1a94m5Sp5MGGIklQ7Xd8unwD6nFyLNyYFG6F7ckYq6Qu6QdAhLNam7K
	 j3HeuMweyZdixuUjUP710rv22iZ59DDWsS18deRVMJumdwBSUQCju57E1h2tdS4wEx
	 11RdLVxtHSEie95J/4agcxfUQMrxKaAVmu2s3cJ8k2ZFqivroH1s1ItZSQysZzxPMR
	 2lRYC2MiOe8qQ==
Message-ID: <42d66aa3-e996-487f-a44f-ad3d1fd8be69@kernel.org>
Date: Wed, 29 Jul 2026 10:49:13 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() iteration
To: Niklas Cassel <cassel@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 linux-ide@vger.kernel.org
References: <20260728113841.727256-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260728113841.727256-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 20:38, Niklas Cassel wrote:
> The inner loop of ata_scsi_lpm_supported() user the wrong variable when
> iterating.
> 
> It should obviously use the link that we are currently iterating over,
> rather than always using the host link.
> 
> ata_scsi_lpm_supported() is used to control if a user should be allowed
> to change lpm policy (from the default) via sysfs.
> 
> Thus, this bug could potentially disallow users to change the LPM policy
> for certain SATA devices via sysfs.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-ide/20260728112200.B99F21F000E9@smtp.kernel.org/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to for-7.2-fixes, with the message typo fixed. Thanks!


-- 
Damien Le Moal
Western Digital Research
