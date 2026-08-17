Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28944AB90
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983116; cv=pass; b=CD1hQF43gq4YWcogKJCdbR/7YiHF3G2nYKwmbGhZB+8KEKeMVWHUlq5uw57b8hmjVSWGo2LqLojHGAQSzdDmMWEurQw+czgiLF7Bxjw3YequTfAR6LosZUUjjY5M/AP5X3Vcn1IkMexf49JFzdsbFMJCZ3+hH1EiHebgo0bFLIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983116; c=relaxed/simple;
	bh=TxKeIXRF86ivBxRjmnwES3EEmCq5bYW1Q/mhaUnlTv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6T1a1N8n3KLhAKZKYFTspEj4NSk17UMnKvbG6j9uSzHybjXatc1tHSBk7XCigV/WO3raA3BqXkX7iBAGKor/hVpDZIe/hhRzWyJpF64kB8lzHXcj+Upa9hGou6hjTEI1FAfDWckwfEB3FY8df638wOBVaXOamJsbbtezN4Ax1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/BhHyhD; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/BhHyhD"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836ce5d6e85so51714577b3.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786983111; cv=none;
        d=google.com; s=arc-20260327;
        b=eTN6zlS0K48AjGLPeUBc6qv3QrYU0tf1l4GE8/35Ik2kTUZ4DygzQkvXFX9PUfguPU
         AbE5odqZVpwy3HnO7Yo4o78WEEzN4eYZubkxkkK+oX+SKLXODBpEJKodKa6R42s6eA5Y
         eYP1bEKMVcl+t3Iho7+20A4uXM/Yfw7hXuklxebOJmR54LtE4Ab89NHw+0MQfSkApwNH
         QF68VNNNCA+AbjqdPVTolpUfBPOne2u0P/HKsQ2qS7O/cPQxwbpMkDZ+C9b8mBWwlZPG
         55stP76eonYXC1jeKdzPGaSIKuhi9SYy2lJyHbU3q/dvW6YWaivibvMzKeCh9dfbjfU4
         5Vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jwyew6uejrvJvvSHLgbOIpVbgqj4gDfuSfCP1FEP7bw=;
        fh=YzgU1/ZNd8kljdPtjvrBeYlvV08JlNW7rHxIq++Bd9g=;
        b=rHyfPwrwdS3fSsjNAMdc3lT+v2app3KUWWKCPoXH3MqJSw6iIgKio7to/d/Sm7ov0Y
         p9aZsNokoTa3HCQW3P5lnbBTxdhflkIPSJ8vvLQpvsjBSJj0VjpwM8lOI4m4UbJNCJD4
         CgH7GHNaZB7CaDhnjshwINBhvKpoVs2fBauH/IJ5BWKlvTW6u+POxQ2kOj99L4s2kip7
         r87V1pAvRNNKIUJzYaNUdamtOYEjAHM5y/FWm3sMTu7Xy5PiXsT1SkX5SIviv0895Ma7
         GAVazCiu2Tf+FwkobCeuE5/1rwCr/D5huIb0nx4delNXPBhet8Vvx9UXsl295xw+mxsR
         R52Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786983111; x=1787587911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jwyew6uejrvJvvSHLgbOIpVbgqj4gDfuSfCP1FEP7bw=;
        b=G/BhHyhDp1vGQKuDF0mu+K8w+u84AR3Ec7vBYiKP4Vz1lQijgDZ5+dvqPiZ5gI4bZe
         eUig4MXdWeqMhFFAxWJx9Avn017Qlhgn9DTxMWFWNRp92t+2DZD50TXdOHINCcpyyx65
         sJQUVqKWmH/bqjP7aVYjSfHSsu0Dq5ehDRSnbdUIawRYUTmn1y5zoWDRj3NWSi+t2HYn
         2DsxlEUIcGmhADGEsW01BCGAuB1K+jxDwogP1+DCjdS4tRFYOB6zxYqql3F8uWwrpZAq
         7bADdL7zURcB9joOcxpXW7bMcqFn+2jcJSp64CkX3FVqY9Mgy+/p7JZq1lyRBNDI/K/O
         TCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983111; x=1787587911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jwyew6uejrvJvvSHLgbOIpVbgqj4gDfuSfCP1FEP7bw=;
        b=mpd+xOI4zk4aWaRkbw1HiP6g74iC6ADpAKFhBptdm+v8prShLUzExa9SJeXu+P00jd
         KUcmW2J0c27KkXW+/ku4uhc63+YwntM8xbJ+ZCTXx4swh2Mb2DdjJi8MxAF3fCznlFAr
         pIvjDEN/uD7++XYsGI8efpmfgGrW9eJAOWzo1UKYtVXitEzvSf55zd4VWQMJ4/6Hx96D
         kwZZNkC4zIn/BXXp0KFVEALeEgnuH5AjydIXQO48G/MbKHc3pYTvJt4GbwU87WKc5apG
         vmhmDgYue3rN6cD2BLtgXHJjFJRRU+ewWik2H1hAzN4p+PyophKV45In4VaCLPd9N1wH
         MLRA==
X-Forwarded-Encrypted: i=1; AHgh+Rov2R4ZoBKxvf8ALZMHdawQiWdFid6uo3pW29UwFdLC4L8jvSs37HXwBX5/OlyyZD8LuelUBNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMIXY4V+7mzgGU5bUeSSOvH+DBZmnpim3fuzTf6+LFtRiT8Ve
	LzOIAHUVZGkGuAs+kzdXKRr3x1kzN6LYg1K7527EKBkecx5Ya7GIsytfFa2kmFESveWxXtfRy4D
	P1C82VCTfKZnCih/oyw9oaqzUzEQiAL4=
