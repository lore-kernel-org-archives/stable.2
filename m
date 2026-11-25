Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616447;
	b=JzF/4ZL99/TVR7htLquFWalC1nBTn0I74k5WvXydX7+/LKXH/E1fn6KhVohDPWnULFIf
	 Dj35tib3sBgezSvBXtuB9OYZjUyPKiafL+PdOKFSSnjILmocEtCQcQWpddUBTyevkQgwI
	 ZH1RwZtQTRhpSlCK0g0jZyS4WVImLWbimDm7wWGx2Hw3GIypMOHsWY3lkjtPoZFR6tlJ1
	 gAX94IA6XscaWsf6ae+M5InWnb4ggCgevT1QGm6aDKFefmYyk5/4M+T7s9yOugAYhocau
	 jedas5UaV/d5z9KN+w0KFneX4scVNlJOylTQyD52q+xHWBg+PWT0Qi9mbx2D6CwPQAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616447;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=CqPZkR6s9fvAZktok9XJEnxIWf3C/I6wGKX26MKaVkk=;
	b=uM8oGe4mkfGYuQEzAjl7/meT+tbXNcdmqGg3l5mulg1PCohupP4xXH9tze3auA1Ppree
	 x7YECkn2YHxQMF61DPfSy2cg3lQMME7bImk+UVatxvKRCn1OUHvrpCesQ4YyttmTza8Nf
	 wc7swZgH+bOdi+tqaSLBIAUZCDRatrP/QjwrSaEKQVPz/irPRUNDf8YfVxW7Yza7X+D1N
	 jKyznRw7y/jPn5RhIcpn76I4Ph6PbNuEJuGMYs46xHkw4mhODjmvjO2zsIjIRnAJDcKrB
	 ZXHqN8YO/vZmy6muJl99YEk1MkJQIii+S53p5tbT5nzBXP4zhpp58/8EHqF5B7L0vqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D6606A321;
	Wed, 25 Nov 2026 14:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 095D6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5B39F42D01;
	Wed, 25 Nov 2026 15:20:38 +0100 (CET)
Date: Wed, 25 Nov 2026 15:20:36 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vincent Jardin <vjardin@free.fr>, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] ipv6: fix IPv6 scope check of the source address
 in a VRF
Message-ID: <awbuXn2EYlusghUb@luna.proxmox.com>
References: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
User-Agent: NeoMutt/20260616
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795616437643

Gave it a spin, consider:

Tested-by: Gabriel Goller <g.goller@proxmox.com>
Reviewed-by: Gabriel Goller <g.goller@proxmox.com>

Thanks,
Gabriel

