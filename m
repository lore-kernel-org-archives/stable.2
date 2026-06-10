Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22B13DDAE
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096250; cv=none; b=uZhFtbu2AwnDP0I0iG80Kcb8ibBcluWRomkmLlscm4O9TREhPhrelXCnCzywXbhmVqCU1bGSNTisUoIiiPxx9BFhOjxFxPfgxqhLgvDmB/3WPx8Bbf2qREsa7x79AyLH8946SqqdSv7Iu+jFVSl46IruvGdluWY+TxJ0aZVl8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096250; c=relaxed/simple;
	bh=KpIx1agiZkgrFurtoJ1ET+tTDHaal1A3VQITZbFLKeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7kMJdaBZwZQ2powoCZsh5d1g2azc4T7IGNsBp/TBcpn2rUCy0bLqgYshUmUzQD6/DbkrwgM2dCPAHrmO0OJMNV/7oQsAzyBmqaKHuE/nOJR6MfnVwqVMP0Hv5qFTBiAIbajRzQ+S5AmsjujzZ/GOmsZ9+jlWLlV0QwgjnoWy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnXgkwJE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnXgkwJE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eeba68948so4824677f8f.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096247; x=1781701047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0d+zdeqH6lMcQH9MYJ6TD+dtSYgdC4zwQaodD6IKOc=;
        b=bnXgkwJECRpyxDxO3mR9D+1ghNsmeNjn4PGD/neqzOOPe7wWMGoVmU/tV9rYTN/yH5
         0NIRir8Am/LKag4JfMBXCIUNMzKkd3sZPX8fzKgyF/XCcy7oSO7rnFLzTZgIh4Hnq7rW
         W83cBP1C1uiMB55m/4dyh+VwZ5CAwYAMRWIccPMwmVH5zhAH/fB7tHEjNqk7nh5oEXEV
         21/q/vcSMpr0+6y4w20pvowwbUiIZAmUnn9C9m6NOc5UdLQACjvZmvR+U+70WeM3IFBc
         WZGVZHHIM7kMcH7/u0R0EiEK/4MXTm6mU+ec+dnfO5XbRo2/OkhDqBRAlRz+o5YaYDcd
         x4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096247; x=1781701047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0d+zdeqH6lMcQH9MYJ6TD+dtSYgdC4zwQaodD6IKOc=;
        b=ru3tYp0a0sjLO16gWcYd1VOog4H+TcigigF3r7TzCKX8dL1WivWRTdSJIG9HHeKV1Q
         JaSE7Ds/skk23oZ2RiewvmYqvjx9iXwNDJYgMwuc5KutZgDfxK401bDSjeauPXTkkLWx
         exw3bcjKOM2hC7oo2pQQvtZjdFrEBjsuTx4K8UcC+K05D78jFmfdHNbW4iOXTt1E9nlc
         ztWm2W0JuoQi1OaIZ8uO3u3zYvcDzetC/7Hntm0vEQujOBT08iYAGD7QmZMybow423lL
         u76y3xQBxNQMS+OWjxBJmPW5W+/+E6TnJdfjR0s00eq4xI6jXGBU5kWR4casfNfXt1k8
         ApbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+IG466m3Y3+e4DU5hmXZNe6jYjVuT75Nv4KJor/2GIHogbDE62Byp4XdbEznAIEcqGu5A8Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB2uRJcLDspYxMbr4/xod2dL6R+83rP7XPRbtIU5k5HKqJIkjJ
	9SaVCb87cECCvhRIEp3VO08RF2ZXINGLOOMTgOOji4af5dpc3qXdAQI=
X-Gm-Gg: Acq92OGbJrKf1tyrtGJHafDfjh9vP+k2L6pYM6AnEPp1jfPmOoO5gpA6Ib9BSETUUfe
	2G/iIRUEDjDXxJLKsp38PHb2ob3yJQtYgglrzx52FAVMqa+tvohynCPoVz+c7pJFB0K1Kt0354p
	uc6wJmiGwDbsDltftJk1XbLm44IVQNatLArCHEAjkazK4FODEcPY8EYc9ZGB8cmjI3RLpJgXGCG
	InM0rzLCRhvMup9PEaEzwqnljqZLd3R6CGoNnSqrFwTh/0AtOmSkY1TwbphYaMGvsv31XUo6GWQ
	wQnOdDSemulaxlS7+LbNx/6LUWI7t7xbWKbE5K4CpSfBgHAH+JiW/NFq8mGnojgEBPd4hso9XNo
	Nx1SN1afOJT1chBFWP+uNurNMa8RMquH3HCNrNlUvOMSnVtZid3jH2trl3qeu1ZRbldn71nR/u3
	VK/6dLsh68Rh8dEDVYhTSc2zW8CjVQ4h3sQOcurHa7B2HDCps60yphGjB5zVgSz1m8ID4otzgpP
	gg0lmM8elhTuKQ1EZyK41bUZ1G5yeGJLppuNmDukJA1xuaJk210l97A8YnvnZi5+w==
X-Received: by 2002:a05:600c:6384:b0:490:acb8:1490 with SMTP id 5b1f17b1804b1-490c2591e5cmr378024635e9.4.1781096247246;
        Wed, 10 Jun 2026 05:57:27 -0700 (PDT)
Received: from localhost.localdomain ([196.119.91.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm537328905e9.10.2026.06.10.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:57:26 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: quic_vgarodia@quicinc.com,
	quic_dikshita@quicinc.com,
	bryan.odonoghue@linaro.org,
	mchehab@kernel.org
Cc: hverkuil@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] media: venus: fix payload size calculation in parse_raw_formats()
Date: Wed, 10 Jun 2026 13:56:55 +0100
Message-ID: <20260610125655.10517-3-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610125655.10517-1-med08elkadiri@gmail.com>
References: <20260610125655.10517-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consumed size is computed after the loop using the num_planes value
from the last iteration for all entries. When entries have different
plane counts, this produces an incorrect total.

Accumulate the actual size during the loop instead.

Fixes: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index e2af4e9901ee..522bac7ba154 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -171,7 +171,7 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	u32 entries = fmt->format_entries;
 	unsigned int i = 0;
 	u32 num_planes = 0;
-	u32 size;
+	u32 size = 2 * sizeof(u32);
 
 	while (entries) {
 		num_planes = pinfo->num_planes;
@@ -186,6 +186,7 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
 
+		size += sizeof(*constr) * num_planes + 2 * sizeof(u32);
 		pinfo = (void *)pinfo + sizeof(*constr) * num_planes +
 			2 * sizeof(u32);
 		entries--;
@@ -193,8 +194,6 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_raw_fmts, rawfmts, i);
-	size = fmt->format_entries * (sizeof(*constr) * num_planes + 2 * sizeof(u32))
-		+ 2 * sizeof(u32);
 
 	return size;
 }
-- 
2.43.0

