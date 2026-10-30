Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393660;
	b=uwaUExM7gMYhbaDnNasoT/CyaZat3tbocBNK0eZeeoWcI3ARvg4zz48+Mvd8oGlklx5e
	 D4TJ0Hinvs+hKfJhNnC0J+qMrADNYBAzJNpGqV3LWUBdsdjKJNMHEmA44TnDFRgR+A8Hm
	 NjIvrHXBuAyqfdsfOdfmhs3hPlyShztqZaboQUhGDHWqYUP9E+l8tdtwYO9C+h8YfwBhZ
	 3FvpUcpwdF0r283LSyAF5tq/sA3HNqQZJlwAf/zvokVi+UANd+LeHN0ZkCAz3EdpGrije
	 iTsqSeCctRoDBBpOlB1PXRk0iV05Wefv9ZR6aWrQ/6STgal/V+I9me53BYGFU0e5yuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mXlj5Zosu5s8WFF+z8Q+pR3whMpCxHkLxkiJhwIBbTQ=;
	b=5dPQjAgYrZajK2OJ2Jxf8TcXNsvlsgTQG9fqknoSab6xVMDZwWafGrb1WgxNW/8KR+uq
	 FHjFVggyup6G6NTx9Pkp3EGoxK4fsvvcFYqgmr4ph084baME2eFDFehWCq/DpW0v1MQ1p
	 p9bb0ikTmocoQVHPuw6/FQUpCtdObCeNw3r4BmmxS2HMVZbpx3ZuYXt6E5RLPM2B1o2ck
	 FqC9yPQU2yCzEUiofynn2Wppl9R79l3rrcPZCNDmDz06PeC7s80b439enN4E3ku6sh6mg
	 p4mlMz/aRxcBSc62ksofQrGUA7g5KRjev6xqfuY6K7sTDykPb7/Vo78+Lb3Dg2iLsKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAfapd0G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BC606A32D;
	Fri, 30 Oct 2026 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAfapd0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AE31F00A02;
	Fri, 30 Oct 2026 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393659;
	bh=mXlj5Zosu5s8WFF+z8Q+pR3whMpCxHkLxkiJhwIBbTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAfapd0Goh223SFxqCKJqO7a5vFAN3Unq4g2gqFMuY6UDIojrzIHBu9dXHgvtjsBz
	 iiXl7g3k9sCeYH9YZBoUkRivHy6l9IU6v/l4+NtFF7XGAwO/NpMwrjjomQLhjpoCAQ
	 wKXGbUNOHKHpF3d9mZ/bLroUma5WbLV3fI1GYVjwwlkkn3215F+dbjfFihM2qkOrba
	 oHKlbyFxo8Z7+vxZN9Mgw4fft2NboLltAoHMhFy6q0kmTnBJ2iKiDNQfj12VQASCpo
	 sN0WdsZvcQfvLwhT56R+W02+rXl3BJXdVDU1bdcU0mohktEQtSmUxhNDU7IijzpRKo
	 uoeBEXusgBjwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.12.y 0/3] Backport nested EPT violation GVA bit fix
Date: Fri, 30 Oct 2026 16:54:09 -0400
Message-ID: <2026-10-30-1-daily-reply-0006-kvm-nested-ept-gva-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030103713.573783-1-doebel@amazon.de>
References: <20261030103713.573783-1-doebel@amazon.de>
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

> Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.12.y, with its two
> dependencies.

Same as for the 6.18.y series: KVM x86 opts out of stable by default
(Documentation/process/maintainer-kvm-x86.rst), and none of the three commits
carries Cc: stable or a Fixes: tag.

Bjoern, could you get Sean or Paolo to ack this series (and the matching
6.18.y one) on the thread? I will pick both up once they have.

-- 
Thanks,
Sasha
