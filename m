Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794426560;
	b=3JbiXVfFEUOpyz/89iVHlfGEO7CqWN1bFBjKal/XCzh1Pp0uMK0zN1CpMwPKjrgJtHu4
	 86HxFC02DQjHn+9Wmx2gmzNtlW77A6MFHy23YKx8butnCUDIS+P+P9mBzOQqg1/6XVbgi
	 yl4aKw3VDL98g4mIVRrGi3Rpliy0UVvzGjQRtbmSAJPU5uHv6JLUFdJ68HqsFMcu0aFE4
	 i/7yV5ktWlWEWwkj4NT1i1752ocDsLr7JvwkHUB4bJCuxCOgUJdak1gUCEP0RXpDeOytN
	 OxC+ens7e5xJtIUlR3Xjztu1NXLJ4eJgoI7vJvkhAxKD7RZ6ALMPTeGo7dY0H/KSqNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
	b=3GhFz4g5gb49KEYCnMipT7AkjA7Ai2fU3Bz2lwo8UIovWorJ7iFAX4gKOhGw17w3XjKc
	 HKj7ZzsoH/t13G3pEap5xGLPuJ26pYliFJWZ6Bfu3My0rkhf1pO8LU9PdfHBL1oseMKw4
	 VqcnHdTIWW9aa/b7gSFWp43svR0nalMboZSolyIzUfm9kqUtaqyzSHej+4GxDx6sUp0Zn
	 qDAaRMgVVGLJSrmLQEBk/uN40P01eT8JLHMuRm7toCc97frh5NEjlochcVJEJ6KO062tF
	 6ZSl4VRSxQo8h31GTuaki1TnpO7mMezBQUEXINWxg/CoG7853YT5iOy1JvRL6RNsgdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dyveBgFZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9A606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF9A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dyveBgFZ
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so5349668d50.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794426559; cv=none;
        d=google.com; s=arc-20260327;
        b=HU9i2U8Yj9C2/fmmQeMTC9YUHAnbsw/PfFvswLjNrq8P/cetpDucBEuG91NnXby2/y
         iSOh6jwkH8ieK0LH8NbE8XIwEf1dhNdfBRM7YeHC5CnbooKFF7T3ov98XmTEehV201Z1
         /rSr2kFTPNr2WRYm+Yh1f2FZGgSRKpAi3AtmIMHZEeTFowUrUOd2BojuepX55wrLPVPz
         7+aEPDEEcaFAUo7WT5bSoKZQyh/WitN8JjibUZpaw0mR6+LscnJmpu1/lstYTk7Q6tjA
         chS1QjYagFb95O1mH0h/N//qT/z6XTrIc2HyYuvsp65IWMujI63ZdXW31XjLD7ldfeIf
         Pewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
        fh=zD0O/za/9o5ITswwozAbvuuwXXipPmd6eXTbpTWciR0=;
        b=ZGBgbc7JSW4qJ15LJO/h1+HKHnFr1oiujZ0pIbB6xG0aWerfysxw+KVcHHdSoSP+dJ
         ZNoXdkk2oz2hJWVv21TYOKYrbkzVYOHbS0fI3wp0XZV0AnRQzi09j6loRurnAknHSV0+
         Ob2bSyuHkcA6Ylf1EnIYV2QD7uERUXXn4jKQ86/Zmbjay03xOEf63/+CTr+OVcLLuLiO
         zWszr4qYn9StKU2UBioeg9pRc/RFQ0zjT5jiKV45CFfo3VydJ1DhtEbJ1L/4Z70mv7ml
         bSje2zux20el6CqNmhknSiT4/YhI7tHht+cvQO6ZYYNtb3wMKjApx68QwkSSbd64e9Cd
         m81A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794426559; x=1795031359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
        b=dyveBgFZOSJ1AmxXJr3r+ZDDSuXIK8tQ0OFELTZLAYAsiF2dsH81Vwlxok6b9fbMEP
         t7zC9+EVmwjCOK/QC26cxcLW4IRQaCqP2MWTQE6YzfWG2Tdz2wb4hKYBcBSXBR17Ok5E
         t9vjzioN727NkjJgM1q/lf+Bz0BiED/xbQ9wij/mDpgxo3CKQWQeDMdIzWZXzU0SojWg
         6OU7onAy0aLRvH79OTl/RFgBqhggobkzHqNNIsvr92IpPrypxp+hEcRfuhZzqQvnqbQ/
         v+H4caZ+ytIGVQJd2xzECjkICGv/CIdiWdg+/dHQ8CTkki1meHdcYGi+McEBPK8z5fgL
         cmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426559; x=1795031359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
        b=0gejcsV21XOZCWfIFP5nNDcMJ+g5JuUkHQh9tPw+528wdD4IYHwkq+xvqXwdqDmzuY
         Ji904TE1JZYd6w3YqBMf7BAQIMCwCOOwiTUF7vYLg4iMzbKVk65lsfO6l0Kk7mpE9Jyi
         FN8CVkAr2qkviZbm4FU/sTHBPcFQq8Lem/Xu2E0TT2BOP1IYOCUaHVeUYel7e9WmHvl1
         s4QuIc+s3syb+R1Dvyt+W46aTYUPKo/uOCLBpi4Jfgsw4RoVcbqO5ax/PKysKBKdqWUq
         IKxhpy/fN0nWAGt+NtPgZuBim7s9VN13P/H5x84juUJ2qSKR2Q8F/+64AtFB1grEqzxv
         Vv+Q==
