Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703246;
	b=ioG2Kwm3HY+MKxghjN07oDgWSxsNCa4qPPKx5VoDgoONHSwg9l+jIH0UVoBK/LEI/j33
	 PWKfrFFXrDll53SVYGhi+b0JfRXDXOy1wUpe3VxDUBTSemps/jr+exS+O1RMIHtR0GcKa
	 1nTky28dDs/Jj8WOXfXLhtiqK3PHjbJ2aQzGXw+GgTpdjMuhAr53DipaJeXTKiI4Zhve0
	 tud5ZFKoqpbpob/VXeqdYiUMISBJkBLe/ilpXZKezAn6KLt+g/n3812MQR/VdF3N/tSxI
	 oXgPhlz9jJtf+DB07p+Hahq6rUlNKac7g/xRqyvRo70XlgqSrtmijUssMfWozdIWp9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=r5fpEpzNM6uji7Nri+epW5yidLQBDkGGYauevO2LpP0=;
	b=KXfy/ifKyqf1NZyKyqR4zJZq8gJ7BbMrBycvuixl/Iw45nluE+GqNCPaGdeW641Y5Kdi
	 5vZ00daKUZToG+/CdKnX+ladPHcQ2ZLHoBTT9pnfNJ5Th8aCek4jQsxMEXwlGu2wEiagv
	 G5ilIe+xs8uCCf6sJVA7/ZRJYddTO4bnHqS7o7fybW+2cX9Ru4hR/7x2QrOc/IuNdrdoZ
	 KMlznqVDI/DlkMg3UTUlrw1Q9OzL3gAYIvNWE0U7slH/i1oMxFpzDyXPOfPCGyjkfZdVc
	 XyOyZVdGUMT2fAFuNXE/H1XJYhxKtzn8I2xwgPG2UPfZ0Fsb4m/NniyOwEYvkMHTSJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=MyaTijHy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ry+qOhoa;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2E606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA2E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=MyaTijHy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ry+qOhoa
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DCB8140028F
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:27:24 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Thu, 26 Nov 2026 09:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795703243;
	 x=1795789643; bh=r5fpEpzNM6uji7Nri+epW5yidLQBDkGGYauevO2LpP0=; b=
	MyaTijHyLifJcnkuidkvnhCsjqtwZanxXuiPN4FQyHkR4bDd/Vn0K1m9PROarqOU
	Kaqje3I5MRMner+o0SLReDRhM3brQU8e0ltIj/hKO8Boo7hKquYy8JZ4xmzHcbi6
	bOif4wa6dnceqIoD3BYgdvC2SnYoZyNJWKSGEg1jx5MUVquWJEZEY1/yLo5RWPe1
	zcOwc3xyzLcgX6QNYxzexcc281zv8BLe+EMfr0dfekfB+RpAgixDWSNsteTWgq0u
	cLITnDaj3IogVIPUqMy2MzCgbZIgAnXS3rql65v1/jvKrnTwrhNdqKnyklblyXVw
	/njmOtiKBluwL8+zOTb46A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795703243; x=
	1795789643; bh=r5fpEpzNM6uji7Nri+epW5yidLQBDkGGYauevO2LpP0=; b=R
	y+qOhoa+2wHVBFEiHfUPW1nz3wWPKBlnGKFIs8VH2tnxU31QGRQBskul+NOAmBsr
	ct+z9ZOBNIwWwrji8zvFm70FYFjsd6nHmOqhc8lOMnG24sJ5d0Lj9JSdxHQMA7ZX
	shQ46k17LpTKl5LRjXWxHNIo8uSVG1TmQpeYWJR6ytNOX0pWHeaTASA1NyxOYlf9
	hnQcqktQIH00E2ZJRcbL+4+FfU+Sxrpvg3mXpZzuuvfXwRXIF6/qhsSDJb40mXrA
	u6ZfkGuJpDLWioDV5pqR5c8h7g9B5SCjw32foqFqUuugmlt0P7FApHEMKNAH/+m/
	N1RuPll4S/SzkyqGX8U5A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795703243; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ODg8d6yywcg/O3hmJGX3PRXv0kQ9Jv+CWUfPQDppiG9SrNH
	WV1PrmGuPdHWFiPIMHjxx4SjdNrWBk0WREV1FdIQqNLW8aJD7fVN6AJHxx7MEYiV
	2XeiR8iRE4f/+BwT51yj6ZQNHqiOE9sQOB+GQZucjoFfBqct3w3m54u8z2Li1F95
	g1s7lrywOik+YvJ0neU8tt6bAFvEqPsK4MjsJlHm8UTp0LTVKV1gC34IMQdK6G2a
	BK7tNfW5KDP2ZjOWrOuyh9m4OXhH49veW2XQH1GLmBnHD6nnPM+UV4lkq7HqkREc
	WBKEIp0wrIjrclx9GmmrCAPhWfGjMaxfz/TpxEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XydqzwGiPmTgDo0cR9+N0tQdhovMDns3jwsPFHcg2+0=:73OSTreSCsTAc6ALEz/M06Z8YB3FZxdl4F3xmQt+03Q=;
