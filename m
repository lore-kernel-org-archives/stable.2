Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208316;
	b=DGLGkBVkE6Awa2QB5OVjuHbfijAwaWM7qhFLWIlXz7IbMvU6k+MEaAs1J7Nm9UeHX0E0
	 Qy8uEMukZVh7qzRzBzvyF1rc3FXfnXc6L6mbbW9O/IvvCscFLqgb9+aa4RkHCZARsWjTD
	 AdEugIDdJvl6RomVaF3Z4ygh7qK2oFoaxtMhaPtoVxGKfMJPr2okwkqgPCVMMW3KbFOWX
	 7kfEVuaojqxzfwwP6TGDdaPSmEbkXvpsIPbpc/eXGRPtBWfMjh8C1cSSQvGEf52CRv0Od
	 4DpO4sTBgf6A4lQdVZBVAGzr7MAsVJ5Owhs8TG5ts6XUaqndOYGA2bd9smgSj7xWMFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208316;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Efpu2m5sUCkdtOy2mV59c9dnNklW/tHHx/bjnmS0jw4=;
	b=PCIe+SQDlq26LI/YcS5FaV3UDvT8Ju8K9WgtX+2n/Ra99YI3fPm5u5OVOL8R+aBLMFik
	 n9RtfVhivMD6rbXSOWVi/sIqkyJiB0FotCPayL2O6kr9k+mBM5wYW9+q8O1jpuap6f+yl
	 fKZciLqAkudib5Af3Yi//Rh15RSzbiNJ4U9wN5BnIdjbIAmp9h03ipPNY5mvLQxCXrApY
	 KIP4fMd2dNUtaFTGt2t7gOXhNYeQbfZhnQmF+d4Vcm2mguRYv9JTyE5PuXYupuj2ucwBW
	 YeKEGDT3FjCI0ZgWQmnjZnccUJKVRzJx14b9bOdBqYpjvl2eSOuWPvAVDNlsGPPii0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DpSB5oM+;
	arc=none smtp.remote-ip=95.215.58.76
Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6652606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 07:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6652606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DpSB5oM+
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wpRI+2GrIdAPSLZrCXpsQnyv46ZEoGtZdJa6JUTIvvo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794208313; v=1; x=1794813113;
 b=DpSB5oM+KG6vva4r4fO5NTSKG8V+dLgn6FFKBJdR8I6lRBjm98ebMxSuTwld8rSE0vqeB5Gf
 TrF2taRHuMz4gef7v0ZtLxPmffIr6K9Gpk7UdxGtj61eESGUJrLP/yN3twLwvxN74lcPQr8RCUp
 mfYte1q6HTakYvWOgv0vODos=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 583b959740c77b18;
	Mon, 09 Nov 2026 07:11:53 +0000
X-Mizu-Trace-ID: 583b959740c77b18
X-Migadu-Flow: FLOW_OUT
Date: Mon, 09 Nov 2026 08:11:51 +0100
From: Luka Gejak <luka.gejak@linux.dev>
To: Kalpesh Solanki <skalpesh942@gmail.com>, pkshih@realtek.com
CC: kvalo@kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/3=5D_wifi=3A_rtw88=3A_skip_al?=
 =?US-ASCII?Q?ready_reset_station_in_rtw=5Fsta=5Fremove=28=29?=
In-Reply-To: <20261108142708.489067-3-skalpesh942@gmail.com>
References: <20261108142708.489067-1-skalpesh942@gmail.com> <20261108142708.489067-3-skalpesh942@gmail.com>
Message-ID: <83E3139E-BE19-4EAD-9BCB-6DABBF8D1942@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Kalpesh,

Thanks for adding this. One comment below.

On November 8, 2026 3:27:06 PM GMT+01:00, Kalpesh Solanki
<skalpesh942@gmail.com> wrote:

> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index f7708ad17b6f..a74f199a93ab 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -384,6 +384,9 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
>       struct ieee80211_vif *vif = si->vif;
>       int i;
>
> +     if (!vif)
> +             return;
> +
>       cancel_work_sync(&si->rc_work);

As far as I can see rtw_ops_sta_rc_update() can queue rc_work again after
the recovery has reset the station. If the station is then removed before
the restart adds it back, this return skips the only cancel_work_sync()
and rtw_sta_rc_work() could run on a freed station.

The window is small, but maybe the check could just go below
cancel_work_sync()?


Best regards,
Luka Gejak
