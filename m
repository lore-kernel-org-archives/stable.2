Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027752;
	b=CT7n7jTPs2Em1TyONTR68YCYnov4VqjR9Rf2sUWeiFI/PW7/J3PZl2UqGfZ8Awap7UHR
	 yndx4PxXwKc7ie6qsSEdlAWctSvPmtBfhZefHJBddTnWXAKu77pMGtdsuT70l6ZOQJtXA
	 G4KXJNNogntAP6b3BynL0oUO1I5Jtiptahv4NUOPj3VaKLivl7Qu/3Exxls8TXM+vh0Nj
	 Z6EVI0EmdySKQNrcpfFvOayd56a3Kk5ykTmpVivUkGoWPydIAyd2nXwes7V5GYfH0r9Wv
	 obxhQF5Muj96Kn8g3aN6oGTG2F6Y5l+p33cW7N77+Oph4ad6W9nHlMU1MBV6+NFppzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027752;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=n3tYryr7zzQ8LqyZ0K7pIJBeJLogxInZJgVPz9lzEuI=;
	b=eH+B99HPIgtoRJJ+gCLYUVehOCxTPh+jUMkWBXTRqxhgqHdh2uVcGPu+yN/BjLbys+2u
	 D8n/yzv6wFcA2lsTi9qLfBpxDgC3Ezph0KF4k6C/FWiXPJYrbr7n/1R6/btUjfjTaeZWn
	 7ap23e0MNuQWFPgjgLJES5Ypjc0jzaGxKZxM42mlRRYXlpAJqUVncFWjWSPiip6zKhU1E
	 5sfPUMueXy0nQtuwTgcngspQkegjyPI6stlPJ3auLIIveTyVffgIoZbQ5rNvKZAkZbD4F
	 qYVMOmBEaYNo1396XUYTBYIOEV6y6ESD6QZ7oKJguuR8j5mib8A6p77yrt4zMr41aIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WZ96zvVG;
	arc=none smtp.remote-ip=91.218.175.32
Received: from mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDE606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 05:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BDE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WZ96zvVG
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n3tYryr7zzQ8LqyZ0K7pIJBeJLogxInZJgVPz9lzEuI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794027748; v=1; x=1794632548;
 b=WZ96zvVG3x71foE11pN/mEGy/Xu/62o9S+McTlC7mQAAKxiv1RwVW5rDjzH7CIfcKnQwS2vE
 hAjU3LBwvhropjwXwgCxhWsAjB1Y8JK+95hNsrxoSWTIer5iV1SWXBUFyQsUkNQKgb1HZq8xF/m
 ks2clnkfSx6ihUOw5AVpIeFk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 10673def8ae0b7b1;
	Sat, 07 Nov 2026 05:02:28 +0000
X-Mizu-Trace-ID: 10673def8ae0b7b1
X-Migadu-Flow: FLOW_OUT
Message-ID: <6cb5fe89-c6f0-4e84-b753-4425b1aebe1e@linux.dev>
Date: Sat, 7 Nov 2026 13:02:23 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: reuseport: avoid duplicate closed socket
 insertion
To: Lin Jiapeng <ljp1205831794@gmail.com>, Eric Dumazet
 <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org,
 Lin Jiapeng <jiapenglin@tencent.com>
References: <20261106135841.418-1-ljp1205831794@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261106135841.418-1-ljp1205831794@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/26 9:58 PM, Lin Jiapeng wrote:
> Clearing SO_REUSEPORT on a TCP listener clears sk_reuseport but leaves
> sk_reuseport_cb attached to its reuseport group. A subsequent listen()
> does not put the socket back into the listening section because
> inet_hash() checks sk_reuseport. However, inet_unhash() checks
> sk_reuseport_cb and calls reuseport_stop_listen_sock().
>
> With request migration enabled, reuseport_stop_listen_sock() ignores
> whether __reuseport_detach_sock() actually removed the socket from the
> listening section and unconditionally appends it to the closed section.
> Repeated connect(AF_UNSPEC)/listen() cycles therefore insert the same
> socket until num_closed_socks exceeds max_socks. The next insertion
> writes before socks[], overlapping prog on x86-64 and leading to type
> confusion when a reuseport program is attached or detached.


Is the issue same as Eric's patch ?

https://lore.kernel.org/netdev/20261106084300.2029567-1-edumazet@kernel.org/

