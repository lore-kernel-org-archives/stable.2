Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356053;
	b=NS9AJWsE3RUAy2lf4uBRk/W/V3Tz6UCpJQd6HwXPVfrz9tRi/DtTSKQTwCZYjqPXd/wR
	 n8hCbYRtVIMdwUIGwASe6oHeeLUS0quSKOT/UdK0r4V+aUbQMJeAU9VyhMci8xz+OtGW0
	 g0HXeuJ+sn6SUk97JidHQHGLlh2PfGrJDpKOXrCQ0YjWRl6KqwZDMv5tZmJ8HFh+vZUWj
	 eFMk/DTr5feiWAY5AG+w5UsyFmeYLa0Nd2hUPN2rCk2l62/LV0zkoai6s/Qtm4SiNP17y
	 nRK2ufn6jn4DeQPvR9+/i86QZgLInSb75pyInVejIMBPRDKpJWajUw/6PkueREBVlKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356053;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ip/xSJgE6lzIgOQCwqSlzlguWywHZPIvgNJ5S8+kozg=;
	b=sRyiSz49KdC9L9ZIzLhcXmeaIaoM+MsM4O8TUfrfH3Nj7aQtSERde38JFZsqTxcBJ/fT
	 2uF/Qqqa4p9Yixgzg7ZCMmXRdfZkLn1/hlofAlYwUK6IN4SCY30pH4TCXRVnVuKVP+uFO
	 bYboJeBvqqVWXXXN98Khi5Zlb2+6mBZOg3bUyOzpF2+aTBXlZo73qcrX4SOIdgM7bAN6A
	 6SjeGnpY528Dw9tQ04nPAdSpI4hH/4qgVRvqr1ZA10aFaXDtShI6m6LfEtxq95OfVJ5OG
	 HwycL0/ISVbePRXPWIDtIay35jRc8AqiSJPsQ0jBne5GtyAYASBrGR7U42Kryk7kORQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=mDbMuDIt;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93F606A320;
	Fri, 30 Oct 2026 10:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F93F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=mDbMuDIt
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8424:8fef:6e01:2a4e:9a3e:485b:cbb0])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 2B24319F738;
	Fri, 30 Oct 2026 11:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793356043;
	bh=ip/xSJgE6lzIgOQCwqSlzlguWywHZPIvgNJ5S8+kozg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDbMuDItSItOL6G23YMVrEfLp4m2TIIMucO1jJ0nB1wMRvBJ4c37QfFRge8MkMONJ
	 aUE6OC3ofAgIXi685jubgt7jQTgcuBun0QlpWDOuofKJbwFeOI4j77r4Wk6LqPK23N
	 yjtR8c4Y8vovpUB8lMYpl1OHyWI/mDeMSNb8Jg78N0Y1eR7E27iOxMGw+TEjeQMLbp
	 FukHNhpU5AfvfzUrFBVfIez+8pNXA2TNrjMhuLEI7n8r0oYdEEMZVcFUOAOrLbpEzO
	 KQ/pWgPIPG3+zTa9E+5w1ATulkUpsNIMU2WHnCtpSUDMxaXMxOYlYxgleyyDa1RFz5
	 oZLlaaPxIuzkw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v6 03/13] can: peak_usb: sort ctrlmode_supported flags
Date: Fri, 30 Oct 2026 11:26:59 +0100
Message-ID: <20261030102705.30262-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179281433115.3130.15136732593858786026@kernel.org>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr> <20261022-canfd_check_channel_idx-v6-3-197704231551@peak-system.fr> <179281433115.3130.15136732593858786026@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

On 24/10/2026 05:58, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> This isn't a bug, but the runtime ctrlmode_supported update in
> pcan_usb_init() in the same file was not reordered:
[...]
> CAN_CTRLMODE_LOOPBACK is 0x01 and CAN_CTRLMODE_ONE_SHOT is 0x08, so by
> the ordering described in the commit message LOOPBACK would come first.

Right, v7 sorts this one too.

Thanks!

Stéphane
