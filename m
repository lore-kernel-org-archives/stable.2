Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9B3C456B
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180030; cv=none; b=hEZ3q2UacJzl8X1BJe2cztyjqVD3/1M1wXsee4cWqI9FdAgnnNdXDtJfo8ddlfOoqgBNOrslju7Yo52EBWpj25PJSGakLH028uZ3fOXeMYxYYqJdAgeyQaNy8UfQjpN8Tv6L/K6USFdNqn4FY+cpCoDie6Egz8SQeIYmuB0UQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180030; c=relaxed/simple;
	bh=S8dZjeqOYV4ek91I2r4Qov9/LVvEEgQMX8OjggbeLCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPOE/AsaLd49v5Je8TWMg54EwNS5lUZbpFg1WuTDN40lpjmY96Frc8bvpluXJ8alyiVEpg1zipfsBvqPfEd4Z7iGxp4LtX78E5y7Iv9LkpPd5Y5SJUqw4euxlBs/Nb0FDo1Asw9jU4e5RhhyHcCq0n5mLuBrKxlZMalPjfBxCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmTHClyx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmTHClyx"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1260770f8f.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180026; x=1788784826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wnfH7b7KKmDiXtn7bM9cfVe5VuHQ+7bwoAdYTm8PAY=;
        b=hmTHClyxhl3g8IIP1y/KOI/t2FGA9hqsQcFIt3fS906aTCmPhS2X20H50m/EAlfmuv
         QMlaQGlD2bc2o1KoqHwgKuYGpNTtMTjHZWvmsMt26Ill2vUOgBN/wUw5FWhpgIdsCl+y
         +Dtf2Ei25rq4fInbiCwaqDojk2NLR+Tq8KS5/VLHqI3MH1w0RpiAyfZvKfmBqAXwIgAr
         fioZsY/knH1c8Sxx8RWSOQhcPo3CZl29hrYm4j8VoLmgz4WSNcsX8I8P/HbhQdLtJZUb
         Eg09ihGctnA4vRnwvFQ1zc6DfR82F2ptH6Kzg31hKGg4bSBtveukBd7fnNWx87bId1tQ
         Cz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180026; x=1788784826;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wnfH7b7KKmDiXtn7bM9cfVe5VuHQ+7bwoAdYTm8PAY=;
        b=MM5jlqP3mWDVzyvM2YDf8UFK4kO5MeWxwfWQ0YeeRhC6ZAaOyedJCaKyqRU7l4FHw6
         Cth46VEh9wQXPc3RI9dc4MHUfdD7JoUYDFs9s5xCHbltjjG0CKmw9WMS2xS2GLVwFW3+
         vZaz41fQ+LShh1ec4ItP9RPziXeGDqY53moi5fklrWm03gcR1SWgWPdtZ4qlcL8I97qC
         hYAxxlgcEx5cTzGBkCQtSQpUsrtYNCidVuoJdY4sbbtnMRc26KNM1598xGrkP7V50k/d
         Pkgo5bhSN5K3RVmwKlu/AJE6reIZjf6ursAPqC2W+GEeyTQuXJG/etQEvR8kIoIQ8Vkq
         bdPA==
X-Forwarded-Encrypted: i=1; AHgh+RpYGIw4KYXAiXq9XZy1xUyZvhaoA30il1kWTkSUK4rKNOUF0t6LszHPbIpvoLc5ik+mXEHPhRs=@vger.kernel.org
X-Gm-Message-State: AFuF++kPLBLiz5XqeTFImcgXhv1kf5cTZlaOkv3Y6xJJYej2T6f2qXdl
	WMVl3nkJ/y0FtvMeTEJYhPFzRzHWYlAj4X4cWZiS/eATaHX/NYuaproEw2c+2CO3
