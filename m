Received: from mail-dl2-f32.google.com (mail-dl2-f32.google.com [74.125.229.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2563955C7
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214343; cv=none; b=J/kLcQWKJVoFy1xu3fm3xSgk52DSyIQqrCv0J5ncTPy/qhMnRj0Tk9l8GR15u5a1F2khEUMKkzdIrnwuwBC11MCv6jFtUjcgDcfAbZ87cYfbTa39RQjGVV7qYM2nhSomkwglz4OEgL/6ep313EE363paX/B/2iPvwaYMqH70wbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214343; c=relaxed/simple;
	bh=yGtXtCYinasdAFxp/SWjOdDVLqrPg7lxhXfn7Zxmgk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bjm8Rs/WJT6A0E5BEKg+3zttGhTDOeZJ53kb++N38N09PPc1pnZqnhI0rBvLNp6xqyDFJs1c5O5Kpm+F344e8yLl4pvIz4uht+rh4SrQBAfx3edZPKHGMosihSJuvp5FuzFcd1MTJJPUTunNaVzYxNpmxUvzYT0SlLLVyHMV1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=le0i6tw2; arc=none smtp.client-ip=74.125.229.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="le0i6tw2"
Received: by mail-dl2-f32.google.com with SMTP id a92af1059eb24-1437b77c274so959496c88.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214341; x=1790819141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z4iKJgi7tP9mJr36Cxt/ObqVMb0Szzyv3xqf2EEz8Ts=;
        b=le0i6tw2PAylyVVgsHWXkyXD+PdiPfP9hDrTsfUzUqXf5tMZmShnjqefocMMenxTU6
         GaY4aSS/W9MMDIGqhTHbT6zpKe3OGQrw1h0aoaX5RaoKkbdez2FYFMSqNI6qLjJRxqUU
         olCdQXy1+ztCYAvzP3td7NeYGZJm4f5bB7favfUVm9dVnrhtMITn8wecEqmA85Mb55pF
         crvI9l5BNBV8t4K3gFC8dQsGLejOMy1zQrV0sbQDkPgPL3uF5fZpfp8a/7bSAx57uKUd
         M6E1bcx3BmciHe7aDvDwXzz9lwY6UBJbK7fiE+j2kfam8pV8tdB15bNe2SkBvwW1jJZl
         TvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214341; x=1790819141;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z4iKJgi7tP9mJr36Cxt/ObqVMb0Szzyv3xqf2EEz8Ts=;
        b=m42pUiwCOz61JcZI8ljFs/LD3H4XWM7gUe7WW3afTBsSnVq6GXKnmePgzQJRjRjk/F
         CwayIW+9H/05GWb06+F0Wtnx4KSsQApzH9EIVYOLP9IMc/SXrQRV1TJbyiWHa5oBM8sq
         lG9S03zIUj7RGmODHX3N9EMCy1H9rqvNxEMrziblR3Kj0GBKQy8vs59Kb6DKBlk5NhiM
         L98tu8ZKjk+V3d5UHIr/P5WcoTKIM08RIWj71jFEL/co/mWjjvczLSWeXVAEGDWZc0QM
         I0hHBHezrgFbajL1X/RzGE6XhCjlPcUZve+GvMJ3hvHHk8RfiD6nlrAqwJogFnHRTjS7
         3gpg==
X-Forwarded-Encrypted: i=1; AKwUvBz2i/tAE4JozdjImuqRNuwwHvFvLbSnSMLdmDCnRO88gSskZdBvCxVTXgIWYGjZUngiidL2u2c=@vger.kernel.org
X-Gm-Message-State: AFuF++mngp2Uq9Yvy8UVidue5EwUeEo1SEi939WbIjYjK1mvjq2RiXkB
	QOn2goXAy5K57Yt6tDfMs0XQrOIYwqKgR+e/T8+QJlKt1mZ3jeBwZMRbj4T3lXbk6VAU+hC2Upz
	6WiRmCHg=
X-Gm-Gg: AYBFou27WtSaIztSUhbzzbNeB2Ah1/eLCdnMIfx2Ro+3LPTQ9SMugeSxWkAehVfsCsj
	msjdIDzCKP0rYbsSzSNWy7IMKsaL+WhfUcfQIIhco828BWi2hnoffdx1xt0j0GdCEhKlYUoaLUT
	lHhpgn9t1gl7ifay5SeKn5vb6OjF/LE4vXyHgA6MyH77LEr4T9Lpm4usOE88DDiM/hWSFel0p6C
	zBGEtc69VbjRpXARQMZvzIbQKL4SA6nMBPYY8LYLktBy6Tn1QT88hbYC9LypSqH2FQ8foEMQNCz
	aFa/K0zXaMBFaHqJl6p28AMkN+RaH6W+2+iuPzR6KkjNRH9f4jvmJql4H5tx5VPR12fwykXbdQz
	Z/2joozckZ8WZQ1Hf9NY6P5DWQlbbmLjnvQXW0R7n/a3c37Psm061fsBiUiQXgGUCykHHLU+giH
	US+h2sRtni1qla+vZUjnpKjz9+3LwVIf3UMRoieCzmCk/+g8YFJnZ5LGBal3D45jZnspG/p/4fY
	A==
X-Received: by 2002:a05:7022:108d:b0:143:7cca:e14 with SMTP id a92af1059eb24-14503f6a36emr566935c88.12.1790214340945;
        Wed, 23 Sep 2026 18:45:40 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm2927598c88.8.2026.09.23.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:45:40 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v6 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Wed, 23 Sep 2026 18:45:35 -0700
Message-Id: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OwU6EMBAG4FfZ9GzNzJQC9eR7GA9tmUo9wIYiw
 Wx4d9v1sDV4/JP/+2duIvESOYmXy00svMUU5ymH9uki/GinD5ZxyFkQUAsNdTKSl3uMXpJlpwH
 ZA1mR69eFQ9zvU2/vvzl9uU/2a/GlMca0zsv3/daGpffP7IYSJLcEXTDWaju8Tryv43x9tlGU3
 Y0eUiNWkrL02KoevENtmpNUtVSVVEV6p3zowFlQJ9k8pAFTySZLwn4ICtkMyp2kriTV3+oig7c
 9co/A9o88juMH8mUNRJsBAAA=
X-Change-ID: 20260427-i2c-xiic-2aeb501ec02a
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790214340; l=6768;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=yGtXtCYinasdAFxp/SWjOdDVLqrPg7lxhXfn7Zxmgk0=;
 b=ZntK8vvb8eZuSwnNMfSKNtHX/ynXJZAvqc+vDq3/jm2ZMZ2T2ad0sF32ghHGbKBO7HAUUEWMl
 M3s8wyovRaeA7HFb1Y813Jz3PYqEoLe4fiYSLS7H24rR2OfH0c83mvk
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

This series fixes three independent bugs in the Xilinx AXI IIC driver
that together make SMBus block reads with PEC return -EBADMSG or -EIO
on otherwise clean transfers. They only surface when the client has
I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
turn.

The problems were uncovered driving an adm1266 PMBus device behind a
Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.

Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
The i2c core appends a byte to msg->len when PEC is enabled, so
overwriting the length to "block size + 1" silently drops the PEC byte
and i2c_smbus_check_pec() then reads the last payload byte as the PEC.

Patch 2 raises the RX_FULL threshold so the interrupt only fires once
every remaining byte (payload plus optional PEC) is already buffered in
the FIFO. The previous threshold of rxmsg_len - 2 caused the
bytes_rem == 1 path in xiic_read_rx() to NACK a byte still on the wire.
The chunk-vs-defer guard now also accounts for the PEC byte so a
rxmsg_len == IIC_RX_FIFO_DEPTH PEC-enabled read does not push
XIIC_RFD_REG_OFFSET past its 4-bit range.

Patch 3 stops the BNB handler from forcing tx_msg->len = 1 to signal
completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
so this also clobbered rx_msg->len; and because tx_pos is already at 2
in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
up to msg->len drives tx_space to zero without touching the length.

All three patches are pure bug fixes; non-PEC behaviour is unchanged.
Tested on real hardware -- a Xilinx AXI IIC controller talking to an
adm1266, where 64-byte PEC-checked block reads now complete cleanly.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v6:
- Patch 1: also trim rx_msg->len in xiic_recv_atomic() (Andi). An
  I2C_M_RECV_LEN message forces standard mode for the whole transfer,
  so an atomic SMBus block read reaches the same padded branch but
  completed without the trim. The trim moved into a small helper,
  xiic_smbus_trim_len(), now called from both sites that clear rx_msg.
- Patches 2 and 3 unchanged.
- Link to v5: https://patch.msgid.link/20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai

Changes in v5:
- Patch 1: clear smbus_actual_len in xiic_start_recv() so the trim state
  is reset before every receive (Andi). Only the padded branch sets it,
  and a block read aborted by arbitration loss or a TX error returns
  through the error path without reaching the completion site, so a
  stale value could trim the length of an unrelated later read.
- Patch 3: drop the defensive smbus_actual_len reset in the BNB handler,
  now redundant with the reset in patch 1, and the paragraph describing
  it. No other change.
- Patch 2 unchanged.
- All three patches now carry a Fixes: tag and Cc: stable. All three
  bugs were introduced together by e4c1ff772e1a ("i2c: xiic: Add
  smbus_block_read functionality"), first released in v6.3, and a PEC
  block read needs all three to complete, so they should be backported
  as a set.
- Shubhrajyoti Datta's Reviewed-by from v1 is still not carried over.
  Shubhrajyoti, if the current code looks good to you, a fresh tag would
  be appreciated.
- Link to v4: https://patch.msgid.link/20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai

Changes in v4:
- No code changes; resend of v3 to collect Michal Simek's Acked-by
  (given on the v3 cover letter) into each patch.
- Shubhrajyoti Datta's Reviewed-by from v1 is not carried over since all
  three patches have changed since then. Shubhrajyoti, if the current
  code still looks good to you, a fresh tag would be appreciated.
- Link to v3: https://patch.msgid.link/20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai

Changes in v3 (addresses the sashiko automated review of v2):
- Patch 1: handle short SMBus block reads where the controller pads
  rx_msg->len up to SMBUS_BLOCK_READ_MIN_LEN for its end-of-message
  workaround. In v2 this branch left the PEC byte at the padded
  offset rather than the actual end-of-payload, so the i2c core's
  PEC validator read past the chip data. Track the on-wire length
  in a new smbus_actual_len field populated in the minlen branch
  of xiic_smbus_block_read_setup(), and trim rx_msg->len back at
  RX_FULL completion before passing the message up. Addresses
  sashiko's v2 note about the pec_len adjustment missing the
  rxmsg_len < 3 padding branch; that branch was indeed the cause
  of pmbus_check_block_register() silently failing on zero-length
  MFR_* fields and skipping debugfs auto-discovery on affected
  hardware.
- Patch 3: defensively reset smbus_actual_len in the BNB completion
  handler so a subsequent non-SMBus transfer cannot see a stale
  trim value from a completed short block read.
- Patch 2 is unchanged from v2. sashiko's two other v2 notes were
  investigated and judged not to require code changes: the concern
  about removed padding in the chunked-vs-deferred drain misread
  the patch (the padding survives via the else branch and the new
  PEC-aware guard preserves the original semantics), and the
  flagged unsigned underflow in xiic_tx_space() is unreachable
  because tx_pos is bounded by tx_msg->len at the call site.
- Link to v2: https://patch.msgid.link/20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai

Changes in v2:
- Patch 2: widen the chunk-vs-defer guard in xiic_smbus_block_read_setup()
  to include pec_len, so a 16-byte PEC-enabled block read routes through
  the chunked drain rather than writing 16 into the 4-bit
  XIIC_RFD_REG_OFFSET register. No tree-level change to patches 1 or 3.
- Link to v1: https://patch.msgid.link/20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To: Wolfram Sang <wsa@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Abdurrahman Hussain (3):
      i2c: xiic: preserve PEC byte length in SMBus block read setup
      i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
      i2c: xiic: don't clobber msg->len to signal block-read completion

 drivers/i2c/busses/i2c-xiic.c | 60 +++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 17 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

