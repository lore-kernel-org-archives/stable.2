Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256273;
	b=l246O+GEOChasESRC8TJNybRJBw+9JlbJlIl7wXYoOgoqhKsIwcPxlUj4nzrJTCEh6w0
	 qJ9oWyHCbiBDUtDyVDwYmv5V/slOslIdvj9KUyClq8KwESw1SI7ryC3YtNnqYAhaU7rBm
	 IcJZH0Jsm7hKAJLHCZ2mljy1Q3l4zOyTapLVMImax/bd9wEbay1zeN6ESKW+UEneSKd3B
	 OTZ9WlumKnuyYeMGZFiPQtqfg1bv3Vzv+YmsBJnh02HtUI2x4R45Es1ivYwQR9UMN6AZW
	 RHm3obK4spEGa57H4zzzHNRITzZABkPQMnt0UzHABpeMzpd1qDL3MX//sICGVKrSygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=CGM/3+U6P/3Ix3u1vwt+zgurCpv7ig5u/NcOCPf3TrM=;
	b=sezReh+cm6BkVUJIAxX8OaK3wmUklG3QNdN6mIgpq1G5ZhXKuqALQTbc1094O7nky7Lz
	 kEWo/9sEQz1JiTxqdaw9rZKtI37GiemgcsyILW+vpOjuj349aMYU3G+NUFRAvgM/cgDnW
	 ZeSMK/YhF67lrWABeRQnMCUwuOX2jEtsQZRrIiCDWxSnec2PtVeQ/PrzK9+kaTL/HLuen
	 aE7KGhQhEn91otZHqausSIe6IyV5clyZBSn4fl2nthCxBjvrcZ8IL+6PTZx4PfPRGZuBu
	 e9IdbtHJEXO8mKVUXkrJBzA2nX/xR/7y0oWNwIz41sdXkQ9si1zVtveu6lizLgPTJcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5OlWEoZ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4180606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4180606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5OlWEoZ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso879358a91.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795256272; x=1795861072; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CGM/3+U6P/3Ix3u1vwt+zgurCpv7ig5u/NcOCPf3TrM=;
        b=e5OlWEoZb92VIfI4w0ixhqrsQyV2A1MVM2CjecYEPNZ+mzk/aaQMjPGZOw00uv/FcT
         t647KEDokcKq6d71R4DEsRtMLC1jLkJUJrpNOgMA9SNl5ui246wJpMlX8LvjqmsDlSML
         QbfFEc0VtrxixmDUldXP9nvZFGMpCV0EJaqepZh8f1dVsQCNA800aebvL2qgOSG8QXq8
         3Fs0q4sNbfiE+Pv3YQ38WadZVoMGpTJMuBMmlfgFnHV74ZduH69SX2wgZWEzdPYquuCs
         S/v6Er0Jnod7eNFMY3vN7puAXlHpqvPMsHrNoDYXs8EUBBDzYtX1HEONs1iPi6ha5NGr
         /Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256272; x=1795861072;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGM/3+U6P/3Ix3u1vwt+zgurCpv7ig5u/NcOCPf3TrM=;
        b=q3p/qd3CY21NPhBQvXOXnQJShq35zKo9RunfGuJk59a9S6s79BMNJC0tX73PK+uPt2
         /Tt9fPrhheDH6AhU70IrMDRzDeDcYhfKlw3y9EiZCjqknHrI2pCfGfPkvsAsmTi3tpD8
         5FatdvqR+Jdbux519zNxqaeSxC1aT/4Krn0eGykT9wUWhKu6WKhqNoiztIGJZOsFreA+
         Xsyq9SGxcSewtl/ugjX1V2iD+K00DHLs3TQbZMo2mxiY6jmx+e6cI5ex2ovgmY9OAnWZ
         o50wzuqbwSYWCJXQjMosuhFkhTplUnKKnyw3dqOVK3ZOZZaRSmgsw9Z+QSTP3wMBIIFa
         SsWw==
X-Forwarded-Encrypted: i=1; AL+hErEzEY1bDzbr23n9Y89d3685+XmK4keZP6CD35PfSaVHzpEvS476GQhNVrl58fe8kwwDGr65T2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xqhyg4/JvmDMa/vaPJ+ClIrp4idTWa5nv/TIhTYZuyjN+Jstt
	YHqYmMzNpLK9aIaaRdNJPe8So371In4YBb8Kla4H6jBPlWxIJ9ngXW1+
