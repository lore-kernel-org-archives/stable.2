Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582F3AE6F5;
	Tue, 29 Sep 2026 04:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655214; cv=none; b=Xmoz2zXZFAmtuSMF2/lD7zD1UgvZ2d8BzOSwJ8kK7ZdtCcCCkI5uP5CGR1/ExNe9bHNL1jeEcEiSEWa377tPBxBznhDHsYli66ReH+QduAS0pG1eIStg1LCPVX+ebgoZeYNYqBkd9yjNm9HnEI/hYwCl/QuTzsPn5AXMdKcBNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655214; c=relaxed/simple;
	bh=MWCjkQCRpXwYpiQxoRlqm8dR8TPLBp29MTlJ9isVDl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LaSJxLwFmP39aM5ad5ekHf7NJwBYlJ0/G4DKZXhvYRMtL7IvuoFu5mOzF4fMeSPCs0YTZ+RxMwpETDjUBoy+Ipyko0ixN7j2XFJWpxSGBMJGHsVAEhidzISZx0/z4GyTPw3G+nbWu6vrvSfI2g4TjmRWW1JsYIQ/WN3PAOlwKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=E9e+U2M+; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="E9e+U2M+"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 543124022D;
	Tue, 29 Sep 2026 14:03:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1790654588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QsFLfNq3vG8nkp0+gEhwQTWXj0OnyZv0SNLLKZ3JuRs=;
	b=E9e+U2M+BIBKwZ3UOfdGOev7y+ao0y2GS4HCCSS5qXOOFCkalH8y8v86nQzs+rmLR7urCp
	64y/ybBkIXGgzbRhRYFBGmFaI/ZHBSET0cqp0E8fCbYiJl9VUwJLxwxeXGY6sYetlI3Ll5
	umTl/AFe53L8YqLwX+YwH6SMBTAj6zLR2qwwjXpsgHfT+1mAZbHerSWs3HPxsw44HKurfL
	X9f9wGA07atnCzP4v3HQhutNAO+pfAK3Kh67s266+aD8XpmhmWJpNbj+mOU14ReCvVKYiD
	aS8I/IwUawScsNCRlXjleVfWPW+vo5nLoglPDfNAmzy4blulr7S2prPQC6AojA==
X-GPT-Reason: legitimate_transactional_technical_discussion; the
	message is a highly technical discussion regarding a Linux kernel
	patch (rtw88 wifi driver), featuring specific hardware register
	details (reg_sdio_hisr_rx_request), kernel execution contexts (napi_poll,
	net_rx_softirq), and coding logic; the sender (alastair@d-silva.org)
	aligns perfectly with the recipient's known domain (d-silva.org),
	and the content is a standard technical peer-review exchange with
	no signs of phishing, marketing, or urgency; there are no suspicious
	URLs, and the conversation is entirely consistent with a developer's
	workflow.
Message-ID: <242775cb0b45938c0138ae256073bbd9088c02c2.camel@d-silva.org>
Subject: Re: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Tue, 29 Sep 2026 14:03:08 +1000
In-Reply-To: <7f1ad86870184bfe826dd96a3b031d69@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
			 <ea3434d849b34a4286b0a193351a610e@realtek.com>
			 <58a857e3b0614e2b9a520024b9932685@realtek.com>
		 <919109e886399f09db41ef5800e7335440ed4971.camel@d-silva.org>
		 <5ff354336f4748b9bb45621dd899156a@realtek.com>
	 <4662c1bbc73df10449a3925161979c130d94492b.camel@d-silva.org>
	 <7f1ad86870184bfe826dd96a3b031d69@realtek.com>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 01:25 +0000, Ping-Ke Shih wrote:
> Alastair D'Silva <alastair@d-silva.org> wrote:
> =C2=A0
> > On Mon, 2026-09-21 at 02:44 +0000, Ping-Ke Shih wrote:
> > > Alastair D'Silva <alastair@d-silva.org> wrote:
> > > > 5. Effect on future interrupts:
> > > > -------------------------------
> > > >=20
> > > > Regarding the internal expert's concern that clearing the bit preve=
nts
> > > > future interrupts: in our testing, writing 1 to clear
> > > > REG_SDIO_HISR_RX_REQUEST after the FIFO is drained did NOT prevent
> > > > subsequent RX interrupts. When new packets arrived over the air, th=
e
> > > > hardware asserted REG_SDIO_HISR_RX_REQUEST again normally.
> > > >=20
> > > > If there is concern about edge cases (such as hitting the 64KB
> > > > total_rx_bytes limit before the FIFO is completely empty), would it=
 be
