Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EFD48DB3A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397436; cv=none; b=u/d6dTVwxMqMnRLjTegJ+7GTK3aaKsdR7ByPOyVKF3hAHiop8GbxABEgZP+tath5LrE29ZVUCvwQX0o+vWsZYsHjIJ3lSPzhbSUYbdRprG5NhupoXydEUKNAQj2kP/x47lySy1tt3YvHblmsU8+3xClzPrldLSJASyE3ovbMdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397436; c=relaxed/simple;
	bh=+38OfM4nHCI3nn6CkX7YNwTcRX8KI+gQs8yzJHzGeeI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASjFbaM39aFGdMzTN1U2zCeYdSspEvh5Sdd9DNQa4nwe2mIQVoofWcePq28qnlRT917w4KLn2PlhF4Q1QnOLdPZf1TwOkIo5UVqn6nfkio1uD88fXlAg7822COfmaW8Pp1A8Yqn3BzEZVX3EJTrR/AN/qK7CycTgcqomC3UuVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpKbxpsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpKbxpsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C61F000C8
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792397435;
	bh=oUubqkMNuzbEhZ/QzkYZrhGa1eJOqpDaXmCWOSArqao=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=mpKbxpsWIL+xGNHEPltm7/PKoOw+VIet4mC/3WWio6DA7quIvt7r0Ty5+r4Rk0ErE
	 KbWuAvZ6RuPQDUZFJMVftxIWIzMerGN65TzQoQFxgM4xjWKs1+ilcochC9kSQDIi2x
	 sfd+ykQKkzblJgShYii0tpopHNf62rbZfD4s+y8mTeUYUCBvwykSMhJzFpg1+EdmGs
	 qm5hne3Pw92RlOKJ3AFzpF42JtE4ls1abYdPXb6pj4Dvoi5V4eAndacxcVJ/4dXo4G
	 WENcY47ggowV4MmBPIrvc5m0ftZroNnTapmoh5sQe6zcDZTuEUDP/cEgLUxBKsk29a
	 mxr8C8Tpvej2w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso8433081fa.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:10:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBJOKBifY2C5BF2owQ2O/AIxGgDiuffKsZCapkvovSD8UoM56xJ4biRBKwEnaK5TFcvvBgOLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHf9U3nZrz9OVZmKbC6vSl/aUX1LaErEcDPGYtmjIQeG/4Rf/f
	YY/aSHW+VxBfGyxePlpPQmHmopPzV+/uDc3FoVZWTAhBALoHdgUL3Yn3XD3HPoCKo/N8BEaKyTK
	2y3NitMVN54F9ZDuF/DoPw7lkIUnClKa6i3lwx6D9kw==
X-Received: by 2002:a2e:a991:0:b0:3a7:812b:cfc with SMTP id
 38308e7fff4ca-3ab291582fbmr15016761fa.14.1792397433880; Mon, 19 Oct 2026
 01:10:33 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:10:32 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:10:32 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261016124615.61-1-26rote@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016124615.61-1-26rote@gmail.com>
Date: Mon, 19 Oct 2026 08:10:32 +0000
X-Gmail-Original-Message-ID: <CAMRc=McwkqsphfGC5N8P7dmwwV7BAOR_=E1aV_oNS2h1T-HKxw@mail.gmail.com>
X-Gm-Features: AclHuK_FUPXWaa7SsN-fPmc-RpCDhhG1FoH1FGOFYHxfeCyV9QiuI1-8RFA5HaM
Message-ID: <CAMRc=McwkqsphfGC5N8P7dmwwV7BAOR_=E1aV_oNS2h1T-HKxw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: check the device address on every setup
To: Joonhoe Kim <26rote@gmail.com>
Cc: brgl@kernel.org, johan@kernel.org, loic.poulain@oss.qualcomm.com, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, marcel@holtmann.org, 
	luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 14:46:15 +0200, Joonhoe Kim <26rote@gmail.com> said:
> qca_check_bdaddr() sets HCI_QUIRK_USE_BDADDR_PROPERTY when the
> controller reports the default address from its NVM file, so that the
> core programs the configured address again on every setup. The check
> is skipped once hdev->public_addr is set.
>
> If the first setup runs on the ROM firmware because the rampatch and NVM
> files could not be loaded (driver built in, firmware not in the
> initramfs), the check is not reached. Once user space sets the address
> with MGMT_OP_SET_PUBLIC_ADDRESS, every later setup skips it, so the
> controller falls back to the default address on the next power on and
> bonded devices no longer connect. Seen with a WCN7850 on a Lenovo Legion
> Tab Y700 Gen 5.
>
> Check the address on every setup. Setting the quirk while
> hdev->public_addr is set does not make the controller unconfigured, as
> is_configured() only looks at it while no address is set.
>
> Fixes: 32868e126c78 ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> Tested with the WCN7850 over UART: the configured address survives
> three power cycles, a bluetoothd restart and an rfkill block/unblock;
> without this patch the first power cycle reverts it. The NVMEM BD
> address series [1] changes the same branch; the two apply in either
> order.
>
> [1] https://lore.kernel.org/all/20261015-block-as-nvmem-v11-6-f890ac74f87d@oss.qualcomm.com/
>
>  drivers/bluetooth/btqca.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 22b08ab05b82..756a4a8d5631 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -686,9 +686,6 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
>  	struct sk_buff *skb;
>  	int err;
>
> -	if (bacmp(&hdev->public_addr, BDADDR_ANY))
> -		return 0;
> -
>  	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
>  			     HCI_INIT_TIMEOUT);
>  	if (IS_ERR(skb)) {
> --
> 2.43.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
