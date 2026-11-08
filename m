Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138039;
	b=hm3MguMtX0xvtuD8aRp5T23ujyf/5kpUtadg3BtBZOQ8IlpRs7YT50E1Wb3c55rxqQhb
	 uVKOMlEJwuJLLaILPI/DMndRO7os+N+QE4dLGWMC/ZdWxJBIDMed21J3H7IW+FLT30Jwk
	 5yq6/Hwuoa3h69d348XmOhNLv8RTufjMQCsTWCbLEuR7fh5enHE/wiamp8Cw5s5PaA1aZ
	 q5tw70PxOiFY5UpN7RkDMNOAY6/TPVvhlhRAA5cdBSoqpNtPUVvdtVYdndnmhv074tq41
	 iB4DpM5JRS5CJNICC1psyT5YE8NwvKqFERcy706+FyjHzCMF08qlcqQ+D/7NVsMVBMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138039;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=zLnKlf5lHAvzQF0wN1jYdHTwzCKhgXL74j3WS82GZJ0=;
	b=sPRAoVrD/Q/eVNn7ONeDVt4xf6WFiFHrysXnGb54UNOU9xw6MNgWKWihlLyBXN9cYo18
	 kDhz2D446F2I4LlvEmM8AGbioRoxpN2udjAfLjO/vrdZ/nt6xOHLbDERDgmK5mEZvv8N+
	 ceYl8m9PD7ybEKRcycFRZbmiRFNhEc/hjQQ4j6Iw4t289f4YbllXH8OO4NFKAUfViAbhc
	 553EU6VtlyGdV2wX4OVSsEfr3AlzYJmbzniOtkIc7G6xx1fsCLZsqMMai+xgAerPjxkb5
	 pASaAF/yi0VvjmMVJv9E0ynbc0Ni2c/0LtVUfQiNrx213DiMgwT4YiY4JgjlfciioNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bzWwwVJz;
	arc=none smtp.remote-ip=91.218.175.166
Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FC606A323
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 191FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bzWwwVJz
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XewC+AgDeBK5Mip4i3uoUqEy860yN1DThXK/zmNhZtw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794138035; v=1; x=1794742835;
 b=bzWwwVJzdzSbxDiZBI7bEp6Ju9RpcTUkjogjEWDnWNv4j+abYvcgLmAVjkTsMTDfjNgGgO1Z
 414A7ReSw6itYUAyJ43Hv/w7BcAXMRnXiMcMej4SDLHjGjmcdGxE0czTOF0w8EeEmirT3GoHg0D
 Rw4NBgOnvHnix6v2WQAhV0wI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a2ca078a8937925f;
	Sun, 08 Nov 2026 11:40:29 +0000
X-Mizu-Trace-ID: a2ca078a8937925f
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 08 Nov 2026 11:40:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Luka Gejak" <luka.gejak@linux.dev>
Message-ID: <ef3bbfa6d9e2fc45c565c3a300da7b0fbd83d21a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 1/2] wifi: rtw88: clear RTW_FLAG_RESTARTING in
 rtw_ops_stop()
To: "Kalpesh Solanki" <skalpesh942@gmail.com>, pkshih@realtek.com
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Kalpesh Solanki" <skalpesh942@gmail.com>,
 stable@vger.kernel.org
In-Reply-To: <20261108085126.331784-2-skalpesh942@gmail.com>
References: <20261108085126.331784-1-skalpesh942@gmail.com>
 <20261108085126.331784-2-skalpesh942@gmail.com>

Hi Kalpesh,

Thanks for the new version. One comment below.

November 8, 2026 at 9:51 AM, "Kalpesh Solanki" <skalpesh942@gmail.com> wr=
ote:

> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/ne=
t/wireless/realtek/rtw88/mac80211.c
> index 5e40cf06a9e3..7c86da9e9396 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -67,6 +67,7 @@ static void rtw_ops_stop(struct ieee80211_hw *hw, boo=
l suspend)
>       struct rtw_dev *rtwdev =3D hw->priv;
>
>       mutex_lock(&rtwdev->mutex);
> +     clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
>       rtw_core_stop(rtwdev);
>       mutex_unlock(&rtwdev->mutex);
>  }

As far as I can see one case still doesn't get here, and I missed it
when I suggested rtw_ops_stop(). If the restart fails in drv_start(),
local->started is false by the time
cfg80211_shutdown_all_interfaces() closes the interfaces, so drv_stop()
returns early:

        if (WARN_ON(!local->started))
                return;

So the flag stays set after a failed restart, which seems a likely way
for a recovery to end on hardware that is really stuck. The next time
the interface comes up, recovery would stay blocked until it is stopped
again. Maybe rtw_ops_start() could clear it as well when
rtw_core_start() fails?

Best regards,
Luka Gejak
