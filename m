Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBE368D65
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598902; cv=none; b=Uc2bAJFVK8WzPdHcKzuC29q3+DKhBIc1a6ZeaYuyNViNpPrw93VG6dcVIhffljW7PV69eryWMgBPieJXh6lBU+IYAJPuvUmGVREVeM5i2mna6m5mnxkOFxTA2Ha3t2h+FaltZ7/XIGIIsgt0H0TAbQtju3fY81keNLOOS8HcOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598902; c=relaxed/simple;
	bh=CmwH/B0PtnzgfGqG8j8e2Mypnvqls/YlFIwqIJNUr1I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WpnnhAKLIJU7hI9xIOZmJXqdNdimhc3B6AZYPqKjmTTCJV461LrBpI3tys2MQkN9lpDZkUzm5Qp5ggr7A36LJyHgcTxtg0NVk14912nbgH5dO6AyD49JA5HEKlO+i5zWXTEzT14jtGs2Srf/9xK0kyMkAlRmPwFc0f0kZY94Wgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrvXjHlX; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrvXjHlX"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so90491105ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784598900; x=1785203700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ffAaSrXTHoX1nF2FpytraIRkGW9osx4fNIumZb54aqE=;
        b=GrvXjHlX96cF/nN+KFdLoOZ+fxYBMYUTIhg9gYjxgWebsenRph3E6QaqDEVcsxkD7H
         pbf26lyy4Ow0i+NU7fvww839p9SDSG0hTVjU4BG2Qp22xnA2FG0cAJx6ueZDIB9eU1dX
         iOk7V6/C656CHz7euR7a5Nr0nbGLSXkUelY0a5r4737aHnhE7l71jY2wjrz5uEFzHYCY
         iEDNOTHAVFRDj5EiUZEXllqhPI37cXxQMHd0puUhizsWSp1jgVFOWCj4eELcHO54gL4/
         5sPsGV/V1FzTUWhOW7YCyPIz0PopymVADdfN7RBnLOUsNejEPve8JabGaEHSXCpmX9kp
         9P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598900; x=1785203700;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffAaSrXTHoX1nF2FpytraIRkGW9osx4fNIumZb54aqE=;
        b=SPqhw7Ewj7sNuM8/UNv4q7ZG9R3Ltah001coVFa50JbofkaIcFjYnlGpeO7Tu0WEY0
         lqyrCy98JWFPqVNv5Y1ESDm3t3+hyFllUZHJBNzvW0T37PmhYMp1D8QVA4DQvfJmW7/I
         yruheQ4SaxxQ4ATVe+cFOa3Pk1gI3eWh6o8JZU7504F+vluaieAZ3P7WkWq43PIaYRD3
         S7OVoObxG/PbuP2JWGmm9ZBr6sl0hwmI27IDR9Af4yyC3I0PX26PfF/IpGThjiDw3TzO
         bWTodHtY0ARKaLkTSiH9CjLXGz1eEFSxS+I6tI8A7YMCx8LhF2obp5Yl/M4+EPxUteDp
         s33Q==
X-Forwarded-Encrypted: i=1; AHgh+RpKYrQLlJOfarh6xGGyVtoY2kkkOjLg2mmnQg9DwWJGqgvoSZPK5Yxy/ZVdmQHIXNAm3EGUO2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+8ju1DcOF/xWVA+rePBfXldRdXGFgk2wMfO7hQs7Fdtimqa9
	bBIdlev4OWlbe1sWJF5Vbt4tCHGByKATMyujJnQaGOf2bMEiNCa8LvEd
