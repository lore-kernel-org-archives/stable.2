Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD02DB7B8
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787989170; cv=none; b=YYRz3pxERB0A6wDEjQyS6cUNgcMdJw6TYr44tfgVlxKEp2l1pY5XJGS9LUOuts2sUL9QJpqAmeYCKNYgQK28QtWFE1bZ6+e68YepP56394bDD/9CdaSi4UF9O2FeV2mMKBVnZFQdvfKkjtb2Vl3meWc9y0VR1DCC8Drm+8KDSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787989170; c=relaxed/simple;
	bh=Fl0jnXaPEWiKqd7Q32TYDalsVlXkvLPGZIAW6itNGmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFTjW0RVQ/0EdNTYP7nR3Sirxw4hVgU2bfWa2pFCt5et2OkezZjrknKMArPC4q1iNqaKWUACfysWR6LgrVwsvwvWqD0D+AnSD96YF1GtyTiyl1y1j35skZZlEqt6TChJa9ONlymB5lL63jTf/TalTAKdZ5uLAgvw3gk6Rv7aKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC/fSue1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC/fSue1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceaf8a1265so22567625ad.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787989168; x=1788593968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E+jXy+0y1xn3HgSoRA0hzYr820gLXgKV38btGuCIEbE=;
        b=SC/fSue1wzc46H0xezHE37Ice6kEbzcKtOoe0r8/QjtH5+4fewpc3OGVAhdyIrAUBK
         xj5WtCx7jfRdAKqi3CwN3CK6gZp2mXg0dUfZtnB3HvT5lhKN0tFOq/Eszg3kpnYFUqiJ
         vMHBfs6EZHzJBSPcK1zggB03BnNrJbne1FH09LOHmz1wckpmRzVtmbacQC5Ll55AFg03
         CWj5K8su++/LW9IeRb8Jz1Da1iRWsjU7twlqH0d9N6DMYdme2wuAUrpl5xsYElZJHiJr
         vjZn77x0iEsjmRUytqb2dFGTCYWEdg9WbjeXUASi6JagBpHZXhQnxjNYAkAzi/WjWySj
         vdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787989168; x=1788593968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E+jXy+0y1xn3HgSoRA0hzYr820gLXgKV38btGuCIEbE=;
        b=cenBz54tzz+HxiIrZ8yBLGCu4bMsa7/7W3nMkwQ+MoD5hJ/CmQj8SQeCL/UPoCsV7R
         wSJ6BITPHBPh4Rgp5sWdQ+BCgTjaC7qOz0jMj2p9gUBFyRxQCNZPianVEea395F9h3mG
         h/DZFPyVMucGJMoQVeGjkTKHJoqYx7y8R8YqThRoYrveroYOg214kduPce0HR6PIMMEr
         H56LWaEgS6lOvnwNeVcs/sjdUFjAQ6ykhTBODhU8QgU0hLR2l/mwmEpXYgihBCyziuez
         HjS+Qk4sol/GtIOZ/ndsExo727dXjod3qiQdtD0VyQ7E8Smrhr9s8VZfydPwIyvwkvZ5
         YkRA==
X-Forwarded-Encrypted: i=1; AKwUvBx0S2YH5jS5/uSjpq3Ne/0AUDqLQJxyg4pd4SmIB6juTSyUj0cdQIYQI9dYs+Km+RvWpnlby4I=@vger.kernel.org
X-Gm-Message-State: AFuF++lIPX0qtJto59l0rqWScsEcjuh00a1nWIwJR8QEyQl1y1b33x0a
	6IoF2yVNrWX2giPLxNBF7JUB667rdfs3ckRpQYRhU1rT0tNB6I63gPEC
X-Gm-Gg: AYBFou0OTH/Fmp4Rd7PV21pmkRmhBsAtlXqc/ptIO+omL7f4FOF/qgQ/zes66rSvdlk
	yAPlAnu/kp/Z8MOoTTvotBFrPlN5UbnwKPCYhpAIjVvq14ED0FFNQ7MdeNjsO1waifLIky3OVCQ
	fgatBj8B5Bsxqw7nK+/g6Y8cLnFogz1swgHZCjr0q91xFO0hH8vq6iJXV0OhVNJPQTS9TcsnKEa
	4phr9geyVk6drIHl4G1sRjJidPemfZxC1gI7wXuUthoqkjAiRrRT1vgttsBENsGi8zn1G1u8KJ0
	ABbQXW5Gv0G5Znq9KMJuX/e+Fu+ngfQR7t2mRZHyqPSRlcGlICWlLqxLHbEjgC38HSOo2jBgK2W
	1F85qJRKCjaOrTHLCmJiFx/8jvtVDTnrBOpzHJf5oJgB/ZSHAXsPwPvtZdjUX7xRjjeAtmHewz/
	Spv4vp+6XonyYnr5d0wPza7kW0b6H96ZPbLOyeXPh8dE1AFFpWbqJgqNMR/O9gElUoW2mY0psDt
	IQZocco2Hc9AzR+3GVB4FfF9EXExHGfBm0h9vSNXcN/7WqZJW6eO7UZZA==
X-Received: by 2002:a17:90b:3ec3:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-396d0ebd7eemr19840989a91.9.1787989168442;
        Sat, 29 Aug 2026 00:39:28 -0700 (PDT)
Received: from archlinux ([2405:201:1b:20ef:268a:fa82:9f05:61a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4de3sm17201372c88.12.2026.08.29.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:39:28 -0700 (PDT)
Date: Sat, 29 Aug 2026 13:09:24 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: Arda =?utf-8?B?RG/En3U=?= Ari <arfeliousheres@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6
 board
Message-ID: <apKKuL5lh2OK-6lq@archlinux>
References: <20260827235139.154462-1-arfeliousheres@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827235139.154462-1-arfeliousheres@gmail.com>

On Fri, Aug 28, 2026 at 02:51:39AM +0300, Arda Doğu Ari wrote:
>When adding support for board 8DD6, &omen_v1_no_ec_thermal_params
>was passed as driver_data instead of &omen_v1_no_ec_board_params.

Hi,

When I added support for 8DD6 [1] &omen_v1_no_ec_thermal_params was
indeed the correct quirk. But because Radhey Kalra's board-specific
feature data patch [2] was accepted first, my patch probably lead to a
merge conflict that had to be resolved manually, which is why this is
subtle bug got introduced in the first place.

>Because active_board_params expects a pointer to struct
>hp_wmi_board_params, dereferencing active_board_params->thermal_profile
>results in a type confusion bug and invalid memory access. Update the entry
>to point to omen_v1_no_ec_board_params.

Thank you very much for observing and sending a patch for the same.

[1]: https://lore.kernel.org/platform-driver-x86/20260623141314.33947-1-krishna.chomal108@gmail.com
[2]: https://lore.kernel.org/platform-driver-x86/20260615091034.987029-1-radheykalra901@gmail.com

>Fixes: a7320d6eb9c42 ("platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Arda Doğu Ari <arfeliousheres@gmail.com>
>---
> drivers/platform/x86/hp/hp-wmi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>index b2773fc1aca4..615b4cf6fc45 100644
>--- a/drivers/platform/x86/hp/hp-wmi.c
>+++ b/drivers/platform/x86/hp/hp-wmi.c
>@@ -337,7 +337,7 @@ static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
> 	},
> 	{
> 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
>-		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
>+		.driver_data = (void *)&omen_v1_no_ec_board_params,
> 	},
> 	{
> 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
>-- 
>2.55.0
>
