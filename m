Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6833DA5C7;
	Sun,  6 Sep 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701661; cv=none; b=BHAEwGFg3wPZhed2tuSi5fKvPSnS0sighG/YOlbiKCFi2anEb6xeSen99V+eqgEm0VZ260idqvgVIKiOqC+aRweC1wp4N7y89bxFU/llNfoIVPvW0usfDU1TblZqj7H/PwcogPSUrKVaq6Q90hEFXmL94gV7apumlAyoR/jOx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701661; c=relaxed/simple;
	bh=lqqkDO1r4lJ2T6Wp1/3zms5bGHaOkoAxXaF4z4p7o3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGsADcsUELgtMBSymR0EQH9i6ZPY7XBLg8sGFN89mQkV30UBpUVgzHmkBae4tomf1DC+UfouffduH7/pdCfyA8Bw79N2WNQ6c+Dpfu+PF1VLPrlejSawBqxSSfQOZfQa5M3mzxE5aD6spFNFZtDficaQBEQxpANhdiWQAmk7b/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBPheUMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBPheUMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A4D1F00A3F;
	Sun,  6 Sep 2026 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701658;
	bh=/KT168Vve387ZFmKH1wECptYoioqeszSe2kVnCkWM7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBPheUMJ9eJPnQV8Ge4BfFHVUC/xwNOFVdBAs0OpHS7z3dBC9XYN6JCVoPcViceh6
	 dJolMCGusDl1KaHVLn+aXF9Rc7FqF/OQL79wKFaN6xq3tlE9czbGwTphWYsPiWEur+
	 xvcS6do8mByozRQFI+9JWRLF/8GrpuhBbIkhruTMfs+ifrDv2cuFUaOuTIphxBcbNk
	 EJvUTKwllUKnoDZpd452akXfuDueIn5D8oFtT6Kb2+iXi4vXwJJPgUS3HJT2hRW9nx
	 2pep3ObWiGO+ASpOMldwPJyqdEMTzgSg1ClvG8xdu2SX8WG7h+6/8GYX3CmcEzEPyS
	 /WQ7M2WUXcmkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	atul.joshi@nokia.com,
	joakim.tjernlund@nokia.com
Subject: Re: [PATCH stable 6.6 v2] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Sun,  6 Sep 2026 09:33:18 -0400
Message-ID: <2026-09-05-daily-reply-0048-tcp-syn-recv-race-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183500.3841094-5-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-5-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This fixes CVE-2026-43198 (v2 -- v1 broke the DCCP build by not updating
> every icsk_af_ops.syn_recv_sock implementer for the new argument).

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
