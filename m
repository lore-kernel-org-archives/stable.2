Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB1440653;
	Fri, 25 Sep 2026 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362127; cv=none; b=kdSTN9qPzQ/5VEiWbFPaL8pmPm7QZoBTmLiBXHz0re8q2MJL8UqBx7NyN1y9OUMGPNTOuYXNDWwy23tkcDCs96HZPUNIh1MwgxFmMy2+0atu0/tS+tus5vIJs6CP60puYI81Q5ulRB54pO3o/lwbzALzN1FoW1w3PRCMqREkjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362127; c=relaxed/simple;
	bh=H51giSJCAt5iKVItQalE9H76qkaFVERRy6Hzt5q09sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfqvcfFhymNrx2e+PLaO8Z0Qt42Cs72yRCnVH3qwQ2AcS6ga0lRjzM2zx9lsqcRGzR7hY/8udqXREONdyMGx9+k8F81Vnog1S0qpZluHpMrKNdnsCB+XoUD3DOwkBEH4WhbOGsXn3EM3LtNheOeSe5V6d80KTElrw7XxuIb6/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD0S6BrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD0S6BrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E55D1F0089B;
	Fri, 25 Sep 2026 18:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362111;
	bh=4dTvN9eu58SVrWngLpoHGRAn4LoxzEKFTncDXvCSQ78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XD0S6BrP3cCfs7n77XMafWo+a6lKfmqGhd3a2DA05WFHz/j3mu7wYHO1KyvGsn7rc
	 G8ueYShXRSCpROMSUFS8TteqEOkFog0v0AcGym0tJHc/AwtQpdxcplgi0djlU/OetE
	 I7R7qvb4DpbZayLcQJpzL7ZZKfDxZbImR3NXyBvRVvSpfyxWl2XBKMUUV5Kpz9cHd/
	 3Z5J2nVCI3pY6Cs1sVTpCWiputh2/V3mgcKTxJAWub5Q5pVtV5J4m/NAq7tpRIMhge
	 9iNjgrsSmZq0XGe7jvEg1L0+8UFSK6xFoT/umTZ1bwGAUmeXck1KbIbfvE/NcwD1rq
	 I+y9Fk3iIHC9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH 5.10.y 0/3] net: preserve skb_end_offset() in skb_unclone_keeptruesize()
Date: Fri, 25 Sep 2026 14:48:03 -0400
Message-ID: <2026-09-25-daily-reply-0011-re-skb-unclone-keeptruesize-5-10-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
References: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I backported two other patches to make the series apply cleanly.
>
> Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

Your Signed-off-by is only on the cover letter, none of the three patches
carries it. Could you resend with it added to each patch? The patches
themselves look fine.

-- 
Thanks,
Sasha
