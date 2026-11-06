Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951889;
	b=SuqpsT/nvfF8czQ5GOOnutVmKpXWVwJnzzx3J+dTBjtD7mJZB859HyqfnHms9/A4O7M7
	 vG6hRKPdSQ+OkFIbXlZkWnUkLdQmq93JKF5yCgTNs+a5Du1rbnbCBMTuDLKaEdfnpXAjp
	 pjh74dBUNeXoYGymOThgEPcm0OSEzCo1zIwF1HCZKB8XOJ7GVRgjUP6CQ1ZREBTascAF9
	 YQO32C09IvfmqGkup/0SHw2KSaS8ESEgWxh0CDt41T9zu3i+DvLhKEHCfxbaOH243jClo
	 zxBuOC6wPR2P2Tg8ePKvzwX61SaexIBPbVNbLMbRVSKfYEehU7J+DM9cLXRSh9o4yvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951889;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N6IDFcqBT66Ly0mje/ldO2xjtUcjknZLvpb4a2Ah/h0=;
	b=Wlnp7IN+t9CMfSUJtSDGlqpImhZvIibd73A00cfKYj9UQRwQAuMlgZpUwf+Upa77e2iu
	 v55BA8rcjKpFtc9+pBbemy9vs/I4oxdtHRqm1n7Wk+/OGYX36ca3mQLU7iVCQap1pOS3O
	 LK76JBDil6Ny3NtdOBzxThmMROMYxarm/pe6chCM8E/QvnrfXmuCFgBzMeDPiWhorodLO
	 mw5u5qLItmUgZw6eZgSwtXXNu685HWLzfbaewRcToDFUooBnVDCIURMt6maGn2BD9zFXU
	 V8kJ/D7j1j1gdulGTeTyaWrlCGmq7buYM0jFZIPL23GeA8hpzp165Od34rIL9/ZviTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xhZa5zyD;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCC606A326;
	Fri,  6 Nov 2026 07:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDCC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xhZa5zyD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793951882; bh=N6IDFcqBT66Ly0mje/ldO2xjtUcjknZLvpb4a2Ah/h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xhZa5zyDbr5HPXgRGg1FVidmH0ZxHc9an8PMxPY65XRPRaiHVbGFZzwq6uktWmsoI
	 6tYohRjn4d50GkLYoaoKVrd/WqBZ+u4TxFDrEgxEIciRLYLoz1+WINUdTTkNgqd1ws
	 eiMWIoim0Dykfhw27jUFue76agOzI+CeD9K1wz1U=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E7B38225; Fri, 06 Nov 2026 15:57:59 +0800
X-QQ-mid: xmsmtpt1793951879tivh0zjg2
Message-ID: <tencent_9EF27B4D21B82E623513AEEE6ED2F92C7D08@qq.com>
X-QQ-XMAILINFO: OATpkVjS499ug70r33O1iL5s+mMR3MjVq8p9aUJ5tubQwsA1Fuqm0IezGzcTN9
	 X5aYwm/Sd1IArjjm+2fYkjUa+5/buca2pyh2KvE+g7gkaSDeQfQ2xkvvL4Tvo/7SjlOfjV7crtyh
	 VdwgxmWl99qvHr+DwNnWm/I/78d4Lvt5FMTwQaDuTFacZKA3z9QbW0wa1o+cVYwAFuB/ncFZIy5u
	 DJFKjr+PJtH9hqYnGY2u9iR7sFdTNtTUSpR3WsiStLOXMU0X+clA78DRzAxW3gFom7ZsSRXK7Dcc
	 pDON58VYG0o9cp5Ub9trM6AzsBOWFLlcwx7lQ61jgAkzozTSNB7RvYNn8znG72SmctgYmPiAbQw9
	 K4QCsoT6N3Hn6+ir3bVAnYtyKELchllRQkcRhlJOOqHyn2Kv67uE99Z4t2BqtyaX+iEYnYPHFWct
	 luAyQ+IwVwPnKRGwYpc9N/piAwP+3KY8KbvLYwuP72CfJO0gGJKgi8rxmfymZ/4BHlNbSn7Zordu
	 p/e7ZcP/wTMdMmnuD/i1W35OlK0/mNCS+RzcacyUHE4DT5ypZeMvIMYrIAzXYp9fIoxVC5k2KD4D
	 oXN8CUlyN5HgUsJXx6po4Y+Rw5SbaD1FZYJ/z7pMvVcXDeKaBDzQln2gT/CVQPoLIaGHwrLtHO7C
	 eZqivDqBqhSX8Cb4IKUG15rtUP45qJu1y/SiPCnyDXZWEJIZWBqgoqMghLaxCZ1qXG3g+qnF21a8
	 HMUWdNELJdTpLjeC7DApZzKbuT+F5MKspJ4o3iB5f/DDUCk2jSbMTfoyoBYybaZEjstpjR4NoLEe
	 7bCCvh8wPw61H30aH9uaRsSuNgTjHe+uE1hl+y3+x/UlonKuoL9KAn9QsioyRgQW+NicpzNFjJ1E
	 15X/Zm00EAmwfoZfa82rl/IANDrdgYgOIrgoevQ0mNU5y4ka1ZIthzZllzXui0EFlLoBx9BEOFOp
	 Dp10WhHRtYhOYgEms9M79727uDNeRbR9YHw1mq7sSX5Bkwn2JRf1b97inm61+QHWVOpzVMsnSN7Z
	 F61CLbOKdkKrue7eZ8QYBbU9UzjwvTfqP3e8pyver1gPs0kLurKfIdhx/jB57UvP4BBAB0NFjP9X
	 pEIi/Ho1+G2rdHehw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Shuai Liu <847807867@qq.com>
