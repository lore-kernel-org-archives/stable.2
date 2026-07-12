Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58534107F
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872162; cv=pass; b=VZTrlrs3YWNWVVZ19V0LyaqB46beg9ivo+s5vEdcgfs8lVzodfEdRDtTcv03ri4DZIRnSO6KR/UUgKLTE5dD8w+1ueTs8CU619A/VsTHJwuLbtL+6CpJV0l2RVCmHDH5HzJuJJ6r9gr11UddeavbCUnAnC8CzRUf/eNu9GokgSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872162; c=relaxed/simple;
	bh=lEN1RDO1utLqCuN68G05+ujxtG3nu9JpSH8sV9ic7Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9vWRMHQGTt8qQXa8vEzh0jxbkErVRHmkBcjY09VgfrB01elHM78MB1gEzoegxAX+kHSFszXIs7sSzEX7Ki1ONtUrYKbD62Cn4iL7HFMnnprE3gh6s/imI1sjg+a/6UverQeeESD4EJF4556VuA+PaHZiHf/0A2Zv57p9AggQ4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=UyzSvgh1; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="UyzSvgh1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c7cfa17fedso33953235ad.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 09:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783872158; cv=none;
        d=google.com; s=arc-20260327;
        b=UniSJuzK0p/96sfNUWFG4st5kYLleJvyr37uGVMS7u07xXh2LJgI6Q3g66JMOrLfuk
         ISB6yKs1dlXPCB0zPVpnXvF4TcMOic9MtCcb0nlhI5/wM/opZF5uFG2X0GUBDrGz2HdK
         OdzesHHAd/8okT4iMpzFvCJkIZjkZM2qk0zYMOD3eipVP2qI8JBH2J+XnZalef6m8mwR
         eZw5F06v1W0WcXbQwxYxjH1kS49USNqOFupNm0U2UFivdXqpTm+fuXXrPVKgdr8D+qHz
         r9LfhfBW8752PVBP1Vg9pDRQT/Q8Lc10bD3O0EWTTCLxVadx+yWa8/5FqCHShYkPAdtu
         2LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y8gOd+Q3z89xRep8w0XzdPaSt7VIYP9aT1DEEYw2ULY=;
        fh=KUY7ky+KryiNix62+IAwahdYl/bM9Q9www7meNg3tAE=;
        b=Dw6iVuxkpalSYQA0ON2pc5hiKdmcNXrbJRKUOr7/x0PjbTaxzQIj/deUurQOOxTvol
         hdDaelX5C36etmSvRubuqNDflr04yD56cOAkLS5aDJxYjTGWU6a9xxaLqn+FjK8voMK5
         I6jnwFxNgjkx62d7i5GN1j+KiWyINahZrvVqfFsAZhYmBPkbZ2bzQHt6FucQrfSTdFj4
         OT8DBD0BPVNYt7bh9WZjkxCsqrHf5hmXLMLqmNmXnFSuQyKjl7N/iZxOjdlquHRSNWmQ
         nJHowFFelqJYbUWTesYOki0pQLTWSR/VXwfMhPYSdzIRYOlj9Qpi7gjZ6fQV/dT14FTi
         yAxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783872158; x=1784476958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8gOd+Q3z89xRep8w0XzdPaSt7VIYP9aT1DEEYw2ULY=;
        b=UyzSvgh1DSo25sz9JUH7LAEQYx9BMF+mB73o0GzGMxtQ378cZRnGojCu+dD/ic7RZn
         6JceGpLBw/0SgcsKVCR52kBm4F2Du2aMyjgISzHNdB812vaSwkx424f+2H+xfE+P4T6r
         H965lm/wzQ3xU25gEcc+fevOrV+JU8g1qMjYVrF7wCzMqmljJGxeWMwUw4hahRRtNawr
         zOt9Gd4SYOmRZdenLeLc7078SdrBqOXqedNdY/MXPKE+WK409Nc5pa+aEJju/ctXTUbB
         eQgTYSY0c/dVfA/ortM1UDNfYh0S3opSb2paDzLnuTy3S01Gb3UtHf6RfTf0Yde5pumL
         m6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872158; x=1784476958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8gOd+Q3z89xRep8w0XzdPaSt7VIYP9aT1DEEYw2ULY=;
        b=HKRIPWS1kwB8SwCJgA8BwMFYpXY6TOhuwOjW38OyhTH7r+CueSh3g/usU1q/zo/Obc
         TE8vaqhalctO6xgmzDrNfXInIk26jtTPNvNLmw9E+RuzTenmjVYWfq7Z8BkBLkEds2bi
         dzi/ZZ0dwoAgKmUYz4oFWLlvHAi+XR8z+pSubJQwXPtTMT9y79Wyq/ei7s08sh7rhdP3
         Lvulg21/H1nVonRRejgfQ72sIBL0VKkFZ3hFQzjZHlomwFRag5C8+69SzzIeIRAiTwZh
         SXvGnby23LkLVog39nbFSOuzZw1TBYzsjm2wi/eD15kXNs9fuI8UjnJrYP5v7HQ+6/8j
         xwGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8vHmFSHDEuveCtDLiphcZQtQGaO/Oy4LbTvW30is3ZK8pdDnZF4DcBJOCKWL0yPvAlJg5Pmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylO4QGwM5LGaJwIfNbADKfrAsuFh2XE0rYZF6xF6xI73Vuu8pT
	hXvLjzSigjY4KpK5oL9TC4c65g2RZjbex+MtNyoi/s6zTm5enNEvE5ENutgYIRWTbF+qho3F9NX
	bkk1o+7pQt/qM7vTOc76Hd/pdtO7OQR9A/+gtgPPadY0=
