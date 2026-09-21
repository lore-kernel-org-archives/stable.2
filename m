Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D533E347;
	Mon, 21 Sep 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982292; cv=none; b=AhZrLUPTkaNLKsxrX57qekmxecpbDAEI55Tg66ZXBqvKQ5HjkTjYD7RpFceCc7eqvpuzSbSEdBT8fY5rVzBNoz8sU0LF/YTzs9pzsIxrP2+F2dAarwjgj8glSKHrD6/B98RybB5bg1J0/yCztDAC9g/VaeHPpJAfEHmS6DNyAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982292; c=relaxed/simple;
	bh=85y/0z1iTonA1/UenLD2541Ftfl31arO/GJG5ggZYf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2tmgmaZGHrIC4shEbJjrB+LpF7frZ1azLcLymuMXaOueCh0meEQqmh0/hyzJZ6BHRmw84QBqgoY9Gj+zPhzgJerInVfazJZqEn/yRA5IkB8zGu62uxV+kawu+G7Sjze6nbYlsda2bl438pciD76BPulojP4kUIrhKO3M4VUynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=zYCJXt6c; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="zYCJXt6c"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 9522B40168;
	Mon, 21 Sep 2026 19:17:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789982271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D2GTRxbXMjywRSPQ1pkKGRQAf5vSn636H0p7D2nPk/I=;
	b=zYCJXt6cRWyJTnrsNCYYpXcwxOUYpL6hmq5hxU4fPHz1ez4WwGF1VIYt/x61JYSHHIr2lR
	KdfuL2n4RVGzLOvu7IPK2ZiOpqvj3Arcbe4xQ/2wmmzGH2U1htzW20NDLRU6+ZY+bqsDeg
	4Kn6K+i830S98GxWyeXswCIQpit2xA0HnFVk9e40DESEkpNV3wI8PyOaWOv6lqlERSSpEK
	VQZsjyYkeN43iUNlCJawksOy037NWLqEvFnkFsHNMr8wVlAqGB9cedISMC6PvHAJ6AGW3R
	S8hMy06/JQIETlG3XTpNqCL2iC31nUuJNzoJ0LQO6uY+jgNJQKzJ/35JbQvJiQ==
X-GPT-Reason: legitimate; This is a technical, professional email
	regarding a Linux kernel driver patch ([PATCH] wifi: rtw88: sdio)
	that aligns perfectly with the sender's identity (alastair@d-silva.org)
	and the technical nature of the content; The message contains highly
	specific engineering details about interrupt storms, register clearing
	(w1c semantics), and hardware telemetry from a "mellow fly c5 board" which
	is consistent with open-source kernel development; There are no
	phishing indicators, no suspicious URLs, and the communication flow
	appears to be a standard technical discussion between developers.
Message-ID: <4662c1bbc73df10449a3925161979c130d94492b.camel@d-silva.org>
Subject: Re: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
From: Alastair D'Silva <alastair@d-silva.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Date: Mon, 21 Sep 2026 19:17:51 +1000
In-Reply-To: <5ff354336f4748b9bb45621dd899156a@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
		 <ea3434d849b34a4286b0a193351a610e@realtek.com>
		 <58a857e3b0614e2b9a520024b9932685@realtek.com>
	 <919109e886399f09db41ef5800e7335440ed4971.camel@d-silva.org>
	 <5ff354336f4748b9bb45621dd899156a@realtek.com>
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

