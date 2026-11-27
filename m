Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798899;
	b=EsNt/dl+CktGWNUFo7qBIP8dhI/HSFnX9q7L99eOFEuSv1Nae6Dembx2/K30I3qfgGgr
	 YyMXei2hci0mRoy2qfeZOWdZLjApvAKoMWRF+H/RYfvCyqcPlIxwjjcHFE0wHmfDm3Lvg
	 GzzPrmbEwazyoMNBNi04+Ek77cPJjPUgzqR4Toi5iGrinVl82F117tYJWgPeSUzbjSTIN
	 swbgFcijuBNnL+iiJBoSgLziI7Sn7xNwqS6Sdb9rlfG1ykG0rC/V/bJpWQNAi36tmqlV4
	 UTFXXMD139lnVlrVXKE3+JkKzwWPlr8jShCzajiQGFq3V3EOYw3ogXsf8NQ3xPf1WAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kXnbOt4C+Jx4P4BwwiB1h0wUpFm1GhBXsvyfJ1gp+9k=;
	b=rTs9MOmUoV9CvuUyr9FxXkbQEvqkFIb1GLGjQfyciLkhtHJFcWmguu284aMTnoNmwO/r
	 S+lREwBgJzp1uGoQjGHULq3vKdBOJSc8PSWxxpofGJ1mBFEJurGPiV7bJOt6IfulZ0HsK
	 Fm5WiarRv+Rn34uLrzsseJbRwTO1l1++gT8BELYLr4cMNsTP9N/W1D5Tlrp6rWOIDXjCn
	 38qyTCdgwb2d1X2C4uXAGZbESU/ubTNqBSk47EMXC/pZicKeRJgFqNWxgNCWfGCc0o/y7
	 9MQpXuc/Uq0IVTAwqumWujQCFbqHaZAtPRebxnqqA/GYDtEPwFhGnaXYTO5rL1QbXXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axeTBbQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB6606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axeTBbQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281591F0089B;
	Fri, 27 Nov 2026 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798898;
	bh=kXnbOt4C+Jx4P4BwwiB1h0wUpFm1GhBXsvyfJ1gp+9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=axeTBbQbZ5V4I3lQXOh4SHb886PjF300lvYWIAYy73YR4MXSTymc6IhrS8+V0z7ax
	 NF1PTZanBqRNbbFdmWcGURrxXhosCJ4hB5Dvugt+O5gAreI4vqvXF4lPBnnCgtO+Al
	 ik3WjUl963JdAP+5a0+zqs0drYYIxpwXLrYhTCDoiF3S37G+s/tmzQ9/o8pK1716qu
	 ahpqAmNCxh6UR4JVP0lubgMl8NTZBec7Z0VDRwctJc81heNSENgIHT1bBcztv9ByF7
	 sKxPMtweUBp+8YSVVjVmlYfEfrtD6tSDkYUmdJQAL/5ju2SRBvFtm1hvIF1qSuy4x1
	 +/n+BWMFDH8FA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7.3.y] comedi: comedi_bond: Fix leak of opened device references
Date: Fri, 27 Nov 2026 12:00:51 -0500
Message-ID: <2026-11-26-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125174412.735738-1-abbotti@mev.co.uk>
References: <20261125174412.735738-1-abbotti@mev.co.uk>
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

> bonding_attach() calls do_dev_config() to open other comedi devices
> specified by the user and tries to make use of them as part of the
> 'bonding' device.

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
