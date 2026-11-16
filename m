Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851976;
	b=3XRHBVFENbuhZSr65SmxAh+V6ZVmqsxuFQqWw2w4zsZkL73FRqnbyH8muXt1935i+Nkb
	 Rz4mbr1ZXxmv3tdTSZPxuhKxjMFCsQLQk2H2dEoYyQ+iALO9niODdVldOsonU2Qs4T9nb
	 5R+ev63vKuz+A5v3hHSpD661ga9zRtI1KakRm9s4Ip4f8j20mDeDzVaxejMDcjUYWiwhb
	 D/yjQPyvRLFKpwWfWGwtH9tjlSUy98oFP8HFUs9vXIqlSz8JePmE/64gagJfRYKMHswyg
	 NYZbaXN+l/pvxNj1rtQ1e3dbligPlXnCAK8UxXffZK8R3ToIyydj+zBJsqa9t0qiC7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+nvE593UQ9d0U2IPo3a1ExhnUFrCrkM14breEsOZj/U=;
	b=dAqtYnNt68blGKmcud433E3LeX8DF3FEqTisQfU4oemul/reLKVTJtt8OLllru961+KR
	 BkVQyLzTZCfw9ITiADu726+6iiD/Dv+KqxcChC+38W6YEdJwTJPIsU7dU/hBkCc+gHqt7
	 ez0hbPVSomeKaJmWX1zpPDoHcsq47e9FEhFf9JxHUEz/4yIAEJPoLTuMplf9b4q2DSXv2
	 svFwNAbtzTxQtXSaxWseLQPA+r9itdI2c0MlVorbyeIL27yBEJVzp96vdIqM5pViSBcZI
	 DNizWd/3xM0shdRLEWHisqjIwcoZ9HSobQM+Ak00/znWRPmd/HJiKd57/RUe/bDIQxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUGhZBRQ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8D606A881
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC8D606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUGhZBRQ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso862455e9.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794851973; x=1795456773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+nvE593UQ9d0U2IPo3a1ExhnUFrCrkM14breEsOZj/U=;
        b=tUGhZBRQZ0lPiurakct8TUDeJCPJwiKNmIgg2g/8DtVBDzVQERlreUcHlb2e73VL1+
         BpVMRbdh6Zwu/OaPuoEyYeuaJWsRqfAztKK6tmEwC51Qa+g0WzfNa+L4zs8s7xc58Yqa
         g6vb/aU20b86L4c88uA+mzwEeKNAjmQx5xlqNJAQeD6Q0eB+ntYHiYWMTUS+fUDXWlNP
         PGaVITVZgITbxk9Tu4dZaf2e1eBJIVK5mMvVx/QmerATJ5dqXyWtvjqwPjaa2p4J5X9K
         kHusHaMDMztT9Dj05Xck3P5pAK+aFlRvhVmnveaMZQHGmhNdO7UqRVojyfKHALpJ1VkA
         pcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851973; x=1795456773;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nvE593UQ9d0U2IPo3a1ExhnUFrCrkM14breEsOZj/U=;
        b=hZMmbMt8iBH66gjQ3vNnnojb0QmL+Z/Ogs3sY4THKVlnBB/dSt5AB2pTWY5/YhPIv3
         WAGP3sizs2OjzdN7isuWNlLXPsES9/sixM9dMYn6B4XnPMEeWjB3McltbvbJYpgt88QY
         IaiTv+3MrjnCCpvxGh+PcBj2ut9JZ0T31mpmY7kQuazy+QB2iiNiFOG8Gq9EAs5sfX/3
         umy8HWG06jyJVvJtI+v4AAsSI1BSmpXwIE9T2Yuwq6dQEHLWSVO9VIUmqKfzGMAhJvBA
         VBMaegsbWNFlfisBpxfEr0jJZfOvJ823kKT2VnGJWQCbN7tuLfmi9MJVlb62pz6v5CKa
         91bg==
X-Forwarded-Encrypted: i=1; AL+hErFCW25HM74qpRD4g1YOJTPvVscIQyAIH97+odNtzUqRnm8j2IjFA1K/dNPK7qAk0SlaVt6ghlw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JFrTiVynZ5GQa5DMB07VZBOaGnh27mJha3gxo0Y0o1hr0Wt93
	V/FE0ZYM11js+UWHR7lZl6bk/KKg0ESJ/kYxhRkmFjm+AhIqO8uFeSrnvPRVBdYk
