Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363038BF9C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577314; cv=pass; b=K6Qr1erJZ+HUSpRvO7jEMahB+5JPrpn7jI15jRg/G2BAGrJAC5WZdwotnI5HC/bX+F9SHz4KXKrOWIOZjTsaaScFZQNJUY3gUTN/3rKJNanitHAE8BOhchK4oktHw2JQSP7+/1cAZvzGxCSA9TKvEn8EgEHCKi65J2MXcIQfNPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577314; c=relaxed/simple;
	bh=U6naqr8/fm2E7FQtlwL+QylvLk20pczaI7HxTKdFd5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHh2wTPoqkmHmbX+DWXlE34VclbB9vu7MxYnv+nWKtQywMR6/Oe7OxpISuBZyOrZcULHqxbL/6Efg+yRAJFVnBxl5SPV/8XxFmRuU7w4sNBjtlN5fUhfriYJlgNCjpjz02Duj2RJInziX6ooZgnMllw/sjYv4R9yH7TjaZ6k0iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWiRO74l; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWiRO74l"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81eff3ddba4so30664547b3.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784577310; cv=none;
        d=google.com; s=arc-20260327;
        b=NbSmX2kuPIec47srJy1bhltcwlWrgET7N+nGxiWVWutO+PyDfzSax5eJw6a4xHAf1n
         mZARELw5Fg+QloxRpV8ll9XjgT5QjYgFUSZXbG809EMz5GvDyVCoDFXYxUo1jMwHMKhm
         Xdkb5E11KZ/HoIfA+YQCBuOxfESb0uCrAmjjmR7jjtCAIubaSx7UtUnnyDuWw1m4r7Lg
         jfvqRabcqVeCrePKdYG6kcTHgvL7RiZmfr9Us/isani18gjyM06y/Rcfhe2XYdRsIPtL
         mZt/Slbz7/fx8kMTI8IO2WFaN7eGGCtLyD8+iNUNE/qhHd6ud2UvUlcpTQLVqfdQ9yol
         HuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/AOtXMyuIHsHhRfVMauZWyjtCTCZoSPj81jh5GgUwec=;
        fh=7QUH51M1LLVfl+UjI5KURHp8BUB5MpBWZhSVYYcwbUQ=;
        b=B/AG/wHFuOpu6l5I5+H01P/1r43TuSjmkH8ab+axGGf3iO732wVvBQppBJ54izMlzx
         lRmybOsuUSTT6V+Z8Qc6M3EhSoErcrlYsSMyMRZsb53/pTiI8j0UIzYxV0b67RfZhyDm
         P1OVmTo1riB3iw/5tPE4tREr13hwXlaKakupRqYwminQmvpecDbjtYhrJj/43UFDUAjb
         ye3Bdb+TRxGvczf54K0SJvxsroDF3s8EhJh84ytvkVmnB0P7os20GwHYJ1CzSZgh4gvP
         4s5TQfXgMeYySq36XPwRtDgnDx32aYKsvYlwaBAGWP8N4gY4Q0J4WjJ0wMM7tWWdPVn7
         yk8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577310; x=1785182110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/AOtXMyuIHsHhRfVMauZWyjtCTCZoSPj81jh5GgUwec=;
        b=FWiRO74lhMxjxDk1LJhjl3w7DuNoRlmfDWqxJjJsyiAW+mnUhf87q+4lvWDg4O3VSc
         aOtePuRrmshG1TQchNxYgQdGCfXDI44KT8/zjQ97KoxRiY/LA2EGFS0nevUhpuykRMe7
         a25Ym9J4NvTzwF0zbg4mkSadvKPGdFb/MVQSZZDBxyoYDaxplhSQ2Ac5qL/s/aRslfAY
         BrM75O5ZFKeRcty/fALGa9DKcpSptQmlQiStgF6t2Mv7jSQY5pqPy6ppqtssyhMGtorA
         5MxkwDwEAHRCuWuLqS7iH802zev0FfHrjUgLOei9IjvyPN2Xp9wOgBFsn78BNBwIoQA1
         kdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577310; x=1785182110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AOtXMyuIHsHhRfVMauZWyjtCTCZoSPj81jh5GgUwec=;
        b=fVoLRAE5xVIcMsZCPPpQqPcCkIhJv75AEMLUWlmI16ecPG1UXohJz21UkYQEZFLiJb
         WKDHFuLCQ+BAJu0AENJeIeTX+6l6fKYKeEK/cyF59FnogavDU4Y/5GtAB52zyxaRpq3p
         EpD3pMxkEMjyDqYs1hAGPviYNVdgU/3u2N8dX4A8zgDF+krTcx/2YFrx30E7x9sUtoZ0
         /Ym73eWY789ZLgHK5YijP8fufuRVw7/IDJscptFlHw01/05a1XZQVfZQmtkkHa79clp1
         Ubfo6MCJribxgLvyvZreDO9YALXtlF0yd4fYlnWOVZtWKtD/YdzwaieHocJztYegSLZX
         Ta3A==