X-Gm-Gg: AZFdTZcXkRRrwKMhPaRBjAUGGxG2vEj2A8Hz39ayJQv7NpoLUyCJVZj9tFCvmcj4a+H
	+Prhw8VbKYMzI6TUWq9Fw/5prOT2i+SSYhEQDgKwW9IW5718oCSiW2ITyRvQdkd1ARgdc/EXp2J
	Yh/HzkGkVN3ytiRUw8mZq8fQbYVBs/iRQk3JOr6n4POjka35DLkpOjvEd4/0qZ3GWsvf21/Rk8i
	xJm08eV3qUtPU9PVQ0/rd0nO50obnLBTn6UG6adhXmocqerUuHGarScgJD2IYJO39JIkLgm2QTq
	Ng9wWrsqs24/PxQWtIsgOpu4A1tgmjpkA2Qd/zNU76m0uo/gvyUWyMD1U15q1q9KJpof/7VtsFB
	mwAKtlqdgQTOeztHapXIyiK0dydJG1Ujj7BJoQjXHyLIbUvSBLhH9v1mvU58Ex7m70LDXNeyB+y
	N0nEWtFMKemtzhD7x5soS5/t/7MXEotAr132cUB4HfUsYkZeA5TNNbdbmL29lCO5McKdqU0ExFB
	xSXTo8avGOKdg8J3coAI3RSpqPZlfHWyCEOHTjnQDJLZ0kXgSqM/PlF5XU2+sjCb631VLvM/X5a
	2vX84vCyxN6VefgSWODvjeP4dazEoNtZgaTsLNyUFMmJj0Em1dB/lxDUiX6ocDJj8uSsdPJrO2/
	js2BE9lY=
X-Received: by 2002:a17:90b:4d0a:b0:3b4:1352:6ae with SMTP id 98e67ed59e1d1-3b41c905981mr4992815a91.30.1795256271992;
        Sat, 21 Nov 2026 02:17:51 -0800 (PST)
Received: from reply.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm11859916a91.8.2026.11.21.02.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:17:51 -0800 (PST)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
 David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
 Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com,
 Mark Greer <mgreer@animalcreek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?=
 (The Capable Hub) <u.kleine-koenig@baylibre.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thierry Escande <thierry.escande@linux.intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH net v2 1/1] nfc: digital: fix use-after-free in unregister
Date: Sat, 21 Nov 2026 18:17:30 +0800
Message-ID: <20261121181730.58295-reply-xuyuqiabc@gmail.com>
In-Reply-To: <20261112151208.496636-1-horms@kernel.org>
References: <20261107141910.549465-1-xuyuqiabc@gmail.com>
 <20261112151208.496636-1-horms@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Simon,

Thanks for the review.

> [Severity: Low]
>
> The commit message presents this as part of the unregister fix ("handle
> its MD listening state in abort and shutdown"). Does this abort_cmd case
> take effect on the unregister path?

You are right that the unregister path itself reaches abort_cmd() with the
state already at PWR_OFF. The MD state handling is there so an MD listen
cannot outlive the device, and it also changes the normal stop-poll and
suspend paths. v3 describes that explicitly in the commit message so stable b=
ackports
do not treat the normal-path behaviour change as unrelated cleanup.

> [Severity: High]
>
> Can this assignment overwrite an ignore_timeout =3D true that the IRQ
> thread set for a timeout handler that is already running?

Valid. v3 no longer clears an ignore_timeout set by the IRQ path: shutdown
and abort only set it to true when cancel_delayed_work() reports that the
handler is already running. The handler therefore sees the flag and does
not deliver a second completion after the IRQ has completed the command.

> [Severity: High]
>
> Can a timeout handler that is already running still deliver a
> completion into a freed digital_cmd before this point?

Valid as well. v3 marks the command complete before invoking the callback
in trf7970a_send_upstream(), so a timeout handler that is already waiting
for trf->lock cannot complete the same command again. The timeout work is
also cancelled synchronously after shutdown and before unregister, so a
handler that was already running is drained while the command and device
are still alive.

> [Severity: Low]
>
> Do the in-tree implementations follow this new contract?

The contract now allows driver-side removal serialization as an
alternative to doing everything in abort_cmd(): the driver must ensure
that no completion callback can run after the command is freed, either in
abort_cmd() itself or by serializing removal before calling
nfc_digital_unregister_device(). That matches st95hf's rm_lock/nfcdev_free
scheme and trf7970a's shutdown-plus-flush scheme.

v3 has the fixes and the updated documentation, and is now sent as a
new thread.

Thanks,
Yuqi