X-Forwarded-Encrypted: i=1; AL+hErF+lFkNIALRmbQtir107sxyHLz1avCmKsEsKgMDnFml3Y7kn1lah6EZL6QpS8Z9ASpV+x5B6KE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oAxgonP5Yrt0miUvBblVMR3gb39H1NpHDpzQeEAR/ODER7IzH
	20xew841ji7HI5dVrxWozbdtEcbchA2v/P4jaS0Mob5Lj9LSLtAbmWf+IwgDLM84bUHVvn3R11Q
	qTriilmzeVFbDNiw+NH7tFz1SB2Kb0Sm4N4gk
X-Gm-Gg: AYBFou1yd+7z1OwS5TwNjACUbCziia/Blh/A9onJzJgdY/AZY07cmICnM4W7h4el9C6
	fADII8ChI+4syue+V6Z5Cvj164S2kOLmL74pfnGqPo49pRcZqEV33aihoTjoeBbQIdLRCpM6e0d
	8WwGAaCoEoi7kChk3emS8ctGC4I9IETvZ66+YfochCSuR8iBz6Pbxb1RF6JbkUN87CoC7+elFjd
	/ytWDw/PG1icQA7rYsGln9UKgN2zM/bgzrINqttcWVbpVNaf7hiTOs4tEGoYvBMeoXGMec72lTv
	H1VX3zEyG5m3ma4tABaGjVPDTDrKZXfxUBaDKwNOEqR03Ax4sdZzBuRxlwLZZ80JidY5W/TllZJ
	IKUw+mH/dI0cYAB+ZpKQhRdIXfrhnEyBsvCSLkFDMWEzbUVqRtxi+Wzr02QluiwLFVGTvbghKU1
	gBjp5W/0mRQJclKfMkRyitdCybE73Z6j82aN6FH/ATooxGch+D3A9ft5zpg+w=
X-Received: by 2002:a53:cec6:0:b0:679:9e0b:dc4a with SMTP id
 956f58d0204a3-67c67f5905fmr1755689d50.49.1794426559390; Wed, 11 Nov 2026
 11:49:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110175334.676816-1-piyus@iiitd.ac.in> <20261110175334.676816-2-piyus@iiitd.ac.in>
In-Reply-To: <20261110175334.676816-2-piyus@iiitd.ac.in>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Nov 2026 14:49:07 -0500
X-Gm-Features: AclHuK-nfByfHGxFAPmMdYDp3chGaQIH-KV5UpMqKHJaLwdjvVYyKqOTEoEvZVI
Message-ID: <CABBYNZL9GjdZvU6Z8B2v5_5iGXBno5K-GvqkKfX5vjEaTkV9vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_sync: drop adv instances the
 controller cannot carry
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Piyus,

