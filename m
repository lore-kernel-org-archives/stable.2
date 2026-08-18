Received: from mta0.migadu.com (out-149.mta0.migadu.com [91.218.175.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E833C1400
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044422; cv=none; b=DLqxFygASjCFVjmZBwp5JNdT9zecmwLSfgJt7qSseHladedQyt3DeJOcTdtSqBeaFP3sLGT4JlQjJ1/Auy/U7M+lUs6w73ML8F4f7S8EwNsHJPm1zkGxTx6FLtDWJQ6YDPie+GvAAJhpehXxWNbZFz0W24kVxmG7KGQB2tkIIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044422; c=relaxed/simple;
	bh=lt2HcI6nybCzyfFRr8ydY9sXKqJ/ZC2gaShlnnB1P2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj+uGg4OELm8jboMTOCR6DLwR1Fgokcll00WuBavpkgEyqg1BWlpVrWPJ+y2iSK9kE0REPm7PlZeRPFMmxNLdZnCTBaVRlfPStIkemPkHrtLnp7f7xbQ4Zrq1aGr6Sa2/me5X7hO2uX64L5efP52eAdUu5AXCkQ4v1VLHh2wduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vb1eC3i4; arc=none smtp.client-ip=91.218.175.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vb1eC3i4"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lt2HcI6nybCzyfFRr8ydY9sXKqJ/ZC2gaShlnnB1P2U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787044417; v=1; x=1787649217;
 b=Vb1eC3i4JkiAysSOLwQeJXxHjsX+T7TxP+quiRRr+wSXdQ7qHu+idHpRCUTsJcmz8IYoalb9
 wu4SthnS4sdvk0XlIZJfMMH8hAoY/ikcOk/pVAoM66AW8jp1LJDvNZxcQtGv6Z6yvmAeV/RGT81
 bvRyZhETnWYzuEvggnqp+moc=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.80.0.99] (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 6b73d90c19bbb78d;
	Tue, 18 Aug 2026 09:13:27 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <5847901f-6080-4b8b-98d4-6693d64fb748@linux.dev>
Date: Tue, 18 Aug 2026 11:13:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: asus: fix touchpad multitouch initialization
 regression
To: Panz Dev <panz.development@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260818085623.18467-1-panz.development@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260818085623.18467-1-panz.development@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/18/26 10:56, Panz Dev wrote:
> In Linux 7.1, commit 7253091766de ("HID: asus: do not abort probe when not necessary")
> and commit 0919db9f3583 ("HID: asus: always fully initialize devices")
> introduced regressions in the probe sequence for ASUS I2C/HID touchpads
> (such as on the ASUS E200HA):
>
> 1. asus_start_multitouch() was placed inside the claimed input check block:
>      if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT))
>    On ASUS touchpads, (hdev->claimed & HID_CLAIMED_INPUT) evaluates to
>    false during asus_probe(), skipping asus_start_multitouch().
>
> 2. The asus_report_id_init loop in asus_probe() was executed unconditionally
>    for all devices, which sends keyboard initialization feature requests
>    (asus_kbd_init) to touchpad endpoints, corrupting touchpad probe state.
>
> This patch fixes both issues by:
> - Skipping keyboard report initialization for touchpad devices (!drvdata->tp).
> - Moving asus_start_multitouch() outside the claimed input check block so
>   multitouch initialization is always executed for touchpads.
>
> Tested on ASUS E200HA (where touchpad functionality is fully restored)
> and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).
Hi,

thanks for this! I forgot to exclude touchpads from that init sequence.
> Fixes: 7253091766de ("HID: asus: do not abort probe when not necessary")
> Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Panz Dev <panz.development@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67..7f19ca1e5a1b 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1294,12 +1294,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  	}
>
> -	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> -		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> -			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
> -			if (ret < 0)
> -				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> -					 asus_report_id_init[r], ret);
> +	if (!drvdata->tp) {
> +		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> +			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> +				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
> +				if (ret < 0)
> +					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> +						 asus_report_id_init[r], ret);
> +			}
>  		}
>  	}
>
> @@ -1327,12 +1329,12 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  			drvdata->input->name = "Asus TouchPad";
>  		else
>  			drvdata->input->name = "Asus Keyboard";
> +	}
>
> -		if (drvdata->tp) {
> -			ret = asus_start_multitouch(hdev);
> -			if (ret)
> -				goto err_stop_hw;
> -		}
> +	if (drvdata->tp) {
> +		ret = asus_start_multitouch(hdev);
> +		if (ret)
> +			goto err_stop_hw;
>  	}
I think this will re-introduce the security vulnerability fixed in the commit that led to me
creating the "HID: asus: do not abort probe when unnecessary"...

Furthermore if that drvdata->input && (hdev->claumed & HID_CLAIMED_INPUT) doesn't
evaluate to true it would be useful to know what part is false and that code that prevents
null/invalid dereference is wrong, and since I tried touching it the least possible it means
there is also the need to change the && back into ||, but that would undo the "keep the
proper name of the device" for keyboards...

With these in mind would you want to try fixing them all at once?
>  	return 0;
