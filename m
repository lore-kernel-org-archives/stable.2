Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794129;
	b=ikRVTBcY1MEZ4ImmPOBn78u/W5oISaGmENjFLL/0F34MCmy0c5ikumANvZKF3nLRs0RT
	 eL4VvFMyCjkVGVe/pSFJ9QwJ9I6vA4ZjyS3dhAs474jc7Oz5lvfdDRxd0CTwIRnxumGWx
	 su0eFKKbi6l9ei0/UFidyJWQ1EB8RmG/vkitA27N0szQEBF8xIZgyl01cH66E1mW78d86
	 F7exsT7N+4Xa9Ikrwr646OdqCNwrbtpcuJkl9NZ1mO7uR/LvAdWz2SZmmcpIzBQN8shaW
	 7ZSATOqElbAcdt2bSqKZUq6tlFcOSTpwNMJddRP555lHVcHG7ZvoZrEB/npTDZRj3cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e2fJZFZERBeQNZtQBCOfYByS4NMe3sHfsqjEP9dc6kw=;
	b=oJ3icxij9lExKLMBP5RV+4GHlO5cmoB1h5rYedARn/GMbJOzSIgkGmM9LQbxXpDO9/+F
	 Cztjzqy9ebGRigRAhBBoyLWuoUFhO023LcvEz7KNrftNJorYGCSsOgaxDL+r3sfVfToz9
	 cmSSq5iCxX/5N7U20iR5QRxmRQAJFn9KVx0b7/v4Az1yVGqkp7vCR9FLjX5Dkgyax/ZM8
	 8oT/yFgto8m4ENfBUEFnmY7vliQ+CyItXd+3omY2jhY5Eo11ypqSIYrKv+T6z5MyemUhs
	 T20afXw0mLwqTIg3ZfYxMkjQ7r47in7c/1ghQH/UfzZ5eJYGCCLeA7m5m8eQhD2tE3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SRiWno0Y;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0603606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0603606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SRiWno0Y
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso28258885e9.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795794127; x=1796398927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2fJZFZERBeQNZtQBCOfYByS4NMe3sHfsqjEP9dc6kw=;
        b=SRiWno0Y1jdZyPsbE4n6wIFpmgpJpwhE2Su76T7JV0vCvkt5xD5pmfy1BDCLeGlsGs
         0N1KShPEoYZ8kCWwDlRuMNdqtFiQVR8lTFHc6zK1dcB+vPTN8JeA9fyc1eBzcrq5+Bzu
         8gagrolZ1aeYgxcDWBKFPC4Z/GWz5KE9FC9dmUnMpZByUmk8M2QcmFu0ZZOsWVOLI699
         u6rOYspTYX6Q85yoYrFZot8MKjQSvgrMKZP+Mxm32oyZPXJPfVPxqjkqNP7zUXTOiI7b
         lwncZWrGjEboyvV8m/WVt8uYWUkH7zfyyJc215BzJpQH2gp7bAgGKBecJLx0orpHO1KX
         Yo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794127; x=1796398927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2fJZFZERBeQNZtQBCOfYByS4NMe3sHfsqjEP9dc6kw=;
        b=2KuilzT7XScqDhEY+Zu4/x+LkbuHdZXWFqo1hwzgAcRIWh6b8ThRF2VeVXdJ+3Gi1g
         R9sBAZ4P8rwUGEh5En8Ixf4Lo6nQE0cyG1vZWo1O6MqnWkk5YWc3vOwylYgN5e88IA35
         1/ODyjqqnVjINZ0FQuMB2eh39kaVANt+VhoQXUB5/a51zIKoT3mrS/4q0TNGqRFOl0wU
         qKP3hKIpngQuKH14kO/Mf4zRIBBH7oRzcyT1Pta/NGpXRen9T9CCDU7E06axUX25kmwo
         JCz/HjDq23s4smaFEnwtKmPt9io2bVkWfHoFtZmZc/jL/OnnX3J2EeFxPKuqHf4qJHZi
         yl4Q==
X-Forwarded-Encrypted: i=1; AL+hErG9YLU4O2b0xwciERqTZ1+LltJMVM2tDSXldup+bb+rPG+qFrnbmOU6zMynxdnGXui5/jq/KKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tE01jEUI9dUuxv8gFFcfbeaW/6TOoAp4G/Dh1Z0bPtN7nZz9Z
	5g0cTpoFxII2X5n1ZVX4UhpRH8fefyF5ER2Ef7U9JdNO8HbmCu9NwpS9Gtd1eLiubYs=
