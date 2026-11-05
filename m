Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889796;
	b=ZQPPTVF8DTRBKXm25Yh2LbhW12ksPgjtP6ACtK0TshzDJY3Dz49SuGWd2ViRPcq+l1zv
	 +tEauUs0bVZj0LHeWQJOa0Nzi/Ye7RrbSEYgkdGeGCbKXHJWmzuwKI/oqCylMbzPrEizH
	 73wN04AR5WMg9TDu0BL2a55r073BabAEqagP6cIlRrmkZeeHYor/FAoKjuo58naRxlsqh
	 JwHobq6YiAMd+0zN9RYPYzTXU1e1KIkmV4GM7xHB5kD9AFJgeWxwGTQGHjlDJja5q7Cj4
	 LklsNTMD+/xTARFh+6yEXRqCSQOQTjbOLO49J1/htFFRPAVYpGq7tG0noh4O3Sxw/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MnyLKUfg5ufAqKiT0oKE83kexAXeCPTLKjrnMiWI+IU=;
	b=V6jfsrjrViDl8ihGeHIZKhKR7VXizijUbcEcIlTfrhqiwADnSbOR7rjuiiQGYt5t2CH3
	 gpTrsLyfhx0HuGTKaqUafQ69yGTdRI6US1Yh8isZD2Ew9okS68GytvWFkEdTSW8vWybGU
	 j1XR6nzM6GbFpdY8eiDFbYbyENwZNw8F9S1ra00C2ID2hAEgUQYvb/CzGmUMfC/LYXvEW
	 BHBkNTngr10TDU/oFNCLBq7vLd1CLU2PttDi+4IQ18Wg92GH7NNhpY9OrMLSXNXx+OuuD
	 SNbl7kiGDhSOw/aIpzwS0xmELxi1ZFDfB823VPYhvYQQ1QDkym7f1291u91UwOh6Zag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9rOLmAK;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79809606A332
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79809606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9rOLmAK
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-147be78cd56so4291374c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793889796; x=1794494596; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnyLKUfg5ufAqKiT0oKE83kexAXeCPTLKjrnMiWI+IU=;
        b=Y9rOLmAKjBVdrCp02W76hV9kicaJEHdhvzHUIzJyOlft0uebcy41X9U7JkYqpM3u8q
         VL8urorwkYTTjsajE8Q6hWl4PKlKi/MwLuZMh2e93cdqV9O5Dui0f8lpZCWuGV3JtFU+
         OXO3WQxJrY287dJdKczTEy56tpb6KictYEZk6C4AJoTrrtLGm/9OrLX9uh0J12MP8vD6
         JPkOq6r5Kzb0gH2oU3QWpT/ZzUrQNc6jk+Ip3V75fCGmdeFuMvhM30+erX7Hg/Ma/R+a
         w3JnHwr7WopHxD0f39mTIe3FivrSHbA8Jem3SBEYdWC6CP3qi6A+aN7FqrC1A7ZjfCSV
         EZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889796; x=1794494596;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnyLKUfg5ufAqKiT0oKE83kexAXeCPTLKjrnMiWI+IU=;
        b=pnL6R3umPdOuxTdvj95V+VZ/ynznSCuF0CdVU1exKre8p2DJ05hNnXFB+KKW5Nnc/C
         /6QUZ8athX0GG6oy6wRMdKVcVYRNB+q6lsMEVloGRVdbPmG5TO0pvZ35jg1R1Qs+g9BX
         4uncW/qgM1mobpPjc/sdevdBAoAANUgmZx6jzRQt/97PmabNZG1ciOjjUzinJJotoAKP
         bi5ySo+XA97bh2990BtZNxGb5c58wSom9u+R9nhlwU8CnsymXN8VZDY03vuVhSYJXiBD
         AyghBJ/PyLIvmt2IDgwDozrye1ApKNK8IH4ypZsz5v55QQ6xWWjsSpZnv3R3WPjvTpUV
         2b+g==
X-Forwarded-Encrypted: i=1; AKwUvBzwUvecSW2T4xRdMlWM0KZJKAwgPwGei6GZQa4JGNB9U2M2DZYoilnG73w25oAOKTZKp8G3eig=@vger.kernel.org
X-Gm-Message-State: APuU4Z+W5QldHfSVqbOM2UN7RwO0/sBVuZffUgpCHsbWN4LJOlp1hGU0
	Bgz7AtKpr3Fw7SKDrlbLLPn8EgF6N1VCVdc37HVe0l0llPEz3KmnJUTDC9kSPB2oteGxZ+EaSm4
	fh8qUI2wsc0OL+pB7GZAeeQ==
X-Received: from dldz11-n1.prod.google.com ([2002:a05:701b:418b:10b0:1a1:3ce6:560b])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b047:20b0:1a3:bfb6:44ad with SMTP id a92af1059eb24-1ac5da797d4mr31199827c88.32.1793889795206;
 Thu, 05 Nov 2026 06:43:15 -0800 (PST)
Date: Thu,  5 Nov 2026 22:43:13 +0800
In-Reply-To: <sashiko-outbox-198693@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105071518.1458428-1-stanleyjhu@google.com>
 <20261105071518.1458428-3-stanleyjhu@google.com> <sashiko-outbox-198693@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105144313.2627198-1-stanleyjhu@google.com>
Subject: Re: [PATCH 2/2] scsi: ufs: core: Wake consumer queues on suspended
 W-LUN recovery
From: Stanley Jhu <stanleyjhu@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Brian Norris <briannorris@chromium.org>, 
	Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	John Garry <john.garry@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 05, 2026 at 07:43:05AM +0000, sashiko-bot@kernel.org wrote:
> Can leaving ufs_device_wlun in RPM_SUSPENDED here cause hba->dev to
> prematurely runtime-suspend before the asynchronous consumer resume work runs?

Agreed. This will be fixed in v2.

> Wouldn't that leave resume_sdev_queues false and
> leave the consumer queue stuck in __bio_queue_enter()?

Agreed. This will also be fixed in v2.
