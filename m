Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662921;
	b=Q9hxJ4a/SvadnjbPYGvw94+HcD1VQQd8mOhSaAac5RPuxjuMfaZnxy9d68l5JA4zY5oG
	 us7yXHxRFSQqDAuPBCHamsNr6g0BkXzjbcEpSIFivMdQnxmxo40OWN4A8BOd/ijzMWE/Q
	 tR0z7+WM8ZYbUkDtbiXD2neklaR7+bHRwY67iuxozXQwQKqXFdO7tv/ILGW/oUjGPEs1/
	 V+AVLCk5KRHcDCAz7k69Q8l+tRP8bzJOwcPmGMkek+xaGz4H+7dTie4yG5l0uyNIL69qo
	 mulYBsKZY5dGphxveM/n9VQlS9izTMv92ZWsM3onEbmDuQVLGKrdSwD5J9KDbhiJB5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sNzRYBNLRKkf0Y/gp9OREoymKpw7SvFmjDC5u9+y2bU=;
	b=V6FIhT6QZheZnt+PsweEaVqS3hh8+nsfqORaKOIM8o8TQyprVMSR74FdH0mAJHYGgXJq
	 XeVfgtYorhaOFZB6F5Q0qjDo76O1srPiHQVX9noazuI00J1yxr5TWud+0fPe5TAXKOWEP
	 en1/h9fw9+ssZY7Z2a52KdBNnKTyvurd2VbRlbmeKiSW/PuipwD8vdX/Ai6MK0iFTDCVs
	 JyYc9nGWKqvADNTsTSVGeXRKfya3OnQxw3s4UQ9cqDEYgPJabB13DehCvUpEBX/jlIBSj
	 7aujk2PARrrz6eP//+rESqWnMNWptwTfxxU5CKFd47q8aAjJvERS4OROH9iZ/wY+ttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skD2ppcL;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A3606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skD2ppcL
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so12529755e9.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662919; x=1796267719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNzRYBNLRKkf0Y/gp9OREoymKpw7SvFmjDC5u9+y2bU=;
        b=skD2ppcLp8Io6d1UOVIAK49rjMBwYkQ5KwfoDF0RZK3PJEsvZ0LRJ3kNOLo8CLUrRP
         YLgirbXYWF9Pg9MZUgEMOnzVrY2jwIVgD7OmWr3IYRQwKyqy628c3iwbsYdB+YJQv7KB
         vHhTGwfGVQ3Ei0/E0CuAjbYVsoyAsuh4DwxJKQlJQG5zWgmy8JWX3el5c2MZDoBrEgcF
         ZN7vym/yWsZoZoI9UTV2UtpiK92wOnTScZWeNi7wW7BRstB1Dh8V/N33bx6zhsYP+9yp
         Zm/DpZzl5ar/0ekbWXqDkdgm09FolS3Df0wdOKRkbsHHV9DAyK/AQ43ba3ISCwUoWztd
         l2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662919; x=1796267719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNzRYBNLRKkf0Y/gp9OREoymKpw7SvFmjDC5u9+y2bU=;
        b=x6V/+dlxrHiY48ZOFqqq4E89cJ9BYy/9CGimH+K17IyqLRV7T/efqNESv/Yj9ZhlCE
         6z6HDGx5xo08Sl4+kdhRmjmZEFGDGbAChoeE3K859p+z94uibQRMAnMR+KxtjkAWF5Vi
         W0RJmCffs70w6xVRjc2+ENQlqNGJ+RmgCltylQm3ugD3DRwRn2FV0urpn7K24qreSLju
         P5iocFNXxuRfdanhe8rVluEKlUYeZ7ByTXZrwdn6HWjS4JTerzaqZBmi+CqJwBmN6ago
         uRxDDfOPQqzXfKUAxtt2p+1QjeV4HHGx7hLZuHMiPz5WsCcGxQwkV8h1YkSdv8VWxR9u
         GS+A==
X-Forwarded-Encrypted: i=1; AL+hErFF4EZrPk5KKAqV7bPkHGaD8I80kuSbGO4TIofBhTxdb+hNaabHo+Mk4PYGq7gpG0Um7Ut78CQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZGZaMRUyeWqrUMOlNmQN1Q1JO3E22GA7tHVeh1Tyi9G992scQ
	J08IC/MQZTTS/j6TvviUOJ6fotGvxflG6jXBRZMejuue/TL+ErlNPDM5
