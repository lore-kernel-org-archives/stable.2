Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104518;
	b=w3FltQxhE8KGl0wIulo/Bywo8L//G5tlnmnAUdehBBp0RIngHFvnBVcrDsuLsZYfkogb
	 Vo77jxvsn7MhVd/wZlQ6k2fOHrO6uHrFbOVh+x0dS+NSelHjWPbP4SgPfsmS1GJ+bil+v
	 bPxHZaf+V4GbaIpxFzh2asv5n/+tksvCT0f7ml03hSBxRtbnWc/uHeMFC2g4nyP7p4b3v
	 HUDW92Uxbh+VUEBB6aulm9HgJtMymKeK7aPh8aZ8hqYdBo1XCU7JLyhnDY8BCsXxMQS+D
	 TXy/eaKzyXw8tO/Pg0gaVZV3Uq8ZE/WZW3fz3iSRROGGpYtE0TQmMxBDWZg+VebD6qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eaqwS3/vkcbFCW/Aj1ah0AA9Pa736iPqNtZZpbNIeA4=;
	b=mSdyubIC7b1GWmzsvtoPNJ5BnHepUW8AZPkBrdT8+aVs3W0O+gj2UHCcmZzPZuedoHTn
	 pJqe/DE0c48sBV9hNMWKX5LRHLqF46CQW9n0p7TtKkryZkd2gUgRqM3GkXkl2XKtP8YCX
	 JA9BmJMWh9wpRZ+QJrs5il/JPjSkYAO6dNfeYUp0hfHhPclccZa0jHndDMvJXMeOHT4yl
	 UGHFUUSk3iiY9QwQtiXRXtN02fb66pHUjmZZ+bderw6LvoJ5riKRfD5NVb9kXV17gg27N
	 D4Atceex6QgVqozhiaQ4CLLoPWEpZasp5Bo46fleizLsIJhkxarTvu/eYKd4whwMMgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5Ne8CFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7060A2608;
	Thu, 19 Nov 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5Ne8CFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADA51F000C8;
	Thu, 19 Nov 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104518;
	bh=eaqwS3/vkcbFCW/Aj1ah0AA9Pa736iPqNtZZpbNIeA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5Ne8CFFkCoPbyxapveGkmyoaiJ75TDtrwZK9MusojecOx74x2lDFroVtmTUMC3Ot
	 bA4kT9x/Kw+ms7XlUvdugdYaDqz7zBaUjrmo88SKHyc95kNxl9ci7m7XkcDlhwbseN
	 avF+a7qq3PU3GHjB3Pj7fCC9ieBG9tyigkOegXXyyl9NPIs2Vf+tGiDIFW9+w7Zfj5
	 BTH7/DsInBMK/dcFLsfYH3i44EGrG2tW7qcMlygAzEZCaUXkf08i+7alDCV0xZcu1H
	 z6zAmuZD0x0Ntzo7sZZvLlguGhA6sXZx8LsWKPEm+GaQaOKMZlMXtbXyeiGuh18Sze
	 AMQ8nJe3OwC4g==
From: Sasha Levin <sashal@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	stable@vger.kernel.org,
	pabeni@redhat.com
Cc: Sasha Levin <sashal@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y v1 1/1] mptcp: fix UAF of child socket on listener close
Date: Thu, 19 Nov 2026 11:08:06 -0500
Message-ID: <2026-11-19-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118125032.200934-2-jiayuan.chen@linux.dev>
References: <20261118125032.200934-2-jiayuan.chen@linux.dev>
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

> mptcp_close() orphans the listener subflow before inet_csk_listen_stop()
> runs on it. A child created in that window inherits SOCK_DEAD, so a
> following RST frees it while it is still in the accept queue

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
