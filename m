Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB0318ED2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435227; cv=none; b=P1L+NDxPrH22UEl70msbf9rUwoemqwUzDWnLW+xcfn76k64ur2R2XAtU48VI+tzQUMG/tQma8U0RRZguEAaaeEsGT9GX+94cHc7d4xLMsd0PImDrLqo7f9nkWw4s1W990jct53e4ESpIVkr4X6v88P4Fm9E6ufKW81+0VYWWcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435227; c=relaxed/simple;
	bh=CKKoXinNIPjaJ7mWM3TvEUEq1iXPeisQkm64XntF2Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBM3f4dZjiKdA+/UzRqODoU6GrGaGGlnTeNAfGhvqOQJkOF3LC7gr+BRRKoXcZHcFzjGWFqZgpw+yJI84AcWIb7ZMJhwoahg/3dpOlaslPs9+Dirdog/1H9OQN0kivMwItIy3jCLJ+bhM1ECplqKcpq0udAr5IxR8KyXd7JMNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abXJH4G+; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abXJH4G+"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so1680756d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435222; x=1790040022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wCRBWGGFnF1Ry6hzDyS1vYmZsFfXfi71bfZ207Oj8vA=;
        b=abXJH4G+x92yAF0j8u1Dmw/kgfvAo8vqn3PSijj+f/ZVx2/soLTvqHUPM4O7CutMn/
         EQxUt4ZtG7ttiBKorDYwcQDsSA038bqbtDxfKygBOx+OkDW8owjjHlWPnHoe8D+4O1uC
         LkdB0mf38DJm7Lw3CkNS11uORyxnosphlT3twqOGEaFPClvmku8FL6FnihIP1l/W9u6d
         bUD7v9PmkvwaB1ulsS8GR0Cvr64np66NM6L8CarbvJlsVGoNy5awajZIhE6bwgEPo03/
         gpxWaWiwjrsyerruMcSiPF2gRc0RgB55Q6G36QgGbBo9+yYovDonQXvg7/iT4PMksoxD
         fwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435222; x=1790040022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wCRBWGGFnF1Ry6hzDyS1vYmZsFfXfi71bfZ207Oj8vA=;
        b=OfLnO9H4UDGTgqodofWxG2kj0ZItOy7TJ+GUsBE6n/oVJijSllKHc3/I9jW9I1+uw4
         Ft2l02vhKlZ5QJQ5K6R7u3wvuRnyEA8BXv8IqB+E/UpCZrydPn1ycuPg09K8yD/A+UH/
         goG4psSyD+D3uqp7iAex+GJjyX2s9zEZ5hXsGYH0enIHeM8IbJzLFBUcdj2BYCqQt345
         HBE6KmPmjouvxdhK0+0a5qD2oZJHNx/ZsZaF6SSJ9su2s8O7MZCJu7EEuOf0t1NHnvMh
         8uQmEB3d72nS9yiapeXw1dObFzLDSj+U4PP+uHy5rZAGkiP21BnNU320ycmIxvutxnXD
         pvjg==
X-Forwarded-Encrypted: i=1; AKwUvBweYr4BfDEaRCwfcRkDzKe2Vj4Yv+djmQL+NhsuG2Z07ztYCj88w+YW2In0aZUtCJa6npJphpY=@vger.kernel.org
X-Gm-Message-State: AFuF++l1dBQpD7u36D/hv9vlrp0hXFiUNp/z1wywMbUXZrCUEIrkYbKc
	pgu5RliqlprUUCpJ9FqyHiG1MGSpuSkX/h4p4REdO8+5Q9F6Pj4y5xk=
X-Gm-Gg: AYBFou2WocHMil9Pwk62sJ+5iYv/mLbF5sUAVEjNsaSAA4cjh4Tzb3jggEDsHVPDbuV
	3KFrY1O0GWYc9oUgISCNN4KryjVmAQDztOHst1g4fey68iGxTynpBzgISCdhaiHlL+RylRtMU02
	kFvapnpubaa/0RRASD4D0rnTw+wc/JuQuzsJvERXrI/JoFpiAgyLzHiB8S1hXfMxalu8wPrBQip
	91hyHLuSzM6PTKVjxO5uHhMgisjJghON7mECsTpOwSiEAeF5Zs/eOnGsk3nEo4HCgf5PzoqXohg
	Ta18kSHtLNufed1GU0MPO6c7oCbz3jWU7Ggbqmz1K9rHJUrYORSr/9eGOS79PzWly41+DuzM/9K
	dTWJdCc3nUjvwkSwEfAvmTtzanYq4yJIBV9GV+ZF1sJ5BHDsQBhAnOWDn74WFKMszJqPfyrtznP
	uEJj/g/h8kTCKL0BrIQm+f4aDWtlfRb2nfe7zIPOtrW46kX4380AAsqX9n8feC8Gfrf5YpJW0BB
	FjBVyo8owy+iiGHkSsqN+RXgdbVB+us6LHPU9Ux307ok2YvUFXXNrTnXHQAceRRHQnqIhRJKLEb
	vGALkGvirwgDh5dpW4/16/wjrRiPzYPF6HcwYm1GxKRC1K+V7mrjuWbGA4Hw8tciQJoOBW0fQy/
	tH4C+ww==
X-Received: by 2002:a05:6214:590c:b0:8f0:3b98:d6af with SMTP id 6a1803df08f44-9122e660530mr96067806d6.26.1789435222335;
        Mon, 14 Sep 2026 18:20:22 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a62b783sm91141946d6.23.2026.09.14.18.20.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:20:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] usb: ohci-da8xx: disable controller wakeup on cleanup
Date: Mon, 14 Sep 2026 21:20:08 -0400
Message-ID: <20260915012011.61874-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915012011.61874-1-mhun512@gmail.com>
References: <20260915012011.61874-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OHCI core marks controllers with RemoteWakeupConnected as
wakeup-capable. Probe enables wakeup, but neither removal nor a later
notifier registration failure disables it, leaving the wakeup source
attached.

Disable controller wakeup after removing the HCD on both paths.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/host/ohci-da8xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -447,6 +447,7 @@
 
 err_remove_hcd:
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 err:
 	usb_put_hcd(hcd);
 	return error;
@@ -457,5 +458,6 @@
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	usb_put_hcd(hcd);
 }