On Tue, Nov 10, 2026 at 12:54=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> wr=
ote:
>
> An advertising instance stores up to HCI_MAX_EXT_AD_LENGTH (251) bytes
> in adv_info. How much of that is accepted when the instance is added is
> decided by max_adv_len(), which depends on a feature bit in the
> controller's LE Extended Advertising support:
>
>   ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH
>
> ext_adv_capable() reads hdev->le_features[1], which is re-read from the
> controller on every bring-up, while the instance list is only freed in
> hci_release_dev(). Instances therefore outlive a power cycle, and an
> instance added while the controller reported LE Extended Advertising
> can be far larger than the capability now allows.
>
> hci_update_adv_data_sync() picks the writing path by that same bit.
> Without it the legacy path runs, and hci_set_adv_data_sync() writes
> into struct hci_cp_le_set_adv_data, whose data[] is HCI_MAX_AD_LENGTH
> (31) bytes on the stack, while eir_create_adv_data() copies
> adv->adv_data_len bytes into it. A controller that reports the feature
> on one bring-up and not on the next overflows that buffer. This can
> happen when, for example, a USB dongle answers LE Read Local Features
> differently after a reset. scan_rsp_len has the same problem against
> hci_cp_le_set_scan_rsp_data.
>
>   BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
>   Write of size 220 at addr ffffc90006b679c1 by task syz-executor
>
>   BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
>   Write of size 220 at addr ffffc90006ca79c1 by task syz-executor
>
> Both are reached from HCIDEVUP by way of hci_powered_update_adv_sync()
> re-arming a stored instance.
>
> Bounding the copy in eir.c would leave the instance registered and
> unusable, to be retried on every bring-up. Unregister it instead, once
> the features have been re-read and before anything is scheduled, and
> report it with MGMT_EV_ADVERTISING_REMOVED. Userspace can add the
> instance again at a size this controller will accept. Dropping the
> instances before the list_empty() test below also lets the default
> instance be set up.
>
> The removal is under hci_dev_lock() because
> hci_schedule_adv_instance_sync() sends commands, which cannot be done
> with the lock held.
>
> Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH=
")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
> Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
> Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
> ---
>  net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 9213e3ef9f26..ee8b1cd9dee5 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3608,6 +3608,34 @@ static int hci_powered_update_adv_sync(struct hci_=
dev *hdev)
>         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
>                 return 0;
>
> +       /* An instance's data was accepted against max_adv_len() as it wa=
s
> +        * when the instance was added, and that is a branch on a control=
ler
> +        * feature which has just been re-read. Anything too large for th=
e
> +        * current capability can no longer be rendered: drop it and tell
> +        * userspace, so it can add the instance again at a size this
> +        * controller will take.
> +        *
> +        * This is safe as long as there is no command send while the loc=
k is
> +        * held.
> +        */
> +       hci_dev_lock(hdev);
> +
> +       list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
> +               u8 instance =3D adv->instance;
> +
> +               if (adv->adv_data_len <=3D max_adv_len(hdev) &&
> +                   adv->scan_rsp_len <=3D max_adv_len(hdev))
> +                       continue;
> +
> +               bt_dev_warn(hdev, "instance %u too large for this control=
ler",
> +                           instance);
> +
> +               if (!hci_remove_adv_instance(hdev, instance))
> +                       mgmt_advertising_removed(NULL, hdev, instance);
> +       }
> +
> +       hci_dev_unlock(hdev);
> +
>         /* If RPA Resolution has not been enable yet it means the
>          * resolving list is empty and we should attempt to program the
>          * local IRK in order to support using own_addr_type
> --
> 2.34.1

Sashiko flagged a few problems:

https://sashiko.dev/#/patchset/20261110175334.676816-1-piyus%40iiitd.ac.in

--=20
Luiz Augusto von Dentz
