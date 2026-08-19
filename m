Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB935C180
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148995; cv=none; b=MnQReHqQJ0ix78lC5gbv6Zy0+cjOJGMs8Is9wZnC9MTGpi2G6vgQ6AE5th376SX2CP4CikHOdrA0NMJUWWolfgVGrSBqjsjedFr1Yb530rALVMB28BZNocROLijvuy4iFFPfDA0GLc9UvpZA33VVaJP/9AdAUWiDOnMiTemZM6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148995; c=relaxed/simple;
	bh=bHbfKJz1kka7mf5RZIATEdTfLySqLtCGs2gr0iabdH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k449QWkh8qwB4iio7S2Gc2LPHcsJ3KYP0rftUVhNhUjcYjhTWQinpQnIM4AbJCzQuP6yJTolW6FAcOVsGt+QXu1y2rkZnz5/J9JWGgLLHH8f/cCbfdRhgvsLr40Fc3gmenGIYEzN5/lRtX76UdKDh78QURYrh3qnfmxt2DW0zUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vHpkz8sC; arc=none smtp.client-ip=95.215.58.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vHpkz8sC"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bHbfKJz1kka7mf5RZIATEdTfLySqLtCGs2gr0iabdH0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787148989; v=1; x=1787753789;
 b=vHpkz8sCGRwG77+kJALVkocUIcGp4ukqHZay6q9TyMN2SCxbc5aa2kzbNkRy3CyBNGNa9mpq
 PygJdgrcWEmxilfH+zd2XGsA9zRoIrPPzmWb+OLPoEop4SVfFYilVl9k/Uot7keSkLr5zDCyzyJ
 KEzhhWjQGrRbw5be4OFrSUKw=
X-Envelope-To: stable@vger.kernel.org
Received: from [10.80.0.99] (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 799ae4864548c5e1;
	Wed, 19 Aug 2026 14:16:29 +0000
X-Mizu-Trace-ID: 799ae4864548c5e1
X-Migadu-Flow: FLOW_OUT
Message-ID: <6627d99d-5507-49d0-bdea-f14c919a290d@linux.dev>
Date: Wed, 19 Aug 2026 16:16:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: asus: do not send keyboard init reports to
 touchpads
To: Panz Dev <panz.development@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260818151431.939132-1-panz.development@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260818151431.939132-1-panz.development@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/18/26 17:14, Panz Dev wrote:
> Commit 0919db9f3583 ("HID: asus: always fully initialize devices") added a
> loop during asus_probe() to send keyboard feature report initializations
> (asus_kbd_init) to all ASUS HID devices.
>
> On ASUS laptops with I2C/HID touchpads (such as the ASUS E200HA), sending
> keyboard feature reports (FEATURE_KBD_REPORT_ID) to touchpad endpoints
> sends invalid feature requests to touchpad hardware, corrupting probe
> state and causing the touchpad to become unresponsive.
>
> Wrap the asus_report_id_init loop in an `if (!drvdata->tp)` check so
> keyboard feature initialization only runs for actual keyboards.
>
> Tested on ASUS E200HA (where touchpad functionality is fully restored)
> and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).
>
> Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
> Cc: stable@vger.kernel.org

Reviewed-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Panz Dev <panz.development@gmail.com>
> ---
> v2:
>  - Keep asus_start_multitouch() inside the HID_CLAIMED_INPUT check to avoid
>    any UAF risk if input registration fails (as pointed out by Denis Benato
>    and automated review).
>  - Focus the fix on skipping keyboard report initialization for touchpads.
> ---
>  drivers/hid/hid-asus.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
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
