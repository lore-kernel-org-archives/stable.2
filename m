Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239645;
	b=Lr3QzUdZpTtk+N8sGyMjb07F65qyJ2xC86c3LOvJsBtppLkWVXyN2apZJ2cxp+HbdMxa
	 vBbUJo+ES4kDZYEbS7n8yD4TveP+bjhmmh/lUth/1gmGPuL65Deutp4i1YCTPMyKQUL/6
	 2OIr481hWJ/eTb/shUXSEVU93wwEQevnpD0eNcZ2iMvzGadWBad/akRvn80DMQ3jXBK1P
	 /vIroP3spUdaVDA6XacwMetWbvfWcM2wIWEkL47ioztnP5Pq9OvH/FOO93Biu3XNFtPi0
	 auvHLT1J5gJjquEdRwjJZruMn3X3BDhKNizhiosJtmgDGM04jHyNtsz2wFvTItO+RiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kxlvs8zy6mD5Ld1nCLG4tbIJu+SbOwGTMmjnIuPkHjk=;
	b=NHgfpQkofzFXjiXxmv+Yq2iDsYMzM4UHL1A5xTqzYdvPJ6Q1v3K9zi4CaRDkPBidjIlE
	 ZlA8qj+xh2deGe+ivZ3cGa7lpdKXK7wsxXqk//sPGWT+y4mulIHT977dO0LSzPH9OAHr8
	 ORWOmSgA10agIGGadXKVDFixGnQGgnrGGkVy/smrqboHQI51HPf/YPO8YXctNVxptBPyN
	 uwjCuJO4wtvG9hLP0hKUxKsUnHAZNvJiS/oWHe3bKbGxAVEWhq5zN4Bzsg/VzU00mx/vM
	 7wJIYzIQDZD/FUVMR1M5qrCl7yCtocHO6Q6/HURfZemEQea5db6RM1Akjq0IWGSoq9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUJEA1nR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C738606EE8F
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUJEA1nR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25011F008A1;
	Mon,  9 Nov 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239645;
	bh=Kxlvs8zy6mD5Ld1nCLG4tbIJu+SbOwGTMmjnIuPkHjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUJEA1nR/ywSIh4uk87bbk85oLGvjDFFAS/1TonXZhKq9AcmGtiBJ1k8fyjP/nU4+
	 wt2nebbLmb6YlIj0Uv0h1nYRnN8B/aPFfcqA25p91V/OJaxKi0QF6En+niJoshW/Rw
	 Rbuujd+phIxOY/zJGL87PKTT+9LjB/tj7nn1+8EiqgOXWf6tXWBcRc1DqehJmbehGS
	 bdLauChIEAntFkCVj9qCX/Av9cZdYvVMS/g7ymZEWj0TX7LFXPcEoGU+bhmQLA2MLD
	 QEVJceRc+jRLo0g0GvaD+tbcp972lwqlSqa+Egi8FdmOdwSyRD1IokXcB0h4hIjiLV
	 kMsrP7rSlh/BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: Re: [PATCH 5.15.y v2 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Mon,  9 Nov 2026 10:53:20 -0500
Message-ID: <2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109015902.3034747-1-oss@fourdim.xyz>
References: <20261109015902.3034747-1-oss@fourdim.xyz>
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

> Bluetooth: L2CAP: signalling response fixes

Thanks for the v2. The 5.15 and 5.10 series add AMP/A2MP hunks that are not in
6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid
states"), a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to
outstanding requests") or a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection
responses with wrong ident").

Luiz, could you ack those AMP extras? I will queue both series once there is an
ack.

-- 
Thanks,
Sasha
