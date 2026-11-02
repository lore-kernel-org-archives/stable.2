Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654203;
	b=JKujiZzj9WIk3HHwZekhbTMw+UGnR2x1yEhhUmnJjPjwm+TIncELkMZUAFLsYHWpof9r
	 bVMSMURxE7TAFr0E6KYnNgfMPZMFUUDrwbSR/tXbLNi/+tddQlrhKflfetYxGiLD78XVf
	 b6QFyoD2jruwFoeOe6Zt0Fdam9mmuwvfqP6x0en6ayjl3N//3VuJdvPlOsQDqEkW6eruF
	 zud8OV9Uxo1VvWQE6TAbvsO2fMB11YDEMizqEm6f8zIV6JO7WW6Xz92pYHilg5C5U9JOd
	 quId4BhEcudQq4QxBd0QtIPUlLDidMj/kxywTC3ZC6Pd3VB1MFHLEc1wWbZqlXbKRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654203;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
	b=t8dz962+LYplXovooO7dxGYJNkMHRNCBSSlBfMmuquWK3YM1e59+IeDvoyjxLloVtxGX
	 IVpvpumk1F0imHV2UyFYyY6cENea1HKH9WUU6H6/yO7Z2+d2k1LKGRlV3LeciWRDmw4yV
	 NpSyxKUU5ND1zUbGEyF81D2r0xSkpiIVnHx8ZS+r1ysQkkS7CWjM6cN/qEAesi1wV8ZKM
	 RGxLqCnEFroS7kZBId0prVLdN49Ema7OooeYrZsFGcy5KUMo0Y73WUl6A/C4qyXgsI+Cm
	 +ZrJXkBj+nFV75jNdYw5K0hY7GJ6s8vOci5W0J65AEGTb+LVdevL/AAUndKCPSXmkPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfIZcCjS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aaVfyhdT;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D535606A338
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D535606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfIZcCjS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aaVfyhdT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
	b=KfIZcCjSQp+/TDRQij30V06YWyk70Lc4D8Ks7QqG6b/nilBZIA4kk6nIA9wI6bca5JSyTg
	xhhAo/OlWFgioK4sfqV6oMEHvwCo1B1k3KL9vKCTQ1fUEUPQfcADeomCpLzj5kNtYSSNEC
	HmsiaKQ+t1PL9+Imxv1MoyjEgcjKuEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-KU_vZTSSOki5mFc2pcjNlA-1; Mon, 02 Nov 2026 16:16:39 -0500
X-MC-Unique: KU_vZTSSOki5mFc2pcjNlA-1
X-Mimecast-MFC-AGG-ID: KU_vZTSSOki5mFc2pcjNlA_1793654198
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6e69d62aso4674015e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793654198; x=1794258998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
        b=aaVfyhdTROsZ01EnSiSdVZ7tX/JorVgE9PS05wFmPbmLyclI6ZfmC8yDH6d7z34+5P
         xz2BOwEh1YJubvi57TyNj2UuYK4H2MSYBk1C5vDrJRHw9tBaptnmftSfNTGm/8gkCido
         ShPcO1ary3T8tGeCRnuijl/eVet/lFnqGOh6cquVDqotDCwgzUjTC+y9LD5GKGELGtO4
         4a+cQjxs8oRnGQbB381ImW8eumlcwy85kOVzsM5lVso9corxjvSeJjtjHm9qsGZo7AXk
         07zLKVxWNSBT+YwBjDSsC4s+U4A26GwivOus7178OF2uXBlTBK93iqqfFCeAbvqvoJh8
         gtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654198; x=1794258998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
        b=i1CCub8Y5+WcTPvHNVvsI0J8zmAxg06gZTH+UyDSy19vmSwQafLpu9wXIySASZJZpN
         LtiS99bENA70lbeZ9S9wjHd/+1zPBCrYg2/gF4VMYuL5P0X1V9chTZNdkbbXG5HJiX1H
         b7Gn/hnkWXVVCo8kSZHrFaGJ8BMCymN06A+ZyDhPNBVqeuhAvRcysE/FCvt1FZR8/cQ+
         mJcsEzhPqUE2egCS0M1C2+tZp3PdxBq8lkQzuBkHR5ZdVdfeG9pkEXmDUX8GmCPg+yiP
         4OUPuqQDSlF5NlCqaNrrdm8HeDo8QzhnBOLBDz2Sfp0YULkXaQQWvOXuRitg+mxlMOTV
         i0zQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4eIXNN2FohmAmbopyh7y0DRvbbGHFxDic3hOY4v7A3H8IpJFa7ZpTx4Nxj9BXrypb/+xKnP8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E23wo1g80U3/FLVsHoQdaRGb4+IqjPOw0akgBXq7BUZRwefFo
	JtojU+iF47VOyM0uo/QZAzz7L4BNtt0wJTKuwC36pQtoCPvhxzH354LQM6GLuNcp/g54JhTxTdB
	eTTo2+bFFNK2DkAXcmlvzieQlk56TW3doOz6TISzXpG/cEZiZQtTPT6BnZw==
