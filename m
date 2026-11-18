Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005610;
	b=mFRmRCvNK4qXdKBQY8UBJrQBpS41tITOGlyM4n7LIu0drS6UCFrvMRRFbl8xDMPO7Du1
	 JUwt6KQc2WoP/bcNLTUHyB5BBMgVJNUl8KBj4jOYQz8U4bLt2zcAqQC4DcP4GP4Lpa9RD
	 zG8B3DgQXidtcWQy9Yjj1Cm1VnkVQA5/f2pRrtZAjO5phqzApIn/ciJD5JQ37sJzZ0RzH
	 gIclEQoNL0xqN23HKx7pfgLHn8m+jXz+FKcnVyQl3X/zYFgLFAY2S/ei6n+0Q19R9zdWe
	 t+oYlPUb6WSmFNbHeQtPCa2P0MfO0A90XL98hACJLF1AbnLDcUqqn87B6yeBmqWNntw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NWRRBL/nkj/qiw0FA+M+8kPBJmXsdrkEuh/cCE1zcS4=;
	b=bRp6prUWPlOXoZFGHWV07SKbtRcPg631OsAXJw58R5ePOVzwAo4Mhtol76uajbwZMtv6
	 EushYgYsPKv/klGCf7pKXUozv0UhmSMq1LryI0vO9oqufobCDWVRhqmWP0clbSwaLYUK1
	 SRqS62hGY9elW3pLPRXRYw1Si/xAchYqu2pNVcCxOehoc2BzPmtSmtV4tNXpgApfYWw3i
	 NOmMT+HUziaBFPH1MDbaYLn9xR6BgI6YsosENAhJIPbepBwQsNIZ5064TpsoY8HxZEY0q
	 +cNNL9T89K49rf6UW6bxOgYnjLAfiaug0pU5NmaUFOu/qTwhylB7QMoi7xMlgVu4KpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQKiFR3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5695606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQKiFR3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F631F000C7;
	Wed, 18 Nov 2026 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005610;
	bh=NWRRBL/nkj/qiw0FA+M+8kPBJmXsdrkEuh/cCE1zcS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQKiFR3suRGrAbBQu/9v+UXrj9sh2Fc+z6Lyjn2oc9MSvNmVG24t/TSpB3fT/NWya
	 D402e6YSF992XUfq84+9D/4GUGXA0XoD7sws+f/BSCmNa0EkEC+3h6WUb2PH+/e180
	 6KuUtNl2ZufP3Paa0j2SPkY4VoIOsIMxCBbNUek1WQo9F63006NiAqZUWM4miDVALU
	 gUH3A/UDc16VeXWzRf5eivABYvFdDlKttYd6O6l9mmyLYIbnuWrI6nRew9GIaXg2Le
	 gfkD4gPVS4BFNjx++gU4ibN1VO/9dBRMaaXHCBFM6cofRqzheI28IwsVYxxC6fbl9M
	 5Ml+AbbwJohyg==
From: Sasha Levin <sashal@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: Patch "serial: max310x: drive RTS in software when hardware delays are too short" has been added to the 7.3-stable tree
Date: Wed, 18 Nov 2026 07:40:02 -0500
Message-ID: <20261118124002.3727477-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b68885fe-223b-4b55-aae9-768456d4fa30@vaisala.com>
References: <20261117144521.1678735-1-sashal@kernel.org> <b68885fe-223b-4b55-aae9-768456d4fa30@vaisala.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 08:23:34AM +0200, Tapio Reijonen wrote:
> Please queue c06fcc258db0 before this patch in 7.3 and 6.18. If that
> is not wanted, please drop this patch and ae588038e31c ("serial:
> max310x: don't transmit while an RS485 reconfigure is pending") from
> both trees; the second one builds on the first.

c06fcc258db0 ("serial: max310x: schedule tx_work directly from the IRQ
handler") is now queued for 7.3 and 6.18, ahead of 33632215e1bb ("serial:
max310x: drive RTS in software when hardware delays are too short").

-- 
Thanks,
Sasha
