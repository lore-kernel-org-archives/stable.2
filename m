Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28E1A683D
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786772447; cv=none; b=T1JoIWSBRzcNIJHPZEB9bEwv9mcQAXT2GD+xV08s8mHTVKq6G/L2jwCFlTiw5QJW5QZLPYLyCn6MZjShBNmHz/f6jAvIi017eRwf+168xLcZQfsEzY7T7b0fZqIw3IosPWSFbOHRKCachJ0ezmTqm2jNEqFvyfnF0O7P52pr+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786772447; c=relaxed/simple;
	bh=RKr8wDx4vfIVDxaydRzoEQ7U5kq6zGMwRmAGuw0kiFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbeBOMy0fMONJVYVen2OwsjbRh3BRGu63JO0KAjDO076ecBYwlRPPt7dqpLibkj0hZSXLJZOS1NIj3uIXMz9KBEW7SJyn6KCp9WvdZnEwrZfD0OPy/qPEDtxpvORu0qX4ADEAloMbv0jUg0VQmJTQ7WmyVySCPdbPSitv8LuRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqSFZx6V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqSFZx6V"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc97653887so29313125ad.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786772445; x=1787377245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xRZrKjh8gSRFHQ09WnLqzB2J4uOH4YDnOZFIpu3HY00=;
        b=QqSFZx6Vi/qMcrp+18GwQQlQv7VzP2kxObCUH5kH0AsBU4tsGpKFb7MKOg4QwvK+y0
         H6vobr1vPQ+Kminc2iuX73uGHwNpkh0jA9LDQEFhn0ebyt3MOGKromX2O5Z+1DxyJIk/
         shKxzYzOBiIeWCVTBASGZq3KhqhD7Kq1r/OXXB26LgjWX5ZnEu28xGLBn3YhDQcjAGBR
         BFWgdvC26uu99Yze+QECbiL+MbGChCtqc0i7vznLbxDOlcxBUzkT8bX9mPZNQ/9o9GOR
         tcgE9hHuFEWP9WhjJsVLAq81uR/GVs+iBQTeEUPrNXr1g+l8ZlaMmKeNcMnHwMRDs2Kx
         Mgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786772445; x=1787377245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRZrKjh8gSRFHQ09WnLqzB2J4uOH4YDnOZFIpu3HY00=;
        b=K1m6u+YlMvuYKFCyy+RotEaBJVa8FQnrx+FXUFxT0P/57BxabDXy0x3l2OCicb+OJa
         igkEDhqZ0729h1gU1LNaEjGI8YsT/QziLe4FpVw5JVdfCEg0SzJRjZYeoRbTxzPhN1Y+
         fCXF0tv6ZwUA6m9eSojSHvsGXmXmqnNljLZEtMG6zqAUWoK9TH55TqGgjbZF2xTv9/MF
         7TOMGLwq41ozAl/dLO97uH9m4rn6yNeCK5N8wJ07BH7glOzHvmEhiNE1CKKZrGppOodB
         wGqprlQePnlzapYT17i0jPZnnBSIaZCv2FeDN0ZkChUqmgfEKsckrCfH67BngOcIdGLr
         lJbw==
X-Forwarded-Encrypted: i=1; AHgh+RrwVLirovBxegJUhF4EQluEy5V50VOIaHTc83yZ2SVo/WWgOnx6POXHs+7Ue1Me/YmakZSPAlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEiQjXZQzza5W0g2KnTaBLJLABK/ij4Z1jo2EdqiMJNmFuRdL
	sl4/+isjGYbVLu/VnTWxLyfexL0c5lZMmOwpXJC6LSAL+N+fridLNi4Y
X-Gm-Gg: AR+sD10m5Lg+z47020p1Ktw4+1OXypdFs+cXsiY4amREjB352R6kBIKQbk+tHCu3yTi
	eddIUzg7t/3edcw+hBW+iyZIn/xRcUTe5vD5coQIWCaXh7HH6pDwwHeVQ7bUjIJtW5q2zb4/U83
	EMZKUZYAsOt0pGjq4SIPkYdWzEQCM35fuzZ/khj0In3R2Gf2zw9B/5YW4+gqSL0hPkPpcrRmBeF
	m19VE08TGBybiOZwc8EBrVAoMAEjP598K1JoUBsaEPocpykoI/jQCAnW/xQcXmKURcZRUSd70Ez
	7hIzArIpWttaB/8zIb1Y7rrGoIJVpFIW5HrFUjwahm9V8URRItvnmDeA+MQrEvEhPvh8C4S3cg3
	IW2VxuiHrXozIaL/GBS8Dk+h18ZKJwDRUby0t6xHl2/S6ND6MfyWFCL1Appn0GbNPDcW7Bj/Zii
	y5EhH9oEBtGZ5pUM8LyrM7lUuf3RbUAvK73Y/EPY0MYPLQNJNw3Q5WEct3XJmeDxLoqfxFNZasA
	reZoDBGUw==
X-Received: by 2002:a17:902:fd90:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2d3b0d16339mr129547175ad.7.1786772445466;
        Fri, 14 Aug 2026 22:40:45 -0700 (PDT)
Received: from Default ([2409:40f4:103d:c2fd:25e5:83d3:7385:6296])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fd3sm11025097eec.4.2026.08.14.22.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 22:40:44 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jeffinphilip14@gmail.com,
	victor.krawiec@arturia.com,
	fanwu01@zju.edu.cn,
	christophe.jaillet@wanadoo.fr,
	kees@kernel.org,
	balbi@kernel.org,
	tiwai@suse.de,
	dave@stgolabs.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+d5fa3d224505c8610702@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: f_midi: initialize work in f_midi_alloc()
Date: Sat, 15 Aug 2026 11:10:06 +0530
Message-ID: <20260815054006.102325-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f_midi_alloc initializes free_ref to 1 and it can only be incremented
when a sound card is registered via f_midi_register_card().
f_midi_register_card() is only called in f_midi_bind() which actually
performs INIT_WORK. If f_midi_bind() is never run, work is not
initialized and the if condition in f_midi_free becomes true,
this results in a warning later in __flush_work as work->func = 0.
Fix this by moving INIT_WORK from f_midi_bind() to f_midi_alloc().

Reported-by: syzbot+d5fa3d224505c8610702@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d5fa3d224505c8610702
Fixes: 8653d71ce376 ("usb/gadget: f_midi: Replace tasklet with work")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/usb/gadget/function/f_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index fba8cf787d6c..63fb6ee70a3d 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -879,7 +879,6 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	int status, n, jack = 1, i = 0, endpoint_descriptor_index = 0;
 
 	midi->gadget = cdev->gadget;
-	INIT_WORK(&midi->work, f_midi_in_work);
 	status = f_midi_register_card(midi);
 	if (status < 0)
 		goto fail_register;
@@ -1377,6 +1376,7 @@ static struct usb_function *f_midi_alloc(struct usb_function_instance *fi)
 		status = -ENOMEM;
 		goto midi_free;
 	}
+	INIT_WORK(&midi->work, f_midi_in_work);
 	midi->out_ports = opts->out_ports;
 	midi->index = opts->index;
 	midi->buflen = opts->buflen;
-- 
2.55.0

