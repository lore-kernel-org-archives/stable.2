Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C043B2FD0
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879316; cv=none; b=bjKb80WOI6SayPCSpwPKtHHZJEiGYmLM+KhDLw1o46NxAdeW/+1vWsMuaAdRA2dKwsP/HOaPnECAwzOGfsTAnUAUJd7fhRejmBF42cav/GG7ndF5qRnT7FUHd4bMvoxunoWs/aslq9eExuW1X1mpRAaoupbOTj3t22P5oM60Ups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879316; c=relaxed/simple;
	bh=bqg0NehwVXA1rTLhVpjps1ZsW0rmS/bRW52n0SrYjxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8eI8GvKMXMUkiYzc50btOo4BBNt1buKtaeCB9Z+gH7PDeV2xa3WLHo+6F1lG2IllNPPYiUw17exQm6puank2DGTEwSPdZYQh2faHW1OzBFK7Ht0I8Adn1mC0J4upGuIKczFvPlM1g+S7vyP3vZV05tY+qIT+LFYT9IfQWKAGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPnOX4E2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPnOX4E2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so216847a91.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879314; x=1786484114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbbKhcHxWg4c2CE8Ge9QTVBenagHkPrYHIB1asS02ng=;
        b=IPnOX4E2+wbZkIwfsElv9Z18xfSgZJhELm7qCQZzOaVQjzJAIsAdlWFokKiW5eGFM7
         ibdbU6PGCYu0HM/+B/T5ePpuUJGfPa92F4evVITCeT0wEHqWj5tFAynXkzQls1CxgCk8
         zy6gkVa/cIHGhjxqNbJjArlo8s2x+1iJDgF47RlNPiLgcilz5R7KYKOV2Bhkh9KWRsVZ
         BIayLUzK/12b7xjQ1o3lUbfF8AMUMfb25xI5mQkynVPkU2wcteMUibQVJ17VNmb9vQkR
         tpAC3MjIFwgrrYnYfndqTiwIF5X16HtO68/AUeXT5Nch0ZGvJMpZQy2w0s/Mi4ZtDsx8
         TO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879314; x=1786484114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbbKhcHxWg4c2CE8Ge9QTVBenagHkPrYHIB1asS02ng=;
        b=FPzmK5NLZTPNWVZDDbqFJHXxRbo5LAg5hDwMc8zsgTX7bseDVdOACdwgTpOpaimYT/
         lzJxqfzeX2oneJeXFyT9vyjg3Hol3UbqAQvX5Ley1rND9lxut/ZENjSaF9Ydj2TyEpHq
         dQyc0wEKK2cgjbUpz6N0IReK37E4aydtJTo0FFNFoAeZQW8D+xmQtPxZbb+LX4nCgwh8
         m+361JYLT0jBY7fAwr9LeQwgCzKXuCZsUZDsq1/sTDPW+4OvbZ+Obi/3S0Ue0n3p4CYX
         tjUJYWkDL/XhHorfqjeYbUb8a1zbSJ9vDa4dJlHFDlQXG9n3hPfE2OfuwwHS4tcLMQUb
         07fg==
X-Forwarded-Encrypted: i=1; AHgh+RoR1hLnxyGFewe5xlet/o7XEEKaf0RDkb4uLSKA7c3qgSdAh4LX0UUYlubqVAuhXRwlAML9joI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0c3d+ek75qIT+jtduOUyp+IisY+mVn2fUCinmLIxeWSLqHnjN
	T0sFjQkmkPoG9nIgppZ/eHYkF7A2+dmsFNICACWBtR7YV5FEX7QurcmT
X-Gm-Gg: AR+sD11l2R+e90ZkRS6qOJKQn19Hn5lhjge0fg5KygEF71UReVatRo+8zzoWEch+E7d
	c8f7hBsVNI5D2BTVQyXSvraVp65GPmMXY0M54Co1KteKwVOUBFHIbVDYny3Gofa9XVK1i1Kh3GT
	NCmBFVghMxQEqhD14xFReQTEK5Nt4PFE2L+ARI4cKiLicQytiZFNU5gSwiUdJSNYs94GwRXIs25
	SiaP9yYGdlx3jDEgB8hRopGkoFfY6HR11FuxqF/Ok4OLNy+h8sGNixZ1Y6oOHfDjgue3tevKt4N
	RLJVrTy+UrPPoeygGcYxGb+OUlh6oHxdsqhUoYxAGBbFmzmOnxCKFWQHE9M0zVehjgSODXIVKYo
	UGGO9YB2yS1npAJBBAr3FdJoTU/64dOwUp8hajDaCKnqrNO1ZmVDq+MbVBSIUs0UISCqkxG0Tul
	FBuZZvqpDT3UlxhsxRSJAC6JgX2SoY5rCHgcfV3o1Bu1oR8+lzldBl8pSfN4kA+ubnzFuE4vrX0
	agfz50YibA2FxFMOeBdq7GjzJsRJi1ewsY1Wdk5ZkQ=
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3903c5c443dmr1316461a91.16.1785879314070;
        Tue, 04 Aug 2026 14:35:14 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm13069487eec.1.2026.08.04.14.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:35:13 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
Date: Tue,  4 Aug 2026 21:34:56 +0000
Message-ID: <20260804213458.3408662-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msb_init_disk() creates the per-card ordered workqueue msb->io_queue with
alloc_ordered_workqueue(). It is torn down with destroy_workqueue() only
on the init error path; msb_remove() never destroys it. msb_stop() merely
flushes the queue, and neither msb_data_clear() nor put_disk() free it. As
a result every card insert/remove cycle leaks the workqueue and its
kworker, exhausting kernel memory over repeated cycles.

Destroy the workqueue in msb_remove() after the disk has been removed and
the queue drained.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/memstick/core/ms_block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ce33907bfc24..65154e569a9e 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2204,6 +2204,8 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
+	destroy_workqueue(msb->io_queue);
+
 	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
-- 
2.43.0

