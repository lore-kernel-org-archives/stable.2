Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DE3EA94C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874279; cv=none; b=GvSJW4tHuuXrNfccnlYoYIRSdUeVVs6URNIzaYhyMRSB6935wdtirdQYEt7kw/OkM563RFvhJufOPzfnhomcy3zCzSY2SYV0EouRSsGXSJhNf02ri7SKeWHhy4yLPmtcNcsv5/WvcL3f1znhMGE3Rxm/uI+IGSegOWIPvam1m+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874279; c=relaxed/simple;
	bh=PpqVuzPzg8SDxXOWgKNV7iFrqgNDiAsyJhClQMf5ARw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=necLkAOWqEi81iImDVG4Ah8AULt8F9q9tuAB8ZsprzpO22/Rr0iU+oQwSXF2lOvvcvsv+Yhs/KIPnrn3PiaonFSQa6gWUj9DjbNbOX/nPdiczSR4sgDrtNOVhdBLz1xwGdlQ2APur/0oZUXwIkcdykLoSdCInmrXGsbD0p2WcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AaRGqzYV; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AaRGqzYV"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PpqVuzPzg8SDxXOWgKNV7iFrqgNDiAsyJhClQMf5ARw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791874275; v=1; x=1792479075;
 b=AaRGqzYVlXLHPQYTXkYBSS/51UXdcBuPUD1Ki4RsyVWgbIvTtKFR69jDWgPrd5XxQAdpdqEH
 GSfWMZ1yvbgJd3MC8j+CJB3d7boudu9CpzMcg3FJk1HR5Y5aYXn5Jbg0+wJq6FZoz/y3MlPcTn6
 3KSoSbKkyGiRHIoAh+I9HK7Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 726380c402274b50;
	Tue, 13 Oct 2026 06:51:15 +0000
X-Mizu-Trace-ID: 726380c402274b50
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 06:51:14 +0000
Message-Id: <DM3IF1RE7901.FAXJ1LU10C96@linux.dev>
To: "Alastair D'Silva" <alastair@d-silva.org>,
 <linux-wireless@vger.kernel.org>, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: "Luka Gejak" <luka.gejak@linux.dev>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH rtw-next v5 3/4] wifi: rtw88: sdio: Fix unhandled RX
 request interrupt storm
From: "Luka Gejak" <luka.gejak@linux.dev>
X-Mailer: aerc 0.22.0
References: <20261011220755.1673367-1-alastair@d-silva.org>
 <20261011220755.1673367-4-alastair@d-silva.org>
In-Reply-To: <20261011220755.1673367-4-alastair@d-silva.org>

Hi Alastair,

On Sun Oct 11, 2026 at 10:07 PM UTC, Alastair D'Silva wrote:
> On 3081-based SDIO chips (e.g. RTL8821CS), hardware does not automaticall=
y
> clear REG_SDIO_HISR_RX_REQUEST when the RX buffer is empty. Masking this
> bit out before writing back to HISR prevents it from being acknowledged,
> causing an infinite interrupt storm loop that locks up the system.
>
> 8051-based chips instead rely on hardware to clear this bit automatically
> once the buffer is empty, and software must not clear it.
>
> Split rtw_sdio_handle_interrupt() into separate 8051 and 3081 handlers.
> For 3081, disable interrupts via HIMR, acknowledge pending status bits
> via W1C writeback, service pending events, and re-enable interrupts under
> irq_lock if still running. For 8051 chips, preserve the existing behavior=
.
>
> Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO =
based chipsets")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 62 +++++++++++++++++------
>  1 file changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index 7d4f17e96648..9fbd7654ada4 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
[...]
> +     rtw_sdio_disable_interrupt(rtwdev);
> +     rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
> +
> +     if (hisr & REG_SDIO_HISR_TXERR)
> +             rtw_sdio_tx_err_isr(rtwdev);
> +     if (hisr & REG_SDIO_HISR_RX_REQUEST)
> +             rtw_sdio_rx_isr(rtwdev);
> +
> +     /* Unmasking HIMR re-asserts the IRQ line if new packets arrived */
> +     scoped_guard(mutex, &rtwsdio->irq_lock) {
> +             if (rtwsdio->running)
> +                     rtw_sdio_enable_interrupt(rtwdev);
> +     }

The ack goes out before the drain, so RX_REQUEST is cleared on the card
before rtw_sdio_rx_isr() has read anything. That is fine while the drain en=
ds
with RX0_REQ_LEN reading zero. It does not end that way in two cases, when
total_rx_bytes reaches SZ_64K and when rtw_sdio_rxfifo_recv() returns an
error from 1/4. There the data is left in the FIFO with the bit already
cleared, and the interface depends on the card setting RX_REQUEST again for
data that is already sitting in the buffer. The comment only claims that fo=
r
newly arrived packets.

Your RX test probably covers this, 65 MB in 15 s would have hit the 64K
budget many times, and a stalled interface would have shown up. I would sti=
ll
want either the datasheet sentence that the bit is set while the RX buffer =
is
not empty, or a second look after the unmask:

        if (rtw_read32(rtwdev, REG_SDIO_HISR) & REG_SDIO_HISR_RX_REQUEST)
                rtw_sdio_rx_isr(rtwdev);

> +     rtw_write32(rtwdev, REG_SDIO_HISR, hisr);

Here the whole snapshot goes back. On 8051 the write back is masked to
RTW_SDIO_HISR_CLEAR_MASK, because undefined bits written back raise the
interrupt again after resume, and that mask leaves out RX_REQUEST and also
AVAL, bits 8 to 15, BCNERLY_INT, ATIMEND, ATIMEND_E and CTWEND. RX_REQUEST =
is
the only bit that has to go on 3081, so would

        rtw_write32(rtwdev, REG_SDIO_HISR,
                          hisr & (RTW_SDIO_HISR_CLEAR_MASK |
                                REG_SDIO_HISR_RX_REQUEST));

be enough? If the full write back is deliberate, I would say why.

>       hisr =3D rtw_read32(rtwdev, REG_SDIO_HISR);
> +     if (!hisr)
> +             goto out;

include/linux/cleanup.h:148 asks that goto and the cleanup helpers are not
mixed in one function, and this function now has both. Wrapping the two
handler calls in if (hisr) { ... } would remove the label.

Two questions on the cover. The storm is described for 8821CS and 8822CS
while the validation lists RTL8821CS only. Was 8822CS observed, or is it
inferred from the same 3081 behaviour? And the board tested is sunxi-mmc,
which runs the handler from ksdioirqd. sdhci, dw_mmc, meson-gx-mmc, mtk-sd
and mmci set MMC_CAP2_SDIO_IRQ_NOTHREAD, so there the handler runs from
sdio_irq_work and the host has its own way of rearming the card IRQ. A line
in the cover saying which of the two the mask and unmask timing was tested =
on
would help.

Best regards,
Luka Gejak
