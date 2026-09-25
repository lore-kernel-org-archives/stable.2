Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A218E025
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359694; cv=none; b=ksM98rP2ng/JCXp7Tu5QhbQktLXw+BFRX1BXwc9vcaeH+7eG2NjQ4MK/O03boIkr70RtH1EWn5xjHoPWyqzugESG14wqudXKkmxjySLZSxDkONlf0OhXsDghvEzxh8ZyWaUdFj2MmPdZMaEOw4NfVsDiriXZMBrdJydq2LauObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359694; c=relaxed/simple;
	bh=YWAleQXRs2MJb3aPe0X/tf0CkJQOfkPUjqBznQefgME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur4ZY/as13hCb/pTg8wnPULcyZTG5yxjREXYXKTZNwF6qsC3bDlkNTvZ8+ByakPJ68flb1/4dqnDY+Jcfg694ESkjgfDUAzdmEyZXe1fzh6kNALlXLZGv0B1gM2Yxw3iTb8DItSJM+dd61O1YBXz5AwNaKxegGmX+1sQi6nE8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz; spf=pass smtp.mailfrom=grische.xyz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so6905295e9.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790359691; x=1790964491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EeBaURt4JWv0bo+NgSZ7c7BxLfPQXBf65HraIwaxvcI=;
        b=pzir/pseB8OxD/v74k9NtjV/sLMPZA10U8DmsNIvgrkivluEon3+X0dKl3rUHwf0W0
         cmLEBXJ9zD/yIdBFRB0nMWRnoRwPxegvgvfXmLJrYzksVp9xlVhMODNOJQV4ZLcK4rck
         RQK9EcAzuhS03oGMeUW2zKTje3Z2uMRWc3PULQNcvKrMmmUdC7VGSlQq6delD0huTozM
         8cn8raP8P/uhqsHpB236QH415DAuacN53XJDoesLvEi8EnK3/ai0HP30CJTdMfDIrtCQ
         tVvE8HN3RV35f4TOzT9nKa15i3YDjjf+49h97CHqaK6nNOCHetWTgtT0yN3pXtAackRl
         fFgQ==
X-Gm-Message-State: AFuF++nQ2O85B6R4C/0XA4Nbl9jI2ihTZpIroAKcNymQpjCeEkME/FWh
	0r9WFKS0h9drlvqJsGcFiLeNBUndpd7QVN90lLqPWKEDa29ktRYjVv3JSEiHX+iTfhJhElDGcMn
	96c8uUP2Zog==
X-Gm-Gg: AYBFou1jr0vBneHwqh2cA8lZ0svrJRW0dA0x5RkzpdQW2kK74x7/rlsUvIUKTy7CQLs
	QMJgYU4rX7R6xBK0OtoWwoQ/jwaZEZCmjW+/iJBVKEmqVy5fwCXTwHIbNOdpxeOdiRzuarZRdaq
	R0yHBwP8BLAn64EpD9qDeUpKWnhATxwaMvG6Lb//7BnLIsGXD28goNcpbsxoVSlBOpg54tYPOW4
	/KSK2M+e267ggsUnLAulWNRgYGL/ntwGNoiHhaVadumMuQFURSWismXEcVwjUYs5u1hAy/oMgx7
	1kVUodykd/QWKWYSWAAyJPisP3O2v6+GY1dH3FmJgIo9swT70/RV6kT3J9qiQCsbO2ccQ+g/uEr
	y9qY7XNDac1rPC2TV+tuT9cRm5Lolids39Pj+95x6mXwywW0DGTFZL5Tm/5ilXKgOX/xcZCTrjo
	4EB0jeCIFID7HzCipvsuLE6fHdjUS6UJu8jS/PSCSiUxfAVkY/p5ns+ayxDRuHFF72d7o=
X-Received: by 2002:a05:600c:1daa:b0:49f:ce78:3568 with SMTP id 5b1f17b1804b1-49fe66fa94fmr101704765e9.25.1790359690828;
        Fri, 25 Sep 2026 11:08:10 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:58b8:6ca9:69ba:902d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff264723csm66272715e9.4.2026.09.25.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:08:10 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Guillaume Nault <gnault@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 6.6.y 4/5] vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
Date: Fri, 25 Sep 2026 20:08:09 +0200
Message-ID: <20260925180809.603571-1-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812091127.1349673-4-sashal@kernel.org>
References: <20260812091127.1349673-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,

The backport went into 6.6.153 together with "net: harmonize tstats and
dstats", but without the later fix for the same conversion,

  8431c602f551 ("ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS")

which went to 6.12.105, 6.18.50 and 6.19.10 and is tracked as
CVE-2026-23459.

Without it, iptunnel_xmit_stats() keeps bumping the tstats syncp,
which overlaps rx_drops in struct pcpu_dstats, so VXLAN's rx_dropped is
corrupted on 32-bit kernels.

The netdevice.h hunk does not cleanly apply to 6.6, as 6.6 has no
net_device_read_txrx group, and it only moves pcpu_stat_type.

The ip_tunnels.h hunk doesn't seem to work directly in 6.6 either. In
6.6, wireguard, ip_tunnel, ip6_tunnel, ip6_vti, sit, geneve, bareudp,
gtp and amt still allocate dev->tstats themselves and leave
pcpu_stat_type unset.

I can try to send a 6.6.y backport with the above in mind if that's easier.

Cheers,
Grische
