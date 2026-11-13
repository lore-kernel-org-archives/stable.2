Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537215;
	b=JCYYE3bCpWn8KWonWPQVrSkqeVKx2hpHvr+FFRxBESQEMIvwBTUj5fmJBiBh5IM6G1Sp
	 ILNHaLn3Hc1up3rOjsko8iY43gXr7a3XqlCywsVc/FFb6oLEQuM/REr3eQy5MKdAZLqOC
	 hFEDKywXvioqY3J5/blczpNUQG1efFrIq7ZMkVNJExptp5CT/ef96NQWImx5Pu0AzWNUY
	 t+nWCSkPOwuvEp2155lfCqlFu52Sqkhqi3rsKTYg0GQcUkarhQTwkhy+9/k9helud8M7t
	 4jt9QQY1O8yjPYyX1CmRgTLHJJ+uFjA3XbFkCmSVZ/CbFqFKsuogYW+xz1jIxafinTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KXBsLbHqbNY0tnMKABAel74HWjlwLz2G94116zY2phk=;
	b=ViQ9wQNq+Acq/STi6qb70VBVZHc39OI6iRVGCJ4Cg/2Fip8Q98i31LiKLQFK/QdMrO7a
	 SFQDLg31SKZAWr6vJ9A0CwvsjwuPB2FAA6mZT/l67P2Wo8wHmYBQtyMa8RINb8MUEFrmT
	 5gNn3DgqlHDOn+zIWb/9Nl/TLccYEKvLctdmz+lGo+mRpxX/RoOSBSIC6n3Rwoja+2qdh
	 X0DeFpkgpT4X61vTV5WzrPrTC0dyfr1sg0G8Ac9FfKUabsO3cf/tyt9a+QDPHExmhaW4a
	 QPn4WDMDoRcDCEXeeB4CEGq5KAhT9yt9iLQ80yRY3v5p0t8Nyr/vm85nyeqAwgE8XjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T3u/Jidc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A26606A33F;
	Fri, 13 Nov 2026 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3u/Jidc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E91F000C6;
	Fri, 13 Nov 2026 02:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537215;
	bh=KXBsLbHqbNY0tnMKABAel74HWjlwLz2G94116zY2phk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3u/Jidc7xu8JsGU6dv4NwbO97Wf1optilw/vxJkmlS2KkX5EFyRAVq3Z/PQkz1ry
	 rnrOGnHp5JlyShIK089TBkZWk/PS4A1uIhJynPInptR5Js/oTAEjMIhgkRmn8rHTBG
	 Kf+zZ3E8IQPqhGqmKMQO4n072F0rPqb7t/WZMVtOYyhELPqbg/Ny1jLvjqlN3f2j3k
	 UiVhZfjzJxbYe93CyK4UU13rkmjxUqbQFAP59fTykCIu9gBXqdx1CXoMXQGDtgkcl2
	 EZWIXg7EVE3JpfAISneQYtpz/tOo9eTcyNVPJv0eF3Odvq+9VheQjjytuefra/T7Bs
	 YqUYUtMDT7sug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	yeoreum.yun@arm.com,
	suzuki.poulose@arm.com,
	leo.yan@arm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH] coresight/etm4: fix missing disable active config
Date: Thu, 12 Nov 2026 21:33:14 -0500
Message-ID: <daily-reply-2026-11-12-2154998661@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112135406.71749-1-xueshuai@linux.alibaba.com>
References: <20261112135406.71749-1-xueshuai@linux.alibaba.com>
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

On 2026-11-12, Shuai Xue wrote:
> [PATCH] coresight/etm4: fix missing disable active config
> When etm4 device is disabled via sysfs, it should disable its active
> count.
> Fixes: 7ebd0ec6cf94 ("coresight: configfs: Allow configfs to activate configuration")

Queued for 6.12 and 6.6, thanks.


-- 
Thanks,
Sasha
