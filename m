Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105139;
	b=zNJfripRWdGHtjfnJi3amBINlbEEx0qgH9zfm9RM72Q/Z1ub+l0OwweSNlWW5uXDZdIZ
	 TSkdEwQ8DgZ30Hb7BK99w8Eo7lYCRL2ucYBWLrstTFEOwiNbytFQADSacwtBs1QKi6rSB
	 ZgwwovOXstkhpgGHwYXPa2gOj7WIVjefbuCYuSGcU9Nd+lQrcQVnBX/2o2gvhEO0Ku8Hs
	 WfaCG+wWQq/DxnktvH5OfiYM5us+nCjH9JRO2InAMD5ajDDXbU213G+M5l2Vg05Ng7XC2
	 1pq1MkIo/ua9ebFOGxlz8/TcYSR6MDPBOqHGY7Zw8Hl74pmRTE7tM7i1bC1vmQQhEmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105139;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=zuc3+mslWhh4yWvyXnVvIgNvQ31XzcXQKgtRlH8B9ms=;
	b=p94UIsQpfjSPQAJMvj4YYa9ZMy3bUxP/GqPFkLNmvzHg/VJUorNlb2FaGpiR0yeXlZVL
	 +w7h074+Yplad2Ee/k+quhuULPRrQnOSlvNFK37ttjRkL83/dL7J25lho417+bd1e9kUH
	 5ncvmEQyo/plZqx/btDIdY9/ZqVCrjP/w8oz48aIHRLsmRim0q1F8Ko1PyEvqLwcOLf0C
	 LXbblI8NCMP4YhW1nUAKcyw3rDuh67ZnIuio0ABlumJDZCkM+xt+xHKNKWXm20hksVAQh
	 xm5mOrudeRwHh19uRcTle2YRInGRvCE8/gYMllhvAXsmUcsD2CwtltOAUl/Hp+jCSKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=ULKGHPE2;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74B606A31A;
	Sun,  8 Nov 2026 02:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B74B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=ULKGHPE2
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A82VxEzA3097986, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794105119; bh=zuc3+mslWhh4yWvyXnVvIgNvQ31XzcXQKgtRlH8B9ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ULKGHPE2CeAvk4dfpuwlr+6KmHXiqgEtbbdgL8M/TIM08dfuZU8Xw8pecJJsjY4Ap
	 Us4E4MQzI9j6LwrYOZtulIk38qn+GSssSjt73kStRDc4/9QPRtdk9rEzvxI/cBr306
	 5jYbe9vq8FPmNKdF7EkgUl27e33GtlJ5jOTqjz4WQfOA3Y69LVqWdLwNIsqV4eWXRM
	 JyQFfTaVknCxl21IdNBTU4V1yrrmMhOouJfu/Lxs7kSnVNxC7umCQ5x0cIocfjapGN
	 P73NStH262qw0ReHDq0FVepSJYRP95HNda6LdNMfutH9UjUz0OcEb9SdEcFAKUu3sW
	 1+/SRfdE42lgg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A82VxEzA3097986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 8 Nov 2026 10:31:59 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 10:31:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 8 Nov 2026 10:31:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Sun, 8 Nov 2026 10:31:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Huihui Huang <hhhuang@smu.edu.sg>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Luka Gejak <luka.gejak@linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3 1/2] wifi: rtw88: drop C2H packets shorter
 than the C2H header
Thread-Topic: [PATCH rtw-next v3 1/2] wifi: rtw88: drop C2H packets shorter
 than the C2H header
Thread-Index: AQHdbShxv245XcRg/UWH2Gn2M9BVm7cjd5JQ
Date: Sun, 8 Nov 2026 02:31:58 +0000
Message-ID: <3b5749624a53468bad7b2c0b74c74d69@realtek.com>
References: <20261105125958.3891196-1-hhhuang@smu.edu.sg>
 <20261105125958.3891196-2-hhhuang@smu.edu.sg>
In-Reply-To: <20261105125958.3891196-2-hhhuang@smu.edu.sg>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Huihui Huang <hhhuang@smu.edu.sg> wrote:
> rtw_fw_c2h_cmd_rx_irqsafe() and rtw_fw_c2h_cmd_handle() compute the C2H
> payload length as
>=20
>         len =3D skb->len - pkt_offset - 2;
>=20
> where len is a u8, without checking that the skb holds the 2-byte C2H
> header (id and seq).
>=20
> If the header is incomplete, the C2H payload length underflows: zero
> bytes after pkt_offset produce len =3D 254, and one byte produces
> len =3D 255. With zero bytes, reading c2h->id also accesses data beyond
> skb->len. The wrapped len defeats the minimum-length checks in
> rtw_fw_ra_report_handle() and rtw_coex_wl_fwdbginfo_notify(), which then
> read their fixed-size reports beyond the valid packet data.
>=20
> skb->len is pkt_offset plus pkt_len from the RX descriptor, and
> rtw_rx_query_rx_desc() returns for C2H packets before its
> "pkt_len <=3D FCS_LEN" check, so a short C2H packet is not rejected there=
.
>=20
> Drop C2H packets that are too short to hold the C2H header. Since
> rtw_fw_c2h_cmd_handle() only sees skbs queued by
> rtw_fw_c2h_cmd_rx_irqsafe(), this covers both computations.

No need much commit message. Just say that you are validating C2H packet
length before reading.

>=20
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This tag is no long necessary.=20

> Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

As I requested to reword commit message, you can still take Luka's reviewed=
-by.


