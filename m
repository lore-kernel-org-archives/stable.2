Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795518852;
	b=h5mockBuLLfpsdnP44K3cuP08w0LXFy9XxtIz1mnUrpge28HSwRRcxwgKSqesYUVWtGX
	 tRWTANZbh4QYg7IjxIDOlEkokQWE/Z32J6dPlar2dI93jIpPIbmHPRHrU+aYQMbgGQV+J
	 4/3mU4RgqtWLmA2F6HNvwLWrZQWEysPQoiwGxAruqn6A/ZOG4asrdkgnVTJYZqE6prlyX
	 3j1e53OttoLKhgEGCX9UORTJIZTdvhjAemSEb8fnXxy9UARMkFuRNvcKcygHzkyDPza97
	 iSMHtvmjEaugTdgyb4GhWr9gWHKeLnb8jD6QiKB3zseI3IwZ1jngxpt6p7QgCC5/pdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
	b=GTlnhM5ZTXNgisdhHL5JHsbf0BsvzZR5mSxCf3lcnF2Ue34teyQr3bnFYIWncCQHdhFR
	 yGAn+zBKwDUnTZbM7aNHmKxZNrB6TSse48rlRcgDtN+kPXkqFh+DFFqObjcY1tZT77JnN
	 6e4Ocz37aBQUTweDijcoykPoVFu1q132X1oD9Ia0ya+OfuSagRTTlekOXeuFiGC54WsRG
	 b45E//bpGXLC6KqN4vNVmr/3bdjoNYqjxaqn5QJdsbDereMTRRFXdd0YA63s62ineo0+O
	 Dd4zcen24koKKIdQzidA5yGg535hpwJxkDE6mWoL/GApyK5pOxDoVn5Z9H9mhy2Mbmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b="h/p4yZ02";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD9606A32E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BD9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=h/p4yZ02
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9496473b511so524142185a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795518851; cv=none;
        d=google.com; s=arc-20260327;
        b=RWM1Ls7jwVZ0/r4zwnoW2mBHuO2+MaVV/BjB6l4VQ5UwW2AxJ72y1Z7wpinWMIDkdE
         OEgxy6u0LHZf3LtdzhxBlsn6cvGrtnik+NIGpcNhHeWNCMahYuSOxSatk/DxfKrCbm+0
         NKzva371UHp8L0IHCO9CWSVHO4recqJyec1BHCyyqqSKB2aLeMmiOO+kDKHUug/SdRe9
         P9GJqorq8Si93P83+pZTFIur5TePwRgR3gx8/hHuicFnvwIRIn/MwtGHlmM1nJmcmx9z
         XRAwG1TpIe4x3VnEy4pq4Oc3J5HacivP14Na2t/VtKNSeOce4Ci9+Ec/AWiXDdqCYjHh
         32hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        fh=x/SrdF+Q99l9PK/cEItc+eP/bh1Fy1xDiyE2Aj6u4CE=;
        b=A0cieFTuOnI8InLGTc//LB9xWKHAbbokn/+6iCVFm2R+0ofx/M+KudDXecXX9rrzy6
         K3BKHEBKlnFFMq8YRDqKNOBQosGL48HuhrpWiFnvDkjprFG/y2nuV/yGajKEjJBsDIt2
         vlggNn+a3dBAeTuLoScZ4so3Yfk2UtCotiLeB2LjP5lib1BKBl3vJWeURSa3Gld8mYhs
         XwVpptEeBo0jHBnK/HfoSIKTbmhlYT23ct/pXlKAJM0FmOjJrbB8POXzTedTOv+Dgdr3
         /xflV0emNhWTkFBiq1+oudc2yHrNWrA6lxOUA9TFzqTN2a5MWzO39x1zwc4S4rYrWlyU
         5Crw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795518851; x=1796123651; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        b=h/p4yZ02U4/9YorTdRcFj1AzztFNUc6zGhMvin/RU8AE53rgv/XgEKAANi+OJrH/Hb
         H3pfpLwut6wQ0jbKJxTL4/LkT2405RPKemcfeGVMmbJHbw0OMA6hfBLY72LYHcRGn+oo
         779ap2foD0F7/vLzKqMMfI7ezHLrPzgdDeXqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795518851; x=1796123651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxcSWKYnItj3yo5FCFqsfm26g9ItY5gHtNPYg7zw1LA=;
        b=RKFfr+dd7duvxYXDE8oAZCPcBmhWtxPhRd5LG9m4Lx001o58A63W92djjXRgQrOF84
         UlQyqL/8lUow3rPzjNwNLfkwO4gb/uZWyVYGjc+yfTKWTsuPhM2ZZ/4ubqB85V1VUFHO
         GcAqxvOkag78ojysNfusuhh55KQ1jAbnwQxKBNkeiPXklQ/NfZs5aB4mFflRdPsHJmrY
         QIw2dlDVvfkzKneyH8lUUR808eWXlt18DyG1WDYECoI8/FnqWZ2UtqDkyX/Ws7YepBrS
         kfP/FO5jo8Cv008RplvCuQPkJErX5yl17Q7dsvYDpBT7quxCVP5BX+BkJoFHPRKoryn3
         ht/A==
