Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836368;
	b=RaBvCgmXCFGG0QqIJSIW0MxGsXzrAD7SGYpxF4sm/w9G5AfVNg84Azz3YGq5ezxFfErm
	 QUAgrB/L5/lMvC9BVhUs613Z9XYrVPJFsWxTC9GDrqHuYof7Tn/dluJzCPJBKXgcCz8H0
	 35X/cwD8bTn0NqDhUvfdegk67MtgRbc8kXlSxnzF6/JJQ5XyW4zgVqjYKqM4Ceky+eCSE
	 2ZEfZOME/P7GNVVgkIUC1SCtaizyIhgQBWm3moKG902753fS2HoN8Z1zbsuLbTPLIaWTZ
	 svJ9fqHcB4rGKuOBy94NvvL37jcAXoMeE/Z9yZste5+ZO9QCPN5vCXYA5dVRNknpxKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GCBkedzgVlQqMi1kz++iUtIpIacOFXvDUza6lGua/T0=;
	b=3IFwWKbhiZhN9EbgV0iUshvmVFRf5tOdSFu+7zfY6UjwxgtR2fyd+6ZP6zcLYUygFqf3
	 o3WpCnF+82UlXPsyxbx3KzjxmrTvcYgaTHVhgO+mfCzW1xvweRRXQuWfyrV1lNBMl86ez
	 l3BFhwX04bYt91JIXnkhYtHEOmdCLIZkVYnpgpPqT8FPLk/az4BOxfahoTgWhBYFGmzx0
	 nSY1VKrKIBmXNJC+LY0UYpEiXJo804ZCVUU6JqFQLpXrTlvALPBBIgO5hGU9ntLAEPDNY
	 y4KKbK3Gm3XN2RQLWo6E2Pgr98zR+B823iA8MQpw/keLlE5xtdlefJvez3b49Fs0yjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APNcuOLA;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7D606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C7D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APNcuOLA
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2850889c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836367; x=1794441167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GCBkedzgVlQqMi1kz++iUtIpIacOFXvDUza6lGua/T0=;
        b=APNcuOLANR3tXkFYFrqmLoAVFs9VbmwMK/1tF/C2bbYpl15hrlGP9+jh8MHtqM41Xs
         wX+ZSp9Y/3Tklu64K+XcpQQUro2nztcBc6Q394I4u87LUdCImgwSEFQVr2qAvdYnBPtM
         Cu2C4HKZseSvAcqJNy+0ZYjREj0DyjWd6qdAkGOfjmT6AdA+Z6ASOtrF0eMUC85aHhAh
         S2HlDXsFrSfvY9obHVU+CX2YdkXbcz+TdxsmYflz247QFwgmMcGNL1hwKsqDKMSlwBP3
         mMcsMcIr7FmFC6EsKeZbFotAEeKF8iCsOhcgZwIft+Edp0A7rGP9iIDDN1sW6kMij4IK
         H4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836367; x=1794441167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCBkedzgVlQqMi1kz++iUtIpIacOFXvDUza6lGua/T0=;
        b=rGxb3NCm8Fht7kFL0PPh/pY2Ah/mZmsoJVsAOUho3vaVP4diAtSkaQhYLBL8BCLo3S
         zFvH18ywNerWtCGSeh3/7NE7KjW5hp4dj8ph7Q2HF6y8nsT9IHqU8hFvsGy7XOdSws7i
         0rPK7MqPCV1NwU+WUqf0CQ7FMRyWZ6HYU3jzh0bAK/jR/Wmnkk0ZWj6AEu9+MuzH7Sbe
         adqC602rcXWXaT1z9okmf6ttVsCOk6C8Afsog9JYjIGt3WBoVUTOm4CDi2GSInF+q/zI
         v4HMLEJJ0pwsumXrQy2ZzUN8LKDtS0GEcXi59d/pwqevhHhUFCKQS40IkB03bzp17T51
         PDKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNOZxwgizHTM3CifYeTHmhGR5Jd4RrBWENUPeFwPf9EzuDN8DOrRm6681GPzPsIAb0wKCII00=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e7EhaFGlUzgEzH71aE2N4KGt8cErqPe/L7ihrKBPGdbCDLSqh
	iUxaB23lpXCMDmol6URlpr5V+Shx+mYaDa1QVzmR4JppGaeXqvjoSpvR
X-Gm-Gg: AYBFou3PAZqDrHw6d8V+c66JYmWI88OA1woLTBP3w2l00dZNdyFCeRMlpyqkzmIcq3Q
	CY8DN7SneNGjK0bXWSptxZdYtM9CNjjm2Qa9Ej9N8Fsf2gCWJ0IwS4NY/7+tQlmgkwiBYuFp/fl
	AJLPUFIlKKDpbHouXVidwQMLZRl2MODuYC1SiDHH4VKyZ5bVS7eWhIetdFvRLXAbKuCxN/HZDe2
	3mwEjvbSc466vb5FhGsBTIJyOwfotgAHbn+VR0hfdEEXjpvmED6VMSFChtO2Bz1BSa5b8/XHZmd
	yVUxAxcbSW9JgL8T/IR4AVQ1PE1nz9WzVh/fRrPJm5b7odtpbpdGK2xHFm5zLUij6GcgRVML1h3
	cNhRFvFhE9qhYpFHLM/O+MLe9OgzxSgVvSACWP7AsYAp/dEh5fAjR+TgUKQwmOBdetKzmnvU80g
	Ip6bO3ParAb7i78bXtF+04HNYJsF/g0E6bpsYU9jxZuBfR/Lte/w2Zwcgw7jsJole7GBFNlyNgT
	PMcJFgunGRCJ1k8wIHsy8ReSWKAxJCuUnY1bqxFxASA3DFPLvWYBHlV0StrTcla/mbXvYnBDLPR
	Yo9TGCT+m8hn4Wj6+u3KeLYhRogFKYviQw2bcx5eCbateyfrnULJmKOMb1cWNHbxgH3t5zyjNs4
	3DlvLpefCE9NEa6c=
X-Received: by 2002:a05:701b:428a:20b0:17b:fed6:7449 with SMTP id a92af1059eb24-1ac5da7725fmr28530265c88.47.1793836367131;
        Wed, 04 Nov 2026 15:52:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm10107500eec.29.2026.11.04.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:52:46 -0800 (PST)
Date: Wed, 4 Nov 2026 15:52:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: mt6779-keypad - check the reported row and column
Message-ID: <auvFSNx_RS60_tO0@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-6-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103084135.426629-6-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:33PM +0800, Guanglei Zhu wrote:
> The interrupt handler turns register bits into a matrix position
> and indexes the keycode array with it:
> 
> 		keypad->calc_row_col(key, &row, &col);
> 
> 		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
> 		...
> 		input_report_key(keypad->input_dev, keycode[scancode], pressed);
> 
> The keycode array is sized after the rows and columns the device
> tree declared, but neither the probe nor the handler checks that a
> reported position actually fits those dimensions. A register glitch
> or a matrix smaller than the hardware's fixed layout indexes past
> the array and reports whatever sits there as a key code.
> 
> Skip positions outside the declared matrix.
> 
> Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
