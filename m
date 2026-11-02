Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627975;
	b=0Y2aSTvqfnRjDeY72A5nenbk1i+5gIZhRocjKs48gud0YZsnHxlMrfU24T6hFYhSzD9F
	 cBNzBhmsrbo/haN+t/x958HOBkm7DalTxDBV1emSrSD62SY9L0/oioj//YNIsu5QTuS/0
	 NF9xpTEzOfhSdcFfCS2DXaK/VNqcMxrJ+hgfom97uBSQBZ+qsnuKh01EQoTGDPrfH/4ZH
	 MJR/TuuK5FJw3IFRjBnheGsvEczKjRKc4jioW6msTuFuNh0pyTnQcRGLm7uS23aTSknT6
	 Iq7fTFKQDdSqNycFM+wLj9vhkKhA1cOBHqgCN5cPyVaE6zFjWdmI5qrB48Q5vyhP0Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4wvmxRssayt2Gh/JlDXJzYBinssZXZB4IERgvDYW9IY=;
	b=mSWo7JOzW37vZcttij07fM+pNMI5FTv5QovR5pOwLREqPKRwOdDnyUMKriCInoO96WL/
	 snPhhhJiTPTb6DIeUwZOAINghjTyPCtsR4GxG+7ojkU0p107rlrxqBpNPoEdc7Kv6rWpJ
	 uW8hjpwPDZ8AdGzPaMtqGTujpjMvONlTVzirDiG2fPd/9VYiz7PBqqno5rSJO/JJ8u0sM
	 ZBGn9Eg0DnTxjagiYRqT+balS7s6co/cWxDZChNKBbIOFQ8fmnhWCG6SDNADblxSIEicT
	 P/1df3HTOoApJOb9rsTqoCeCQiuNScY/ecL/MpH3qXnSHE5rJv3IEIEZ4id6eb54ETw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyD8COu+;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA060A263E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FA060A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyD8COu+
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso30835195e9.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627973; x=1794232773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wvmxRssayt2Gh/JlDXJzYBinssZXZB4IERgvDYW9IY=;
        b=vyD8COu+frj4RNaBSRa57YJmHsoCzs2zU3MPsoqpSW7zJ58Oux6nDakb61yQZVMsvk
         XY4C8Xkohyp0A4mLJ9+HMH9zb1kokJF6nfADDFmzBLGZdcmJVfNq+wMxZcsQxOlFow+G
         ZIEQb+zOxL30lgzK3586obNv6TXVZlaqL4WU+wWHPLONDH/qcxVo8OHLfA46pL8SKo9A
         U+cIvzaEaX3/xImY1zmsVwiOz/ZfoX4h4/qmH6Q5v6u9Nx0xIJpgqmwWY7vw2JnyeG8K
         2EmRn91UL8NezbJ9Q6tYhu8e5M5JdvEd2P0bpWx6AH2kmYJCv3oROp8kGBIDrNlCscbO
         6gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627973; x=1794232773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wvmxRssayt2Gh/JlDXJzYBinssZXZB4IERgvDYW9IY=;
        b=XPEbvYpZg796y63WkJTkekpZU49MW28BL1uGH9Lk0qId/UPu6OqWNblH2LYdJW8Hhi
         juXaWxQDG25LjhaOGFCcGKtqOcWjWCdUZt5lxl9RO5AvgfaZguUwafkubpxtLp6WyBly
         OCo4UykcSAPSqC9VRASxX1qGKZKy9XIRhxgRL4gvZ+o/eo9f9Ov847pCiUu9fB14gs4K
         6hT5dpy0ECHiX7E5PT7VB3O3dDdK/LO7IkHdRwGvY/UTf4BxZ4EtXBB2iq3gjyJKvKP7
         4iyfGsUR3T2rPHxH3YM1HvJ1mYfuIR1H6trtWxZBOHny2DW8eU8aIQpRdnUR2fhNTh7x
         2wJg==