X-Gm-Gg: AZFdTZerziV9u7STiTW2J747nWGnBIa8WcDGmqTaTgApBYs4fZj9veEgQ0CsdQTgfxn
	tMbCgT3T5KWKMGZYzDqCkf6kOHKoo7lC6nA0Xn0YkLgQ8HsEk6waD4T/ieD16YPjARg/Dj3Krbf
	e8bap8o60+HnhVL1wmsnitDfRUwyM7cXj83iAqO9UbhNURIKImcvYSQQtfLbt+iX2sXmYDOodyK
	HXCBRHJbWmyo2l7VeZIm0ygAkS76Jr2ZcJjbqAyOIyn5YFVUrCvKbgNm+wF8hQ3izE9pMm6UNFh
	SEel0ZTobFoM9f/w6LkqIl72nZUr1YE73W6rVOfaBui2aqCL6WcqvwYgd5fEE5zRsG8P2X/1GDJ
	pifSbVpPPYKlL+e3ZsFVPJsQO0aof1P0M34QWpKi/6vbDGl9GLFmEYc5gAyTscbZ3PPVFOX2hOO
	ut5eSZ++mp2npOkueDM2wE5zvtU36Co32IX91CWu6nNAFDiFmHjPQgwE6EGLiuZjvSf4X1HMxLr
	13lWHrMD1wpx5EBURDBWGh2KzeM77XG0+nI6SEHphwSyNU++49uT6q/zZlFty1v3uqpfdJJicBg
	Rtw65MB9tiTUXtWRgFXfzXM8luP5hSwMoL4dES9vQYa+5nX7oZY9h9Lkcwe7wpLiPLna23eAWxv
	gh0ZP761MwMZtxdsuSLvFU6mUvRRbApC8lGsJyMd4xhRAwGhsDHE2jl5HXrZYVg5haQM5rK2VVW
	MdcB9NsFspNm3J9jlJTLIZXJ7w9s/zoJZJbA==
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb88826810mr384054565e9.11.1795662919396;
        Wed, 25 Nov 2026 19:15:19 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3882sm37189290f8f.49.2026.11.25.19.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:15:19 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	yangqixiao <yangqixiao@inspur.com>
Subject: [PATCH] ntb: ntb_tool: accept hexadecimal addresses in peer_mw_trans again
Date: Thu, 26 Nov 2026 06:15:06 +0300
Message-Id: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and
size_t in tool_peer_mw_trans_write") changed the format of the
peer_mw_trans parser from "%lli:%zi" to "%llu:%zu". Unlike %lli, the
kernel's vsscanf() parses %llu in base 10 only, so an address written in
hexadecimal is read as 0, the ':' in the format no longer matches, and
the write fails with -EINVAL.

This breaks the usage documented at the top of ntb_tool.c
("echo 0xADD0BA5E:16384 > $DBG_DIR/peer0/peer_mw_trans0") and the NTB
selftest. tools/testing/selftests/ntb/ntb_test.sh writes back the "DMA
Address" that mw_trans<N> prints with %pad, i.e. in hexadecimal. As the
address format comes from ntb_tool itself, the first memory window test
fails this way independent of the NTB hardware driver:

  Running mw0 tests on: 0000:00:04.0 /  0000:00:05.0
  ntb_test.sh: line 117: echo: write error: Invalid argument

Parse the address with %lli again, which accepts any base, as before
that commit. To keep the format and the argument type matching, which
was the point of that commit, store it in a long long; it is passed on
as u64 as before. A negative address is accepted and converted to u64,
as it was before that commit. Keep %zu for the size.

Found by running the NTB selftest against a virtual NTB device in
QEMU; the fix was tested the same way (the unmodified selftest passes,
and hexadecimal writes to peer_mw_trans0 succeed 10 out of 10 times).

Fixes: 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and size_t in tool_peer_mw_trans_write")
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Cc: yangqixiao <yangqixiao@inspur.com>
Assisted-by: LLM
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
 drivers/ntb/test/ntb_tool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -928,7 +928,7 @@ static ssize_t tool_peer_mw_trans_write(
 	size_t buf_size, wsize;
 	char buf[TOOL_BUF_LEN];
 	int ret, n;
-	u64 addr;
+	long long addr;
 
 	buf_size = min(size, (sizeof(buf) - 1));
 	if (copy_from_user(buf, ubuf, buf_size))
@@ -936,7 +936,7 @@ static ssize_t tool_peer_mw_trans_write(
 
 	buf[buf_size] = '\0';
 
-	n = sscanf(buf, "%llu:%zu", &addr, &wsize);
+	n = sscanf(buf, "%lli:%zu", &addr, &wsize);
 	if (n != 2)
 		return -EINVAL;
 
-- 
2.34.1

