Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8036E477;
	Sat, 19 Sep 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803942; cv=none; b=WBPArSNznHLCWwb+GG/TgC9oAkJC3Uq/BoHj0IHFVLdmjcsT9eoIodS15Hw+ecJK95Kh5ramtxjc+cSJdzeHnL3W4BU2tq73GFfBDslLVnVWJn6NF/Tq8DNr4t48xnxClF8ZzgGE2OF4gkxh/yY78EF35SVZcHOFOENlwy9m0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803942; c=relaxed/simple;
	bh=iHjEtvjbwZp8MtMoOBYjMuSiYtqWJ+rzoYqQalSQTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp28GYBD/J2wPSWtHqkxihjTZtdZO2GRaUUwWgWQTMxUGiVP+NvY+qDadd8AdD3M87d9RP1/MY0E9JJvA4UmAEJ75rksJzWWNaD5BvWqABTCLubR4tLHyh98l0sPqOMF2bb8sEOik+vp5/i8dRQe7heDkepCjljrTPgKqtuDzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfd46SK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfd46SK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D591F000FF;
	Sat, 19 Sep 2026 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789803940;
	bh=MdyQMSas/1xgWPnQhVBvbmhKhHLwQVZ7dSRO+2CofI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dfd46SK0WLkecWkYIvnhZC9LwPN+FexFxPAX6WuJ2YU7GK/sTDCZN7u6nk8aXXHe+
	 8jkE+poTI9/hwU8+2pr31D31oIUmFNiEiqU4I0qEgd0zSGxCDDtzshYF56zdxvSCEY
	 bRpI3Hr7EsCiJFBt5vTM/diAVFVv563gkoWfnKQ4whODGcnNxQnERlC6PSS44NhFHx
	 9cNRzdLizOTu0D53MSOV58Vw9q6Epb/wcX5FIcJZ25HKU7jAnOOm5v2wbY34I7xl0b
	 V0UdrTncbd4utGF9QeYcyxIhdCHhb+c4VZnItdFJviXF4Evls9S1gTsoIIpCbtcSSj
	 VBM2gBsYgHiow==
Date: Sat, 19 Sep 2026 08:45:35 +0100
From: Simon Horman <horms@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jakub@cloudflare.com, stable@vger.kernel.org,
	co+0ea1ac045375cf05@bugs.sh
Subject: Re: [PATCH net] vlan: require the MAC header to be present in
 __vlan_insert_inner_tag()
Message-ID: <20260919074535.GW51261@horms.kernel.org>
References: <20260915083152.705309-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915083152.705309-1-xmei5@asu.edu>

On Tue, Sep 15, 2026 at 01:31:52AM -0700, Xiang Mei wrote:
> __vlan_insert_inner_tag() only guarantees head room via skb_cow_head(),
> never that mac_len bytes of MAC header are present.  Its ETH_HLEN
> wrappers - __vlan_insert_tag() under skb_vlan_push(), and
> vlan_insert_tag() under validate_xmit_vlan() on the generic transmit
> path - therefore rewrite the first 16 bytes at skb->data: a 12-byte
> memmove plus two 2-byte stores at +12 and +14.  No caller supplies the
> bound, while the pop helpers use skb_ensure_writable()/pskb_may_pull().
> 
> An IFF_TUN device has hard_header_len == 0, so packet_snd() accepts a
> one-byte AF_PACKET/SOCK_RAW frame.  The first vlan push only sets a
> hwaccel tag; the next - clsact "action vlan push" or
> bpf_skb_vlan_push() - enters the helper with skb->len still 1.  The
> head comes from skbuff_small_head without __GFP_ZERO, so each push
> drags bytes from beyond skb->tail into the frame.  After three the
> one-byte send leaves as 13 bytes carrying 11 bytes of uninitialised
> slab:
> 
>   0000: 5a b3 62 12 80 88 ff ff 00 b3 62 12 81
>            `------------------------------'
>   only 0x5a was sent; the rest is slab, here the top 56 bits of a
>   linear-map address
> 
> Require the MAC header the helper rewrites to be present, so such a
> frame is dropped rather than transmitted.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: co+0ea1ac045375cf05@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  include/linux/if_vlan.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 20cc16ea4e5a..4846032bf4ff 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -365,6 +365,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
>  	const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
>  	struct vlan_ethhdr *veth;
>  
> +	if (unlikely(!pskb_may_pull(skb, mac_len)))
> +		return -EINVAL;
> +
>  	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
>  		return -ENOMEM;

TBH I am surprised that we have a bug like this in this function.
But your analysis matches my understanding of the code.

Reviewed-by: Simon Horman <horms@kernel.org>