X-Gm-Gg: AR+sD11Ndj4n8yApqghGI3z4kNrCA6ZVShIhOHVGVBR7lNPqLCIn2Nb14+8F9cGh+WY
	cE+zIS8jYAOSrS4eYbUKo1BvT22bf1fa5c4jOTkXLodhUI3UiK9EgQ/fJqINZxqduxNw5tiAHz0
	wY5+JfEVH6GmFOoyBIDrVp/KUgLyjLcu3H/SOwcjVMXeYLvpxDTW6phPj9rtLQJQQzfaDSiQrUM
	oGncwKLn044uZzO6Ov0kCCdwEMw7F2JegqsaBRiT2gwgDEhWpqQfqy0AOkfHUFJ1f7HLIVItmvC
	iXHYGO0vUCzQY5Y3FgER4A3F0mD4ifHMbYVhBGNFUzAJnQPrT47/2UQEoywqMjt77rYJBwnwiZO
	F7mSxnoGCvoMN5wZXj0/OX1W+jCdHmGBGqtljybCNtn5TEv64ayWMTH1bUtDy8/sTlzi1SA7Hh5
	o7ccTLGafHZlnFIgJYPDXjzWA4BICSuG9DDSXrXGSdvy1+GaOt9hXVMj4zpj2BGJekNine9Myjv
	w536AvzFAtAPgJ0o6T4cnoyTA==
X-Received: by 2002:a05:600c:8011:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-49cdc5660bamr4232645e9.12.1788180025820;
        Mon, 31 Aug 2026 05:40:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b945816f2sm338783295e9.8.2026.08.31.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:40:25 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:40:23 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 kys@microsoft.com, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, linux-input@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info
 bounds
Message-ID: <20260831134023.7784374a@pumpkin>
In-Reply-To: <20260710022854.3739558-3-michael.bommarito@gmail.com>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
	<20260710022854.3739558-3-michael.bommarito@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jul 2026 22:28:54 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

> Add KUnit coverage for Hyper-V synthetic HID initial device-info parsing.
> The tests cover zero bLength, a valid descriptor plus report descriptor,
> and a malformed report descriptor length that exceeds the received
> message.
> 
> The same-translation-unit test uses a KUnit-only ACK bypass so parser
> coverage does not require a live VMBus channel.

Breaks build - see below.

