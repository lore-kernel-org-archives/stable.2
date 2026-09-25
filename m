Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30F18E025
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295043; cv=none; b=XoAfC0TLsoBsUdTT2JekdLcwkThDluq3hQSLmv+2j4aSE+8dPG5JgUmWxPgaCh8apGATFfVW5S+++JANA7DPsPznSqcf9UNQIFZiyQ+N5RVZL61iCgfOCo2yJ/PLLKUtg+pLi/iqE6fT7ERAUCyUaBxYwjNyWaUwr5yLD6I/YQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295043; c=relaxed/simple;
	bh=JMCIkzbUrBRh1SrVTJfEacm1MM89Kanq0huw99VeDP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kBMCPRAw8XbDYU6aE0Ws8Y8XPnygkFttohFBeRsaIaRTQaaEeVYCTB8GUnqwODDcq5Ks+BI6oqY5n3DK/LbfVBkdOpn0jqVrgQ8b+ChCwMHX9eBIew8dzgWOAoi3ahdgRNODLe6xaKSXBLJfvxpYtM+frzFOKmG55puVhweEzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gQhC7CaZ; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gQhC7CaZ"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef791so137655eec.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790295039; x=1790899839; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kSKJyljBXbE1CSWk9QdZk9925sD0HXXfMlY1ZmKk2Nc=;
        b=gQhC7CaZyh9Szf+siHenyuK2HP9kH5hLW5Inyemw3bGL7Ha2lSDRAB+0MXKkD5FM4a
         d34XgLse9X1rI13bLlDHMXG01mYq817+z9e6kEpdRtdmAnlzNNT/V8SrPq1H8EqMk2M5
         wgI9E6pnFX8CW3bx5X6lj+e6pS18k8I6tCsB+SmiGfCEBkvR0rIIgjY8zhY8q7I11RiI
         Ds2T2I9iOuSvupHsc+oIRTLJelbiRHI5D4DrSKDbsTkY6gOrkSa62HnOwR3ldlV9kZtl
         Src9lsFtCH5V28fXNp/JHaDHQinja6bEfggKsNLpSmmO/MwhX1XkDthLbL9yFUDJAodi
         /tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790295039; x=1790899839;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kSKJyljBXbE1CSWk9QdZk9925sD0HXXfMlY1ZmKk2Nc=;
        b=mcNWJ0ZzI10FNBI+l3bBEN0gPD5bAnHI2dfsrqIrtnzuJA/Rd8qBgRumBMyxX0Uuts
         rtywpZwdG37o0E2Zmgxh49tPpt3YYud17iIYzWvc6p5EC76z8cnffqa8csk9TraBDeUx
         cOMVKHQ/rJgIdakbhop5CHWPlI5call7mS5tibCQyK9XIjuz4mo1tJ0VUOQHUbog+CHW
         xRC3EX7QmpCM2qkegOmusTwXAx8Wa71F79DXULL/pBtEzQ/Z1jQ1O14PcOe5PxoDsTMV
         ek3otQjUkWKEK3xS7FK3nFZQDVbIQjy8uBbZCb9gIUVe2lqFmmb1YyBceo/cSQirHGwO
         SzaA==
X-Forwarded-Encrypted: i=1; AKwUvBzo/wpcbqzBi32SFbOszfBUCE94XpFu9EGNL4xUTiH/gGxt+kYpeIq7e+aheuTICS13AOZigQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++m6JD7J6gvYXQI3tAMopnFk6SfKolo5wNjdhvggsqy9V2zTownu
	J13QWJ42s3Y2MA49JlyMU/i8QAkp7c8aniUpXvPe41qzR730ZUytklBtqILcewyQxVgUPsL+aqn
	xPS6KCO4=
