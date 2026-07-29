Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8922A1D4
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295900; cv=pass; b=LMMu+u+wL5z9UXZGzZM15XlYKRQq0Xv/C3Ub62OoRX+QqWD0LU3BOAMQRsaqLT4loZf66F5cwVdeWhxRAqmpVYG/Jc+ggIZ4RdbJ5lCU+Hg4OKchSIEqr8J1VVrbhJfVmvFrKKBXMP8mfGJwktNqvYiveeIpoeLh+Q/+ggPA0sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295900; c=relaxed/simple;
	bh=8INSsvIsr0EcFor0KjhMqLit17i8jgQhYiGlfRY+r1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gz6QB4/nWa019tSFiJ8ClLBrOvtzsXy5wjzPG0FFHpAmqRteebmuZeBXMfRSx9/WnHQUslJp9vW7JynD1/Zu2a0XYZQemKGfRGfw535xbRWzUyvj2aSzgC6nMo8HbwzbHZJzQmb9mFLPJJID4hdv7H3lCDr9dRaEwpzUr6+L89k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZkFzDLJ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZkFzDLJ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6679d88abdcso575934d50.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785295898; cv=none;
        d=google.com; s=arc-20260327;
        b=VoLZYqqa6eaqIiXu7CV+Uwe3LDb6IpGF0kcqVWJaB/gfpGddS6R1aYULcTv2vlt766
         I0SozzAD8s3Pazof18LWkBtjgEpgwoBtuhq+eY7xNklzvM7sQM2YgCyafWSCRnVHGad8
         GoQX6VoP6kLN09XAQCuOcQ7lHzKKcaFKDYL9LwbI4hYYj2/53x0lqmv2OlzNaPYLDzAH
         alnLNJfG0kiXSnDPm2GUx5HX3A+l+UuiHl4gm77KwP/DbCivQkNJ3FTxzTSIylpnoC3y
         UUzZAuyWiGsm9tHM8ZPAOQpgeUcUuasPrc8MQ7wT5vrRB9joYCjuo+oZytoqrzcHgPy3
         Yl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        fh=IuM4/5iYRdSe0KDGZGp2a8ouCctEM11MQ/FbdMUc8pc=;
        b=ElS5iZz2/wTDC3Jh/VvPs1WGWWXkBf10TYq0QinwWKYxlMxphsyIvVcjJ/UrjLLwdp
         TgHVoEcKXakbCM0XqEGeGVRvBcooEASGxQe4iqnTu23260/eLXw4YF9S4iGh4jKy8zaQ
         Es5S4HryIOPH80MrJamGls2X/JZohkjgsRXLEH0lM7xGtlUhTn8TjkR3s4XIAHDHU2s4
         MTD+ZUtZyR3+gFAK7a2NUE85zDchreUobAX9Mg+tiBKzwaJjP3C2zgZPmU7i2k3leDNW
         WXfGWUcRF9w630Rtcii9oCUTMdljI1ZSLpWcT4sqahhH0hWb264aoNnJ7WTT+VJ9VZDR
         WEaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785295898; x=1785900698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        b=LZkFzDLJYcHyEVQjUK2tiKOjy7g93DUrCPtLUfOlKgu79bnoTMVwilsZVc8hrngfNM
         ADOlYWZA3nrXD1n+8NY/xS0vkN0Qp63wg23bsn0nvHU0qtDh5avpk6hxEjlc5s3FDXMz
         oKBYX/GiJW104aKxw32AK6W6TJco/J+A4eBos1lRYZhbJJqP22ZgscRYXYz62TSrzucY
         ckTDgmyNQ0OFbuYwbGUSsxBxfy3t8vyWZdvECPQ+ET322LT2n7E+kvdIJ5X6+lwAdhRw
         33VItxbVf1TDbxYqV2P6aplA6tZKMCL0umNJjy9Wi25WpbMsaGxr1xYh+N3cvSfnmpdW
         vBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785295898; x=1785900698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        b=Vy0iHuymfkHNY9FDZFJdEg5nTayYrm1DLK+Rsj275qXI7/I4uixdDpnI9eeX6Ue0Ye
         jXtRRzbLTtXCdvf3yl4l9a0JkN/SCCDmrYCOIjLmCZddmzkoZ+16ClgvYN2iyOxw7huI
         +vlqbXalvUbyBOGPwvHOPpjUELFfVMKY3N62gtM/dwXuzh/3a/g26tcAKFN4QEvg5Gbc
         /B43eXkMU8cBzHEsWGQotEQDeyOkVIA+kjBhV+EGAocfsanhYL80AVWPS44pb659wU8p
         jMDnOhSD9YG5jADZHgVIcqGdTMdrH6UZEji7wGOURAwNHjoiHHAD5tXV94PeyeJO2rJS
         JjXA==
