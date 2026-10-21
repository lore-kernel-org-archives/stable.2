Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573465;
	b=m2aUs0/6Dz+2Ogc5xxOLyFGfKjjNLHB1ZydoH1SwKHmsQR8Oxjy0kdFNRlfIO6wZktde
	 2zayzq5aNdIgTFlueyO8a3yDb9xo1Z5uetI2QeMxgH9MWP+fkcDcKP1STx8/S6oX+5h7A
	 BQKxGtiXbACAfvDZiWKRv2lvOYGawl65IbPlEmeqh+6SaOY1utriHTc7Z1+hAfPiqEfID
	 2rSPs9L3wq+BZ6xE8ip7vGyUijefC93T2OKCGDkCY/VB4df0PeNcgGpDDlEddkwsBIHpL
	 hMdlFFNr5FI9tkfsBAYCk6JfGUVDtKkUEwnAn6F4V7bG9L8rv+D/ZvASvKSYWwOtDYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573465;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=csNOmpzOi9opi088UH5aVImfWx2YCUTo70s3xFwzQFM=;
	b=OBaPbpsPm4WAE0oXVq6jo21y/7//8aipJSZBssJIVtRLA3Udd/G/FSDRyRiNciUN74+x
	 /u+htWhvWDo1DvBPMnWzE01I0piQg/LN4O+xVLvGwXmAkQfVEyMxEdE1qrN2VbPRet1Un
	 ux/kGgTRd5Da9Qf/GnxSPX7okriQmSiEZl/8TAGq5HB9wW1yJsNje9OUz4heWBxxk8btw
	 SqBYrX18yWrS1KmfafNh1PVUMIyqQXRP5WPu0SSTPV6DmM2aVR4vaZKwgoYxohgRIlA+m
	 aSbItR6h2CvF5rzn0SpbAHUUrEckwdZhlrh/QFT4JXIttCpzz9RJiHTQnQsXrz0TXtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=queasysnail.net;
	spf=pass smtp.mailfrom=queasysnail.net;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D767606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D767606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BAD671D000E7
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:04:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 05:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1792573462; x=
	1792659862; bh=csNOmpzOi9opi088UH5aVImfWx2YCUTo70s3xFwzQFM=; b=o
	meSON72QEHErjg7n+i2yeuPoD4JJO3wC0eQEUP670QY9jVILee30qzKmS4mOVKdh
	peivkki6RAGkgrXSwPyFReTEuB2+aWZDnKuVFkTVbbhn2IRuPe5EeYiZwiaCXj5t
	BWH64f724LqnDxwnUntOpa3zIYyNBDfQYtQHdLdokmn+my2gMwsWUEQY/OmWDJe7
	EJnGJvBElhHJ0OAILgOBGI+yyTKyMjRknJIWe1ECfuY6xvFveHLyHxIAw4Tavkq4
	RSk9rc/qmrqrc6+egbMBOmveywQYLX+4SUCet7HMTXriVVYcz3rn+0z2xmpE7vfg
	B2L+2FrywVUryW31X7QbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792573462; x=1792659862; bh=csNOmpzOi9opi088UH5aVImfWx2YCUTo70s
	3xFwzQFM=; b=nudGWP2WpJidpEIlgg3pDi5/YpEIj6ZF1hEBVngrs55d/rt2z2r
	qVMvOlua5w007vKBlQhSkEwUT/a1btkc382XtH5ii4vJi15RO21GmxCu0XicxAb4
	uQmUVMfqotwY7kcloF8ILjTkmORbIDWN8UcJ/xa/LrY6FUh4qZjrEpJG5yHQXfVE
	ZbrqLfoUch8u1E6MsFiWlUcQrTjpuTlexzxZ37gfGwmyiU1fC25AYMzvtXKPjk9i
	HQ+R/nnmVFfCSJOkjpgvfjt4CDcMArLIqdg5psbzaZwfOpdgPSqLOin8hzEOdnx5
	YiuwnLQu0GyRO18SV0tdHtmV5O608ehqv/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792573462; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:heaa9uuAJtFWtkjAvjOEAEd4ZPko8UQvgDex9D9hqgg+FyD
	DnD6MQjSjxilN4PxsDmrFGhhYilwSBCcgQh8XGzww4D+/KSnBkvOdQhUkzIypFUP
	1cwf2JWaofykz1/UG3aD9jXXhg9xQy3gpS63mKQKSflGPghFASQmYhanxr+DgHhI
	BHKo/PNvzNDGum4rAbWwzKmzZCWE/s1lYeSLk77cohUaKInRyrELJbrnmV0DGZxK
	/yykBAxhtFFr/k/0v3gJu1MdOzBzFVGJSOULaLn1CRW/KaFZ64hdZH7/FH9nEP/O
	ST8RWEntWQCow/bJyfQ+16pXiwkcB3eyDxh3VIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BPsFBW8hox1ARX6bqMlGNHye56oNNRkxjp5ruwYW0+0=:SN3lCVCm/+OtZcsJHcgkhERSa+yp3BYbsp+O1Bf8328=;
