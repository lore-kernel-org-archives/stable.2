Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753540;
	b=aU1oUkHNCBEVXVDHACwQd2guT/4qmL9lXpu2fKvrGnfeEb2LlRgQNGrul9gNzo7sCalT
	 r0tjgSA5BQO8yft61mFMMaSF7u+nMJ6vKfVR18ls70jSG2bAPMYVh8MgSEVUkiL/32yfJ
	 Y8nBJ3PQ/M1tqgsUfMeKJH3kdrvo1Ix9rbz1RFqaSwYxDbNyVwgtrXS7scJO6VByndpoD
	 mnPsByn83py0mosjPH72DZhA6InGsdvV1lm0wifLf9cGJwZD2Y9nWmFv/Zczs7XHjZQiJ
	 WhiSQA64+R8H8yaf1SM1z8gLjdC6vHysWXTdZr2CQfE2r4zmE18hIZS65pjsllcUobw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753540;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XOihmqZ+Aq7zdWwCxAvfFtsHXPSkDrkI7WYrjtaeiY4=;
	b=TalnfOxZ15xZC1yhE0T/wjJhwV0YHpnVxb9wweOcO7/WEs3C1EbQdewUFQ2IlQqSvTnW
	 B7ItXUF047gj8P5bM5Z2m4rGI5aU4RKCQfIat5C5HZglwBnJoTWGj/ydTcAh+o3wGNy6J
	 /Ve/p57YpmeaD5gWUV5g4JpxibY2CsL8P7HbbhMwbjdV8vXtAq0g6QlD3omRMjJD0mIS3
	 1A38iqkv6cjv8YMmUVTUDCeiBmTa8FNnr3FEfzoQBTyYLljV//Z5P87vmhx0QH9mB1CpY
	 ZJC1kVIIwQj3dXfLDO2IERsCyKIosbb73iJri22q5PbVGM0m98i+y+LwqFNFXP4dZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD29606A32C;
	Fri, 23 Oct 2026 11:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFD29606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Mehmet Fide <mehmet.fide@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Michail
 Andreas Michalopoulos <mike.michalo@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath9k: drop WMI command responses when no
 command is pending
In-Reply-To: <20261020152412.95560-3-mike.michalo@gmail.com>
References: <20261020152412.95560-1-mike.michalo@gmail.com>
 <20261020152412.95560-3-mike.michalo@gmail.com>
Date: Fri, 23 Oct 2026 13:05:36 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875wyssmm7.fsf@toke.dk>
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
Content-Transfer-Encoding: quoted-printable

Michail Andreas Michalopoulos <mike.michalo@gmail.com> writes:

> ath9k_wmi_ctrl_rx() accepts a command response whose sequence number
> matches wmi->last_seq_id and copies it to wmi->cmd_rsp_buf, which
> usually points into the stack frame of the ath9k_wmi_cmd() caller.
> Only the timeout path clears last_seq_id, since
> commit 8a2f35b98306 ("wifi: ath9k: Fix potential stack-out-of-bounds
> write in ath9k_wmi_rsp_callback()"). After a normal completion or a
> failed send the receive path stays armed, so a duplicate response from
> a buggy or malicious device is written into a stack frame that is gone,
> and its extra complete() makes the next command return before its own
> response arrives. Sequence number 0, which means "nothing pending", is
> also used for a command once tx_seq_id wraps.
>
> Keep the receive path armed only while a command is pending: disarm it
> once a response has been handled, on timeout and when sending fails,
> drop responses while nothing is pending, never use sequence number 0,
> and reinitialise the completion before each command is issued.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
