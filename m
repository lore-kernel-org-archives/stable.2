Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29D3F5BF0
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964956; cv=none; b=Hy52rvdWFD1tJMgB/jhBGawRVAVSKXZ+t+XusJx5nT/txAJSBLJpAYBlMMoReHHGFXPviVQmIApYPHrBY2j+hE1olrp6qEz/ywJ8YhF9fpAxdRdEFd9qOH9jQRqb18EcFdbNYK85wiKdOxB9hb8qNvYvwxEdY690be1uQra+9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964956; c=relaxed/simple;
	bh=zQITEraiHsGpDDYt9Nt1jR8D0YOYzfn8aHodB9I1nps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcTK4LjZugI5NbvVDlzgii1TEXF3XP+C0azKS8wMdNu9C8KC7yqLb1sg4PL5P8E2jVUofukzGQBHX3O3Y2BRN/4ZvTq4jryycqLDJxdKmdqi/QcKPCoSD5gN/t8qxJlK6UxjRiHmdIOFJu4SpUW98oK4Yzqubth7e2X/PvW0ttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk/Qv4rs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk/Qv4rs"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf318752so2129310a12.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786964955; x=1787569755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbOXjIOE5eUZ77E2jan3Zky2z5kifDys7cgukCqXI+w=;
        b=bk/Qv4rsJKuR0lKES/Ci2m7JR9S86vVNBP31BLixS28E1NYeyQU9bGI+sI8Z71aUQg
         GlQz/ouBILSYBhy18AElqf66Fu9AcFn4NMNT3N/0wUZFoRNA/aLJoTXXojF7HiNQPpB/
         ahuLCn++7eMwG8mjs/wORExiKeUQX0uGlIgNCUwp+/us8W8bgMLIb1yFM1KZ7sI4Poe/
         RztxfGlprLGYQ5LxXnpi2eRLp1seTCPsBZiUab/GSwcXW8ZRv9hJ0RHyFQ+ExNTOZM/Q
         uXjg9RFlyhkys0welLXTUKfoDaMJiLUMHsDwTVVE3avSGlaaO1Q/EVhMVgTLk5YJmZU3
         SW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964955; x=1787569755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbOXjIOE5eUZ77E2jan3Zky2z5kifDys7cgukCqXI+w=;
        b=dl66uA/80Brlo9Pf0Sw20OvSwK8oCGBXguFkQ4+t1J7Th1GnLN/3vRI71JQpEWzR5V
         FXxRbV5ZCV2Vhb5XA6DHfA3cBz/9RBwavVFZtbzAE2c3b1xIfJGIJi1tFNQMaW7Y3ozi
         EG7e7Ie2/xLFNjyDtiPs8xfi8NNAOrY2BlXdFZH46iPkKtLEz/8CAUXGLFIsTXw9/2we
         WHxrpXy55IDvZG4K7p1wgFnufiOy5+Ny4v4b1YCqbGVfbEznpc++3TxW4Ts4/D1NkZRp
         iqPuT9cpY7udaAwPrzkJsCa3P6/VRnpU/XkqjFuLaRslyduOssDKRj9+E7rxdKf8FNBX
         6Aqg==
X-Forwarded-Encrypted: i=1; AHgh+RosH+Lb8pjVujo8w9ssRgFQO0qke73ifzN5foKCvN/NwyOGuLHZDyyocAQViM/H5QcaKtCZifI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySX9VUzMgwfv4e/bPy0SU1Ad6EGvL898itmFnwNAvQWpZwgYqu
	vsF/q7ggcZrCetejgL0ApZ5Y1jxxOiFSWKlLchMj9Y1hjbcqLObRc/GP
X-Gm-Gg: AR+sD100Y7wiCGH8mdrc/7Bo6oBMR6DOcHORw6HjxtxNpZJsvQg3kskER0fECLjEQjK
	fH8RR2vseckPlhuLNbZRthXhTJ3PwYiDxd0vU2Qko6VY45OcHaUdxcDXbygbq/ufArIbzyTVurs
	ruisMosZ2xqc/P7kZbo4IDOHRfjbMH9UIqitnTCVtqwXgb5SiOEMax1wsgqsq6LedWeCtK+NYPE
	2+qAOh/ngtEdjB4t4Bi0VMuKU2Xs80AuuQLAz33GkdG+DBVXvl/QH3Pdc4U90aciNlw8xMAsAwQ
	Rn5bvd0Na96uzPPLJehaQb+/nWpoTrMwULco/MkjAYVDiuFY4mcnbmUHAV6yCpN+P9IqyCDk2vN
	XVIz924ls5Jr76NQz0CayNFd3ymU5SEjifQnRRab4qfLonyCuE+2i3doSc70jEDxD9THcOX3NaN
	onkvBoLY9MwbpQavHtOy4/z/Nt6kxFQHcXufIwoqEr89Fn2EPBV5wyqzsu6lO25uMSGQ==
X-Received: by 2002:a05:6a21:6110:b0:3cc:1d2b:2ac3 with SMTP id adf61e73a8af0-3cc71d195cdmr26060283637.26.1786964954730;
        Mon, 17 Aug 2026 04:09:14 -0700 (PDT)
Received: from Default ([2409:40f4:102a:23fd:2be3:947e:c2d2:30da])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1415305e48esm6077568c88.5.2026.08.17.04.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:09:13 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com
Cc: christophe.jaillet@wanadoo.fr,
	kees@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_mass_storage: fix null pointer dereference in fsg_common_set_num_buffers()
Date: Mon, 17 Aug 2026 16:38:39 +0530
Message-ID: <20260817110839.8201-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsg_common_set_num_buffers(), n can be 0 as conversion to u8
using kstrtou8() in fsg_opts_num_buffers_store() can return
values from _0_ to 255. When passing 0 as "n" value to kzalloc_objs,
it can return a ZERO_SIZE_PTR, which passes the null check for
buffhds. This leads to a null pointer dereference later in bh->next
in the do while loop. Fix this by adding a check for n = 0 case and
returning -EINVAL if n is 0.

Reported-by: syzbot+791be35f1fbcc85d06d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=791be35f1fbcc85d06d7
Fixes: fe5a6c48fd95 ("usb: gadget: storage: get rid of fsg_num_buffers_validate()")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index a50743caf083..640d3bcb7bf0 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2747,6 +2747,9 @@ int fsg_common_set_num_buffers(struct fsg_common *common, unsigned int n)
 	struct fsg_buffhd *bh, *buffhds;
 	int i;
 
+	if (!n)
+		return -EINVAL;
+
 	buffhds = kzalloc_objs(*buffhds, n);
 	if (!buffhds)
 		return -ENOMEM;
-- 
2.55.0

