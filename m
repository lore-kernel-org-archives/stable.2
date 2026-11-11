Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412156;
	b=MwldPUbGXGivBwfY9LXgitgTcQ+CWoLLdtxq+7DvjquZFw1sP1jTlwbawivJ6CsAkTBr
	 YdbSHthQrl0JLBYOFbRefPDd9aedia0xYZstw52AiI5ynguhZagtchBeql+Q25iFC+atX
	 xwfEkk9aU294Ud2XkmKb5Wb8FBQfRUpYtg9Jn4pLJB1aMf5lFZ9hubac7OcfCNIjb01tK
	 QLfxlWAAqKH6BeJI+3hDPLcD96OWM04ir1mcUz+EA4RsPcpeHcn1rM26XIt0zHOQUad+z
	 TCU94rAH73kFfTGo2awrHJNQXHG+bcmXlha+KZ5hdNc3QSyMLBnx0rfycaKhAqa+PYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412156;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
	b=BK0J9qpLs8qNV/zzgTSFhDusdj8Tz4HLXtUTvTKPh98REKhQh9ZEchTIv20IBzPbFxk4
	 /kaktj8xvWoRYCDjXr9CTiuek/VwxC6jfwMn/qO+nliiMsTo1+2FDdNvR62EVuCm1IzcC
	 Rr59EGW7vg+52oA+khKc11TOaZn91iatgXC01ZtX4PzBvJXUZ5n5kzLIfhRsFMYI0wiPX
	 8rbFwOudRxwK12oJKpbTswf28jl3S7qC8xm45mjsoqKCkaZr9Jpi0JnjSl3TjHG1kvm7B
	 rcIVD/4O4KddCrzxZx+EnJELq0RdnrofKBr4fdbTy3oo8F1SX8I1OHbRjnLG02MjpFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmQDo07x;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sWYYTTHF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71C606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED71C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmQDo07x;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sWYYTTHF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794412154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
	b=JmQDo07x7xWRbfEQE4iQqmEHhfWSlOUt1ysjeKzg9IcMwJmQIfuad3MQLdVTmus0XY4mM2
	8+xfc9sHv12emN7pb4DtRJ3+YrRQJ+p2FXd4WgBFIIS8spOASaXrfCeTToXrP0TgqUaak8
	aD8NlfzKDV8wmOsUJ5n0X5x5D+CeR8Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-jbm6y931PUKDIL5GdRWKJQ-1; Wed, 11 Nov 2026 10:49:11 -0500
X-MC-Unique: jbm6y931PUKDIL5GdRWKJQ-1
X-Mimecast-MFC-AGG-ID: jbm6y931PUKDIL5GdRWKJQ_1794412150
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49337a224a8so2912839f8f.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794412150; x=1795016950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
        b=sWYYTTHFxFkChOge2dL3RnJ6C9vwyuLF5f8Bgy1itS1v5gW+S3RjMHGUX2cH2b2Xw2
         wGpixVsvmNgcX+lxNPmD5np+dyycD66cBUlcniLuS7FnVkvVvzXZXLL7Qm6/yrpTxrmL
         l+j7U1Ns7XWzTczrrMhN/2jTJmmf/ZBmJ/YN6WayiM8IMWwauQxfBIl8i4jm391Qj7I6
         /jxpFdV5l3JFr1na4oj89wmd0vsJM4CnUtjgnOkAHj/3TMC6/gLqf7upqDvvy/czaqow
         Ev1h5QgrH/6ci2sIibfyjvvdn0iviWOJFGZzfiS+Ng4Cm4O7EUc5fGuG6ulTYpDr6Wnp
         y1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412150; x=1795016950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNXNrwuoyZ1DP7EX4o/hQb3f/LJ1H5porXRD6RrT6/I=;
        b=jREtv6m+pAmxVaBjrqxZuUwdfw5RUSSID1/1wxhty1DzSeGUx15SOXB2xYrAithf5M
         MX5IDmIryD1uITc4RtZ0NFK3w5ha4HWDJIwlCWgUooJsrqkfX8J9lPDirZY8Nj1DdBme
         499mj+C8UDQBPLd+v01CIIzrN5QanSsOWGH6+jaIu7s2I74BYd0SG0YNr3ICSiWuY0Eg
         TNnELy1DP+cIbJvQemROXkrzIvw5LXrCUpLdUwslS8w7HMSen+k69tVgsWW6f0SRhFhU
         QWUJJLEpsNHOMFT5MTVeBAQixHfBArZ3+rvJotn8RIFNMoEXxZXMjp7KuvG3MLNBN7lD
         0E1w==
