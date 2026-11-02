Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657128;
	b=FpkHrLrw1jti0HcNlDispEuRmRgtVZwoq5rP976tJG/K0ZecEPBHlMGLzMuOncbXXqcZ
	 No2EETEi8HYJrl/KT2i8GC3bApUs/qcFPokGsU1ratjXuz/iFapymHrcINaF2zJ1/j1y4
	 fvvuVIYcnNf6uBvW+wezVm5s6fAuwUkyir7DWhEm9r0FVnCSGG9TzdURd7l9Csmss2BGr
	 reji0XGCKDJ9gcT+fjsKWiV6z92O9kOwXJFC+9S86WzEJ894A9TPQfpm9SDk6j2dX/os8
	 shlsIimb5WE/V7AMoj4r7Rqvg3UaKcomNRHPYFPh7PtIhzQvl2yPtfne/s7HvQCGatg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2JasoZs4pU8J575UCokZsfJygggnE4HUTF2MY/ekZJM=;
	b=DxF+BIoTk5ZP0JaBe6kpkI8s2CGSx2cEJEn5SzIiFYQC8vMyg1VTbnJyLm1lk4pMg3CS
	 3lmZ0poEPFoPyGk3y+G1XysTqWROJvzQ7osPQncgfTNxfqK6kZPdwNgkoazz4a1+KRMSi
	 K/nZVfL5hgh9iVvHL2sJPDpGJegWMl3qPpBX9Ol/lKkEkYeyDfnT87zZcQMkvFIUD6/1l
	 h76E2C1goAXStQt0PCVDhTHqkEwHkhLHIgmQZGsok9XAS0PRrfM5uNWn9swTHH0ha+6tR
	 syVcVdmDj7NMM0IK3Qb31JBxBFPuuim/9aobO3kirQ0NxQJ2pYrdVwdU3VYphUDXIkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O99SkEkG;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBA606D80A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDBA606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O99SkEkG
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a18fc7a38so6476029eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657127; x=1794261927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2JasoZs4pU8J575UCokZsfJygggnE4HUTF2MY/ekZJM=;
        b=O99SkEkGgX+yDaEspfPEBwygqQ8yh0ngcnnm/iplfx2/07xIvSVgCWc2jc1qSkcnwO
         jwtCw1qWTsbouhE1lPeROQ3bJgD/8puj6J3ZcZehM7KiNfcNo5a15Ea1Tn+iKWQN0xcC
         SVz0yHWR9XOgcrbepl4xvqGN0g4RpL1+2S5tarjVZ127Q6+qaBy9dPX3zPa8fFvAvtMm
         klf9k68dSi0CUQizgOk+OWsodAUtoJTSo47meAdeX/9NRKcji9hdhBcZyU3a7b35XVVY
         DH9AisRVVfLhfy/udG35z2389KxygGWgIF/3F/JYdd2ks6xjup4RnAYhSiRQqnJHS7/G
         9PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657127; x=1794261927;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JasoZs4pU8J575UCokZsfJygggnE4HUTF2MY/ekZJM=;
        b=E0sUA5ie6xKqfK0CJO1z3EORqt3w7db4d6H3KbxGgdvlDFrEtKb0u2Oz8m5wCEdiUR
         czdqTepbyrJtEf53vDsVFP92gqnbqaL524ULrD9HsHf5lIX0y3bz3RVayh2uZUS3Zjru
         zRz+uzSNNe9KqLzTS0LaML+FWzaUrYirmR5ugM4bwrM/Ju3gPp+WekPzwI4Cim91odML
         Jm3uhs50Ib0k7uZJ4pdfj8a9M9u5TuXO1e6Kz/ye3NW8wbdNlPujoTm3j6F7Oa7v4AEX
         7Z3jSo4Vx6RITBPW7ClbEI5jJ8EmTQhlcrvp2Ro9CFeD7NrwNZ5lzT5S+8efq9zvlDgh
         nCJA==
X-Forwarded-Encrypted: i=1; AKwUvBx6W1H5nF9/kDN4J1Kq01kkt7T9hbvY/nMtXl3F64nuiVIE21bWRrZQGULmnIITS2pbS+lTVas=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KdBxK5XFRrBlzIP8cuazWxztyvOd/ADkcfG24DEzUDASLk3a2
	S3TUkmEsz//Evceh3gdvbNAEpdwOzZMfynYTwrf/+GfYCLHKSCY4Ojbk
X-Gm-Gg: AYBFou3IEkN9NKIaGJ1/gvxpiNYWLed9tQNsLlVG2ORuy7QfEmnxWb1rLCWJnCSy6+V
	+z69OiPhUDnr6N3W1OtPKIt361pT8Cus3O5iuGxZAaM/Z+PwR1lMtdYWMx+9/zfexdXMO5e88vC
	pnhet/JJ1moVCevjvD22dajhglXdELJyLpCnnUKWk0VASSRaE9K9x868E9sqDSb7gfCjcOp6EKZ
	9v3dgx4OvWY4U1IcIVwKgXxf59tn8qXe7QeuMJ2r4bEIHWsTLTA7omIoGCTOQ7Y6sfJDsBORTyH
	8Z2OMyjq5FK+isTKXUqKWxAbsrytEJ3e3pXNCu8Ne5nR4x0M5Pu3OVBOPLPWUW7jCYeuD+vSE/m
	gvh8JNn74cKoBOLM2oYfhVPlmjCmL9uv80HYp+dhyJW3/FU4APEQABRwa9ctUq6eG8D/D4et9mL
	8g5T0lCnYRHU6yYF3XsBhm/LaLiXsM9EGMmB+JWpWkY5+z95yizOGGUHdwMqmfKOd8N45epjlQk
	qtYQ3q4ezRkJ+3Fliw0hxM2xvp3Rp/xOdV2O/bmZCmTo/f/KGvxzUF9pUjWddhZxKNBMwfdeANs
	JLvPfGSO/lyv+708MTZeO2wiLDqIaQxYQNZ8E9uujCiS
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr20683512eec.27.1793657127005;
        Mon, 02 Nov 2026 14:05:27 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm38470009eec.19.2026.11.02.14.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:05:26 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Birk Skyum <birk.skyum@pm.me>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: qcom: iris: Wait for threaded IRQ completion during power-off
Date: Tue,  3 Nov 2026 07:05:26 +0900
Message-ID: <20261102220526.1755-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
References: <20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com> <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vishnu,

Without the series, I hit the same deadlock on a Lenovo Y700 Gen 5
(TB323FU, Kaanapali, v7.3-rc). It happened when removing the module
right after a decode session. rmmod waited in __synchronize_irq(),
and the iris IRQ thread in iris_hfi_isr_handler() waited for
core->lock. A loop of decode, rmmod and modprobe reproduced it in
round 4 of 20.

With both patches on v7.3 and out-of-tree Kaanapali support, the same
loop passed 60 of 60 rounds. 2/2 needed context changes only. H.264,
HEVC and VP9 decodes still matched software decoding.

Tested-by: Joonhoe Kim <26rote@gmail.com> # Kaanapali

One question. While core->lock is dropped around disable_irq(), some
callers take core->lock directly rather than through
iris_acquire_core_lock(): iris_hfi_queue_cmd_write(),
iris_set_clocks() and iris_set_interconnects(). These are not held off
by irq_disabling. Also, in iris_core_deinit() the firmware is already
unloaded at that point, while core->state is still IRIS_CORE_INIT. Is
that window meant to be safe?

Thanks,
Joonhoe Kim
