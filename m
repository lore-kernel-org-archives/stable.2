Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F61A9F97
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780701; cv=pass; b=bliWtXb9YnorN0EIh2017VbWCQmx8WuihYRMMfTA4KNsK1BR0cKugXUs9ljwAVjy1I9AXlzeM0nQ2I/cF9BdURVnTK06Zv75IdOqdKk9JDnYpEFuqxbGTLnRRsOyVbCqA1+vfJFo3WSEMDj4da96+GsVvNZiBxA9goI+H/ZNVVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780701; c=relaxed/simple;
	bh=vrxugpkTpl7KdNGKFYMacYLPmQTNtpTy7XB9HLJV6yw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FBdl4aseyreJwi9xNOzDuFsdEJcorX23tr76J52ooebPvI88d8q/osP/cvyMSnA7lT6KfHwDHagR5aBcFb6L39zyyP/iK6vz6NpWrQM3EnOyevILrfpBKIul3s3bFQXtKmsoTBTbVbgELOzPgknMxaocMBM1Ujwwy+G1bKjUHSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyKmgXtS; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyKmgXtS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e501244f5so84591585a.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 17:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782780699; cv=none;
        d=google.com; s=arc-20260327;
        b=Gr/0Ib/qiEEZ4nl46yTW6QKFNgJFEq6rr/AZbpwYUa1d45sh/W8n9ghW31XYumKn5L
         lsJNYdwajySqjcRfnrb6zRwn0mhwQ2WxLU2bKcWrEMcA7oXA7Wh6eTN03NlL1PYRgHHX
         VCb1TqrN7CPe6Pt6ZSA59WTbVFT2VzDMHfByZN57ywOWAvQPGPDcwzmIhyZrKZg5R2PV
         hiIps1Hr4mlNE7VnuBMBtI6dZcJXu48UkKyOrsj9H1a1jWI68StvMs6JEvkLOqs4l9TD
         Eqqbe9s8BPtxLxesy0nNx28WjwZujeDF7NJrelUZKP6FxVB+CSldW3u3CGXD3F2zoVR3
         TuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WWI2VOV9y/rPr8i1n2qeWbsdA31pb+M+pbfxyK4Oxcw=;
        fh=2oe+zNcCqK7v17kFPS7HcSINQGakPwE20wpOCltiafM=;
        b=LEDCg2OrOERFa9CeSeps+V/qfaziGwR2ElXXpON5QQ0sHHUNRVz/b97A+8N03qgE2l
         bzdjGqjetsqpRYZqO5drvWhpwvGE5WX7EyIFxdRJOn4+sdGlM6Qk/jRpBueiUXejNnwJ
         y+NjDxaUNgmPwWuU46eZ7WhH5e6IYXJmQLAKa5yiJcb0gde4PbKfl13dCKvrbcXM8bf7
         2BO9Ho8NBUqiUWMfELS5nz4tU1L5a3UJkMATFkIjPScU8pLLJ6nMQVFJ5aExZBNmkFEG
         YSBmxAyPfMzdB5A21WogK3TlCjdUL5uSIswzg+u6UAgp7TEiHE1daZeiLLVjcXtQRB0u
         4uOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782780699; x=1783385499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWI2VOV9y/rPr8i1n2qeWbsdA31pb+M+pbfxyK4Oxcw=;
        b=CyKmgXtSq+XipK9WL6qPSfjr7b1CcjrlkWKZbyUHFpk9EBRdWYKQC4LfDmipsFbaEH
         G4pyV1uhHroXz+FJCpkIBLGgEHMaEeZANmpHqsPbJTxbuEXAyq4R38MpMAmHbVmWE7EY
         CqwzE+acX/yZ9cz5d4LPweqZcbuhI6lFsUAlL91Ws+2x+81PYSWyvAxzn5cHWI9w4pMa
         JwXXvLpj+RC2zqRqQlEL6Ww9/3T/Rdoy+o0lHDwqyNi5eyBBUyd6CXQ11Y0XvtinXCJR
         n7vkhggEW2S9JtBk/kYCmBU1L9uFYhHe9ziGoQz7F2+ZIrdPW6jx2r+Dbr1V3yA86Cc1
         L6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780699; x=1783385499;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWI2VOV9y/rPr8i1n2qeWbsdA31pb+M+pbfxyK4Oxcw=;
        b=MrsRejXjSTnsW2ecWXivVDXJspnUX+k1e2jwFbz+ZOGN6oriIv1O3czwwoHQTmxQAM
         L85OUmsMQ4qqcOXCvgcUD0ZeqbS4Ch0qIHzwd4KJqrdUOIZSkpH2sjb+uxyuKAs6XLFr
         AJkeNtcGenzzanWeuzASe4/Rg+oTuOxqDaOgQvt2/d1nvA4ib8+kw+X8gjXHZqEBE29w
         0eYFp8LE5frzjozanLt6iLWo4nwpUSSOIbvCd1gsaE7kA/8hHq9s/k7invtKtwjq2Qz5
         6EdiGjkXFDXKdgDa8G7NGxJjVSdtMUaZEUOF+LpGa2y6imxdzUXPPY6mFgdnIqWO3EkX
         1LRg==