X-Forwarded-Encrypted: i=1; AHgh+RpHFJDgwkcTyKwlmYbF5aqD4ydF8LDVGuOm9DMm2lGHiPrlFII6w2Dg7dM2w1Z6riGYpTgBV4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpVZVgj70wtOqRz95ac9JtgXTCxYARtS5+9I5I0mmV1stuggn
	s4lyku8lUC4qfPHreb+qawT5BoT81gtMDrqZ2H7ot/QtpEr+C5An35b0u0cBkvoDgN4vpeqKlD2
	XYiyrazrb3YKRxZ2wWzAb32ZOnZnu5H0=
X-Gm-Gg: AR+sD10KeLqbAniQ3N3ANeAod/X8v/ovBIuSIxS56Maq0b3D6imyEX+fGkpNNr3o/8M
	RM3nmKLjz3P6BVPLEHB50+qrTo9i9lW7OGC2uNk6wfOKL9UfZdFQQh27ehTmcmsA5pitVWpGPYM
	23x6oFheoj8eymPmcC6g+OlUIzxEGgaFDiR0pfDHLLuYQFSYdGP5aCa4Om9ShMi9omfubD2SRnF
	cI3fXYTyw5vw7fjc76aOgEmpX46T4dcXaHgPyQl/wOuA2lj9M2fjrD4MaxlqWX+Oc358b9De1Ca
	vRgJ/OkU67ON3E5yMmTEwlDp1Ey3jMbW1pUZhByuHErCe1bo
X-Received: by 2002:a05:690c:6702:b0:81e:2e67:bb9b with SMTP id
 00721157ae682-81ef26edccfmr47109007b3.58.1784577310290; Mon, 20 Jul 2026
 12:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:54:58 -0400
