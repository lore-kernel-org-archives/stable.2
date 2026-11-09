Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236736;
	b=fcimF8VYTf+ohrWzGIuhnlFHBN/003ofkCKJEZxM+WrzRyzqddQWY0Nww08Cap+tA2rC
	 VcCPpIzleAset3TNHMdzlLERfbbq8EuOWF8afUd5wnGxMcY9sDdQ1ct/J21Ph6ourHynk
	 6KagpY6XJbHDahA2IctquvxuQtoXIVdYVhA1HtgKtHLcBEOCaSt1oQLYWXtQ+DWCTJKAX
	 L49MiBdspm9uXzq4Niq76H75cilPAQUHzfFIgh+bO8FbrE/w+iZ51kuS/z39f6tmGhu9N
	 JtVb49IlUKkonY4b0sAVDGVAPICPab9yxar4OL2UNTguOzMMfw+flF4e3dzuFT//ekQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bm4n8PR4Zol2r2UflU7BTBKbLsaJuu5hjO5epKs7b7I=;
	b=vPOvLQRfUIBfxKZ9kkIUPx5PnWHdhgtJn5pd5tPQLK9uAUPgMqkQ7v+3trt1doUrKISK
	 DFj4qUKeyp4Ko0xh0bKCiS9tfpw2tasXqRYsOsVXc7pPmFh3NiOuB1I2XptI+0l8B9UYG
	 cSb6IeUlJ9Nae+7AW9U8WzJFnoyb6p1uZFELYXt8QuZHUV1qyiHcsbPogwk6uJSqkwwex
	 NthDZqM07OVXE+K7Mx4uorqHrLW8vSDR1lwhYfidAwlp7lYJw3Nz2oIbduWKZRnsmWVX1
	 lonMao6mhbSjb7RZwBpU7OF7Gghe8UJaPQXR6lPPP3mIUpS5+SYpPP3qA4oVz7xbGCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="yN8/eHBt";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A7606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 082A7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yN8/eHBt
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb628232d2so537942a12.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794236735; x=1794841535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bm4n8PR4Zol2r2UflU7BTBKbLsaJuu5hjO5epKs7b7I=;
        b=yN8/eHBtFUZSIk36y9X8io9EEFQsVcyLgUpXMZ2OA5iZkku/XLPHO5HhSUcwUSye+U
         zPMz2QbINcFoWF2T0uSx2o1gj3h77oP9a0nDzhwxC/X6VwCBPPMSa+tQSOkSUbaTm6XK
         fxu2r0F5Ne7Z6lVM8K+ykH5J9MEoLzEUiTstRj7LH86Kgo69L2ZzXcPXH2miPwqHUOFS
         8sJjON2PmfHu1MFlXiXzWfQc/8gJL48vPozdUfO9sLtjBsGWQkxWBgs8PMsJIviUznMX
         6J5fPn/KG8p06ohHuqcBrmQgWdTFAsrxLtmfN4pQWNRanpsaMGMMBjpbwVMHGZ7GIliH
         53gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236735; x=1794841535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bm4n8PR4Zol2r2UflU7BTBKbLsaJuu5hjO5epKs7b7I=;
        b=MJu3UPVvztv3GfX3Rg8vvzgyTsDvJN35PV1i6895Oor+Yuzh8AtLqdg/FWgNzH3yU4
         30+mw/FbiN7vnf979xOkgEla9Ec6YiDVd+ooMxngqebSIxzUl/kqQVI9mmGkeRk6uZ7X
         KT0thidR/FHQGdXiHdVFKeD4t7zDUL2WezYLw+NSqNGxNqUiOc/6O5RLZtC0Ow+7Q9mO
         EHM4dWTbYGNzI7t5Z+pNwPCBWfnWR7xMxDiRRruRqZItzL87QKJQTPjmd2CvoaiYBt6U
         fnici87Zgj2z85uXQAGqiH5+KgzjWjA2qh+/aDxKZDWqStTjRYUoBJ5xqm7ve3AdTf2k
         fraQ==
X-Forwarded-Encrypted: i=1; AL+hErElWE6gxFdXWVrHiQuVqgonEBNv1eMDPkN/P7X5zuiLw0XK8VQHASXUMMdvYEPTgOCQnqvY20s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ka1u6M+i0ltBax8rcjeGO5oJMEBWqnmOJ1OkfYsnWxWD2N35A
	S9LlZ6zlLauPQDgJQ9YauiyCF8ZETY49O4tBcSoi/ISazTr9DXwgg+GdH1Bx3S4lH+o=
