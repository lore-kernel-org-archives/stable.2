Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D94AB1A2;
	Thu, 17 Sep 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639515; cv=none; b=DCJonwLjKAgpELA6w6O9/Sq6tFeVYTYN4wpP3EJDPIk1BfySVPrvvMbryXivVDVlYk/Tvil6VGfhDitij9eTAaZFJN/jcXLtgI6g9NPmiHovjZuIFSxyKGZ1Uv5KHiDRuvafa1XycDP5z9ohYocvQXmhHkmZKtUiMZBYUMxZsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639515; c=relaxed/simple;
	bh=oJZpSGeZR7c0gtIpdrbJQjFPlzZ2zTpyCdhVreTnrow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWoNRvFdpVfqlooW/JUrpYx4SyQkxPCI8WhjDKzn4CwXgYHh8g0hyvr+wJketZmtjK4cBxIb64hxUCjSzgfFYMNrJDMYVMSR9brhLBkTPPFRRAqafwgSw3/2z18m/oAvIvvR0Nw+u32tFR6/vzN096642X2qNGk+u2Jehk11ANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=w4WpXlaZ; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="w4WpXlaZ"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 20AA840198;
	Thu, 17 Sep 2026 20:04:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789639474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c3jDlmkxxOD3XtdyCo2tdWsuRppzBPyEgPOWoYIFm4o=;
	b=w4WpXlaZxpCm4PXAWLUxpn8DhT4UZPVwp6YJzX37W6VsRL7jo3bS0bC3ERhkBHvSIVWw1u
	Ny7ryHYojtfJun1AWUfRKLl6ClYJUAWvOMPx1YYf0HroG7Fmv4uOpqN78EMmoBPS1eNi8V
	qWkQhwHMuUacQsEQqgemtPiZHePezZrZgIj/mfu0sSh1D9Ui/ZlRSc4QTVPQHsZAW1/G8L
	OCaXr8uba8xRKYuYBxGzUgi/vwGlhKLfr9TxMrrbm4+RJGcC4C/DNOajcFbFqgLCF2xSpE
	SqxAvuztXV972KHrpuixiBOoNiGfQSGeBJdsqxpK5YGdBfG+KEz4hspxR/QP1Q==
X-GPT-Reason: legitimate; This is a technical discussion regarding
	a Linux kernel patch (rtw88 driver) which perfectly aligns with
	the recipient's identity as a technical/professional mailbox
	(alastair@d-silva.org); the content is a detailed, high-context
	engineering correspondence involving hardware telemetry, register
	analysis, and code logic; the sender domain (d-silva.org) matches
	the recipient domain, indicating a personal/professional relationship;
	there are no phishing indicators, no malicious links, and no marketing
	language.
Message-ID: <919109e886399f09db41ef5800e7335440ed4971.camel@d-silva.org>
Subject: Re: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Thu, 17 Sep 2026 20:04:33 +1000
In-Reply-To: <58a857e3b0614e2b9a520024b9932685@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
	 <ea3434d849b34a4286b0a193351a610e@realtek.com>
	 <58a857e3b0614e2b9a520024b9932685@realtek.com>
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

On Thu, 2026-09-17 at 09:09 +0000, Ping-Ke Shih wrote:
> Ping-Ke Shih wrote:
> >=20
> > Hi Martin,
> >=20
> > Alastair D'Silva <alastair@d-silva.org> wrote:
> > > In rtw_sdio_handle_interrupt(), the HISR status register is
> > > cleared using
> > > Write-1-to-Clear (W1C) semantics. However, the driver masks out
> > > the
> > > REG_SDIO_HISR_RX_REQUEST bit in the local 'hisr' variable before
> > > writing
> > > it back, causing a 0 to be written to that bit.
> >=20
> > I feel this patch makes sense.
> >=20
> > Did you remember why you clear the bit locally? Can you share
> > vendor
> > driver you referenced?
> >=20
>=20
> I asked internal expert who said this bit will be cleared
> automatically
> if all packets in RX buffer are received. If we clear this bit here,
> the interrupt will not raise again if no newly incoming packet even
> there are remaining packets in RX buffer.=20
>=20
> Checking rtw_sdio_rx_isr(), we can see it reads hisr for each
> iteration,
> which this is also the evidence that the bit will be cleared
> automatically.
>=20
> Therefore, we need to dig further why the RX buffer can't be empty
> and get stuck.=20
>=20
> Ping-Ke
>=20

Hi Ping-Ke and Martin,

Thank you for following up and consulting with the internal hardware
team. We have extensive test telemetry and logs from our bring-up of
the Mellow Fly-C5 board in Armbian that provide full context on this
issue.