> > > > acceptable to only clear REG_SDIO_HISR_RX_REQUEST if
> > > > REG_SDIO_RX0_REQ_LEN reads 0, or re-read REG_SDIO_HISR at the end o=
f
> > > > rtw_sdio_rx_isr()?
> > >=20
> > > I guess there is a racing between W1C REG_SDIO_HISR_RX_REQUEST and
> > > REG_SDIO_RX0_REQ_LEN =3D=3D 0.
> > >=20
> > > With a suggestion from internal, if we want to disable the RX request=
,
> > > the better way is to disable/enable it by IMR. The corresponding
> > > functions are:
> > >=20
> > > =C2=A0=C2=A0 rtw_sdio_enable_interrupt()
> > > =C2=A0=C2=A0 rtw_sdio_disable_interrupt()
> > >=20
> > > To avoid interrupt storm, I personally suggest to combine NAPI, which
> > > disable interrupt when it processes RX budget (I think we can W1C
> > > REG_SDIO_HISR_RX_REQUEST by the way). If (RX) budget is full, it can
> > > poll again by estimated time. Until budget is not full, it re-enable
> > > interrupt.
> > >=20
> > > Ping-Ke
> >=20
> > Thanks for the feedback.
> >=20
> > Regarding using NAPI and IMR: While NAPI and IMR masking is the standar=
d approach for PCIe,
> > implementing true NAPI for the SDIO interface is problematic.
>=20
> As I know, NAPI is a pure software mechanism, and should not depend on in=
terfaces.
>=20
> Quickly search for the terms 'napi' and 'sdio' in wireless drivers:=20
>=20
> $ git grep napi drivers/net/wireless/ | grep sdio
> drivers/net/wireless/ath/ath10k/sdio.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 napi_schedule(&ar->napi);
>=20
> At least ath10k does.=20
>=20

While NAPI is a software scheduling mechanism, what can be executed inside
the napi->poll() callback is strictly governed by the execution context.
We audited the entire wireless tree, and ath10k is indeed the only SDIO
driver that registers a NAPI instance. However, ath10k does NOT access the
SDIO bus from within NAPI.

In ath10k (ath10k/sdio.c), the SDIO IRQ handler and a dedicated workqueue
(async_work_rx) synchronously read the hardware mailbox over SDIO and buffe=
r
skbs into an internal queue (rx_head). Only after packets are already in ho=
st
memory does it call napi_schedule(), and its napi_poll callback merely
dequeues those buffered skbs and passes them to mac80211.

