Received: from mout.freenet.de (mout.freenet.de [194.97.204.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC937FF6F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.204.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627985; cv=none; b=u+yusvxiFWgPv9rHd1iVyUmawnay4MqvVtAmGQtuvc7IZGtSBbRDzTqYOMUyB96zYYD8yhwqNktpV6pz2Q03osdtyVCrn9opwl/xTwPTUZjDaKvV0MAKlUx81AU6ZLRBap35tHbnFvgr3eZwzOGcQ74sD8ZbARAI0v9ceeeiKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627985; c=relaxed/simple;
	bh=Y1vIhrIMTc1jBhis3Y0GEWWlsYHmbtkrhKAoXKpRr+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+ZFFrJKDGPjSoEB/UfvU3Y1cNxVmYTbwL3sS9gF2Fr768dL6r+lfhm+svdSujmKFm0umjagGkibh+wNS4gxsmmWox4YmHkdu0UChKtPmPDoFnaDRPvaIksnFHBzY6kutZ3MrQe104ZLczWpSP6sLaxE6EcFBYJF1zRmwuMrx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=rDjUrBuW; arc=none smtp.client-ip=194.97.204.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="rDjUrBuW"
Received: from [2001:748:400:2319::4] (helo=sub5.mail.fnrz.de)
	by mout2.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.98.2 #2)
	id 1xBI3B-00000008Lsn-0rgt;
	Mon, 28 Sep 2026 22:34:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uelSW4pOUZifPY89Zg/86gM68lfEDgaip8/q88d+NGY=; b=rDjUrBuW2IQmWZ5WDWDeyoGNFW
	6cLwHnmNds0s+ESX2yvy3/MA81r+aWjq716YlQP6wV15EXisx/RJLu7lGyj4Lsqn2F9jqoNfrzA4K
	K0dGJHnu0La0uVS2JtOBJRbU6l/P6D4xbLqIradVcW3wNx6RrGl+w8OdBwgcszmY7zJqF1fepJNoV
	AeAd8x7j56ufbH7xHZca8BG/TzoKMhXYxHnB3jLrYm4BRke6cwX+EK8vTsWw2WGO1qbgluEMdH4Iz
	mrPvDUYuS5EnN+S8CZumUPkm63Fer9fQ0kPI/3nNqG6M3s1qcVmzDydgENJxts4mSFFyNBhUqfFTK
	c/aD4Fcg==;
Authentication-Results: freenet.de;
	iprev=fail smtp.remote-ip=2a02:8071:a85:f020:9d16:c80a:7eab:b776;
	auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:9d16:c80a:7eab:b776] (port=54958 helo=[127.0.0.1])
	by sub5.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.98.2 #2)
	id 1xBI3B-00000008dd5-0DUe;
	Mon, 28 Sep 2026 22:34:13 +0200
Message-ID: <40ddcd20-cd79-4280-b3b3-16782d8b1a71@freenet.de>
Date: Mon, 28 Sep 2026 22:34:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] drm/pagemap: dma-unmap pages before
 handling migration errors" failed to apply to 7.2-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, sashiko-bot@kernel.org,
 viktor_jaegerskuepper@freenet.de
References: <2026090928-daisy-vitamins-0900@gregkh>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <2026090928-daisy-vitamins-0900@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 17906276531EC17FEA388CO
X-Scan-TS: Mon, 28 Sep 2026 22:34:13 +0200

On 9/9/26 14:02, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 7.2-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The patch below *now* applies to the 7.2-stable tree. Sasha wrote a backport for
this patch (see the other reply), but the backport does no longer apply. It
seems the patch below requires the following mainline patches to be applied
before:

c4126f1db36e drm/pagemap: Prevent double migration of device pages
8eae39cd0adf drm/pagemap: Reset migration page count on eviction retry

Those were part of the 7.2.7 stable release as follows:

62451f540c46 drm/pagemap: Prevent double migration of device pages
95d2386a2b16 drm/pagemap: Reset migration page count on eviction retry

I hope I got this right because I'm just a user.

Viktor


> ------------------ original commit in Linus's tree ------------------
> 
>>From 9e6372ec2a3990662ae0a67f56ac0aee19848d5b Mon Sep 17 00:00:00 2001
> From: Matthew Brost <matthew.brost@intel.com>
> Date: Tue, 1 Sep 2026 23:35:03 -0700
> Subject: [PATCH] drm/pagemap: dma-unmap pages before handling migration errors
> 
> drm_pagemap_migrate_unmap_pages() relies on the pages array to determine
> which pages require DMA unmapping. However,
> drm_pagemap_migration_unlock_put_pages() clears the array as part of its
> cleanup, leaving drm_pagemap_migrate_unmap_pages() with no valid page
> information if it is called afterward.
> 
> Call drm_pagemap_migrate_unmap_pages() before
> drm_pagemap_migration_unlock_put_pages() so the pages array remains
> valid during DMA unmapping.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: f86ad0ed620c ("drm/gpusvm, drm/pagemap: Move migration functionality to drm_pagemap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Link: https://patch.msgid.link/20260902063504.3024362-1-matthew.brost@intel.com
