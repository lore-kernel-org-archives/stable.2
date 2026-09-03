Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BD468C15;
	Thu,  3 Sep 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426536; cv=none; b=QBpARkY1dReXUv3gBVldnq2s5/agyxsyzRszDUneNs99Ax8H7TESczOdrnDhvFHw+rtoFl7SA8qhmr2sFXii0cP/DQYKSYGwqayO6Th8W1iR8e/t6762/FDB2uIlmq5LM9TfWGQbt0XOAHci+2tHxxHa275myZdXxre5YX3kQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426536; c=relaxed/simple;
	bh=MPX+WMtGjQc8B1VAZ+9iCbrZvCrmn1A91GaeT9JpBCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6Z4dR42lkLUw7ILXaFGKsiw4XUsbBTZUw9occzgcmcAkc6nWgfjwnbmpEitdATb8QMVONOzEiZS2H87yJVNX/cl8rfpk5T6qkPgcieYzIkyR2BQOpFO68FdjIO21DPye1Aw+85b1JcVpLVhYy2cy8rQNzruLU7iJt+PoBl6PRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 2E747C0CF2;
	Thu,  3 Sep 2026 11:08:50 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: miquel.raynal@bootlin.com,
	alex.aring@gmail.com,
	Ibrahim Hashimov <security@auditcode.ai>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	david.girault@qorvo.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wpan v3] mac802154: fix use-after-free of sdata via queued RX frames
Date: Thu,  3 Sep 2026 11:08:41 +0200
Message-ID: <178842650120.4023173.10327300985698277463.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725135154.99876-1-security@auditcode.ai>
References: <20260725135154.99876-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Ibrahim Hashimov.

On Sat, 25 Jul 2026 15:51:54 +0200, Ibrahim Hashimov wrote:
> The RX softirq producer ieee802154_subif_frame() queues received beacon
> and MAC-command frames onto local->rx_beacon_list / rx_mac_cmd_list and
> schedules a process-context worker, storing a raw mac_pkt->sdata (and
> skb->dev == sdata->dev) with neither a reference nor any locking:
> 
>  - the lists have no lock: the softirq producer list_add_tail()s while the
>    mac_wq worker list_del()s, so sibling interfaces on the same phy corrupt
>    the list;
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: fix use-after-free of sdata via queued RX frames
      https://git.kernel.org/wpan/wpan/c/2f37fba846c9

regards,
Stefan Schmidt
