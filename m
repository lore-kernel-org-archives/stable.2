Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971925487C
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785732572; cv=none; b=WDPiCLHLIEvkVqWOYZ6/oTWzDv9TwYFKVzpLE7LP3ymhlxbdHqqfFt3FsHCcOxGagYp539muOe37L7K+f7lAtSE9DO7cC1InPb+IaeabNcPAM8+JFDL3aMKc2eJJT8jn9wIEcygtX9Q9LBlDM+sY9rYO8wFP5rv8WGNx/jRGyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785732572; c=relaxed/simple;
	bh=46HK5ojW10QtCqveZtmMIdvFVUvyO6vX8BARdRVpdX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pa0XP/vfpeHNC9DR58eow/HugnQ9VoysB2BQgeVApkHyWW3w8SwYIJ4FIyDDXUVWnphRREYwqaH9+uFFM34npxS9Cgk5JquJi3V5/wSc5vF8vqz2XAGk2XtcGW14fcyIcB+WVfTXFdhrDzSg35MbBn/AsZtNIuK9BRuvy5tw740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n44XSYNZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n44XSYNZ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso2197799a12.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785732570; x=1786337370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h6mXAlr/zwt8ZXOoLa52W+b3eDz4sTWHBZRzsSIRQPU=;
        b=n44XSYNZOXdqsYgyyJ7tAS1cXo+S0Jl/0mXdFnLO+ivS1+2HUBXZp4P3D6IacipDKG
         k98zIovp2BCXsjMQKqyIGyL8SWTdVhUnjAK6R2jd72j7nrd5CdZcO/aiQCMaBy5zWNzn
         9zK70OtXqD543A5Rtum9jM02y8a/KHpV1UYfIigt5QajSDisAwOpFMIAsB9mIjEwfFk6
         hdyfJLFQmTMNecSfni+UEl3jeEfaFojHe+ok2Fda3eyRNHgxkgpdPDhqwZAnKi/Rv5nw
         kR1aSuS3diI/r4x7V5L8QV2AxUGXeBDZnM0waUYcD+xbfVCUpeG4oK8gYwIKqEWZURW/
         LFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785732570; x=1786337370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h6mXAlr/zwt8ZXOoLa52W+b3eDz4sTWHBZRzsSIRQPU=;
        b=XfUcjxtXGsFRUpevN7vqNqumEVh6Q1kKeILe0dNjwAhsGsEuR+EBKTl6sMdYVt1w8m
         UfUCQ0wkfu+e41bmgADgsNx1ucvi25RojCGwVw7NU/7FdEhA1njtmTKqtiI5gp4/688b
         35np4uIYMKX7Iv8pFRR74kRl3TPA7uvAPUy1Etf0T31wKjewii6d3wj+F3luZMAxaR8Q
         OmLfmLRMogU3hUMZaF4anWAmfwDne4tbF1m4KFulmxcsg0+Zk3i/MbzDOW4Kt1r7DpqZ
         kFC6UcdqaqT22dml7S8iUuU2f3pd4TmYFLhWlmN1MAA3rHhYZ8shYoi6cpRqj/82R79h
         xa1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqs+JgSzwl2+p4vlUsM+BRw2nJC/+I5q9ThQA46AttfOfVYXkXHmwDCEcgPQAiyAI5JM/f6dwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEd0nohNGy+GVGkDYWVn7B2ZornAC2ug8DHnzkzbFsHX8Jblab
	1eRUPiRs0ZlUGwvCY9YmBydq0Dvt0/6CqKWBiM84/mmsSo3pkWqdmC7b
X-Gm-Gg: AR+sD10KW20GAcg3YBeK74HreAjCaxVqKbGCwBp3rDPqbRJH1dHqKB4nzfvQI9JjiAI
	NSmFppJKuvrYvWbHqZCbZUOBDVIrPx/mvDGWYjuvzHSKpGryE5ZNQr2xumc/oetuXaMNuC+WLC0
	YXMUx9IraSjMpJTw1wSMagY78pAltZoQ3z7P7MHmoIlQWoby/w9nRP7tde24gZFG24eIjWyz5S/
	/Jb4CavoSriXKTCx7njW4oM9SH3lbUuxX39iLZDB6tsK77rlLIMhlfGcxtI5HS2sV4lFDM42Eqo
	st6kY57df1sUSJbSeBoyGnZGmjxtvJnCNAlVORnmtZdAmnvcC6LDmdF4tBQmcOl4w68KZQHwx8t
	/UjBiq/UbFlW7r31opyiZe6Sqj2SMDU1Insn80V+1PW7uaGfat6hLSrbbSbXa/kiDwtncJiF5PC
	mueh+4JxlVn5zZ3XUdbaacnCpgBWdktQEf5+cl86ro990VQUiRMnF2tlbvF3k3KlxL
X-Received: by 2002:a05:6a21:398b:b0:3c3:f5ff:8c9b with SMTP id adf61e73a8af0-3c92a8e2c72mr8019202637.71.1785732570300;
        Sun, 02 Aug 2026 21:49:30 -0700 (PDT)
Received: from Default ([2409:40f4:10ff:eef4:b4e1:bfd0:d002:8e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fc98sm33236477eec.21.2026.08.02.21.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 21:49:29 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: xu.yang_2@nxp.com,
	Frank.Li@nxp.com,
	kees@kernel.org,
	panjunzhong@linux.spacemit.com,
	andrzej.p@samsung.com,
	laurent.pinchart@ideasonboard.com,
	balbi@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v6] usb: gadget: uvc: Fix Null Pointer Dereference in uvcg_video_init()
Date: Mon,  3 Aug 2026 10:18:56 +0530
Message-ID: <20260803044856.9271-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uvcg_video_init(), if kthread_run_worker() fails,
the error logged uses uvcg_err(), however, the pointer it uses:
video->uvc is not assigned at this point, triggering a null
pointer dereference. Fix this by directly using uvc->func which
is assigned already.

Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts with host uvc")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changes in v6:
No code changes from v5
 
Changes in v5:
Added changelog as per maintainer suggestions
 
Changes in v4:
Changed Fixes commit line as per Xu Yang's suggestion
 
Changes in v3:
Shortened SHA1 hash as per maintainer comment
 
Changes in v2:
 -Changed subject of the patch to include subsystem as per Xu Yang's comment
 -Changed incorrect "Fixes" tag to "Closes"
 -Rewrote the patch to use uvc->func rather than declaring video->uvc first
  as per Xu Yang's comment
---
 drivers/usb/gadget/function/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 2f9700b3f1b6..9ba09118bb74 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -821,7 +821,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	/* Allocate a kthread for asynchronous hw submit handler. */
 	video->kworker = kthread_run_worker(0, "UVCG");
 	if (IS_ERR(video->kworker)) {
-		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
+		uvcg_err(&uvc->func, "failed to create UVCG kworker\n");
 		return PTR_ERR(video->kworker);
 	}
 
-- 
2.55.0

