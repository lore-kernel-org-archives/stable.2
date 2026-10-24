Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809656;
	b=25rUR5ojw01w8GSU7bdSBW5sjiy5yIBNzyU+lSiI83v5oEbT+mJpFfJNvj4yyIHmL+Ye
	 DXeTiLHvrtk/4SPSRSHMomqiRa0TBrGTXFpeUIWK0wHoobVJD7IcufCTiBkdbG0FxfB7G
	 7L1WCCci90pCzc52TyuQqugLtEDGPuYvLjGLlkg36ayG9wQX/JY86JzIdReNOl9UbRyDO
	 qg3IJN1hkhkHZ4aLVzbOJspu1gFwHou6vQ2yAEIeP+t1FjIBEV43ttUQQOMUQYapq1n9S
	 3DcKqTlVfn7qZ9FB762CsZzUVvnqWCuPDLl9FueY1RsNin4kI4cq+XmJLDUR6mP38KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d4mvKHVg0u9lhgOXNdg3AlX0ucHCymbdGcE+4K43yLg=;
	b=ZfUk4kyX7UgfaSvrai9w7SSwt4QqZa2R4dsk6Ox7YP+VTKJA2EZ6tzrArq3w6cTLpXy5
	 bHL9MSWSDtyJJ7ruQqvOLbLDAhgh18AAvZ9bmDkKMBt0ifFZFtgy5DvyW6/3MBBNcXn5M
	 cIzB0WV8+1s3gUgBRB+RDqID+V4o8+X6EC1pDS7J2LzHvhH1ndZIVkPFliYgCSps0nQT7
	 jkOSgm2LgUZGpZlyGAoV7djpzxt71NsfTxfUgzyvAvO59/zV4At9OijHFnfaWGPjvw3re
	 RLVh6olt/7qr1kFS2szn83YKIpqgVVXzei6BWybs1V1wZ5NJjh+o3uh4GjAPELN5ILA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ovwbUIQu;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4EA606A333
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4EA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ovwbUIQu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ba702cceaso17412356d6.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809655; x=1793414455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d4mvKHVg0u9lhgOXNdg3AlX0ucHCymbdGcE+4K43yLg=;
        b=ovwbUIQulR/trzGPUe6AcLFuBGKSStkt+G9NV0x/7+h8nj3ReutjCibybUc6ZFjQHm
         lfBVGmkk5rWNBMNKWK5v0A5IOxiDq5ULKr6rKEBivFivT3xDaR2Ye/NBC6e0A5QJd7GX
         8zGnXlUgwunCf9VHNAT/nroUrPc1lGIm9inioB1hh+++u6OMboobvWKF0vfY8sJKDBn1
         ZgXiIex0X3gA6h40TSXVieXjR2yvvJITRE4YI3uHR9rfqlY0WDR7eSrGwXZd/T89JUSv
         1PpaI3mnE3HWO5RAarekm8tthS5t1YXfowWa2XuQDaOpoQLuaaO5oTpIK/O9sZwkullo
         13wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809655; x=1793414455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d4mvKHVg0u9lhgOXNdg3AlX0ucHCymbdGcE+4K43yLg=;
        b=yhR4qTaztqWv+TreFZWYOtOGb17gXDuWAFcEqEwg/zYEMmb/yLYxHGz/F9iRCfXoVZ
         oywjNfHjxJ489gOVxMuLaqPHtTev0PxsMeZ38+KVv6snvr/Njazq/O3iQwU8bDhXymiZ
         UJKew1zdv/3A4qQ9UZhUXmZCnxOV2OYfTswt7e1wzLnQr5pjSYPd5GNLz6SHN+OzbQHg
         8wiiKqZ0A2nR0KnutkRzY2JhmZ6MOR7edPGLk4i9sMvvFavw8T9RvAfqKjA0zoqy/JXi
         LI5LdQd/92bmaOU0uAmXavFjF7eATDEAX1d/UTQDifspuxymVmxZmF2zhtre7NGvd7aP
         RWew==
X-Forwarded-Encrypted: i=1; AKwUvBxEJ87FkjcoZ0CRhV9812x1fGYCFP1jwIFkaU8YkYNk5U8cmfehuN9M3Ab7LuGYaP9QYLZGd88=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAJtrs36oXaGzSETHGXritTGH1jQEqcQxg0+zE4RAcCey7P/pi
	OEpF80dzk1gxdYlive+21hyhIY9bLSu6gpZmFqZtNXs2bETk86i07aAOT8gvpOcrsA==
X-Gm-Gg: AYBFou3GqVcVP3hpWrxd9csaZEZLG0MCxB9fZ8X1EiSGJJvum19lH6QGZGGjo2Gr65E
	rv9TDCrDNqyAg0vRzqgobyz/FMRyUKqk/cuJFOiQ0H+1efnFLeJ4sXTNpvAIMm6ouM6d9rxD0qu
	1RiQZ0bby5KRT054QmX1KeU6uT6IkgmXzU1DVis/nbh6JGVromo/WoOK/KAEnONsiah9W2Azt0M
	MkgdV4iYXL0do5BzpZDNCe00Zs7Mv5mPcgNBSTdDi+fw8OkyinJDqopk4IjEaRzFcFjTmLFDgZW
	uhcFuYR3cuz0UicxtRVnfmwhh5kmOloL1CNW0xaQV3bu55Z91+rZhh19kCBn5kGO2wzvAm3zJIk
	8IB7VuL4tw6nev6a+esF8ah5ljSkq10GB8tH0LElVfAmH3BPjwzlhyJez9ZuF/0tpXZS7b06oAi
	ra8gHK7jGrHgM7ddedp96qCDM7RcaNpHy+aBZjuo87r9xh2k3yAnjAbl0w9fuyW/oUQRU7G9a69
	i86yIGQfck3h0smaOuhwucyasGcj69ba7QUFh1tp2U6oEidhqRR5KGZGRx3UzPWPGEgRixRtpWy
	Afr9bbr39v4OX6STZpGzpr/Zmde15V1steTYN5Etnm13vA7+doKtlYzgTzJyUFoSMiOaN5znGsF
	W7e3W9x521g==
X-Received: by 2002:a05:6214:ca9:b0:91c:1a4e:425 with SMTP id 6a1803df08f44-91c48e75052mr14414866d6.56.1792809655265;
        Fri, 23 Oct 2026 19:40:55 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c48feca9bsm7203526d6.39.2026.10.23.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:40:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v5 1/2] media: venus: hfi: disable IRQ before freeing HFI device
Date: Fri, 23 Oct 2026 22:40:50 -0400
Message-ID: <20261023223635.3c895c4752c4-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
References: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
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

venus_hfi_destroy() frees hdev and its interface queues before disabling
the IRQ. A handler that already loaded core->priv can therefore access
freed state even after core->priv is cleared.

Move disable_irq() before clearing core->priv and releasing HFI state so
both the hard and threaded handlers have completed before teardown.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260612103333.5585D1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index bd82066bb6e77f68ac3fe1440a8b5429ad62a192..e7e4e78a186adaa7fd80deeb094ed53d54f27ba6 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,11 +1689,11 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 
+	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
-	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
-- 
2.53.0

