Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C528030E
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320394; cv=none; b=gtWcYzD5wJSoOikAiBFWEh6YyZS1fBTBhyxlCv8WSqm5YqwvhAjbOaUmk8ExUAYIW36UtmcLGoqKhRhO0/p5VGPfHa/BfrimgiEkkkiy0Wc2MafaXaqqtPLHgg4dohgE9hw/xqUM8r2ZCZZwikbiBpPiN1sAc29DDDo0PUoBHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320394; c=relaxed/simple;
	bh=SQ/SYrXh+5CwEvrwpxtX23+FbGxGlYtGDGs1ObPCCVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAM6KL+1mfEassZ3W+ZigpCaPqcZ0WiTOG1YjBRsL6BhVoMgQXIwgjILXyy2J5myf3qk8N7Al11xYO9f8Sggw0pnQI3bhKiCPk9piRieAN1TY7J516mEM+/p3LlBaoHjSiftVHHuriTSS8+T8ugxz5ub9enMeBaRCF6LqTdOvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OibLzQWa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OibLzQWa"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8874539bccbso675864b3a.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320392; x=1792925192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3dVKKN3DPlm8bXuDignnQ0HmpnRMQ+D7u3OnuhG2rs=;
        b=OibLzQWaL0sxmeyFrEvLsDzlVKemXLdZeCQuQFPHTnGYElO+6bQf1FqHisHrRIoCQJ
         1L8UcVPU8+t0I/ehHhAex681Sh8Z2CwLDO8K5s9S1lTylCYUMdJ0DkV4WB5zLzxG3Wvt
         JYYaxSJ3bMjJCGS0jZSjmRYN42VtJYV4UEQBhRVB3EE02bwnpgycbdwHAws9l5ELv4et
         q4TD8muxM2va7YHfgFW1qonMei1ZL6LZ+0kr0DWI3FOSH3jbJgprEUNvTjP2YenVUXGv
         bi8rkvItU2nF4AYcPPcS0EQrPnkgvf869Rv1bhKseNkZSw5ZhvMq4Xoukg9NXNq+SWwc
         ZZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320392; x=1792925192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3dVKKN3DPlm8bXuDignnQ0HmpnRMQ+D7u3OnuhG2rs=;
        b=NNalUxVCK+JvuLxkE1HBSyb/ajRTp/ZRtTdCJN9DC+j/Cu3tQmiNfvFn9M9j+1kIRO
         IyNBmiacdpvFM0GRtjR1coy+BD4BZmCG7/EYwvdry+XFwWlCBg7PcTVLOYwTASfPMN7V
         pr9H26/gJ0s0FRx5DOqfTzw/Kf4PCPgBR/LOr+Fma7qYN9db66oJNgw/GP9mWGLMovzF
         DA1ft+pCy8fw2/0UBxKAWJVITJ+ELI9m1ASap0cgKJsjHnCa9DDiY99fmzM/JN8GIHNj
         HUd3IXFWkJqPb0mmuX60iVjBtOigLYG/4yTcCJLO3tP4kBLFCXx9Q0kRpmpyosJ1qUIv
         yrrA==
X-Forwarded-Encrypted: i=1; AKwUvBzYWunyFIz652Rt/2v/tgXJxzDZZmaL2b1T7SpH+KT8jiFbaeKk9jeI1yk3IESwcPhNzxzSPGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcR14ktQiWSDN9u6Db7u97OvcrnorsWTfRITQdKjAa/K4mp5hX
	bRzMkvngmgHaoxq9P99fPWDWc6EgxJzXXz7xzt7JlW9s8edWcgJDxS5R
X-Gm-Gg: AYBFou1KGTB1iGSH1FvKTLuUygQTFBujYL6sHx5/VSOLGvye9rQ+ehCBg+Zmk/XkDSw
	q+wIR87u3jbB7TWeAVWwS84Mldbc7tiJdDE4Mbk2RsR2aE2tBRr5r0GNG709DDFr1yUXM2qRx6Q
	5PMA2gRF3a9E8KFspVs5McKxAN99ARLFCyRLscR0VmjTzkCsok6yi/3e7pVAoNedNUYohF0KBAR
	AOTUld4aRQ0/U5inLswYEBQlCtiLBKplQAmwKhf5LP2kE1T1m1QQ6daYheVWf9vSNzonuJ3xDMt
	YT4Nhnp8+CSzKSYKB17uWmRRDccdW4ZJU98ObHALPN6MsH/Q4RGZ8CvtImrnk8r5g+i35X7WVhu
	Cyq8MvBgob4JqGHfX7aDSuUMbYFPCg7p7mv7RAkFwQHU0JCAXB0zvRfT+dwYa6Q2pL99easFWcJ
	m4fnoYd/1XgUvto+eoBhoc2Dk1s2ypKj+Y2QKUIJru8vWuipvp+xKowzuvZyPt/2Qcmd1eGJ+qV
	oFW2UI2tvHqZa/Z4y/6j8M=
X-Received: by 2002:a05:6a20:cd90:b0:3e0:d4eb:a9b4 with SMTP id adf61e73a8af0-3e2263d3801mr3823884637.45.1792320392419;
        Sun, 18 Oct 2026 03:46:32 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:31 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 3/5] HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
Date: Sun, 18 Oct 2026 19:46:15 +0900
Message-ID: <20261018104617.743771-4-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018104617.743771-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018104617.743771-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() uses wacom->pad_input throughout, but pad_input can
be NULL when wacom_setup_pad_input_capabilities() returns -ENODEV during
a successful probe.

Place the guard after the data[0] report-ID check and return 1 so the
report is consumed. Returning 0 would let the caller fall through to
wacom_intuos_inout(), which would misparse the pad packet as a pen
event.

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index aa08afb3c5ef..acf24360d547 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -578,6 +578,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	      data[0] == WACOM_REPORT_CINTIQPAD))
 		return 0;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return 1; /* consume the report to prevent fall-through */
+	}
+
 	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 		buttons = (data[3] << 1) | (data[2] & 0x01);
 		ring1 = data[1];
-- 
2.53.0

