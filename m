Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478838424C
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857364; cv=pass; b=gLey+nXfJ0g7OG+yphc2bx4+Z7nuhmH/lOSaKbg4XRWmcrYl1aY4GWVkHHA7g9gYfRPNfkTYM3XFmSntRRAPa4VHaNCRhzYLwh2d2tTKfIMNH8v/LtZk69rUr+iFmARBgssWRrTWYCatns/HsBFOjdlcutl1QlLOfaik+S3sL6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857364; c=relaxed/simple;
	bh=XcSMD/HdUmVFxslTIb2qIZgsej+xGutNgV8WULXEE3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7mwjtybV3fPkamfExCwbq/bjCBk3tu6+4VbPR39gu1usoN7FX2gGc4i5m9razn/XDpGjbmtIABXet1xixAcRRD6zPHIpoSqdlY4dLxeoAXsSKxVJQWBa9G9Z55bIHb9hHUNos/A+PE5kwzNE1zU6tWzlf8PwMkHsXd/ghE2oX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBSvJDLW; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBSvJDLW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso208675a12.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 12:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787857362; cv=none;
        d=google.com; s=arc-20260327;
        b=aTCOnMiBynDEKhtGfuaax4JY6kgq0Pwy4i542FXGy6rKemg/7fShOchtPjHoBQsl+S
         L7jCWRW+1OK8Os5sNHnwXDuW1FvL3oijyv7pesTFRlM0rUe0psDzIkzogFBcOANygFh/
         zIVoAUFJnq5yk/rKX3OCsNYWWd2D55KYoX+0rjZ93+yhw10nS+VI30urvE7MLCL0MkKz
         pFmV/0PTuAUs8bR9wV65pJj68xJAj+G9oLrAO8mm+juObb60Ly73Pbyf9JELm8WCFlp4
         z9H1zG1vgu8aeW0T24nDTEXeEizInUfBKY6zZEEbYXB2kJDheod3fe5UATbX7W/5yRi3
         yt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QRLwXZ3w9PabTGTAitLmepFzO9LpmDAYaCwAO/RJEyQ=;
        fh=65fr/A16fOYJw04tgQ6gOZZnioRzmHlivDzjsRIEYHU=;
        b=qtbNS4FCriiTAIIViWykpEZeyWa7S2CDJL+vrnS0t9dtibqBHSNrsb3hoeAehTuhC/
         TskiRsw8czeVvW4Jc0TSjj69dSkLV/aQMmL1w+xXt9RfTt2YqY7ebjA2pomrNqowdL77
         21ttFsPISIEK0gISndj/LxXVEc7VjYXUUcmHrxa2+lPMM1zFiwRUSiCFf7zj6rKn6O/F
         oxTBWDMWWDrd2frz77b+vB5Tbo7kp7rv7vvyaOu/VdsI/4v51ssgpzMuDCtXsAQ7QAkn
         Ia7NaV1w4HEFIdjlv010slgGD88K069Yo5yxge4rShg1SY3NkkeS3t2f7wnulm2pwDRp
         aQ7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787857362; x=1788462162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRLwXZ3w9PabTGTAitLmepFzO9LpmDAYaCwAO/RJEyQ=;
        b=IBSvJDLWV6/blxTQVqe8lHoJ0ox3gq88qsFyqvYo+VHUU9Av+gAH5dK8bk3eg+I58y
         eKGJiJwHOFBSoydwOCtkm3HcvTopq8pu2Vk1Y65HPjE7RD5xYZMSiMpaa3lU8/eF9/Mx
         nVQfZRwMJylOjZxd9b73usTGo58cW4sEtqz8+wuu8NS+uYJnbCKJkGexRYBaWJypHqk/
         3SbG+W6fWmFtM1yZX3tP5XOwDcWeq3MXIXGf8ZYWnOTkWAvI9x2mpkGNAkEAZ0xoY18v
         RWQPXnYPc3CHN3AcLkz1uwvOx0BxrIrIgkAk60eQ4Ninr9v2q/KV+bvuAH8uQuM5+bpl
         MYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857362; x=1788462162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRLwXZ3w9PabTGTAitLmepFzO9LpmDAYaCwAO/RJEyQ=;
        b=CMlUN/k79NPVhlzoi9ospIbXW0+euyXoWWfjg5CLPdkrLDQ01Zk1TpjGEm7UQRLIkT
         TZcnWoaX21lKhCkmwkfCDGTWvlOpBcJWeph6+aTPeRhwvvGCVQPhuKDos6bOb6TLTeR7
         OcZ/niq39spGnXgrqfwefa2hX5iB6TDO0a+8WY8CMYs7j+x4C444gxe56eximkcKlKOy
         Nmy7zWmkmiQiLnE/PdHU7jqQrijBnClr365hS/ygeuXf7voxDbWTowYnyZCEWKQ6O4YJ
         LN1Rx8H8+Pt831rgBXgDNgqKbx47zqQFPXeThWEjIgA8zOX46Hvlx2aY5hm39qPBmgCT
         RD9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqoT+LthbWlwdQ548M7BJw2nUCyeR2tspwe/CQPPAhN3tEesSFOKAhyIbqJPD+WgkC/tTNNCK8=@vger.kernel.org
X-Gm-Message-State: AFuF++k+RB8XzJDeiUY0NryILe0/xjPgloz7NrD/DZdtxC+fO/NRD581
	M8b9SrsLW8Yp5NPmFMFSM3BHBkd2wghWRPYxwOdMQuSmpJdCR8fGOYyRPH0RdiijQGMB1kHmae8
	LrTxfcNJkEAwZNtmyTL/XgFhYYGc1V1o=
