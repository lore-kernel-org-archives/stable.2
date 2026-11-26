Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703441;
	b=Gyjz3Esp+US1KflCSyq2RvAGyoMVsCbLaMHSsLum1iJu1OCYJA4NHu57eNxYQ+ygeJnD
	 /4pXvJBDTZWxbUn6b/dXvXh1plTomSDO90nLTJW4OrvTwKzL6sVBt9O6yOTLYEyVuOLJH
	 bA4NGoNlbL7IGigdleMqNZhRbbYLK9M2p5V516GaT9+dNBRd/UXGMpkXQOAuSxUzlC38M
	 92odqowfwluB4qGU8KQ/ICrq88H1vQ/o5JFyuOYJTDyj6KsgjfE7ZWbDZoTk/E3YmD9se
	 RC1Ls60SlQtrRYvogLDPIDGqNVRbS+3SXNL6hmLEGL5cVjKq7w1h19REpEXwQaLjLAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703441;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PBcEywGpl7EHmIdTb7DwO6vJO+JCsqru7uf2bj4i97o=;
	b=RPKE7q7szuc1sOCzARmV+Q7+kQscawHQFLGHKWRYKojvcqOrN1RSAWxAMc4DijlbJLX1
	 0oQsVdcaiOjXm++BcxjGLFr+d+vatF2xADZrBnv66ezE+/QKuvQMXP0nskc73Jpdn7JY5
	 YS8U0vJHu5q6Rz+yM3X+AuF29OXEu9MguE673VC22x7eohu8vhv16AbGdeLWx5waFlsvs
	 YD6z7RvCb/3Q6kff3W1UOwt9C64VS/++UL/MiiADlTJSm4Jny6+/3sGZ1Qlh9N0mMozzO
	 rGhYs8OOstP/DOmOFiQh7liUBCobnILyiG/Z4YZc2CqNTpK8EOO1KAakSuh/aOKazWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b="pVEHC0/P";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tB5x6GA+;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EC606A6A3
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 286EC606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=pVEHC0/P;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tB5x6GA+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E8967A051C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:30:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 09:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795703440; x=1795789840; bh=PBcEywGpl7
	EHmIdTb7DwO6vJO+JCsqru7uf2bj4i97o=; b=pVEHC0/PveccPEPqsGGHVoXvfk
	hI/SEnkMcLx7caJgNJGwf5jb+cSJhwSzjKKIE0Etq9Ce0DTeaJgJ4om0maD+5oVB
	DnPkiXsjR+d3s4keXuyyRQJXsZuGJQCp+OE0rlHNS+KM0zrX2rAv8hZpI8zKU3OO
	OXcZeL5/wznL6Zbhje1bX+iHz0VXHT8xbs7K43pROEmjKDL3M5QYmZDayf4G/+5H
	HNuRW/16iahq99AbjP2GQ8PT8mKUWpDhAo8/0SROHupZtcjhiFCh4dbTmhGwkc86
	k1oSccj1J2qCKmAucIMKjvvy3Eiw44GGvRnx1sIY0OSaCFWVjmGm+6MPUPrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795703440; x=1795789840; bh=PBcEywGpl7EHmIdTb7DwO6vJO+JCsqru7uf
	2bj4i97o=; b=tB5x6GA+QvVyRD7AHdGvN+QQxcx4cY5yuEsTW4TdmLM79h5ZBNh
	740xapZY/jSI59eGJdbPV31cGy7zPhPwEU0N8J2aBbuc55d50f6qvt5S2BxzDtdS
	kd184K2Sxk0OMZ9h8GfYJ1xtRlGvyqe5aDY+MjkZNsdhVgjWjLFJLkkd0eRkXiOa
	tStPq+opkak7D+x3tu2wngov7p1f5CwAK//mOBteGj7OCbEXVFjiDlJ69xeGHHBv
	d+yxi1czNNHbrruHDV7EBhRy+ioHX6Ai4kYisPg0h+A2wd0EJE/27PdAw8hUsDkm
	snXqf9fkwexIaE+Qx6zvftE8UOToMJEpk3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795703440; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:KgRaRFP+7qM7EuLLJ5VxFpjN/6Q3ImibotJFTbDszo+liqP
	hGZ6qNaB9KfTv2rr2zcRJLdOP/y7yEer3MY94VWBJ0JcARQaeqfcUj8eoTKQO8wl
	wkqMRIKscJcYYQv14DBEx3qFlSRhSTvmsPdnSPgKkog/KaVaabuQooexlLbsWL/i
	fVz8Ade3qML6w/LgigG3j+pAyHS5n1rIW4tQO7H3Uw1tkmI09riZCDN6p7u45x2R
	QFvMkRBHZCN9NnuboriYM5yOupBbo+teN/9kIEYv07igZf1UK1NkitZYnJTBps15
	ew0QiJ1HWWTLGJalp29hhQtXM6KokGyH4Kj2ivg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nGZoHEmlbTFRTE41axQFzQ0vGqVCMW9U0G1ZR8uoMkc=:aEoDDYAtWWw1d24OnrwiBHPFqGmHZiULiXcq0K+1Uzg=;
