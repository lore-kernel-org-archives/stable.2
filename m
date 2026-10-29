Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299419;
	b=Rg6jFPxR/cdVwL1TgmP4FJbEqAlBp2t6xwOsx3SU34lT4nZvNdu0w2ib0m943Dbh57C1
	 7zWyQm5iMdvb7lQLVbDSJgdiws6jhVMOPxv3wozRTUpwjP35KOTxxIqiTe/HOiI0PTYO/
	 ZkLTqcVoQdsTlMI5ZS0Db7AOwmNWwX3rd8TDnuPo4ontEQo2NVzNcOE+NTGThLv79iRvr
	 Fvzm6vnRWiaDR/V67DzGhirvPvaRTLpivT39jiF2YaJzGP8OkANk5lyWZbl9SylRiwMPa
	 UtNUZZ/v1TeLFXPl/YsZG/GXuJtyBSSdFJlGFHoL0mvrwwGdPUwudW7wb6lwtMSKY3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0B7GgPY/nqEbHL3a047yY3u7RfgGetvgK3DliECAc1U=;
	b=I4u7qLt/UZvVQZ3jd7663rK7bfYY/6QIMqST/vmsAR6vU8u+uTW1tLGTFiiIJlMusnfz
	 mDvK/eQpvboqvFRPVEMIz7i8dcrc9htKcX5WEDubQzuq10TMEeIMBxpi6znb50ehrAp7D
	 tP+q0UJ8LBLGNjDwV09QvV464NQ0BAFu3Twdu0b7jsBSpH3igmhj9trJ28YEwIPG/XkGK
	 ZPyaySKKXvsvGXn5CUmmVfDw7XGkl23SKjG9aysVrZsowIz3I6YKH4eBtbDLzLtbVVmWG
	 OPO0cPCWo3MRIizn3LrBbF9d7ogA+c00nXTVyz+2+mLIKaGDv8WvEOyzH6x9sY4KI5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1SBZxVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA3606A320
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1SBZxVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6362B1F01829;
	Thu, 29 Oct 2026 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299419;
	bh=0B7GgPY/nqEbHL3a047yY3u7RfgGetvgK3DliECAc1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1SBZxVZi5d5XD4lsw4qIw61L7dEvwAXFY9n6bnOnZWRCmsvYldxtLnxUuk+Ne+HV
	 5ASTyzx12b/JJGGRTyoyJovN8b6ZiyOq008YE+wv15SPyjwTE39Klu8EatNwe1d3MO
	 JwwIES7/q+cu2lh/WOTLTXd6BmZGGECPjoI0r6aXInbFWsJWPRBcLEkbYjwJH2D+mU
	 WD3ZmYF9CoaI3qid/2N1ha5OpRWgKr597UIAcI3GZ5YhTpcSLzmH1ssbsaZdXPKjZD
	 NjuujNOTBW/V17k0QNIfZBWg5qKuqLei4+vT9vYljKV80O6pl7E2lVw7yxVk51PO7v
	 PXtHQ97NAhUWA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kijo Park <red993688@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [STABLE v5.10] exec: Cleanup POSIX timers right after de_thread()
Date: Thu, 29 Oct 2026 14:43:12 -0400
Message-ID: <2026-10-29-1-daily-reply-0005-exec-posix-timers-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028122118.3429939-1-lee@kernel.org>
References: <20261028122118.3429939-1-lee@kernel.org>
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

> commit acb03d3881818581052924a9bbbe92b8741ed448 upstream.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
