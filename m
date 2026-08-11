Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3944457A4;
	Tue, 11 Aug 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455877; cv=none; b=AiicH4uZGmr6vt9qf8SnEK6AKIrXx06DYUPIuQhLT3a5X5qubooAPc+ufpgPB7eyxhND6oOWO4HCHaapGywd5zqr7R6N+gLpAiob4nyXAos/t8sAlvlA3Xru2GQ/tMwZ+MqsckKMEM5Og9pT4D+/otIB7TuqvLinLSEv6Oys0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455877; c=relaxed/simple;
	bh=vZxOgSk/8LC6tSxBXR9s4xgADIM60QQkBnUj2fl9Asc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blqG2p76+fIZNr9QFj1QJSc4reMBleb7yBn2n5UmhHsAehj97f67mgW0bVkecQ5n//lstIktsyteEe+RNhkiSR5esdufFIaa5c82jTpYwD+Ss/PpobBDd9nZUJYJaRWaC8m/7tDHsVUm03DXTLHtME6wcvqfl8ugv+fs+LQNsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hHLV1/Ad; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hHLV1/Ad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786455861; x=1787060661; i=w_armin@gmx.de;
	bh=FvrrDus05Nb6kj7jBPZ7JM1VcPx1G9iq+0TWbjm0hy4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hHLV1/AdalLWzcAl6VTaXRIwscdT6RqjiuojFaTKpdRkrOrv4ACc2N0a9MNGsf9+
	 BT8/ClxGh8eAG/eG0324xWHTss10f1gROo6UirDZeBqxWL9JUr6+jCZOBeQWQJdsW
	 lMJcvhOnQ2cU+ogV18UemaSEE4xZvixtf6Nu3usDYcRayA+Tri07KZBJYIBAm/Xkd
	 IQKWiGIlJTgzAhwduAH1MhZFJqK7A42uYXBz7w7AtWX5YZfjNJIFGuNKd7RoeVjOG
	 WL0atbx1wUICzsiWa2wJeejon2jWliSg4mQtRnE12UOHUKruMgtno9ttKWIxhmtgB
	 noZNNw7MvgIZwY8Iyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1xGiyu2Vkb-00m05v; Tue, 11
 Aug 2026 15:44:21 +0200
Message-ID: <72e66d0d-08cb-4d90-9526-c7acfa614006@gmx.de>
Date: Tue, 11 Aug 2026 15:44:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Add ACPI_COMPANION() NULL check in
 parse_wdg
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811102128.1027805-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260811102128.1027805-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bedby78WHoCcAGg0H9WVKYNbksv0sJGWtTuObhP3Lh788Z+CiGC
 lgM8pKmckItSMzOCQWGRnzG7Ku6VTMw4Xu7tNBIz60J58cK1McWyeTiAX1DiIiz6HtmLt8/
 5GXsG7+d30hIBAOojkBYi+SsQL9LgX/HKNkbRONMbDibuLr4xR1isnS875pdCkwx9v5K/Gt
 zBuoyigxFrDy/JAqZHAYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VgLd/Iru50k=;+DM4nMkEqxmHFJ88sQcEqTZ+8lB
 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

Am 11.08.26 um 12:21 schrieb Xueqin Luo:

> Add NULL check for ACPI_COMPANION() in parse_wdg() to prevent NULL
> pointer dereference when driver_override matches a device without
> ACPI companion.
>
> Same issue as CVE-2026-64227.

Hi,

we already perform this check in acpi_wmi_probe(), so doing this again is
not necessary.

Thanks,
Armin Wolf

>
> Fixes: 4186a47dbfbc ("platform/x86: wmi: Decouple probe deferring from w=
mi_block_list")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> Cc: stable@vger.kernel.org
> ---
>   drivers/platform/wmi/core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index 529825dcfbfe..151b712d08b5 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -1290,7 +1290,7 @@ static int wmi_add_device(struct platform_device *=
pdev, struct wmi_device *wdev)
>    */
>   static int parse_wdg(struct device *wmi_bus_dev, struct platform_devic=
e *pdev)
>   {
> -	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>   	struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
>   	const struct guid_block *gblock;
>   	bool event_data_available;
> @@ -1300,6 +1300,10 @@ static int parse_wdg(struct device *wmi_bus_dev, =
struct platform_device *pdev)
>   	u32 i, total;
>   	int retval;
>  =20
> +	device =3D ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>   	status =3D acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
>   	if (ACPI_FAILURE(status))
>   		return -ENXIO;