X-Gm-Gg: AfdE7cnd6F3Td55tpL5J1qJF99xmgB1aVl5mVba6yQm90lq6lMpERu8Cs6btWULpUd5
	10/qUAj3NPSqzBQFUBd3q4JQLlz3vp6nQlHddDNa9ddgDR62sb/Q7IcxaYcR0JSRgqa8dmQB+q/
	hG0mfvp/XuZBUNsx7htIVYWaABgzEbJcWvqofSotHT/Faggr44yn3GjtmZYyhRWa09R/yucSxsQ
	Dp6occhslkJ61Ve3EmURmBmTPxujb5IngXfYsPLZQm1MnYl7dhheDeinEK4sV/vLsgGEScpC1GN
	8PHUvyMvNuhtF/6KA1E3elhKW2yqwGwqD0fjCLk6YDcM174V5avOMbLqKwVu
X-Received: by 2002:a17:903:2444:b0:2ca:c4a5:84bb with SMTP id
 d9443c01a7336-2ce9f27e6f1mr63459385ad.38.1783872157981; Sun, 12 Jul 2026
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711072702.70231-1-doruk@0sec.ai> <be1731eb-e6ec-4015-92e4-c09fd88019e6@linux.dev>
In-Reply-To: <be1731eb-e6ec-4015-92e4-c09fd88019e6@linux.dev>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sun, 12 Jul 2026 18:02:26 +0200
X-Gm-Features: AVVi8Cfuvaa8c4Hm1hNjjBfiFUfKj_52zwFcdM42IhGHFkrP4Lc2eV58kzfpMGc
Message-ID: <CAPdMp1p=72WXe-8w5Y9viBuB6YvZWZomNc9xQzXEg-qe1WVN0A@mail.gmail.com>
Subject: Re: [PATCH net] nfc: llcp: reject PDUs shorter than the LLCP header
To: vadim.fedorenko@linux.dev
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vadim

this was reproduced from userspace on unmodified
linux-next (bee763d5f341) without RF hardware.

It's the peer-RX path, not a local command skb:

virtual_ncidev_write (peer NCI DATA) -> nci_rx_data_packet
-> nfc_tm_data_received -> nfc_llcp_data_received
-> rx_work -> nfc_llcp_rx_skb -> nfc_llcp_recv_connect

