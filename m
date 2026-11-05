Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903976;
	b=3xOKt0mVueO6Ox3q30YqG2qijkrOTv7edie+l4QElD/N0DeeG9nBn3D5lfjhQIqQ4s1d
	 5inKL1eiVGRts9Fy1UbBTHOQ6ZhGwcYR/OrMYxnjblryOs4PDfXf+jV4rlv5bgkNO3Oer
	 +Mr19aENYoTTDikk80STxclqCKhtmfu+DRt79VrilJA/4J85Btw1b5r75ZQTrDi3NV8Uh
	 1KboaKm+hWsXONrki3t2is6TKi+iROIBAIm7KL7NqXKV9CDVXtGc0EdgWLCD2cOQZgzEs
	 d73bDvtb0tihcufE9tedsCMYN/vVHWHmVl59RFUKHggZI3X0e6H3Moeu3azwwpTspGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xXicdx4+PEY1L+44qm4Wnymy20CrafRAf4BQJHQMhQY=;
	b=TcduAaoNS70Op6IB0QXzr4+OMdhXVltI23bbuBEW0u7sCwhK3k4+GHfCwyRrMk6nqK8i
	 PI4RtKesn+Jd9u1GLUBAvtP4oeieDYIgu8K/buS1/2W4Zri9zARhdJl5LnqqOzfO8hSat
	 2oOSIUao05f0HpVAZlYJ8Mne+7qortEBY89Canhx103q067S51Gy4v2htihahn292YVUo
	 NOhJJUV9XtCCJaFCTlbba9+SYdFSMneA6EqBX99aE0juhb1xy+QB2Pt8jYWqx0f7QvvHP
	 YSjp4fITMNGnQw2o0ERvrxf0oBgbkjudRhwFdMgSQg/7BgPg9ay5vaaT60hk2vNTsRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMVEA6dq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B71606A32F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMVEA6dq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1606A1F00A16;
	Thu,  5 Nov 2026 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903975;
	bh=xXicdx4+PEY1L+44qm4Wnymy20CrafRAf4BQJHQMhQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DMVEA6dqImprJDd1X0UGGLKj8Ig964jHyIEadfFtebt6E0Ar48RMCo6eipxDLQV+9
	 ELqNaI8UcK92vYL7CsE32DgU9tTCOD09Jm5dC4cSh+QmsgQrQZ7gyvpysSmVvu8rJl
	 nA+joXFid3NOc1w+IJScARs4iTA0w3C1V128g6celRJQxeiEgalZ00bWC+j0gUlH8n
	 sPBR9XCOpew6OvPhvji8/PAh8lBdl8kaiknq8j1IPE3U0CqZNN1A7nwokIWDs/sTf3
	 nqd0s3R3l5deIZBg5gvYp7rYlE3IL+Jy1sOkz/QVDHb4ZOosxQ/MusURiuK6TeVxmW
	 0tpCsCzBSpP7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	xiaoyao.li@intel.com,
	Sean Christopherson <seanjc@google.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 6.18.y] KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
Date: Thu,  5 Nov 2026 13:39:18 -0500
Message-ID: <2026-11-05-1-daily-reply-0013-kvm-vmx-0xdead@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105120208.2031475-1-xiaoyao.li@intel.com>
References: <2026110438-shrink-panic-2119@gregkh> <20261105120208.2031475-1-xiaoyao.li@intel.com>
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

> Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
> to stuff the exit reason on a failed VM-Enter

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