X-Gm-Message-State: AOJu0Yzfcxzsf/gnujlgscT0aDjoVBQU8iADepcbcmn7lLNZw+JgOJyF
	olV4WxSVCTqVJrP9scy/5+kzbfSBJPiE41j50pK/IjmOcijLqGsHGRFx1G2lZLU0iw1/QY/vkoO
	b0RxCYSUvynVuHnrdlzU2PkA4v6N3jaRyZ5oMMAw=
X-Gm-Gg: AfdE7clntsMfs/rk+QfwDUVh3Wq/wK9JQ0/GpufLbG6HXuMWpJfxVnboAfqaNU+4N3g
	bQoKXUAz+SwYBC8RWnmtEWB8YGBDs8gZiVBP5tOVMwSuiGJ+8dQw122vyL08+npuMTjV0TUQFT9
	q9lXLD502KMqEM/oukClihyCbU77ersTTkbsjKegb8Ydo64iZ7JMCHT6bAzoeiqV7U2AB687sBL
	rty2DLguaCc1T9HhmP3am/eoJBBm3APTw0QTQEswpuO2aqXDTJQn9L68toSCX1jtdGtl3iq
X-Received: by 2002:a05:620a:31a7:b0:92e:4ab0:98c2 with SMTP id
 af79cd13be357-92e626734bfmr279334585a.34.1782780699246; Mon, 29 Jun 2026
 17:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Annie Kim <pulpannie@gmail.com>
Date: Tue, 30 Jun 2026 09:51:28 +0900
X-Gm-Features: AVVi8CebmiXN-6-nNB_yRcYXkji4mcbRhXY-jLPtLMBnF5n8WQsf2iBHZ8Zb92Q
Message-ID: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
Subject: [LTS Backport Request] Fix RSS indirection table OOB write (6.1.y, 6.6.y)
To: stable@vger.kernel.org
Cc: mst@redhat.com, "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Hope this email finds you well. (Sorry I am resending it due to plaintext issue)

I am reporting a minor OOB write bug that was fixed in the mainline
kernel (commit c7114b1249fa) but is still missing from the stable LTS
trees (6.1.y, 6.6.y)
  - the fix: https://github.com/torvalds/linux/commit/86a48a00efdf61197b6658e52c6140463eb313dc
Please excuse me if this issue has already been acknowledged or deemed
non-critical. However, I am reporting it because this OOB write could
still be exploited by a malicious device or host OS to trigger
unexpected behavior in the guest VM.

Bug:
- drivers/net/virtio_net.c reads rss_max_indirection_table_length from
device config with no bound check, then uses it as a loop bound over a
fixed 128-entry array (indirection table) embedded in a kmalloc-512
buffer.
- A malicious device/hostOS can OOB write past the indirection table.
- Confirmed KASAN output (virtnet_init_default_rss is inlined into
virtnet_probe):
  BUG: KASAN: slab-out-of-bounds in virtnet_probe+0x2f46/0x3bc0
  Write of size 2 at addr ff110000bb9aed68 by task swapper/0/1

Impact:
most likely just guest kernel crash.
- At boot if the virtio-net device config reports
rss_max_indirection_table_length > 128, with values constrained to to
0..N-1 where N is the maximum number of vCPUs for the VM. (OOB write)
- At runtime if the guest runs "ethtool -X" on the buggy device.
Again, values are constrained to N. (OOB write, OOB read)

Exact files and affected code:
(Line numbers below are from 6.6.y (6.1.y is equivalent).)
drivers/net/virtio_net.c:223  #define VIRTIO_NET_RSS_MAX_TABLE_LEN 128
drivers/net/virtio_net.c:228  u16
indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];   (fixed-size array)
drivers/net/virtio_net.c:4816 vi->rss_indir_table_size =
virtio_cread16(... rss_max_indirection_table_length)   (unchecked
read)
drivers/net/virtio_net.c:3204 vi->ctrl->rss.indirection_table[i] =
indir_val;   (OOB write when size > 128, boot path)
drivers/net/virtio_net.c:3883 vi->ctrl->rss.indirection_table[i] =
rxfh->indir[i];   (OOB write, ethtool set_rxfh path)


Affected:
Trees containing c7114b1249fa (v5.18) but predating the fix (v6.13).
Confirmed by source inspection: 6.1.y, 6.6.y. Not affected: 6.12.y and
later (already fixed), 5.15.y and older (no virtio-net RSS).

To reproduce (I can send you the PoC if you need it):
Guest OS with VIRTIO_NET_F_RSS and UBSAN/KASAN; make QEMU return 512
for rss_max_indirection_table_length in virtio_net_get_config(); boot
triggers an out-of-bounds write report in virtnet_init_default_rss().

Proposed fix:
The canonical fix is the upstream commit 86a48a00efdf, which makes the
indirection table dynamically sized. Please apply 86a48a00efdf to
6.6.y and 6.1.y.

Thanks,
Annie Kim