X-ME-Sender: <xms:FYDYauMP4a6wy_N2vd6bl73-dVR2gJpMSg2ECRE9E7AoSIfCc0-ObQ>
    <xme:FYDYai8tYAKVjeW7LlIJgoPvnHmhVc0ki5KINUUIhyzUh0WVk6yclIt0vAOyOSW_5
    PpkMHEjLj_XNJuJfAHA8izGpTqAMAjbU3B3jFz2O-gPjHOZwRbIBf3A>
X-ME-Received: <xmr:FYDYagHgn2hk1qgwWQ_s2nu5LBEYvscjvWc-lIkZ3WCp1ipFJudtLW93p1I>
X-ME-Proxy-Cause: dmFkZTEu9GlWtHXe9v9ClB+erUmoDap8HNWDFhJJi5pP1RUgD8TZuRnUuCCBr1H8B0+f/F
    xcfo+/mXnhan7i4FzLnwhbRZ1QUo3U6auOgMvtpuwR2wXwUsPO+dgsJWQse6rYu/MYGQEa
    ad1sJrqX8ZWQOBJ6jfBeswqfi6sidebXP4/b8Bh79NYyEa9JUa5eD7EAXE7AC9a8j3kV2X
    5MSXnED3dLH8vB0pOcMbwyTMEltKQRLJMoRGB6ZEVyDVa4L7LMImJcGM4lhXxaZEh407Aq
    XCONGZqAuEXOSov9Vh9qXgV/z7vur5hiAvGh5U/Uw7Bo4UmHthK+M2P+GHo7tPi+cTERg9
    XIdDkkS/xzWpx+dlIdz6guXu+8uWxwWTolp5QLOE0QqjzRZZU49Cenr04EKtkEtPSW/Ri3
    DAsATrp2XrU6EkAqZbnespu9lj4RzsN2Xq0lCo5BPfLilXxT2ftpnlKihgY5oDR8pyvSQS
    xkIOjMMw0kc8+vB8YGSgajmwODNIvlkJ3Toh4fp16CtxXFQgFDed4p2tYLsvQ3qcdivC6r
    WD4E9l3vvEoaqaR1QWM3iACMvLwrMyeazLpwQ/jGvPOkWrVxtoX0NYe7oSUK+FNw+6lIXW
    fA63JfweHR0DDhQiCL/GZCRyZ1kSzUB0fW6trlhpQAkO8nJSbNUaQDUHSjxg
X-ME-Proxy: <xmx:FYDYahhXsVAlRoPfZxlYTlnuGVDc0p2cbNbubdbOVdIHS1xBAzyE0g>
    <xmx:FYDYaltnXFMlSICTXpMrGUS5sT331VQrnoXPKTE19ku_RQsEJ4Jz8w>
    <xmx:FYDYastJkBcNLiTvh6lv7qwqBeYpVOLZMtlUriOnvVgES6fl8axYcA>
    <xmx:FYDYaiERLrOeTp1AA3BRNfh6dO_pV630xhxRy7QThbW2zWXYdQ6Otw>
    <xmx:FoDYajcdDGLF-Dn0E_Z4KMbYXiTD9mw18eJF4PVv5YGZ6XLz4JvZC956>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 05:04:21 -0400 (EDT)
Date: Wed, 21 Oct 2026 11:04:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] tls: device: keep tls_sw_fallback() from encrypting
 its own output