X-Gm-Gg: AYBFou11cZZgLctc+sfgbrUHIwdt1en1fHWLONZsV+Vc9IhbZLp+6HithAguZ4OiJg4
	VnHXloUfGH/PIHFI0aJDrqiQAKZhPRZLo8P+8dqakI3fA05mEfg9fF7Z78Eld442qSpYGT5jotw
	lQl8Wcg9k2K2wgb3JBtURMyunJi0MxisbgeLxTS42Y8tGGTMjlkWqz16oD+yhBkdmETR2bqtq0d
	txw3PUHkk6j0nLSpqQvRxHj2J3bYywPp2emI6I+O4DGGnJEs3TnrSkTIBe9EM+DTkLZK1gpEA5w
	gAymZNL3yZUwXrycym+x4oMkDxz+d06+37causOBFS2vDQOnmh9sC81pX4d/g/aRzNBGxbfJLEO
	t5NSfvyrDF4yYrHKDyubBJWX1Z/3Hzz4UpliNXzJpjn/EG/fdWNUbjzaHJ4JQLA+OXeV9SLXOPG
	Q6B/P9Z85SmphNc7KwNPX6BeXYKvqAYVL2RvASoVICW4ej6L2ONXdBpOdt1Dflh1qohFoV08YsP
	SUH05uZOpb5aEnsOOf1yRhE/bvDAZZMuHoffEThQrTrNnsytPetgOsoanxjy99UyLW4
X-Received: by 2002:a05:600c:678a:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb78372a20mr8533235e9.2.1794851972940;
        Mon, 16 Nov 2026 09:59:32 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm22431108f8f.21.2026.11.16.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:32 -0800 (PST)
Date: Mon, 16 Nov 2026 18:59:30 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] i2c: imx: acknowledge the count byte of an atomic block
 read
Message-ID: <avtEgpw9YpIzCj5p@eichest-laptop>
References: <20261116122707.1349139-1-mehmet.fide@gmail.com>
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
In-Reply-To: <20261116122707.1349139-1-mehmet.fide@gmail.com>

On Mon, Nov 16, 2026 at 01:27:06PM +0100, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> i2c_smbus_xfer_emulated() sends the read message of an SMBus block read
> with a length of 1 and I2C_M_RECV_LEN. i2c_imx_prepare_read() clears
> I2CR_TXAK only for a message longer than one byte, so the atomic read
> does not acknowledge the count byte. The target stops sending, the rest
> of the block is read as 0xff and the transfer reports success.
> 
> The test for I2C_M_RECV_LEN was dropped when the read was split into
> i2c_imx_prepare_read() and its callers. Commit a5d0b9e32745 ("i2c: imx:
> fix emulated smbus block read") added it back to the interrupt driven
> read only. The DMA read never gets an I2C_M_RECV_LEN message.
> 
> Fixes: b460b15b3cc2 ("i2c: imx: separate atomic, dma and non-dma use case")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
> 
> Notes:
>     Reported by the Sashiko review of "i2c: imx: test the block read flag of
>     the message that is read":
>     https://sashiko.dev/#/bug/linux-09e3015b-fc03-4410-809b-82964cdfac9c
>     
>     Tested on a Colibri VF50 on the Iris carrier, kernel at this base, with
>     the M41T0 RTC at 0x68. The core takes the atomic path only after
>     SYSTEM_RUNNING, so a test-only hook called xfer_atomic() with interrupts
>     disabled, with the two messages that i2c_smbus_xfer_emulated() builds
>     for a block read. Register 0x04 (0x13) as count byte: without the patch
>     0x13 and then 0xff (50 of 50, return 2); with it the next registers,
>     the same bytes as the interrupt driven read (50 of 50). With a count
>     byte of 1 (register 0x05): 01 ff before, 01 01 after (50 of 50 each).
> 
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf08cd63151..1a3fc245d6ba 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1283,7 +1283,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
>  	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
>  	 * length is unknown
>  	 */
> -	if (msgs->len - 1)
> +	if ((msgs->len - 1) || (msgs->flags & I2C_M_RECV_LEN))
>  		temp &= ~I2CR_TXAK;
>  	if (use_dma)
>  		temp |= I2CR_DMAEN;
> 
> base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
> -- 
> 2.56.0

Thanks for the fix.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
