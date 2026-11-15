Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727194;
	b=ZTj0Gw7JWORSQ81vrvMTkjlgyJka89/8ieAvZDZHe/uVtGA3K7LPLmF3dCIky35aPAKC
	 fYPiYnjtSEljXmPqRgDLWTyIqKCLuK53bslB86GG+PZYOc8Jk/ymecf+rhvNPmoRA7f2Q
	 WJ9XkifudiqB9AkGI/XtJxHY/SSRpXqJPMEO1hD1WugHD4MF8G28wgY2l9ti+tUntsIFl
	 kBuuwrdkjBaUuVAaZ9Smokvze9r7lgHhDJwU226MV3YjZV2RAK14ihkUk0OiEtfAN8mxG
	 SN7+ukaE9Lcgpf+G6GgtqZ/jGrk0lx0a5o/Q5BvbqwBiqffftlY49ayezJHmOGH/G7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
	b=RJ54+mDyfjT16AdANuUPCyrPKEH6OP89zhthPI9mu56NKEW91GzH5cP65dYRIrbmpT23
	 OMNS+MHInQwsYo2bEIVPUEm2gDKLdK2m23ozyau2Ymg0Hr/30cYFJQ1Nis53T4BA/b783
	 Ptkj4GV4GRwCCQ1tkgpDRjAFrBAJAzMywBb0OrQ1b8usFMME+pc/4sFDz1vTbPt2dzoS5
	 bDoO6+7nMiCgnHuX0J1xUeiMS1qEOeIkKXqbn3rxLtzaJi3fcXZI0T8F7m046WEeulJRc
	 dz/l6E+l35IIcLQrzj6eN/o6koo+D0ZA3fsExVAkZuvE3vXWMY79jr+tTOeFSjrxBJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ceYAJYjk;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2E60A3829
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D2E60A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ceYAJYjk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-716c0217635so3515243eaf.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 23:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727193; x=1795331993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=ceYAJYjkTQE+MYaav3vU0DXG3mM4qLnM/7WEl09HG8qfVIon/Pa2fjcGYoxVkzUJB0
         YSzh3u6CxFDsSXjM5oKN6+Lklm6zB+AxWgEielSZgXCO8U//Dw2SGyjY1h3Tu6PEQTs3
         NISiOlin3w/1Lh/8R2+ZtNnFfnf5hJ05lVbo7mf6uFOaXWgI9+ERgrZIItse+iKRWVmM
         a4Z6Tn+Mn6GYLFkWxckyqM1nOB4O5Y50OJA/nKmV+b53K/vOtp3PW8BJq5ggyxNpI1Hj
         yeaa/ydlgHLcRNwIsFAJRIXgyG44HWwNOJSDDFgVpllx6dx3XujIkbjCa3pcBIc3hxO3
         o4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727193; x=1795331993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OFiyLgPB9gonzWakO9Dintvadbo1GwHe3HBflThFw0=;
        b=h6ayVAAS/CZ7Dv3WyWFwOBcyK/RjxsantKOK2k0cpaAGFZSVRshtOWL1i/Gub7/BQu
         MuFwROOOwgQNvyZwfFhynIYgcUrWCSG6yEH2VTtlWMM3VqXmsUWavT4oUsiRXQ3Vjqpp
         Rni0f+CFJ7edupCIsBA52EDt3f/RqM9bfuVe/80h6UTNUrIGkjrAkiX0Ir0IgnJbPSGa
         K5/QWYk2Rfm3np/kCFrHEmJr22k4wZIuUT1C1jHZQcX/fO4Bv8/BoIxrAJUXPAhbMeJF
         PM7ybEjI2o0M5i//4l+h6ehIIhTT53oGOSD9uTdRcKFI+Tn7t4l5Bc7FMqv+JWvwVEZ4
         wl0Q==
X-Forwarded-Encrypted: i=1; AL+hErFTvJcp5G2VIjT/ImmzaHU4ScXuhaTw1vi3of5qtM0ATqvy94YRxeoaJQujpXD6x8/z+Vscqso=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hTPCRBVrfS+h2smkm81bs+wvPwVNSOhdXK+GA0goQsCqogGyk
	bMqbRmGM2Lf1sRJez8P7KOD78c7wRebE8/y2T2GecyD1HcC8fF3nBgZa