X-Forwarded-Encrypted: i=1; AHgh+RqX60vraMUd0iCy1g9uRgkhcwAI4c31kJyjrkDv91tHznYVqf+3UNVIe1Lk89TG8+HXOiETX2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDenAse0TgXGeQGiSqQvkFG4nvfV9d0ATabc4uiM1Kx64Kayp2
	wBXOBmauh2WwGBsErxumVURo0aawssgZ6tIrDTtq704b2pWnpATiuQFYyJc7bdL8NqdM7/KUbcz
	Qb5o19e9pKGuiofEDcowHYZVUWL7cdac=
X-Gm-Gg: AR+sD11ZNOmtYVR3ExTH4fnFkrgcQ8ljbFWUbYs6vhXaS5LMqU0gDQWUJOpTqNjWZPA
	ibi8sTPwuxLsARUa+9hLVyR5MmD7tyleziuaDEYWZjC2LlapE0tf+pbILlTw+bq435pErO2J1Vk
	SR28ABRojHYVG830MrHdPkUWIQI6fiOIkKxdcs4nOU0sXCePHNK3I37TCif1pVrnfyDeBK+fD3o
	pGRqvmDxPJ2BHWr2KVfjYgCsLgooQUxaajRwkYKfIVpSpBN9qkV/NFrqMknIFp+CrMJL2frBbLD
	e7dSY86dzoBOCwoWqr4ZzHzJoG3S/pI68JPx2E2ZtI0Gkos4HaZHaxLMHnS+gp3qsMtVyUcA41N
	QGTQc3eFMC0LBB+K0O90=
X-Received: by 2002:a05:690e:4295:20b0:667:b57b:8697 with SMTP id
 956f58d0204a3-669057f5bc3mr1697637d50.61.1785295898162; Tue, 28 Jul 2026
 20:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-3-sun.jian.kdev@gmail.com> <amcIoG59kgi4CJbo@lore-desk>
In-Reply-To: <amcIoG59kgi4CJbo@lore-desk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 29 Jul 2026 11:31:28 +0800
X-Gm-Features: AUfX_mzCCj-Rhe2GnR_T5jwxAsRWw1WjvNw_V50aUcanGkk---NpUHWw-SrR344
Message-ID: <CABFUUZG+g_g_7N9D477vJW2c141-WhWL2JG8oc-y3OoF9QePdA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	maciej.fijalkowski@intel.com, matt@readmodwrite.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:28=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> On Jul 26, Sun Jian wrote:
> > veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept =
non-linear skb")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel=
.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  drivers/net/veth.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 00e34afd858e..a956498a073b 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct ve=
th_rq *rq,
> >               __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> >
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> >        */
> > +     skb->len -=3D skb->data_len;
> >       if (xdp_buff_has_frags(xdp))
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >       else
> >               skb->data_len =3D 0;
> > +     skb->len +=3D skb->data_len;
>
> nit: same here, you can this one just in the if () branch.
>
> Regards,
> Lorenzo
>
> >
> >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> >
> > --
> > 2.43.0
> >
Hi Lorenzo,

Thanks. I will address this in v2.

Thanks,
Sun Jian
