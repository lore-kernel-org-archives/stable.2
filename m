Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551237;
	b=TF6tut3K8o40LYf1bUv4SZ+foxSk1VZceggp43raAwnFEyJrdOL7mHFFLbFFdyDWWjBB
	 m7ihcfJCT17ct91O0Sx+G6s9PNVCEsAMX7tyLuM+BrB7weOZPf+lb17Y/2NKx3fTH1Pbd
	 jJfe0hSrpNBAgmC/dXIXq5Hcnh0DFEurNR4rk5TlzpVB9FAwsvcoRVhXbelP0Xhjkme+n
	 bCxAoh5D+cdzPQPFWJBzlX9ETv/5i5LE1OlbqrwG/dGiBCeaslMHgBkFlwheZ0yeTfmhH
	 w40CyZCqavXpsdyeS1MqWs+JXER8IZav1UwZJaIbGI9KzNGYTciJxStjsqkUuNQHF4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551237;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=gi6zvmo29Lhp6QPo1Sy6Pqw0tG3SiUIqhQEhH8s/5Vs=;
	b=DM4zHiXwvJ2LQkzWxA0z3gJsd6cYEpdP3jnQ/H5EsE5K+cER3dRzK2PxZ4W+EUIvlNPN
	 GWvPyh4N2JqrxQExJNAeNjS16duXHsBND3UMxODJ1DGRMS/LMwz9/Q0j9bn9cHgvDTfuy
	 IRH+38N+hcKbtrjOYd/WUOKNab8alZh2LbuYbcNeZxgyR927rDFutDjJGgN3C3xYPYBCn
	 +lc6CAGxd4SFXK6JRHFOIFRrpI4UCKL/LCeDoGUtkXKCmTvxVfbJeGLbQt7YC0/xztXYx
	 5g73og1M3LuHNMbs8dTIDtr4L/FzacUdpC+tcR53Fne+pd4xi7Txh0UJ+MdHFgqXidQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=F2SWJf9P;
	arc=none smtp.remote-ip=209.85.217.98
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38753606A338
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38753606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=F2SWJf9P
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so2063507137.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551236; x=1796156036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gi6zvmo29Lhp6QPo1Sy6Pqw0tG3SiUIqhQEhH8s/5Vs=;
        b=aNomnEa5od36sGZSUkBmxwPSVXiw+gRdBifCF6R/m+Ju+1Tx8QQwuH2HfkO2UEwjWy
         do1VXXZUoROPfx+23tIAzVVZxv82pmOVwCaZXoK1Z/Bqsn8qWfgCBdAz1EzZ6r+naX6i
         t9tlvKNrp/5v5KIrFbtJ9n40wWRVNO+3H361CXURQLK0lkA1qhThtYsNjsv2gPtd2sBA
         0yQ/QoHaxS0Tnn0AK1GbzATF9V/BL4Oo5gQBcejlEtOUO9N37q/9LS3Z1bg8jrD+EuJ6
         tfonNsqV42V8n9PaIhCk9fA5/K7Tq3we1ChfIoWUG8y/lyHqKU+eS1oyq4vPaTRXzURj
         FWTw==
X-Forwarded-Encrypted: i=1; AL+hErHxn2FVH4OilAiLdJmuH+gGLGO88LLlTk+XpWURp+BmoNzuvLeDUcTb8iaF+MUWS0BOTKjAyHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Fn1p93PUD6WBN3dfE6roFYbGYjgCuMicH0Ecg0Nhh+b3Pj5ts
	tPhqsXNE/qLnUmFRMEjmx4E2FO8auaQfQUddM1MLfPr7Nex6bqua0npkDyqEfJRqnsA/0W6Gm0b
	x/VUosirVby5Twma+mnuyyhpTeG/Lao2VA0jvQcfpy+EiUTeNVorsZkbjo92zbGlGhjj8DHw3bv
	IOH9hGMbDGljcuSDoaAUruuwCyPUdwRwvIw75uWNmLBns3WyR6LsHuFh0ZMTrHcpZkUsaA01tvo
	sNYtG36vuGM7nRvww==
