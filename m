Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA836E48E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631158; cv=pass; b=Qp/+JOOA+WqV4neH5mYTNb3W2eTDyWmIKGjorW6SPZj0KXl9qdTGyXD+xrB9ChkWFnAd4bnt9uWdLabeRghokGIZwWj4SMMRaNFdTXyYzNztGAbkd0ZVKyRpcHd8cdm3cJrd/3kNDiHOIxBsHjGaMnKJDLKiMtJfdEupfdmftmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631158; c=relaxed/simple;
	bh=/C41jxtKenll5BIssYP09zDrWutfkprHkOjpO9rpivU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnQQzyFmFqUSnL6irLn2SUQ4QyqJWcunTgxbo8G6FzJ+qIG3q8xJjxPCQQ7gGLkWMmfmxnkGFjowVDyZ7vtDtkYmw6R5AR1xuXFbcK0Vm92aBUCqMC8VWHN2IBQMiZ3AJC6Pi4/MZq6QGHSIP7kkZ/9kZx4TeukxjI97OAcpM/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=W5so3R0/; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="W5so3R0/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caed617615so1927605ad.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783631156; cv=none;
        d=google.com; s=arc-20260327;
        b=Jl0jX+EBv/sMAVd1U+7pZz0NgyGBE4JXy1mnFgs3eXCSrBpgZY+4grz2LHBLvdXrMP
         ftG97/jQmIITNxmV8yJ+sbAJ/eO1J5cTPF90sHvsm21boaqXE0iQGeggejy2y8MpvgGR
         cl9FyroTXy9NMe3Ptnchb4uOyqasiL7VG33yLY50ZzQT3ETAsCjh45f5C+5OnM08cLBb
         khOP6e5/qJe9r9Fqszf46U6W4Elpv9a1NUKIDWpz1J+bY0YmQRnGs51gMz7KjAstkiZX
         Wv1U/v/h/iLeBQSiQuPtXDqRePBnnRZPLa0Ifta7OIzInoI4vESX8ii8XOB7udyKb353
         rSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2Mbytc2f5T/npbdUHn7lZOFk/XSgQNmPUoq1DJdzknM=;
        fh=Haao1AKiCrkSt8mTlNw8EqJUCRbnq1xDn+21gIWW4yk=;
        b=T7C/GIrWKm86fAVhVq4KyehhxCRu/A4Kz+ZNNnIHJGmZye//O1JNejPrO6B0NR+BRq
         1WnwembCmE5hCTRh87febo90iGsATdqiI3VjStL/DsyCSpkfpwIxEJYQ7SUAsDj6Bye0
         //cG5T2cK9D8C+oiSyzPzt8T1bUssNd1gfJVH868NF4F/ovSkhYXtZwO/A+LsTtYDoqa
         zHKlRIi1SdEHZSMEwzJEjDuWlbbf4uJcniBnw7aKcO5fcHOjfsxIVn6zeVE6vw2EC+D4
         iHIW9C4jmERV/Lpvw5OWeMvah3hb0/ZklqdY2x0/2FALEnIBo7Fx8smvR/DGOhKD0itm
         pkoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783631156; x=1784235956; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Mbytc2f5T/npbdUHn7lZOFk/XSgQNmPUoq1DJdzknM=;
        b=W5so3R0/pMOk2CFOMEC6wN34ehUOCZVp6hXEvhk0/N43+J18I+6ulEe9v4u4NXtlsJ
         DM55k4ON8ZUUcXedmuEZmWfrB4Z66ro54xZVkPvGQsar9jPuOZpqmmlALCyFOUoUZkrS
         kkB4CsdFyMqIYcdFZH9E9ZbXbdYSTN25e5ZgJckB4yqj5TPZW9NQqfnXrmvFbUB9oeJz
         BKZ1gi+6hFqio/lXqNoqNEVaqk81vnAtm5KDxwgmORtQNscVSIgHaGS85k6A79bdT8wn
         l36RxaP+i3Ljj9+ZOebxrXh9C1zJcT7xTAmS8fkKp9kLU2r+gVIqgFKnDslVnGuBYsyO
         b+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631156; x=1784235956;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Mbytc2f5T/npbdUHn7lZOFk/XSgQNmPUoq1DJdzknM=;
        b=GDuNw4nObRcg+rUcohtQMW5ucfBqPp49qtS7hNfQIZXrIQPIOP03CHNr9ZBqSbg4NX
         OgHPwk1nDdB49iazPW1y3hjJ+8SE0dEPUq9tAT+rd9bq9cuAsVfKIojVEcerYidBPJr/
         ISKx8g7hLjwAlAJtUTjcHmLSKyQ8OfUQW5jnssaWevsfGHWNQ8XFbCE7qaprNuPheR7U
         BLx+3TH6RSnLiWmgpp4iOFHRQPwYj/6jyxewDdvz9YHm674sgePWxSBtUKcjfJMcT3Ue
         +ELtQjkH740omPMH5el8wcBR1NLYbZb2XP7e9rD7+nLHvvqcrua9Uc90mwa4r9nbnN2X
         IdbQ==