X-ME-Sender: <xms:ykEIa-Toqtq_UfxPLBXv0_DT8fX1F-KG22GAQBVXHBCNOySXdJ31ug>
    <xme:ykEIa-nUwO3fpjK6jjguCCzLZsf32nW9_EH5l6BEiOJD6-bYVLmPJZHKe27WVyjKo
    IdnsRuY_gnK_9DFE77tfbCDCNFR2nlpTyn31ZgcaHZjv2RYN-JiNQlt>
X-ME-Proxy-Cause: dmFkZTFGSLIddqahp+MsUwyGR63OJKsG3qiP6EBAcMuzWDrxrnBMC7/HOeDwfZhl7WXUIY
    Cau2S5irihZYqbPZm/tDe6Dl7WEJpWuwhI1ZKhD9QlmeivJnZlUo3n7CuLKhuUwxUmfhZ3
    LRGagQCj/W4r4fvPunfCC31gbDxc6lZeUMlygf732bfhanle/xhUrDPFGIdULMlSPWMYRz
    tVBfZGHmGnuJre43JH1duql5btr1ansK3cssqhBsO+AQ3JvH2zwBVilurRfXmpmfAqwGqa
    gxpiCS6aWaij6XmvV/daHxPDf2vmF8HNznurBztq6XiH+++c4QkALwkcZ3nZnKaqMaWJmZ
    FESSQRdGmfM/9gf3Y/QGScezpRfnF3jb2dWru4jImyg1PiYVV4fQgUcrcMTkkzAtoSbz7W
    n9ztROoCp3Im7H4lX6mtM4rFsZgwPiprel+uqoTdpc7wCXq6HfF3FT6CYL7wG7CbTocRzU
    3td6TDAlhnH1kI2dhJy0wb/EnSUGn1Kkj6VuDOKbvrdi7Pc1JIp/h1gS90zhkvPibEBAMG
    PysxkwA4PeT9wzLZfaaKkhWBTW7N/3b09HRAysmJ5NdGA/Q1qv4BTgoheXt+0BUn5fCcr2
    w+acTSkU7AAnjbjTZEXn3ZekEouLFrpbRRkOKXZyE5QpoEMLMX0wD13L6waA
X-ME-Proxy: <xmx:ykEIay1GWZKA-5CcXkm8oTz6eSgfi9UG0HuM2BKAO7GoHcY8fvMW-w>
    <xmx:ykEIa3VTWTsmGhytd4bp7PzIh71H0lGEJBaHTISsmWvlvFMVX3xSbQ>
    <xmx:ykEIa9KCI9faVxclSjhChnsRBCfwONELYmBY1GDfOgQ3ExR1mSKtyQ>
    <xmx:ykEIa53N7sUO63cjRLN9826dCNO2tPiCEOrTeA7uSTYtB1jtXGqj2g>
    <xmx:y0EIa1gARvfwzuEKsMSs9bc3b05vvITjIDhayrQQtpmsk846Njnv9UVO>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id A1D9C2C00085; Thu, 26 Nov 2026 09:27:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AYDYWHX8bjAc
Date: Thu, 26 Nov 2026 09:27:02 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ricardo Ribalda" <ribalda@chromium.org>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <dfc69d6a-1fdd-4174-8522-ba02887ce524@app.fastmail.com>
In-Reply-To: 
 <CANiDSCtcOa1UuCOb8wwpMdGRk_3Kb0aZtoiNfMXX2Y-0fCjorg@mail.gmail.com>
References: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
 <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
 <CANiDSCtcOa1UuCOb8wwpMdGRk_3Kb0aZtoiNfMXX2Y-0fCjorg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 26, 2026, at 9:09 AM, Ricardo Ribalda wrote:
