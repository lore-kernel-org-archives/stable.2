Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877983;
	b=EC1xHi5ZGBZqdI444lxCEZBg6DAp4lw/Z05iPfufcBExW5ZcNCriNyxj3arUfTXbzn2V
	 yLZto5uKRxfPbLrQE0QQnbITM2wPQGBeKYZxfKmvSlHQO+PVsp+crUld8JPTlRPje3d3E
	 ygurDvK3d5vFAAKSNGo64N53oyEUREZ3XF8ZkR15nyMj8lUjq8t/Vf303nEr7L91kRKVY
	 qW8Jc1z9R6sZRVankgj6oO8KkhzIBDMJqEUjtsbYZNEad8hT4MLV+sXAaq6zfUBdbxZxk
	 +W51lEH/TAefPi/YCzFlc2DcuzM3VbMOze8zcyKk/wlj/VKKTuFGQUJkl0F5Z8Xx/wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NUhA+uZG5XdxMUQDorM5AwEpculFp+rMbhcc7G7XRe8=;
	b=Oi7iGfrIYcPJ+6i+/hTaGBWPlUGjF9imVgW8Z8PAZHN0l4bumoxN0TFETfpULoG9Vl29
	 UXtYJtK91jwH9in20cO9MV8WviCA1Gm1bDMWvK7NaARgAdUd32kZv8F5WkXCQjRutvI5B
	 o0a1GZJ9I4LxM8oRdq9wRwhEWm19DrDgUOMUvpBNOfNqgwmYrca6fKE0WEaS36dduycbx
	 0rkFgMOlXxtroT9WuiwVqi+ofrfFgQ0jtLgBnri+KtzPekIm/XYJJOl2jV3jtlOjoiFD0
	 y4QGatkJJv4o8Qew74M801WVar4aJ/hmjaWww4aC7vlfiZC8ED7TsKy0IEctdgJc5BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ8F7IZ1;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BE606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A85BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ8F7IZ1
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so5727531c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794877982; x=1795482782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUhA+uZG5XdxMUQDorM5AwEpculFp+rMbhcc7G7XRe8=;
        b=KJ8F7IZ1fdLevvCAy9EWM+XFt/RwS4rzLVHGli7ayJ31VQO43qztXGUFmJHFL8vkUU
         HmD9yzFIxOK0kWtwiViO6o/rgaP8h68DBBc37qdsVQGSbR6zZ5CSwDALHtKsxAwt5Yx1
         LISL42V6M3b6ftocHAR/oLF966NmrY/VAfJPQ77XtLO/p08y8+OzpHZMfXw5AsZXBYOg
         Z47Nbl/Xbg0P4vhQ4RjHv9kbzNmB7MBej6bTeRTovRctBCnBOF5n3aCVGyJwVlBqtOHx
         /N+3RZDY4FAsxPJZuOkUQgUMmuInC7JYHEKjVcbzgS1Y60X3EYgn4B/3trXiUNLkaUOn
         I1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794877982; x=1795482782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUhA+uZG5XdxMUQDorM5AwEpculFp+rMbhcc7G7XRe8=;
        b=l1DJU/Y0FuufdxnLTCJUGerbys+essr5g20hlDr2LLgmtGcY67/KIE6+KNE29LaK7B
         rD/5l/qHbOauZoQ0RKAFv+E8XLCEQAqzn3Z4VpU8DV+Aw0cVBP4DYu3VuGZW2LOO2DlE
         q8bNZmBNe9P6CJ3eea2EEZTbCyclAHpcF3EywqU6bxsvsYOExo7LIFi+lFm2y6revymO
         bkgU7D/P+cekMAt0vfgDytMi5mOXMtALgQ8jwdPSdPbgG5mYF5Q/3K9Q9vvbnsyrXhEm
         wfSnUAG7oMON+75HJ0IZwP5Mn6G1WjeBxt5Vyf85P60ppkKmUdfqCrck0PUU4E7cqdoa
         mWkA==
X-Forwarded-Encrypted: i=1; AL+hErF1s5TtPFd/nP+Dr+/4lvlY5Fchm4nGfZHYAd7gQt3w0p4Y+XExKILOk7UjWWFvZE7T5Vxmm40=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hVFWSHI4dWL+WakjGVpces97LOb1sqnb2Ywe9KFG2wEH0JTTw
	mbryKSXgbMhtxGm840DH1p+sRsqMYgxD4Jg1aXwuZYZZ5qfUwtd4pM51cxC/64G9Kj0=
