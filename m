Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794488250;
	b=tPUmyO3MdEhzE5d1KBptMu+X/JvG/iLctO4pJYCzrmT70W3T8nQnetWPGDNU0vlIYTHH
	 MKz6p/Pqn94BhpWY+odQ+CvXAq4lSUYbMOO1WP4iW9jyEba1ygcM6Th6QZysklPSdasxi
	 xqibIBYgAtaI1OkspB2KBAjtiJtVI7C4kz2Ww7iMl51kR7wrkj6eX0FfPUmxJMvsEy/Rf
	 sEkNhj73ikD+73HjINXisVNCp9ZTWLjsUatVgI0rZOmvFosxi79n+Eww3KhhIKYaLLmLO
	 FHCJyHI7FSX7RNad11Sff+q7WJQoZB16YfX8vmfeFzrTOHPSBIzDFlkA25x6pLxnRwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
	b=08MqkzzMOW2ORmyteCc/mktDuXWgvE9KhS5o2R/BB5eGgMO7VQ835plGuVL+Qez7q+lG
	 Owrr3wRB/CcIiRfrPj68RrBh99AWPuOY7RKXN46kMulaubAWovfQ40Rbl0xLh22y7HL0s
	 7pIg00d1tmAWa0lXQb4G5iUJDnt7B0TpR0nqEKooKUJGKYWmQtC5DnuUoCPLRpB/e7cjq
	 vz2LvtIETyduixfBS1a0NM2MEQvWlduWQdLUpvJydEVfXRlVjbZ15jRzGce8Fu4x0wllk
	 Z7eKsJb7xeC8SjasouUezU5QtULDmyQy3+lV2OnGRL9DTWrruAQq6R0dG/5BSvRXl5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Ck8de3oy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96635606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96635606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Ck8de3oy
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso5052552a12.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794488248; cv=none;
        d=google.com; s=arc-20260327;
        b=HY7KRYzx06w8apqufT7pfN75ETHSBZ3CJxtzvZhrFbaIKhqPVo+UaH1KQCouQsiwvs
         22P16h6avrPZUbvJ/mwKgOVTeAhCDDOWZhx0yieQC6fRpuKZNCKW7gr0uOBXJPK1zPNS
         PGwEhiyc+wNJ6GFvrZ9Z5bnqx6WtGhi63g+oQ/CquhTttPNuc1viSoYVPacFNlReIJwi
         l0VaFpclk2uRFl79yKYUCRqfLNFW4t+MLLNwMTBYuKVFfRQFRtcj4Fxgc2flISLESJ/X
         tjF+p+eMya9E6xA5/Xv2HdraHmyOJSHPTnxc64FXlNclLuNyz2p0mBrmvEccT2tYc6WM
         F1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
        fh=J3F85fCWB9V72dNBdBfjRIMqp1778f6M47Mcss/62lA=;
        b=MBR4MO1twpPiB+2sXlbaIOKlSz+504zKbyoOtS7gLI9lJNCny2Udy2UdTRbJBYUppV
         iwDwCYXQAn2/t7GsO16r+VnHDDBbdj22+q7vk4L9HG5Sl0O9/3sJZPbOt7j/KJTmJXGh
         Tq8CHAkWHUeSmChV3RS5mbgRcVoKiU4SpdH6JDrmTFUSNHaLs3fwNrRmDzFfBiiB8XKD
         g0ilq6C7HlSrSa0o6ejN9vMvl6ci/KcqtZ3e6Ax/RilpZl3Sx/RjTJ24G4HfsAlHMJ1k
         L9M7zi8pkccMWw3eRqsA/y21YEEiwbMHiqDvD2ctP4OlUbnPDju5Pk6i+n9skagXiK0Z
         Yi6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794488248; x=1795093048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
        b=Ck8de3oyVOuBXjWWNERiRX6kifNx8Y6MwGVEyjQs4mgvSRlaUnGfKsMDQ7pOTpUSxF
         LLMS9doO2ZHoyUP0Qx9wiKw4888CBVO6ETO8Wk8/v9kucYwkNb5A1MZa7q4Apcf5fFIz
         M3MM7Y3BrI2lk3WEZG2+KrbFX8qXRLUMcKjr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488248; x=1795093048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
        b=RxfiHe45Ocj4LlOclF/tCvFBvImhieHuApgcAtGLB98nt8TqPnGbNXUprrhIyanzop
         EzIePnrBV23Okinr4ZIbFYLbKZTJxtzpDY6UbDzvbN6xTMj//IpFvTCQaEuBocttQCmg
         x0pZbcHexVJi1Ndp9tuPtmd2Zxl3Cv3ME9YaHwsYnopMcU5VVtGzrh4+yoW/opVxSbIK
         DphZdFhM9FpZBaOuslsWR0eXVAOYaP7L8HPY9Te8OF9bO9aASePE4zuiZx57ezl24mcA
         Qh0I/oeeAL/sfTHnT8yeaXGrMPDkTm2dOefZ1ktpoS4661P+mySJFqmQCv9Tyu5WAN/w
         6qKQ==
