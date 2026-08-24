Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F78395AD3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787614849; cv=none; b=iNbUSPSAQKA5m6UgcEyiI1HSola1Qn5Gz/uTuPVomWDsVrHoMhQcNsYwjJLj7AC8pQPyl58lA3KsvFiBlJAWeMFcqkxOWo6YMLADZDhO14oIk1tzra20zybx6giNGqAEDyokw3Dzo7I+RB75tmghJhmYPyBdfEzIApLMB3ozmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787614849; c=relaxed/simple;
	bh=UK3Ka/ym/G0XcukOVsVyV6NnJWs41Sf1ZVaK1C/8CzU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejv2auHBZvFKK8/tIXm0ZDmGRiyNLveXG0OMihsrStYTYcNF39JfqTPAOTX8s/Pr94nVIuoKohoje/OnQH027LxHmSKv1AQRQDLCnHQW1T6Nm+BM0CFfrgcdR2MAspt0LueoPflzbM/a8n2mXWRjBAQdl+KP3EFuuO51r1qTI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dwilley.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLGIWIhQ; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dwilley.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLGIWIhQ"
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9dc0f5900so566384a34.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787614847; x=1788219647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UK3Ka/ym/G0XcukOVsVyV6NnJWs41Sf1ZVaK1C/8CzU=;
        b=qLGIWIhQff+Zn6beqaYsDHrA1QjQSF5xKH6RVedIxK8BifC/WqAW13xuHTO0qvV09b
         CrTOxiqyS6rbno2Pqz2AboT0sFNtPkQ7XAvpNWtqrY9NKx7/QRCdhn9zuTODOK+/vm6c
         6fONEzDTBYuBdMTV3oMskaXXjPg8eeoWxZ29Y4VApmH0DadZvxvOEuUIb5ovLipuYTh0
         wYbAeJ7PawH+jNcR6dZDtou9XLRLQC0iQO8O8IqvxxbMFEe/EW84IfQ/SToDHeSDlYQH
         IOUj7i8MqmDcHr7s/9LE3koGm4LIJdtLSleztDXf3IlLXcjFcZWZpdFcBIuOUlKvVx40
         f+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787614847; x=1788219647;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UK3Ka/ym/G0XcukOVsVyV6NnJWs41Sf1ZVaK1C/8CzU=;
        b=B+LUD48dHjf1r5irIqIguPZ6NhmqP7eIII0EGjLugGshT10RzhWcUupLgTlyJ6pK72
         kgQZ+Vj7ebHt/CjjDzRkVer6+3665AOsM56mbXp6zayRhKgkoMpHVKynf+gl6PE9ThOe
         ok79jXwR4ZnQQhjWDwppKpgkN8OtAMVqKsGkThfrMr5VwGb+qkcPOXJcUSeejwFnmWRJ
         JnCeOteTjV2lfGLGDQXlnd2mNQ1G0WjKq6B3UIqc+CKBAGVBxwo4ucGHOcf6XM8rM6CN
         bJVUjy3uwIGCLEA/KNIngsvFOUwmWgG1FWpoDoX4rUNQM1hcod5F/T0CjmMCs2IhJPgV
         WJcg==
X-Forwarded-Encrypted: i=1; AHgh+RqooTYCfMTkDdz1I1xqZGK7DSKyZfzfLMNeb3lyIN6tRhtxSYYu5SOJC4bVXi44+Kyd7aCefDg=@vger.kernel.org
X-Gm-Message-State: AFuF++nRg1gluglemqNiqA4oFKmZe61ehrjFj17v1Tqxo0an2+AQZ0cB
	ZUu8NdKsypRlvU1azLYLgQNUwGgfvs6qD+xADRHvu5uYHWYQeAAJwbycY+HbnZNpvGohf9ZnzP8
	FcTdPPGdwMw==
X-Received: from iobip13.prod.google.com ([2002:a05:6602:6e0d:b0:9ab:3339:3966])
 (user=dwilley job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1908:b0:6a3:6f5d:4d6c
 with SMTP id 006d021491bc7-6b18faa5cadmr2046337eaf.6.1787614846566; Mon, 24
 Aug 2026 16:40:46 -0700 (PDT)
Date: Mon, 24 Aug 2026 23:39:52 +0000
In-Reply-To: <20260824-alluring-affable-hog-d072e8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824-alluring-affable-hog-d072e8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260824233953.2057979-1-dwilley@google.com>
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size mismatch
From: Drew Willey <dwilley@google.com>
To: mkl@pengutronix.de
Cc: admin@dynetrex.com, devnull+peter_hong.fintek.com.tw@kernel.org, 
	gregkh@linuxfoundation.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, peter_hong@fintek.com.tw, 
	stable@vger.kernel.org, Drew Willey <dwilley@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested running ChromeOS, kernel 6.12, rev facaadd, f81604=C2=A0(2c42:1709),=
 the driver hits "f81604_read_int_callback: short int URB: 9 < 12"=C2=A0on =
the first Tx attempt and stops the Tx queue. Subsequent frames queue up and=
 are not transmitted.

Reloaded the f81604 module with this patch. Transmitted several frames over=
 a minute and all succeed.

Tested-by: Drew Willey <dwilley@google.com>