On Mon, 2026-09-21 at 02:44 +0000, Ping-Ke Shih wrote:
> Alastair D'Silva <alastair@d-silva.org> wrote:
> > On Thu, 2026-09-17 at 09:09 +0000, Ping-Ke Shih wrote:
> > > Ping-Ke Shih wrote:
> > > >=20
> > > > Hi Martin,
> > > >=20
> > > > Alastair D'Silva <alastair@d-silva.org> wrote:
> > > > > In rtw_sdio_handle_interrupt(), the HISR status register is
> > > > > cleared using
> > > > > Write-1-to-Clear (W1C) semantics. However, the driver masks out
> > > > > the
> > > > > REG_SDIO_HISR_RX_REQUEST bit in the local 'hisr' variable before
> > > > > writing
> > > > > it back, causing a 0 to be written to that bit.
> > > >=20
> > > > I feel this patch makes sense.
> > > >=20
> > > > Did you remember why you clear the bit locally? Can you share
> > > > vendor
> > > > driver you referenced?
> > > >=20
> > >=20
> > > I asked internal expert who said this bit will be cleared
> > > automatically
> > > if all packets in RX buffer are received. If we clear this bit here,
> > > the interrupt will not raise again if no newly incoming packet even
> > > there are remaining packets in RX buffer.
> > >=20
> > > Checking rtw_sdio_rx_isr(), we can see it reads hisr for each
> > > iteration,
> > > which this is also the evidence that the bit will be cleared
> > > automatically.
> > >=20
> > > Therefore, we need to dig further why the RX buffer can't be empty
> > > and get stuck.
> > >=20
> > > Ping-Ke
> > >=20
> >=20
> > Hi Ping-Ke and Martin,
> >=20
> > Thank you for following up and consulting with the internal hardware
> > team. We have extensive test telemetry and logs from our bring-up of
> > the Mellow Fly-C5 board in Armbian that provide full context on this
> > issue.
> >=20
> > 1. Test Platform & Failure Telemetry:
> > -------------------------------------
> > - Hardware: Mellow Fly-C5 (Allwinner H618 SoC, sun50i-h618).
> >=20
> > - Wi-Fi Chip: Onboard Realtek RTL8821CS connected over SDIO (mmc1 /
> > sunxi-mmc).
> >=20
> > - Kernels: Tested on mainline Linux 6.18 and 7.x branches using
> > rtw88_8821cs.
> >=20
> > - Reproduction: On stock mainline kernels, immediately upon interface
> > bring-up and association (wlan0: associated), the CPU core servicing
> > the SDIO IRQ became 100% pegged in an interrupt storm, triggering RCU
> > stalls:
> > =C2=A0=C2=A0=C2=A0 rcu: INFO: rcu_preempt detected stalls on CPUs/tasks=
:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0-..=
.0: (1 GPs behind) idle=3D... softirq=3D...
> > =C2=A0=C2=A0=C2=A0 rcu: rcu_preempt kthread starved for 5126 jiffies!
>=20
> Does it mean even if RX buffer is empty, interrupt is still triggered?
>=20
> >=20
> > - Verification: With this patch applied (leaving
> > REG_SDIO_HISR_RX_REQUEST set so W1C acknowledges it), the board
> > completed 100/100 consecutive reboots under active network traffic
> > (continuous ping, SSH, Moonraker HTTP) with zero RCU stalls and zero
> > packet loss.
> >=20
> >=20
> > 2. Why the bit was cleared locally (Vendor driver reference):
> > -------------------------------------------------------------
> >=20
> > In Realtek's vendor drivers (such as rtl8822bs and rtl8723ds):
> > - In hal/rtl8822b/sdio/rtl8822bs_io.c:
> > =C2=A0=C2=A0=C2=A0 if (phal->sdio_hisr & BIT_RX_REQUEST_8822B) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No need to write 1 clear =
for RX_REQUEST */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phal->sdio_hisr ^=3D BIT_RX_=
REQUEST_8822B;
> > - In include/hal_com_reg.h:
> > =C2=A0=C2=A0=C2=A0 MASK_SDIO_HISR_CLEAR explicitly excludes SDIO_HISR_R=
X_REQUEST.
> >=20
> > Martin appears to have ported this comment and software-clearing
> > convention directly into rtw88_sdio_handle_interrupt().
>=20
> Thanks for the info. It looks like every SDIO chip does the same thing.
>=20
> >=20
> >=20
> > 3. Difference between 8051 and 3081 chips in rtw_sdio_rx_isr():
> > ---------------------------------------------------------------
> >=20
> > Regarding the observation that rtw_sdio_rx_isr() re-reads HISR in each
> > iteration:
> >=20
> > Notice that in rtw_sdio_rx_isr() (sdio.c:1057-1073):
> > =C2=A0=C2=A0=C2=A0 if (rtw_chip_wcpu_8051(rtwdev)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hisr =3D rtw_read32(rtwdev, =
REG_SDIO_HISR);
> > =C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* RTW_WCPU_3081 chips have =
improved hardware or
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * firmware and can use=
 rx_len unconditionally.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hisr =3D REG_SDIO_HISR_RX_RE=
QUEST;
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> > RTL8821CS (and RTL8822C/B) has wlan_cpu =3D=3D RTW_WCPU_3081. For 3081
> > chips, rtw_sdio_rx_isr() never actually reads REG_SDIO_HISR! It sets
> > hisr to REG_SDIO_HISR_RX_REQUEST unconditionally and loops purely based
> > on REG_SDIO_RX0_REQ_LEN.
>=20
> Indeed. I also found that after sending previous mail...
>=20
> >=20
> >=20
> > 4. The RX buffer IS empty when the storm occurs:
> > ------------------------------------------------
> >=20
> > The buffer is not getting stuck with unread data. In our testing:
> >=20
> > - rtw_sdio_rx_isr() drains all available packets until
> > REG_SDIO_RX0_REQ_LEN reads as 0, and then breaks out of the loop.
> >=20
> > - rtw_sdio_handle_interrupt() then writes back to REG_SDIO_HISR with
> > =C2=A0 REG_SDIO_HISR_RX_REQUEST masked out (writing 0).
> >=20
> > - Because the bit was not cleared in hardware via W1C (and was not
> > automatically de-asserted by hardware when rx_len reached 0), the SDIO
> > host controller sees the IRQ line still asserted and immediately re-
> > invokes the handler.
> >=20
> > - On re-entry, REG_SDIO_HISR_RX_REQUEST is still 1, but
> > REG_SDIO_RX0_REQ_LEN is 0. rtw_sdio_rx_isr() immediately breaks out,
> > hisr writes 0 again, and the CPU is trapped in a 100% spin loop.
>=20
> This answers my question above.
>=20
> >=20
> >=20
> > 5. Effect on future interrupts:
> > -------------------------------
> >=20
> > Regarding the internal expert's concern that clearing the bit prevents
> > future interrupts: in our testing, writing 1 to clear
> > REG_SDIO_HISR_RX_REQUEST after the FIFO is drained did NOT prevent
> > subsequent RX interrupts. When new packets arrived over the air, the
> > hardware asserted REG_SDIO_HISR_RX_REQUEST again normally.
> >=20
> > If there is concern about edge cases (such as hitting the 64KB
> > total_rx_bytes limit before the FIFO is completely empty), would it be
> > acceptable to only clear REG_SDIO_HISR_RX_REQUEST if
> > REG_SDIO_RX0_REQ_LEN reads 0, or re-read REG_SDIO_HISR at the end of
> > rtw_sdio_rx_isr()?
>=20
> I guess there is a racing between W1C REG_SDIO_HISR_RX_REQUEST and
> REG_SDIO_RX0_REQ_LEN =3D=3D 0.
>=20
> With a suggestion from internal, if we want to disable the RX request,
> the better way is to disable/enable it by IMR. The corresponding=20
> functions are:
>=20
> =C2=A0=C2=A0 rtw_sdio_enable_interrupt()
> =C2=A0=C2=A0 rtw_sdio_disable_interrupt()
>=20
> To avoid interrupt storm, I personally suggest to combine NAPI, which
> disable interrupt when it processes RX budget (I think we can W1C
> REG_SDIO_HISR_RX_REQUEST by the way). If (RX) budget is full, it can
> poll again by estimated time. Until budget is not full, it re-enable
> interrupt.=20
>=20
> Ping-Ke

Thanks for the feedback.

Regarding using NAPI and IMR: While NAPI and IMR masking is the standard ap=
proach for PCIe,
implementing true NAPI for the SDIO interface is problematic. napi_poll run=
s in NET_RX_SOFTIRQ
context (which cannot sleep), but reading from the SDIO bus requires sdio_c=
laim_host(), which takes
a mutex and must be able to sleep.

Fortunately, the kernel's MMC core already runs sdio_irq_thread in process =
context specifically to
handle this. If we simply leave the REG_SDIO_HISR_RX_REQUEST bit asserted i=
n hardware (by
conditionally skipping the W1C), the sdio_irq_thread acts exactly like a NA=
PI polling loop. It will
immediately re-invoke our handler in the next cycle, yielding to the schedu=
ler as needed, but safely
in process context.

This achieves the budget-limited polling you suggested, but avoids the heav=
y overhead of extra SDIO
bus transactions to toggle the IMR on and off.


Before I spin a V2 and run through my testing, can you please confirm this =
aligns with what you were
expecting?

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wirele=
ss/realtek/rtw88/sdio.c
index 5b40d74b16ee..933e51a980a8 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1037,7 +1037,16 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtw=
dev, u32 rx_len)
 	}
 }
