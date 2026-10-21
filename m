Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576122;
	b=OxAf2WnX1OwQJ+IOZLszGYLWJBmJGlYuxziNV/+65OmiNPGADdQZDOtqsZSveqQGoUzW
	 olR+eYMskvkxH3Y2lL3Zd4x+2Z7QjbtzvALnjis5aW1iKkHH8Yt5I8V6EBwk/64Sm20qR
	 gP6b23qdegTj/UTbIGHBDvGYWkh1JYxisCg0/TkSmNqpHg6krsILlJa3A5SAfNFN6d5dC
	 sVrL1JE/KE0AXaYMy+4gD/k0iySrbpTgLIlQCqzCIaTmZ3/RPLrv0xg0Dqo0daFVTN1Ze
	 Q07PNCTHsaGrdwPkVKw8hZTG5kyUgPsCpXCCOzTunTiORuArJjRvaPDbtOr255fwjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576122;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Xm+Ve/tXN2PYHWw15Ga7Gmdc7Cs7sLZm518+G2Vxh1Q=;
	b=uL7ReUofGhFmvAIPLR2NFSF8NC/G2u3g5KKpKkT1MaaZZfPgtA9KRPGSYR0oF51KmRjq
	 LTjiJXm3buZIINvCa6639q3/q3w/c03XTKIaLuWoIcpQBN/nQS6kq1zk5H1Ixu5+PDFrt
	 lWzwbU00W2nmpiM5t8trhMPftkqqBK7viWYa3SzcLRMud5Nuarj8OZfyK+Va99//6T17t
	 HnxRtTmnva97LPOoPJxKJOwZ6S6iqf4Y8+kiRbIIZkV5qyD+DQBRFPUhoabbGiGsecRjc
	 lreZl7w67qomiybollSdgIfe4TmPYQctGKQHsTFuBYju4YKn0u6WffwZzeJJBEneVFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gXQbmU4B;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE2606A319;
	Wed, 21 Oct 2026 09:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAE2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gXQbmU4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792576122; x=1824112122;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mYqES3D0TXPYP1B4ikr75vrMtc0qw0j02MmovWZ+a6Y=;
  b=gXQbmU4BmgayKc8F/Ob5aCBT/T2fJnSTkkrwhy4IVLndzuWTTQDsWdzL
   N6UePy6A0bkJBbs3Qnzwey4LrzRKqZffi+utaE/9NGUrejAp4401OsZpd
   jlSkn5YUZPliSBlmbvepcmMllNyF0P2sqSHZC+XgPoNgVg7mIrZrJxM3h
   g+vEk1BiWhBSh310OkAm9CR+V573xC45Xo/nHBCDa6QC4n3sUH6qbdbte
   LlBGCEe3B1yMBhNSf8jjFRR2Er6uFhLftHvAQ9RQKldsC5zDwQi1tN/Dx
   Tij9ETqMr3ZrojD3vResCQDmD1e9qlvSZsNxxyMp3cev+haMwnZAW7k7H
   Q==;
X-CSE-ConnectionGUID: l+wBijV8S0qHAb1yFPa7HA==
X-CSE-MsgGUID: Z9VthFNOQcqPhKaNIdAREA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1194603"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1194603"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:48:42 -0700
X-CSE-ConnectionGUID: JMNunso3RSWEVRtxj0YqSw==
X-CSE-MsgGUID: bf5g+90CQ5aaoqBy82Hpbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3039664"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:48:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Oct 2026 12:48:32 +0300 (EEST)
To: Wentao Liang <vulab@iscas.ac.cn>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    luzmaximilian@gmail.com, platform-driver-x86@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/surface: aggregator: Fix use-after-free in
 ssh_ptl_shutdown()
In-Reply-To: <20260917135607.2154130-1-vulab@iscas.ac.cn>
Message-ID: <8cddfc6f-c357-c5f8-dc4d-8209d3c31668@linux.intel.com>
References: <20260917135607.2154130-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Sep 2026, Wentao Liang wrote:

> ssh_packet_put() is called on the loop variable of both
> list_for_each_entry() loops in ssh_ptl_shutdown(), freeing the packet
> before the iterator advances past it. Use list_for_each_entry_safe()
> and move pending packets to complete_p, as their links use
> pending_node, so that each loop walks a single list.

It sounds like there are two independent issues as per your description, 
so two patches would be needed.

> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/platform/surface/aggregator/ssh_packet_layer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 3dd22856570f..871780828419 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1983,13 +1983,13 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>  		smp_mb__before_atomic();
>  		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
>  
> -		list_move_tail(&p->pending_node, &complete_q);
> +		list_move_tail(&p->pending_node, &complete_p);
>  	}
>  	atomic_set(&ptl->pending.count, 0);
>  	spin_unlock(&ptl->pending.lock);
>  
>  	/* Complete and drop packets on complete_q. */
> -	list_for_each_entry(p, &complete_q, queue_node) {
> +	list_for_each_entry_safe(p, n, &complete_q, queue_node) {
>  		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
>  			__ssh_ptl_complete(p, -ESHUTDOWN);
>  
> @@ -1997,7 +1997,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>  	}
>  
>  	/* Complete and drop packets on complete_p. */
> -	list_for_each_entry(p, &complete_p, pending_node) {
> +	list_for_each_entry_safe(p, n, &complete_p, pending_node) {
>  		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
>  			__ssh_ptl_complete(p, -ESHUTDOWN);
>  
> 

-- 
 i.