> Hi Mark
>
> Thanks for your review. Do you know if this is going to land in the tree?
>
> Thanks!
>

That's up to the maintainer I'm afraid - not me :)

I think you should probably have cc'd Jonathan Corbet <corbet@lwn.net> and linux-doc@vger.kernel.org on the patch (I missed that). Maybe resend and add them so it's in their inbox? (Jiri - please correct me if I'm wrong)

Mark

> On Mon, 2 Nov 2026 at 18:48, Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
>>
>> On Mon, Nov 2, 2026, at 7:40 AM, Ricardo Ribalda wrote:
>> > Friendly ping...
>> >
>> > On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wrote:
>> >>
>> >> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge them in
>> >> sysfs-driver-hid-lenovo-go to avoid this warning:
>> >>
>> >> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
>> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
>> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
>> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
>> >>
>> >> Cc: stable@vger.kernel.org
>> >> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
>> >> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> >> ---
>> >>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
>> >>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
>> >>  2 files changed, 6 insertions(+), 40 deletions(-)
>> >>
>> >> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> >> index c8221373ef76..f3ba3504939d 100644
>> >> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> >> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> >> @@ -364,11 +364,12 @@ Description:      This displays the available options for the mode attribute.
>> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>> >>  Date:          April 2026
>> >>  Contact:       linux-input@vger.kernel.org
>> >> -Description:   This controls the behavior of built in chord combinations.
>> >> +Description:   This controls the behavior of built-in chord combinations.
>>
>> Nit - this minor change is not part of the patch description.
>>
>> >> +               For the Legion Go S, this controls the touchpad's operating mode.
>> >>
>> >>                 Values are windows or linux.
>> >>
>> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>> >>
>> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>> >>  Date:          April 2026
>> >> @@ -377,7 +378,7 @@ Description:        This displays the available options for the os_mode attribute.
>> >>
>> >>                 Values are windows or linux.
>> >>
>> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>> >>
>> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
>> >>  Date:          April 2026
>> >> @@ -640,7 +641,7 @@ Description:        This controls enabling or disabling the touchpad.
>> >>
>> >>                 Values are true, false.
>> >>
>> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>> >>
>> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>> >>  Date:          April 2026
>> >> @@ -649,7 +650,7 @@ Description:        This displays the available options for the touchpad/enabled attrib
>> >>
>> >>                 Values are true, false.
>> >>
>> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>> >>
>> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
>> >>  Date:          April 2026
>> >> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> >> index 4d317074bb7e..218164cfe544 100644
>> >> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> >> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> >> @@ -231,41 +231,6 @@ Description:       This displays the available options for the mouse/step attribute.
>> >>
>> >>                 Applies to Lenovo Legion Go S line of handheld devices.
>> >>
>> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>> >> -Date:          April 2026
>> >> -Contact:       linux-input@vger.kernel.org
>> >> -Description:   This controls which value is used for the touchpads operating mode.
>> >> -
>> >> -               Values are windows or linux.
>> >> -
>> >> -               Applies to Lenovo Legion Go S line of handheld devices.
>> >> -
>> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>> >> -Date:          April 2026
>> >> -Contact:       linux-input@vger.kernel.org
>> >> -Description:   This displays the available options for the os_mode attribute.
>> >> -
>> >> -               Values are windows or linux.
>> >> -
>> >> -               Applies to Lenovo Legion Go S line of handheld devices.
>> >> -
>> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
>> >> -Date:          April 2026
>> >> -Contact:       linux-input@vger.kernel.org
>> >> -Description:   This controls enabling or disabling the built-in touchpad.
>> >> -
>> >> -               Values are true or false.
>> >> -
>> >> -               Applies to Lenovo Legion Go S line of handheld devices.
>> >> -
>> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>> >> -Date:          April 2026
>> >> -Contact:       linux-input@vger.kernel.org
>> >> -Description:   This displays the available options for the touchpad/enabled attribute.
>> >> -
>> >> -               Values are true or false.
>> >> -
>> >> -               Applies to Lenovo Legion Go S line of handheld devices.
>> >>
>> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
>> >>  Date:          April 2026
>> >>
>> >> ---
>> >> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>> >> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
>> >>
>> >> Best regards,
>> >> --
>> >> Ricardo Ribalda <ribalda@chromium.org>
>> >>
>> >
>> >
>> > --
>> > Ricardo Ribalda
>>
>> All looks good to me.
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>
>> Mark
>
>
>
> -- 
> Ricardo Ribalda