X-Gm-Gg: AYBFou0kSsgyKMLb5LJrPVtCXJksh0hkiuavwQol1pmmHymqMVRa/xcVU7LSKU6jO/R
	mxt5xzvklvX7IdjY8O78qT3DJdJcRVdIeimOuphmTavdZ8BJM8usgS0jEpHMEG08UxzAgxhz3D1
	H+0JYTSVijLyZSKWWQ/hHXcVMxHvcdnAtQsvjYBmV0ZmG/NBFzeNbaTwcAMFGG9IMnU2JqwoRKu
	BNMQFLL+LGNTFykevVuOQ52JayE1ooRTIpuBkGf+g3aQS2hI5CnSsMIyvNvvRH6cOfDzORCgCs6
	wRa3b2sm+hJ6bTKf1sxRREYnCG5ZKF61ZnJPO3Zlp+MkJn648yP62+b1P/0+hG3xSWYCBTw9Z0G
	hzJTKj/UPWfwfhy3Ts4B1LIzd1+Ct+mKwGW0FHbUEgVkh5tAjuXH+pHAHtFmB2Vyg4lPcD82Znc
	uOcoPKJHawr1fN/kjhTENct37636zYkLn6WIdIbnEZsUxZ33xcRfFdhpA/xnZ6nFaKIqSQsETNs
	g==
X-Received: by 2002:a05:7300:6143:b0:33b:aea6:17be with SMTP id 5a478bee46e88-340062749d3mr4711333eec.24.1790295039239;
        Thu, 24 Sep 2026 17:10:39 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm1787647eec.22.2026.09.24.17.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:10:38 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v7 0/3] i2c: xiic: fix SMBus block read and PEC support
Date: Thu, 24 Sep 2026 17:10:34 -0700
Message-Id: <20260924-i2c-xiic-v7-0-df7e752332ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OwU6EMBAG4FfZ9GxNZ0oL9eR7GA/TMpV6gA0gw
 Wx4d9v1sDV4/JP/+2duYuE58SJeLjcx85aWNI05tE8XEQYaP1imPmeBCq1qsJUJg9xTChKJvVH
 AQSGJXL/OHNN+n3p7/83Ll//ksBZfGkNa1mn+vt/aoPT+md1AKskWVRsdkaH+deR9HabrMyVRd
 jd8SANQScwygNWdCh6Ma05S11JXUhcZvA6xVZ6UPsnmIZ1ylWyyROj6qIFdr/1Jmkpi/a0pMgb
 qgDtQTCdpa1l/a7PUBMZb7dpo/srjOH4A2nvhE9UBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790295038; l=8120;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=JMCIkzbUrBRh1SrVTJfEacm1MM89Kanq0huw99VeDP4=;
 b=SX6bZ7upCb0MTZzh0HdZZ9XsmKl96O6LceLuNybTV02J7dKvrkndOnfxoB8ipQKS7bEVDqMBp
 N0+U5aNksZTDNtQEnxXhcSuPQfATb148ihopQnKu4ZeKkceTZDRBTnm
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

Tested on a Xilinx AXI IIC on an NH-4010, against an ADM1266 reporting a
zero-length block (padded branch) and a Murata D1U74T-W PSU reporting 4
to 21-byte blocks (deferred and chunked branches); both enable PEC.
Unpatched, pmbus_core creates no mfr_* debugfs files for either and every
PEC-enabled block read fails with -EIO; patched, all read back correctly.
The same transfers through i2c-dev with I2C_M_RECV_LEN cover pec_len 0..5
and both sides of rxmsg_len + pec_len == IIC_RX_FIFO_DEPTH. Routing them
through xiic_xfer_atomic exercises patch 1's second trim site in
xiic_recv_atomic; block lengths 0 to 32 read back correctly there too.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v7:
- Patch 1: move the chunk-vs-defer guard widening
  (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) and the pec_len term in the
  normal branch's rfd_set here from patch 2 (Andi). Patch 1 widened the
  padded-branch condition but left the normal branch computing
  rxmsg_len - 2, which the widening newly made reachable with
  rxmsg_len < 2, underflowing the u8; only patch 2 repaired it. Traced
  on hardware with a zero-length block: at pec_len == 2 the v6 patch 1
  programs RFD with 254, this one with 0. With the bounds that protect
  the new arithmetic in the same patch, patch 1 no longer depends on
  patch 2.
- Patch 2: now purely the threshold change, rxmsg_len + pec_len - 2 ->
  - 1, with the rationale for why it stays inside the 4-bit field.
- Patch 3 unchanged. Resulting tree is identical to v6.

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

 drivers/i2c/busses/i2c-xiic.c | 61 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 15 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260427-i2c-xiic-2aeb501ec02a

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