X-Gm-Gg: AYBFou0ZVX2s7AeNpop4eqwZhruRJAlOigmICN05GnH14MTxP3RUgFsNDplEKWdf/Zq
	H8htsKg5itYPQzmW4dZ+Nahts3ojLBxY+5WmTNFomVio6p8hCXFjHsgun+f4SSzEBhYAJJl/Qks
	NxWVK1VRIo/OUpUmIC743wo9kBBDG03Snr/SJLUrbacZLwQFRR2N34or5epiNS/dnm03QgOOf0C
	iOx/HVUn2a2tyzBILWTlJSjol0XqnH3dn5G1oOYRb/wGchzKXg6WglX7HT/2l0sKTLY60CnrtXA
	6uG0vHegzbAR6EwmE5og5A6BJ7GB6ngY/bSGifq7e5j0o7EzvdN+GplbBdxd2xo+ozB8+mLbdIF
	oR7+tWunH1uHf2JAiKaV1aedcUHs5U3U9rogdsPs/RflBrXHsB2v5SfVlfEz0sJKIKuEONAnmm7
	41Kpg+QgiA8KW+PFToggTAhbTcSZrVswdhNsQwVhgEsBFkDQvWxb8+qjyXbWSSRQx17Vmb66GuV
	pP+UgCyB+OxQhawH11cFUVOJV3XHgwo14ra8Qc5OsHsgXNHKQOU8N3tPedBW/so7pHfoCspyEIb
	Gg1y07zDeSk9C94ai5H7mIQ3FW2ynQ==
X-Received: by 2002:a17:90b:4a09:b0:3b0:78c8:d56e with SMTP id 98e67ed59e1d1-3b12d441cbdmr4126098a91.27.1794236735128;
        Mon, 09 Nov 2026 07:05:35 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105864390sm11249661a91.6.2026.11.09.07.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:05:34 -0800 (PST)
Date: Mon, 9 Nov 2026 09:05:32 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: virtio: Reject a message shorter than its
 header
Message-ID: <avHhPI5btZcuhKsZ@p14s>
References: <20261106232322.1093165-1-lian@is.s.u-tokyo.ac.jp>
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
In-Reply-To: <20261106232322.1093165-1-lian@is.s.u-tokyo.ac.jp>

On Sat, Nov 07, 2026 at 08:23:22AM +0900, Lianjie Wang wrote:
> rpmsg_recv_single() checks the msg_len field of a message header against
> the used length with an unsigned subtraction, so every msg_len passes
> the check with a used length shorter than the header. The rx callback of
> the destination endpoint can receive a message of up to 65535 bytes,
> longer than the default receive buffer of 512 bytes, so rpmsg_char can
> copy the whole message into an skb and read past the buffer:
> 
>   BUG: KASAN: slab-out-of-bounds in rpmsg_ept_cb+0x4d/0xb0
>   Read of size 65535 at addr ffff888002484010 by task rpmsg_echo/140
>   Call Trace:
>    rpmsg_ept_cb+0x4d/0xb0
>    rpmsg_recv_done+0x29f/0x840
>    vring_interrupt+0x32a/0x540
>    vp_interrupt+0x146/0x180
> 
> Compare the sum of the header size and msg_len with the used length, so
> no subtraction wraps.
> 
> This patch is assisted by Claude Opus 5.5.
> 
> Fixes: 9648224e564a ("rpmsg: validate incoming message length before propagating")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
> ---
> v2:
> - Leave the check after the dynamic_hex_dump statement.
> v1: https://lore.kernel.org/all/20261102221504.175116-1-lian@is.s.u-tokyo.ac.jp/
> 
>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 23ff6c8b7a20b..3d58bb19e9297 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -676,7 +676,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  	 * the reported payload length.
>  	 */
>  	if (len > vrp->rx_buf_size ||
> -	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
> +	    sizeof(struct rpmsg_hdr) + msg_len > len) {

Applied.

Thanks,
Mathieu

>  		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
>  		return -EINVAL;
>  	}
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.56.0
> 
