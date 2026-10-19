Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448800;
	b=KEYFT79ExRGBA7ySYqlZKZnbGabk87HL3bfgAwFeBi6WjR+1wbuOrG+rZUfnYHzjPY/H
	 1nIEVcN2bvQjwqu+o1S6aQtQpRhy9kPhtQbX1cuXxlY88GiNuuCUnWhITXyj8IYbfPht8
	 T3LbAq/03iI1rcbaIDWwc1jG/QQQs10SXK28rbsodAy0g5EYhk21Cc9/NmaAaaK5CNPm6
	 AvVRKVRhRFC3zZV9nKEhMrclZabURUzCdtjsrtCf05qwTbSp19CMGUKbF9LkXEbB8VZyp
	 6PZ1OEgMQ1Q4OyKJzb5uFBNueCaOv2HTatd5rkHWD6KWn3k3PIfs1eRrhQZLMtEAu8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ryRG0e4/3H27Att8+jO3Gq6g8+ldVnq0TGRgHWVLyao=;
	b=yCB56FtcS5yBOXnGMDTGN7e6x5TeJtrAqhX3vZ9KdeulF2VnvCW8yucRvklwBovmjJs/
	 o7WUgIOdtAqHAFtm6C5mc2/BVqUSObhLYisXfgfi/UhzDN7Gv5xLUDbrarHBwlhCkP3Oq
	 uCcPiGbRl/hTYQW23T5dM4ADI5+JbrEVZDw7yNYXGE4ho+36P9YFyHofUXbiASKJTUY+W
	 O64dIzq7uawT9D4kLPXB7MyO0mxPJ6veHRRryu+NZH7mWSAHTmaZfGevy7lV1dwc7VYdN
	 BjtR/IUEtta2Kxgqv6L47Mty6BKuUfoQtN4+q8MGHYk2ugqEbzYWg0RzoLgQB8CEViQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PyoJd5Fa;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7E606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF7E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PyoJd5Fa
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c45111bebso1591505f8f.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792448798; x=1793053598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryRG0e4/3H27Att8+jO3Gq6g8+ldVnq0TGRgHWVLyao=;
        b=PyoJd5Fa6w0NKm6PZgA9niUo5UCGgIWXLWZf4MB4Td1LUV9u98xBgGXAAcFaV+BOWs
         hgowkV2nfK3+613G7WR4V2oLAxCnDj4iyl+52s+AK+AHM6H8fvVXlM2js+J4fCV6P1+V
         gTqnza+7ZPFrMAxxVfLHTNBd9Agu15LHoypNEAbHtjXZxZ9spm4TSzMtis29ctHvC1FI
         40d9TMfLQgS3FFkULWArffUXk5fSsDToNGhoDRJjpxABO6ZbHm4RktKS+K2pEf9fpxqG
         e1FRup0ipAOb9nKvvTPxOOD0bEvJwT71DVhJxb7+JuPDNTRtzhNmrOubY2NsO6Dno55A
         sPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448798; x=1793053598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryRG0e4/3H27Att8+jO3Gq6g8+ldVnq0TGRgHWVLyao=;
        b=lLdrnqIviBht2OJa3AHuPf5hbHvOJz6KPfFBTGrcsgKO4yoeHjUgqSXoXYEVu9cQ3F
         0QLFI4QfC4RnK80X/+QLjOkFLrlQJa0X2CCzRTklzfd2MbhMxQy7KEel0MeXYJzFIRJ9
         AEcNO5dyUBG+IonMMtajhA0Xyy9fFMErbr05EQLoIMhxUjAckfzq8fr2NcG5LNPB1xwy
         +qgYC3KgUHM/Su2FTDAtyzhi3t5PdiKZEng5ntDdjArbpvhHoVamlO4hoVIvqEiG1OE4
         Zkf2BR22qYwiCJwSNkRtDdVmzLW5EPBPH34B+Wu0c0DaVonJv/BxaZ3uYamz540jApI4
         7KOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSsGe5Nbix+2mrSApVZyL6W0mcrZkMoS2CESS8CBaNTBPfUD2bnOOBrmX1N82WqPiN8QbCkSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvUgwzPfQMYsnvHAmM9RJQhLLV6ch9Rb4rP5iNJYTCydYzsPvu
	olavz6Wmfp49IgV6SfyXCaWAcYcKVAQhp1y74rGtKvjMYMDejDudQ7ZrKrm9
X-Gm-Gg: AYBFou3yPCzhxZ7aE7O8wRYhiIEvAPBkT/RqzJ6liyCetRwqfL10KaqaqCWDIaCQSZe
	WXzBoaLgUS227awXSFXoYeTWA5jWsUwOjIg3y2nC+joLlm/01GIVsR8kaMJg4zXVXvq/Py8BPhH
	HSAf79HKRcZQI5Q4eFpLreKoLx+heuuX3FFs+sxbgnrmUaphmE8mwL9HWisRto9rC9j4hAbNQSo
	5FFThy8jz9YA7/AICt11M9d7UQHtp1pBbyt34WUH/8oqKyHuKmoyoUfv/D9fH4QvQCwAq8VdMEN
	MJev33BWHOgQkOwHXbjG8oRUiem+X20Z9L0HHW/TBLzifGRL6h9LKhxizToD3abi2Wtc0xM+LWW
	HDXINapcTdjC83QwbXrJzdNSBNriDxiHzDpJQz5MWBfupWbZjHfMKLStHd17iRVQsil39CpuX+S
	88tONrE9xWuyerriijl+3LQB0iR5mLwkGCWCF1Bns=
X-Received: by 2002:a05:6000:38d:b0:48e:884:c70e with SMTP id ffacd0b85a97d-48e0884c755mr20966448f8f.33.1792448797908;
        Mon, 19 Oct 2026 15:26:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818c59sm1784977f8f.30.2026.10.19.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:26:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] cpufreq: intel_pstate: cancel HWP notify work in driver cleanup
Date: Mon, 19 Oct 2026 22:26:35 +0000
Message-ID: <20261019222635.1741146-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

intel_pstate_driver_cleanup() frees per-CPU data without cancelling the
pending HWP notify delayed work. If hwp_notify_work is still scheduled
or running when the struct is freed, the work function accesses freed
memory via container_of().

Call intel_pstate_disable_hwp_interrupt() before kfree() to disable
the interrupt source and cancel the pending work, matching the pattern
used in intel_pstate_suspend() and intel_pstate_hwp_offline().

Fixes: d0e936adfe84 ("cpufreq: intel_pstate: Add HWP_HIGHEST_PERF_CHANGE handling")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb25dd89..0e6ae4cdda5de 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3436,6 +3436,8 @@ static void intel_pstate_driver_cleanup(void)
 			if (intel_pstate_driver == &intel_pstate)
 				intel_pstate_clear_update_util_hook(cpu);
 
+			intel_pstate_disable_hwp_interrupt(all_cpu_data[cpu]);
+
 			kfree(all_cpu_data[cpu]);
 			WRITE_ONCE(all_cpu_data[cpu], NULL);
 		}
-- 
2.47.3

