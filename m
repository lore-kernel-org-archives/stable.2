Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7722F8EAF;
	Fri, 17 Jul 2026 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252287; cv=none; b=aLm5jfzMC9Knj0TOvHS4S00nP5tRkLXK/GHiGEbgdqZrpvzbgIPm+kZFIIa0RV1bofDkEwIud2tMPgAKbKXsdRJ2758KGnyf06/Pq8hwvxsrlLN34O0xP31ycf4Gyg5u2qHtc6st4UoG/5ulVhnsKbauPQFLOXlpzq+D4DUdfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252287; c=relaxed/simple;
	bh=CX7L8uQ/711vvKi9fmpMP0XVTVJfGvVDDSxDs0Y7z+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOlNXJNkgJnW1N0kNQ8GcAz7CpIFOV8Gjw1Gw5t1069Ql8a12fr2OxNxui3ZaHK11GgJW18l+gWkpIBCHEPWY3f9QRivnsCsl5jLLWAialyzO8SMQFR100OBHtQtuCgWiUHWvfsnbzIo8gzcRk0XmDJrYsH6vfZmGi3L/6xquPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF58RCVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF58RCVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCB31F00ADE;
	Fri, 17 Jul 2026 01:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252286;
	bh=25W18Ip+YrPYAP6wyH8PVlv7KlYjk1pkSckiOn/CT4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TF58RCVTB8bb9ncEW40JW4bxGL0Ye6VBleQbUeovrjbi7u+Ra/X8vxNbnOIyP4lTJ
	 0xovBh/UuPyJXoEnYJcMhD6L6HgnhxQogR4aATl9zbgCKBo63pzU/2271CuihblwyH
	 YFsrps6zKxKUhi0S+UbOqfnDmaIM1TNnFARjXMlSGS8AmLM6S4PJlRMUNmu+aTEjGf
	 XA4KsTGBRWdDKfX10bgeua5qrllW0gbYw23bDK2rrNjdeWymQdIDQTkYYmTiqCGb/a
	 wjw/+MAEdfDPyDwqMDq/Y5Z5HIvmVzauAAc+rYWdWBBp98WcrspU97THmWU8ljLe8H
	 X/SbCn4AjZfjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	olteanv@gmail.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: Re: Please backport: DSA taggers OOB read on PACKET_QDISC_BYPASS TX
Date: Thu, 16 Jul 2026 21:37:43 -0400
Message-ID: <20260716232340.0019-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714164633.75135-1-doruk@0sec.ai>
References: <20260714164633.75135-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 06:46:33PM +0200, Doruk Tan Ozturk wrote:
>   eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
>   499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
>   f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
>   0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")

I've queued the tag_ksz fix (499b2491d550) for 6.1 and 5.15; 6.6 and
newer already have it.

I'm holding off on the ocelot and sja1105 commits (and their
skb_vlan_eth_hdr() prerequisite), as well as on 5.10 entirely - the
backports there diverge more from upstream than I'm comfortable
carrying without more soak time.

-- 
Thanks,
Sasha
