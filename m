Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814337;
	b=EVKKeF/PORIMob0Qq49FFl3vnXKvKiBOTZ5vglvFmpSR2OicLVAuI1HjPWgW4p+6nCrq
	 ti5RMVTl5f6SiMKfXsD4N1srfR+Yoq66rk30fcnfmdedVGio2wne5dfRIKXrXwOMoQl0B
	 EGz/bzvfjpLFUEi2qZh2xlvO8ZlZdE6Vyt+REiKOgYElu7peKW/8pQ/n7P+IhuwPNROdu
	 ukPjR4ZztNS38a7WAzCUU6dX8mME2bCkMjG1rA4nUBEI5lY5H2Z3aYsmlpJi4AJQ2+PIM
	 HscoUvU/DwYY2TSXP/mLfv6jnF8+R8CA7zUqCb2SQfXz/Lhod2A/FfY30zjsqjbj+Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814337;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5xkZz2I8AMu/3n1/a9XNb4hISvxH2xKwC+RKffmK/OM=;
	b=HExfRswIKUpFcfbBcB5xzV7enH8CEr2iox6TuK7F56y8jBxACEwu0G0lTjIR+6TIFHv4
	 sGK5mcXXECCBn+qp2wyG5hObEdOSoxPSPh0Jl+xC4hu+h9ltmFJNAb42V7aMn4KQyBUnP
	 txkCiRYm0E62VIUsnz6ZNCcfFRAjADE67dYmOThd4PRnvdBEs2FU2tqb6584NnrXiRk3r
	 ixmzHJQommGghSahL0wgmaBSFaMG132P8B2ih8sg/i6naNcIo6uw6kROQg18IuvhcJwqG
	 vmuGGt6pZODiP6bL0NGUoaqqsLAeMnoKdhQIUly5pLmbIj7CvwpuJxMLqoKhtArYKjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liJIzYBF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB268606A328;
	Sat, 24 Oct 2026 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liJIzYBF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D601F01825;
	Sat, 24 Oct 2026 03:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814336;
	bh=5xkZz2I8AMu/3n1/a9XNb4hISvxH2xKwC+RKffmK/OM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=liJIzYBFJf8He7Zckb2zsPXiF1t5nTcSD6aEiN3cHRWT49EdT5rc76dTHIIYT/pMo
	 4ccq60MZwezM0x+mTxhqzC2EIqn/cBhtf2X+W91flZp4HgmgjOKu6GVxmE5kKbXlAM
	 wwLWfobW9ibQLu/ROovYgNSqOfY9snQnCwtpW6+BfsH2y22ZjfAH20D339aYMFGML/
	 lLRRRVc2zrUCskWGD9DiNBKtq4HKaOH20VufJRy5tzv39CoXyc63CV32dvAQ0DuNb1
	 +VaVbJD0V0YPwzaIlB2J+39aQO4ecJDD6rt7VwfEWMTpMAjUlcRU+xuiv5AyWej1IN
	 BiYuzAVCkGI7Q==
Subject: Re: [PATCH v6 11/13] can: peak_usb: don't read past the message in
 PCAN-USB Pro decoders
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 24 Oct 2026 03:58:55 +0000
Message-ID: <179281433565.3130.14307625292135673040@kernel.org>
In-Reply-To:
 <20261022-canfd_check_channel_idx-v6-11-197704231551@peak-system.fr>
References:
 <20261022-canfd_check_channel_idx-v6-11-197704231551@peak-system.fr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message overstates what the old
  pcan_usb_pro_wait_rsp() bug could do.

--

can: peak_usb: don't read past the message in PCAN-USB Pro decoders

This commit adds bounds checks to pcan_usb_pro_decode_buf() and
pcan_usb_pro_wait_rsp(). With these checks, the record walk stops at the
end of the received message and no longer trusts the record count sent by
the device. pcan_usb_pro_wait_rsp() also now rejects a record that doesn't
fit in the received length.

> - pcan_usb_pro_wait_rsp() doesn't check the records against the
>   received length at all. Since the count is a 32-bit value, a bogus
>   response makes it walk the records past the command buffer.

[Severity: Low]
With the current callers, is the last sentence accurate? The code change
looks correct. It is less clear that the old walk could ever leave the
command buffer allocation.

pcan_usb_pro_get_can_channel_id() in
drivers/net/can/usb/peak_usb/pcan_usb_pro.c is the only caller of
pcan_usb_pro_wait_rsp(). It builds a 4-byte header plus an 8-byte
GETDEVID record in dev->cmd_buf:

pcan_usb_pro_get_can_channel_id() {
	...
	pc = pcan_msg_init_empty(&um, dev->cmd_buf, PCAN_USB_MAX_CMD_LEN);
	pcan_msg_add_rec(&um, PCAN_USBPRO_GETDEVID, dev->ctrl_idx);
	...
}

That makes um.rec_buffer_len 12. pcan_usb_pro_wait_rsp() passes that
length to usb_bulk_msg(), so the device can write at most 12 bytes.

peak_usb_create_dev() allocates dev->cmd_buf with
kzalloc(PCAN_USB_MAX_CMD_LEN), and PCAN_USB_MAX_CMD_LEN is 32. None of the
PCAN-USB Pro command builders write more than 12 bytes into it, so bytes
12-31 stay zero.

No record type 0x00 is defined, so pcan_usb_pro_sizeof_rec[0] is 0. All
record sizes are multiples of 4, and the largest is RXMSG8 at 20 bytes.

The old loop therefore reads type bytes the device controls only at
offsets 4 and 8. From offset 8 it can advance to offset 28 at most. There
it reads a zero type and stops on the !rec_len check, whatever value
rec_cnt has.

What the old code could do is read past actual_length. For example, it
could accept a truncated response with actual_length == 8 and a GETDEVID
record at offset 4. In that case it would return the stale request bytes
8-11 as dev_num. The new "pc + rec_len > rsp_end" check fixes that case.

Could the commit message describe this case instead, so that the stated
impact matches what the old pcan_usb_pro_wait_rsp() code could actually
do?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-canfd_check_channel_idx-v6-0-197704231551%40peak-system.fr
