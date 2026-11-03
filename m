Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667263;
	b=a7il/JYDxkoEMHebnKZFqCS8AMPasGSf6OzuauEwlZWJJw1DFeqToXmhv85bjj8hHsqJ
	 P4MNiKl4LvklqccICdQGHMY+9xAkiGTpXZ/eSNl9xYnavcWdl0gKGbSiaxGocAyNNzuKR
	 iKUCiGnsz/yUn+dTAXqiIdjpfGjQwuVOMHj5TDI2TVRCIT7DmmvivoIRQOVUbN8XA/5kh
	 KctPxka8/ZgrZtCgcIDr9BCq7CmIXIWILjOJmtSomt1B1HAiZwJHOgbT/Y8uA2+ElSS6Z
	 lEj6lQHnsA0ZEh0aMb/8nHN4PUfKTz+1sPZ8LfVr698A01x1NyxVbMuxuqY0zvh+NPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:Mime-Version:Content-Transfer-Encoding:
	 X-Mailer:References:In-Reply-To;
	bh=RwyqEgtB25Ow+xlFyVAPMIqpmzERsoMcC9QLCT55HOk=;
	b=LCQNHCUMCsM/fEdVk2nDmJOSduy/7nW/ziZHbdhW7a3GJJKtzEe2/3vbeFeeR3+jXvBQ
	 T+1WAWLSpoCo6dTqsllpKzZEZKRWRG06jacG9nXT94hkQO2kEONKL1k2Ug+EVf4sR20y/
	 /4/7urYRrRnHB4ATTGyenf9U9KTokseHa3LfknCgsPSuONR5QGxM4T9yLpSTY+ktOCf8S
	 CTk7R5cVr0XyveVebx8W34U+1ye1q8GKGEGJJTA031YG5PNod3fIYMBtzvtTZjyenodGK
	 2GNbbC7DbudyG8qi4pUcpdCqqkCiGCE2A57Is22RssCtwCu/eWQooL1UkNEGhZ3hlKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=Oz7pMhly;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FB606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 999FB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=Oz7pMhly
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a17a332ecso5611349eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 16:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1793667262; x=1794272062; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RwyqEgtB25Ow+xlFyVAPMIqpmzERsoMcC9QLCT55HOk=;
        b=Oz7pMhlylLFGR6IGBanENjwP3uVM/ayv9XP6++K0OIxIW+nktXLkCnn/KMlY5Hgl5E
         WIftMD+vs/IeitufizMOl3UlwoviAvmw/87zgb5fnsRXe2H+S+zoaD1+neuxOBx7SIs/
         H7Px1uzOfFlY/Jz01D1vtWbbXx/RG0PLFrl/Ju1Otw/FWehthPSfHssqewmC2JJdHr/4
         WR6MJTntbRN2hN+mHlVozGlTcd1MvRGXkiTGi+tG+6hoNDWw24Eg9j/fztdc86kzKBOu
         HO79FLCNQzBth79qDXGY8eXt2S+npcchE4NBim2h1l+nbc92ayVKnUyJO67CbBw1kX+0
         Z+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667262; x=1794272062;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwyqEgtB25Ow+xlFyVAPMIqpmzERsoMcC9QLCT55HOk=;
        b=HuQQsnaC6oO0sFcn4YwAbcMLaTuQIjnHyJC69d97cleeJzALVxxiv0SHm08oN6BZcs
         vConeZz8xF9olXuyNj8V1TauqthW7MNN9le6ulX+c2V2alvWg5fN8uqN4/STLfgoMfgv
         3Z/emmbFYDyh0wgSzUSqSTH0x9sMDKH35D6+tkG/5I4s5GB0XLl2rX4CnaZ4fva143Ry
         DASDIeqQTfQ7bPK4Pe6R1ZaWjdDcRbb/MayfhXFwe8xpVtenVtycsHTacqVVq8OY0Bfl
         1MdY55MAXf+KXcfYcTZTAwbE3+HnJXZbwIweamcDjHPZpA4TfbCuHVaH/uXTxTga+woc
         XGMA==
X-Gm-Message-State: APuU4Z9QOzRQrBFxLwnaMMjA6inA5HLt+iZnj0fZVfDdTrrx6grO+RNL
	FPq+rKu1q0tSnFLZxQEPzMFylsbuFtZRDt+DPEgqqWpbTmhYzDy6qRenb4IC/KgPrkve6A5/tLG
	3jjJctxI=
