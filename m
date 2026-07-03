Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93630305E10
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096510; cv=none; b=Kk3VcQuz84WP1jNiTMLx6X0mdMSb/6LTqAlx3H0qRHuz3Z3p5ieDtALpsFYBYKp+t7A/QILEVomOwnD5XmBmUNJsz8ZGn+fupyimUbPHzWD1hwZD+tvsLJIv2t0Exl2S3k6d2AXKCC4U2qOnUMFAG5wmGPI2DENbT9+jfSCXDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096510; c=relaxed/simple;
	bh=WdeqKTbBw0p9IN6WCIHfQW9SJlRN9D8ekRRYYDXPGYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hyob2H2VXdbwl8mL2HqEy7LLhh3bGL6A9MciQJChXER2/Ao+N6pJaB2wU2sJQPBmELxZRkCASusrD6vMB/38vxGYS3WNL2sOhfskMkVYoF8DzIWDt5fWXhs4VCVmZFa9Ilh6GsyNYq/mTXqNrewf5B0g9594R6leQKnVDj5ou98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0t6arJr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0t6arJr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c83474ddso7174035e9.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783096507; x=1783701307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELIgzqdNSMVVWgszVoq642vcRbk3MvTzwUI4sM/DChA=;
        b=U0t6arJrWrNySAOsulmooDTgY5VjIUfVjjqwQsOXjXfAvMkaaFxeFE9zZTo54OGIxP
         VgzG1+XNNVydfLOQs6gIQjRv758XTsgIlUsHw1QrDxM/0mx/lQ6a/rqL8ICDbmv/LC05
         q1X4IRwgLahxvKhgTHpRiGtMGKks4I950npo498a7A4SEkPUuuR/UpxxbAFX4cO5492k
         v8GgZKIUG7T1kn4B/My2R1UQmbEvzL7VVpAu1LWTlMvUCS8l1dfsXgDaCnTO1NsUglX0
         cp92xE+jY3BSsJEDR91bRCbkeemadUQqBdQhP3oynQORvZ2lpmKQuXOMLkmMXQgLnWDU
         XObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783096507; x=1783701307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELIgzqdNSMVVWgszVoq642vcRbk3MvTzwUI4sM/DChA=;
        b=M/sdT4ILb3llwE8iutx2vBwAhmkq4MkYZfwDmwdC7hElTur6YNbzjxd1mrgXHUD6Em
         RmgQeTMHjWwk3zPR29nBANDvODYtxJcyjy0+I5FDL5tyxfcwoHjp0dsrAG7QxJ/n6bUa
         LxCf7XC0FE+dDz6TECfE9ivYGyGVPVK3J0LPqe+1DSXbEYAt02sMsWotph4h95i45Wks
         8NaEb+qdXTFnV0GoJhggULG0jZZIshnLWsBFvv2Hdu5D9Z7s6Xn/xQpwbkymbuUoJFWR
         /RCr6O8f6NGoHBFnGrY2OIN4yQLjpBA1n4tO7IEDo6K56d1H/Kzp3Uol/SUilht8xtC2
         tJxA==
X-Forwarded-Encrypted: i=1; AFNElJ+U5+qMJ1Ud/RlI4Cmq0I42oE16K3m6QkBrvGbT7V3yqiUl2zmLKIRe2l9AtYjsQLdaQGG0ebs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCmGcqpift8oq5MTGK4cj6JlL42EeTI54SJw7RPDoSKXyjRsK
	zZeMYa+JRGp9WURBzfNsAu7s/ctaXqAf5aYWiF08r8Tul1Ero873AnHk
X-Gm-Gg: AfdE7ckbwSGl6glrRRTJnwEhEfvNzLyLa5qqr3UM3Piy9VXSn6ltEUsJqCAqWZ4gSHj
	DukW4dZw+SR3HIUdIJZG+PPulktn9ttOqJjoHSF+w65bISzhCc3b5tMWCFbIWyXRZWDlj5W0GEB
	aSmAwLXZs7Utf7quVdE396qT3ckO8BJGE+S9MeOB10iujjoR0hPeTgmtOsAhV+fahNinM3FRt6v
	Yvy2G9O2AKCFhFdASOu08PCNKqK3O1b9F4aJD/7g6VM3RtzjdtQaQYYUQuEnYZzJ4X51RaCwdY3
	MiHud3MTpafYypMVSOGCqvdFs2bg6HZVZIchk5J5zSs+ttGYOr/UWgSsEJ/HFXv8NhecO17cIhB
	YWJ32WizwQ/0tibvV3KIVcR5xhmj5JpamzsiEEjUNvrs4Bl/bDubkMo4NBTt85U4i1VtZD7ebXm
	u9fYBM80VSKrpgfr5DNPJF3fYEU7a9cUafljji6gs7zNIR/SrYkvtt4gifAGmzgLZ5wkw4GJRC
X-Received: by 2002:a05:600c:314f:b0:493:cfd2:cd06 with SMTP id 5b1f17b1804b1-493d11cef20mr620455e9.6.1783096506606;
        Fri, 03 Jul 2026 09:35:06 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm81986795e9.10.2026.07.03.09.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:35:06 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: dan.scally@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: mali-c55: Fix clock leak on reset deassert failure
Date: Fri,  3 Jul 2026 17:35:03 +0100
Message-ID: <20260703163503.715606-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__mali_c55_power_on() enables the clocks before deasserting the resets,
but bails out on a deassert failure without disabling them again. Both
callers treat a failed power-on as already cleaned up, so the clocks are
left enabled.

Disable them on the error path.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
v2:
 - Add Cc: stable@vger.kernel.org (requested by Jacopo Mondi).
 - Collect Reviewed-by from Daniel Scally and Jacopo Mondi.
 drivers/media/platform/arm/mali-c55/mali-c55-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index ee4a42674..fb81141d1 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -699,6 +699,8 @@ static int __mali_c55_power_on(struct mali_c55 *mali_c55)
 					  mali_c55->resets);
 	if (ret) {
 		dev_err(mali_c55->dev, "failed to deassert resets\n");
+		clk_bulk_disable_unprepare(ARRAY_SIZE(mali_c55->clks),
+					   mali_c55->clks);
 		return ret;
 	}
 
-- 
2.53.0

