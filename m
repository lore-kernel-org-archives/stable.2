Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793819850;
	b=tNlEttBz9GXMfnoN+9ifEiIlrCcfreDEBR+2wyD83T1a0020xSjFfcDMyPvbzUDQXeSg
	 NHEWblZ4F90RaLQ5agiwewG0BCXt9uOFLU2PhjVyAbmUOJu9ozFPMYEo6waog0yb8gygi
	 b1BfZvZCsH9eamsnBQwJO9+Eob1fdPo7edeo/frgKLkIs8t8BmZbOEpovVeRtZC8Dlewd
	 bU9KJ/tffuy/TVaXJqw4UtMonOuioH+SKI1UD6rOCIIipHlxMXRQsOXJcRUzDFHwSwQ0E
	 IKnzJPdDm0J9pVqvB6H65uLBa5loNz0BpZgWGlkv4mshmWQ0hjmAq2Zisq+i6Kto4ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
	b=bVl9ovV25la4Lt7PpfhWq4tGvLgeIgd4BsUYEypLsuuvRp1tBsOLw5ZJ2tnzubF6FioA
	 f350huP9kaeelvE19nwNP0kV9ocyszpbRAx2YvRU50s9Au8EHvb3uVVOvCtwLPGBf4RZV
	 An9zuPsnwQ1/qcJHtRu9+LO2qXJ8LAkXHwsjpbAcU8Hvq3mnmrrWVVzIu3HglOoFH6V4d
	 RJKcBnykPxFU5PJmqdMhIy8LUyrNDdN0B8LbZ491ouvELjes6H4TSy49ljgKbTiRGq2m/
	 F8Krt41ZLGvxm/kvHdxAS11ED/mRUGGK9v4vLkAlde4QF7vNNWVtO/UP1PwNdWsI45g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DczrfccH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329860A2623
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0329860A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DczrfccH
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8aea7b7ca0cso12002637b3.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793819849; cv=none;
        d=google.com; s=arc-20260327;
        b=RaV8SkHAAtW82SfGKgQSIwrZRSGm5oQ5R/aQ2It1/FdF4uPnWF2Fvp7mA/33IUx+a9
         052tUnPlnT8cHwVgq/Z+rli1qJskj1Iwxhd0p77TEBnIlUr5EgTz9DmL9ftG2bFZBDLN
         iA3pGO97vfBFm/e+fpmqNlape/ki76ghg4WJHWLN+ykJGAYAtGEd62eLktQNXvTdGdvG
         reHl34/eUT7nLpZZj3hYbuGIDHuJP9YUcWMiSLRuyGZSZKgx+3SOU3GV2syLG6+q8Ks5
         tA557kbfGA/sukHwBOlgn53c6BF371t4FsQeG6t+WLP2U7pLYVc1nLkcanfMSdj6LuUV
         WIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
        fh=o4qIlD5fRJqeKu8OL0h2TpFphPjz1qfSY3LePDTj5f8=;
        b=DuXduNNhCxCelT68daj1Jx7JjeNEsXiFIrz761rfSLVywM8OJHO8DkoErbSNlXSMFc
         YnfmQg9no1G7h8p+MmZBJEl3OukWcgTkitPpJcc6+HZdk5mVimp5yzEZiT/H6M/cW6MV
         FbnEkXGnYzYjh72Ko7wFe76T5PQ5/AUE5yVcLNwWtfyL5uppzSKcGmbgEsOQMsQIUR19
         VcsZYjOGZkO2eUw/N8vPyybxCSc/x77liRJK6mOeO20b4mhyDBTHOH0GF6QCDvy/elZX
         pGRR/td3B03yxG5Fm8t25DuQ6D58cRrrxQEmnR+BfUHHbDTyCRI2rt2quDDk1uuPOb+X
         RRdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819849; x=1794424649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
        b=DczrfccHl1vCyfye/MRZShyO0W7Vf1kRuO/DiQYoaNOH03T3Tz1GxvlATnfwiva9JJ
         1M3f3I4rBWdMsOqaySVcF1FA6RC974QbHcUoLVxb1R09dVZnNQ5NHrdDt+XIoE9XzOGS
         usa4jLpmdkL8BdaovGZDewJ3dtam3tMC0x5SvxGrorazWbpGtCxXN9ulX+pikgTWS4WY
         HONca1YNCn33KM9j66uy0zhvNK1GU/4/FBAI0afGcOnF4v/N0tzJedr/FbOhp45SyIpW
         JMioSuqPHkhBbxRi6EVwS79MHxwxzdaOe3150wKDvfPte+5o7JuDIb96uqYgdbc8Iw9W
         I8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819849; x=1794424649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
        b=aI6vXJlKXZ+GbtInPtbnWMCMtu83pz8OSiIhcNlRrKynctlVX358uGG7U/X9+9e2kk
         4B5Ns8XuHvLI68tjwsL0JrmNJJVGycbDjaeMp6s2CHHlY7HZUXtWpGkmWJ3sUJgs729s
         fQpPe7OUmXvlNXEfFZqrVz3golD6A79SyfJ06fv4W/6X14i7J92M7PqDOujgo/4qo58b
         zX4ugCwlaZXY7uJfeVpsUG+GgIwtkEMMMmJInY+ASBhFVG4nv/oNWuNc6FTArUlEpVBx
         bOTD4hNDbybE/iJLeCmKGive2+rL4Sd/gEwTxB3OdztUgsn4BMizHcR+K519ngxxfJP7
         62tw==