X-Forwarded-Encrypted: i=1; AL+hErFCLRLHohkA5FwnMC2/yv/qw79sehP3aefyNoyos4mnbaLtOufeEG79viqyF5IrUUlQZpyvYN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d15Xh0XGG/LcBA20qMu84Hk9Wck376pxp3Y+jcwqT5fCv8MuU
	xt14Sd2Oc6EW8x+E2FTPpGN2MYjdWyQnMoLc8xMqqyPOgLv563lekaI2vvJxzuO8HWFkuHlJnE2
	MaOso0nTEbcbc3iatJKA5dRgVNK5/6HD7mG2yUR6ByA==
X-Gm-Gg: AYBFou3/VxgpGh93gzgYD53urCUwkSHZCX5DqUYWAPMqD+ctt8oH9ReKZDO/2X01jDQ
	sw60bfEW+cz3V0y100jWuvW/qJglK+QM8/H+pPsClI/cUCP+3D7iuPn9/ZbGYdRaHN/rY/ZWCDb
	Q50MeDzl1XxbdnzFNFv6Uz6IFfkwQdFzNrS34Y0tSWXqyppK81LejKbdWNsEjEVd5LuDOArHx+1
	fK91dP6XuULYjM7kq5eM6qmCTEXTZAHr0HfUfn2SPf5FQM3z/ychvLtxCTvO84dknaMNBm3goOI
	ybW2uv8cmdMJHJfKduG9TjJCmkBmTGVoJpk2BWvXqqMVT2fsO55EP9i1qs7saCG/q71AHhOHade
	ZVkGivcXxIHek7e6pkxt8fz3UaoENIz8Vnc3PNE+Yg1F56/pfHp3b85q/WLNQd+VEVvnwKO0qdz
	RRji3xu29c/XD8QI27k6+yveK9UHuSHNqEiadLtI0iOuIM79XvLwt2BP4=
X-Received: by 2002:a05:6402:4407:b0:6b7:b0bc:f4af with SMTP id
 4fb4d7f45d1cf-6b7b0bcf5c5mr873269a12.7.1794488247914; Thu, 12 Nov 2026
 04:57:27 -0800 (PST)
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
 <CABBYNZL9GjdZvU6Z8B2v5_5iGXBno5K-GvqkKfX5vjEaTkV9vw@mail.gmail.com>
In-Reply-To: <CABBYNZL9GjdZvU6Z8B2v5_5iGXBno5K-GvqkKfX5vjEaTkV9vw@mail.gmail.com>
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Thu, 12 Nov 2026 18:27:16 +0530
X-Gm-Features: AclHuK8hls-AW8yfs8-PRYUOyj383dNj68tz1FvuidA2KViMtTYZ32vFMU0YiIw
Message-ID: <CADq=QSxbEXxgbZry=d0F5ACxNUST_u2fChEc8XgZ3YR-zyOmaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_sync: drop adv instances the
 controller cannot carry
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

We just submitted another version that addressed the issues raised by Sashi=
ko.

https://lore.kernel.org/linux-bluetooth/20261112125420.3905719-1-piyus@iiit=
d.ac.in/T/#u

Best,
Piyus

