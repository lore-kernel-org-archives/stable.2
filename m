Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942835;
	b=imaMVHf8hZ5pkxpQsveWe70aC966hJGpZUAW/qLWVCmOtmVPQTFao+0oLOS8KN7D53LJ
	 Iy33L0suun30lCib7WXXqkevMzPL1DS5kI+bs+lpEA9CkCicKqQlm4dxYwl6TWwgOX/rR
	 89Kx52iAM3uNCsw8kTgZvhKQhiH4YednzzkB4JlBq5OaDy+70gxi8ytdGkTPCUD4+nzts
	 qmbD+aDbX6t0k5ETYg2PrMIQX3OqsY66oF//myiGQ0gP8T3RCfguU/O5ws3uecd9JkjwW
	 gGy9fk7WImEd0WGeLn2hQBqb28rvUeY63l0/iZXJBH5gkCGH+Pp6jzCPIMYsZUErrPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942835;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=cV6zCHqgqIXodqu1pLKZgWGLibpyplphNM97IttR0BM=;
	b=PiBGWkIpcA0WHXm68rtewKII3yG9zuLWxWwVkKby8Sv33pMTny0b/kVs8sU5hxIhPPtB
	 w9rMElAq7AlAMIfmEyvK+eqN74f7ff0ht5Q07aZ0Glk5TaHHGR9whyZdHJXPeVO6M4iuy
	 etSFE5hYZcXv5cZg0kHyqkdXXTZqFiBCidQbxzSDGqItZXdt66UWWiqBo5/Mu+rM1u5on
	 +dffpFMOIbeg7djOb9mFO6zoqv4S4ZJr5QYZbAuDKsWMA4OlqbaGoGYfvfYEbhTVNnZKr
	 OC/7z+Y0pnpMDOJonmPbmctk8M2JxPjgQy37bNDTbdJzy1ph6OK4ypF6qMGxpMJt9ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N7ECeJyd;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43CD606A32C;
	Tue, 17 Nov 2026 19:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D43CD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N7ECeJyd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cV
	6zCHqgqIXodqu1pLKZgWGLibpyplphNM97IttR0BM=; b=N7ECeJydX0kt4fxJRf
	FXJZUmNKhDNUee+aGAxUZoQrkuwhdGcxX965+MU4qSdMrvEbwYAnkx1Tm3wGxSEQ
	Y1+PPV5Y0dWMJBu9oLziAhCDPlDSr4CWvYviR3wLbko/sqyFHuyXDqRzEKAX2L3Z
	DMyFfQ2XueZkg0CUEuNWkbALI=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X7BHp_xqK590Hw--.29024S2;
	Wed, 18 Nov 2026 03:13:12 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: handle empty transfer list in tx_status
Date: Wed, 18 Nov 2026 03:13:11 +0800
Message-ID: <20261117191311.2146922-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avyaLhOo8fdAIvUi@lizhi-Precision-Tower-5810>
References: <20261115080245.910534-1-zihengw03@163.com> <avyaLhOo8fdAIvUi@lizhi-Precision-Tower-5810>
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
X-CM-TRANSID:_____wD3X7BHp_xqK590Hw--.29024S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAFy5uw13CF13Aw4xJFWxtFb_yoWxWwb_uF
	s3G392y3yUCF4fCF42kF4Ikr9IkFWxX3WIq340q34SyF9xAFZ5JrZYg343X3WfJwn5tws8
	C3y5ZryfCw1YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0K2NJUUUUU==
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7QrVJmr8p0oNSAAA3q

On Tue, Nov 17, 2026 at 01:17:18PM -0500, Frank Li wrote:
> suppose below patch can fix this problem
> https://lore.kernel.org/dmaengine/avdni52GEjf_B3vE@lizhi-Precision-Tower-5810/

Hi Frank,

Thank you for the pointer. It looks like the same empty-list issue in
the Xilinx driver, and the list_first_entry_or_null() guard is also
what this patch uses in at_xdmac_tx_status().

Since my issue arises after terminate_all() empties xfers_list in the
at_xdmac driver, I am not sure whether you meant the Xilinx patch as a
reference for the guard, or had another suggestion in mind. I would
appreciate any clarification.

Thanks,
Ziheng