Bring the LLCP link up via a normal NFC-DEP activation, then send
one NCI DATA packet with a 1-byte CONNECT PDU. skb->len - 2 wraps
to 0xffffffff and the TLV walk runs off the end:

BUG: KFENCE: out-of-bounds read in nfc_llcp_recv_connect+0x9f6/0xf80
nfc_llcp_recv_connect+0x9f6 -> nfc_llcp_rx_work -> process_one_work
read 4219B past a 704B skbuff_small_head from virtual_ncidev_write
R14: 00000000ffffffff (wrapped tlv_array_len)

With the guard: rx_skb runs for all 600 short PDUs, recv_connect
reached 0 times, 0 reports.

The bound stays "<", not "<=" -- a header-only SYMM/DISC/DM is
exactly 2 bytes and must still dispatch; AGF uses "<=" only
because an AGF frame must also carry a sub-PDU. I'll drop the
"same guard as AGF" line from the commit message.

Instantiating /dev/virtual_nci needs privilege, but that's just
the syzbot transport; the 1-byte CONNECT is what a remote NFC-DEP
peer emits, and the DEP layer imposes no minimum LLCP length.
Impact is a proximity OOB read (DoS).

I can send the full reproducer if you'd like.

best
Doruk

On Sun, Jul 12, 2026 02:01 PM, Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 11/07/2026 08:27, Doruk Tan Ozturk wrote:
> > nfc_llcp_rx_skb() reads the two-byte LLCP header (DSAP/SSAP/PTYPE) and
> > dispatches by PDU type; several handlers then derive a TLV-array length as
> > skb->len - LLCP_HEADER_SIZE. Neither nfc_llcp_rx_skb() nor its callers
> > guarantee the frame is at least LLCP_HEADER_SIZE bytes, and a sub-header
>
> that's not correct. there are 2 ways to get to nfc_llcp_rx_skb() - via
> nfc_llcp_recv_agf() or through commands/locally generated skbs. The
> first one checks against LLCP_HEADER_SIZE, while latter one creates skb
> payload with correct LLCP header size. Do you have a reproducer to
> trigger the issue?
>
>
> > PDU does reach it: digital_in_recv_dep_res() and digital_tg_recv_dep_req()
> > strip the DEP header with skb_pull() after only checking the DEP header
> > size, so a DEP I-PDU carrying a 0- or 1-byte LLCP payload is handed up as
> > a sub-2-byte skb.
> >
> > For a CONNECT or CC PDU, nfc_llcp_recv_connect() and nfc_llcp_recv_cc()
> > then pass skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv().
> > For skb->len < 2 that subtraction underflows: truncated into the u16
> > tlv_array_len parameter it becomes ~0xFFFE, and for a CONNECT to the SDP
> > SAP, nfc_llcp_connect_sn() uses a size_t and underflows to SIZE_MAX. The
> > TLV parsers bound their walk relative to that length, so they read far
> > past the end of the skb.
> >
> > The aggregated-frame path (nfc_llcp_recv_agf()) already drops sub-PDUs
> > shorter than the header. Apply the same guard once, in the dispatcher, so
>
> that not exactly correct, it drops skbs which are shorter or equal to
> the header, the check added in this patch is not correct then.
>
> > every PDU type is covered.
> >
> > Found by 0sec (https://0sec.ai) using automated source analysis; the
> > missing guard is evident from source. Compile-tested.
> >
> > Fixes: d646960f7986 ("NFC: Initial LLCP support")
> > Cc: stable@vger.kernel.org
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
> >   net/nfc/llcp_core.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> > index aed5fe1afef0..e3b3077e0e83 100644
> > --- a/net/nfc/llcp_core.c
> > +++ b/net/nfc/llcp_core.c
> > @@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
> >   {
> >       u8 dsap, ssap, ptype;
> >
> > +     if (skb->len < LLCP_HEADER_SIZE)
> > +             return;
> > +
> >       ptype = nfc_llcp_ptype(skb);
> >       dsap = nfc_llcp_dsap(skb);
> >       ssap = nfc_llcp_ssap(skb);
>