Message-ID: <atiAExld_bpR7sQm@krikkit>
References: <20261019212651.733565-1-rjethwani@purestorage.com>
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
Content-Disposition: inline
In-Reply-To: <20261019212651.733565-1-rjethwani@purestorage.com>

2026-10-19, 15:26:51 -0600, Rishikesh Jethwani wrote:
> A socket offloaded through a bond has every skb validated twice, once
> at the master and again at the slave. tls_validate_xmit_skb() passes
> the master-level call through for that reason (netif_is_bond_master()),
> but tls_validate_xmit_skb_sw(), the validator tls_device_down()
> installs, calls tls_sw_fallback() unconditionally, so it encrypts the
> master-level ciphertext a second time with the same rcd_sn and IV. This
> cancels the CTR keystream and exposes plaintext on the wire. For a
> complete record encrypted twice in one skb, the second pass also
> generates a valid GCM tag, so the peer accepts corrupted data without
> an authentication failure.
> 
> Guard on the content rather than the device. Offload plaintext always
> carries the decrypted bit (tls_push_data() and
> tls_device_write_space() send with MSG_SENDPAGE_DECRYPTED), so
> tls_sw_fallback() can pass through any skb without it: such a skb needs
> no offload encryption. complete_skb() now clears the bit that
> skb_copy_header() copied from the plaintext original, so the fallback's
> own output passes through any later validation pass untouched. This
> also does not rely on every path validating a skb at both the master
> and the slave.
> 
> Tested on two hosts back to back over a mlx5 port, the only slave of
> a bond0 (balance-xor, layer3+4), so each transmit is validated at the

As in another patch, a couple of selftests for "offload over
bond->NIC" would be good.

> master and again at the slave. Run from each host as sender, a TLS 1.2
> AES-GCM-128 TX socket kept open across an administrative bounce of the
> slave leaked every later record as plaintext before the fix; after it
> each record is encrypted exactly once and the kTLS peer reads the
> stream intact.

The wording and verbosity of this section ("administrative bounce", 3
lines to say "before it didn't work and now it does" which IMO
shouldn't even have to be said) needs to be cleaned up. The rest of
the commit message as well.

> Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
> Cc: stable@vger.kernel.org # needs commit fc6d80eb5044 ("tcp: prevent collapsing skbs across boundary in rtx queue")
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  net/tls/tls_device_fallback.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index 3b7d0ab2bcf1..24fba12febd1 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -192,6 +192,14 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
>  	skb->destructor = NULL;
>  	skb->sk = NULL;
>  
> +	/* nskb carries ciphertext now, but skb_copy_header() inherited the
> +	 * plaintext original's decrypted bit. Clear it so the bit keeps meaning
> +	 * "still-plaintext, needs an encryptor": a requeued nskb would otherwise
> +	 * be re-validated and encrypted a second time on any re-entry into
> +	 * tls_sw_fallback().
> +	 */

"nskb is encrypted now" is enough. the rest of this comment (why it
was set and what the bug would be) really doesn't belong here.

> +	nskb->decrypted = 0;
> +
>  	update_chksum(nskb, headln);
>  
>  	/* sock_efree means skb must gone through skb_orphan_partial() */
> @@ -371,6 +379,17 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
>  	s32 sync_size = 0;
>  	u64 rcd_sn;
>  
> +	/* Only skbs carrying the decrypted bit hold plaintext that awaits
> +	 * offload encryption; anything else needs no work here. That
> +	 * includes this function's own output (complete_skb() clears the
> +	 * bit skb_copy_header() inherited), which is seen again when a skb
> +	 * is validated a second time, e.g. a bond master handing it to a
> +	 * slave via bond_dev_queue_xmit(). fill_sg_in() would map it back
> +	 * onto its own record by tcp_seq, reusing rcd_sn and IV.
> +	 */

Sorry, I'm not reading all this. 0 or 1 line of comment here, nothing more.

> +	if (!skb_is_decrypted(skb))
> +		return skb;
> +
>  	/* worst case is:
>  	 * MAX_SKB_FRAGS in tls_record_info
>  	 * MAX_SKB_FRAGS + 1 in SKB head and frags.
> -- 
> 2.50.1
> 

-- 
Sabrina