X-Gm-Gg: AR+sD11oJ80lq4m1U21GvkfsvVAJaYXF6qE+cyQYnTWwS/EH1zbne2S7hi8p+l6bvJi
	i4NMg9dYDCsxsgmUHlMBNQZEjauFfVFJejYDOJ0wstB8UAZhp8sRgfMqqcsjllG69mEIBsq98j2
	YI0lhQhqDhJ5FN1W9aRo1F1cmROVy919IGPgxHqOl8XWFkpa7E4rsg1X+CkVF95oHAh3S57aiPI
	cVEsQgXDqBxz2pYYSRQ5nUd+PEy57xuUawNLksmzKs42lTmCkDlMxGehvWaHLdnsRd172cOFx61
	+wktSqtDwzaZNYECl1X1I1M3eWdS2+00ptf38L+bzBWXCgovVMJPKoLR9oxJtp8J0hBOhT9oAKD
	Q4DiVLUWpWiICaPjSPIvNoA/h7sFFDdjoq5sv3r1glMLukB5D7jZ4SzWU7aKWcdT7HhBUlVNRnC
	M=
X-Received: by 2002:a17:903:3c4e:b0:2cc:9179:335 with SMTP id d9443c01a7336-2cf3481b661mr171881705ad.8.1784598900381;
        Mon, 20 Jul 2026 18:55:00 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2603:c021:8000:9500:233::14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1ef8sm68539495ad.21.2026.07.20.18.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 18:54:59 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:53:53 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
User-Agent: K-9 Mail for Android
In-Reply-To: <20260720172433.77b83dc7@kernel.org>
References: <20260704214808.1566710-1-coiaprant@gmail.com> <20260720172433.77b83dc7@kernel.org>
Message-ID: <7BA9366A-3243-4A46-BA8F-BB170C8AD912@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 21, 2026 8:24:33 AM GMT+08:00, Jakub Kicinski <kuba@kernel=2Eorg> w=
rote:
>On Sun,  5 Jul 2026 05:48:08 +0800 Coia Prant wrote:
>> The driver calls `pm_runtime_set_active()` before runtime PM is enabled=
,
>> and before the clock is prepared and enabled=2E
>>=20
>> This causes the clock to be unprepared/disabled later in the suspend
>> callback even though it was never prepared/enabled, resulting in warnin=
gs:
>>=20
>> clk_csr already disabled
>> clk_csr already unprepared
>>=20
>> Fix this by setting the initial runtime PM status to SUSPENDED instead
>> of ACTIVE=2E
>>=20
>> The clock will be properly enabled when the device is first resumed
>> via runtime PM (e=2Eg=2E, during MDIO access)=2E
>
>Seems a bit odd that this hasn't been discovered until now=2E
>Could you add more details about your platform and maybe
>a hypothesis why we haven't noticed?

Hi,

I came across what looks like a runtime PM initialization issue while
using pcs-xpcs-plat=2Ec as a reference for the Rockchip XPCS glue driver
(drivers/net/pcs/pcs-xpcs-rk=2Ec)=2E

The current code in pcs-xpcs-plat=2Ec does:

    pm_runtime_set_active(dev);
    ret =3D devm_pm_runtime_enable(dev);

This sets the initial PM state to ACTIVE before runtime PM is fully
enabled, and before the clock is prepared and enabled=2E

If the device is later suspended (e=2Eg=2E, during unbind), the suspend
callback may try to disable a clock that was never enabled, leading to:

    clk_csr already disabled
    clk_csr already unprepared

On Rockchip platforms, the CSR clock (PCLK_XPCS) is required for register
access, and this pattern seems problematic when a clock is actually
provided=2E

I have a few questions:

1=2E Is there a reason this hasn't been noticed before?
   As far as I can tell, there is currently no mainline device tree
   user that enables this driver on a platform with a real clock
   dependency=2E Out-of-tree users might be using it without any clock
   at all, or ACPI users might behave differently=2E

2=2E Should we select PM in Kconfig and drop __maybe_unused from the
   PM callbacks? Since this driver relies on runtime PM for clock
   management, it seems odd to allow !PM builds=2E

3=2E Should we add a =2Eremove callback to force suspend the device on
   unbind? Otherwise the clock might remain enabled if the driver is
   removed while active=2E

I'm happy to send a follow-up patch addressing these points if you
agree with the direction=2E Let me know what you think=2E

Thanks,
Coia
