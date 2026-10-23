Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764606;
	b=IkYjhP4HkS93OmqVXpzMYWLyiTqye/p1/ak5cxVdaYreLZuMOG57NZVmNMRhOPaiHGVa
	 3MJvodPR7dr3FhNWaZ105+GrrwIBemwJR1TDmYEc5816C0Q+hm/ELVVGsumLxg6cEOLuT
	 AXzDAhSQl+DKI4oNWSkOZNV2D/lb1klDSLVqeW3aGpvoVRKqrPIGU7Jy6omr1s7i7a3mb
	 dNtfodZDAgjP/gLOpeq8i2l+GSO5Ehn4T7DHkBYfmLmdC2CQRXE2si/lcyAlfwARXpD0u
	 9LsjIF23gmcsE9cVaNG/Z/IU0q76L19kEAd5P+vKQ2dbkErytc+OPWJYhQO995ZEtsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XPDo1N1hT7cCAK8LkHZsP5UZtpJRXF7LrSS7WPT3zsY=;
	b=pWACiiHmSdYT+8diIetsS5weNJWO9kJmibxQnIkmu/88NEWhQfAWQJeW/sziAHsr07RK
	 WpJHAzfNnnmi3T8XP6OauvfrMGmo+/MsjBU5wF63t1jdqEIP3ertnQpXfEFXh40K6DX9N
	 JC6zUG5ja2mmZDTx52ZO/08cXe6sMrRFa5Ea+k6u49y1BITKm5KzTOg/J7zYjkB5M+Oy3
	 fAmtlBV5ed/zRcTjREvrRpDV/lekGLtKmBJrNfV53WH9P15tWwC6hiolGSGQ+S2OwV6jd
	 2BuECb57gfCx9tPPsgZ4ZQc5KlDOzwRN3v5TbeyDSmJFCnCkYIv7tWZM3NBXmI6IKCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NTvzQ9Td;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF0606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NTvzQ9Td
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so8442455e9.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792764604; x=1793369404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XPDo1N1hT7cCAK8LkHZsP5UZtpJRXF7LrSS7WPT3zsY=;
        b=NTvzQ9TdU2e4irYs7q7441oWiK6tux+67MmXXQrw8zJ1LfSsV7SBaYxU/9PMhDSDmu
         0hcdyppcHq6cV9461E3xbWNphSJDcIYcJ057R9L7peez0OtpKjlII1Xd4sSK478p3gUk
         q4q6zMr7TyuOYPamkWVGJqdtnDMdH7B78ZFWVkBDdOjBKqiaTQtMds4aSu5ybaW2dZOg
         HJ5yuPmd10r/yP5Hq7VTJThh8O1sJ6Zp1CEzqLpcLVO+DEJZrJqr5AceQLmOD78DdppG
         a+TFUo+AVegRNQ9MEKzE4YYdDuMfMXNRY+jgKt2oifVs1G4zE+SY3nYZ2p352h5JXNLU
         Wl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764604; x=1793369404;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XPDo1N1hT7cCAK8LkHZsP5UZtpJRXF7LrSS7WPT3zsY=;
        b=A/XmwKe2v8srv9Uadn9EQxqzxAmxwlzBEUoMluM3V1rTXVynpBbkAlKA0co/Op0qzz
         59oNgXQbOjdRCJYw6jDLDJRzY7xdjNx3FFki4lJRAI0+NwSuZJeQqgfKKdx7svvbvH7C
         DyCBDGdy76tgvNioik9MtsEiQkrwkBO4ghT0EeResxFoo+xrYqgbOk7CIY6OiBf3iYSo
         6G73+WebVbxnYqUv3MILXCFct8zbqfNfLTsJNiGb1rylOYbOGgecp2KJfbr4xNGcie8h
         LEXKU3qOyD2tVggUz8CXSKL0xDfnpxHb5xZhQFlYcgkt3lWvKRnnZAf52K4Sn9yl9cRK
         kqFA==
X-Forwarded-Encrypted: i=1; AKwUvBxUOUHYRXJdgdsy85Ue8dFaDvzdS9gMg4k30DobpdiUVVikfsjNCUGHnyRQuHp3fdj1lHiy1GA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ+pgty+fD+UVPDt5Sq6j1hsR+y0pM+m9qpkYq3mEXi6ndWlua
	6fnc39ojJfGbBbODSCgUyFNw1zO0Bbniz6HOtFNu42ihI/I4Ur1sHXbIAYn+gZ3qGsEfKgMXtLa
	s5VQOKp+0uEM9miQOWMSoQXCKFUSiTOYpxMnFo5CLfqgMQLn7E7qnKHW/xImR/7YCAw8=
