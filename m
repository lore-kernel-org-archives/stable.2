Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785779;
	b=Yui26IvIXk21tKZTpSaxxCUYrRP9MHCfHBS5s5faoOXbbw7lXpVZRS2LRKn21ww0V/4n
	 vrXcHbMCwGf9hcEdarMBa9t1dEO+Zk9Hxwah1ECXk9VQ+71fEksDWirH4QexLnjgV0tkf
	 NDvx/EdLzsqQDabafGSs6tHKrFJR7SAQ2wjvAgtQNIiCiiSISikOiuRMeIHKPhKPW0gWC
	 QyaVqTIqWztM/LElq4hbBxctyQxcDDNqX3mjYNSNyxStt083bzvIDjD4OpZ5qvkPKTHT+
	 J2eNhW26zEsp1NZztFsvVH9biIxgvgw4i8CchPD9/hLA++s2Fmcpp6rKgjxLsyX446A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785779;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qVbVHShFGuXLiuJ/BjESZDoClwoj5s7WnS5aGbLBvbc=;
	b=XAggjpXzmEAsbEq0OTPFwCGz6X4sONxaVK3WDE7kz3X9m5b2B6xfBJ9d1sdqAk+TFI2z
	 wPLCj9uVwB5ZoUMs36sXte1g/Sl15JRoyKX32ni2tZJbqesMOvy38yF0NLizPCYIFVOgs
	 EwNrjwnyVraTz8x9XVwC+Zhnu52Jbc06RniuAyRGpsJmKurEFI8V2XeJQwB9dfbkKUMn1
	 BpOkNIb6pBB4bVtQl+hlCojX4foSme2veHXt3QYcqXXZ3XvyWY7dYlkrZyHalVp3B1Fkk
	 Yz84dQGn8/7wuQjz+aiyPpItzVpA8Js1+R0Mq3w9biNeVJpvR1Z6hiwXh4prhw/aKPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1opOWzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C2606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1opOWzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BF21F01828;
	Fri, 23 Oct 2026 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785778;
	bh=qVbVHShFGuXLiuJ/BjESZDoClwoj5s7WnS5aGbLBvbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1opOWzibZqTDGznYME7HDUqol14AAqcDhsB3oNg2wybZ2mpzj4Ts4968fC062LHK
	 40Rvynw6mwFYCxTVVd+QNDiulrIzpp6UEbYFV6hIt5nmEcN0JzSP/OCU9BClGz2AaS
	 mPb1L06zdNL1WQFOVpMZoIoMULQqx6VzwUcjt1zvA7a6LBiLFh+wzYiY9BlMzjEFry
	 lv6H5doPWgwYEUslwxxjppSEawfW90QGXQK2NCDkQtIUDzeLWpHA+nS1FCvyM/JZUd
	 Sd48kdDztw8yBu8pYXvVR6+INkVMY9w6Ak3wfHG5wr8UnY53YcAgNgZQTTz0BVlmt9
	 cBwc+vZoprKkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dingisoul <dingiso.kernel@gmail.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 6.1.y] scsi: st: Fix use-after-free race between st_remove() and st_open()
Date: Fri, 23 Oct 2026 16:02:39 -0400
Message-ID: <2026-10-23-1-daily-reply-0003-scsi-st-uaf-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021155537.2740297-1-loberman@redhat.com>
References: <20261021155537.2740297-1-loberman@redhat.com>
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

> st_remove() drops the probe reference on the scsi_tape with kref_put()
> and only afterwards removes its index from st_index_idr. If that was the
> last reference, scsi_tape_release() frees the structure while it is
> still published in the idr.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
