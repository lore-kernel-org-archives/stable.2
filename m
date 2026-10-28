Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219215;
	b=KBadzbGdke+CN8npN/B/hMrsKiyV86XG9thjm/GspeUeSAbpWvpJjeDXycN55tLUmxLa
	 z/6aHYi+AS9sL+ytgejVuyAf3K9RXJ9Snj+Qa96K5t+kR68jXmMjWTSa0UTDeTtLDkCP1
	 6a1aC/uQFMQBBpKzh9S6XgWzyhlk8WKQJNoAnOqmOvMK42j6zACgPxBcbQWYujc15egpx
	 JoV4AR9M2e2kIJ22cja5P6+vI2Am7oPjxGIcPUnrvGeU+7SImkHY0wzaZOaW8qnBaZ10M
	 4Y8BjN8Go5nVZ5aA4xn/YHzMJ9QXwS5FLrFGj0LMEo3MWFQRgvHs80xjJVaJp+unm4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
	b=wsJxOrzii9CCFSambnJAAmNiq7Sa2ZjfCnoADpi8nA+aNgPDRsI1gjpfDl8KqCi1d7V3
	 RIjYm5ATYrQHgxyB99HSgxaFJ/45a5B4KkA1s/RIynW8Z0ozyisUkzEdOSJvOW5t6TOOn
	 H40xJlTUCZK2ksDDmx2WYN8S3Sk53PbQ8dcuJ3la0ZOwm8tkMN+KcgriA9EQxGYwwyhv/
	 5VmYBWX56Ob2mDWg6K/mXJGvE8zGMk9sxHiq7mtgIwkTTCM7Bdk65eq+BGhqQwmdcVBdI
	 39OEIw1jk1BqiQ4WQCE1GrLDGMZiMlBO+Dgnis2AYWdKL8GRTPb6CR8mlsX5e1DzM6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwT2qUnw;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC077606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC077606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwT2qUnw
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533861a59b8so19494781cf.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793219214; x=1793824014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
        b=vwT2qUnwCcyqrBLe5yU2QUhYPFrQky4u/9cc9p/Y7MeNdAzA8l3o9vtn08ilBkQZjw
         UHrRP3+IBsEod4L+OcsPisU15jdjX9PeqQl0rOgLxhmQeacNXwmO+Tm4yxlJzWoOA8PJ
         CVlOH45GgL7cR6phz1v0w+ns22coJWF+19Hs4zYWXsz/W1AW7ut49RFSui2n8uDfrzTV
         pNpWVLt6Mcc+xfJR+mlEoLnaUTVE/WF6DpVFGyux02pXEFdYvoFZy5/UzK60Tls94XAf
         uD+iwIvBPVUivQJvQQm6FiCfVB6/aec6Z/KPBkfJqGwW5RLVBzJh2w1WYQdZySiY7Z+H
         lR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219214; x=1793824014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
        b=J2l9yh200cJfjmszQMF/S+OGNDF/+VqSQvDUNfY7QEvmoFF/v6s/1HK5azHc0gODjf
         5sPgYjhEeQfx5m9kFCsiOEw1sdHk7jBugzu9GpeZx7CLWIgwUZLsywc8SmOsV+O8sHMD
         NgihvKc4XIcmhhMYjMNmrkXKPZDSUAPqv2n1O1j5XfputtBhHOgD28MPd7PcpyTNveoB
         V+3GoHMXOKUJmbN76t+5GdC0GsDlZvUVXyyNZYoimngWEMRtlqIY7tgcIrOwc6EIpNG9
         0/MARFBk+9DUJQaU+hrm6hpQOuIp7CzkLYx525Cub+EZTFgsV4DJ4FdoD4mzFqBL2c9Z
         LV4A==
X-Forwarded-Encrypted: i=1; AKwUvBy+g0mYlLQ+tj+EOTopPBmA9iGPXlXDUSQiXetN4+b/PcpUgfwey9AzC4TXR2upQx08cVqUnZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgqnEZgN8LY9DMWi5+SlRdSHuW8SPreQvceBn0Srak3XqVMwbe
	gvVEQVCssjuAA26yI1Z79I8glJlu8feoo73cGV16kQ6dQdJGfB9VaJr8