X-Gm-Gg: AYBFou3GR/Td5/Co6RsGdpK1c63Kj4ElhELfLQ+NZzMCAAKRcLO6V22ils/8qkAKxgl
	5wcma9fbXGBE/j8fynQmMaweiSwrxY7Wg/54olK1ASLSwo2AO0ay1uJI9QY0gnpY+BivyMpsNdT
	rlWnoe5cAykYIB9HUEivQlheZ6uqLi9LlkmOJVqV+yh6PMsZid2YYssZ5D/ucLVE1r68m0FeQQW
	NlGhBhB+rsfnVP7u8KgRml2iSI6LYLYfshmkFvSuvASTr4F3qrN0MHL1fom7Xvfkdp5avimeQv8
	Jkt6GsIGjOHdxye1QY4vrZf54xS/82RkonrJZSqulXXYMfX5G9Q1sW6OUtHhx21x5F8/xpbJjo8
	ScQgM8vzX5hptOdM3g9ic1S1Dhpx03Kcy0dmFZJGuI8OrkpAucWorIoRlW+/4DxLfIQxUX8d/vX
	Nh2rm+t2nv4Qb3vUEF8wYgVXEs3DraM2aoICchrg4h9wAdsdcbNnxqvvItJGDE4VSs/DYQvRVOT
	o/3VPn7Ic7ARlmS2OUzj5iK/MRXAPQuUdZZJT6n9FYRP2Jxi5j3uc2yiEUBZSw9thQk7kxcnKrZ
	Oi9WQsJ4MYdHHBpDWcg+YQ8cS8nnlrqs6OqJN/sujd5mW6DYBqjBAsKVI2AakvAvZwq8LQ9exZf
	PIaTaZE9ucsspfXsr7TPc+Ec=
X-Received: by 2002:a05:7022:3c84:b0:1b4:fa58:9d3 with SMTP id a92af1059eb24-1b5030bb43dmr11232487c88.24.1794877981588;
        Mon, 16 Nov 2026 17:13:01 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4182:5788:5c03:2bf9:5b8c:32cd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3815045b90esm1193654eec.13.2026.11.16.17.13.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:13:01 -0800 (PST)
From: Ankit Gupta <ankit6791@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Ankit Gupta <ankit6791@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: limit Write Zeroes to 65536 logical blocks
Date: Mon, 16 Nov 2026 17:10:49 -0800
Message-ID: <20261117011230.10288-1-ankit6791@gmail.com>
X-Mailer: git-send-email 2.50.1
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

With nvme-tcp connected to nvmet-tcp at default settings, the target
reports MDTS 0 and WZSL 0. A 33 MiB Write Zeroes request on a
512-byte-LBA namespace then completes successfully after zeroing only
the first 1 MiB.

The native Write Zeroes command encodes the number of logical blocks
in a zero-based 16-bit field. The namespace queue can advertise a
larger limit, either through the MDTS fallback or through WZSL. In
that case the host truncates the count when building the command and
reports success after zeroing only part of the requested range.

Cap the native Write Zeroes limit at the number of logical blocks the
command can encode. Convert that limit to sectors for each namespace
and retain any smaller controller limit. The DSM deallocation quirk
continues to use its own limit.

Fixes: b94e8cd2e6a9 ("nvme: fix Write Zeroes limitations")
Cc: stable@vger.kernel.org
Signed-off-by: Ankit Gupta <ankit6791@gmail.com>
---
Tested on arm64 at v7.4-rc3 (aebb72744764), over TCP with the stock
nvmet target. Full-range read-back passed for 1, 32, 33, 64, 256 and
1024 MiB with 512-byte LBAs, and 256, 257, 512 and 1024 MiB with
4 KiB LBAs. Host and target traces confirmed the expected command
splitting. A smaller 1 MiB MDTS-derived limit was preserved, and XFS
formatted and mounted successfully.

Claude and Codex assisted with the investigation, patch preparation,
and validation. I also reproduced the 33 MiB failure and checked the
trace by hand on an unpatched kernel.

I will follow up with a blktests regression test for this, as
Christoph suggested.

Changes since v1 (sent to the maintainers off-list):
  - Move the calculation into nvme_max_write_zeroes_sectors() and
    derive the maximum block count from the command's length field.
  - Describe the affected configuration and Cc stable.

 drivers/nvme/host/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4aa02869b79..441d70001920 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2093,6 +2093,16 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
 		lim->dma_alignment = 3;
 }
 
+static sector_t nvme_max_write_zeroes_sectors(struct nvme_ns *ns)
+{
+	const size_t nlb_bytes =
+		sizeof_field(struct nvme_write_zeroes_cmd, length);
+	const u64 max_lbas = BIT_ULL(BYTES_TO_BITS(nlb_bytes));
+
+	return min_t(sector_t, ns->ctrl->max_zeroes_sectors,
+		     nvme_lba_to_sect(ns->head, max_lbas));
+}
+
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		struct nvme_id_ns_nvm *nvm, struct queue_limits *lim)
 {
@@ -2143,7 +2153,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	    (ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
-		lim->max_write_zeroes_sectors = ctrl->max_zeroes_sectors;
+		lim->max_write_zeroes_sectors =
+			nvme_max_write_zeroes_sectors(ns);
 
 	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
 		lim->max_hw_discard_sectors =
