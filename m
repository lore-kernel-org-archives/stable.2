Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3470379EC1
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091733; cv=none; b=swTR9YtGpQGIe+5+VbYw1Bf7MdQHkNeYegdl8WwCACP08Oh7pDtA6tscKJ2bDXdtcZAwKw7DvU0JuUp0ja0M2nHhW0l6myYVKhk84eNu5cggzsHOGjRDgZwM7+IL1Uan1IKlctufU4oTYqj5bsug58lvDxz2F8SQjpyWR56bX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091733; c=relaxed/simple;
	bh=jgKmE1kKV3b0d5YkmqgCMwOqD04XBbTPa52jDu60x38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tmh0ZOW//oHHNNAG68WpEV8TYCxhVkO4mZeMtWW9pRR/UhG7CO/zvqp4cbfQVy14iPFZFOsZm9hOYT96d6mizDulBts2E2j8gsDhD4lMP0cvqTzzyJZtK80AWInTwGrWZqR6niTftxFGEzrfyW9gmJAZax+3rhrwrl1WUlX1rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTw1L5UK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTw1L5UK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5177ad0cc67so53178761cf.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781091731; x=1781696531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hVbBOpXU3AVgTPjwcETSFcTXwEq2neK+pOPLd5Ot08=;
        b=KTw1L5UKfMETMIMbJwdr9RWuAotGLadwjsnKaZPnXJTr1zFzGUJRITSqSXtd6YbZIU
         XKZLDGyIn58qQdWoAdGO0JqYwD0hNeKxQJ8BxBdqeCegL/zP0E3Peq1d89CyCpY67unD
         mbNeLXa5tSgI/Z7uo9V0htsNydT0hXWwOFpTne1JerpEZ2kKkpuJ9rHwfpmoDQ1XtEFi
         YJWhE9lGPsR17+9Z4Sxhh5P0ByTPpdzzoSW3xy1fjddZq2lOUnq4l/5Hdj7gP+y1JSLu
         HAjrf3CLbakmXgi5VuhT6ns4VCExYSRFgfTxLq3GG3CaqZDJqStXXyoR0LzSa6cQegiO
         PW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091731; x=1781696531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hVbBOpXU3AVgTPjwcETSFcTXwEq2neK+pOPLd5Ot08=;
        b=QWc16WJFhx8vNqpOuYIJ8XsGPNrTonCT1150xsVZzil1K0lsllb/p8SEG02HAMa/Rf
         J4MK89y3sh/MT+Bra1Tuo0Enx6dU0W18j2FmKTo8Yk+WWARWkP/ADG9fs27O4fHIn+z1
         Re13Iv4ENui7p7Cbunjnj+jP1YS9FYuc4l778W94QOj9hyqvwBgmoMjJ+TqYDt9oP7Vd
         PpRgusPtrfEMQLgLN6Z4E73kLrRLRoZG6gDp385jHtAodawd9fOPU1tMN6xB9qOIZR1A
         wo6U4161s42HcWBrqAVvtDWUYa/9kYSU5NvNhmdl/LcKhQykS8q7a+QeBACchMNLEuMN
         RD6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+H1/tLETYnp7bfH8LKKl0+CpAS6WOTykk9vTfsrehAt4S3G2viUi20Ph9ZTvZlg/xeqLVJlYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmOHvRhxJaaLyuyO9EEF/wyT3VJuIQyTKPrIZ8GN+X2BDhXAS
	A2xXskvRyTuxckCiwntdruEbZMX83rgpwssEf3HOSqzA4yBxgTIhNZiJ/fvIIvtDilk=
X-Gm-Gg: Acq92OES+xFVATJ56OStyBtX+/LNrelGuUyfdiKgOhikCj2fsOMRGEMSFmIzR85J59D
	GbVP7ef47q2/JuggUxo29lI7egeq4fdXcdpDQ8c/xqtNRmENExga/bNqa1etPKDAy809PJPuXaZ
	Pwc9VEQ8CiGVjPlrC0/AOAjLvf2Pfzm2qI0Q1Ibl8mpLGu5l3bQmfUY+5JmgiNhWrof86ZqBiyf
	FTrF0pqGgZ1OT+5Knv3fWKpZUFPIKGXap5kUiUFElmhqM4/7/OF78YFXCftnlE+wxOV1Upnq/Pm
	YnfiCtqq/znQot4l7mEC1QlLG1TMkKO88shSggzHCFQpE7Dhy6XbEpuOZbQB+VPS2HNiz/xl1Af
	tvyeQnX4BVGPyyghpJ4hVQ20cdQXxb3k5qw8AMnR/2W4QSxiylDuLVYBKKGrYk1RCMMMuGk5QsL
	gxOC4rVDLNpE7JUlWNVBczpCjEZvumsaL1Zdlx8ubLjme7EGs+lPDlZufFfpdyfUteFrsTBKMJj
	6YrN6UGRx1hsje/Ffth+svvXdzIP/0=
X-Received: by 2002:a05:622a:8d04:b0:517:a02f:171e with SMTP id d75a77b69052e-517a02f1fb5mr305363591cf.30.1781091730803;
        Wed, 10 Jun 2026 04:42:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm216095931cf.4.2026.06.10.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:42:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
Date: Wed, 10 Jun 2026 07:42:06 -0400
Message-ID: <20260610114206.3749904-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

p9_mount_tag_show() copies strlen(chan->tag) + 1 bytes into the
single-page buffer the sysfs core provides, with no upper bound. The
mount tag length comes from virtio_9p_config.tag_len, a 16-bit field read
from the device at probe in p9_virtio_probe() with no cap. Under the
confidential-computing threat model, where the guest does not trust the
host, a malicious or compromised host can present a 65535-byte tag with
no embedded NUL. A read of the world-readable /sys/.../mount_tag
attribute (udev reads it at probe) then copies ~64 KiB into the 4 KiB
sysfs page, a slab-out-of-bounds write of host-controlled content.

Bound the copy to the page size in the show handler.

Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in p9_mount_tag_show()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/9p/trans_virtio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 4cdab7094b273..b62aa7b309f1c 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -573,7 +573,11 @@ static ssize_t p9_mount_tag_show(struct device *dev,
 	chan = vdev->priv;
 	tag_len = strlen(chan->tag);
 
-	memcpy(buf, chan->tag, tag_len + 1);
+	if (tag_len > PAGE_SIZE - 2)
+		tag_len = PAGE_SIZE - 2;
+
+	memcpy(buf, chan->tag, tag_len);
+	buf[tag_len] = '\0';
 
 	return tag_len + 1;
 }
-- 
2.53.0