X-Gm-Gg: AR+sD13Vw6WvEjLT7EOxNc3Nojjbcel/3MoLT2Expx8KT5FbiG4Jw/JnJFxQOFHChmP
	2PRoEYP43faEcU3Du+QG51ieKJ0apko2JZi5W69Q1DD91fsCpNJKhyy3eWiqGtDl6IFw8czgdSc
	tbG+RNwpzxzssk+5QEHGq52+/pPr9X3yLlJcdmNVzaUo8YKr0N46UKY/UjOv8wNQ5GgtoImFAne
	R2G0vF1iC/JXyDN7mXodN36+h/lz4SYKZBeI/dmxngsea56ylH9wnpQ66s4YKcRb2uPSx9B0eXo
	c0UENapMPcKWqPjaJF70Oka8n58vzqVThRrFyCnRRYNhFJ1tK06aGffbQ/dfDJ892BY+R/XFuaR
	bYrgGYb9ljzCvlsDMoTOB5XPJal8fYp6VQeT4nqQ=
X-Received: by 2002:a05:690c:350c:b0:81f:3969:4abb with SMTP id
 00721157ae682-837120f5e45mr99343807b3.29.1786983111180; Mon, 17 Aug 2026
 09:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817150240.520181-1-valentin.kindschi@fiveco.ch> <20260817150240.520181-3-valentin.kindschi@fiveco.ch>
In-Reply-To: <20260817150240.520181-3-valentin.kindschi@fiveco.ch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 12:11:39 -0400
X-Gm-Features: AcwNN1UQ7PbI7dH28blaACAAUUeWuGN0Dkp1mCbuI2K_MqDLHz1Nx88r6KNdpmg
Message-ID: <CABBYNZJ55q+jpSRrp7PS31hR6xbDEPNExQCADKGWFKtKKweMjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_event: keep HCI_LE_ADV set if the
 host cancelled
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Aug 17, 2026 at 11:03=E2=80=AFAM Valentin Kindschi
<valentin.kindschi@fiveco.ch> wrote:
>
> le_conn_complete_evt() clears HCI_LE_ADV before looking at the event
> status, on the premise stated in its comment that all controllers stop
> advertising when a connection is created.
>
> That premise fails for Unknown Connection Identifier (0x02), which is
> what an HCI_LE_Connection_Complete carries after the host issued
> LE Create Connection Cancel: no connection was created and the
> controller never stopped advertising. Clearing the flag there makes the
> host believe advertising is off while the controller has it on.
>
> Other non-zero statuses must keep clearing it. Advertising Timeout
> (0x3c) in particular means the controller gave up advertising on its
> own, so the flag has to go; leaving it set would make the
> "already advertising" shortcut in hci_schedule_adv_instance_sync() skip
> the HCI commands and silently stop advertising altogether.
>
> With legacy advertising the disagreement is self-sustaining. On the next
> software rotation tick hci_enable_advertising_sync() runs:
>
>   - hci_disable_advertising_sync() returns early without sending
>     anything, because HCI_LE_ADV is clear;
>   - LE Set Advertising Parameters is then sent while the controller is
>     still advertising, and is correctly rejected with Command Disallowed
>     (0x0c);
>   - the function returns before LE Set Advertising Enable, so nothing
>     re-sets HCI_LE_ADV.
>
> hci_schedule_adv_instance_sync() re-arms adv_instance_expire every
> HCI_DEFAULT_ADV_DURATION (2 s) and its "already advertising" shortcut
> tests HCI_LE_ADV, which can no longer become true, so the command is
> retried every 2 s indefinitely:
>
>   Bluetooth: hci0: Opcode 0x2006 failed: -16
>
> Captured on a BCM43455 (no LE Extended Advertising) after a central
> connection attempt timed out and was cancelled:
>
>   LE Set Advertising Parameters (0x2006)   Success
>   LE Set Advertising Enable     (0x200a)   Success        HCI_LE_ADV set
>   LE Create Connection Cancel   (0x200e)   Success
>   LE Connection Complete                   Unknown Conn Id  <- flag clear=
ed
>   LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.033 s]
>   LE Set Advertising Parameters (0x2006)   Command Disallowed  [+2.016 s]
>   ...
>
> Keep the flag only for the host-cancelled case.
>
> Fixes: fbd96c151cdc ("Bluetooth: Fix clearing HCI_LE_ADV for LE connectio=
ns")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 btmon
> Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
> ---
> Changes in v2:
> - Rebased onto bluetooth-next; no functional change.
>   v1's hci_event.c context lacked the hci_store_wake_reason() call
>   present in mainline, so the hunk did not apply.
>
>  net/bluetooth/hci_event.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5720,10 +5720,12 @@ static void le_conn_complete_evt(struct hci_dev *=
hdev, u8 status,
>         hci_dev_lock(hdev);
>         hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
>
> -       /* All controllers implicitly stop advertising in the event of a
> -        * connection, so ensure that the state bit is cleared.
> +       /* Advertising stops when a connection is created, and when the
> +        * controller gives up advertising on its own. It keeps advertisi=
ng
> +        * when the host cancelled an outgoing connection.
>          */
> -       hci_dev_clear_flag(hdev, HCI_LE_ADV);
> +       if (status !=3D HCI_ERROR_UNKNOWN_CONN_ID)
> +               hci_dev_clear_flag(hdev, HCI_LE_ADV);

Hmm, I wonder if this is not valid for all status !=3D 0 though, for
example if the connection timeout we probably shouldn't clear it
either.

>         /* Check for existing connection:
>          *
> --
> 2.34.1



--=20
Luiz Augusto von Dentz