To: linux-mtd@lists.infradead.org
Cc: dwmw2@infradead.org,
	richard@nod.at,
	linux-kernel@vger.kernel.org,
	syzbot+0727f46a0571de01bf93@syzkaller.appspotmail.com,
	syzbot+48f2d47f83a4c223ad14@syzkaller.appspotmail.com,
	syzbot+e4484dcf0982d86ca2e1@syzkaller.appspotmail.com,
	me@eltavine.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v2] jffs2: fix kernel BUG in jffs2_sum_write_sumnode on empty summary
Date: Fri,  6 Nov 2026 15:57:58 +0800
X-OQ-MSGID: <20261106075758.671859-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179393007518.5660.257036208046697688@eltavine.com>
References: <179393007518.5660.257036208046697688@eltavine.com>
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

From: eltavine <me@eltavine.com>

With CONFIG_JFFS2_SUMMARY enabled, jffs2_do_reserve_space() tries to
write out the current block's summary when a node and its summary
overhead do not fit. jffs2_sum_write_sumnode() assumes that at least
one summary entry has been collected and calls BUG() otherwise.

An empty summary is a valid state. For example, the syzbot reproducer
mounts an image whose selected nextblock contains only a cleanmarker
and padding, leaving 140 bytes free and no summary entries. Creating
a symlink needs 128 bytes for its inode node, but reserving another
60 bytes for the summary reaches the BUG():

  kernel BUG at fs/jffs2/summary.c:868!

Large pristine-node GC reservations and xattr updates that fail after
reserving space can also leave a newly selected block with an empty
summary and reach the same check.

Disable summary collection for the block and return through the
existing exit path. jffs2_do_reserve_space() then retries the
reservation without summary overhead, following the existing fallback
for a summary that does not fit. Use dbg_summary() for this valid
condition.

The block is scanned normally on the next mount. The on-flash format
and xattr size limits are unchanged.

Fixes: e631ddba5887 ("[JFFS2] Add erase block summary support (mount time improvement)")
Reported-by: syzbot+0727f46a0571de01bf93@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0727f46a0571de01bf93
Reported-by: syzbot+48f2d47f83a4c223ad14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48f2d47f83a4c223ad14
Reported-by: syzbot+e4484dcf0982d86ca2e1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4484dcf0982d86ca2e1
Cc: stable@vger.kernel.org
Signed-off-by: eltavine <me@eltavine.com>
Signed-off-by: Shuai Liu <847807867@qq.com>
---

Changes in v2:
  - Credit eltavine as the code author per his request, restoring his
    original comment and debug wording, and carry his Fixes: tag, the
    additional syzbot reports and the stable Cc from his RFC. (eltavine)
  - Runtime-verified on x86_64 QEMU (block2mtd backing store, KASAN
    kernel): the syzbot C reproducer hits the BUG 2/2 runs on the
    unpatched kernel, and completes cleanly on the patched kernel.

 fs/jffs2/summary.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 4521a7723f306..4a07b7911b210 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -864,8 +864,11 @@ int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
 		goto out;
 
 	if (!c->summary->sum_num || !c->summary->sum_list_head) {
-		JFFS2_WARNING("Empty summary info!!!\n");
-		BUG();
+		/* Nothing collected yet, e.g. freshly opened jeb */
+		dbg_summary("empty summary, disabling it for jeb at 0x%08x\n",
+			    jeb->offset);
+		jffs2_sum_disable_collecting(c->summary);
+		goto out;
 	}
 
 	datasize = c->summary->sum_size + sizeof(struct jffs2_sum_marker);
-- 
2.43.0