No other SDIO drivers in the kernel (brcmfmac, mwifiex, wilc1000, rsi, cw12=
00,
or Realtek's staging rtl8723bs) use NAPI for SDIO. In fact, mt76 explicitly
checks `if (mt76_is_sdio(mdev))` to bypass NAPI entirely and dispatch to a
worker thread. Replicating ath10k's architecture in rtw88 would require add=
ing
intermediate RX queues, an asynchronous worker thread, and flow-control
plumbing, which adds significant complexity to what is otherwise a lean SDI=
O HCI.

> > napi_poll runs in NET_RX_SOFTIRQ
> > context (which cannot sleep), but reading from the SDIO bus requires sd=
io_claim_host(), which
> > takes
> > a mutex and must be able to sleep.
>=20
>=20
> How about setting NAPI to threaded mode?

Even with threaded NAPI enabled (netif_threaded_enable()), napi->poll()
cannot sleep.

In net/core/dev.c:napi_threaded_poll_loop() (line 7900), the kernel explici=
tly
disables bottom halves around the poll execution:
    local_bh_disable();
    __napi_poll(napi, &repoll);
    local_bh_enable();

Because bottom halves are disabled, napi->poll() runs in atomic context. An=
y
attempt to perform SDIO operations will trigger kernel panics:
1. sdio_claim_host() calls __mmc_claim_host(), which has an explicit
   might_sleep() and calls schedule() if the host is contended (e.g. by TX)=
.
2. CMD52/CMD53 transfers submit MMC requests and wait on completions
   (wait_for_completion()), which sleep.

Calling SDIO functions inside napi->poll(), even in threaded mode, triggers=
:
"BUG: scheduling while atomic: napi/wlan0-0/.../0x00000101".

Furthermore, the MMC core already provides a dedicated kernel thread for SD=
IO
IRQs: ksdioirqd/<host> (drivers/mmc/core/sdio_irq.c). When an SDIO interrup=
t
fires, ksdioirqd wakes up in true, sleepable process context, claims the ho=
st
on the driver's behalf, and invokes rtw_sdio_handle_interrupt(). Recreating=
 a
kthread polling mechanism on top of NAPI would effectively duplicate what
ksdioirqd is already doing.

>=20
> >=20
> > Fortunately, the kernel's MMC core already runs sdio_irq_thread in proc=
ess context specifically
> > to
> > handle this. If we simply leave the REG_SDIO_HISR_RX_REQUEST bit assert=
ed in hardware (by
> > conditionally skipping the W1C), the sdio_irq_thread acts exactly like =
a NAPI polling loop. It
> > will
> > immediately re-invoke our handler in the next cycle, yielding to the sc=
heduler as needed, but
> > safely
> > in process context.
> >=20
> > This achieves the budget-limited polling you suggested, but avoids the =
heavy overhead of extra
> > SDIO
> > bus transactions to toggle the IMR on and off.
> >=20
> >=20
> > Before I spin a V2 and run through my testing, can you please confirm t=
his aligns with what you
> > were
> > expecting?
>=20
> There is a racing between reading rx_len (REG_SDIO_RX0_REQ_LEN) and
> writing hisr.=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rx_len=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 REG_SDIO_RX0_REQ_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hisr
> T1: read reg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hisr
> T2: func return=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hisr
> T3: W1C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &=3DREG_SDIO_HISR_RX_REQUEST
>=20
> This is the info I got from internal consulter. You can do real
> experiments (add a long delay after reading register when rx_len =3D=3D 0=
)
> to verify if this is correct.
>=20
> Ping-Ke

You and your internal consultant are completely right about this race windo=
w.
If a packet arrives between reading rx_len =3D=3D 0 and performing the W1C =
on HISR,
clearing REG_SDIO_HISR_RX_REQUEST will leave the packet stranded in the FIF=
O
without an asserted interrupt line.

Instead of overhauling the driver for NAPI, this race condition can be solv=
ed
cleanly and robustly using the IMR masking suggestion from your internal te=
am:
In rtw_sdio_handle_interrupt():
    hisr =3D rtw_read32(rtwdev, REG_SDIO_HISR);
    if (!hisr)
        return;
    /* Mask interrupts and acknowledge pending status bits */
    rtw_sdio_disable_interrupt(rtwdev);
    rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
    if (hisr & REG_SDIO_HISR_TXERR)
        rtw_sdio_tx_err_isr(rtwdev);
    if (hisr & REG_SDIO_HISR_RX_REQUEST)
        rtw_sdio_rx_isr(rtwdev);
    /* Re-enable interrupts: if new packets arrived during rx_isr,
     * REG_SDIO_HISR_RX_REQUEST was asserted in hardware; unmasking HIMR
     * immediately asserts SDIO DAT[1], causing ksdioirqd to run another pa=
ss.
     */
    rtw_sdio_enable_interrupt(rtwdev);

I prefer this approach as:
1. It completely closes the race window: any packet arriving during FIFO dr=
ainage
   latches REG_SDIO_HISR_RX_REQUEST in hardware. When rtw_sdio_enable_inter=
rupt()
   restores HIMR, the interrupt line is asserted and ksdioirqd immediately
   services the new packet.
2. The overhead of toggling HIMR is just two 4-byte CMD52/CMD53 writes
   (~1-2 microseconds total per interrupt burst), which is negligible (<0.1=
%)
   compared to transferring payload data over SDIO.
3. It uses the existing rtw_sdio_disable_interrupt() and rtw_sdio_enable_in=
terrupt()
   helpers and requires only ~4 lines of code changes without touching rx_i=
sr.

Alternatively, if we prefer not to touch HIMR, we can perform a drain-and-r=
echeck
inside rtw_sdio_rx_isr():
  when rx_len reads 0, issue W1C to REG_SDIO_HISR_RX_REQUEST and immediatel=
y re-read
REG_SDIO_RX0_REQ_LEN.
  If it reads > 0, continue draining, otherwise break.

I'm not a fan of this approach though, it feels clunky and requires the nex=
t buffer
round to be completely drained, resulting in the code consuming more than t=
he 64kb
budget it was allowed.

Toggling HIMR as outlined above is the cleanest and most standard pattern.
Please let me know if this approach is acceptable to you, and I will prepar=
e
and submit v2.

--=20
Alastair D'Silva
