Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871003FA5F1
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182509; cv=none; b=PWPgIo5O78r8CyzguqinpYQ/BJlQT126APrHZZvV2bODBqwFZ0vUjTmqJAmyh70pQZlW5UIuaGUuTNVBTI1pwM6ocyAH6CJxq6fYRgbksCn+rqSOEKBwZ2lRicciZPAHSFb4ng6fk4R1brxkCCFDTXxg2M7B0MrRm5MdCys7E5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182509; c=relaxed/simple;
	bh=oZStNDXWE/AcTOTzD9NBJlNmFJtQ1MWzYyCoyRxg4UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEbeS4Dzp1fyg8T++O+MTS5i54JFvSj1Sxnzy/craDRhrTVKntdVgG1jQFENxsPUmLGOfKG/mSbjEHFUGe8NfnmOl6UzGwmCPp+5qOg9aCz4lzDNhPXQIMVM7Mz10QssKX6Og8F9yP6QfCeasLfVxFAXsQxUF8CjNlnWM4RPIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9hn9HkK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9hn9HkK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ce9df4732cso81644546d6.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781182506; x=1781787306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5v1bno7gDTE2v+U9DKoHdWFvECaXXlbgInGSkG+Fe8=;
        b=X9hn9HkKBKLyVckfu9st4+hgxwhDmWcYq7Q7+NEYY3lq+msfJMhRdN7Nrzsa2pHodI
         BzF1aibVmpl1q4C7l8m4boXNaiNFXUh96FkdUEZ9RTI8seZlLFSoYNESu/fe88kjlTWa
         XCwCs/z4JUJis4bxjkA1+i4I2NSJhLeq6IEOQVF9+PJdw7k3aXMNvtYWvqy3sd+FYnPl
         QjrrZ9UDJLbYQL7siCbc01XDslL7EnI2uKPJf26cT4nMrViO234vl118Qt0+qf0L4hHd
         Eo8dWA7s9pqtQujePwfjPFEX7YGpX6sf2G6bWhRDuuy+T5xZnXpob8MfdAqas1e115r6
         XOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182506; x=1781787306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5v1bno7gDTE2v+U9DKoHdWFvECaXXlbgInGSkG+Fe8=;
        b=Whvk3G0lFKQuhn8GhYOpcdHfYgHv0GjO3cBKGWvYUi93M0mxP8juxc8ejAFbkJYiDb
         a0LJljTWFJbyg5eq/EQXpa/CZlS+M0Zonp/skTdxXylPvQ1/d4tsH2o6i8M+urAD7uvY
         WZ+vsjNc75ufcddNkytp7kmfDVWN0mZ9+q2TIyR3eiPEKKLN4MZQ5FzeB/nJYZ4X4auf
         M1UTNwUg7tOTlkPnGU/ZbMGdybvOslEbLShsR3gAvRQmW5s/WcXfRu6d9okpbEpYTB2r
         rud3grCMO1jSeTTIgnRDlDiJRbioI9vWxCGXgQ5W3feX1mrFdf9h9WSkZqKSsjo6TmVF
         65gg==
X-Forwarded-Encrypted: i=1; AFNElJ+uh74GZkuzAkBe6WTjaaxdTfhpMfWlkQbL2j7kCFRY+JCejOGmXf1iKzpStoIZp33CJSZ8mnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQukLmDGyWES9b7Nf/mgOjY8a3VRUraw5JNiWGKflrdTf/r24l
	oUbjQ6HiMs1Q2HnJb6p5r/Cmhylz4W2h3Gwfn99B00R3I3Qi4/Y6sITG
X-Gm-Gg: Acq92OG6OubF08SI8DEbQTUJJHOyWHLrRosK7D3VJwEGhpWlnkQW+wWCzfu1LwcuRNB
	Acq5E+cHCqrD6JkzwnuPnkTTbzNEwQ9GEEo7IrrjTHH8De221EwoGvt1KKYq8AohJ5dhnDXOzON
	uZl9kVXd+jGzpPuYuFCPHICc9O0VjQMhPfWXOYyiXp+LEO4+A+7bGKJFppApTIRGYWJ8D2QxANU
	iWsuNMkhG/zobdf5vdWXunSP1yfxVlFRkFk9M4MyvhZYTDDOmcfuOVexWBOyjrhCFRcwfoy/3bi
	XwddhnpdAOQOwlc/XTFwYfa5lP7IWhk8xvJns21Gw7vKZI7k4Yzvf+ohBNnofvT2pIjNrmVYbyM
	fPpvgGxJzvYUOjtDZ2E9MAeunbEc6I0/xTsAO0+uSm/r40IXQD8t/niYUpk4d+YyQIvnjZFZ78I
	QQyuXpIo/zdGXYYeOiE/+iBoVlkeTGS+rxlWFvwumgcnwBqTCAlriLiGaccvJwErHQAF6jlSC40
	YXUDRQNqEregkKFFqEL15N+7QPBZQk=
X-Received: by 2002:a05:6214:5b82:b0:8cc:e8f4:1630 with SMTP id 6a1803df08f44-8d1dac25ab5mr42471256d6.30.1781182506291;
        Thu, 11 Jun 2026 05:55:06 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e7bc298esm17792936d6.1.2026.06.11.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:55:05 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qrtr: fix 32-bit integer overflow in qrtr_endpoint_post()
Date: Thu, 11 Jun 2026 08:54:55 -0400
Message-ID: <20260611125455.2352279-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

qrtr_endpoint_post() validates an incoming packet with

	if (!size || len != ALIGN(size, 4) + hdrlen)
		goto err;

where size comes from the wire. On 32-bit, size_t is 32 bits and
ALIGN(size, 4) wraps to 0 for size >= 0xfffffffd, so the check
passes and skb_put_data(skb, data + hdrlen, size) writes past the
hdrlen-sized skb and oopses the kernel. 64-bit is unaffected.

This is the 32-bit residual of ad9d24c9429e2 ("net: qrtr: fix OOB
Read in qrtr_endpoint_post"), which fixed only the 64-bit case.

Reject any size that cannot fit the buffer before the ALIGN.

Fixes: ad9d24c9429e2 ("net: qrtr: fix OOB Read in qrtr_endpoint_post")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
32-bit only; reachable via /dev/qrtr-tun (CONFIG_QRTR_TUN) or a QMI modem.
Reproduced on i386 (a 32-byte write with size 0xfffffffd faults; well-formed
writes are unaffected).  QRTR mostly runs on 64-bit now, so this is a
correctness fix completing ad9d24c9429e2, not a high-severity bug.

 net/qrtr/af_qrtr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 7cec6a7859b03..ba6d38244c440 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -496,7 +496,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	if (cb->dst_port == QRTR_PORT_CTRL_LEGACY)
 		cb->dst_port = QRTR_PORT_CTRL;
 
-	if (!size || len != ALIGN(size, 4) + hdrlen)
+	if (!size || size > len || len != ALIGN(size, 4) + hdrlen)
 		goto err;
 
 	if ((cb->type == QRTR_TYPE_NEW_SERVER ||

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