X-Forwarded-Encrypted: i=1; AL+hErHR0udqhSkQOcJVLa+/lsjc0x+wfHI75AleZcRnqKTP6GyRSZovRtPhF8IaP0JSqOWlc1Rbxlo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DrFXipus+ngjyw9VFgWaOnTtOzX++Duy9ebxexBBtEzAn5vi9
	Hx86fsdkfZQYtdhFEG3FNbUw6A4mpzeAnYFLKZIt2Z1Vrf+IYzpEIhTKNKpYqrHVLPGeU8F9nNm
	XACQmSrBfYQs0MNq1GItKLrpwFFdidpHrrEWhabEfun5QaRinUh84GA72bg==
X-Gm-Gg: AYBFou29DiN7Hp/c4+Xm0iR8I+eD+vbFBB9/GcgWvLgr3A/ds2jLzT8FsnbvieN76/O
	N+mVGliCDiPhDqFXkKAyZ/XKkKu8qNprjLjAMe8qdwoMoeg+rW8gnjMtd788NOtkSnOFRKavzi/
	uNXZQSEKXHdD4p2XVHlWgOPiscPs/jI2CCCEAfq7IG2xwdCTXrX7aZ9Ktsxx80lLm8wIWd7oIXZ
	V/ZYJ5EXY+EzHnufXka3YUaxCSgkjoXwLLvcWOzaaxaZm8xwxytFconHYRY58hs0BJzuwvKZ0VU
	ZAMB1xU0G5HHUTVLEvUy5Oh72OhEwKnKuyaFIh9hcB1SfIkisyt8F+U6oXcEb44/oD87cP3PTh8
	wC6JUWhqabM2FHsVIA2Qj+mMU1NPPTNh2lw1iq28ZOw==
X-Received: by 2002:a05:6000:2612:b0:490:2bd4:5c42 with SMTP id ffacd0b85a97d-499c86a110cmr4320650f8f.44.1794412150159;
        Wed, 11 Nov 2026 07:49:10 -0800 (PST)
X-Received: by 2002:a05:6000:2612:b0:490:2bd4:5c42 with SMTP id ffacd0b85a97d-499c86a110cmr4320595f8f.44.1794412149503;
        Wed, 11 Nov 2026 07:49:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498357648f0sm12253487f8f.12.2026.11.11.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:49:08 -0800 (PST)
Date: Wed, 11 Nov 2026 10:49:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitrii Iakunin <zeil@nebius.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>,
	"David S. Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: validate IPv4 checksum start in
 skb_csum_hwoffload_help()
Message-ID: <20261111104557-mutt-send-email-mst@kernel.org>
References: <20261111120448.49979-1-zeil@nebius.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111120448.49979-1-zeil@nebius.com>

