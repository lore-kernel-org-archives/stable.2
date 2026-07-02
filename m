Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937836C9CA;
	Thu,  2 Jul 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018390; cv=none; b=IRFSXzdhzlsMad38Qp5K1FcjIlx5+bS5Y8Wa7kRpjQ6L1YGGr4NtdiYb5eTCdWVXWXYRhdYeLBYTK/RNvKOim7ZExxhlCX2jm24k9Uh3zieRmSg1UQDzxActL4lCilxcTxRwlssRonYXLIuj1VImHVwtvcVPuHdNnoyqegxVpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018390; c=relaxed/simple;
	bh=UXcHXBttgxRaR5S2eMdWxOcU8TYp7kkzrJTgdCcjZkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqQpPYwCQdt581j/hy7QDtB+cuZW4K7poZNVzU/Pz7mkiKeH2uIme0PaxIT3hwQFmf8XVsoTqMEt2ujhEjZ6u2UAilL4QEPEz478jPcjeA5lhtx+t9UNQxmDWb8l4V1a+cr47tbBsUGu+bfNxWAnwbow0nBwtYLNN6yzKyHikQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHPr0gbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHPr0gbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AFB1F000E9;
	Thu,  2 Jul 2026 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783018389;
	bh=z+LfsJVVetcMOCed5WDYmTHA9mvMGGr0BP1ehktRowo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DHPr0gbU2nmNExY3GbRODo8LMGXd9XIfsS7l29FOqLYpD/coQ61p69R3CzT/HC+zG
	 GVBNqJ+MGtcXQLz1Iri40YDbc8AA3deHwiSbR+A/nBbpo8+2WQUkEOxUT0ZnMWneuH
	 32iE7vfyRn8SuYcXAb4jtgGBUjiPfCyN7YC5/k/XtxYE4ZW82jqTDRSa1Ut7Nwre4i
	 HlZF3Co5CsS1Rvr9JCzhLUmgXZoIaYK3zgnlFbLmp0HjKaZIs6/GTwE3ywrw2jz7x0
	 LJuakdO+PBe1Pb9tyaRD29Q9+kFn2fZ1mMv9fdQ1ngeblcIpEuUB366Or9Zhi2oDHo
	 VpMoG30JsxLaQ==
Date: Thu, 2 Jul 2026 19:53:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: sensor: custom: Remove enable_sensor before
 freeing fields
Message-ID: <20260702195305.5fd45d96@jic23-huawei>
In-Reply-To: <20260702094856.1105555-2-haoxiang_li2024@163.com>
References: <20260702094856.1105555-1-haoxiang_li2024@163.com>
	<20260702094856.1105555-2-haoxiang_li2024@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 17:48:55 +0800
Haoxiang Li <haoxiang_li2024@163.com> wrote:

> enable_sensor_store() can call set_power_report_state(), which
> dereferences sensor_inst->power_state and sensor_inst->report_state.
> These pointers refer to entries in sensor_inst->fields.
> 
> hid_sensor_custom_remove() currently frees the field attributes before
> removing the enable_sensor sysfs attribute, leaving a window where a
> concurrent sysfs write can dereference freed memory.
> 
> Remove enable_sensor before freeing the field attributes.
> 
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

If this is the UAF that Jiri called out in patch one, please
credit the bot with a Reported-by tag and link to that review.  Example:
https://lore.kernel.org/all/20260702183644.60827-1-adrian.hunter@intel.com/


> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index afffea894021..d7bdbae96b50 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -1042,9 +1042,9 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
>  	}
>  
>  	hid_sensor_custom_dev_if_remove(sensor_inst);
> -	hid_sensor_custom_remove_attributes(sensor_inst);
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
>  			   &enable_sensor_attr_group);
> +	hid_sensor_custom_remove_attributes(sensor_inst);

Given this is out of order with respect to reversing what happens in probe,
please add a comment to say why (and ensure no one fixes it back to
the original order!)

It may be that a reorder in probe is needed as well to bring things into
balance and ensure that fields is available when
that enable_sensor_attr_group is registered but I haven't analysed it closely.


>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  }
>  