X-Forwarded-Encrypted: i=1; AKwUvBxOm93bkS8CNpvZg1HqO0Zjs8vdeRQEJiBPVLOtR1viYn05/AFNbXzg6qQmKlgbq0xVCqOKsV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZwF6IEK39vbhXNzv/v4O1NigBIRPRBUc0Gjb9pKyu+lg4SFPc
	EALwfGhrdZnuwrXaww5CG7OXyRwv7wPaEKDyffevBAdbwAQ0zHqxGTPaKTUgalDEg9QDJAUGKvO
	Q80+TllyON9nbpdBXdIiTxnETRjWya+w=
X-Gm-Gg: AYBFou2MsSxlXL+iDN19amn47idYdcyfMKJ/hSgurxN4cn2q1A3dAqTuOeVWqZn0iyV
	eZtKNNA6NKjB1hteRdrqwWcFzvYPKnga4OEpPmiWeirg6kL30gbVEeJ6t68VZSig4fPEHo8CyKU
	NdZqT1qbe2+dDwBar4Qalw3TzP9DK1xUA12KJwZrRFwnvf70305xPVrsmSxpyQh0Zu1lRsCFP9C
	pirLDzSHFJSmm+TnGdG99GzmaSxyDAGN3nzeB3nrZKSLnWlzxddbszUrEq/aqnUuyVyCf8llYSp
	cqZM6xADHcMvxc6yCEVjG54fMIpPtLQP97mmJ4G07iBTSwiZpu0YxSlF/kEiuP+KHMZ4t6d9rW3
	4Ucr6pOTBt/KvUdIcRXNJ8cNLUMGYprGtOOtjNQ1RXACUSem/WJfSTitUXAOkMJJIearwemKZG6
	dSeR3bI2vcPBm+ybxa/WgbRZlM1DX8abUZ8qxkqCYFbFqU1mpzEWMYPgwU4ITXH7TrgscBBLkhG
	s6IIw==
X-Received: by 2002:a05:690c:ec5:b0:8b3:392:dc1c with SMTP id
 00721157ae682-8b30392e155mr29915517b3.36.1793819848895; Wed, 04 Nov 2026
 11:17:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102110440.2589-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261102110440.2589-1-25031212351@stu.xidian.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Nov 2026 14:17:17 -0500
X-Gm-Features: AclHuK8Gh1sKwYgmSHyb8ITOSoc6I6dAtMKDKXBc5cQEbXG-axXVKo592cfZme8
Message-ID: <CABBYNZ+iU=riZ8MSTkbqv4vn0OJGLymtN98uJ8_0pw6hEaVWYQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi YuanZhe,

On Mon, Nov 2, 2026 at 6:04=E2=80=AFAM YuanZhe Liu
<25031212351@stu.xidian.edu.cn> wrote:
>
> The force_poll_sync debugfs file uses the driver's struct btusb_data as
> its private data. The file is created under hdev->debugfs and is removed
> only when the HCI device is released, while btusb_disconnect() frees
> btusb_data unconditionally. The HCI device can outlive the driver data,
> for example when an HCI socket still references it, so reading or
> writing the already opened file then dereferences freed memory:
>
>   BUG: KASAN: slab-use-after-free in force_poll_sync_read+0x129/0x140
>   Read of size 1 at addr ffff88800cfb7038
>   ...
>   Freed by task ...:
>    kfree
>    btusb_disconnect
>
> Remove the debugfs file before the private data is freed.
> debugfs_remove() waits for callers that are already inside the file
> operations, and any later access fails with -EIO instead of reaching the
> driver, so btusb_data can no longer be dereferenced after it is gone.
>
> Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during po=
lling interval")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>  drivers/bluetooth/btusb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dc7191bf4234..d928580512fa 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1066,6 +1066,8 @@ struct btusb_data {
>         int (*disconnect)(struct hci_dev *hdev);
>
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> +
> +       struct dentry *force_poll_sync_dentry;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -4560,8 +4562,9 @@ static int btusb_probe(struct usb_interface *intf,
>
>         usb_set_intfdata(intf, data);
>
> -       debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
> -                           &force_poll_sync_fops);
> +       data->force_poll_sync_dentry =3D
> +               debugfs_create_file("force_poll_sync", 0644, hdev->debugf=
s,
> +                                   data, &force_poll_sync_fops);
>
>         return 0;
>
> @@ -4602,6 +4605,9 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>         if (!data)
>                 return;
>
> +       debugfs_remove(data->force_poll_sync_dentry);
> +       data->force_poll_sync_dentry =3D NULL;
> +
>         hdev =3D data->hdev;
>         usb_set_intfdata(data->intf, NULL);
>
> --
> 2.34.1

Looks like nedev sashiko has found a problem with these changes:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102113654.8724-1-2=
5031212351%40stu.xidian.edu.cn

--=20
Luiz Augusto von Dentz