X-Forwarded-Encrypted: i=1; AKwUvBxIZMNe2xlQEjyTTP4DRYeuW1W19l4mG0/v559MR05j0z+T9AFKM9Q/WJ1V4ztlN8Acf1RdJqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6dn9uQTGUMuG8xuH1aXs00vaKOgsLmr2BeT7GnKZ3YDbxq5ys
	EBU83i7QAtWVTCr6IO5opKp8+X0/JRQu5e48gVyhbG90WMeg+yK5DN4=
X-Gm-Gg: AYBFou21resEUNfD0FyFulxNeXBbPeJrIPXzCt0B77cGvniyXAz1hAcKiZ/st9nNR+2
	7rPdVVtk0bTRrAYIi2MJQcgdzaw7+EII4dc50VsUUddrnp99XeA0Vqg5FazCebCexSWXH2NE6Fq
	UrZyYA1JOrZrWto5oTy2TUEwjRi5QIs8O+0LsQo9ni49d17knSMGWuq4D0BCn/jTqOk7pyYa25K
	ubDN4U9U1hyDz7cFjFS3xRe9QHNIgsWdEHpJKE6+/OsDeP4epP80Fvj5+4U9y6qlJD/vgLBqOmC
	OcCmu8GSZALojIE1uxl77axPgS4UUi60ETosul6j6M4sRguJ4rP61ghHAdelPysV6m8D911QZ6/
	cMyG7Bi7kzXCbPWUUbmsDCpGqZa7/6BfMhHoq+3f30VrPx1ODwTfbzbNQW4x1ruPU6jLATadueo
	666QqvDc+vj2LfTz0n9I3JGZhoIlWf/F9rdNc3CtoRXyRXu4GssIoZhDuT7Le6oSiHP7SAG9VgX
	9BWf5Ia0JtV7LBVScG8x8QDjNanoefM6J5yKuQ+yAFB+VA7lfAZPclJu8g90rfPFSzSffnUVkCI
	Mrc6PO6BBEaa
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4ac1793f8ddmr242811975e9.14.1793627973338;
        Mon, 02 Nov 2026 05:59:33 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm352680265e9.12.2026.11.02.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:59:32 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: briannorris@chromium.org,
	francesco@dolcini.it
Cc: bzhao@marvell.com,
	akarwar@marvell.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 1/2] wifi: mwifiex: validate ext_scan buf_size against event buffer length
Date: Mon,  2 Nov 2026 13:59:29 +0000
Message-ID: <20261102135930.701845-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102135930.701845-1-tristan@talencesecurity.com>
References: <20261102135930.701845-1-tristan@talencesecurity.com>
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

mwifiex_handle_event_ext_scan_report() uses the firmware-provided
buf_size to determine how much scan response data to parse, but never
checks it against the actual event buffer length. A firmware response
with an inflated buf_size causes reads past the event buffer.

Add a check that the declared buf_size plus the event header does not
exceed the event skb length before parsing scan results.

Fixes: 21f58d200388 ("mwifiex: implement extended scan feature")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index bdd4b8465863b..77f55a3f9b450 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2631,6 +2631,15 @@ int mwifiex_handle_event_ext_scan_report(struct mwifiex_private *priv,
 	u8 *scan_resp = buf + sizeof(struct mwifiex_event_scan_result);
 	u16 scan_resp_size = le16_to_cpu(event_scan->buf_size);
 
+	if (sizeof(struct mwifiex_event_scan_result) + scan_resp_size >
+	    adapter->event_skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "EXT_SCAN: buf_size %u exceeds event length %u\n",
+			    scan_resp_size, adapter->event_skb->len);
+		ret = -1;
+		goto check_next_scan;
+	}
+
 	if (num_of_set > MWIFIEX_MAX_AP) {
 		mwifiex_dbg(adapter, ERROR,
 			    "EXT_SCAN: Invalid number of AP returned (%d)!!\n",
-- 
2.47.3