X-Gm-Features: AUfX_mwx2tFRY0jR9aCJZGYE-cu6e-hrJK27ReHcPbzYy4X9ldy2V3BG6Q6JokQ
Message-ID: <CABBYNZ+G3jD3A6-k1fEm2sSRa27o8s0PNN_arzVa8de-eJK8oQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix scan response data UAF
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2026 at 12:47=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> eir_create_scan_rsp() calls hci_find_adv_instance(), whose return value i=
s
> valid only while hdev->lock is held.  After advertising setup was moved t=
o
> hci_cmd_sync_work, neither scan response data builder held that lock.
> hci_set_ext_scan_rsp_data_sync() also kept the returned pointer while
> waiting for the controller and wrote scan_rsp_changed through it afterwar=
d.
>
> An advertising termination event can therefore interleave as follows:
>
>   hci_cmd_sync_work                 hci_rx_work
>   hci_find_adv_instance()
>   __hci_cmd_sync_status()
>     wait for controller reply       hci_dev_lock()
>                                     hci_remove_adv_instance()
>                                       kfree(adv)
>   adv->scan_rsp_changed =3D false
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_set_ext_scan_rsp_data_sync+0x2e1=
/0x300
>   Write of size 1 at addr ffff88810a45d21d by task kworker/u17:0/88
>   Workqueue: hci0 hci_cmd_sync_work
>   Call Trace:
>    hci_set_ext_scan_rsp_data_sync+0x2e1/0x300
>    hci_schedule_adv_instance_sync+0x390/0x4c0
>    hci_cmd_sync_work+0x173/0x300
>   Allocated by task 87:
>    hci_add_adv_instance+0x538/0xac0
>    add_advertising+0x885/0x1160
>   Freed by task 89:
>    kfree+0x131/0x3c0
>    hci_remove_adv_instance+0x1d8/0x3b0
>    hci_le_ext_adv_term_evt+0x17b/0x730
>
> Hold hdev->lock while looking up the instance, building the scan
> response, and clearing its dirty bit.  Clear the bit before waiting for
> the controller so no adv_info pointer survives the wait, and restore it
> under the lock if the command fails.  This also preserves an update that
> races with a successful command because that update sets the bit again.
> Protect the legacy scan response builder with the same lock.
>
> Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue=
 set 2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 532534bc601c..8c69a98c71e8 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1490,9 +1490,13 @@ static int hci_set_ext_scan_rsp_data_sync(struct h=
ci_dev *hdev, u8 instance)
>         int err;
>
>         if (instance) {
> +               hci_dev_lock(hdev);
> +
>                 adv =3D hci_find_adv_instance(hdev, instance);
> -               if (!adv || !adv->scan_rsp_changed)
> +               if (!adv || !adv->scan_rsp_changed) {
> +                       hci_dev_unlock(hdev);
>                         return 0;
> +               }
>         }
>
>         len =3D eir_create_scan_rsp(hdev, instance, pdu->data);
> @@ -1502,15 +1506,27 @@ static int hci_set_ext_scan_rsp_data_sync(struct =
hci_dev *hdev, u8 instance)
>         pdu->operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
>         pdu->frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
>
> +       if (adv) {
> +               adv->scan_rsp_changed =3D false;
> +               hci_dev_unlock(hdev);
> +       }
> +
>         err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DA=
TA,
>                                     struct_size(pdu, data, len), pdu,
>                                     HCI_CMD_TIMEOUT);
> -       if (err)
> +       if (err) {
> +               if (instance) {
> +                       hci_dev_lock(hdev);
> +                       adv =3D hci_find_adv_instance(hdev, instance);
> +                       if (adv)
> +                               adv->scan_rsp_changed =3D true;
> +                       hci_dev_unlock(hdev);
> +               }
> +
>                 return err;
> +       }
>
> -       if (adv) {
> -               adv->scan_rsp_changed =3D false;
> -       } else {
> +       if (!instance) {
>                 memcpy(hdev->scan_rsp_data, pdu->data, len);
>                 hdev->scan_rsp_data_len =3D len;
>         }
> @@ -1525,8 +1541,14 @@ static int __hci_set_scan_rsp_data_sync(struct hci=
_dev *hdev, u8 instance)
>
>         memset(&cp, 0, sizeof(cp));
>
> +       if (instance)
> +               hci_dev_lock(hdev);
> +
>         len =3D eir_create_scan_rsp(hdev, instance, cp.data);
>
> +       if (instance)
> +               hci_dev_unlock(hdev);
> +
>         if (hdev->scan_rsp_data_len =3D=3D len &&
>             !memcmp(cp.data, hdev->scan_rsp_data, len))
>                 return 0;
> --
> 2.43.0

It looks like Sashiko found some other places where this could be a problem=
:

https://sashiko.dev/#/patchset/20260720164738.2921802-1-nicoyip.dev%40gmail=
.com

--=20
Luiz Augusto von Dentz