X-Gm-Gg: AR+sD13wK+/AKn+RKMUKsseNjI2W/PiOqp/fxoAA/0UJ8nZoRQ7wqopUZJZUhNvFDjr
	t0kkN5zgb7eiGfvDxtexR2ORgnJJFNvW7+lQtiL5uSxAxR7v/ImjHW2FmlpneSwv2vrhgDZ55q2
	0JffOYZJRV5iGy2tPo9W4FFOpZdonv8anz8DYQptptIbGZZ9PqQCKpe9T43Bh+4pIxUtM6uh8Da
	sWakcSfKGP2KHT43RBPMIZKpu3i5pDPcKCkx142XZ6jA/N2Rfzn2efc3tLQ1ZpLm8JJ2DwSMDcE
	gsZzNhqqUQ+Xx6dA3X+E4Kt/6U1uej6Z5q6zUAXYvJOU
X-Received: by 2002:a05:6a20:1582:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3d2681a9fcemr1636542637.14.1787857362012; Thu, 27 Aug 2026
 12:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825103104.12090-1-98lawweijie@gmail.com>
In-Reply-To: <20260825103104.12090-1-98lawweijie@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Thu, 27 Aug 2026 12:02:29 -0700
X-Gm-Features: AcwNN1VAoUt61SD1pdzAJX6jw8Qf_02tqkLxle51MEfUycbPSDDWE60nEBNZIiw
Message-ID: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:31=E2=80=AFAM Wei Jie Law <98lawweijie@gmail.com>=
 wrote:
>
> wacom_wac_pen_serial_enforce() iterates over a field's usages (up to
> field->maxusage) but indexes the report bits by j * report_size:
>
>         for (i =3D 0; i < report->maxfield; i++) {
>                 for (j =3D 0; j < report->field[i]->maxusage; j++) {
>                         ...
>                         value =3D hid_field_extract(hdev, raw_data + 1,
>                                                   offset + j * size, size=
);
>
> In hid_add_field() the usage array is sized max(usage_index,
> report_count), so field->maxusage can be far larger than report_count
> when a descriptor lists more usages than its Report Count.  A field

The wording above confused me greatly until I realized that the
problem is **not** with the field->usage array. That particular array
is allocated with the size described, which is exactly equal to
field->maxusage. **Instead**, the problem is that a buggy report
descriptor can declare many more usages (and thus a greater value of
field->maxusage) than the Report Count actually provides space in the
report for. In such an instance, we would obviously overstep
arbitrarily far past the end of the item.

I would appreciate an update to this patch with less confusing wording.

> declaring Usage Minimum 0 / Usage Maximum 0x2ffe with Report Count 1
> gives maxusage =3D=3D 12288 while the field's bit region is only 8 bits
> wide.  The extract at j =3D=3D 12287 then reads bit offset 12287 * 8, i.e=
.
> byte 12287 of raw_data + 1, roughly 12 KB past a 2-byte received
> report.  __extract() performs no bounds check.
>
> The value read that way is stored into wacom_wac->serial[0] and can be
> emitted to userspace as an MSC_SERIAL event by wacom_wac_pen_report(),
> so this is an information disclosure and not just an out-of-bounds
> read.  A malicious device only has to claim vendor id 0x056a for
> hid_scan_report() to place it in HID_GROUP_WACOM and have this driver
> bound to it, and a single crafted input report is enough to trigger the
> read.
>
> Clamp the inner loop to the field's actual report region with
> min(maxusage, report_count), so usages that have no report data behind
> them are no longer extracted.
>

I don't believe there is any situation where maxusage could be less
than report_count since it is initialized as max(usage_index,
report_count). We would also *want* to read fields beyond the
last-declared usage, since such fields are actually supported by HID
(see both the comment in the usages loop of hid_add_field() as well as
the first remark under section 6.2.2.8 "Local Items" of version 1.11
of the HID spec --- such fields just reuse the last-declared usage).

Given the above, I propose simply making the loop condition " j <
field->report_count". Thoughts?

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> Verified on v6.12.104, whose wacom_sys.c is identical to mainline here,
> with a UHID reproducer and with an emulated USB device (raw-gadget): a
> hardware watchpoint on wacom_wac->serial[0] fires with an out-of-bounds
> heap byte while a 2-byte report is being processed, and no longer fires
> once the loop is clamped.
>
> Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial d=
ata for later processing")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Assisted-by: GLM:glm-5.3
> Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
> ---
> Changes in v2:
>  - No code change: the diff is identical to v1.  Adds the Assisted-by
>    tags required by Documentation/process/coding-assistants.rst.
>
> The reproducer is available on request.
>
> Compile-tested on bd5f485f3f02, x86_64 defconfig + CONFIG_HID_WACOM=3Dy.
>
> v1: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweij=
ie@gmail.com/
>
>  drivers/hid/wacom_sys.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f7..1ea8763b68a8 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -113,8 +113,10 @@ static int wacom_wac_pen_serial_enforce(struct hid_d=
evice *hdev,
>
>         /* Queue events which have invalid tool type or serial number */
>         for (i =3D 0; i < report->maxfield; i++) {
> -               for (j =3D 0; j < report->field[i]->maxusage; j++) {
> -                       struct hid_field *field =3D report->field[i];
> +               struct hid_field *field =3D report->field[i];
> +               unsigned int count =3D min(field->maxusage, field->report=
_count);
> +
> +               for (j =3D 0; j < count; j++) {
>                         struct hid_usage *usage =3D &field->usage[j];
>                         unsigned int equivalent_usage =3D wacom_equivalen=
t_usage(usage->hid);
>                         unsigned int offset;
> --
> 2.43.0
>
>
