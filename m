Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976375;
	b=leljNn2CQvQMpI6frnMhPd8+ey8uGUIltwC5fKesLbB1d/2GN9NhaoomWg5ceiGShHLC
	 e1FfeYhe0GtOiSWTbQkbDhE8gM7qMtEcj6m/gpOtKiw7FMvvj6ROEr7a/D4jDcmhvNGEn
	 y7NrXfWH9VLtbwf/dgFLHLRjnkkqZNtwkVszt8l2avQtFdLKTSnrkzBkk1y3ekHpdpVvL
	 Rb9oDe938CgfYBodRlfZM1HZdMkaYXY3GCEkB3LwsPasQibhxAzNMJgmvjtpipJzZdhlg
	 Nz5C6OsfVZu8mMGUpk5495h5Smc/uSI6FnSMT/xfgAOtaqaEGW2jwHubm0yXofX6DJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976375;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=bcf8NooVSigb4TfmPTaRxGuCBTM15fUvnjEuKFhLl1k=;
	b=huDuIByWb4dEcyXCe6EiQBvEkXeCP6DafOovE9mBoiK9ZektUU8+PdXnaZ7ehji0az/w
	 loasyvXhzk0+l6iXbYFlO40JuBLq2MnN7FnasmDwgUuBHq1TFfe4gpUB3N02N6O4hP4ba
	 R5NrOglWfntoT2YOBxpq8MfscDGUqxtrwfzauh/dWFIyi21qPCtpwnZnCIPjwi6SavH4O
	 N5fHvRKFrxweWnaA10HTvB2vtuu9Ipy8TFEQnafjJRxsLB/p0oFBf6Iff6zK1HtxraVbM
	 H4sndS0fszRwIsL7rY9pTRCsH14mNgjPyX5K1g6O7nrZXKFP6+LGN+yHyq++g+6bHCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FFxrbnvM;
	arc=none smtp.remote-ip=91.218.175.34
Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93081606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93081606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FFxrbnvM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2dbWv/ipPcBByrtWVppRgZPHES/QVz3Y/W26rsMlQ0o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793976371; v=1; x=1794581171;
 b=FFxrbnvMEF7JCHJuFCQDbFF0oOP5ds8ggkeEYsJnHnNSv9hkWDwkjBi8IHyeLul1mYWhMHgS
 Mm/SKZVfFgBuCnHqqYps8CiK1dw/2tioGwTzkuNE3W1T7hWWF2tuiEhYKENGGspkPRenLkDiVdS
 xs85kurRvIVLKwCbshO3QDEE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a8c2e4ffcc01ae3;
	Fri, 06 Nov 2026 14:46:10 +0000
X-Mizu-Trace-ID: 9a8c2e4ffcc01ae3
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
Date: Fri, 06 Nov 2026 14:46:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <3c56f067d3d87156d8dad56c34b813543ef41d0f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH rtw-next v8 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
To: "Alastair D'Silva" <alastair@d-silva.org>,
 linux-wireless@vger.kernel.org, "Ping-Ke Shih" <pkshih@realtek.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Ulf Hansson" <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, "Alastair D'Silva" <alastair@d-silva.org>,
 stable@vger.kernel.org
In-Reply-To: <20261105025700.1655219-3-alastair@d-silva.org>
References: <20261105025700.1655219-1-alastair@d-silva.org>
 <20261105025700.1655219-3-alastair@d-silva.org>

Hi Alastair,

Thanks for the new version. Two comments below.

November 5, 2026 at 3:56 AM, "Alastair D'Silva" <alastair@d-silva.org> wr=
ote:

> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wi=
reless/realtek/rtw88/sdio.c
> index 172aa7ad4732a..e318fefe5b5e7 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c

[ ... ]

>  static void rtw_sdio_stop(struct rtw_dev *rtwdev)
>  {

[ ... ]

> +     cancel_delayed_work_sync(&rtwsdio->tx_handler_data->work);
> +
> +     for (i =3D 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
> +             ieee80211_purge_tx_queue(rtwdev->hw, &rtwsdio->tx_queue[i=
]);

ieee80211_purge_tx_queue() takes the frames off with __skb_dequeue(), so
without the queue lock. rtw_sdio_tx_write() appends with skb_queue_tail()
and does not look at running, so as far as I can see both can run on the
same queue at once.

That seems possible on the firmware recovery path, where the device is
stopped while mac80211 is still sending, since ieee80211_restart_hw()
only comes afterwards:

        rtw_fw_recovery_work()
          __fw_recovery_work()
            rtw_enter_ips()
              rtw_core_stop()
                rtw_power_off()
                  rtw_hci_stop()
                    rtw_sdio_stop()
          ieee80211_restart_hw()

rtw_core_stop() clears RTW_FLAG_RUNNING, but it does not cancel
rtwdev->tx_work, and __rtw_tx_work() does not check the flag. So a
tx_work that is already pushing frames can append while the purge walks
the queue, and the list and qlen get corrupted. On SDIO this path is
reachable since dc16902cad9c ("wifi: rtw88: ps: Trigger firmware
recovery when failing to leave LPS state"). If I read it right, that is
the only rtw_fw_recovery() caller there, because rtw_fw_c2h_cmd_isr() is
only called from pci.c.

A frame appended just after the purge also stays in tx_queue[] and goes
out after the restart with the TX descriptor from before it, like with
the rearm in v7.

Freeing with skb_dequeue() and ieee80211_free_txskb() in a loop would
keep the list intact. Maybe a second pass in rtw_sdio_start(), before
running is set, could drop the late frames too.

> +     for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
> +             queue =3D rtw_tx_ac_to_hwq(i);
> +             if (rtwsdio->tx_queue_stopped[queue]) {
> +                     rtwsdio->tx_queue_stopped[queue] =3D false;
> +                     ieee80211_wake_queue(rtwdev->hw, i);
> +             }
> +     }
>  }

When the 8723bs back pressure has stopped an AC, mac80211 marks its txqs
with IEEE80211_TXQ_DIRTY the next time a dequeue is tried. On the
recovery path above, this wake runs before ieee80211_restart_hw() sets
in_reconfig. So if I read it right, the wake_txqs tasklet clears the flag
and calls rtw_ops_wake_tx_queue(), which returns early because
RTW_FLAG_RUNNING is already clear. After the restart those txqs only move
again once another frame is queued on them.

PCI does this reset in rtw_pci_start() since 6ac7db1cea43 ("wifi: rtw88:
pci: wake the TX queues after restart_hw and interface up"), through
rtw_pci_reset_tx_queue_state(). On restart_hw that runs while in_reconfig
is set and the SUSPEND reason still holds the queues, so the marked txqs
are woken at the end of the reconfig instead. I think moving the reset
and the wake to rtw_sdio_start() would work here too. It could also take
tx_queue[].lock there, like the 8723bs stop and wake helpers.

Best regards,
Luka Gejak
