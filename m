Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541536;
	b=5PbgUDvALY68xa1iSiSW1K1WH3w7tRA1YqlX8WVIKGXCAF15rIyr5b/KUNwvMGMaSgUD
	 buIVH9D3U437hAGWXzcqKdpGNoi11znHgRXukfA/CJtpY5yUEM5TYuMMyRZf6kLZGKf0h
	 OzrSZ/jOOIvh2LTvBPpIVl58Nr3XtJYNINwk1or5LfVfnnodrAaBqaaRO3PJ/1p843Wvl
	 Y/It2oQiwAJwpBaLaTmgJMzyJ8FrIVzz2WcEsInqCzLVr6fIKqkEFHp1JDo9y3Qucr7Da
	 CCcGf05831Z2SKtxoIAbTmUIeyPAjPfE4qeb85IZWWASQ+CC0viZrrS8/ZRX11t3wGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n8/AvnXIrx41eK9Q4vRZzMy10e9mFZf1Imdul4D70qQ=;
	b=AEOi1aVPpnmH1wLCDd5jjf/LMWPgxAwp769/TUTM63Xv2c9xeMQ9YDomaV0f/aDhJ3yJ
	 UiSUDCYBmm1PPkGv3eaW914VR5D0ZN/G8M4nQ9U8wv46oGgiFYtjFRpj3ayieaMsUzWap
	 5R7RwYlDOEWZgcpCkwp4rXvApPcck/FunH51n8IvnFCQxFnXSGr/EKcPdMRq9QDKmyzCR
	 gV8tXLbHzQfAWH+a4OnI1wlkeveempQKRyFhymZNE8L0eqZtTvVkBLwlGANUh8Ov7ZMvO
	 gm3ZdOV8MbVCyd27W2U6/nY6MRe7Fw3wsbCGTCjIf811e/bqxXab8fHe3Pud0j8SiMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALRQwpx5;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58273606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58273606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALRQwpx5
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3712b6d9843so542262eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541535; x=1795146335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8/AvnXIrx41eK9Q4vRZzMy10e9mFZf1Imdul4D70qQ=;
        b=ALRQwpx5p9tM+6YF3sXHZuNicR5nyD9PRChHqxHRRriNug2muZeqC8G5pM4nNWaI8l
         iRPctIMc6xo13YSHAVIrwkBINhyWjEqligELmxKO/juIafzkdHDg5UEyNzLEf4SgavTc
         agwmJ7I7y/WMDUWpJ24NadxXVeBH0xz4GuBIoJirmzzh84kk6+xVKg8PGACj4SsPogTL
         Y3CEG9TOYYjUpGT/Yo8/kOSEvJa5BDDaZysZK5PaB+FnmRdL2dbxjeFMOBy3OtIAAaZP
         ZPGHWWFKuaWiKIcFMb/RvOKnr5IQfrdk3xKIpmAX6hTOMq/XgMlT0XtiBvMHxicAQngT
         FyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541535; x=1795146335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8/AvnXIrx41eK9Q4vRZzMy10e9mFZf1Imdul4D70qQ=;
        b=I2nfC6V3g5wwcXVJuK0bSAfbNU+bt6PMGZd6I2UotsQEPMIIIYwktKQR10FHyg8fW5
         vzMeBHwEo0LQrYARXODaoSxsVFVVChsgwum2w/6aUdtIrJhtsKGPUKmicvMgk28Z0u/v
         jGR98c6tWEN1kbaUg56S8oAYjD8LR9KuuYw27GApDqo1QZbMoFNgF+E08pB7G53fGBXA
         r5ieBfNdsNJgKzoZkPO/flHf2tMYxL4xJFs9fa/HTDqKn4KPo8jeGIJkIH0JNedoJZTn
         vDJHuJTX3vZ6f4ux0je7gX5SDJaurBBK2tbDIHX97aa3W2K96oDcn85TdGbiApC9Fc6v
         1zIQ==
X-Forwarded-Encrypted: i=1; AL+hErFSr3ftazWIE4SfMUBouRiijhPPhT7+aEyhCjqYaJx8NOIcnYfeAsvDQSZuoIB5riOcPVJ2giw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KazLrvioVJXB7ojvpgchhJdJNB/D4V62Uf3J5xS74BwkySz4L
	15YlYyA0cNnkUiJTQBpUowv70wHsEDsTQAxzrM2WQJ7+gE0RrdOoJ696
X-Gm-Gg: AYBFou0So+HFjM7TRu7ZKry+YSnTfbGwf9R3DX/b0zWguiCT+1Zn4SQJjgCHJzZVQtD
	jMicW6bYK+aAdKW1gDfo4Of0+Q+wGEPl/hJtv7OzZ0/bDT679PFWCHvcB0u+PMLZ16uTwpjPLhW
	02A258bI0rXDp0i7HBLOiKwErS640rj9LouLDUL8I+plK4xBLsbPeO4CzlVTWQ0L+fcywnSIIUM
	VyeD/0AfNm7Khv1laxlwkVxpyOxfHjtIzRr36WSkB3DiMu3+o9XDKdfdPx3dkDZGSP1BbPd3mrP
	EJH6vIgq7IeNf5tIBbCmSwJiUuPHPFpwzzJwZf/mDRTFn4QJ+cd844TtTLicB9GRSdt7ES1MP9J
	fnI6H9Ux4umDJllRSsUqMqxTo4wkJm/R+IYzuGdbRfU2GovMUcBbWvjGESKSg+2Fy3xuwSmXiOj
	4QGnvFdu/55Mq92Z4tt+1F5lolyl50kIV79HKrWzp2MLXI5HZ+uPE9Bl+L12nXAALInMJBJEn7V
	SfLN2Cz0DhjgfZKGqTWVac05TfKt4QPzXcYsli3ieUpNlLbCN8YeaJt/p0K6wOP8eOyxlLslySW
	vjq38G8UwnOCcTNyMnNe
X-Received: by 2002:a05:693c:8084:b0:378:1191:43ca with SMTP id 5a478bee46e88-37966e3b292mr1138076eec.18.1794541535230;
        Thu, 12 Nov 2026 19:45:35 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::243:8a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm6099607eec.8.2026.11.12.19.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:45:34 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: luka.gejak@linux.dev
Cc: pkshih@realtek.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: Re: [PATCH v5 2/3] wifi: rtw88: skip already reset station in rtw_sta_remove()
Date: Fri, 13 Nov 2026 09:15:08 +0530
Message-ID: <20261113034509.20282-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Hi Luka,

Thanks! I've addressed both points in patch 2/3:
- Moved cancel_work_sync(&si->rc_work) before checking !vif.
- Cleared si->use_cfg_mask = false alongside si->mask = NULL.

I also picked up your Reviewed-by tags for patches 1/3 and 3/3, and will
send the v6 series shortly.

Thanks,
Kalpesh