X-Gm-Gg: AYBFou3aclN9dMKJ8GlhIAix9ZqzIKzoANWViy4klnZPGg/qTEVJjGrVkt8QaKG9Iei
	UOc6wdTyW6yYFeSt1+rTpUGeUqWXn8P2LiL68lrE375KNZ7CNFHXF9oGhHoPeT16d3AfTJm1yeX
	TyEkV5BXxPsTZlajvIVmTk6u1O1/nQGTx/audBOnjcjfCdoQ0FxvSd8pBrO7RME6DRVji1tvWPP
	bcVjojmRt7dLbIWm68bY0Ky3KLFrHH45ctNLNSO6gbR/p/f6YNhQjj74bvf3nCVaDYCh+AXkzqB
	rvf8/AG35GRjhLjSc8K6xRYSknD3CbKhB3RbJ7rofGxXDmgge4TC7BVonTV8idLD0R3Wg35GrYH
	cMtOFQcN24EAZfY6yqY62QQ3zRNScXaNyqQxZNmc3PQopj+LgCV9SPIt1mnVfJbhSPpVi2i/8Vz
	J9c0AHZPb+dnlAN5OSattLNVRH4Zkz7PZl7RcnWb2QQHghgE+/9zWO2VRI8rfIHq3ysA0nzXMMe
	RuX5jCf8XMlN63fnmmNN7477sOb8uJtCQS+a1kJoDqTX7rSIOCbT9GvZgloOnxPpT4hMdnTcpaX
	NR6Hz6fqbUyFbS+8U2YSNXNY2e4sP41hEuWkZkQ=
X-Received: by 2002:a05:600c:c493:b0:4a2:8f4:96c with SMTP id 5b1f17b1804b1-4a211edd672mr36756275e9.29.1792764603841;
        Fri, 23 Oct 2026 07:10:03 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:5940:e951:c53d:9e75? ([2001:67c:2fbc:1:5940:e951:c53d:9e75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2a92a4444sm7330705e9.5.2026.10.23.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 07:10:03 -0700 (PDT)
Message-ID: <ef4da481-9332-4e72-976b-e90d3fb571ee@openvpn.net>
Date: Fri, 23 Oct 2026 16:10:01 +0200
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
Subject: Re: [PATCH net 5/7] ovpn: fix UDP TX byte accounting
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, stable@vger.kernel.org
References: <20261022121606.732029-6-antonio@openvpn.net>
 <179275784775.3134.7765670827133808012@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <179275784775.3134.7765670827133808012@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'll have a deeper look.
Some concerns, especially about the stats, seem legit.

pw-bot: cr

On 23/10/2026 14:17, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] After this patch, the ovpn netdev's rx_bytes and tx_bytes
>    measure different layers.
> 
> --
> 
> ovpn: fix UDP TX byte accounting
> 
> This commit resets the inner network header in ovpn_udp_send_skb() before
> the skb is handed to the UDP tunnel helpers. The goal is for the ovpn
> netdev TX byte counter to include the OpenVPN data-channel header and the
> authentication tag.
> 
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index 7672094a67668..05e10a2ed1791 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -495,6 +495,9 @@ int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
>>   		return -EADDRNOTAVAIL;
>>   	}
>>   
>> +	/* the encrypted openvpn packet is the UDP tunnel payload */
>> +	skb_reset_inner_network_header(skb);
>> +
> 
> [Severity: Medium]
> With this change, do rx_bytes and tx_bytes on the ovpn netdev now measure
> different layers?
> 
> UDP and TCP share the same RX path, and it counts the decrypted plaintext
> length:
> 
> drivers/net/ovpn/io.c:ovpn_netdev_write() {
>      ...
> 	pkt_len = skb->len;
>      ...
> 	if (likely(ret == NET_RX_SUCCESS)) {
> 		/* update RX stats with the size of decrypted packet */
> 		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
> 		dev_dstats_rx_add(peer->ovpn->dev, pkt_len);
> 	}
>      ...
> }
> 
> UDP TX goes through iptunnel_xmit() / ip6tunnel_xmit(), which compute:
> 
> 	int pkt_len = skb->len - skb_inner_network_offset(skb);
> 
> The inner network header now sits at the start of the encrypted packet.
> So TX counts the opcode/peer-id (4 bytes), the packet-id (4 bytes), the
> auth tag (16 bytes) and the ciphertext. That is about 24 bytes per packet
> that TX counts and RX does not.
> 
> In effect, netdev TX now follows the per-peer link_stats semantics, while
> netdev RX follows vpn_stats.
> 
> TCP TX uses yet another convention. ovpn_tcp_send_sock() calls
> dev_dstats_tx_add(peer->ovpn->dev, skb->len) after ovpn_tcp_send_skb() has
> pushed the 2-byte length prefix:
> 
> 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
> 
> Other users of the same UDP tunnel stats helper do the opposite. WireGuard
> sets the inner network header before it pushes its own header, so that
> header is not counted:
> 
> drivers/net/wireguard/send.c:encrypt_packet() {
>      ...
> 	skb_set_inner_network_header(skb, 0);
> 	header = (struct message_data *)skb_push(skb, sizeof(*header));
>      ...
> }
> 
> Take the case the commit message calls an undercount, where the inner
> header still points at the plaintext. Before this patch, UDP TX counted the
> ciphertext length there. Since the tag sits in front, that equals the
> plaintext length, so it matched RX.
> 
> Is TX meant to include protocol overhead when RX does not? If so, could
> the commit message explain why? If not, should RX and TCP TX be changed
> to use the same convention?
> 
> The mismatch is still there at the end of the series. "ovpn: fix TCP TX
> accounting for locally dropped packets" leaves both the TCP TX
> dev_dstats_tx_add(skb->len) call and the RX accounting unchanged.
> 

-- 
Antonio Quartulli
OpenVPN Inc.