> 
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/hid/Kconfig      |  10 ++++
>  drivers/hid/hid-hyperv.c | 117 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c1d9f7c6a5f23..41ca48d9adc9e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1183,6 +1183,16 @@ config HID_HYPERV_MOUSE
>  	help
>  	Select this option to enable the Hyper-V mouse driver.
>  
> +config HID_HYPERV_MOUSE_KUNIT_TEST
> +	bool "KUnit tests for Hyper-V mouse driver" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && HID_HYPERV_MOUSE
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds unit tests for the Hyper-V synthetic HID driver.
> +	  These tests exercise the initial device-info parser with
> +	  malformed host-provided HID descriptors and are only useful
> +	  for kernel developers running KUnit.
> +
>  config HID_SMARTJOYPLUS
>  	tristate "SmartJoy PLUS PS2/USB adapter support"
>  	help
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index fd90196430e29..6579bd19da13a 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -13,6 +13,9 @@
>  #include <linux/hiddev.h>
>  #include <linux/hyperv.h>
>  
> +#if IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST)
> +#include <kunit/test.h>
> +#endif
>  
>  struct hv_input_dev_info {
>  	unsigned int size;
> @@ -240,13 +243,18 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
>  	ack.ack.header.size = 1;
>  	ack.ack.reserved = 0;
>  
> -	ret = vmbus_sendpacket(input_device->device->channel,
> -			&ack,
> -			sizeof(struct pipe_prt_msg) +
> -			sizeof(struct synthhid_device_info_ack),
> -			(unsigned long)&ack,
> -			VM_PKT_DATA_INBAND,
> -			VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST) &&
> +	    !input_device->device) {
> +		ret = 0;
> +	} else {
> +		ret = vmbus_sendpacket(input_device->device->channel,
> +				       &ack,
> +				       sizeof(struct pipe_prt_msg) +
> +				       sizeof(struct synthhid_device_info_ack),
> +				       (unsigned long)&ack,
> +				       VM_PKT_DATA_INBAND,
> +				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	}
>  
>  	if (!ret)
>  		input_device->dev_info_status = 0;
> @@ -635,5 +643,100 @@ static void __exit mousevsc_exit(void)
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
>  
> +#if IS_ENABLED(CONFIG_HID_HYPERV_MOUSE_KUNIT_TEST)
> +static struct mousevsc_dev *mousevsc_kunit_alloc_dev(struct kunit *test)
> +{
> +	struct mousevsc_dev *input_dev;
> +
> +	input_dev = kunit_kzalloc(test, sizeof(*input_dev), GFP_KERNEL);
> +	if (!input_dev)
> +		return NULL;
> +
> +	init_completion(&input_dev->wait_event);
> +
> +	return input_dev;
> +}
> +
> +static void mousevsc_device_info_zero_blength(struct kunit *test)
> +{
> +	struct synthhid_device_info *info;
> +	struct mousevsc_dev *input_dev;
> +
> +	input_dev = mousevsc_kunit_alloc_dev(test);
> +	KUNIT_ASSERT_NOT_NULL(test, input_dev);
> +	info = kunit_kzalloc(test, sizeof(*info), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, info);
> +
> +	info->hid_descriptor.bLength = 0;
> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info));
> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -ENOMEM);
> +}
> +
> +static void mousevsc_device_info_valid_descriptor(struct kunit *test)
> +{
> +	struct synthhid_device_info *info;
> +	struct mousevsc_dev *input_dev;
> +	u8 *report;
> +
> +	input_dev = mousevsc_kunit_alloc_dev(test);
> +	KUNIT_ASSERT_NOT_NULL(test, input_dev);
> +	info = kunit_kzalloc(test, sizeof(*info) + 4, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, info);
> +
> +	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
> +	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(4);
> +	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	memset(report, 0x42, 4);

This has landed in rc1 and fails to build (with gcc 12.2) because the tests
in fortify-string.h detect that is it writing beyond the end of the
structure.

> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 4);
> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, 0);
> +	KUNIT_EXPECT_EQ(test, input_dev->report_desc_size, 4);
> +	KUNIT_EXPECT_MEMEQ(test, input_dev->report_desc, report, 4);
> +
> +	kfree(input_dev->hid_desc);
> +	kfree(input_dev->report_desc);
> +}
> +
> +static void mousevsc_device_info_report_desc_oob(struct kunit *test)
> +{
> +	struct synthhid_device_info *info;
> +	struct mousevsc_dev *input_dev;
> +	u8 *report;
> +
> +	input_dev = mousevsc_kunit_alloc_dev(test);
> +	KUNIT_ASSERT_NOT_NULL(test, input_dev);
> +	info = kunit_kzalloc(test, sizeof(*info) + 8, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, info);
> +
> +	info->hid_descriptor.bLength = sizeof(struct hid_descriptor);
> +	info->hid_descriptor.rpt_desc.wDescriptorLength = cpu_to_le16(64);
> +	report = ((u8 *)&info->hid_descriptor) + info->hid_descriptor.bLength;
> +	memset(report, 0x42, 8);

Same here.

David

> +
> +	mousevsc_on_receive_device_info(input_dev, info, sizeof(*info) + 8);
> +
> +	KUNIT_EXPECT_EQ(test, input_dev->dev_info_status, -EINVAL);
> +
> +	kfree(input_dev->hid_desc);
> +}
> +
> +static struct kunit_case mousevsc_test_cases[] = {
> +	KUNIT_CASE(mousevsc_device_info_zero_blength),
> +	KUNIT_CASE(mousevsc_device_info_valid_descriptor),
> +	KUNIT_CASE(mousevsc_device_info_report_desc_oob),
> +	{}
> +};
> +
> +static struct kunit_suite mousevsc_test_suite = {
> +	.name = "hid_hyperv_mouse",
> +	.test_cases = mousevsc_test_cases,
> +};
> +
> +kunit_test_suite(mousevsc_test_suite);
> +#endif
> +
>  module_init(mousevsc_init);
>  module_exit(mousevsc_exit);

