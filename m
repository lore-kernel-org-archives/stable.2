Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAC43F4AB;
	Fri, 25 Sep 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362116; cv=none; b=gv+P7wSIIvxYacWLZhO6ZN+yAVRaSzI+FWYXCn0Xc1jE5q3Si8Qv0LRoyH5RxE/h3fc4k+X+BGxmugO2wLGbgOlu5xsxM1eAoe13//qyviHSpo6s8GKPJhLMfMZVaewnP5tajBCOIUHSZtqqbaBdX2hfg6sWJr6NAYoJnWA2L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362116; c=relaxed/simple;
	bh=LwKnTPlvXnwnN6tKaNhSHXV2pfL+MccW2W9P4S/ChP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHUaqvOL0g5M+v/jUshYJTISjz5nycgPCGkg59FxVmUVtoMlkUKnGihjaCIs/VQKaXhRfFBMnwLSEQLtsiw89Agx08oXAzcyprX+2g9XH39c5lCTFGLcjVTyc8dYHuSRwp/N4iTvBsSTG2xtUJ8uWpY7oBPh8f8PzSWxBFoYZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUfNWplK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUfNWplK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CCF1F0089A;
	Fri, 25 Sep 2026 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362109;
	bh=whLo7El+gFfTBxE/JxHxEF3XKSbMFQz48lhDhfm1uqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IUfNWplKB6dkh28MnzT4Z4jcw2TmjrB6S8YuEj59FWqLJDK1syypMwKDUDmme66wc
	 bqRb75+85l2cYDLB7hPczJFX2/5WIAsDgL4CFm2euV6IroWPtGJmtdSFD792feqdY6
	 SXzdUZn64SZby/SOs/YZGvdYginFSIRY1VyeNbDv+mQdwRIK6fln9pJ5oy3QM0Zzgw
	 CpEPEqRd5ZMzTZTAk/rmPp1qZOo3nPgiy7tnlLj3mu8M88bERFStb9GCfXUkMsHBDx
	 66/Ux5U1d/aO/r9DmBUoQyhzqwOvxnign/zEn65c1zGlNBKsNi7dMmmjwNFMiOIwr3
	 U1fVqx7ohUzIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yan-Hsuan Chuang <tony0620emma@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 6.1.y] wifi: rtw88: delete timer and free skb queue when unloading
Date: Fri, 25 Sep 2026 14:48:02 -0400
Message-ID: <2026-09-25-daily-reply-0010-re-rtw88-deinit-timer-skb-queue-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924174054.88252-1-artem@trailofbits.com>
References: <20260924174054.88252-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: the source change is unchanged; only hunk locations
>   in rtw_core_deinit() differ. The target-only Fixes trailer names the
>   initial rtw88 driver commit, which introduced this lifetime. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
