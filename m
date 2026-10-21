Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555578;
	b=IX0aiE5c6R0uvrNAcpIkJhK2/E6jDJEuoG33eWPJsY2Q+lVIeE9we3iGhA8OpVBlV3Qh
	 g6RrgwGOdwB8gVIZRwvT76t7VjUdCtgL+WR+vstSKbd6zO1dA0P8eFfzGldYPrfuU6Fmx
	 lpqdhpkY9R9j9uPDqAcjWlQp8M3RtHMsE7kf7A7KQ0jRM6FsMecpaHUrMTpIw9I053thx
	 ATCU0pzhUFIZlKJ2m4Td2sSKLpFZ/CW6DyUz0jWCh5WBy+9K2+7/IU6mYwS6xBVxs5hHx
	 WL1LQS4HzAz6CgTuR4LXFkzhrg1I+G0Pek9KbLxAIBz4PpObv39detikbwVgYyd0xKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DuIIAaqvvnxnspDSWao0NwbDdlTo4WVnKM1pf0MR9Tg=;
	b=E/5uW+vASbmjvOUU3P93zpcud8sknKgah/SSylskMDuiywgZm9TtFPAclyLCyIhJB9WN
	 g5tbticBl575JIupS9yw4K/xwQCJwlhge+0CDJjD/8fHXtSIkgwj9ZRZeR4Rw3BsLmNOQ
	 Wi7TcNUaeMx8sctb1YH0vd7+ekq6hpPWE/6bSAmhxiuri0taHcWBPHyDBbjzfL2xwY5EU
	 AUVZc1/ygXLi/ly+HY+pn3ut8JVyBxPFsQHQ957ooP5ZjoM7Q0Bct0NNz5dIGMQphmoyF
	 y7DAhckEXB1MhOcJuh13umYDaNQ9n2Bx1JGLY1MXp4GMpya2c6zYvitH1VPggz1FuWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=unIDJ2h4;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5F606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F5F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=unIDJ2h4
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so1182725a91.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792555577; x=1793160377; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DuIIAaqvvnxnspDSWao0NwbDdlTo4WVnKM1pf0MR9Tg=;
        b=unIDJ2h4mOfkqFxqH3okz7KXv4lbAgWEleztl+pN62Ubi1LrgJzjSoXmnPnhxsLbkq
         YF5bfHN/1SAYZiXFOv+oGOQHWvwW/S3Yzo2YwBxzT+zOXo3PRb/vu2U2QTDCaISFO7NB
         D/qpm2+bpo0Z3jnK5ERwseNNmgu30aR9de4Ikbc2xHxxqky/NAUqL34zsi77hHYQbMkC
         Sn675aeAc0IQWwTuHFnlPoigTRc+XdcBMBL7hFU3nJvMJRXsbEu3eX7fwE9Fy9BQleMa
         LdiHlpHeETqifb3QTMoFYMOhkuwHT8t74ex5S/+DojXdzaucKfCXpxa9AHXp4hvmtkbm
         26WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555577; x=1793160377;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuIIAaqvvnxnspDSWao0NwbDdlTo4WVnKM1pf0MR9Tg=;
        b=rBVPTsWidG15wt9i6OknBcuCTgHUhGYzK0jMBUcgaGc/TZIHligNEWEqq1c3Svh4Wm
         3RixmUG1ivBYh772pXW+fRfG+BmEhAwT+FeAAChhV+2PrMF+N0uDOuGkH8HKzwPOJBso
         ipMFeDv+pvl03R+fXkslqutZBFBq/B3urxQmwoRRkEdplkaoxC5ReBxEK4/nX3/ixzQq
         g2zRkrKPicTlDNvCsvcZLXFEH1bgXbS99ER+h4TnenvINqO4+LJdd3zblF9y8yzmI2SO
         DcVlN2l6H6bUAVPf0hwg3+uSdW86aMT6f8HbUw/j3ucNyqK/mxh/gOJ99Av0Sy3ia+vg
         5USA==
X-Forwarded-Encrypted: i=1; AKwUvByK2neX2g5E+MFf3j5vg87SXTdtwuqSqg+CAnvNYS90yZduGFOhgeAz2bkugrGDrN3jwScgSOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwdqM5qUz6lAtnYAN5JhNp5IJMWXUoAEjtfeTNJhNP39yWXpMi
	Gtfx0snZjDCb1tzMzaI93QwfRYrPLjY+k0uOf7+VBg5koXhGifVMzobFNyZKt6bMzeXnMtasn44
	i/uXpiYhk28s1RCPRxBE09Q==
X-Received: from pltk5.prod.google.com ([2002:a17:902:6945:b0:2e9:5442:b91a])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54cb:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3ad86eed516mr440687a91.20.1792555577258;
 Tue, 20 Oct 2026 21:06:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:06:12 +0800
In-Reply-To: <20261021035450.3488805-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021035450.3488805-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021040615.3566831-1-stanleyjhu@google.com>
Subject: [PATCH v4 3/6] scsi: ufs: core: Fix double completion in ufshcd_clear_lu_cmds()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, ufshcd_clear_lu_cmds() clears the request slot in the
controller and completes the request, but leaves its bit set in
hba->outstanding_reqs. ufshcd_poll() treats a request whose bit is set
in hba->outstanding_reqs and clear in the doorbell register as finished,
so the next ufshcd_poll() completes the same request again and unmaps
its DMA buffers twice.

Clear the bit with ufshcd_clear_outstanding_reqs() before completing the
request, and complete it only if the bit was still set. If ufshcd_poll()
has already completed the request, the bit is already clear and
ufshcd_clear_lu_cmds() skips it.

Fixes: f18fac1e2b72 ("scsi: ufs: core: Rework ufshcd_eh_device_reset_handler()")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1db572f84971..68b53f89f8c6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7987,7 +7987,8 @@ static bool ufshcd_clear_lu_cmds(struct request *req, void *priv)
 		return true;
 	}
 
-	ufshcd_compl_one_cqe(hba, tag, NULL);
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
+		ufshcd_compl_one_cqe(hba, tag, NULL);
 	return true;
 }
 
-- 
2.56.0.212.g129ede20d9-goog