X-Forwarded-Encrypted: i=1; AHgh+RperaA+3XmOjbDx7yxoPhOGZ405QOBG6RS/hcDvYumtZmUwnCS0NVg/GpvXslVaA2AThxkAryg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjeU82xIyrXhgxrIgnkCm5Ziasoxi8XDmu5OqLxZSX8Cnrz+m
	ydGRw/Qa04DIshmiyT5nijmcu2nf/WyGk8AMAYHpPTodCzLIZf76icI6tzTusR9jR+PLOZyejwi
	oPIpXq2ChPQZoz/+haihAd2KXWfYFFV7Ol/k/YQQAm8Y=
X-Gm-Gg: AfdE7cm7u0XVGkWbZPxFZ53r6RpEW6MURiX96q0HmteAwb00hPdqBG52sUhi6QkzQhf
	dC13ZUaOXv7LY+Kn66hB3RKsrXhdy3rSENDhJUHs4X9DsBtcX72u02QodUIp7ms2zdCIpQDs0eL
	X4vbEQjD3qj17IbojFOQwDMRwsM6bOlfO6NnEHT0+Qf/74IzwOwW80pIcr2/601nHWrKRQUxJbs
	xfALEzrEBp62tOhDaIk2nCQvtMcLR0Wb3peVLRDBcExvjh1hb9fxd6NsrJEWEIYWY9DozEyIFMm
	pVC8N+Kul6hmrJpJJdxys1UAfaTf00ZpwHypDkZJ9CDzt9gjttkiNFuHjxy5D+zRc/ipKAM=
X-Received: by 2002:a17:903:2a83:b0:2c7:ef3b:e17f with SMTP id
 d9443c01a7336-2ccea489320mr98226595ad.36.1783631155734; Thu, 09 Jul 2026
 14:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705115650.81724-1-doruk@0sec.ai> <f28eea1f-80da-4def-b11f-33a531a1b595@molgen.mpg.de>
 <AS4PR04MB9692E00192B16910C3F3C011E7F12@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB9692E00192B16910C3F3C011E7F12@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Thu, 9 Jul 2026 23:05:43 +0200
X-Gm-Features: AVVi8Cdkzqa-f-Il9d6LSREN7qAcZCWeuHYqDS6LpZWVeqr8yyG_4lzRg21oYkA
Message-ID: <CAPdMp1pcsmnnH9vXKfhxSo5q0Dr+TiLL+0ZrN=Pz-eZtWQjutg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Neeraj,

Thank you, and sorry if I'm missing sth!

That patchwork link points to Zhao
Dongdong's "Fix use-after-free in probe error path" patch, which addresses
the probe-path use-after-free rather than the firmware-download read.

