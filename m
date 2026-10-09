Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8650EC18
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569671; cv=none; b=jE358u99yV6jsm6nOD0IJ8oT3MKe8m8Ty4JdThxdBdvS7J3a47rCa4iRHZzo3X9E44VGmy42dIEVLCJg0D1MNea4adQ32ZmZKtzvrgMiPr4KDPxnSm4itVFewMIm7fQ8H/NSOXpomlLjm++B7aKrgVnLyImow/a4SiJqZMOhyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569671; c=relaxed/simple;
	bh=hmhp5aCfAowc1RH1ZLE5xg09F/tgIyMjcgJPa/87Xxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hSViSWZx0bcmu8gauGVkJcwAI/HS/T+AuAqQpthSE6s2P/c3iN6QW6261vqri2Qy7mEIZEfv8PIqm67SJktTEniOdaaqRIaQHfINn2NkQyy3EfPdr+JLOdyjGTMPEPerkHADnaw+8QHD6my1eT8vVf2RRArKi9YtesKA669wo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXilsdNz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXilsdNz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b63bd2030so1357886d6.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791569669; x=1792174469; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BmUaHEAjDqs57lG3N//XR/fYj5yl74K4ovqeCbA5msc=;
        b=RXilsdNzfJ72M8bImGfAbIxRYb5qr3aYOwHWmPo9m6vGwG8yWMfimC92Cz6Zy9Z+Dp
         v6kSmDuftmyOAtvZdtVyL+Odbyg9np5MyEoZ88H/VUJOkuiDmCi5yobSB4FgHO7JmOc7
         aAk9uWOSY3eVB+0L+DqJyU/EXWXgnpbrhGg83fldr2DII0c6ot/uF9FJjic5H3kbDCrI
         3nKp53CEULM7K9qsmeWQc/aRuhGL1y2kwuaJiq0JpMJv0C2purZTqB3Sx6ZO0IY4NUNl
         YG+90gs+T4kCrVKA3KFi798rl2yfjwNb9X3imKAwJRDLj2a22cl9oo05351kL9gbE858
         N1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569669; x=1792174469;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmUaHEAjDqs57lG3N//XR/fYj5yl74K4ovqeCbA5msc=;
        b=sukUOOrgEDbtL9qW8yqQ4yY6phhLVJVqsFf+lhLz2XjqlCWkkaSx5cdb3HLcb3lSvW
         2Xb7uLouYhOOZRRONjKKkWXlKuOKyptcD6LDJj0hcWMPzrSydtfrMothklKeX4/Z3IDv
         uolezawZN2Zek9okDVeuE1Q5Vn63CLiToecg253qREKQj23/AZyXP19n67wWWi9T5qa7
         NFE/0R2crZZzOaFyBgtL30WEh4v4YvJuAsy99jjKkNV55am4LUYaOSDUKUGKjitjtz5z
         TULxXgi2vLrr6JH//gaO+hDsE3qzfwuDWuhtbXxr3wSnL6THTlqSbcWaf1KfxlSgMwds
         +yYw==
X-Forwarded-Encrypted: i=1; AKwUvBxNsl129STgiDT3JVkioe/CiID+OXLV8eJDgoUIPrgHvsbBLpopF9Ppy+pKvzKgEVpppdi3Kb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCh7F2nqV2Z5KWKiYsoiL+7CEALB/9asLrtTkG9QiDHyQSnMyJ
	8yitUiYR0SnG3CIZkZAJJW+LdBq3jD2Giz457441cYpEoUJAlksAmXuR
X-Gm-Gg: AYBFou1c6pQXFUJpD+u61ys61d9N83YQ40B1Cud2Gjx+kTW7HBiTDXihQBD/FjmgQ88
	j1u7OMGUmJuIZPnGCb4KnbY0cTCMY6hd1YvtGcYGy/YG9Q3OHlOG0UMNxBr4OkmDypGlWTclCNX
	oRgfQwGP5j0+rR5BF8FPOcVZBliFbKnPykaHpOtZAt/Sjx/C7uBFseRgW6fVwN7laFde8LicRyS
	Z26zPIQcCNj7kjtklnitLS0K00vLgXsl5du/rjZxVO4hb1ovt3ZLKK39GyzE1HjlfWhZS+pVjP3
	y5z7kpGEsxdMNYHrSDKIdKo5tChbwG8Eq81GvpDwVoE0cM0xWpReW5DLjpHYBZ/+2fTerjDpYv1
	UQSnAda9sv1NzP9i4CW5DUZ91czNpatcWy6ex4z/AxevM/kN9oRRCjzaHNYinH8Q3nkrU0Fw28I
	x31uZYHObpyCsWO6sbG4PTZStN1anOOmJw0h7fq53WwgWvH/6WkoXdqzufko2ZR9vzMyUUcbUlO
	gM=
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id af79cd13be357-93ebcc1186emr416023685a.0.1791569668976;
        Fri, 09 Oct 2026 11:14:28 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0cfsm248923385a.19.2026.10.09.11.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 14:14:27 -0400
