Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.125.139.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918993;
	b=tmy4EvurqyAC+ygm84tb5qY4FlKx5exQzIGQ4bX2fYELqPE1caZIh0tcEqzPILtjBEFn
	 pKO8PFweKeA96K6lXFoam24YE2UTw+LRYrFbxFAbvRNMycdOm3iUwvHZea8g2qDXeSOlX
	 B5TZGxZh52NJNdrwAVCuQ1XK3k3gDCB1U+nHQgu43lVpg/dfXAIp70SNKUYIv38Z4T4FN
	 VpALbqXhjBUJt9sP3vcSBxjWk74JLAfl0qV/333r2Kxjy3JK3OZiLPiYIikHNsd4m7yEn
	 8ZsgvM0mkoztsS2dCRwJep6mkDdMi8OWBHhgZaKi0eG1hOaOnvr8S+10cEQ3PUzn+8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=YCCwTw1b8nC/676mldMf21YbE+d2YXPgrhLxfHmgduQ=;
	b=cozqWdW1pdpNX1G1XAxDH97myVp8KUaNCUEfboP7aONsnjGt59YL8AUcv5dT2blFG5j9
	 KGgweR32u7QmcyZ8SDHqKRvANPhyhS0mP7wjBNSwPQmrMRB0HoNueg0TrZpEcF36UadSG
	 ZFnyuNphhQX1FzSFZNmGa6AkdGcge26Y1X3DCwsc+3Cp8C/xl02Uh3EQgSmI8hQlZ7PPW
	 dFboixZihM00KH8QPCbCmGGmrHqGfFZPkjeQJjIUZLycv5g0vFZBfvEZ58M5ZlN+SGvaK
	 grdfkLF8QYKJ6kwj2a8FoMdBqIbG3i1UqFAc59XRfDsZfA+Dcabm5o50Ek5tvmxpMpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sony.com;
	spf=fail smtp.mailfrom=sony.com;
	dkim=pass header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=h3qUNoQC;
	arc=none smtp.remote-ip=211.125.139.72
Received: from jpms-ob02-os7.noc.sony.co.jp (jpms-ob02-os7.noc.sony.co.jp [211.125.139.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64B606A33A;
	Tue, 17 Nov 2026 12:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D64B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=s1jp header.b=h3qUNoQC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1794918988; x=1826454988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YCCwTw1b8nC/676mldMf21YbE+d2YXPgrhLxfHmgduQ=;
  b=h3qUNoQC2k/Ugu6nTx6uMRmUlB9VRSnRo26jvezJ9ljrdScbouKa7Mlo
   Kdsdfo+qzHfVrGwFoLYHMQd7PFvF7Yk1F7gTCpr+jV4FeF2aKsquqVsR/
   DQN/bGVff3KypnNk8EL3T+hG3bSZzk7d+u0Hdq3yHNhssHTQLrwlLWdAa
   zwgiavZBpmpu2cBl0YGss7gkWDbQ6ULKl3BzBbe62nrQAiVBgHTwhrKnU
   fxNF+J6OV72XHmwlsjFSuxzW3PPbR1I6Eb7Li4qhxNSy3Tk+/N7bJmQye
   wKfOw4PFi8wSkTQMrxDgf7iEAcXajOUlEVMaZVwPMUbR/8X9mUoEosEHu
   w==;
X-CSE-ConnectionGUID: NzDsvF0pTD+V0+fCneLbPQ==
X-CSE-MsgGUID: YEQsx7mPTEqfWnEV8HRiSA==
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob02-os7.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Nov 2026 21:36:20 +0900
X-CSE-ConnectionGUID: JZ/D7hrhQVaD8UBQVwoXlw==
X-CSE-MsgGUID: bMIQcZ8yTwmfVY+55+JU9w==
X-IronPort-AV: E=Sophos;i="6.27,166,1786978800"; 
   d="scan'208";a="71116498"
Received: from unknown (HELO jpc00229873) ([IPv6:2001:cf8:1:519:0:dddd:790b:411f])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Nov 2026 21:36:20 +0900
Date: Tue, 17 Nov 2026 21:36:10 +0900
From: Naoki Matsumoto <naoki.matt.matsumoto@sony.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chenchangcheng <chenchangcheng@kylinos.cn>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sasha Levin <sashal@kernel.org>
Subject: [REGRESSION] 5.15.y, 5.10.y: media: uvcvideo: please backport
 5b9c75c794ce
Message-ID: <avxKOmxCBLF+7qdT@jpc00229873>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I use a UVC device of USB3 at v5.15.y. I found the frame rate down with
the below message after updating stable version.

    uvcvideo 2-3:1.3: UVC non compliance: the max payload
    transmission size (1729) exceeds the size of the ep max packet (1024).
    Using the max size.

This message is from by eb6059474e70 ("media: uvcvideo: Fix bandwidth issue for Alcor camera").

    5.15.190: eb6059474e70
    5.10.241: 3eaf16ff8165

kernel-5.15 supports usb3 of course. This problem is stream->maxpsize is
not support usb3. Since this function parses it directly, USB 3 support seems 
to have been overlooked. I found the patch at v5.19

Please apply 5b9c75c794ce ("media: uvcvideo: Undup use
uvc_endpoint_max_bpi() code") to 5.15.y and 5.10.y.

I confirmed that it cherry-picks cleanly and fixes the problem on 5.15.

#regzbot introduced: eb6059474e70

Thank you,
Naoki Matsumoto