X-Gm-Gg: AZFdTZcf+FSaHkmZqEUS480GF3HAQd15KSvJ4FQQNFXSp8L/gqMkqoiXVk4lGOkTARt
	828PqBcwMzoBlxVlrfkR5p/foOgReER4bb6VQjZ64XHRttI07nnKKP7Nj18Q4e9NR9cE6BzB0Av
	ybqHgAHqNpkMLhnYcLPqPs68D6c1cleitjByTSyWyx0ncz+jjZrO6TcRsAUUNYyFdCGBozYZR77
	KJlEmU5B2XPi8IJOKW4/4rV0UJwKd76gAoSw0+fwYnaSWV9Q+0XXd4hd+Vb3lH3JaEm4gsW6c40
	FCx+0GkI2bP1nwLRladRTCo3D1E9Wds6BGYpc3XnM/2BDyVwzIi73q75bJ9wwr3TyCjWgxGaLwY
	Hdtb5XPFkBm/Cd/v7BgOFTvz7Blitbaq5cY6QD8IwCrLKK8CSNqM6m3mB2gb7z6f9+cua4JDK8c
	msf29ardzac6n2S9VTI8Tt+3BazvnVF/Mqjju+TOyZwQ==
X-Received: by 2002:a05:6102:5049:b0:7d2:7266:2c71 with SMTP id ada2fe7eead31-7d71e326783mr8083296137.0.1795551235882;
        Tue, 24 Nov 2026 12:13:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7d6e8276773sm122311137.29.2026.11.24.12.13.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:13:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94960bd17b5so810227585a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795551234; x=1796156034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gi6zvmo29Lhp6QPo1Sy6Pqw0tG3SiUIqhQEhH8s/5Vs=;
        b=F2SWJf9PqOmIVjrduE300d7rNnhvWlk+gZC751axjduniQ6Mcy5E8WFcE8sc23gzFt
         dzBdR5GXjHQr+jwQ2ILvjkgCkjxHT8D7GxG9kn9+RdP6+Pw5I4vn3QWr3LEnd+tDDAcU
         JMCLAa7FU9rDO49wzdGg8ac//4ysx7+Of5cdo=
X-Forwarded-Encrypted: i=1; AL+hErE99q/85gIzZF35r75shQcHWUhFwtvWbFb1U0fvJSXaLZwEe9tA1ga+9T4n/20bIL03yqXPLKg=@vger.kernel.org
X-Received: by 2002:a05:620a:6886:b0:947:7f5e:2b63 with SMTP id af79cd13be357-949ba99a9demr2711119985a.34.1795551234358;
        Tue, 24 Nov 2026 12:13:54 -0800 (PST)
X-Received: by 2002:a05:620a:6886:b0:947:7f5e:2b63 with SMTP id af79cd13be357-949ba99a9demr2711111885a.34.1795551233648;
        Tue, 24 Nov 2026 12:13:53 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f5c31sm1133479485a.30.2026.11.24.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:13:53 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Chad Aldreda <ca@modelmiser.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH wireless] wifi: brcmfmac: fix join parameter length in IBSS join
Date: Tue, 24 Nov 2026 21:13:50 +0100
Message-ID: <20261124201350.3495772-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121092746.2917397-2-ca@modelmiser.com>
References: <20261121092746.2917397-2-ca@modelmiser.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, 21 Nov 2026 09:27:54 +0000, Chad Aldreda <ca@modelmiser.com> wrote:
> brcmf_cfg80211_join_ibss() builds the length of the SET_SSID payload in
> steps. It starts with the SSID record (36 bytes), adds
> BRCMF_ASSOC_PARAMS_FIXED_SIZE (14) when a BSSID is given, and adds
> sizeof(join_params.params_le) (16) when the channel is fixed. With both a
> BSSID and a fixed channel the result is 66, but struct brcmf_join_params
> is 52 bytes (sizes as on x86-64, where __le32 is 4-byte aligned). The
> length is passed unchanged to the protocol layer, which copies that many
> bytes from the on-stack record (brcmf_proto_bcdc_msg(),
> brcmf_msgbuf_tx_ioctl()), so 14 bytes of kernel stack beyond it are sent
> to the firmware.
>
> When the channel is fixed the whole record is in use whether or not a
> BSSID was given, so set the length to sizeof(join_params) in that branch.
> The other three cases (36, 50 and 52 bytes) are unchanged.
>
> The double count dates from the commit that added this calculation: the
> BSSID case counted WL_ASSOC_PARAMS_FIXED_SIZE, and the existing
> wl_ch_to_chanspec(), which that commit called after the BSSID case,
> added WL_ASSOC_PARAMS_FIXED_SIZE plus one chanspec again.
>
> Fixes: 69274f020a92 ("staging: brcm80211: Fixed ibss join/leave functionality in brcmfmac driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> ---

[...]

>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