X-Forwarded-Encrypted: i=1; AL+hErHEd/uRKVLBpRDEYlFkpenoF+AGmZsJY+GFzziGN2rHJGvBaDUq5dRoqUR/6oj6uBihMyWy85A=@vger.kernel.org
X-Gm-Message-State: APuU4Z95di1OVKYbXEk0tv7Vg04OGtFIMgs6S1Qtu8zxktZrhOVyU8Qi
	DVnbjum5hiH8kF/jlM8D+qplTZpv2ZwthUlxSvMWy69rXT5hrw1KIMr5zyo2NVYlCV7hN/dY6rG
	MGNP/NyLZaj0JIPksmaoF6o23Ir2xfNOtj2npiYGDtw==
X-Gm-Gg: AZFdTZdLXpsEKIWSTTQnmGQ56nHCsgozaxU4jPlpczfeNgi8JpOE3NC2ZWOA1UWpUD8
	wOzg++29UkXIJOGdbkfeaGsCze8wBuXnjCXdRebEPYjwNNkH0LMjSWn6+niUZIbP/S2Mx+mrpxR
	LR2Zyzx70+h5W2W2MgFRWyXELGa2W4sjdLvOPcbDtLI4IH4s+KDbLGIE8yC/Bm898DWO480+Qpw
	K4aT8fYCCR1PlVonpxod58l07qBVyxM6GaTfwpRWw4Pqbs6kZj6rtvRjsVaR3E0vqmN6TkrBpT5
	S2MCjo0mQcL86rTZRBASvgLK07MuZPpNwPJbe7QDqXaxjRDm8ukPcv0rqtPD45va4D+Yp6fvK8r
	Aibgz4mry0T1PXnq1L3a/qgGlY0dJNSubXSe1zBfpLQ+syK7ApYotQAibeRadtuOZpQ==
X-Received: by 2002:a05:620a:199a:b0:949:aceb:b77f with SMTP id
 af79cd13be357-949b36034edmr2558799785a.30.1795518851115; Tue, 24 Nov 2026
 03:14:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123095455.88622-1-liwang@kylinos.cn>
In-Reply-To: <20261123095455.88622-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 12:13:59 +0100
X-Gm-Features: Aa3M54pbj8-6gfE1d-Xj-d2hBGWMonaIctmbDSe8aODDQN2gLU60G5Esc5wLwmc
Message-ID: <CAJfpeguSMMaBuELCVtUpEvCZZCRZK-xvs_TMMD8r_KuuzzQoaQ@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: fix potential unmount or device removal hang
 due to stuck FORGETs
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, fuse-devel@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, virtio-fs@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 10:55, Li Wang <liwang@kylinos.cn> wrote:

> After the FORGET is dropped, return 0 so this same worker invocation
> continues with the rest of queued_reqs.  A full queue still returns 1.

Applied, thanks.

Miklos