On Wed, Nov 11, 2026 at 12:04:52PM +0000, Dmitrii Iakunin wrote:
> Commit 6785011f8b16 ("ipv4: validate checksum_start before completing
> checksum") added checks so that malformed CHECKSUM_PARTIAL metadata
> cannot make software checksum completion write the folded checksum
> into the IPv4 header.

... after validation but before ip_do_fragment received?

> skb_csum_hwoffload_help() completes checksums in software when the
> device features cannot satisfy the request (e.g. via validate_xmit_skb(),
> ieee80211_tx_skb_fixup(), openvswitch queue_userspace_packet() or
> ppp_bridge_xmit()). Packets built by AF_PACKET with PACKET_VNET_HDR or
> by tap with VIRTIO_NET_HDR_F_NEEDS_CSUM can reach it with a csum_start
> that points inside the IPv4 header, and this path was not covered by
> the earlier validation.

And so what? it doesn't go to ip_do_fragment. if af_packet
wants to inject malformed packets, it already can.

> 
> At the sw_checksum label, for IPv4 packets, require the fixed IPv4
> header to be pullable and reject csum_start values that fall before the
> end of the IPv4 header. Return -EINVAL so callers drop the packet.
> 
> Unlike the sites added by that commit, this path cannot rely on
> earlier validation, so:
> 
>  - Locate the IPv4 header at the depth returned by __vlan_get_protocol()
>    rather than at network_header. After skb_vlan_untag() pops only the
>    outer tag of a QinQ frame and the skb is redirected by tc mirred or
>    bpf_redirect, network_header still points at the inner VLAN tag, and
>    ihl would be read from the TCI.
> 
>  - Reject ihl < 5. ip_rcv_core() has not checked it on these paths, and
>    with a sender-chosen ihl of 0..4 a csum_start inside the fixed 20-byte
>    header would otherwise pass the check.
> 
>  - Skip the check when the network offset is negative. On the PPP
>    channel-bridge path (L2TP or PPTP), the outer headers have been pulled
>    while network_header and protocol still describe the outer IPv4
>    header. The IPv4 header of the packet being checksummed cannot be
>    located there, and those packets used to be forwarded.
> 
> Hardware-offloaded checksums and SCTP CRC handling are unchanged.
> 
> This change only covers the software fallback in
> skb_csum_hwoffload_help(). Other places that call skb_checksum_help()
> directly are not covered: drivers that fall back to software after the
> core offered hardware offload (e.g. wireguard, igb, tg3), and core
> callers such as xsk tx_sw_csum and netem corruption.

what does this mean?

> As the earlier
> commit notes, validating the metadata on input remains the complete fix.
> 
> Cc: stable@vger.kernel.org
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Fixes: bfd5f4a3d605 ("packet: Add GSO/csum offload support.")
> Assisted-by: claude-opus-5.5
> Signed-off-by: Dmitrii Iakunin <zeil@nebius.com>
> 
> ---
> v2:
> - Locate the IPv4 header using the parsed VLAN depth.
> - Reject IPv4 headers with ihl < 5.
> - Skip validation when the network offset is negative.
> - Narrow the subject and document software-fallback paths not covered.
> - Update the Fixes tags to identify the original introduction points.
> 
> v1: https://lore.kernel.org/lkml/20261102140633.42564-1-zeil@nebius.com/
> 
>  net/core/dev.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index df1a840b0334..fafcb8f7ff9b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4111,6 +4111,9 @@ static struct sk_buff *validate_xmit_vlan(struct sk_buff *skb,
>  int skb_csum_hwoffload_help(struct sk_buff *skb,
>  			    const netdev_features_t features)
>  {
> +	__be16 protocol;
> +	int offset;
> +
>  	if (unlikely(skb_csum_is_sctp(skb)))
>  		return !!(features & NETIF_F_SCTP_CRC) ? 0 :
>  			skb_crc32c_csum_help(skb);
> @@ -4130,6 +4133,26 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  	}
>  
>  sw_checksum:
> +	offset = skb_network_offset(skb);
> +	protocol = skb->protocol;
> +	if (eth_type_vlan(protocol))
> +		protocol = __vlan_get_protocol(skb, protocol, &offset);
> +
> +	/* Use the parsed VLAN depth: network_header may point at an inner
> +	 * tag. If the network offset is negative, network_header refers
> +	 * to bytes preceding the current packet data and cannot be used
> +	 * to locate the IPv4 header being validated.
> +	 */
> +	if (offset >= 0 && protocol == htons(ETH_P_IP)) {
> +		const struct iphdr *iph;
> +
> +		if (!pskb_may_pull(skb, offset + sizeof(*iph)))
> +			return -EINVAL;
> +		iph = (const struct iphdr *)(skb->data + offset);
> +		if (iph->ihl < 5 ||
> +		    skb_checksum_start_offset(skb) < offset + iph->ihl * 4)
> +			return -EINVAL;
> +	}
>  	return skb_checksum_help(skb);
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);
> -- 
> 2.52.0
> 
> 