X-Gm-Gg: AZFdTZdj2+zDFbNbdQWZXA5WWtngADf38NdjqoudS9sSA/Lb6Uzdm69CNOT0JXiVRxU
	UgnbEdSgJZsNAR9s0pYN+sXzWBleqh8bpiQw6TgGbnt6P2IhiKPRlcM9agNiFaIM9BJH4WC/xPf
	0X5fQjvuByhzY1QfAabG+s3MTfqOqGlg9RVaAFZ1n5TOLx0j8CYPpDQiwdqI9N8Xe3HNNsr8kB+
	X59WyVJjGVPYNYwWkQsH0Z+4dm+V8EWrzqf+WXVj/squ+WEdxYMLPdTwnvJZOjBgnf/gyW30UGI
	DRYRGUQHBcF9/8ByhRGOPUsamjq019OqRd/9mDBvoPTu9/xTqkj1NowTtwL1Wt1PakzdAlFtPLG
	4iBGIFncDn3N5l8ewO3X7D979wnY5tTYQBk2EHo2Wd8ft2JAOdaOetN7fpRw3jqc7Qz+AnIOr87
	goH2YNqm5GCy8TjVOh4dj5TTISu5EQ1EzbZ80TI39N7NhhqedL9CcoO6w4bVVX2D9hRsmftlqJz
	TP4xmBVIuwN9wbGSPTMnxjJ9UM1OcKVaDO0BjhiSgeIOuRu46Xx3O5uJ6EJ/uEFplzvZx6Xigih
	WFDFaXnzywL/twnUYTY5aQPtxgo3zT3wA0gybVa819vxGBAIC7vfvFtjTb9NUbyOs7xPAvb3WSw
	Z/9DwpbEZ9yMH2lxZ2HpgzUOJlAZ2x+tXaK/GilCmp3lBHs09IXAOb1e/VNUC2AD3V43dbBZSVV
	GedTNoCs28oFKu
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4bb88800134mr482703475e9.11.1795794126985;
        Fri, 27 Nov 2026 07:42:06 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm959073745e9.13.2026.11.27.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:42:06 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Koichiro Den <den@valinux.co.jp>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	yangqixiao <yangqixiao@inspur.com>,
	stable@vger.kernel.org,
	Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
Subject: [PATCH v2] ntb: ntb_tool: accept hexadecimal addresses in peer_mw_trans again
Date: Fri, 27 Nov 2026 18:41:57 +0300
Message-Id: <20261127154157.3541-1-kaynak.oguzhan0@gmail.com>
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

Split the input at the ':' and parse the address with kstrtou64() in
base 0, which accepts decimal and hexadecimal. A negative address stays
rejected, as it is since that commit. The size is parsed with %zu as
before.

Found by running the NTB selftest against a virtual NTB device in
QEMU; the fix was tested the same way (the unmodified selftest passes,
hexadecimal writes to peer_mw_trans0 succeed, and malformed input
including a negative address is rejected).

Fixes: 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and size_t in tool_peer_mw_trans_write")
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Cc: yangqixiao <yangqixiao@inspur.com>
Suggested-by: Koichiro Den <den@valinux.co.jp>
Assisted-by: LLM
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
v2:
- Keep rejecting a negative address: split at ':' with strsep() and
  parse the address with kstrtou64(base 0) instead of going back to
  %lli (Koichiro Den).
- Koichiro's Reviewed-by on v1 is not carried over, as the code changed.

v1: https://lore.kernel.org/all/20261126031506.165973-1-kaynak.oguzhan0@gmail.com/

 drivers/ntb/test/ntb_tool.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -927,7 +927,8 @@ static ssize_t tool_peer_mw_trans_write(
 	struct tool_mw *outmw = outmw_wrap->mw;
 	size_t buf_size, wsize;
 	char buf[TOOL_BUF_LEN];
-	int ret, n;
+	char *addr_str, *size_str;
+	int ret;
 	u64 addr;
 
 	buf_size = min(size, (sizeof(buf) - 1));
@@ -936,8 +937,16 @@ static ssize_t tool_peer_mw_trans_write(
 
 	buf[buf_size] = '\0';
 
-	n = sscanf(buf, "%llu:%zu", &addr, &wsize);
-	if (n != 2)
+	size_str = buf;
+	addr_str = strsep(&size_str, ":");
+	if (!size_str)
+		return -EINVAL;
+
+	ret = kstrtou64(addr_str, 0, &addr);
+	if (ret)
+		return ret;
+
+	if (sscanf(size_str, "%zu", &wsize) != 1)
 		return -EINVAL;
 
 	tool_free_peer_mw(outmw->tc, outmw->widx);
-- 
2.34.1