On Thu, Nov 12, 2026 at 1:19=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Piyus,
>
> On Tue, Nov 10, 2026 at 12:54=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> =
wrote:
> >
> > An advertising instance stores up to HCI_MAX_EXT_AD_LENGTH (251) bytes
> > in adv_info. How much of that is accepted when the instance is added is
> > decided by max_adv_len(), which depends on a feature bit in the
> > controller's LE Extended Advertising support:
> >
> >   ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH
> >
> > ext_adv_capable() reads hdev->le_features[1], which is re-read from the
> > controller on every bring-up, while the instance list is only freed in
> > hci_release_dev(). Instances therefore outlive a power cycle, and an
> > instance added while the controller reported LE Extended Advertising
> > can be far larger than the capability now allows.
> >
> > hci_update_adv_data_sync() picks the writing path by that same bit.
> > Without it the legacy path runs, and hci_set_adv_data_sync() writes
> > into struct hci_cp_le_set_adv_data, whose data[] is HCI_MAX_AD_LENGTH
> > (31) bytes on the stack, while eir_create_adv_data() copies
> > adv->adv_data_len bytes into it. A controller that reports the feature
> > on one bring-up and not on the next overflows that buffer. This can
> > happen when, for example, a USB dongle answers LE Read Local Features
> > differently after a reset. scan_rsp_len has the same problem against
> > hci_cp_le_set_scan_rsp_data.
> >
> >   BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
> >   Write of size 220 at addr ffffc90006b679c1 by task syz-executor
> >
> >   BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
> >   Write of size 220 at addr ffffc90006ca79c1 by task syz-executor
> >
> > Both are reached from HCIDEVUP by way of hci_powered_update_adv_sync()
> > re-arming a stored instance.
> >
> > Bounding the copy in eir.c would leave the instance registered and
> > unusable, to be retried on every bring-up. Unregister it instead, once
> > the features have been re-read and before anything is scheduled, and
> > report it with MGMT_EV_ADVERTISING_REMOVED. Userspace can add the
> > instance again at a size this controller will accept. Dropping the
> > instances before the list_empty() test below also lets the default
> > instance be set up.
> >
> > The removal is under hci_dev_lock() because
> > hci_schedule_adv_instance_sync() sends commands, which cannot be done
> > with the lock held.
> >
> > Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENG=
TH")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
> > Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
> > Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
> > ---
> >  net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 9213e3ef9f26..ee8b1cd9dee5 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3608,6 +3608,34 @@ static int hci_powered_update_adv_sync(struct hc=
i_dev *hdev)
> >         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> >                 return 0;
> >
> > +       /* An instance's data was accepted against max_adv_len() as it =
was
> > +        * when the instance was added, and that is a branch on a contr=
oller
> > +        * feature which has just been re-read. Anything too large for =
the
> > +        * current capability can no longer be rendered: drop it and te=
ll
> > +        * userspace, so it can add the instance again at a size this
> > +        * controller will take.
> > +        *
> > +        * This is safe as long as there is no command send while the l=
ock is
> > +        * held.
> > +        */
> > +       hci_dev_lock(hdev);
> > +
> > +       list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) =
{
> > +               u8 instance =3D adv->instance;
> > +
> > +               if (adv->adv_data_len <=3D max_adv_len(hdev) &&
> > +                   adv->scan_rsp_len <=3D max_adv_len(hdev))
> > +                       continue;
> > +
> > +               bt_dev_warn(hdev, "instance %u too large for this contr=
oller",
> > +                           instance);
> > +
> > +               if (!hci_remove_adv_instance(hdev, instance))
> > +                       mgmt_advertising_removed(NULL, hdev, instance);
> > +       }
> > +
> > +       hci_dev_unlock(hdev);
> > +
> >         /* If RPA Resolution has not been enable yet it means the
> >          * resolving list is empty and we should attempt to program the
> >          * local IRK in order to support using own_addr_type
> > --
> > 2.34.1
>
> Sashiko flagged a few problems:
>
> https://sashiko.dev/#/patchset/20261110175334.676816-1-piyus%40iiitd.ac.i=
n
>
> --
> Luiz Augusto von Dentz
