Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239630;
	b=0fA25mo6d//8YVioUWfvdtkyCxzJP+K7kKjNaygKZdN+csyfKt5RGXWHaxIfhvw4OhMi
	 GdTP1yvaULLhxuC9/cJXT/b5+NCBqjKhne0XQgvInjpx3FM+Jjdw06GUDGA5LYC5CojDa
	 A9j5hnOI52CF5jxuVThujs5gQeayhrSmkXpv2gar3eG7kgvGz9SV1YKJBLP/4zIW7bN5n
	 WBWJXEYedoIqKRIrAWmIUbtJPRP3n/r9V+BE1TdhaJGr5trOjy4+8Cq+7L0+HpgT4HYAA
	 VLK5EjL396uGklvLiUtx7fP9ZPbWOkaTsJh6zPLJ+ZmC3wogmmOitbqMTdM1T0tCrDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9o3Ywx7yXNt/nqVg5D7pxRuKEAjQ4srChyQNUhlWg50=;
	b=5RPyipskHi1mvhPeJFoN3Ddd8nc0pLzxy4CClIn0GSIps69APbz0P1w5oISCLTQ8GreI
	 mHATxyAyyoUxip+gUnxtULCoXv49GdJdGlMI3IkXJwjSx863tWuLhRLkIh916lhq/eyXQ
	 OPIXUqqfhNgYn5G3Wz/8rHAHDaKg/EsEHzslWPh82jyiJ8v0PNFK8kF2lt0sQYlenzfLC
	 yoOAgL5Vii96jhrcX2V8Ing4ffH9UmWHk2+ulNHtH4hX6CWrMQfxM2KHKmGU7mQev5RA4
	 hmj/J0RyoK5R0KnzRQGmAKQgSVuGA97q8wi8seYkuSUx0ytu1z7prujMwen2lrPC9Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfLOchJD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DD606EE95
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfLOchJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96901F008A1;
	Mon,  9 Nov 2026 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239630;
	bh=9o3Ywx7yXNt/nqVg5D7pxRuKEAjQ4srChyQNUhlWg50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UfLOchJDnmEf96grPBgbVABoe7B3xaBcYNvhQQdeAOXb5Tsll7VRc+f8IDizbcvts
	 Ui2qfjwzB38gpB+Ninbg9MOXjCuMUzS1qrILyZKx8z10hKZXp5yS29zHO66znKQeFW
	 gUidpEL8lL6DsSlfZgVnWWedtfyD3Lh3bUXTXAIEv82TpR+sfWfzLxDJgDcdlHWoCn
	 l+V+x1aVzA+p14TatAD68eZxwzQS+nCgzYkZc3T9IUet6SZO6OZMGKSNBW0sJ9Yvx1
	 Q9uIEWJFX6eHbG8Lun3lF8+XqEIkpInenmF1wzKO1+rk5iMuCFw1MerzhtZb72AIuM
	 otsWjiagjf7qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 6.12.y] wifi: mac80211: queue frames while off-channel
Date: Mon,  9 Nov 2026 10:53:06 -0500
Message-ID: <2026-11-09-1-daily-reply-0024-mac80211-offchannel-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109084744.5999-1-stf_xl@wp.pl>
References: <20261109084744.5999-1-stf_xl@wp.pl>
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

> wifi: mac80211: queue frames while off-channel

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