On the firmware-read side: commit 25c286d75821 ("Bluetooth: btnxpuart: Fix
out-of-bounds firmware read in nxp_recv_fw_req_v3()") bounded the v3 handler.
My patch targets the v1 handler, nxp_recv_fw_req_v1(), where (at least in
today's bluetooth-next) the header length is still read at
nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)

with no bound on fw_dnld_v1_offset, and the payload write still uses the
non-overflow-safe "fw_dnld_v1_offset + len <= fw->size" form
(fw_dnld_v1_offset is u32, so the sum can wrap).

If it's still open, I'm happy to send a v2 that also logs the
offset/size values,
as Paul suggested. Either way, thanks very much for taking the time,
and I'm happy to defer to whatever you have queued.

Best,
Doruk



On Mon, 6 Jul 2026 at 06:20, Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> Hi Doruk,
>
> Thank you for submitting this patch.
>
> However, a similar patch is already in review and approved by me:
> https://patchwork.kernel.org/project/bluetooth/patch/tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com/
> It's awaiting Luiz's review and/or merge.
>
>
> Hi Luiz,
>
> Can you please review the patch mentioned in the URL above, from Zhao Dongdong? I have answered your review comment.
> Thank you for your time and review.
>
> Thanks,
> Neeraj
>
>
> > Dear Doruk,
> >
> >
> > Thank you for the patch.
> >
> > Am 05.07.26 um 13:56 schrieb Doruk Tan Ozturk:
> > > Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
> > > read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset
> > > but left an unbounded read in the v1 handler.
> > >
> > > nxp_recv_fw_req_v1() advances a device-driven download offset
> > > (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> > > bookkeeping runs even when the payload write is skipped, so the offset
> > > can walk past nxpdev->fw->size. When the controller then requests a
> > > header (len == HDR_LEN), the driver reads the 16-byte bootloader
> > > header at
> > >
> > >    nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
> > >
> > > with no bound on the offset, reading past the end of the firmware image.
> > > A malicious or malfunctioning NXP UART controller can drive this to
> > > read out-of-bounds kernel memory during firmware download.
> > >
> > > Bound the offset before the header read, and convert the payload write
> > > guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset
> > > is u32, so fw_dnld_v1_offset + len can wrap).
> > >
> > > This was found by 0sec automated security-research tooling
> > >
> > (https://0sec.a/
> > i%2F&data=05%7C02%7Cneeraj.sanjaykale%40nxp.com%7Cc82fdb86e33f476
> > 570ed08dedad83110%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > C639188819230990815%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiO
> > nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyf
> > Q%3D%3D%7C0%7C%7C%7C&sdata=z6YC4OGfeSW45U2PbFFlFz13DG3%2FSr
> > qYeFKMSNTiMBI%3D&reserved=0).
> > >
> > > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> > > Bluetooth chipsets")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: 0sec:claude-opus-4-8
> > > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > > ---
> > >   drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
> > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btnxpuart.c
> > > b/drivers/bluetooth/btnxpuart.c index 6a1cffe08d5f..88d9ebf25a8f
> > > 100644
> > > --- a/drivers/bluetooth/btnxpuart.c
> > > +++ b/drivers/bluetooth/btnxpuart.c
> > > @@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct hci_dev
> > *hdev, struct sk_buff *skb)
> > >                * and we need to re-send the previous header again.
> > >                */
> > >               if (len == nxpdev->fw_v1_expected_len) {
> > > -                     if (len == HDR_LEN)
> > > +                     if (len == HDR_LEN) {
> > > +                             if (nxpdev->fw_dnld_v1_offset >= nxpdev->fw->size ||
> > > +                                 nxpdev->fw->size - nxpdev->fw_dnld_v1_offset <
> > HDR_LEN) {
> > > +                                     bt_dev_err(hdev, "FW request
> > > + offset out of bounds");
> >
> > Would it make sense to log all the values, as I'd think, such an issue might be
> > hard to reproduce and gathering the values miht be difficult?
> >
> > > +                                     goto free_skb;
> > > +                             }
> > >                               nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev-
> > >fw->data +
> > >                                                                       nxpdev->fw_dnld_v1_offset);
> > > -                     else
> > > +                     } else {
> > >                               nxpdev->fw_v1_expected_len = HDR_LEN;
> > > +                     }
> > >               } else if (len == HDR_LEN) {
> > >                       /* FW download out of sync. Send previous chunk again */
> > >                       nxpdev->fw_dnld_v1_offset -=
> > > nxpdev->fw_v1_sent_bytes; @@ -1053,7 +1059,8 @@ static int
> > nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
> > >               }
> > >       }
> > >
> > > -     if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
> > > +     if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> > > +         len <= nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
> > >               serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
> > >                                       nxpdev->fw_dnld_v1_offset, len);
> > >       nxpdev->fw_v1_sent_bytes = len;
> >
> >
> > Kind regards,
> >
> > Paul