X-Gm-Gg: AYBFou1OeHIFkpaQuyFO2Qw+GGm6tJ+FSWddJpEIlXOek30qid8xVVH2NgofjZNBQJ7
	ghYg5RB1MojH1D51UqLnd5sjT1bRFc0bqHCDAB9u1gUG4meqEXN9RUPnW2YdX40yamvvbiR3Mi5
	Ynqtbd5xtYnuzedtX1hmt0FURrN4DtfdkuxMb/K+O5LL6vLmVun4LSZKjlJseqJfSZ5JBEGPnk1
	jwR0W8lcUfCHjTymd8HSc5HSge/vV5hWuax+DZkkfKWkMFjt+7iNHgLxuI2u/Ev4LZectDT1bls
	INwGS9A296TCEL6jMu0NwljBRkR9A6ulbkhzOeAuo1n9sTmFZXjGwZeTh4RjCZOTPznf17W7DD2
	VNajgNqlEfE44G+pNs6+JiGbHHc7iAeuWauoG9qKxoD77x2A6UrPt6zbZwrqdw2js+MXhYnu70F
	Ma4Tquu7tH2h/7eQ==
X-Received: by 2002:a5d:5f48:0:b0:48e:6ff2:606a with SMTP id ffacd0b85a97d-48e6ff2609dmr27631591f8f.6.1793654197967;
        Mon, 02 Nov 2026 13:16:37 -0800 (PST)
X-Received: by 2002:a5d:5f48:0:b0:48e:6ff2:606a with SMTP id ffacd0b85a97d-48e6ff2609dmr27631544f8f.6.1793654197560;
        Mon, 02 Nov 2026 13:16:37 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71baa1b3sm20838703f8f.56.2026.11.02.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:37 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 02 Nov 2026 22:16:20 +0100
Subject: [PATCH v2 1/3] clocksource/drivers/nxp-stm: Fix max_delta overflow
 on 64-bit platforms
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
Message-Id: <20261102-nxp-stm-fixes-v2-1-8ca2706f30ef@redhat.com>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
In-Reply-To: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=1278;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=DVfNt64Fa2EP/J0U6rHzSmiL2wOHXcUfdf87XnRZfSg=;
 b=l9hNDdzUrhma71aFw5r9/uBmIB5COcdfl4Gq7cRYpas8co0jiLEqNrhksseawGF7HVyaMLcJR
 wxiPwGkenjpCPQfWwh1t6b2mYj7Q1sJtwNbsSjje6VTqWdOIE/SHRzQ
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

The NXP STM timer has a 32-bit counter and 32-bit compare registers.
Using ULONG_MAX as the max_delta parameter for
clockevents_config_and_register() is incorrect on 64-bit platforms where
unsigned long is 64 bits, as this exceeds the hardware's capability.

Cap the max_delta to 0x7FFFFFFFU to match the 32-bit compare channel
width, avoiding potential timer event misses or unexpected delays caused
by programming an unreachable compare value.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 6fe098a4a33f..ee249fed1b91 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -346,7 +346,7 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	 * minimum ticks = (rate / MICRO) * 2
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, ULONG_MAX);
+					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.56.0