X-Gm-Gg: AYBFou23oqFBK+bIIiYqnSCkwET7H8QG8Z1oRHd9SqE5j65NCZpVLd0uINapzuMCyYs
	QyLHnz2AAczbcvBj9CsCJKhXgMbgSw6oBJc5KZTaOtae5dTpTU2plY6PUFdaJHYMBIgeR0MdUTT
	6OpN0TJIJ1l6eAIH4dvwytu6wnmFWKIaqdJ3u1tPgK2SZZl1l3k0EKLa3Oexlk4g32Kp/Rq7nK0
	cxez1qJHN2BZE3vCyjRV20qu7p8Bsa6UycKUUfibCRSlnGsScu7lMt3BWRkumrSicE7p+YCLSk3
	xpDf90OhLVPg2h1jqPrEoQz26eD5G8CMeqZOdXtkIQ6HOIfnagtmbHsy3W1AnoENjp0tIW8i/8d
	2Cgw4lz7jdPsfamT61V9gYcH6MthiHBOJsOmb4GCzY8lgvYYy0mw/2v5NCju2d/nTnCYV7YCuHR
	ZN/d6t4irW2CypqZWGAxHjRQL08+/0s9nw588XedE8XTBqJLpAIh0aj9c42EJHFeKQPU0lanM7o
	vMKdmp4RHVsYg8KP1CBQ/QLEhHfMd7pz8WU/3GhwB8UQkfjjGjwTdruamrTKJvAfrW6+NVoc9TL
	B18h0hxW/piaSR0j4k181vpZQjnlxw==
X-Received: by 2002:a05:693c:6090:b0:36a:4a68:84e5 with SMTP id 5a478bee46e88-36a4a68851cmr17938934eec.8.1793667261275;
        Mon, 02 Nov 2026 16:54:21 -0800 (PST)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm37897209eec.27.2026.11.02.16.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 16:54:20 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:54:19 -0800
Message-Id: <DML5Z7RGR8LJ.1N4L196Z6ZTPS@nexthop.ai>
Subject: Re: Patch "i2c: xiic: defer RX_FULL until all trailing bytes are in
 FIFO" has been added to the 6.6-stable tree
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
 <abdurrahman@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Andi Shyti"
 <andi.shyti@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20261102224014.2424041-1-sashal@kernel.org>
In-Reply-To: <20261102224014.2424041-1-sashal@kernel.org>

On Mon Nov 2, 2026 at 2:40 PM PST, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      i2c-xiic-defer-rx_full-until-all-trailing-bytes-are-.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit f350cc9aac60df9c804cf99ea413ea2cb6109edb
> Author: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Date:   Thu Sep 24 17:10:36 2026 -0700
>
>     i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>
>     [ Upstream commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7 ]
>
>     For the normal path of xiic_smbus_block_read_setup() -- the trailing
>     bytes all fit in one Rx FIFO fill -- RFD was programmed two below the
>     byte count, which fires the RX_FULL interrupt while the last byte is
>     still in flight. xiic_read_rx() then lands in its bytes_rem =3D=3D 1 =
branch
>     and sets NACK on a byte still on the wire, truncating the read.
>
>     Without PEC this is harmless: the truncated byte is the dummy one the
>     caller never looks at. With PEC enabled it is the PEC byte itself, an=
d
>     i2c_smbus_check_pec() fails the transfer with -EBADMSG.
>
>     Raise the threshold by one so RX_FULL fires only once every remaining
>     byte is already buffered. That routes the drain through
>     xiic_read_rx()'s bytes_rem =3D=3D 0 path, which reads everything out =
and
>     emits the stop cleanly. The only change for the non-PEC case is that
>     the controller waits one extra byte-time before servicing the
>     interrupt.
>
>     rfd_set stays inside the 4 bits of XIIC_RFD_REG_OFFSET: this branch i=
s
>     only reached when rxmsg_len + pec_len <=3D IIC_RX_FIFO_DEPTH, so the
>     value is at most IIC_RX_FIFO_DEPTH - 1.
>
>     Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
>     Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>     Cc: <stable@vger.kernel.org> # v6.3+
>     Acked-by: Michal Simek <michal.simek@amd.com>
>     Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
>     Link: https://patch.msgid.link/20260924-i2c-xiic-v7-2-df7e752332ef@ne=
xthop.ai
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.=
c
> index 5e8521f86dd9e..6b6fd1a3f9be7 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -558,11 +558,11 @@ static void xiic_smbus_block_read_setup(struct xiic=
_i2c *i2c)
>  			i2c->smbus_actual_len =3D 1 + rxmsg_len + pec_len;
>  		} else {
>  			/*
> -			 * All trailing bytes fit in the Rx FIFO. The widened
> -			 * condition above guarantees rxmsg_len + pec_len >=3D 2,
> -			 * so this cannot underflow.
> +			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
> +			 * until every one of them is buffered, so the drain
> +			 * takes xiic_read_rx()'s bytes_rem =3D=3D 0 path.
>  			 */
> -			rfd_set =3D rxmsg_len + pec_len - 2;
> +			rfd_set =3D rxmsg_len + pec_len - 1;
>  			i2c->rx_msg->len =3D rxmsg_len + 1 + pec_len;
>  		}
>  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

Hi Sasha,

This patch should be avoided. I have send a revert earlier.

Regards,
Abdurrahman
