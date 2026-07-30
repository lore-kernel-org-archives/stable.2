Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236337703B;
	Thu, 30 Jul 2026 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379241; cv=none; b=S+zfNZCDbvYixc0yBZpzkZV+GrcBimVxzyvVFW4Aw7Ith8z3PWejLC6DMriTHEf8Jbk1ALFfnGSHnT8BgfCOGWvvsVn+CUiMc+unlLVxJtH0IM6rQR/zirugnAQMFaCt+cB5fPQyBFAu9Yhgyjy935my1fuGGu8l/gHIK6LKmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379241; c=relaxed/simple;
	bh=CSwnYtJsoT0vLX2skWgtjp9QrruFj5NMEfi+KUjFhFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ1wDiYfQfK1kXY3LUw22NJaJxvz1ujnkSwVB4eARpE7sIVJvbk3Y9TXOwL/y1ESmyZzpExTxRG3sT2zdGqoBY2ti7sQuk3LymEmuVJ9yEy7anbobU5Ypi3tGr4fdiwIVa/n2IEHlqqR7+DKdUqcKhVW+mZfVVLBjcQUpLl0GqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0RAVXkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0RAVXkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2689B1F000E9;
	Thu, 30 Jul 2026 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379240;
	bh=SEWDGFuNpU9C1rRd2EC3RqNxjg+y4oob98fwClDFcsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0RAVXkBv9yp8pHzddimmsHw1QOhkV2PLSh1uwJeYewPXnBm9ZfhpjxzTtlY03/fq
	 CI39Kb7CwQECXDhwETfzuOqSOL35w6qp1OPc/3hI6o206zPKaOW5p37NbMmFhuAz6r
	 P8W51inLkee2bhdeGzPu+hEZsUuNVOCl0bhtjn9StANtv1bDwff+/TKP/TipoPEGr+
	 J6U4CUvtQvqjelVccYvm0GQfw4GX+9slF/uWyfSXm5YBRzcKjZix0B3/fMJccI//bs
	 DO78MGtGZLo58gCB+xvbPnG8upmCVMJ10aFG2IMv/wKtkDMoxbqLx64HVycBYwj8aG
	 HgvA56R8ZfmLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: Re: [PATCH 5.10] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
Date: Wed, 29 Jul 2026 22:40:05 -0400
Message-ID: <20260729223316.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729121605.134642-1-alexevgmart@gmail.com>
References: <20260729121605.134642-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
> [PATCH 5.15/6.1] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
