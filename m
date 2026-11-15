Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771477;
	b=SkYdmnBBT63v02Cfitt6Nmv2fcCIqWcx7gLCNCVnW8zrzqYozxMTnQ3daClndYKptwQ0
	 lWv0JGgezMAEZPsKyVyM12dhgUuBxTxpR4LJAxcu77Q3341AqMb0SrECNh0sR497yr/kA
	 ljCbN7gNU/SN8SAYrrAqpojDK4i7u03WL0lEFg6CrUcf05H4UfroogtPsDUt9bYhdQrmG
	 cj9GbH29YoGSKRXcgPXeLYLhAVLQIxXULVNWDUMrc+AUi6K0YLA0B+hma2PrIQMds1kw/
	 dbZcBBrzBM2TsilUYNJJ2fjmsLYKn5CkHzp74I8YAypvAzPYlwOwbYWvk5n3YSQqhWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771477;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=isEsQrrx0hL73b1p5Jr6MlaLz4dtBNblQFsunuEj6v8=;
	b=ekpF7ekvyOajQXE/vXp1G3tPRu7r2q6nSBNFHmYb71XnbNJ26ftrYs2OoFkyhyPqSAIb
	 4DIiCbny6ReBWvhVJHq8avZrlFs6yzYiLxe27qNcf0aRpgSszbAZFcMbdeiwmfLaB+45V
	 Ur1+cZNL5hz3ntjqVVOpvlazgFNixvWPhjBoFgRIWHm5X2FB/ihysvsNmjrS4OhNn9+Rd
	 KyeC2pL9QGVpe2gIGRsIPf1IfZvo0jwGdECYJwHND6yJl7apCAI3/px6wH0ZA4jM5Tu2H
	 5vqzi9EMRc5AnJa0NkpNM6DZtr8FuyRIc/r0Q+DcjezEOR3vbS72NczEBGRKfWtW0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=GiSawGQk;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDF606A33F;
	Sun, 15 Nov 2026 19:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CDF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=GiSawGQk
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jSLqt1NjvzNl6l;
	Sun, 15 Nov 2026 20:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794771466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isEsQrrx0hL73b1p5Jr6MlaLz4dtBNblQFsunuEj6v8=;
	b=GiSawGQkORQPgxry110kOJKRxqQGGrmkoV1eGmHSj+S+ZUPrbQ01sfFAi3I1PaaN4YZR5J
	8zPNOf5PL2cluuIlUggromDPjMExlNdbJBkoCGDOTwfkw3p3TGxW/PiB9viFuXHr1RLCs5
	XKjtSxPeaYty0wdrgcBOTUviEXOrvnwdtXeNikySC/WDs3uEbID83zskgVyeMCtx+R/nBB
	A/DHIgJ4DkI6nrU1RIDkBy1tPvIHFSJOtMG5d4whFjbfpYb0Yw5kYlwx7R76B6XUDSUXE4
	VBTJfmCbZjrnQ5n08kWKWZRA8Q2Q/DXd1OxHFTigp1mwI4qXJrwqw6ENG2j3jA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <fc4b8168-d8b9-426b-95c5-4a24e93f46b9@mandelbit.com>
Date: Sun, 15 Nov 2026 20:37:43 +0100
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
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261113105835.3821433-1-antonio@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jSLqt1NjvzNl6l

On 13/11/2026 11:58, Antonio Quartulli wrote:
> Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
> RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
> but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
> require it. An asynchronous runtime resume (e.g. after the link comes
> back) then triggers "RTNL: assertion failed".
> 
> The queue counts only change on paths that re-open the device under
> RTNL (ethtool -L, SR-IOV reconfiguration): set them in igb_open() only,
> as igc does since commit 6f31d6b643a3 ("igc: Refactor runtime power
> management flow").
> 
> Fixes: ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in RPM resume path")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Sashiko reported an interesting finding that is worth fixing.
Will spin v2.

pw-bot: cr

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

