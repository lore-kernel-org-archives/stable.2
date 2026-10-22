Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634650;
	b=zIIriQ8qj+I33yy9NlYhHT0cAe0UqMNaiz2dtsajIL6meav9dAg5nrvVsdAKDp28ND94
	 ZmpBPwYVlUclClqKjYBAptDZZjO13wbUHIFcwbVdMAYk1LcBPOZWQMVHmdKSDjXHuDVIE
	 Wj25NPXNktM/oRHZl71v6MNKUrx1VDuwzbWXg1/5oPew7qCE+dEIFGuSsl1394BD9lE99
	 92uADqxkILsfn3py83hap+fupHR5SRw2SGKfGS6j+45G9vUNY2Lpodzj/s3Oc0/20znhW
	 m/RCsgkA/mRe6IKvDyuVE6neGhTgXADHT3MIvHQvNEDbvBGoGtLv6N49MJ8S0a+oMRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M+p2RI73U5OwQMV5h5f9MtcNrBK4hrYeemWveTRWY64=;
	b=s9RkthzQmAxK34Z1QpqfiM1Uw2E85s3kYXOsLNs4kuJSVfnIbswT0BaoZGkcNHwcaMns
	 Ngq5FYyryz4ZOSjsBSU4hrJ1pFPX+h7Y6bWn80muYhal/kDf8OBMrqWlv0LnT5AuYGf06
	 ZTP5ijn3kZH1WXnGaYSdxPMppK89nc1QvIDJeWhM0w1dTDMykUWZC6FqMT8mZxJ7l4LIp
	 maausNZAaOHzKxrzfetL4tVJva5r8G6ztPItUtVS3GRdQOQpEbIBxenqa8YQT2JZ2YNCq
	 sGIzgH3thfCME5ZZxZLUhNRfObgLm193gtZFg8p9SjUtV1qsta5nZ4dNX+YzJm7Md9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbyxIY3t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEA606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbyxIY3t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AD61F000C1;
	Thu, 22 Oct 2026 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634649;
	bh=M+p2RI73U5OwQMV5h5f9MtcNrBK4hrYeemWveTRWY64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbyxIY3tpOFMNRKZEKPw6r6+FQAwHcenffabqP9JUEjR5txxm1UINBIjlkc9F//iK
	 iFHAqOJPM1+VoCtPz4CYh84wytpoBwEvpPN8S6y1XM/Secfje97XxrjeyjES9z9O3z
	 T0Ot6uHyKGIvrHIQEwYIpbst9iimD9/lc/WsctSZhGtBttLfFa+MdNIs7v+xqMcV1e
	 tv1bYXKCqs6obsDLDY2VSy/qa6hQk4UcPzJN8MAZEEUGqxRvGLL+HwX8sQV72kadr8
	 ihKMe999/4Lrw7VOb6vY4+hifpdfTNf/m/GnFaT+PKTjJNSmK0N1Yak4idG8Sv/jon
	 zLlMR1wFirj8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicholas Carlini <npc@anthropic.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] security/keys: fix missed RCU read section on lookup
Date: Wed, 21 Oct 2026 22:03:35 -0400
Message-ID: <2026-10-21-1-daily-reply-0010-keys-rcu-lookup-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-64015-5-10-v1-1-e46094923660@bootlin.com>
References: <20261020-cve-2026-64015-5-10-v1-1-e46094923660@bootlin.com>
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

> Nicholas Carlini reports that the keyring code calls assoc_array_find()
> in find_key_to_update() without holding the RCU read lock, while the

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
