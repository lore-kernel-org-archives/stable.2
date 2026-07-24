Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB73D9527
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883246; cv=none; b=Plor1clWT44HZUnnyMfRiRmxLiD/hnxaVXanqmqaO16cA37H5Ak4xmG4CzN5+skfzQzce/DmKbXW2VVRgewQthik9xdthOBn+AUi/MR0C57Jp3knPkJqwCuJWo0jnABsTFOqawy6RJg8ZxfbtzL5o13rC4nFLx1J/Vp91s+fjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883246; c=relaxed/simple;
	bh=qiSw3CXe6ef0GHW7BD1P2DpoPSYO2C7MYTBIkWemKhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTwvG8rb6HrmkynU+4B5L1eaG3VaEvLSOA0TGhwc7S2MZJTmcaFNlIkklAxboK0u6i4Jx431OZaUdFgdZzb5geoSqjpDQQI9zKM0bq02eblhbgCtbzC/Gv+3jLfsAa9Wmm7bQOkwxVz9uf43/4hSniZeMREmqOLNnnqkl7wBGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQ3ya7CD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQ3ya7CD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA89C1F00A3A;
	Fri, 24 Jul 2026 08:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784883244;
	bh=twsuHtSOerpHG3MI0oz+x6trjYwSDpyR6qrRaE/78iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DQ3ya7CDxs2u2aX9B4ZQFUX7ArctG87u7rkhfkMxpUuwQ6tOgfxg/bZYgiI+7rS98
	 aOoodw0hoJw1ZsQiYc7SSKfL7JT9J66QHiEbqNYAXYKvKJP3DAW722GmoTlmTGeE43
	 AKF8OLFHeIPE/L2Syh4grsbw85JXmOmTZVhlmyoA=
Date: Fri, 24 Jul 2026 10:52:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed
 to apply to 5.15-stable
Message-ID: <2026072409-schilling-scheming-5aa9@gregkh>
References: <20260724083756.12430-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724083756.12430-1-socketcan@hartkopp.net>

On Fri, Jul 24, 2026 at 10:37:47AM +0200, Oliver Hartkopp wrote:
> This resubmits "can: bcm: add locking when updating filter and timer
> values" (commit 749179c2e25b95d22499ed29096b3e02d6dfd2b4 upstream),
> which failed to apply to the 5.15-stable tree, together with 8
> further bcm.c patches from the same upstream series that build on it
> and would otherwise fail for the same reason. This is the full set
> of 11 upstream bcm.c patches from 7.2-rc3 minus the 2 already queued
> by the normal stable process for 5.15 ("can: bcm: fix lockless
> bound/ifindex race and silent RX_SETUP failure", "can: bcm: add
> missing rcu list annotations and operations").
> 
> This assumes the 2 already-queued bcm.c patches for 5.15-stable have
> landed by the time this is applied. If not, please let me know and I
> will rebase.

This is a mess, it showed up like this in our inboxes, with no threading
or information about which patch was for what tree at all:

   1 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()                                  
   2 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 7/9] can: bcm: fix stale rx/tx ops after device removal                                                  
   3 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.12.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.12-stable                          
   4 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.15-stable                          
   8 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 1/8] can: bcm: add locking when updating filter and timer values                                         
   9     Jul 24 Oliver Hartkopp (2.5K) [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
  10 N   Jul 24 Oliver Hartkopp (3.5K) [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies                                   
  11 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.1.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.1-stable                            
  12 N   Jul 24 Oliver Hartkopp (6.7K) [PATCH 3/8] can: bcm: extend bcm_tx_lock usage for data and timer updates                                       
  13 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 1/8] can: bcm: add locking when updating filter and timer values                                         
  14 N   Jul 24 Oliver Hartkopp (5.2K) [PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops                           
  15 N   Jul 24 Oliver Hartkopp (4.0K) [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal                                        
  16 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.10.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.10-stable                          
  18 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 6/8] can: bcm: fix stale rx/tx ops after device removal                                                  
  19 N   Jul 24 Oliver Hartkopp (5.2K) [PATCH 9/9] can: bcm: track a single source interface for ANYDEV timeout/throttle ops                           
  20 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()                                  
  21 N   Jul 24 Oliver Hartkopp (6.5K) [PATCH 2/8] can: bcm: fix CAN frame rx/tx statistics                                                            
  22 N   Jul 24 Oliver Hartkopp (3.5K) [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies                                   
  23 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 2/9] can: bcm: add locking when updating filter and timer values                                         
  24 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF                                 
  25 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 7/9] can: bcm: fix stale rx/tx ops after device removal                                                  
  26 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()                                  
  27 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF                                 
  28 N   Jul 24 Oliver Hartkopp (4.0K) [PATCH 6/9] can: bcm: add missing device refcount for CAN filter removal                                        
  29 N   Jul 24 Oliver Hartkopp (6.5K) [PATCH 3/9] can: bcm: fix CAN frame rx/tx statistics                                                            


I'll delete all of these now, and can you use 'git send-email' or some
such tool that properly links emails together so that we have a chance
to be able to apply them?

thanks,

greg k-h