1. Test Platform & Failure Telemetry:
-------------------------------------
- Hardware: Mellow Fly-C5 (Allwinner H618 SoC, sun50i-h618).

- Wi-Fi Chip: Onboard Realtek RTL8821CS connected over SDIO (mmc1 /
sunxi-mmc).

- Kernels: Tested on mainline Linux 6.18 and 7.x branches using
rtw88_8821cs.

- Reproduction: On stock mainline kernels, immediately upon interface
bring-up and association (wlan0: associated), the CPU core servicing
the SDIO IRQ became 100% pegged in an interrupt storm, triggering RCU
stalls:
    rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
            0-...0: (1 GPs behind) idle=3D... softirq=3D...
    rcu: rcu_preempt kthread starved for 5126 jiffies!

- Verification: With this patch applied (leaving=20
REG_SDIO_HISR_RX_REQUEST set so W1C acknowledges it), the board
completed 100/100 consecutive reboots under active network traffic
(continuous ping, SSH, Moonraker HTTP) with zero RCU stalls and zero
packet loss.


2. Why the bit was cleared locally (Vendor driver reference):
-------------------------------------------------------------

In Realtek's vendor drivers (such as rtl8822bs and rtl8723ds):
- In hal/rtl8822b/sdio/rtl8822bs_io.c:
    if (phal->sdio_hisr & BIT_RX_REQUEST_8822B) {
        /* No need to write 1 clear for RX_REQUEST */
        phal->sdio_hisr ^=3D BIT_RX_REQUEST_8822B;
- In include/hal_com_reg.h:
    MASK_SDIO_HISR_CLEAR explicitly excludes SDIO_HISR_RX_REQUEST.

Martin appears to have ported this comment and software-clearing
convention directly into rtw88_sdio_handle_interrupt().


3. Difference between 8051 and 3081 chips in rtw_sdio_rx_isr():
---------------------------------------------------------------

Regarding the observation that rtw_sdio_rx_isr() re-reads HISR in each
iteration:

Notice that in rtw_sdio_rx_isr() (sdio.c:1057-1073):
    if (rtw_chip_wcpu_8051(rtwdev)) {
        hisr =3D rtw_read32(rtwdev, REG_SDIO_HISR);
    } else {
        /* RTW_WCPU_3081 chips have improved hardware or
         * firmware and can use rx_len unconditionally.
         */
        hisr =3D REG_SDIO_HISR_RX_REQUEST;
    }

RTL8821CS (and RTL8822C/B) has wlan_cpu =3D=3D RTW_WCPU_3081. For 3081
chips, rtw_sdio_rx_isr() never actually reads REG_SDIO_HISR! It sets
hisr to REG_SDIO_HISR_RX_REQUEST unconditionally and loops purely based
on REG_SDIO_RX0_REQ_LEN.


4. The RX buffer IS empty when the storm occurs:
------------------------------------------------

The buffer is not getting stuck with unread data. In our testing:

- rtw_sdio_rx_isr() drains all available packets until
REG_SDIO_RX0_REQ_LEN reads as 0, and then breaks out of the loop.

- rtw_sdio_handle_interrupt() then writes back to REG_SDIO_HISR with
  REG_SDIO_HISR_RX_REQUEST masked out (writing 0).

- Because the bit was not cleared in hardware via W1C (and was not
automatically de-asserted by hardware when rx_len reached 0), the SDIO
host controller sees the IRQ line still asserted and immediately re-
invokes the handler.

- On re-entry, REG_SDIO_HISR_RX_REQUEST is still 1, but
REG_SDIO_RX0_REQ_LEN is 0. rtw_sdio_rx_isr() immediately breaks out,
hisr writes 0 again, and the CPU is trapped in a 100% spin loop.


5. Effect on future interrupts:
-------------------------------

Regarding the internal expert's concern that clearing the bit prevents
future interrupts: in our testing, writing 1 to clear
REG_SDIO_HISR_RX_REQUEST after the FIFO is drained did NOT prevent
subsequent RX interrupts. When new packets arrived over the air, the
hardware asserted REG_SDIO_HISR_RX_REQUEST again normally.

If there is concern about edge cases (such as hitting the 64KB
total_rx_bytes limit before the FIFO is completely empty), would it be
acceptable to only clear REG_SDIO_HISR_RX_REQUEST if
REG_SDIO_RX0_REQ_LEN reads 0, or re-read REG_SDIO_HISR at the end of
rtw_sdio_rx_isr()?

Cheers,

--=C2=A0
Alastair D'Silva
