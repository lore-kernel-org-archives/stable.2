Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371022;
	b=YLU0k/T0fZ7hrw9McJ2HHs45pW2ZfMf6EM03NlVxHrIgU4MgYPt2xOpwKXbcMMjRiOwF
	 RiIy8WfKj90XcEPwoW1joAuxLLkNs1qeW1MqDKSTwtDG1JtuL6uw5BzKJN+gLrZkKxaHK
	 G6QKS/fdI6TzNMVmo9jmm+H8sQUK2pzXul/TmjF4r6nhrUUkZut7ISqwJMLTd1avdYt4n
	 b+WnBLZj1H+Dp8PHUsZXTsRDxDJfbqeDngwXO/PU88XgLb2WN18T/zwRqibFfPQZ8KB1O
	 g2v5oZhu8HJefdNXHicCCs1IX//FGjHhZmiANGcHVqoUxpxzg5p+g9vVh/fLrbAE97A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371022;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=wiIa6Cr2sZaLCXVMCzH0OBX7W4amt0iKKKNP2eGSOzc=;
	b=iIb1yzgLVB57Go99LhYMumjO8zZOTfqZMVj3N81NML/28Vm+zLzp5D1UCjnhIQ2Mn2BK
	 OK/2plIP0jk6gc/k29K4B6/QMAsP5bAOMDkFZ07vf3umyIQsd9pgULd1esbvDb2j9ox0j
	 HmGJDvxH08QWLG7TGAPtlOWVYg1kgAMb4X8tiqZMUCAPBgjYJ0olFd+DEIQfe3owquDEQ
	 ub6FOH4EJ8fdqfiqD3snEq/CTfJoPwXBBU44PGjaWqNsSx6Zyn9ffHhEqB4gEJmI55OCr
	 MwmKHLFpG8qLSExlGkOoytlULHyUnO+dcca71kwgNPPJWIu7dJPyhNVPV4hdyecNspQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QDLxa3VS;
	arc=none smtp.remote-ip=91.218.175.187
Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31908606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31908606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QDLxa3VS
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qggKogTdOwOMj/yNNYKeKJscDWkEFiFK71V3XLb/xGk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793371019; v=1; x=1793975819;
 b=QDLxa3VSJeSVFow5vrSVdIKi+2nO6uShhD/b0bHUolKnFeYATxk9qqXCAIP/40kpzDe19/jz
 82kiy1OaxaOCl1Ih2+hLl1uE75FDy3FXJHbt6jNYFahDi8zdaMHhlRQOxBmEbawwTOrITaSbiU3
 orYVD+g0RSPVcQKnnf9rpCtQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ca7b49e6f113364b;
	Fri, 30 Oct 2026 14:36:59 +0000
X-Mizu-Trace-ID: ca7b49e6f113364b
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 14:36:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <1c6b269275da44f667b6cab73968fee752860eda@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next] wifi: rtw88: drop C2H packets shorter than the
 C2H header
To: "Huihui Huang" <hhhuang@smu.edu.sg>, linux-wireless@vger.kernel.org
Cc: "Huihui Huang" <hhhuang@smu.edu.sg>, "Ping-Ke Shih" <pkshih@realtek.com>,
 stable@vger.kernel.org
In-Reply-To: <20261029170017.832708-1-hhhuang@smu.edu.sg>
References: <20261029170017.832708-1-hhhuang@smu.edu.sg>

Hi Huihui,

I have two comments below, nothing major.

October 29, 2026 at 6:00 PM, "Huihui Huang" <hhhuang@smu.edu.sg> wrote:

> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wire=
less/realtek/rtw88/fw.c
> index 945fedcd375b..2e37c304cde0 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -353,6 +353,12 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtw=
dev, u32 pkt_offset,
>       struct rtw_c2h_cmd *c2h;
>       u8 len;
>
> +     if (unlikely(skb->len < pkt_offset + sizeof(*c2h))) {
> +             rtw_dbg(rtwdev, RTW_DBG_FW, "C2H too short: %u\n", skb->l=
en);

Small thing, skb->len here still includes the RX descriptor, so the value
printed is not the C2H length. Maybe print skb->len - pkt_offset instead,
so it shows how much of the C2H actually arrived?

> +             dev_kfree_skb_any(skb);
> +             return;
> +     }
> +
>       c2h =3D (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
>       len =3D skb->len - pkt_offset - 2;

This takes care of the header, but as far as I can see a C2H with only
the two header bytes still gets through, with len 0. Most handlers read
their payload without looking at len, e.g. right below in this function:

        case C2H_SCAN_RESULT:
                complete(&rtwdev->fw_scan_density);
                rtw_fw_scan_result(rtwdev, c2h->payload, len);

and rtw_fw_scan_result() reads payload[0] unconditionally. So if I read
it right, skb->len =3D=3D pkt_offset + 2 ends the same way as your test c=
ases
1 and 2: scan_density is taken from the byte right after skb->len.

rtw_coex_info_response(), rtw_fw_c2h_cmd_handle_ext() and
rtw_tx_report_handle() seem to have the same problem. They read fixed
offsets in the payload and don't get len at all.

Would you be willing to add length checks to those handlers too? Maybe
as a separate patch, so this one stays small for stable.

Best regards,
Luka Gejak