=20
-static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
+/**
+ * rtw_sdio_rx_isr() - Process RX packets from SDIO hardware buffer
+ * @rtwdev: The rtw88 device context
+ *
+ * Reads packets from the hardware RX FIFO until the buffer is empty or th=
e
+ * 64K packet budget is reached.
+ *
+ * Return: true if packets are still pending (budget reached), false other=
wise.
+ */
+static bool rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 {
 	u32 rx_len, hisr, total_rx_bytes =3D 0;
=20
@@ -1072,6 +1081,8 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 			hisr =3D REG_SDIO_HISR_RX_REQUEST;
 		}
 	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
+
+	return rx_len > 0;
 }
=20
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
@@ -1091,8 +1102,14 @@ static void rtw_sdio_handle_interrupt(struct sdio_fu=
nc *sdio_func)
 	if (hisr & REG_SDIO_HISR_TXERR)
 		rtw_sdio_tx_err_isr(rtwdev);
 	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
-		hisr &=3D ~REG_SDIO_HISR_RX_REQUEST;
-		rtw_sdio_rx_isr(rtwdev);
+		bool rx_pending =3D rtw_sdio_rx_isr(rtwdev);
+
+		/* If budget was reached and packets are still pending, do not W1C
+		 * the RX_REQUEST bit. This leaves the hardware IRQ asserted,
+		 * causing sdio_irq_thread to poll again like a NAPI loop.
+		 */
+		if (rx_pending)
+			hisr &=3D ~REG_SDIO_HISR_RX_REQUEST;
 	}
=20
 	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
--=20
2.53.0

--=20
Alastair D'Silva