X-Gm-Gg: AYBFou0EyVdy5VLGE+51URY/CgyXuZXMGk3s27qe/cs1iA9AQc0Vnh4rGwMwI5i36PW
	/0lynwb8u1VMAOV7hMN7C6oudz9gi7vd0ndvuKcFQJ/00UCT8Qt/Wd3dQblMc5tQfznLVeQ/B+c
	ycoWSwer5CveqUVwLvXf2oxDlfijT6FSowdWnCTLNC3ZOJeuHSm6rXl6UmWWWlPXFQh9Vj81VGj
	CM5GrzzN1Mx39niIvXtzlE5lai+LCt41LAHGA4evUOiGOE9JEfe8tQJP/mYO/m1OKC4FM3giCLl
	5zo/qnJ5c2GErQIPt+3eakDnr69AH95yyW7tyc7R6x2uC8r4rV4Zpk9IxO0vDI0/Rc1g/cN5J8V
	PWg175ogTv0cf69HplKfNrc0g05OixiMgOYZS1As3ruZEeVJjmsVcRvjR+jjcZxZYxfQVrUTUc+
	yPZZwsRd3d3qtm0/Z04H2Ie075jVC9UAgVH8plVDxzzkAgpAisO3BSDAc8H46y5hBZWbQPcaQ9q
	Xrmr6WfyHZ+tJlOwe7aRTbb54uvx+hhvydBvVJzCU3/VeGFUtHg2JhBhLIHxmORPlCIMKy/7KkU
	+FpkjyqzwiBJGY+P1g2IdtY/K7zwLwRSTnI=
X-Received: by 2002:a05:622a:90b:b0:535:cc6:659 with SMTP id d75a77b69052e-53fcb7fb52emr58748511cf.37.1793219213813;
        Wed, 28 Oct 2026 13:26:53 -0700 (PDT)
Received: from falcon.baltimore.nuwat.tech ([2601:14d:5284:47e0::1262])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c8d5ee885sm10190956d6.41.2026.10.28.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:26:53 -0700 (PDT)
From: Abdulla Bubshait <darkstego@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	dominik.kaszewski@amd.com,
	dri-devel@lists.freedesktop.org,
	Abdulla Bubshait <darkstego@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Abort DPMS ON when enabling the link fails
Date: Wed, 28 Oct 2026 16:26:41 -0400
Message-ID: <20261028202641.549955-1-darkstego@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since commit 843049bac7c0 ("drm/amd/display: Split DPMS ON into
parts"), link_set_dpms_on_enable_link() returns
DC_DPMS_FAILED_HANDSHAKE when enable_link() fails and the stream
enable has to be aborted: any failure other than link training, or a
link training failure on DP MST. The link has already been disabled at
that point. The step loop in link_set_dpms_on() treats
DC_DPMS_FAILED_HANDSHAKE like DC_DPMS_SUCCESS and goes on to
link_set_dpms_on_post_enable_link().

Before the split, this path returned right after disable_link(),
because MST displays can't proceed without link training. Now, for
failed MST handshakes MST slots are still allocated.  When the link
trains again later, the new payload starts after the leaked slots so
ACT never completes, and the display stays black until
reboot. Replugging or power-cycling the monitor does not recover it.

Seen on Navi 33 (DCN 3.2.1) with a DP 2.1 MST monitor (Odyssey Neo G9)
at UHBR10 x4 with DSC. Link training sometimes fails on DPMS
wake. With this change, the failed attempt leaves no payload behind,
and the next modeset after the sink reconnects bring the monito back
up.

Return early on DC_DPMS_FAILED_HANDSHAKE, as for
DC_DPMS_SKIPPED_HANDSHAKE. This restores the pre-split behaviour. Link
training failures on non-MST signals still return DC_DPMS_SUCCESS and
continue as before.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6047
Fixes: 843049bac7c0 ("drm/amd/display: Split DPMS ON into parts")
Cc: stable@vger.kernel.org # 7.3
Signed-off-by: Abdulla Bubshait <darkstego@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 75e232ebffe8..b355e29b178d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2813,11 +2813,11 @@ enum dc_status link_set_dpms_on(
 
 		switch (step_result) {
 		case DC_DPMS_SUCCESS:
-		case DC_DPMS_FAILED_HANDSHAKE:
 			// Enum is ordered from "best" to "worst" results
 			result = max(result, step_result);
 			break;
 
+		case DC_DPMS_FAILED_HANDSHAKE:
 		case DC_DPMS_SKIPPED_HANDSHAKE:
 			return step_result;
 
-- 
2.56.0