X-ME-Sender: <xms:kEIIa1o0x6hUgWl20nN5GegXOy43k4lDlOglKXwcwTdwe5KinXZr8w>
    <xme:kEIIaxpEu5nH5RGSc1M7sBvoOBWVprluI0P10cEkTGxDnvDGCd57fT8JZxL2_YN23
    E0I8vMMxbV7HxinpjrlOnEOFGjE6vXBpqGzW4T3uidTeT1IfK4>
X-ME-Received: <xmr:kEIIa43pITAs3M6s9iGBvB8p9Dt_m652K3pev4G6UJmrSXk3Cu0APUIelyR_t0CYjASqX4dWdQPSFtHgv8OlsS7e3czQ118>
X-ME-Proxy-Cause: dmFkZTGaVY8oc70Z/Zae13IJmz2+T+8FcZgdyHbbUWfFQN6S4dDmsXHnQkH7PaWrFIFBoj
    R+J84uFUumpwXhlb7XWO/7daUhCaTYOHe+X1w/lpEgw/GizUt+s+9Sy4MjxB2B970jr4FN
    V5Jq/WQq/ul5t78uRzNYUvtx5nHpQSiLvEgzohx8mrNIX2kiFyTT7a44dT0EfTPy/2Og+p
    gXGmbgTYdCDn37gK5i/IT1BaJSmYDFQSWucHSTeG1qGNSbBYwnRRZXAJZAjvCiobPFAnpA
    Xb+xgt0lqtUKoDbcv4Qgdl31rwX1zVM8GUvO45ftBvCYqAqmqfR9T4FAVAq+sjDBzen1p/
    lofSRmflEuspzs5uXZj15gxb+Ez3U1rbLcNvmkg0+K5bm3VAm2DSNp99Np5Hp8zU4RZt8R
    mFcRo0ZwuCQsA4xBgL5xG4Pc5Fob5Bh1p3LZoxtHrfvR5usbqFZPsrs6gWUuWwpyyzFpby
    GMAC6wS85yxB1+3yRknNqhTyZktNgbbVUhRu86wzuStV+5yXxPcvOs3D3qTq3f7Ft2xue3
    d4JsDfruusHKTNPcQfqkEXfVzCPbx3KBorSesvDNjFTpV8W9IjWCZlapcFM5e+/NuStnZD
    UDJ7Dhg52Spp6yr0mV/F0/ezSDY7+WcyJ0taH4fkeOjJAEV0Ig1ehx5CJbVA
X-ME-Proxy: <xmx:kEIIa_Ec-WoHGnKic19Ta84KlWd_1SsN_2QbcIRNvWPcY3lse83GHQ>
    <xmx:kEIIazEpAYvS55ovKFgoiZTUXg4tRNK-cwsnH8s1AdfPUXOCVcexaA>
    <xmx:kEIIay5wYORN6Nerytx4Q7aQsLw4UE0t0CiEqqwF7U2S4UCJdPragg>
    <xmx:kEIIa4zsXrd_NkEv-f9tuwJE5dIHddMdt9PnCcZ3bhlAOGN7IWL-8g>
    <xmx:kEIIa_c19cuIcV0QKijwBGBgJWFk0QJhCpSfG1tkAInuBVWdD6aBYjcr>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 09:30:39 -0500 (EST)
Date: Thu, 26 Nov 2026 15:31:00 +0100
From: Greg KH <greg@kroah.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: stable@vger.kernel.org, liuwb@xiaopeng.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5.10.y] spi: amd: fix len==0 underflow and FIFO overflow
Message-ID: <2026112642-password-shrouded-e676@gregkh>
References: <20261107062408-failed-5.10-e2f4edfc061e@kernel.org>
 <20261109030624.419576-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261109030624.419576-1-zhugl3@xiaopeng.com>

On Mon, Nov 09, 2026 at 11:06:24AM +0800, Guanglei Zhu wrote:
> From: Weibin Liu <liuwb@xiaopeng.com>
> 
> [ Upstream commit e2f4edfc061e493fddde16c4bbe1c4f230f41e4a ]
> 
> amd_spi_fifo_xfer() unconditionally decrements xfer->len when a tx_buf
> is present. The SPI core does not reject zero-length transfers, so a
> transfer submitted through the SPI_IOC_MESSAGE ioctl with len == 0 and
> a tx_buf makes the u32 len wrap to 0xFFFFFFFF, and the following
> per-byte loop writes far past the FIFO window.
> 
> The driver also never checks the transfer length against
> AMD_SPI_FIFO_SIZE. The core splits each transfer down to the
> controller's max transfer size but does not bound the total message
> length, so a long transfer overflows the FIFO with out-of-bounds MMIO
> writes (tx) and reads (rx).
> 
> Skip zero-length transfers and reject any transfer that would run past
> the end of the FIFO window.
> 
> Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
> Cc: stable@vger.kernel.org # 5.8+
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> Link: https://patch.msgid.link/20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> [ Adapted for 5.10.y: this tree has no per-message FIFO position tracking, so the check is a per-transfer bound against AMD_SPI_FIFO_SIZE, matching the per-byte loop offsets here. ]
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> ---
>  drivers/spi/spi-amd.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

No, dropping this, you forgot the fixup patch for this one, this
introduces a bug :(