Message-Id: <DM0IFYXERNG1.2ZNS2EYUGGPOF@gmail.com>
Cc: <kernel-team@meta.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Dimitri Daskalakis" <daskald@meta.com>, "Mohsin Bashir"
 <mohsin.bashr@gmail.com>, "Bobby Eshleman" <bobbyeshleman@meta.com>,
 <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] eth: fbnic: validate the Rx completion buffer index
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>, "Alexander Duyck"
 <alexanderduyck@fb.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261009175358.1598001-1-yhlee@isslab.korea.ac.kr>

On Fri Oct 9, 2026 at 1:53 PM EDT, Yehyeong Lee wrote:
> The buffer ID in an address/length Rx completion descriptor is a 16 bit
> field, FBNIC_RCD_AL_BUFF_PAGE_MASK being DESC_GENMASK(15, 0) once the
> fragment bits are removed, so the device can name any index from 0 to
> 65535.  fbnic_pkt_prepare() and fbnic_add_rx_frag() feed that value
> straight into fbnic_page_pool_get_head() and fbnic_page_pool_get_data(),
> which use it to subscript qt->sub0.rx_buf[] and qt->sub1.rx_buf[].
>
> Those arrays only cover the buffers the driver posted.  They are
> allocated with size_mask + 1 entries, and size_mask comes from
> hpq_size / FBNIC_BD_FRAG_COUNT, so at the default FBNIC_HPQ_SIZE_DEFAULT
> of 256 each array holds 256 entries of 16 bytes, that is 4096 bytes.  A
> buffer ID of 65535 reaches 1048560 bytes past the start of the
> allocation.
>
> The fill side already masks every index it computes against
> bdq->size_mask, and so does all of the ring head and tail arithmetic.
> The completion side does not.  A descriptor naming a buffer that was
> never posted makes fbnic_page_pool_get_head() decrement pagecnt_bias
> through a pointer outside the array and hand the out-of-bounds
> netmem_ref back as a struct page; page_pool_get_dma_addr() and
> page_address() then dereference it and the skb is built on whatever it
> points at.
>
> Injecting an out-of-range header completion reports under KASAN:

How exactly are you injecting the completion? Just overwriting the id
field in the Rx completion with an arbitrary value from the driver?

The buffer id is chosen by SW when the BD is submitted to the device,
and the device just echoes it back like a cookie when that buffer is
used.

>
>   BUG: KASAN: slab-out-of-bounds in fbnic_page_pool_get_head
>   Read of size 8 at addr ffff88800c719008
>   The buggy address is located 8 bytes to the right of
>    allocated 4096-byte region [ffff88800c718000, ffff88800c719000)
>
> Check the ID against size_mask before it is used and drop the packet if
> it is out of range.  Masking it instead would keep the access in bounds
> but would silently attribute the completion to an unrelated buffer that
> the driver does own, which is worse than a drop.  Set add_frag_failed so
> the frame takes the existing error path.
>
> Rejecting the header completion leaves pkt->buff uninitialized, and the
> payload completions that follow are handled before the metadata
> descriptor that looks at add_frag_failed, so fbnic_add_rx_frag() has to
> bail out as well or xdp_buff_add_frag() writes through a shared info
> pointer derived from a NULL data_hard_start.  Key that on
> data_hard_start, the way fbnic_put_pkt_buff() already does, so the
> buffer accounting on the normal path is untouched.
>
> Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 27 ++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_txrx.c
> index 10caacffee0f0..d85daab06c99c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -985,14 +985,24 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vec=
tor *nv, u64 rcd,
>  {
>  	unsigned int hdr_pg_idx =3D FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd)=
;
>  	unsigned int hdr_pg_off =3D FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
> -	struct page *page =3D fbnic_page_pool_get_head(qt, hdr_pg_idx);
>  	unsigned int len =3D FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
>  	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
>  	unsigned char *hdr_start;
> +	struct page *page;
> =20
>  	/* data_hard_start should always be NULL when this is called */
>  	WARN_ON_ONCE(pkt->buff.data_hard_start);
> =20
> +	/* A buffer ID the device never got from us cannot name a buffer we
> +	 * own, so drop the packet instead of running off the end of rx_buf[].
> +	 */
> +	if (unlikely(hdr_pg_idx > qt->sub0.size_mask)) {
> +		pkt->add_frag_failed =3D true;
> +		return;
> +	}
> +
> +	page =3D fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +
>  	/* Short-cut the end calculation if we know page is fully consumed */
>  	hdr_pg_end =3D FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
> @@ -1026,10 +1036,23 @@ static void fbnic_add_rx_frag(struct fbnic_napi_v=
ector *nv, u64 rcd,
>  	unsigned int pg_idx =3D FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
>  	unsigned int pg_off =3D FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
>  	unsigned int len =3D FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
> -	netmem_ref netmem =3D fbnic_page_pool_get_data(qt, pg_idx);
>  	unsigned int truesize;
> +	netmem_ref netmem;
>  	bool added;
> =20
> +	/* The header completion was rejected, so buff was never initialized
> +	 * and add_frag_failed is already set.  There is nothing to add to.
> +	 */
> +	if (unlikely(!pkt->buff.data_hard_start))
> +		return;
> +
> +	if (unlikely(pg_idx > qt->sub1.size_mask)) {
> +		pkt->add_frag_failed =3D true;
> +		return;
> +	}
> +
> +	netmem =3D fbnic_page_pool_get_data(qt, pg_idx);
> +
>  	truesize =3D FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
> =20