X-Gm-Gg: AYBFou1dD+nPTesSTh9nEIMFgl3vPRgy98YECHhIq05+an1Fnyj4E814minr8VtYVmW
	JkPOteqDSIrXf2KF2MDlITeACtqBm+cHKI3iY2sDa5ioxXA5w+laNdS/YLT4mbs5oVFX6aFq/6l
	SbBvD9S1cieSNvCe3nBTLTMpJ4psmyw4yndUIJKNXvW0ZQSBQv62kPhdWEtg/rAW4sC9/LwKqIq
	uIgyx3V1SJYdNeiaobbhDv64JEQe2jpK+/CCNkLDDskUnO1crp47VrsfMzv4uqd690lOW5ZZduW
	+XeCfi/5rLhvPwAB2zTBPdfcbCtM9/gCLbeFDLmYlh+pLYqanZsWMYGDw1MIGeKClzBXZYDXZ2o
	9qIBUwS60Cfszq4DHh18XK1xFVOPpVsxdHexkGtrAWS6t7t5yBtIPXsIqyv4h7nIXMQ0JDlZzkw
	B/c5iyHYtNuWS8dodZBUdWoeCEjYi4373ig7OuCBs7XSIUZtO75r10M9kpagHR70K8nvZDW7qfk
	jwWuM5p6CmUnqbcCxnevX+01G6hqOYIZcJK0RgdrwzTApHwKce9dvVttl7NnfB0yeTEb/nFOkpm
	P1tEnfOkhvu7SiQuyAmGfoDNjF7YnINepM3LuqX3lxrlQx3MfYl0GCdbplMPjHwU4LCW2RpBKNu
	9FtUwdUQkUrfKpaj39P9eqNXvBFBUF2Ki/lwDv8fENhubbjfBRNCOWt55wlQUAw5QsUhq1Z6eHk
	qwQH/Bxo/mx8Q58hzX/yQNrpf7nX+zeenjL3zpdw0SJ8zw2+015is=
X-Received: by 2002:a05:6820:5604:20b0:713:da3b:9530 with SMTP id 006d021491bc7-71ab5277f0emr2419543eaf.44.1794727192611;
        Sat, 14 Nov 2026 23:19:52 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:52 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:42 -0700
Subject: [PATCH v7 09/10] dmaengine: dw: synchronize completion callbacks
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-9-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

The controller tasklet can detach completed descriptors and invoke their
callbacks outside the channel lock. Terminating the channel does not wait
for those callbacks, and there is no device_synchronize hook. A client can
therefore reuse callback state or release its buffers after
dmaengine_synchronize() while an old callback still uses them.

Disable and re-enable the controller tasklet from device_synchronize,
outside the channel lock. Disabling waits for an executing tasklet,
including descriptors it already removed from the channel lists. After
termination, a later tasklet run cannot acquire another descriptor from
the terminated channel. Clients must continue to exclude new submissions
on that channel until synchronization finishes.

The tasklet is shared, so other channels may schedule it while this wait
is in progress. Preserve those pending runs: tasklet_kill() temporarily
owns the scheduling bit and can consume a concurrent scheduling request,
leaving controller interrupts masked. The disable/enable pair leaves the
scheduling bit and pending tasklet queue intact. Other channels' hardware
transfers continue, though their callbacks may be briefly deferred.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 56a422ba14c1..6f863fae7455 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -923,6 +923,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void dwc_synchronize(struct dma_chan *chan)
+{
+	struct dw_dma *dw = to_dw_dma(chan->device);
+
+	/*
+	 * Termination removes the channel's descriptors from the lists, but a
+	 * running tasklet may still own a completed descriptor and its callback.
+	 * Wait for that run without losing schedules from the other channels.
+	 */
+	tasklet_disable(&dw->tasklet);
+	tasklet_enable(&dw->tasklet);
+}
+
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
 	struct dw_desc *desc;
@@ -1290,6 +1303,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;

-- 
2.53.0

