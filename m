Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429285;
	b=VhKTdzaTDGLqo8N37223zW5AejaXFraqFeg6NJKvr6CvapxVwJZ6viG+cCp72SJmBoxU
	 VRUjMzZP+jSCiqGYdIWrzhRO55Xbf51GLq0asVnBiNkJ6egns9HkF6ngM92JwrThlzh4t
	 gDfZIWHp7oRmS9bBon0NSiNZMkPh+NEG9GW2mDHA6wY6J0MkRfIU+jbWMqxUF+7dUjqEG
	 m9vHnyBpff0gZADUD6IsBG8f9tHKPThvpM69wv8Vz0VYujtNx/avgpgg4yGj6ql8xGv3B
	 7HIs4HpiMmPYaImiaZYKKnUr84em3tUJEGbiq9x7SSbqFIJRpMVhjrM5indEBOyI6lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429285;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=w8p8m5DjVMBSrwiq6bXrGhA8+EN+mWvM6EpWmDSChR4=;
	b=WcYMIhJiSIkNPnyctRCKyFBoJKTvfP9ZKZ9HBqnZCm/VU0KsIJdtlzdsUNXYB1O/GiWV
	 KgXwyFf54t1yoaH0mpdt9cPaFrvqFo+9MrYWCTUOV49olkouVwc3j+F+Tes+qqEeUgV3c
	 TMhUVqDF+WwDooIijjFg21YVprX3LYU3CEcEdZDNPq6vnk71ruYC++0prTQUxVUX5VKl5
	 iTlUCnt3riPxbbTC9ivCQhyGQp8VBViCksY4iii0y/BwLG9X4ekwemHZW3q6D6U0oFqc4
	 dPeR1eNcmJbCXgfqvHG+jEhZ/objcocDXgH1tYuJRt7Tx8Vh7jgGz3RE4P2r9K0g1nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=justthetip.ca;
	spf=pass smtp.mailfrom=justthetip.ca;
	dkim=pass header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=n07WgLWV;
	arc=none smtp.remote-ip=91.218.175.105
Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942A606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7942A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=n07WgLWV
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0x8x8x+fKY2Y6jyMC+O/5KwxOqoFU+Cw86mPFidozF4=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792429282; v=1; x=1793034082;
 b=n07WgLWVmaMa383egFTHzyZ4+1p01tRim6FVFMxYj0p8y2hRtRn7Nm4NSipO5COZEwnTpl8I
 n5VbYggzEDbZtvBWVWX1zm23Q17791QtHpGVMQvEJMacXmLJFdZTxmYrjN9k8urSbhrHoiXDMhv
 e060vvsUGVi4t5gPYpX3oa8hBw7VGHdyY8OatUT+WD9kNHWSXQ37oTqP6Zqcyp+54Aoyck42TTw
 X99PJehUpXW16ARAAL3hj65EvkwI7N4ql8qvWNGgO4IoDAF2rAVgWaxWkDYKyf1Rtb1rQo9nMMg
 0d5ZyV8K/V91jpaS8pMVKCjjJ+lxmm3fWjogobXD/Ee3w==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4622ebdc0972b596;
	Mon, 19 Oct 2026 17:01:22 +0000
X-Mizu-Trace-ID: 4622ebdc0972b596
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v2] wifi: rtw89: debug: return the error when a read handler fails
Date: Mon, 19 Oct 2026 10:01:20 -0700
Message-ID: <20261019170120.726156-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
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

Return the error when a read handler fails, instead of passing it to the
copy to userspace as a length:

  rtw89_8852bu 2-1:1.0: invalid read reg len 0
  usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-8k' (offset 56, size 262144)!
  kernel BUG at mm/usercopy.c:102!

Fixes: 831cceed3baf ("wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file")
Cc: stable@vger.kernel.org
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
v2: reword commit message

Reading read_reg in debugfs before choosing a register gives the log
above every time on an RTL8852BU. I found it while testing an RTL8922AU
patch, and it does the same there. After the BUG the driver cannot be
unloaded. Without hardened usercopy the read returns kernel memory
instead. The error is also kept for reads at a later offset, so reading
mac_mem_dump at offset 1 after a failed read hits it too.

  RTL8852BU over USB                 before    after
  read_reg, nothing chosen
    6.18.52                          BUG       -EINVAL
    7.2.6                            BUG       -EINVAL
    6.18.52, hardened usercopy off   256 KB    -EINVAL
  mac_mem_dump at offset 1,
  after a failed read
    6.18.52                          BUG       -ENOENT
    7.2.6                            BUG       -ENOENT
    6.18.52, hardened usercopy off   256 KB    -ENOENT

  RTL8922AU over USB                 before    after
  read_reg, nothing chosen
    7.2.6                            BUG       -EINVAL
  mac_mem_dump at offset 1,
  after a failed read
    7.2.6                            BUG       -ENOENT

 drivers/net/wireless/realtek/rtw89/debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 3a430bd08..3b7f8a809 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -185,6 +185,9 @@ static ssize_t rtw89_debugfs_file_read(struct file *file, char __user *userbuf,
 	debugfs_priv->rused = n;
 
 out:
+	if (n < 0)
+		return n;
+
 	return simple_read_from_buffer(userbuf, count, ppos, buf, n);
 }
 
-- 
2.56.0

