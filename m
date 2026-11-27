Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798912;
	b=oaP3PqiNHtpkR5GTvCAMRGJlHGCvhn1hfLxGWp0RoQuZjtkWg40sThGyFOB03uBsJkMl
	 LhL5qBHuqNX1vZTphWNNgHXOH4kojbVX0zbUMtH8/+o50gYyMDWLl39lCE9Ie2jGdKG7B
	 6b96sNBO/56rLaDmqv/Rm8jp5EZ7eDrjYAOl2e7XrZBPfziBAkEcGfs0Vht87Q3FeUEh8
	 In+DaRc6vsyhOUX0pV6MwGv6IDi397jINpiq7B7Xua6plDNzZe89M5BaOAvafAjKfCjnB
	 ICUamBoWuD2wmb832p8ULdXHKYp5Euh+r/wxzFbET26pfpCUp9iQs+dw1lxW6pkONZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798912;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dkOAlSpJ13qp8zArQdi1gUZpIrrZBO7sgnEDeAfz3dk=;
	b=EbDZXlWcd4DXPYLTRPtJFAk0YnRKpJwqNqi6GNH8IwJCIkDfSBmKWQCqa5+/mfq9OPPN
	 sshbmRUvrvI5orgrb2O0+7RSQ70gOq/+5nDH8io+x985yRTvZf1VbKsvZ0jaB0Br4mICA
	 0fCOqvkUFYomW/zRTfYkLxvyGqjgSiXA+rhXD8jLoyI08DxhcyODluw+0iHs45oq5ADaf
	 Q/05JFYMFVoohHDd2OIhFewesFs5S4/nbaprrwu0Ep5gXGSGD/yeHF8CuivKOLrs8bBy5
	 rU5HvnENwIZyCi+/AqQ/eGNXuVfqbcBjgtfgnHEpRCYTHDPx94kjIfJC0AaqsajGsPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9wmfB3Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B75606A31C;
	Fri, 27 Nov 2026 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9wmfB3Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882801F00898;
	Fri, 27 Nov 2026 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798912;
	bh=dkOAlSpJ13qp8zArQdi1gUZpIrrZBO7sgnEDeAfz3dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d9wmfB3YLJyUgwpAL0FnVujnsG8/dyqYIY1LMYxwfLEr40DMBMAGKv2fxgq7gfmqp
	 TA3yWUW78a8YvaTYYSYBkwzg0KKw32V5aS7o4Qmsp1GDGw/2R8FUDu8toO9T8xLufG
	 CyWh1JbFpsptCG5y+T+8ErtH9/YaHPdGtPrhJonhkA9wbsJkAZZnhtP0kqcUMvjIlb
	 nd7mA6bqPx9YSNTsXrpFeCw6XRbx2PEcfr05LRY6PrrcE72mQtUQq7vhf9Df2x0VHS
	 /DrEjMpTxqWgUsQANSknhwHulZjhPztQTsibeXpBU3E2e9winglABTEN2aFroqvSIG
	 SBD9TxyYPDXaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kris.pan@intel.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.18.y] net: flush skb_defer_nodes in dev_cpu_dead()
Date: Fri, 27 Nov 2026 12:00:59 -0500
Message-ID: <2026-11-26-1-daily-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125205653.75303-1-artem@trailofbits.com>
References: <20261125205653.75303-1-artem@trailofbits.com>
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

> When a CPU goes offline, dev_cpu_dead() drains its softnet queues
> (completion_queue, output_queue, poll_list, process_queue, and
> input_pkt_queue), but leaves net_hotdata.skb_defer_nodes untouched.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
